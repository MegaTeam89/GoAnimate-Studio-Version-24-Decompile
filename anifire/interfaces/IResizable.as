package anifire.interfaces
{
   public interface IResizable
   {
       
      
      function get width() : Number;
      
      function set width(param1:Number) : void;
      
      function get height() : Number;
      
      function set height(param1:Number) : void;
      
      function get minWidth() : Number;
      
      function get minHeight() : Number;
      
      function get maxWidth() : Number;
      
      function get maxHeight() : Number;
      
      function resize(param1:Number, param2:Number, param3:Boolean = false) : void;
   }
}
