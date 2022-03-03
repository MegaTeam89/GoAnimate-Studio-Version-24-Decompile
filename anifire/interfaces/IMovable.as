package anifire.interfaces
{
   public interface IMovable
   {
       
      
      function get x() : Number;
      
      function get y() : Number;
      
      function set x(param1:Number) : void;
      
      function set y(param1:Number) : void;
      
      function move(param1:Number, param2:Number) : void;
   }
}
