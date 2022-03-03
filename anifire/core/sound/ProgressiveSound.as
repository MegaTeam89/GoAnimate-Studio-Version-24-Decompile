package anifire.core.sound
{
   import anifire.constant.ServerConstants;
   import anifire.sound.TTSManager;
   import anifire.timeline.SoundContainer;
   import anifire.util.UtilNetwork;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
   public class ProgressiveSound extends EventDispatcher implements ISoundable
   {
       
      
      private var _urlRequest:URLRequest;
      
      private var _soundChannel:SoundChannel;
      
      private var _soundTransform:SoundTransform;
      
      private var _duration:Number;
      
      private var _sound:Sound;
      
      private var _soundContainer:SoundContainer;
      
      private var _subType:String;
      
      public function ProgressiveSound(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function init(param1:URLRequest, param2:Number, param3:String = null) : void
      {
         this._urlRequest = param1;
         this._duration = param2;
         if(param3)
         {
            this._subType = param3;
         }
         this.dispatchEvent(new SoundEvent(SoundEvent.READY_TO_PLAY,this));
      }
      
      private function onInitProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Sound = param1.target as Sound;
         if(_loc2_.bytesLoaded >= _loc2_.bytesTotal)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitProgress);
            this.dispatchEvent(new SoundEvent(SoundEvent.READY_TO_PLAY,this));
         }
         else if(_loc2_.bytesLoaded >= 15 * 1024)
         {
            _loc2_.close();
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitProgress);
            this.dispatchEvent(new SoundEvent(SoundEvent.READY_TO_PLAY,this));
         }
      }
      
      public function clone() : ISoundable
      {
         var _loc1_:ProgressiveSound = new ProgressiveSound();
         _loc1_._urlRequest = this._urlRequest;
         _loc1_._duration = this._duration;
         return _loc1_;
      }
      
      public function loadSound() : void
      {
         if(!this._sound)
         {
            this._sound = new Sound();
            this._sound.addEventListener(Event.COMPLETE,this.onLoadSoundComplete);
            this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadSoundFail);
            this._sound.load(this._urlRequest);
         }
         else if(this._sound.bytesLoaded > 0 && this._sound.bytesLoaded == this._sound.bytesTotal)
         {
            this.dispatchEvent(new SoundEvent(SoundEvent.SOUND_LOADED,this));
         }
      }
      
      public function play(param1:Number = 0, param2:SoundContainer = null, param3:Number = 1) : void
      {
         this._soundContainer = param2;
         if(!this._sound)
         {
            this._sound = new Sound();
            this._sound.addEventListener(Event.COMPLETE,this.onLoadSoundComplete);
            this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadSoundFail);
            this._sound.load(this._urlRequest);
         }
         if(!this._soundTransform)
         {
            this._soundTransform = new SoundTransform();
         }
         this._soundTransform.volume = param3;
         this._soundChannel = this._sound.play(param1,0,this._soundTransform);
         if(this._soundChannel)
         {
            this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onSoundPlaybackComplete);
         }
         if(param1 < this._duration)
         {
            this.startIndicator(param1);
         }
         this.dispatchEvent(new SoundEvent(SoundEvent.PLAYED,this));
      }
      
      private function onLoadSoundFail(param1:IOErrorEvent) : void
      {
         var _loc2_:String = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadSoundFail);
         if(this._subType)
         {
            if(anifire.sound.TTSManager.isSoundRebuildable(this._subType))
            {
               _loc2_ = this._urlRequest.data[ServerConstants.PARAM_ASSET_ID];
               this._urlRequest = UtilNetwork.getRebuildTTSRequest(_loc2_);
               this._sound = new Sound();
               this._sound.addEventListener(Event.COMPLETE,this.onLoadSoundComplete);
               this._sound.load(this._urlRequest);
               this._soundChannel = this._sound.play(0,0,this._soundTransform);
               if(this._soundChannel)
               {
                  this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onSoundPlaybackComplete);
               }
            }
         }
      }
      
      private function onLoadSoundComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadSoundComplete);
         this.dispatchEvent(new SoundEvent(SoundEvent.SOUND_LOADED,this));
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      public function stop() : void
      {
         if(this._soundChannel)
         {
            this._soundChannel.stop();
            this.stopIndicator();
            this.reset();
            this.dispatchEvent(new SoundEvent(SoundEvent.STOPPED,this));
         }
      }
      
      private function reset() : void
      {
         this._soundTransform = null;
         if(this._soundChannel)
         {
            this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.onSoundPlaybackComplete);
            this._soundChannel = null;
         }
         if(this._sound)
         {
            this._sound.removeEventListener(Event.COMPLETE,this.onLoadSoundComplete);
            this._sound.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadSoundFail);
            if(this._sound.bytesLoaded < this._sound.bytesTotal)
            {
               this._sound.close();
            }
            this._sound = null;
         }
      }
      
      public function getDuration() : Number
      {
         return this._duration;
      }
      
      public function get isReady() : Boolean
      {
         return true;
      }
      
      private function onSoundPlaybackComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundPlaybackComplete);
         this.stopIndicator();
         this.reset();
         this.dispatchEvent(new SoundEvent(SoundEvent.PLAY_COMPLETE,this));
         this.dispatchEvent(new SoundEvent(SoundEvent.STOPPED,this));
      }
      
      private function startIndicator(param1:Number = 0) : void
      {
         if(this._soundContainer)
         {
            this._soundContainer.startIndicator(param1,this._soundChannel);
         }
      }
      
      private function stopIndicator() : void
      {
         if(this._soundContainer)
         {
            this._soundContainer.stopIndicator();
         }
      }
   }
}
