package anifire.sound
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.media.Sound;
   
   public class SoundFactory extends EventDispatcher
   {
       
      
      public function SoundFactory(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function createSound() : Sound
      {
         return new Sound();
      }
   }
}
