package anifire.util
{
   import anifire.popups.UpdateAccount;
   import anifire.popups.UpdateAccountForStudio;
   import anifire.popups.UpdateGoBuck;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import mx.core.FlexGlobals;
   import mx.core.IFlexDisplayObject;
   import mx.managers.CursorManager;
   import mx.managers.PopUpManager;
   
   public class UtilUser
   {
      
      public static const BASIC_USER:Number = 10;
      
      public static const PLUS_USER:Number = 20;
      
      public static const PUBLISH_USER:Number = 23;
      
      public static const PRO_USER:Number = 25;
      
      public static const COMM_USER:Number = 30;
      
      public static const BETA_USER:Number = 40;
      
      public static const BETA2_USER:Number = 50;
      
      public static const ADMIN_USER:Number = 60;
      
      public static const ACCOUNT_UPGRADED:String = "ACCOUNT_UPGRADED";
      
      private static var _type:Number = -1;
      
      private static var _goBuck:Number = 0;
      
      private static var _goPoint:Number = 0;
      
      private static var _loggedIn:Number = -1;
      
      private static var _eventDispatcher:EventDispatcher;
      
      private static var _updatePopUp:IFlexDisplayObject;
      
      private static var _isTrialAccount:Number = -1;
       
      
      public function UtilUser()
      {
         super();
      }
      
      public static function get eventDispatcher() : IEventDispatcher
      {
         if(!_eventDispatcher)
         {
            _eventDispatcher = new EventDispatcher();
         }
         return _eventDispatcher;
      }
      
      public static function set goBuck(param1:Number) : void
      {
         _goBuck = param1;
      }
      
      public static function set goPoint(param1:Number) : void
      {
         _goPoint = param1;
      }
      
      public static function get goBuck() : Number
      {
         return _goBuck;
      }
      
      public static function get goPoint() : Number
      {
         return _goPoint;
      }
      
      public static function updateAccount() : void
      {
         CursorManager.setBusyCursor();
         var _loc1_:URLLoader = new URLLoader();
         var _loc2_:URLRequest = UtilNetwork.getPointStatus();
         _loc1_.addEventListener(Event.COMPLETE,onUpdateAccountComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,onUpdateAccountFail);
         _loc1_.load(_loc2_);
      }
      
      private static function onUpdateAccountComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:XML = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,onUpdateAccountComplete);
         try
         {
            _loc2_ = URLLoader(param1.target).data as String;
            if(_loc2_.charAt(0) == "0")
            {
               _loc3_ = new XML(_loc2_.substring(1));
               if(_loc3_.hasOwnProperty("@money"))
               {
                  _goBuck = _loc3_.@money;
               }
               if(_loc3_.hasOwnProperty("@sharing"))
               {
                  _goPoint = _loc3_.@sharing;
               }
               if(_loc3_.hasOwnProperty("@ut"))
               {
                  if(Number(_loc3_.@ut) > userType)
                  {
                     eventDispatcher.dispatchEvent(new Event(ACCOUNT_UPGRADED));
                  }
               }
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("setNavGoBuckGoPoint",_goBuck,_goPoint);
                  ExternalInterface.call("refreshTop");
               }
            }
         }
         catch(e:Error)
         {
         }
         CursorManager.removeBusyCursor();
      }
      
      private static function onUpdateAccountFail(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,onUpdateAccountFail);
         CursorManager.removeBusyCursor();
      }
      
      public static function showUpdatePopUp(param1:Boolean = true) : void
      {
         if(_updatePopUp == null)
         {
            if(param1)
            {
               if(UtilApp.mainAppName == UtilApp.STUDIO)
               {
                  _updatePopUp = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,UpdateAccountForStudio,true);
               }
               else
               {
                  _updatePopUp = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,UpdateAccount,true);
               }
            }
            else
            {
               _updatePopUp = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,UpdateGoBuck,true);
            }
            PopUpManager.centerPopUp(_updatePopUp);
            _updatePopUp.y = 100;
            _updatePopUp.addEventListener("okClick",onTransactionConfirm);
            _updatePopUp.addEventListener("cancelClick",onTransactionConfirm);
         }
      }
      
      private static function onTransactionConfirm(param1:Event) : void
      {
         _updatePopUp = null;
         updateAccount();
      }
      
      public static function hasPlusFeatures() : Boolean
      {
         return userType >= PLUS_USER;
      }
      
      public static function hasCommFeatures() : Boolean
      {
         return userType >= COMM_USER;
      }
      
      public static function hasBetaFeatures() : Boolean
      {
         return userType >= BETA_USER;
      }
      
      public static function get hasAdminFeatures() : Boolean
      {
         return userType >= ADMIN_USER;
      }
      
      public static function get hasProFeatures() : Boolean
      {
         return userType >= PRO_USER;
      }
      
      public static function get hasBizFeatures() : Boolean
      {
         return userType > PRO_USER;
      }
      
      public static function get hasBusinessFeatures() : Boolean
      {
         return userType >= PUBLISH_USER;
      }
      
      public static function get userType() : Number
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:String = null;
         if(_type == -1)
         {
            _loc1_ = Util.getFlashVar();
            _loc2_ = _loc1_.getValueByKey("ut");
            switch(_loc2_)
            {
               case "10":
                  _type = BASIC_USER;
                  break;
               case "20":
                  _type = PLUS_USER;
                  break;
               case "23":
                  _type = PUBLISH_USER;
                  break;
               case "25":
                  _type = PRO_USER;
                  break;
               case "30":
                  _type = COMM_USER;
                  break;
               case "40":
                  _type = BETA_USER;
                  break;
               case "50":
                  _type = BETA2_USER;
                  break;
               case "60":
                  _type = ADMIN_USER;
                  break;
               default:
                  _type = BASIC_USER;
            }
         }
         return _type;
      }
      
      public static function get loggedIn() : Boolean
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:String = null;
         if(_loggedIn == -1)
         {
            _loc1_ = Util.getFlashVar();
            _loc2_ = _loc1_.getValueByKey("userId");
            if(_loc2_ == null || _loc2_ == "")
            {
               _loggedIn = 0;
            }
            else
            {
               _loggedIn = 1;
            }
         }
         return _loggedIn == 1;
      }
      
      public static function get isTrialAccount() : Boolean
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:String = null;
         if(_isTrialAccount == -1)
         {
            _loc1_ = Util.getFlashVar();
            _loc2_ = _loc1_.getValueByKey("trial");
            if(_loc2_ == "1")
            {
               _isTrialAccount = 1;
            }
            else
            {
               _isTrialAccount = 0;
            }
         }
         return _isTrialAccount == 1;
      }
   }
}
