package anifire.playback
{
   import anifire.constant.AnimeConstants;
   import anifire.core.AssetLinkage;
   import anifire.event.AVM2SoundEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.interfaces.ISoundAsset;
   import anifire.sound.SoundFactory;
   import anifire.sound.SoundHelper;
   import anifire.sound.TTSManager;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundLoaderContext;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class ProgressiveSound extends AnimeSound implements ISoundAsset
   {
      
      private static var STATE_NULL:int = 0;
      
      private static var STATE_PLAYING:int = 1;
      
      private static var STATE_PAUSED:int = 2;
       
      
      private var _state:int;
      
      private var _sound:Sound;
      
      private var _soundChannel:SoundChannel;
      
      private var _currentPlayingMilliSecond:Number;
      
      private var _soundTransform:SoundTransform;
      
      private var _isSoundCompletelyDownload:Boolean;
      
      private var _skipSpeechDispatch:Boolean = false;
      
      private var _numTry:Number = 0;
      
      private var _urlRequest:URLRequest;
      
      private var _soundCompletedOnce:Boolean = false;
      
      public function ProgressiveSound()
      {
         super();
      }
      
      private function get isSoundCompletelyDownload() : Boolean
      {
         return this._isSoundCompletelyDownload;
      }
      
      private function set isSoundCompletelyDownload(param1:Boolean) : void
      {
         this._isSoundCompletelyDownload = param1;
      }
      
      private function get state() : Number
      {
         return this._state;
      }
      
      private function set state(param1:Number) : void
      {
         this._state = param1;
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      public function set sound(param1:Sound) : void
      {
         if(param1 && param1 != this._sound)
         {
            if(this._sound != null)
            {
               this._sound.removeEventListener(Event.COMPLETE,this.onSoundCompletelyDownloaded);
               this._sound.removeEventListener(ProgressEvent.PROGRESS,this.onSoundDownloading);
               this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onSoundLoadFailed);
            }
            this._sound = param1;
            this._sound.addEventListener(Event.COMPLETE,this.onSoundCompletelyDownloaded);
            this._sound.addEventListener(ProgressEvent.PROGRESS,this.onSoundDownloading);
            this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onSoundLoadFailed);
            this._isSoundCompletelyDownload = false;
         }
      }
      
      public function load() : void
      {
         var _loc1_:SoundLoaderContext = null;
         if(this._sound && this._urlRequest)
         {
            _loc1_ = new SoundLoaderContext();
            _loc1_.bufferTime = 0;
            this._sound.load(this._urlRequest,_loc1_);
         }
      }
      
      public function close() : void
      {
         try
         {
            if(this._sound)
            {
               this._sound.close();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onSoundLoadFailed(param1:IOErrorEvent) : void
      {
         var _loc2_:String = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundLoadFailed);
         if(TTSManager.isSoundRebuildable(subtype) && this._numTry < 1)
         {
            _loc2_ = UtilXmlInfo.getThumbIdFromFileName(this.file);
            this._urlRequest = UtilNetwork.getRebuildTTSRequest(_loc2_);
            this.sound = SoundFactory.createSound();
            this.load();
            ++this._numTry;
         }
         else if(this._numTry < 3)
         {
            this.sound = SoundFactory.createSound();
            this.load();
            ++this._numTry;
         }
         else
         {
            this.isSoundCompletelyDownload = true;
            dispatchEvent(param1);
         }
      }
      
      private function onSoundDownloading(param1:ProgressEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function processSound(param1:Event) : void
      {
      }
      
      private function get soundChannel() : SoundChannel
      {
         return this._soundChannel;
      }
      
      private function set soundChannel(param1:SoundChannel) : void
      {
         this._soundChannel = param1;
      }
      
      private function get soundTransform() : SoundTransform
      {
         return this._soundTransform;
      }
      
      private function set soundTransform(param1:SoundTransform) : void
      {
         this._soundTransform = param1;
      }
      
      override public function init(param1:XML, param2:UtilHashArray, param3:String, param4:PlayerDataStock) : Boolean
      {
         if(!super.init(param1,param2,param3,param4))
         {
            return false;
         }
         this.state = STATE_NULL;
         return true;
      }
      
      override public function initDependency(param1:Number, param2:Number, param3:DownloadManager) : void
      {
         super.initDependency(param1,param2,param3);
         var _loc4_:String = UtilXmlInfo.getThemeIdFromFileName(this.file);
         var _loc5_:String = UtilXmlInfo.getThumbIdFromFileName(this.file);
         this._urlRequest = UtilNetwork.getGetSoundAssetRequest(_loc4_,_loc5_,AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE);
         this.sound = SoundFactory.createSound();
         param3.registerSoundChannel(this._urlRequest,this.startMilliSec,this.endMilliSec,this);
         this.soundTransform = new SoundTransform(this.volume * this.fadeFactor * this.inner_volume);
         this.fadeVolumeBySubtype(this.startMilliSec);
      }
      
      private function onSoundCompletelyDownloaded(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundCompletelyDownloaded);
         this.isSoundCompletelyDownload = true;
         dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,1,1));
         dispatchEvent(param1);
      }
      
      private function onBufferExhaust(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onBufferExhaust);
         this.dispatchBufferExhaustEvent(this.soundChannel.position);
      }
      
      private function dispatchBufferExhaustEvent(param1:Number) : void
      {
         this._currentPlayingMilliSecond = param1;
         this.dispatchEvent(new AVM2SoundEvent(PlayerEvent.BUFFER_EXHAUST,this));
      }
      
      override public function getBufferProgress() : Number
      {
         return 100;
      }
      
      override public function setVolume(param1:Number) : void
      {
         this.volume = param1;
         this.soundTransform.volume = this.fadeFactor * this.volume * this.inner_volume;
         if(this.soundChannel !== null)
         {
            this.soundChannel.soundTransform = this.soundTransform;
         }
      }
      
      override public function fadeVolume(param1:Number) : void
      {
         this.fadeFactor = param1;
         this.soundTransform.volume = this.fadeFactor * this.volume * this.inner_volume;
         if(this.soundChannel !== null)
         {
            this.soundChannel.soundTransform = this.soundTransform;
         }
      }
      
      private function doSoundComplete(param1:Event) : void
      {
         this._soundCompletedOnce = true;
      }
      
      override public function play(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:SpeechPitchEvent = null;
         var _loc6_:ByteArray = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         try
         {
            _loc2_ = !!speechData ? 0 : int(int.MAX_VALUE);
            _loc3_ = false;
            if(this._state != STATE_PLAYING)
            {
               if(SoundHelper.isSoundBufferReadyAtTime(this.sound,param1 - this.startMilliSec,this.isSoundCompletelyDownload))
               {
                  this._soundCompletedOnce = false;
                  if(_loc2_)
                  {
                     _loc4_ = (param1 - this.startMilliSec) % this.sound.length;
                  }
                  else
                  {
                     _loc4_ = param1 - this.startMilliSec;
                  }
                  this.soundChannel = this.sound.play(_loc4_,_loc2_,this.soundTransform);
                  this.soundChannel.addEventListener(Event.SOUND_COMPLETE,this.doSoundComplete);
                  if(!this.isSoundCompletelyDownload)
                  {
                     SoundHelper.addBufferExhaustEventListenerToSoundChannel(this.soundChannel,this.sound,this.startMilliSec,this.endMilliSec,this.onBufferExhaust);
                  }
                  _loc3_ = true;
                  this.state = STATE_PLAYING;
               }
               else
               {
                  this._currentPlayingMilliSecond = param1;
                  this.dispatchBufferExhaustEvent(param1);
               }
            }
            else
            {
               this.fadeVolumeBySubtype(param1);
            }
            if(speechData)
            {
               if(!this._soundCompletedOnce)
               {
                  _loc6_ = new ByteArray();
                  _loc7_ = Math.floor(1 / AnimeConstants.FRAME_PER_SEC * 44100);
                  _loc8_ = this.sound.extract(_loc6_,_loc7_);
                  _loc6_.position = 0;
                  _loc9_ = 64;
                  _loc12_ = 0;
                  try
                  {
                     _loc13_ = 0;
                     while(_loc13_ < 56)
                     {
                        _loc10_ = _loc6_.readFloat() * 128;
                        _loc11_ = _loc6_.readFloat() * 128;
                        _loc10_ = Math.abs(_loc10_);
                        _loc11_ = Math.abs(_loc11_);
                        _loc12_ += _loc10_ + _loc11_;
                        _loc6_.position = _loc13_ * _loc9_;
                        _loc13_++;
                     }
                  }
                  catch(e:Error)
                  {
                  }
                  if(!this._skipSpeechDispatch)
                  {
                     (_loc5_ = new SpeechPitchEvent(SpeechPitchEvent.PITCH)).sceneId = AssetLinkage.getSceneIdFromLinkage(speechData);
                     _loc5_.charId = AssetLinkage.getCharIdFromLinkage(speechData);
                     _loc5_.soundId = this.id;
                     _loc5_.value = _loc12_;
                     this.dispatchEvent(_loc5_);
                  }
                  this._skipSpeechDispatch = !this._skipSpeechDispatch;
                  if(_loc6_.bytesAvailable == 0 || _loc3_)
                  {
                     this.sound.extract(_loc6_,1,0);
                  }
               }
               else
               {
                  (_loc5_ = new SpeechPitchEvent(SpeechPitchEvent.PITCH)).sceneId = AssetLinkage.getSceneIdFromLinkage(speechData);
                  _loc5_.charId = AssetLinkage.getCharIdFromLinkage(speechData);
                  _loc5_.soundId = this.id;
                  _loc5_.value = 0;
                  this.dispatchEvent(_loc5_);
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function goToAndPause(param1:Number) : void
      {
         try
         {
            this._currentPlayingMilliSecond = param1;
            if(this.soundChannel != null)
            {
               this.soundChannel.removeEventListener(AVM2SoundEvent.BUFFER_EXHAUST,this.onBufferExhaust);
               this.soundChannel.stop();
               this.soundChannel = null;
            }
            this.state = STATE_PAUSED;
         }
         catch(e:Error)
         {
         }
      }
      
      override public function resume() : void
      {
         this.play(this._currentPlayingMilliSecond);
      }
      
      override public function pause(param1:Number) : void
      {
         try
         {
            if(this.soundChannel != null)
            {
               this._currentPlayingMilliSecond = this.soundChannel.position + this.startMilliSec;
               this.soundChannel.removeEventListener(AVM2SoundEvent.BUFFER_EXHAUST,this.onBufferExhaust);
               this.soundChannel.stop();
               this.soundChannel = null;
            }
            this.state = STATE_PAUSED;
         }
         catch(e:Error)
         {
         }
      }
   }
}
