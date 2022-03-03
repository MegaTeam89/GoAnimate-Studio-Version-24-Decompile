package anifire.core.sound
{
   import anifire.core.Console;
   import anifire.core.SoundThumb;
   import anifire.event.CoreEvent;
   import anifire.timeline.SoundContainer;
   import anifire.util.Util;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class SoundPlaybackManager extends EventDispatcher
   {
      
      private static var _currentSound:ISoundable;
      
      private static var _playbackSoundThumb:SoundThumb;
      
      private static var _playbackStartTime:Number = 0;
      
      private static var _playbackVol:Number = 1;
      
      private static var _playbackSoundContainer:SoundContainer;
       
      
      public function SoundPlaybackManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function play(param1:ISoundable, param2:Number = 0, param3:SoundContainer = null, param4:Number = 1) : void
      {
         try
         {
            if(param1)
            {
               if(_currentSound)
               {
                  _currentSound.stop();
               }
               _currentSound = param1;
               param1.play(param2,param3,param4);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function stop() : void
      {
         try
         {
            if(_currentSound)
            {
               _currentSound.stop();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private static function onSoundLoaded(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,onSoundLoaded);
         SoundPlaybackManager.playSoundThumb(_playbackSoundThumb,_playbackStartTime,_playbackSoundContainer,_playbackVol);
      }
      
      public static function playSoundThumb(param1:SoundThumb, param2:Number = 0, param3:SoundContainer = null, param4:Number = 1) : void
      {
         if(param1)
         {
            _playbackSoundThumb = param1;
            _playbackStartTime = param2;
            _playbackVol = param4;
            _playbackSoundContainer = param3;
            if(param1.sound && param1.sound.isReady)
            {
               SoundPlaybackManager.play(param1.sound,param2,param3,param4);
               Util.gaTracking("/gostudio/playSound/" + param1.theme.id + "/" + param1.id,Console.getConsole().mainStage.stage);
            }
            else
            {
               param1.addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,onSoundLoaded);
               param1.initSoundFromNetwork();
            }
         }
      }
   }
}
