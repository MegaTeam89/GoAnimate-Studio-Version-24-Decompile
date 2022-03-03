package mx.controls
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventPhase;
   import mx.containers.Panel;
   import mx.controls.alertClasses.AlertForm;
   import mx.core.EdgeMetrics;
   import mx.core.FlexGlobals;
   import mx.core.FlexVersion;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModule;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import mx.events.CloseEvent;
   import mx.events.FlexEvent;
   import mx.managers.ISystemManager;
   import mx.managers.PopUpManager;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   public class Alert extends Panel
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
      
      public static const YES:uint = 1;
      
      public static const NO:uint = 2;
      
      public static const OK:uint = 4;
      
      public static const CANCEL:uint = 8;
      
      public static const NONMODAL:uint = 32768;
      
      mx_internal static var createAccessibilityImplementation:Function;
      
      private static var _resourceManager:IResourceManager;
      
      private static var initialized:Boolean = false;
      
      public static var buttonHeight:Number = 22;
      
      public static var buttonWidth:Number = 65;
      
      private static var _cancelLabel:String;
      
      private static var cancelLabelOverride:String;
      
      private static var _noLabel:String;
      
      private static var noLabelOverride:String;
      
      private static var _okLabel:String;
      
      private static var okLabelOverride:String;
      
      private static var _yesLabel:String;
      
      private static var yesLabelOverride:String;
       
      
      mx_internal var alertForm:AlertForm;
      
      public var buttonFlags:uint = 4;
      
      public var defaultButtonFlag:uint = 4;
      
      public var iconClass:Class;
      
      public var text:String = "";
      
      public function Alert()
      {
         super();
         title = "";
      }
      
      private static function get resourceManager() : IResourceManager
      {
         if(!_resourceManager)
         {
            _resourceManager = ResourceManager.getInstance();
         }
         return _resourceManager;
      }
      
      public static function get cancelLabel() : String
      {
         initialize();
         return _cancelLabel;
      }
      
      public static function set cancelLabel(param1:String) : void
      {
         cancelLabelOverride = param1;
         _cancelLabel = param1 != null ? param1 : resourceManager.getString("controls","cancelLabel");
      }
      
      public static function get noLabel() : String
      {
         initialize();
         return _noLabel;
      }
      
      public static function set noLabel(param1:String) : void
      {
         noLabelOverride = param1;
         _noLabel = param1 != null ? param1 : resourceManager.getString("controls","noLabel");
      }
      
      public static function get okLabel() : String
      {
         initialize();
         return _okLabel;
      }
      
      public static function set okLabel(param1:String) : void
      {
         okLabelOverride = param1;
         _okLabel = param1 != null ? param1 : resourceManager.getString("controls","okLabel");
      }
      
      public static function get yesLabel() : String
      {
         initialize();
         return _yesLabel;
      }
      
      public static function set yesLabel(param1:String) : void
      {
         yesLabelOverride = param1;
         _yesLabel = param1 != null ? param1 : resourceManager.getString("controls","yesLabel");
      }
      
      public static function show(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4, param8:IFlexModuleFactory = null) : Alert
      {
         var _loc11_:ISystemManager = null;
         var _loc12_:Object = null;
         var _loc9_:Boolean = !!(param3 & Alert.NONMODAL) ? false : true;
         if(!param4)
         {
            if((_loc12_ = (_loc11_ = ISystemManager(FlexGlobals.topLevelApplication.systemManager)).getImplementation("mx.managers::IMarshalSystemManager")) && _loc12_.useSWFBridge())
            {
               param4 = Sprite(_loc11_.getSandboxRoot());
            }
            else
            {
               param4 = Sprite(FlexGlobals.topLevelApplication);
            }
         }
         var _loc10_:Alert = new Alert();
         if(param3 & Alert.OK || param3 & Alert.CANCEL || param3 & Alert.YES || param3 & Alert.NO)
         {
            _loc10_.buttonFlags = param3;
         }
         if(param7 == Alert.OK || param7 == Alert.CANCEL || param7 == Alert.YES || param7 == Alert.NO)
         {
            _loc10_.defaultButtonFlag = param7;
         }
         _loc10_.text = param1;
         _loc10_.title = param2;
         _loc10_.iconClass = param6;
         if(param5 != null)
         {
            _loc10_.addEventListener(CloseEvent.CLOSE,param5);
         }
         if(param8)
         {
            _loc10_.moduleFactory = param8;
         }
         else if(param4 is IFlexModule)
         {
            _loc10_.moduleFactory = IFlexModule(param4).moduleFactory;
         }
         else
         {
            if(param4 is IFlexModuleFactory)
            {
               _loc10_.moduleFactory = IFlexModuleFactory(param4);
            }
            else
            {
               _loc10_.moduleFactory = FlexGlobals.topLevelApplication.moduleFactory;
            }
            if(!param4 is UIComponent)
            {
               _loc10_.document = FlexGlobals.topLevelApplication.document;
            }
         }
         _loc10_.addEventListener(FlexEvent.CREATION_COMPLETE,static_creationCompleteHandler);
         PopUpManager.addPopUp(_loc10_,param4,_loc9_);
         return _loc10_;
      }
      
      private static function initialize() : void
      {
         if(!initialized)
         {
            resourceManager.addEventListener(Event.CHANGE,static_resourceManager_changeHandler,false,0,true);
            static_resourcesChanged();
            initialized = true;
         }
      }
      
      private static function static_resourcesChanged() : void
      {
         cancelLabel = cancelLabelOverride;
         noLabel = noLabelOverride;
         okLabel = okLabelOverride;
         yesLabel = yesLabelOverride;
      }
      
      private static function static_resourceManager_changeHandler(param1:Event) : void
      {
         static_resourcesChanged();
      }
      
      private static function static_creationCompleteHandler(param1:FlexEvent) : void
      {
         var _loc2_:Alert = null;
         if(param1.target is IFlexDisplayObject && param1.eventPhase == EventPhase.AT_TARGET)
         {
            _loc2_ = Alert(param1.target);
            _loc2_.removeEventListener(FlexEvent.CREATION_COMPLETE,static_creationCompleteHandler);
            _loc2_.setActualSize(_loc2_.getExplicitOrMeasuredWidth(),_loc2_.getExplicitOrMeasuredHeight());
            PopUpManager.centerPopUp(IFlexDisplayObject(_loc2_));
         }
      }
      
      override protected function initializeAccessibility() : void
      {
         if(Alert.createAccessibilityImplementation != null)
         {
            Alert.createAccessibilityImplementation(this);
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         var _loc1_:String = getStyle("messageStyleName");
         if(_loc1_)
         {
            styleName = _loc1_;
         }
         if(!this.alertForm)
         {
            this.alertForm = new AlertForm();
            this.alertForm.styleName = this;
            addChild(this.alertForm);
         }
      }
      
      override protected function measure() : void
      {
         var _loc1_:EdgeMetrics = null;
         var _loc2_:Number = NaN;
         super.measure();
         _loc1_ = viewMetrics;
         measuredWidth = Math.max(measuredWidth,this.alertForm.getExplicitOrMeasuredWidth() + _loc1_.left + _loc1_.right);
         measuredHeight = this.alertForm.getExplicitOrMeasuredHeight() + _loc1_.top + _loc1_.bottom;
         if(FlexVersion.compatibilityVersion >= FlexVersion.VERSION_4_0)
         {
            _loc2_ = getStyle("headerHeight");
            if(_loc1_.top == 0)
            {
               measuredHeight += _loc2_;
            }
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:EdgeMetrics = viewMetrics;
         this.alertForm.setActualSize(param1 - _loc3_.left - _loc3_.right - getStyle("paddingLeft") - getStyle("paddingRight"),param2 - _loc3_.top - _loc3_.bottom - getStyle("paddingTop") - getStyle("paddingBottom"));
      }
      
      override public function styleChanged(param1:String) : void
      {
         var _loc2_:String = null;
         super.styleChanged(param1);
         if(param1 == "messageStyleName")
         {
            _loc2_ = getStyle("messageStyleName");
            styleName = _loc2_;
         }
         if(this.alertForm)
         {
            this.alertForm.styleChanged(param1);
         }
      }
      
      override protected function resourcesChanged() : void
      {
         super.resourcesChanged();
         static_resourcesChanged();
      }
   }
}
