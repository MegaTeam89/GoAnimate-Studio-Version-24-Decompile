package anifire.core.sound
{
   import anifire.timeline.SoundContainer;
   import flash.events.IEventDispatcher;
   
   public interface ISoundable extends IEventDispatcher
   {
       
      
      function clone() : ISoundable;
      
      function play(param1:Number = 0, param2:SoundContainer = null, param3:Number = 1) : void;
      
      function stop() : void;
      
      function getDuration() : Number;
      
      function get isReady() : Boolean;
   }
}
