package anifire.interfaces
{
   import anifire.core.MotionData;
   
   public interface IMotion
   {
       
      
      function get motionData() : MotionData;
      
      function set motionData(param1:MotionData) : void;
      
      function get shadow() : Object;
   }
}
