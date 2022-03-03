package anifire.util
{
   import anifire.constant.ServerConstants;
   import anifire.popups.GoPopUp;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import mx.core.FlexGlobals;
   import mx.core.IFlexDisplayObject;
   import mx.managers.PopUpManager;
   
   public class UtilNavigate
   {
      
      private static var _themeId:String;
       
      
      public function UtilNavigate()
      {
         super();
      }
      
      public static function toUpgradePage(param1:String = "", param2:String = "") : void
      {
         var _loc3_:String = ServerConstants.ACTION_GOPLUS_SIGNUP;
         var _loc4_:String = ServerConstants.POPUP_WINDOW_NAME;
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            _loc3_ = ServerConstants.ACTION_SCHOOLPLUS_SIGNUP;
         }
         else if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            _loc3_ = ServerConstants.UPGRADE_PAGE_PATH;
            _loc4_ = "_self";
         }
         if(param1 != "")
         {
            if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
            {
               _loc3_ += "?hook=" + param1 + ".client";
            }
         }
         if(param2 != "")
         {
            _loc4_ = param2;
         }
         navigateToURL(new URLRequest(_loc3_),_loc4_);
      }
      
      public static function toPlusFeatures(param1:String = "", param2:String = "") : void
      {
         var _loc3_:String = ServerConstants.UPGRADE_PAGE_PATH;
         var _loc4_:String = ServerConstants.POPUP_WINDOW_NAME;
         if(param1 != "")
         {
            if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
            {
               _loc3_ += "?hook=" + param1 + ".client";
            }
         }
         if(param2 != "")
         {
            _loc4_ = param2;
         }
         navigateToURL(new URLRequest(_loc3_),_loc4_);
      }
      
      public static function toG4S(param1:String = "", param2:String = "") : void
      {
         var _loc3_:String = ServerConstants.G4S_PATH;
         var _loc4_:String = ServerConstants.POPUP_WINDOW_NAME;
         if(param1 != "")
         {
            if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
            {
               _loc3_ += "?hook=" + param1 + ".client";
            }
         }
         if(param2 != "")
         {
            _loc4_ = param2;
         }
         navigateToURL(new URLRequest(_loc3_),_loc4_);
      }
      
      public static function toBusinessPage(param1:String = "", param2:String = "") : void
      {
         var _loc3_:String = ServerConstants.BUSINESS_PAGE_PATH;
         var _loc4_:String = ServerConstants.POPUP_WINDOW_NAME;
         if(param1 != "")
         {
            if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
            {
               _loc3_ += "?hook=" + param1 + ".client";
            }
         }
         if(param2 != "")
         {
            _loc4_ = param2;
         }
         navigateToURL(new URLRequest(_loc3_),_loc4_);
      }
      
      public static function toBusinessPlanPage(param1:String = "", param2:String = "") : void
      {
         var _loc3_:String = ServerConstants.BUSINESS_PLAN_PAGE_PATH;
         var _loc4_:String = ServerConstants.POPUP_WINDOW_NAME;
         if(param1 != "")
         {
            if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
            {
               _loc3_ += "?hook=" + param1 + ".client";
            }
         }
         if(param2 != "")
         {
            _loc4_ = param2;
         }
         navigateToURL(new URLRequest(_loc3_),_loc4_);
      }
      
      public static function toBuyBuckPage() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("popBuyBucks");
               UtilUser.showUpdatePopUp(false);
            }
            return;
         }
         navigateToURL(new URLRequest(ServerConstants.ACTION_BUY_BUCKS),ServerConstants.POPUP_WINDOW_NAME);
      }
      
      public static function goCreateCc(param1:String) : void
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE && param1 != "family")
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("showCCBrowser",param1);
               return;
            }
         }
         var _loc2_:IFlexDisplayObject = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,GoPopUp,true);
         GoPopUp(_loc2_).text = UtilDict.toDisplay("go","goalert_createMyChar");
         GoPopUp(_loc2_).addEventListener("okClick",onCreateCc);
         _loc2_.width = 400;
         PopUpManager.centerPopUp(_loc2_);
         _loc2_.y = 100;
         _loc2_.name = param1;
      }
      
      private static function onCreateCc(param1:Event) : void
      {
         var _loc2_:String = null;
         if(param1.target)
         {
            _loc2_ = ServerConstants.CC_PAGE_PATH + "/" + DisplayObject(param1.target).name;
            if(UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.siteId == UtilSite.SKOLETUBE)
            {
               navigateToURL(new URLRequest(_loc2_),"_self");
            }
            else
            {
               navigateToURL(new URLRequest(_loc2_),ServerConstants.POPUP_WINDOW_NAME);
            }
         }
      }
      
      public static function goCopyCc(param1:String, param2:String) : void
      {
         var _loc3_:IFlexDisplayObject = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,GoPopUp,true);
         GoPopUp(_loc3_).text = UtilDict.toDisplay("go","goalert_copy_char_window_alert_text");
         GoPopUp(_loc3_).title = UtilDict.toDisplay("go","goalert_copy_char_title");
         GoPopUp(_loc3_).addEventListener("okClick",onCopyCc);
         _loc3_.width = 400;
         PopUpManager.centerPopUp(_loc3_);
         _loc3_.y = 100;
         _loc3_.name = [param1,param2].join("|");
      }
      
      private static function onCopyCc(param1:Event) : void
      {
         var _loc2_:Array = (param1.target as DisplayObject).name.split("|");
         var _loc3_:String = ServerConstants.CC_PAGE_PATH;
         if(_loc2_[0])
         {
            _loc3_ += "/" + _loc2_[0];
         }
         navigateToURL(new URLRequest(_loc3_ + "/copy/" + _loc2_[1]),ServerConstants.POPUP_WINDOW_NAME);
      }
      
      public static function toFaqcPage() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqc"),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqc"),ServerConstants.POPUP_WINDOW_NAME);
         }
      }
      
      public static function toFaqdPage() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqd"),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqd"),ServerConstants.POPUP_WINDOW_NAME);
         }
      }
      
      public static function toTribeOfNoisePage() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            navigateToURL(new URLRequest("http://www.tribeofnoise.com"),ServerConstants.POPUP_WINDOW_NAME);
         }
         else
         {
            navigateToURL(new URLRequest("http://www.tribeofnoise.com"),"_blank");
         }
      }
   }
}
