package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.skin.GridBriBackground;
   import anifire.skin.GridDarkBackground;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import anifire.util.UtilUser;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.Grid;
   import mx.containers.GridItem;
   import mx.containers.GridRow;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import template.templateApp.classes.Global;
   
   use namespace mx_internal;
   
   public class BackgroundGrid extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _24223926_canlimit:Canvas;
      
      private var _1391959765bgGrid:Grid;
      
      private var _35966127bgGridRow:GridRow;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _486585567_defaultCeilWidth:Number;
      
      private var _widthCollect:Array;
      
      private var _totalWidth:Number = 0;
      
      private var _gridCount:int = 0;
      
      private var _maxDuration:Number;
      
      private var _currBorderSkin:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function BackgroundGrid()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"resize":"___BackgroundGrid_Canvas1_resize"},
            "propertiesFactory":function():Object
            {
               return {
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Grid,
                     "id":"bgGrid",
                     "events":{"creationComplete":"__bgGrid_creationComplete"},
                     "stylesFactory":function():void
                     {
                        this.horizontalGap = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentHeight":100,
                           "percentWidth":100,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":GridRow,
                              "id":"bgGridRow",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "percentWidth":100
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_canlimit",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off"
                        };
                     }
                  })]
               };
            }
         });
         this._486585567_defaultCeilWidth = AnimeConstants.SCENE_LENGTH_DEFAULT;
         this._widthCollect = new Array();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._BackgroundGrid_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_BackgroundGridWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return BackgroundGrid[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.height = 500;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("resize",this.___BackgroundGrid_Canvas1_resize);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         BackgroundGrid._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function initApp() : void
      {
         var _loc1_:Button = null;
         this.scrollRect = new Rectangle(0,0,this.width,this.height);
         this.refillGrid();
         if(UtilLicense.getCurrentLicenseId() == String(Global.BEN10) || UtilUser.userType == UtilUser.BASIC_USER)
         {
            _loc1_ = new Button();
            if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) == null || Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) == "0")
            {
               this._maxDuration = 120;
               this._canlimit.width = 6600;
               _loc1_.x = 6015;
               _loc1_.toolTip = UtilDict.toDisplay("go","timeline_durationalert");
            }
            else
            {
               this._maxDuration = 25;
               this._canlimit.width = 1850;
               _loc1_.x = 1265;
               _loc1_.toolTip = UtilDict.toDisplay("go","timeline_durationalert25");
            }
            this._canlimit.graphics.beginFill(16711680,0.5);
            this._canlimit.graphics.drawRect(this._maxDuration * AnimeConstants.PIXEL_PER_SEC,0,10000000,300);
            this._canlimit.graphics.endFill();
            _loc1_.width = 20;
            _loc1_.height = 20;
            _loc1_.styleName = "btnTip";
            _loc1_.buttonMode = true;
            _loc1_.y = 105;
         }
         this.bgGrid.addEventListener(ResizeEvent.RESIZE,this.onGridResizeHandler);
      }
      
      private function onGridResizeHandler(param1:ResizeEvent) : void
      {
         this.refillGrid();
      }
      
      public function get totalWidth() : Number
      {
         return this.bgGridRow.measuredWidth;
      }
      
      public function getCeilWidth(param1:Number) : Number
      {
         var _loc2_:GridItem = this.bgGridRow.getChildAt(param1) as GridItem;
         return _loc2_.width;
      }
      
      public function setCeilWidth(param1:Number, param2:Number) : void
      {
         var _loc3_:GridItem = null;
         try
         {
            _loc3_ = this.bgGridRow.getChildAt(param1) as GridItem;
            _loc3_.width = param2;
            this._totalWidth = this.totalWidth;
            this.refillGrid();
         }
         catch(e:Error)
         {
         }
      }
      
      public function setHorizontalView(param1:Number = 0) : void
      {
         this.bgGrid.setStyle("left",-param1);
         this._canlimit.setStyle("left",-param1);
         this.refillGrid();
      }
      
      public function getHorizontalView(param1:int) : Number
      {
         return this.bgGridRow.getChildAt(param1).x;
      }
      
      public function setWidthCollect(param1:Array) : void
      {
         this._widthCollect = param1;
      }
      
      public function redraw() : void
      {
         var _loc1_:GridItem = null;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         try
         {
            _loc2_ = 0;
            _loc3_ = 0;
            _loc2_ = 0;
            while(_loc2_ < this._widthCollect.length)
            {
               _loc3_ += this._widthCollect[_loc2_];
               if(_loc2_ < this.bgGridRow.numChildren)
               {
                  _loc1_ = this.bgGridRow.getChildAt(_loc2_) as GridItem;
                  _loc1_.width = this._widthCollect[_loc2_];
               }
               else
               {
                  this._currBorderSkin = this._currBorderSkin == GridBriBackground ? GridDarkBackground : GridBriBackground;
                  this.addGrid(this._widthCollect[_loc2_],this._currBorderSkin);
               }
               _loc2_++;
            }
            _loc2_ = this._widthCollect.length;
            while(_loc2_ < this.bgGridRow.numChildren)
            {
               _loc1_ = this.bgGridRow.getChildAt(_loc2_) as GridItem;
               _loc3_ += _loc1_.width = this._defaultCeilWidth;
               _loc2_++;
            }
            this._totalWidth = _loc3_;
         }
         catch(e:Error)
         {
         }
      }
      
      private function addGrid(param1:Number = -1, param2:Class = null) : void
      {
         param1 = param1 < 0 ? Number(this._defaultCeilWidth) : Number(param1);
         param2 = param2 == null ? GridBriBackground : param2;
         var _loc3_:GlowFilter = new GlowFilter(10262680,1,5,5,2,1,true,true);
         var _loc4_:Label;
         (_loc4_ = new Label()).text = String(++this._gridCount);
         _loc4_.percentWidth = 100;
         _loc4_.setStyle("textAlign","center");
         _loc4_.setStyle("fontSize",40);
         _loc4_.styleName = "timelineNumber";
         if(FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".gridStyle").getStyle("filter") == "glow")
         {
            _loc4_.filters = [_loc3_];
         }
         var _loc5_:GridItem;
         (_loc5_ = new GridItem()).setStyle("paddingTop",0);
         _loc5_.percentHeight = 100;
         _loc5_.width = param1;
         _loc5_.setStyle("borderStyle","solid");
         _loc5_.setStyle("borderSkin",param2);
         _loc5_.verticalScrollPolicy = "off";
         _loc5_.horizontalScrollPolicy = "off";
         var _loc6_:Canvas = new Canvas();
         _loc6_.percentHeight = _loc6_.percentWidth = 100;
         _loc6_.horizontalScrollPolicy = _loc6_.verticalScrollPolicy = "off";
         _loc6_.styleName = "gridStyle";
         _loc6_.addChild(_loc4_);
         _loc5_.addChild(_loc6_);
         this.bgGridRow.addChild(_loc5_);
      }
      
      private function removeAllGrids() : void
      {
         this._totalWidth = 0;
         this.bgGridRow.removeAllChildren();
      }
      
      public function refillGrid() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Class = null;
         try
         {
            this._totalWidth = this.totalWidth;
            _loc1_ = 0;
            if(this._totalWidth + this.bgGrid.x < width + _loc1_ && this._totalWidth >= 0)
            {
               _loc2_ = this._totalWidth;
               _loc3_ = this._currBorderSkin;
               while(_loc2_ + this.bgGrid.x < this.bgGrid.width + _loc1_)
               {
                  _loc2_ += this._defaultCeilWidth;
                  _loc3_ = _loc3_ == GridBriBackground ? GridDarkBackground : GridBriBackground;
                  this.addGrid(this._defaultCeilWidth,_loc3_);
               }
               this._totalWidth = _loc2_;
               this._currBorderSkin = _loc3_;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onResize(param1:Event) : void
      {
         this.scrollRect = new Rectangle(0,0,this.width,this.height);
      }
      
      public function ___BackgroundGrid_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.onResize(param1);
      }
      
      public function __bgGrid_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      private function _BackgroundGrid_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,this.width,this.height);
         },null,"this.scrollRect");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canlimit() : Canvas
      {
         return this._24223926_canlimit;
      }
      
      public function set _canlimit(param1:Canvas) : void
      {
         var _loc2_:Object = this._24223926_canlimit;
         if(_loc2_ !== param1)
         {
            this._24223926_canlimit = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canlimit",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bgGrid() : Grid
      {
         return this._1391959765bgGrid;
      }
      
      public function set bgGrid(param1:Grid) : void
      {
         var _loc2_:Object = this._1391959765bgGrid;
         if(_loc2_ !== param1)
         {
            this._1391959765bgGrid = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgGrid",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bgGridRow() : GridRow
      {
         return this._35966127bgGridRow;
      }
      
      public function set bgGridRow(param1:GridRow) : void
      {
         var _loc2_:Object = this._35966127bgGridRow;
         if(_loc2_ !== param1)
         {
            this._35966127bgGridRow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgGridRow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _defaultCeilWidth() : Number
      {
         return this._486585567_defaultCeilWidth;
      }
      
      public function set _defaultCeilWidth(param1:Number) : void
      {
         var _loc2_:Object = this._486585567_defaultCeilWidth;
         if(_loc2_ !== param1)
         {
            this._486585567_defaultCeilWidth = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_defaultCeilWidth",_loc2_,param1));
            }
         }
      }
   }
}
