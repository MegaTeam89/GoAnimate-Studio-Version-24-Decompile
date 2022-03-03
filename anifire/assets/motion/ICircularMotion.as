package anifire.assets.motion
{
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public interface ICircularMotion extends IEventDispatcher
   {
       
      
      function clone() : ICircularMotion;
      
      function get isCW() : Boolean;
      
      function set isCW(param1:Boolean) : void;
      
      function get rotation() : Number;
      
      function set rotation(param1:Number) : void;
      
      function set center(param1:Point) : void;
      
      function get center() : Point;
   }
}
