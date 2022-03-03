package anifire.core.sound
{
   import anifire.core.AnimeSound;
   import anifire.core.SoundThumb;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class StudioSoundFactory extends EventDispatcher
   {
       
      
      public function StudioSoundFactory(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function createSound(param1:SoundThumb) : AnimeSound
      {
         return new AnimeSound();
      }
   }
}
