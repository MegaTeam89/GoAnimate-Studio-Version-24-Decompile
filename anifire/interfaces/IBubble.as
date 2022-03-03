package anifire.interfaces
{
   import flash.geom.Rectangle;
   
   public interface IBubble
   {
       
      
      function get bgColor() : uint;
      
      function get bubbleSize() : Rectangle;
      
      function set bgColor(param1:uint) : void;
      
      function resizeBubble(param1:Rectangle) : void;
   }
}
