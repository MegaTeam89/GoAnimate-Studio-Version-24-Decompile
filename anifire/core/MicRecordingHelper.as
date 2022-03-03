package anifire.core
{
   import anifire.events.MicLevelEvent;
   import com.adobe.audio.format.WAVWriter;
   import com.jac.ogg.OggComments;
   import com.jac.ogg.OggEncoder;
   import com.jac.ogg.events.OggEncoderEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.events.TimerEvent;
   import flash.media.Microphone;
   import flash.media.Sound;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.Timer;
   import mx.events.PropertyChangeEvent;
   
   public class MicRecordingHelper extends EventDispatcher
   {
      
      private static var _instance:MicRecordingHelper;
      
      public static const BYTES_PER_CALLBACK:uint = 4096;
       
      
      public var isRecording:Boolean = false;
      
      private var _microphone:Microphone;
      
      private var _recordByte:ByteArray;
      
      private var _timer:Timer;
      
      private var _pitchShiftFactor:Number = 0;
      
      private var _soundChart:Array;
      
      private var _soundByte:ByteArray;
      
      private var CHANNEL_LENGTH:uint = 256;
      
      private var _oggEncoder:OggEncoder;
      
      private var _oggBytes:ByteArray;
      
      private var _phase:Number;
      
      private var _1293667902currentPosition:uint;
      
      private var _930295060playbackSpeed:Number = 1;
      
      private var _1381423772bytesSpeed:uint;
      
      public function MicRecordingHelper()
      {
         this._timer = new Timer(1000,20);
         this._soundChart = new Array();
         this._oggEncoder = OggEncoder.getInstance();
         this._oggBytes = new ByteArray();
         this._1381423772bytesSpeed = this.playbackSpeed * BYTES_PER_CALLBACK;
         super();
         this._soundByte = new ByteArray();
         this._microphone = Microphone.getMicrophone();
         if(this._microphone)
         {
            this._timer.addEventListener(TimerEvent.TIMER,function(param1:TimerEvent):void
            {
               dispatchEvent(param1);
            });
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(param1:TimerEvent):void
            {
               dispatchEvent(param1);
            });
            this._microphone.rate = 44;
            this._microphone.setLoopBack(false);
         }
      }
      
      public static function getInstance() : MicRecordingHelper
      {
         if(!_instance)
         {
            _instance = new MicRecordingHelper();
         }
         return _instance;
      }
      
      public function get recordByte() : ByteArray
      {
         return this._recordByte;
      }
      
      public function set recordByte(param1:ByteArray) : void
      {
         this._recordByte = param1;
      }
      
      public function get pitchShiftFactor() : Number
      {
         return this._pitchShiftFactor;
      }
      
      public function set pitchShiftFactor(param1:Number) : void
      {
         this._pitchShiftFactor = param1;
      }
      
      public function get timer() : Timer
      {
         return this._timer;
      }
      
      private function handleEncodeProgress(param1:OggEncoderEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function handleEncodeComplete(param1:OggEncoderEvent) : void
      {
         this._oggBytes = ByteArray(param1.data);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function microphone() : Microphone
      {
         return this._microphone;
      }
      
      public function endRecording() : void
      {
         if(!this._microphone)
         {
         }
      }
      
      public function playRecordHandler() : void
      {
         var _loc1_:Sound = null;
         if(this._recordByte)
         {
            this._recordByte.position = 0;
            _loc1_ = new Sound();
            _loc1_.addEventListener(SampleDataEvent.SAMPLE_DATA,this._playSoundSampleDataHandler);
            _loc1_.play();
         }
      }
      
      private function _playSoundSampleDataHandler(param1:SampleDataEvent) : void
      {
         var _loc3_:Number = NaN;
         if(!this._recordByte.bytesAvailable > 0)
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         while(_loc2_ < 8192)
         {
            _loc3_ = 0;
            if(this._recordByte.bytesAvailable > 0)
            {
               _loc3_ = this._recordByte.readFloat();
            }
            _loc4_.writeFloat(_loc3_);
            _loc4_.writeFloat(_loc3_);
            _loc2_++;
         }
         _loc4_ = this.shiftBytes(_loc4_);
         var _loc5_:int = 0;
         _loc4_.position = 0;
         while(_loc5_ < _loc4_.bytesAvailable)
         {
            param1.data.writeFloat(_loc4_.readFloat());
            _loc5_++;
         }
      }
      
      public function startRecHandler() : void
      {
         this.isRecording = true;
         this._recordByte = new ByteArray();
         this._microphone.addEventListener(SampleDataEvent.SAMPLE_DATA,this._microphoneSampleDataHandler);
         this._timer.reset();
         this._timer.start();
      }
      
      public function stopRecordHandler(param1:Event = null) : void
      {
         if(this.isRecording)
         {
            this._timer.stop();
            this.isRecording = false;
            this._microphone.removeEventListener(SampleDataEvent.SAMPLE_DATA,this._microphoneSampleDataHandler);
         }
      }
      
      private function _microphoneSampleDataHandler(param1:SampleDataEvent) : void
      {
         this._recordByte.writeBytes(param1.data);
         this.dispatchMicSampleEvent(this._microphone.activityLevel);
      }
      
      public function getWaveByteArray() : ByteArray
      {
         var _loc1_:WAVWriter = null;
         var _loc2_:ByteArray = null;
         if(this._recordByte != null && this._recordByte.length > 0)
         {
            _loc1_ = new WAVWriter();
            _loc1_.numOfChannels = 1;
            this._recordByte = this.shiftBytes(this._recordByte);
            this._recordByte.position = 0;
            _loc2_ = new ByteArray();
            _loc1_.processSamples(_loc2_,this._recordByte,_loc1_.samplingRate,1);
            return _loc2_;
         }
         return null;
      }
      
      public function getShiftedWaveByteArray(param1:ByteArray) : ByteArray
      {
         var _loc2_:ByteArray = null;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = new ByteArray();
            return this.encode(param1);
         }
         return null;
      }
      
      public function encode(param1:ByteArray) : ByteArray
      {
         var _loc2_:uint = 1;
         var _loc3_:uint = 16;
         var _loc4_:uint = 44100;
         var _loc5_:ByteArray;
         (_loc5_ = new ByteArray()).endian = Endian.LITTLE_ENDIAN;
         _loc5_.writeUTFBytes("RIFF");
         _loc5_.writeInt(uint(param1.length + 44));
         _loc5_.writeUTFBytes("WAVE");
         _loc5_.writeUTFBytes("fmt ");
         _loc5_.writeInt(uint(16));
         _loc5_.writeShort(uint(1));
         _loc5_.writeShort(_loc2_);
         _loc5_.writeInt(_loc4_);
         _loc5_.writeInt(uint(_loc4_ * _loc2_ * (_loc3_ / 8)));
         _loc5_.writeShort(uint(_loc2_ * (_loc3_ / 8)));
         _loc5_.writeShort(_loc3_);
         _loc5_.writeUTFBytes("data");
         _loc5_.writeInt(param1.length);
         _loc5_.writeBytes(param1);
         _loc5_.position = 0;
         return _loc5_;
      }
      
      private function resamplingWave(param1:ByteArray) : ByteArray
      {
         var _loc3_:Number = NaN;
         var _loc2_:ByteArray = new ByteArray();
         param1.position = 0;
         while(param1.bytesAvailable)
         {
            _loc3_ = param1.readFloat();
            _loc2_.writeFloat(_loc3_);
         }
         return _loc2_;
      }
      
      public function encodeOGG() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:WAVWriter = new WAVWriter();
         this._recordByte = this.shiftBytes(this._recordByte);
         _loc1_.position = 0;
         _loc1_.endian = Endian.LITTLE_ENDIAN;
         this._recordByte.position = 0;
         _loc2_.processSamples(_loc1_,this._recordByte,_loc2_.samplingRate,1);
         var _loc3_:OggComments = new OggComments();
         this._oggEncoder.encode(_loc1_,_loc3_);
         this._oggEncoder.addEventListener(OggEncoderEvent.ENCODE_COMPLETE,this.handleEncodeComplete,false,0,true);
         this._oggEncoder.addEventListener(OggEncoderEvent.ENCODE_PROGRESS,this.handleEncodeProgress,false,0,true);
      }
      
      public function saveOGG() : ByteArray
      {
         return this._oggBytes;
      }
      
      private function dispatchMicSampleEvent(param1:Number) : void
      {
         var _loc2_:MicLevelEvent = new MicLevelEvent(MicLevelEvent.ACTIVITY_LEVEL,this);
         _loc2_.level = param1;
         dispatchEvent(_loc2_);
      }
      
      private function shiftBytes(param1:ByteArray) : ByteArray
      {
         var _loc3_:Number = NaN;
         this.pitchShiftFactor = Math.floor(this.pitchShiftFactor);
         var _loc2_:Number = 0;
         if(this.pitchShiftFactor < 0)
         {
            _loc3_ = -8;
         }
         else
         {
            _loc3_ = 8;
         }
         var _loc4_:Number;
         if((_loc4_ = this.pitchShiftFactor + 10) > 10)
         {
            _loc4_ = 20 - _loc4_;
         }
         var _loc5_:ByteArray = new ByteArray();
         param1.position = 0;
         if(this.pitchShiftFactor > 0 && _loc4_ <= 8)
         {
            _loc4_--;
         }
         if(this.pitchShiftFactor > 0 && _loc4_ <= 5)
         {
            _loc4_--;
         }
         while(param1.bytesAvailable > 0)
         {
            if(_loc4_ == 10)
            {
               _loc5_.writeFloat(param1.readFloat());
               _loc5_.writeFloat(param1.readFloat());
            }
            else
            {
               _loc2_++;
               if(_loc2_ <= _loc4_)
               {
                  _loc5_.writeFloat(param1.readFloat());
                  _loc5_.writeFloat(param1.readFloat());
               }
               else
               {
                  param1.position += _loc3_;
                  if(_loc3_ < 0)
                  {
                     _loc5_.writeFloat(param1.readFloat());
                     _loc5_.writeFloat(param1.readFloat());
                  }
                  _loc2_ -= _loc4_;
               }
            }
         }
         return _loc5_;
      }
      
      [Bindable(event="propertyChange")]
      private function get currentPosition() : uint
      {
         return this._1293667902currentPosition;
      }
      
      private function set currentPosition(param1:uint) : void
      {
         var _loc2_:Object = this._1293667902currentPosition;
         if(_loc2_ !== param1)
         {
            this._1293667902currentPosition = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentPosition",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get playbackSpeed() : Number
      {
         return this._930295060playbackSpeed;
      }
      
      private function set playbackSpeed(param1:Number) : void
      {
         var _loc2_:Object = this._930295060playbackSpeed;
         if(_loc2_ !== param1)
         {
            this._930295060playbackSpeed = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playbackSpeed",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get bytesSpeed() : uint
      {
         return this._1381423772bytesSpeed;
      }
      
      private function set bytesSpeed(param1:uint) : void
      {
         var _loc2_:Object = this._1381423772bytesSpeed;
         if(_loc2_ !== param1)
         {
            this._1381423772bytesSpeed = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bytesSpeed",_loc2_,param1));
            }
         }
      }
   }
}
