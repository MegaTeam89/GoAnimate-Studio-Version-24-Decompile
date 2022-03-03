package anifire.util
{
   import anifire.popups.GoPopUp;
   import anifire.popups.GoUpgrade;
   import anifire.popups.SchoolUpgrade;
   import anifire.popups.YouTubeUpgrade;
   import flash.display.DisplayObject;
   import mx.core.FlexGlobals;
   import mx.core.IFlexDisplayObject;
   import mx.managers.PopUpManager;
   
   public class UtilPopUp
   {
      
      private static var _errorCount:Number = 0;
       
      
      public function UtilPopUp()
      {
         super();
      }
      
      public static function upgrade(param1:String = "") : IFlexDisplayObject
      {
         var _loc2_:GoPopUp = null;
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            _loc2_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,YouTubeUpgrade,true) as GoPopUp;
            _loc2_.ref = param1;
         }
         else if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            _loc2_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,SchoolUpgrade,true) as GoPopUp;
         }
         else
         {
            _loc2_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,GoUpgrade,true) as GoPopUp;
            _loc2_.ref = param1;
         }
         if(param1 != "")
         {
            UtilLog.triggerGoPlusFeature(param1,_loc2_);
         }
         return _loc2_;
      }
      
      public static function alert(param1:String, param2:String = "") : void
      {
         var _loc3_:GoPopUp = GoPopUp(PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,GoPopUp,true));
         _loc3_.width = 400;
         _loc3_.btnCancelVisible = false;
         _loc3_.title = UtilDict.toDisplay("go",param2);
         _loc3_.text = UtilDict.toDisplay("go",param1);
         _loc3_.x = (_loc3_.stage.width - _loc3_.width) / 2;
         _loc3_.y = 100;
      }
      
      public static function errorAlert(param1:String) : void
      {
         var _loc2_:String = null;
         if(_errorCount == 0)
         {
            _loc2_ = "Looks like something went wrong.\nTo help us solve this issue, can you send us the below error message to support@goanimate.com\n\n";
            UtilPopUp.alert(_loc2_ + param1,"Oops");
            ++_errorCount;
         }
      }
   }
}
