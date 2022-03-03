package mx.core
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.setInterval;
   import mx.containers.utilityClasses.ApplicationLayout;
   import mx.effects.EffectManager;
   import mx.events.FlexEvent;
   import mx.managers.FocusManager;
   import mx.managers.IActiveWindowManager;
   import mx.managers.ILayoutManager;
   import mx.managers.ISystemManager;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.IStyleClient;
   import mx.utils.LoaderUtil;
   
   use namespace mx_internal;
   
   public class Application extends LayoutContainer
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
      
      mx_internal static var useProgressiveLayout:Boolean = false;
       
      
      private var resizeHandlerAdded:Boolean = false;
      
      private var percentBoundsChanged:Boolean;
      
      private var preloadObj:Object;
      
      private var creationQueue:Array;
      
      private var processingCreationQueue:Boolean = false;
      
      private var _applicationViewMetrics:EdgeMetrics;
      
      private var resizeWidth:Boolean = true;
      
      private var resizeHeight:Boolean = true;
      
      private var synchronousResize:Boolean = false;
      
      private var viewSourceCMI:ContextMenuItem;
      
      public var frameRate:Number;
      
      public var pageTitle:String;
      
      public var preloader:Object;
      
      public var preloaderChromeColor:uint;
      
      public var scriptRecursionLimit:int;
      
      public var scriptTimeLimit:Number;
      
      public var usePreloader:Boolean;
      
      public var controlBar:IUIComponent;
      
      public var historyManagementEnabled:Boolean = true;
      
      mx_internal var _parameters:Object;
      
      public var resetHistory:Boolean = true;
      
      mx_internal var _url:String;
      
      private var _viewSourceURL:String;
      
      public function Application()
      {
         this.creationQueue = [];
         UIComponentGlobals.layoutManager = ILayoutManager(Singleton.getInstance("mx.managers::ILayoutManager"));
         UIComponentGlobals.layoutManager.usePhasedInstantiation = true;
         if(!FlexGlobals.topLevelApplication)
         {
            FlexGlobals.topLevelApplication = this;
         }
         super();
         layoutObject = new ApplicationLayout();
         layoutObject.target = this;
         boxLayoutClass = ApplicationLayout;
         showInAutomationHierarchy = true;
         this.initResizeBehavior();
      }
      
      public static function get application() : Object
      {
         return FlexGlobals.topLevelApplication;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(this.controlBar)
         {
            this.controlBar.enabled = param1;
         }
      }
      
      override public function set icon(param1:Class) : void
      {
      }
      
      override public function get id() : String
      {
         if(!super.id && this == FlexGlobals.topLevelApplication && ExternalInterface.available)
         {
            return ExternalInterface.objectID;
         }
         return super.id;
      }
      
      override public function set label(param1:String) : void
      {
      }
      
      override public function set percentHeight(param1:Number) : void
      {
         if(param1 != super.percentHeight)
         {
            super.percentHeight = param1;
            this.percentBoundsChanged = true;
            invalidateProperties();
         }
      }
      
      override public function set percentWidth(param1:Number) : void
      {
         if(param1 != super.percentWidth)
         {
            super.percentWidth = param1;
            this.percentBoundsChanged = true;
            invalidateProperties();
         }
      }
      
      override public function set tabIndex(param1:int) : void
      {
      }
      
      override public function set toolTip(param1:String) : void
      {
      }
      
      override public function get viewMetrics() : EdgeMetrics
      {
         if(!this._applicationViewMetrics)
         {
            this._applicationViewMetrics = new EdgeMetrics();
         }
         var _loc1_:EdgeMetrics = this._applicationViewMetrics;
         var _loc2_:EdgeMetrics = super.viewMetrics;
         var _loc3_:Number = getStyle("borderThickness");
         _loc1_.left = _loc2_.left;
         _loc1_.top = _loc2_.top;
         _loc1_.right = _loc2_.right;
         _loc1_.bottom = _loc2_.bottom;
         if(this.controlBar && this.controlBar.includeInLayout)
         {
            _loc1_.top -= _loc3_;
            _loc1_.top += Math.max(this.controlBar.getExplicitOrMeasuredHeight(),_loc3_);
         }
         return _loc1_;
      }
      
      public function get parameters() : Object
      {
         return this._parameters;
      }
      
      override mx_internal function setUnscaledHeight(param1:Number) : void
      {
         invalidateProperties();
         super.setUnscaledHeight(param1);
      }
      
      override mx_internal function setUnscaledWidth(param1:Number) : void
      {
         invalidateProperties();
         super.setUnscaledWidth(param1);
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      override mx_internal function get usePadding() : Boolean
      {
         return layout != ContainerLayout.ABSOLUTE;
      }
      
      public function get viewSourceURL() : String
      {
         return this._viewSourceURL;
      }
      
      public function set viewSourceURL(param1:String) : void
      {
         this._viewSourceURL = param1;
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         if(this.controlBar && param1 == this.controlBar)
         {
            return -1;
         }
         return super.getChildIndex(param1);
      }
      
      override protected function invalidateParentSizeAndDisplayList() : void
      {
         if(!includeInLayout)
         {
            return;
         }
         var _loc1_:IInvalidating = parent as IInvalidating;
         if(!_loc1_)
         {
            if(parent is ISystemManager)
            {
               ISystemManager(parent).invalidateParentSizeAndDisplayList();
            }
            return;
         }
         super.invalidateParentSizeAndDisplayList();
      }
      
      override public function initialize() : void
      {
         var _loc2_:Object = null;
         var _loc1_:ISystemManager = systemManager;
         this._url = LoaderUtil.normalizeURL(_loc1_.loaderInfo);
         this._parameters = _loc1_.loaderInfo.parameters;
         this.initManagers(_loc1_);
         _descriptor = null;
         if(mx_internal::documentDescriptor)
         {
            creationPolicy = mx_internal::documentDescriptor.properties.creationPolicy;
            if(creationPolicy == null || creationPolicy.length == 0)
            {
               creationPolicy = ContainerCreationPolicy.AUTO;
            }
            _loc2_ = mx_internal::documentDescriptor.properties;
            if(_loc2_.width != null)
            {
               width = _loc2_.width;
               delete _loc2_.width;
            }
            if(_loc2_.height != null)
            {
               height = _loc2_.height;
               delete _loc2_.height;
            }
            mx_internal::documentDescriptor.events = null;
         }
         this.initContextMenu();
         super.initialize();
         addEventListener(Event.ADDED,this.addedHandler);
         if(_loc1_.isTopLevelRoot() && Capabilities.isDebugger == true)
         {
            setInterval(this.debugTickler,1500);
         }
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         this.resizeWidth = isNaN(explicitWidth);
         this.resizeHeight = isNaN(explicitHeight);
         if(this.resizeWidth || this.resizeHeight)
         {
            this.resizeHandler(new Event(Event.RESIZE));
            if(!this.resizeHandlerAdded)
            {
               systemManager.addEventListener(Event.RESIZE,this.resizeHandler,false,0,true);
               this.resizeHandlerAdded = true;
            }
         }
         else if(this.resizeHandlerAdded)
         {
            systemManager.removeEventListener(Event.RESIZE,this.resizeHandler);
            this.resizeHandlerAdded = false;
         }
         if(this.percentBoundsChanged)
         {
            this.updateBounds();
            this.percentBoundsChanged = false;
         }
      }
      
      override protected function measure() : void
      {
         var _loc2_:Number = NaN;
         super.measure();
         var _loc1_:EdgeMetrics = borderMetrics;
         if(this.controlBar && this.controlBar.includeInLayout)
         {
            _loc2_ = this.controlBar.getExplicitOrMeasuredWidth() + _loc1_.left + _loc1_.right;
            measuredWidth = Math.max(measuredWidth,_loc2_);
            measuredMinWidth = Math.max(measuredMinWidth,_loc2_);
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         createBorder();
      }
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         if(param1 == "backgroundColor" && getStyle("backgroundImage") == getStyle("defaultBackgroundImage"))
         {
            clearStyle("backgroundImage");
         }
      }
      
      override public function prepareToPrint(param1:IFlexDisplayObject) : Object
      {
         var _loc2_:Object = {};
         if(param1 == this)
         {
            _loc2_.width = width;
            _loc2_.height = height;
            _loc2_.verticalScrollPosition = verticalScrollPosition;
            _loc2_.horizontalScrollPosition = horizontalScrollPosition;
            _loc2_.horizontalScrollBarVisible = horizontalScrollBar != null;
            _loc2_.verticalScrollBarVisible = verticalScrollBar != null;
            _loc2_.whiteBoxVisible = whiteBox != null;
            setActualSize(measuredWidth,measuredHeight);
            horizontalScrollPosition = 0;
            verticalScrollPosition = 0;
            if(horizontalScrollBar)
            {
               horizontalScrollBar.visible = false;
            }
            if(verticalScrollBar)
            {
               verticalScrollBar.visible = false;
            }
            if(whiteBox)
            {
               whiteBox.visible = false;
            }
            this.updateDisplayList(unscaledWidth,unscaledHeight);
         }
         _loc2_.scrollRect = super.prepareToPrint(param1);
         return _loc2_;
      }
      
      override public function finishPrint(param1:Object, param2:IFlexDisplayObject) : void
      {
         if(param2 == this)
         {
            setActualSize(param1.width,param1.height);
            if(horizontalScrollBar)
            {
               horizontalScrollBar.visible = param1.horizontalScrollBarVisible;
            }
            if(verticalScrollBar)
            {
               verticalScrollBar.visible = param1.verticalScrollBarVisible;
            }
            if(whiteBox)
            {
               whiteBox.visible = param1.whiteBoxVisible;
            }
            horizontalScrollPosition = param1.horizontalScrollPosition;
            verticalScrollPosition = param1.verticalScrollPosition;
            this.updateDisplayList(unscaledWidth,unscaledHeight);
         }
         super.finishPrint(param1.scrollRect,param2);
      }
      
      override mx_internal function initThemeColor() : Boolean
      {
         var _loc2_:Object = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:CSSStyleDeclaration = null;
         if(FlexVersion.compatibilityVersion >= FlexVersion.VERSION_4_0)
         {
            return true;
         }
         var _loc1_:Boolean = super.initThemeColor();
         if(!_loc1_)
         {
            if(_loc5_ = styleManager.getMergedStyleDeclaration("global"))
            {
               _loc2_ = _loc5_.getStyle("themeColor");
               _loc3_ = _loc5_.getStyle("rollOverColor");
               _loc4_ = _loc5_.getStyle("selectionColor");
            }
            if(_loc2_ && isNaN(_loc3_) && isNaN(_loc4_))
            {
               setThemeColor(_loc2_);
            }
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      override protected function resourcesChanged() : void
      {
         super.resourcesChanged();
         if(this.viewSourceCMI)
         {
            this.viewSourceCMI.caption = resourceManager.getString("core","viewSource");
         }
      }
      
      override protected function layoutChrome(param1:Number, param2:Number) : void
      {
         super.layoutChrome(param1,param2);
         if(!mx_internal::doingLayout)
         {
            createBorder();
         }
         var _loc3_:EdgeMetrics = borderMetrics;
         var _loc4_:Number = getStyle("borderThickness");
         var _loc5_:EdgeMetrics;
         (_loc5_ = new EdgeMetrics()).left = _loc3_.left - _loc4_;
         _loc5_.top = _loc3_.top - _loc4_;
         _loc5_.right = _loc3_.right - _loc4_;
         _loc5_.bottom = _loc3_.bottom - _loc4_;
         if(this.controlBar && this.controlBar.includeInLayout)
         {
            if(this.controlBar is IInvalidating)
            {
               IInvalidating(this.controlBar).invalidateDisplayList();
            }
            this.controlBar.setActualSize(width - (_loc5_.left + _loc5_.right),this.controlBar.getExplicitOrMeasuredHeight());
            this.controlBar.move(_loc5_.left,_loc5_.top);
         }
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         super.addChildAt(param1,param2);
         if(param1 == this.controlBar && "dock" in param1 && param1["dock"] && "resetDock" in this.controlBar)
         {
            this.controlBar["resetDock"](true);
         }
         return param1;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(param1 == this.controlBar && "dock" in param1 && param1["dock"])
         {
            this.dockControlBar(IUIComponent(param1),false);
         }
         return super.removeChild(param1);
      }
      
      private function debugTickler() : void
      {
         var _loc1_:int = 0;
      }
      
      private function initManagers(param1:ISystemManager) : void
      {
         var _loc2_:IActiveWindowManager = null;
         if(param1.isTopLevel())
         {
            focusManager = new FocusManager(this);
            _loc2_ = IActiveWindowManager(param1.getImplementation("mx.managers::IActiveWindowManager"));
            if(_loc2_)
            {
               _loc2_.activate(this);
            }
            else
            {
               focusManager.activate();
            }
         }
      }
      
      private function initContextMenu() : void
      {
         var _loc2_:String = null;
         if(flexContextMenu != null)
         {
            if(systemManager is InteractiveObject)
            {
               InteractiveObject(systemManager).contextMenu = contextMenu;
            }
            return;
         }
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         _loc1_.builtInItems.print = true;
         if(this._viewSourceURL)
         {
            _loc2_ = resourceManager.getString("core","viewSource");
            this.viewSourceCMI = new ContextMenuItem(_loc2_,true);
            this.viewSourceCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.menuItemSelectHandler);
            if(_loc1_.customItems)
            {
               _loc1_.customItems.push(this.viewSourceCMI);
            }
         }
         contextMenu = _loc1_;
         if(systemManager is InteractiveObject)
         {
            InteractiveObject(systemManager).contextMenu = _loc1_;
         }
      }
      
      public function addToCreationQueue(param1:Object, param2:int = -1, param3:Function = null, param4:IFlexDisplayObject = null) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc5_:int = this.creationQueue.length;
         var _loc6_:Object = {};
         var _loc7_:Boolean = false;
         _loc6_.id = param1;
         _loc6_.parent = param4;
         _loc6_.callbackFunc = param3;
         _loc6_.index = param2;
         var _loc11_:int = 0;
         while(_loc11_ < _loc5_)
         {
            _loc9_ = this.creationQueue[_loc11_].index;
            _loc10_ = !!this.creationQueue[_loc11_].parent ? int(this.creationQueue[_loc11_].parent.nestLevel) : 0;
            if(_loc6_.index != -1)
            {
               if(_loc9_ == -1 || _loc6_.index < _loc9_)
               {
                  _loc8_ = _loc11_;
                  _loc7_ = true;
                  break;
               }
            }
            else
            {
               _loc12_ = !!_loc6_.parent ? int(_loc6_.parent.nestLevel) : 0;
               if(_loc9_ == -1 && _loc10_ < _loc12_)
               {
                  _loc8_ = _loc11_;
                  _loc7_ = true;
                  break;
               }
            }
            _loc11_++;
         }
         if(!_loc7_)
         {
            this.creationQueue.push(_loc6_);
            _loc7_ = true;
         }
         else
         {
            this.creationQueue.splice(_loc8_,0,_loc6_);
         }
         if(initialized && !this.processingCreationQueue)
         {
            this.doNextQueueItem();
         }
      }
      
      private function doNextQueueItem(param1:FlexEvent = null) : void
      {
         this.processingCreationQueue = true;
         Application.useProgressiveLayout = true;
         callLater(this.processNextQueueItem);
      }
      
      private function processNextQueueItem() : void
      {
         var queueItem:Object = null;
         var nextChild:IUIComponent = null;
         if(EffectManager.effectsPlaying.length > 0)
         {
            callLater(this.processNextQueueItem);
         }
         else if(this.creationQueue.length > 0)
         {
            queueItem = this.creationQueue.shift();
            try
            {
               nextChild = queueItem.id is String ? document[queueItem.id] : queueItem.id;
               if(nextChild is Container)
               {
                  Container(nextChild).createComponentsFromDescriptors(true);
               }
               if(nextChild is Container && Container(nextChild).creationPolicy == ContainerCreationPolicy.QUEUED)
               {
                  this.doNextQueueItem();
               }
               else
               {
                  nextChild.addEventListener("childrenCreationComplete",this.doNextQueueItem);
               }
            }
            catch(e:Error)
            {
               processNextQueueItem();
            }
         }
         else
         {
            this.processingCreationQueue = false;
            Application.useProgressiveLayout = false;
         }
      }
      
      private function printCreationQueue() : void
      {
         var _loc4_:Object = null;
         var _loc1_:String = "";
         var _loc2_:Number = this.creationQueue.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.creationQueue[_loc3_];
            _loc1_ += " [" + _loc3_ + "] " + _loc4_.id + " " + _loc4_.index;
            _loc3_++;
         }
      }
      
      private function setControlBar(param1:IUIComponent) : void
      {
         if(param1 == this.controlBar)
         {
            return;
         }
         if(this.controlBar && this.controlBar is IStyleClient)
         {
            IStyleClient(this.controlBar).clearStyle("cornerRadius");
            IStyleClient(this.controlBar).clearStyle("docked");
         }
         this.controlBar = param1;
         if(this.controlBar && this.controlBar is IStyleClient)
         {
            IStyleClient(this.controlBar).setStyle("cornerRadius",0);
            IStyleClient(this.controlBar).setStyle("docked",true);
         }
         invalidateSize();
         invalidateDisplayList();
         invalidateViewMetricsAndPadding();
      }
      
      mx_internal function dockControlBar(param1:IUIComponent, param2:Boolean) : void
      {
         var controlBar:IUIComponent = param1;
         var dock:Boolean = param2;
         if(dock)
         {
            try
            {
               this.removeChild(DisplayObject(controlBar));
            }
            catch(e:Error)
            {
               return;
            }
            rawChildren.addChildAt(DisplayObject(controlBar),mx_internal::firstChildIndex);
            this.setControlBar(controlBar);
         }
         else
         {
            try
            {
               rawChildren.removeChild(DisplayObject(controlBar));
            }
            catch(e:Error)
            {
               return;
            }
            this.setControlBar(null);
            this.addChildAt(DisplayObject(controlBar),0);
         }
      }
      
      private function initResizeBehavior() : void
      {
         var _loc1_:Array = Capabilities.version.split(" ")[1].split(",");
         this.synchronousResize = (parseFloat(_loc1_[0]) > 10 || parseFloat(_loc1_[0]) == 10 && parseFloat(_loc1_[1]) >= 1) && Capabilities.playerType != "Desktop";
      }
      
      private function addedHandler(param1:Event) : void
      {
         if(param1.target == this && this.creationQueue.length > 0)
         {
            this.doNextQueueItem();
         }
      }
      
      private function resizeHandler(param1:Event) : void
      {
         if(!this.percentBoundsChanged)
         {
            this.updateBounds();
            if(this.synchronousResize)
            {
               UIComponentGlobals.layoutManager.validateNow();
            }
         }
      }
      
      protected function menuItemSelectHandler(param1:Event) : void
      {
         navigateToURL(new URLRequest(this._viewSourceURL),"_blank");
      }
      
      private function updateBounds() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this.resizeWidth)
         {
            if(isNaN(percentWidth))
            {
               _loc1_ = DisplayObject(systemManager).width;
            }
            else
            {
               super.percentWidth = Math.max(percentWidth,0);
               super.percentWidth = Math.min(percentWidth,100);
               if(FlexVersion.compatibilityVersion >= FlexVersion.VERSION_4_0)
               {
                  _loc1_ = percentWidth * DisplayObject(systemManager).width / 100;
               }
               else
               {
                  _loc1_ = percentWidth * screen.width / 100;
               }
            }
            if(!isNaN(explicitMaxWidth))
            {
               _loc1_ = Math.min(_loc1_,explicitMaxWidth);
            }
            if(!isNaN(explicitMinWidth))
            {
               _loc1_ = Math.max(_loc1_,explicitMinWidth);
            }
         }
         else
         {
            _loc1_ = width;
         }
         if(this.resizeHeight)
         {
            if(isNaN(percentHeight))
            {
               _loc2_ = DisplayObject(systemManager).height;
            }
            else
            {
               super.percentHeight = Math.max(percentHeight,0);
               super.percentHeight = Math.min(percentHeight,100);
               if(FlexVersion.compatibilityVersion >= FlexVersion.VERSION_4_0)
               {
                  _loc2_ = percentHeight * DisplayObject(systemManager).height / 100;
               }
               else
               {
                  _loc2_ = percentHeight * screen.height / 100;
               }
            }
            if(!isNaN(explicitMaxHeight))
            {
               _loc2_ = Math.min(_loc2_,explicitMaxHeight);
            }
            if(!isNaN(explicitMinHeight))
            {
               _loc2_ = Math.max(_loc2_,explicitMinHeight);
            }
         }
         else
         {
            _loc2_ = height;
         }
         if(_loc1_ != width || _loc2_ != height)
         {
            invalidateProperties();
            invalidateSize();
         }
         setActualSize(_loc1_,_loc2_);
         invalidateDisplayList();
      }
   }
}
