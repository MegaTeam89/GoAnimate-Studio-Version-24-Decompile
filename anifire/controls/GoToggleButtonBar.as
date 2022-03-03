package anifire.controls
{
   import mx.controls.Button;
   import mx.controls.ToggleButtonBar;
   
   public class GoToggleButtonBar extends ToggleButtonBar
   {
       
      
      public var selectedButtonColor:String;
      
      public var selectedButtonBorderColor:String;
      
      public function GoToggleButtonBar()
      {
         super();
      }
      
      override protected function hiliteSelectedNavItem(param1:int) : void
      {
         var _loc2_:Button = null;
         if(selectedIndex > -1)
         {
            _loc2_ = Button(getChildAt(selectedIndex));
            _loc2_.clearStyle("fillColors");
            _loc2_.clearStyle("themeColor");
         }
         super.hiliteSelectedNavItem(param1);
         if(param1 > -1)
         {
            _loc2_ = Button(getChildAt(selectedIndex));
            if(this.selectedButtonColor)
            {
               _loc2_.setStyle("fillColors",[this.selectedButtonColor,this.selectedButtonColor]);
            }
            if(this.selectedButtonBorderColor)
            {
               _loc2_.setStyle("themeColor",this.selectedButtonBorderColor);
            }
         }
      }
   }
}
