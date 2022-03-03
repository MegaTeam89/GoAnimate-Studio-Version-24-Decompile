package mx.controls
{
   import flash.ui.Keyboard;
   import mx.controls.scrollClasses.ScrollBar;
   import mx.controls.scrollClasses.ScrollBarDirection;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class VScrollBar extends ScrollBar
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      public function VScrollBar()
      {
         super();
         super.direction = ScrollBarDirection.VERTICAL;
      }
      
      override public function set direction(param1:String) : void
      {
      }
      
      override public function get minWidth() : Number
      {
         return mx_internal::_minWidth;
      }
      
      override public function get minHeight() : Number
      {
         return mx_internal::_minHeight;
      }
      
      override protected function measure() : void
      {
         super.measure();
         measuredWidth = mx_internal::_minWidth;
         measuredHeight = mx_internal::_minHeight;
      }
      
      override mx_internal function isScrollBarKey(param1:uint) : Boolean
      {
         if(param1 == Keyboard.UP)
         {
            lineScroll(-1);
            return true;
         }
         if(param1 == Keyboard.DOWN)
         {
            lineScroll(1);
            return true;
         }
         if(param1 == Keyboard.PAGE_UP)
         {
            pageScroll(-1);
            return true;
         }
         if(param1 == Keyboard.PAGE_DOWN)
         {
            pageScroll(1);
            return true;
         }
         return super.isScrollBarKey(param1);
      }
   }
}
