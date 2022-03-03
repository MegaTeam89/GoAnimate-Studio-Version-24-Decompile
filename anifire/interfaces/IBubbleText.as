package anifire.interfaces
{
   public interface IBubbleText
   {
       
      
      function get text() : String;
      
      function get textColor() : uint;
      
      function get textFont() : String;
      
      function get textAlign() : String;
      
      function get textBold() : Boolean;
      
      function get textEmbed() : Boolean;
      
      function get textItalic() : Boolean;
      
      function get textSize() : Number;
      
      function get autoTextResize() : Boolean;
      
      function set text(param1:String) : void;
      
      function set textColor(param1:uint) : void;
      
      function set textFont(param1:String) : void;
      
      function set textAlign(param1:String) : void;
      
      function set textBold(param1:Boolean) : void;
      
      function set textEmbed(param1:Boolean) : void;
      
      function set textItalic(param1:Boolean) : void;
      
      function set textSize(param1:Number) : void;
      
      function set autoTextResize(param1:Boolean) : void;
   }
}
