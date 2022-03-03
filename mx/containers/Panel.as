package mx.containers
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextLineMetrics;
   import flash.utils.getQualifiedClassName;
   import mx.automation.IAutomationObject;
   import mx.containers.utilityClasses.BoxLayout;
   import mx.containers.utilityClasses.CanvasLayout;
   import mx.containers.utilityClasses.ConstraintColumn;
   import mx.containers.utilityClasses.ConstraintRow;
   import mx.containers.utilityClasses.IConstraintLayout;
   import mx.containers.utilityClasses.Layout;
   import mx.controls.Button;
   import mx.core.Container;
   import mx.core.ContainerLayout;
   import mx.core.EdgeMetrics;
   import mx.core.EventPriority;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModuleFactory;
   import mx.core.IFontContextComponent;
   import mx.core.IUIComponent;
   import mx.core.IUITextField;
   import mx.core.UIComponent;
   import mx.core.UIComponentCachePolicy;
   import mx.core.UITextField;
   import mx.core.UITextFormat;
   import mx.core.mx_internal;
   import mx.effects.EffectManager;
   import mx.events.CloseEvent;
   import mx.events.SandboxMouseEvent;
   import mx.styles.ISimpleStyleClient;
   import mx.styles.IStyleClient;
   import mx.styles.StyleProxy;
   
   use namespace mx_internal;
   
   public class Panel extends Container implements IConstraintLayout, IFontContextComponent
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
      
      private static const HEADER_PADDING:Number = 14;
      
      mx_internal static var createAccessibilityImplementation:Function;
      
      private static var _closeButtonStyleFilters:Object = {
         "closeButtonUpSkin":"closeButtonUpSkin",
         "closeButtonOverSkin":"closeButtonOverSkin",
         "closeButtonDownSkin":"closeButtonDownSkin",
         "closeButtonDisabledSkin":"closeButtonDisabledSkin",
         "closeButtonSkin":"closeButtonSkin",
         "repeatDelay":"repeatDelay",
         "repeatInterval":"repeatInterval"
      };
       
      
      private var layoutObject:Layout;
      
      mx_internal var _showCloseButton:Boolean = false;
      
      mx_internal var titleBarBackground:IFlexDisplayObject;
      
      mx_internal var titleIconObject:Object = null;
      
      mx_internal var closeButton:Button;
      
      private var initializing:Boolean = true;
      
      private var panelViewMetrics:EdgeMetrics;
      
      private var regX:Number;
      
      private var regY:Number;
      
      private var checkedForAutoSetRoundedCorners:Boolean;
      
      private var autoSetRoundedCorners:Boolean;
      
      private var inCreateComponentsFromDescriptors:Boolean;
      
      private var _constraintColumns:Array;
      
      private var _constraintRows:Array;
      
      protected var controlBar:IUIComponent;
      
      private var _layout:String = "vertical";
      
      private var _status:String = "";
      
      private var _statusChanged:Boolean = false;
      
      protected var statusTextField:IUITextField;
      
      private var _title:String = "";
      
      private var _titleChanged:Boolean = false;
      
      protected var titleBar:UIComponent;
      
      private var _titleIcon:Class;
      
      private var _titleIconChanged:Boolean = false;
      
      protected var titleTextField:IUITextField;
      
      public function Panel()
      {
         this._constraintColumns = [];
         this._constraintRows = [];
         super();
         addEventListener("resizeStart",EffectManager.eventHandler,false,EventPriority.EFFECT);
         addEventListener("resizeEnd",EffectManager.eventHandler,false,EventPriority.EFFECT);
         this.layoutObject = new BoxLayout();
         this.layoutObject.target = this;
         showInAutomationHierarchy = true;
      }
      
      override public function get baselinePosition() : Number
      {
         if(!validateBaselinePosition())
         {
            return NaN;
         }
         return this.titleBar.y + this.titleTextField.y + this.titleTextField.baselinePosition;
      }
      
      override public function set cacheAsBitmap(param1:Boolean) : void
      {
         super.cacheAsBitmap = param1;
         if(cacheAsBitmap && !mx_internal::contentPane && cachePolicy != UIComponentCachePolicy.OFF && getStyle("backgroundColor"))
         {
            createContentPane();
            invalidateDisplayList();
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(this.titleTextField)
         {
            this.titleTextField.enabled = param1;
         }
         if(this.statusTextField)
         {
            this.statusTextField.enabled = param1;
         }
         if(this.controlBar)
         {
            this.controlBar.enabled = param1;
         }
         if(this.closeButton)
         {
            this.closeButton.enabled = param1;
         }
      }
      
      protected function get closeButtonStyleFilters() : Object
      {
         return _closeButtonStyleFilters;
      }
      
      public function get constraintColumns() : Array
      {
         return this._constraintColumns;
      }
      
      public function set constraintColumns(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != this._constraintColumns)
         {
            _loc2_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               ConstraintColumn(param1[_loc3_]).container = this;
               _loc3_++;
            }
            this._constraintColumns = param1;
            invalidateSize();
            invalidateDisplayList();
         }
      }
      
      public function get constraintRows() : Array
      {
         return this._constraintRows;
      }
      
      public function set constraintRows(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != this._constraintRows)
         {
            _loc2_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               ConstraintRow(param1[_loc3_]).container = this;
               _loc3_++;
            }
            this._constraintRows = param1;
            invalidateSize();
            invalidateDisplayList();
         }
      }
      
      mx_internal function get _controlBar() : IUIComponent
      {
         return this.controlBar;
      }
      
      public function get fontContext() : IFlexModuleFactory
      {
         return moduleFactory;
      }
      
      public function set fontContext(param1:IFlexModuleFactory) : void
      {
         this.moduleFactory = param1;
      }
      
      [Bindable("layoutChanged")]
      public function get layout() : String
      {
         return this._layout;
      }
      
      public function set layout(param1:String) : void
      {
         if(this._layout != param1)
         {
            this._layout = param1;
            if(this.layoutObject)
            {
               this.layoutObject.target = null;
            }
            if(this._layout == ContainerLayout.ABSOLUTE)
            {
               this.layoutObject = new CanvasLayout();
            }
            else
            {
               this.layoutObject = new BoxLayout();
               if(this._layout == ContainerLayout.VERTICAL)
               {
                  BoxLayout(this.layoutObject).direction = BoxDirection.VERTICAL;
               }
               else
               {
                  BoxLayout(this.layoutObject).direction = BoxDirection.HORIZONTAL;
               }
            }
            if(this.layoutObject)
            {
               this.layoutObject.target = this;
            }
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("layoutChanged"));
         }
      }
      
      [Bindable("statusChanged")]
      public function get status() : String
      {
         return this._status;
      }
      
      public function set status(param1:String) : void
      {
         this._status = param1;
         this._statusChanged = true;
         invalidateProperties();
         dispatchEvent(new Event("statusChanged"));
      }
      
      [Bindable("titleChanged")]
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
         this._titleChanged = true;
         invalidateProperties();
         invalidateSize();
         invalidateViewMetricsAndPadding();
         dispatchEvent(new Event("titleChanged"));
      }
      
      [Bindable("titleIconChanged")]
      public function get titleIcon() : Class
      {
         return this._titleIcon;
      }
      
      public function set titleIcon(param1:Class) : void
      {
         this._titleIcon = param1;
         this._titleIconChanged = true;
         invalidateProperties();
         invalidateSize();
         dispatchEvent(new Event("titleIconChanged"));
      }
      
      override mx_internal function get usePadding() : Boolean
      {
         return this.layout != ContainerLayout.ABSOLUTE;
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         if(this.controlBar && param1 == this.controlBar)
         {
            return numChildren;
         }
         return super.getChildIndex(param1);
      }
      
      override protected function initializeAccessibility() : void
      {
         if(Panel.createAccessibilityImplementation != null)
         {
            Panel.createAccessibilityImplementation(this);
         }
      }
      
      override protected function createChildren() : void
      {
         var _loc1_:Class = null;
         var _loc2_:IStyleClient = null;
         var _loc3_:ISimpleStyleClient = null;
         super.createChildren();
         if(!this.titleBar)
         {
            this.titleBar = new UIComponent();
            this.titleBar.visible = false;
            this.titleBar.addEventListener(MouseEvent.MOUSE_DOWN,this.titleBar_mouseDownHandler);
            rawChildren.addChild(this.titleBar);
         }
         if(!this.titleBarBackground)
         {
            _loc1_ = getStyle("titleBackgroundSkin");
            if(_loc1_)
            {
               this.titleBarBackground = new _loc1_();
               _loc2_ = this.titleBarBackground as IStyleClient;
               if(_loc2_)
               {
                  _loc2_.setStyle("backgroundImage",undefined);
               }
               _loc3_ = this.titleBarBackground as ISimpleStyleClient;
               if(_loc3_)
               {
                  _loc3_.styleName = this;
               }
               this.titleBar.addChild(DisplayObject(this.titleBarBackground));
            }
         }
         this.createTitleTextField(-1);
         this.createStatusTextField(-1);
         if(!this.closeButton)
         {
            this.closeButton = new Button();
            this.closeButton.styleName = new StyleProxy(this,this.closeButtonStyleFilters);
            this.closeButton.upSkinName = "closeButtonUpSkin";
            this.closeButton.overSkinName = "closeButtonOverSkin";
            this.closeButton.downSkinName = "closeButtonDownSkin";
            this.closeButton.disabledSkinName = "closeButtonDisabledSkin";
            this.closeButton.skinName = "closeButtonSkin";
            this.closeButton.explicitWidth = this.closeButton.explicitHeight = 16;
            this.closeButton.focusEnabled = false;
            this.closeButton.visible = false;
            this.closeButton.enabled = enabled;
            this.closeButton.addEventListener(MouseEvent.CLICK,this.closeButton_clickHandler);
            this.titleBar.addChild(this.closeButton);
            this.closeButton.owner = this;
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         super.commitProperties();
         if(hasFontContextChanged())
         {
            if(this.titleTextField)
            {
               _loc1_ = this.titleBar.getChildIndex(DisplayObject(this.titleTextField));
               this.removeTitleTextField();
               this.createTitleTextField(_loc1_);
               this._titleChanged = true;
            }
            if(this.statusTextField)
            {
               _loc1_ = this.titleBar.getChildIndex(DisplayObject(this.statusTextField));
               this.removeStatusTextField();
               this.createStatusTextField(_loc1_);
               this._statusChanged = true;
            }
         }
         if(this._titleChanged)
         {
            this._titleChanged = false;
            this.titleTextField.text = this._title;
            if(initialized)
            {
               this.layoutChrome(unscaledWidth,unscaledHeight);
            }
         }
         if(this._titleIconChanged)
         {
            this._titleIconChanged = false;
            if(this.titleIconObject)
            {
               this.titleBar.removeChild(DisplayObject(this.titleIconObject));
               this.titleIconObject = null;
            }
            if(this._titleIcon)
            {
               this.titleIconObject = new this._titleIcon();
               this.titleBar.addChild(DisplayObject(this.titleIconObject));
            }
            if(initialized)
            {
               this.layoutChrome(unscaledWidth,unscaledHeight);
            }
         }
         if(this._statusChanged)
         {
            this._statusChanged = false;
            this.statusTextField.text = this._status;
            if(initialized)
            {
               this.layoutChrome(unscaledWidth,unscaledHeight);
            }
         }
      }
      
      override protected function measure() : void
      {
         var _loc6_:Number = NaN;
         super.measure();
         this.layoutObject.measure();
         var _loc1_:Rectangle = this.measureHeaderText();
         var _loc2_:Number = _loc1_.width;
         var _loc3_:Number = _loc1_.height;
         var _loc4_:EdgeMetrics = EdgeMetrics.EMPTY;
         _loc2_ += _loc4_.left + _loc4_.right;
         var _loc5_:Number = 5;
         _loc2_ += _loc5_ * 2;
         if(this.titleIconObject)
         {
            _loc2_ += this.titleIconObject.width;
         }
         if(this.closeButton)
         {
            _loc2_ += this.closeButton.getExplicitOrMeasuredWidth() + 6;
         }
         measuredMinWidth = Math.max(_loc2_,measuredMinWidth);
         measuredWidth = Math.max(_loc2_,measuredWidth);
         if(this.controlBar && this.controlBar.includeInLayout)
         {
            _loc6_ = this.controlBar.getExplicitOrMeasuredWidth() + _loc4_.left + _loc4_.right;
            measuredWidth = Math.max(measuredWidth,_loc6_);
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         this.layoutObject.updateDisplayList(param1,param2);
         if(mx_internal::border)
         {
            mx_internal::border.visible = true;
         }
         this.titleBar.visible = true;
      }
      
      override public function styleChanged(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Class = null;
         var _loc7_:IStyleClient = null;
         var _loc8_:ISimpleStyleClient = null;
         var _loc2_:Boolean = !param1 || param1 == "styleName";
         super.styleChanged(param1);
         if(_loc2_ || param1 == "titleStyleName")
         {
            if(this.titleTextField)
            {
               _loc3_ = getStyle("titleStyleName");
               this.titleTextField.styleName = _loc3_;
            }
         }
         if(_loc2_ || param1 == "statusStyleName")
         {
            if(this.statusTextField)
            {
               _loc4_ = getStyle("statusStyleName");
               this.statusTextField.styleName = _loc4_;
            }
         }
         if(_loc2_ || param1 == "controlBarStyleName")
         {
            if(this.controlBar && this.controlBar is ISimpleStyleClient)
            {
               _loc5_ = getStyle("controlBarStyleName");
               ISimpleStyleClient(this.controlBar).styleName = _loc5_;
            }
         }
         if(_loc2_ || param1 == "titleBackgroundSkin")
         {
            if(this.titleBar)
            {
               if(_loc6_ = getStyle("titleBackgroundSkin"))
               {
                  if(this.titleBarBackground)
                  {
                     this.titleBar.removeChild(DisplayObject(this.titleBarBackground));
                     this.titleBarBackground = null;
                  }
                  this.titleBarBackground = new _loc6_();
                  if(_loc7_ = this.titleBarBackground as IStyleClient)
                  {
                     _loc7_.setStyle("backgroundImage",undefined);
                  }
                  if(_loc8_ = this.titleBarBackground as ISimpleStyleClient)
                  {
                     _loc8_.styleName = this;
                  }
                  this.titleBar.addChildAt(DisplayObject(this.titleBarBackground),0);
               }
            }
         }
      }
      
      override protected function layoutChrome(param1:Number, param2:Number) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Graphics = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         super.layoutChrome(param1,param2);
         var _loc3_:EdgeMetrics = EdgeMetrics.EMPTY;
         var _loc4_:Number = getStyle("borderThickness");
         if(getQualifiedClassName(mx_internal::border) == "mx.skins.halo::PanelSkin" && getStyle("borderStyle") != "default" && _loc4_)
         {
            _loc3_ = new EdgeMetrics(_loc4_,_loc4_,_loc4_,_loc4_);
         }
         var _loc5_:EdgeMetrics;
         var _loc6_:Number = (_loc5_ = _loc3_).left;
         var _loc7_:Number = _loc5_.top;
         var _loc8_:Number;
         if((_loc8_ = this.getHeaderHeight()) > 0 && height >= _loc8_)
         {
            _loc9_ = param1 - _loc5_.left - _loc5_.right;
            this.showTitleBar(true);
            this.titleBar.mouseChildren = true;
            this.titleBar.mouseEnabled = true;
            (_loc10_ = this.titleBar.graphics).clear();
            _loc10_.beginFill(16777215,0);
            _loc10_.drawRect(0,0,_loc9_,_loc8_);
            _loc10_.endFill();
            _loc10_.lineStyle(0,0,0);
            _loc10_.drawRect(0,0,_loc9_,param2);
            this.titleBar.move(_loc6_,_loc7_);
            this.titleBar.setActualSize(_loc9_,_loc8_);
            if(this.titleBarBackground)
            {
               this.titleBarBackground.move(0,0);
               IFlexDisplayObject(this.titleBarBackground).setActualSize(_loc9_,_loc8_);
            }
            this.closeButton.visible = this._showCloseButton;
            if(this._showCloseButton)
            {
               this.closeButton.setActualSize(this.closeButton.getExplicitOrMeasuredWidth(),this.closeButton.getExplicitOrMeasuredHeight());
               this.closeButton.move(param1 - _loc6_ - _loc5_.right - 10 - this.closeButton.getExplicitOrMeasuredWidth(),(_loc8_ - this.closeButton.getExplicitOrMeasuredHeight()) / 2);
            }
            _loc11_ = 10;
            _loc12_ = 10;
            if(this.titleIconObject)
            {
               _loc13_ = this.titleIconObject.height;
               _loc14_ = (_loc8_ - _loc13_) / 2;
               this.titleIconObject.move(_loc11_,_loc14_);
               _loc11_ += this.titleIconObject.width + 4;
            }
            _loc13_ = this.titleTextField.getUITextFormat().measureText(this.titleTextField.text).height;
            _loc14_ = (_loc8_ - _loc13_) / 2;
            _loc15_ = _loc5_.left + _loc5_.right;
            this.titleTextField.move(_loc11_,_loc14_ - 1);
            this.titleTextField.setActualSize(Math.max(0,param1 - _loc11_ - _loc12_ - _loc15_),_loc13_ + UITextField.TEXT_HEIGHT_PADDING);
            _loc13_ = this.statusTextField.text != "" ? Number(this.statusTextField.getUITextFormat().measureText(this.statusTextField.text).height) : Number(0);
            _loc14_ = (_loc8_ - _loc13_) / 2;
            _loc16_ = param1 - _loc12_ - 4 - _loc15_ - this.statusTextField.textWidth;
            if(this._showCloseButton)
            {
               _loc16_ -= this.closeButton.getExplicitOrMeasuredWidth() + 4;
            }
            this.statusTextField.move(_loc16_,_loc14_ - 1);
            this.statusTextField.setActualSize(this.statusTextField.textWidth + 8,this.statusTextField.textHeight + UITextField.TEXT_HEIGHT_PADDING);
            _loc17_ = this.titleTextField.x + this.titleTextField.textWidth + 8;
            if(this.statusTextField.x < _loc17_)
            {
               this.statusTextField.width = Math.max(this.statusTextField.width - (_loc17_ - this.statusTextField.x),0);
               this.statusTextField.x = _loc17_;
            }
         }
         else if(this.titleBar)
         {
            this.showTitleBar(false);
            this.titleBar.mouseChildren = false;
            this.titleBar.mouseEnabled = false;
         }
         if(this.controlBar)
         {
            _loc18_ = this.controlBar.x;
            _loc19_ = this.controlBar.y;
            _loc20_ = this.controlBar.width;
            _loc21_ = this.controlBar.height;
            this.controlBar.setActualSize(param1 - (_loc5_.left + _loc5_.right),this.controlBar.getExplicitOrMeasuredHeight());
            this.controlBar.move(_loc5_.left,param2 - _loc5_.bottom - this.controlBar.getExplicitOrMeasuredHeight());
            if(this.controlBar.includeInLayout)
            {
               this.controlBar.visible = this.controlBar.y >= _loc5_.top;
            }
            if(_loc18_ != this.controlBar.x || _loc19_ != this.controlBar.y || _loc20_ != this.controlBar.width || _loc21_ != this.controlBar.height)
            {
               invalidateDisplayList();
            }
         }
      }
      
      override public function createComponentsFromDescriptors(param1:Boolean = true) : void
      {
         var _loc3_:Object = null;
         this.inCreateComponentsFromDescriptors = true;
         super.createComponentsFromDescriptors();
         if(numChildren == 0)
         {
            this.setControlBar(null);
            this.inCreateComponentsFromDescriptors = false;
            return;
         }
         var _loc2_:IUIComponent = IUIComponent(getChildAt(numChildren - 1));
         if(_loc2_ is ControlBar)
         {
            _loc3_ = _loc2_.document;
            if(mx_internal::contentPane)
            {
               mx_internal::contentPane.removeChild(DisplayObject(_loc2_));
            }
            else
            {
               super.removeChild(DisplayObject(_loc2_));
            }
            _loc2_.document = _loc3_;
            rawChildren.addChild(DisplayObject(_loc2_));
            this.setControlBar(_loc2_);
         }
         else
         {
            this.setControlBar(null);
         }
         this.inCreateComponentsFromDescriptors = false;
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         super.addChildAt(param1,param2);
         if(!this.inCreateComponentsFromDescriptors && param1 is ControlBar)
         {
            this.createComponentsFromDescriptors();
         }
         return param1;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(!this.inCreateComponentsFromDescriptors && param1 is ControlBar && numChildren > 0 && param1 == getChildAt(numChildren - 1))
         {
            rawChildren.removeChild(param1);
            this.createComponentsFromDescriptors();
            return param1;
         }
         return super.removeChild(param1);
      }
      
      mx_internal function createTitleTextField(param1:int) : void
      {
         var _loc2_:String = null;
         if(!this.titleTextField)
         {
            this.titleTextField = IUITextField(createInFontContext(UITextField));
            this.titleTextField.selectable = false;
            if(param1 == -1)
            {
               this.titleBar.addChild(DisplayObject(this.titleTextField));
            }
            else
            {
               this.titleBar.addChildAt(DisplayObject(this.titleTextField),param1);
            }
            _loc2_ = getStyle("titleStyleName");
            this.titleTextField.styleName = _loc2_;
            this.titleTextField.text = this.title;
            this.titleTextField.enabled = enabled;
         }
      }
      
      mx_internal function removeTitleTextField() : void
      {
         if(this.titleBar && this.titleTextField)
         {
            this.titleBar.removeChild(DisplayObject(this.titleTextField));
            this.titleTextField = null;
         }
      }
      
      mx_internal function createStatusTextField(param1:int) : void
      {
         var _loc2_:String = null;
         if(this.titleBar && !this.statusTextField)
         {
            this.statusTextField = IUITextField(createInFontContext(UITextField));
            this.statusTextField.selectable = false;
            if(param1 == -1)
            {
               this.titleBar.addChild(DisplayObject(this.statusTextField));
            }
            else
            {
               this.titleBar.addChildAt(DisplayObject(this.statusTextField),param1);
            }
            _loc2_ = getStyle("statusStyleName");
            this.statusTextField.styleName = _loc2_;
            this.statusTextField.text = this.status;
            this.statusTextField.enabled = enabled;
         }
      }
      
      mx_internal function removeStatusTextField() : void
      {
         if(this.titleBar && this.statusTextField)
         {
            this.titleBar.removeChild(DisplayObject(this.statusTextField));
            this.statusTextField = null;
         }
      }
      
      private function measureHeaderText(param1:Boolean = false) : Rectangle
      {
         var _loc4_:UITextFormat = null;
         var _loc5_:TextLineMetrics = null;
         var _loc2_:Number = 20;
         var _loc3_:Number = 14;
         if(this.titleTextField && this.titleTextField.text)
         {
            this.titleTextField.validateNow();
            _loc2_ = (_loc5_ = (_loc4_ = this.titleTextField.getUITextFormat()).measureText(this.titleTextField.text,false)).width;
            _loc3_ = _loc5_.height;
         }
         else if(param1)
         {
            if(this.titleTextField)
            {
               _loc2_ = (_loc5_ = (_loc4_ = this.titleTextField.getUITextFormat()).measureText("Wj",false)).width;
               _loc3_ = _loc5_.height;
            }
         }
         if(this.statusTextField && this.statusTextField.text)
         {
            this.statusTextField.validateNow();
            _loc5_ = (_loc4_ = this.statusTextField.getUITextFormat()).measureText(this.statusTextField.text,false);
            _loc2_ = Math.max(_loc2_,_loc5_.width);
            _loc3_ = Math.max(_loc3_,_loc5_.height);
         }
         return new Rectangle(0,0,Math.round(_loc2_),Math.round(_loc3_));
      }
      
      protected function getHeaderHeight() : Number
      {
         var _loc1_:Number = getStyle("headerHeight");
         if(isNaN(_loc1_))
         {
            _loc1_ = this.measureHeaderText().height + HEADER_PADDING;
         }
         return _loc1_;
      }
      
      mx_internal function getHeaderHeightProxy(param1:Boolean = false) : Number
      {
         var _loc2_:Number = getStyle("headerHeight");
         if(isNaN(_loc2_))
         {
            _loc2_ = this.measureHeaderText(param1).height + HEADER_PADDING;
         }
         return _loc2_;
      }
      
      private function showTitleBar(param1:Boolean) : void
      {
         var _loc4_:DisplayObject = null;
         this.titleBar.visible = param1;
         var _loc2_:int = this.titleBar.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.titleBar.getChildAt(_loc3_)).visible = param1;
            _loc3_++;
         }
      }
      
      private function setControlBar(param1:IUIComponent) : void
      {
         if(param1 == this.controlBar)
         {
            return;
         }
         this.controlBar = param1;
         if(!this.checkedForAutoSetRoundedCorners)
         {
            this.checkedForAutoSetRoundedCorners = true;
            this.autoSetRoundedCorners = !!styleDeclaration ? styleDeclaration.getStyle("roundedBottomCorners") === undefined : true;
         }
         if(this.autoSetRoundedCorners)
         {
            setStyle("roundedBottomCorners",this.controlBar != null);
         }
         var _loc2_:String = getStyle("controlBarStyleName");
         if(_loc2_ && this.controlBar is ISimpleStyleClient)
         {
            ISimpleStyleClient(this.controlBar).styleName = _loc2_;
         }
         if(this.controlBar)
         {
            this.controlBar.enabled = enabled;
         }
         if(this.controlBar is IAutomationObject)
         {
            IAutomationObject(this.controlBar).showInAutomationHierarchy = false;
         }
         invalidateViewMetricsAndPadding();
         invalidateSize();
         invalidateDisplayList();
      }
      
      protected function startDragging(param1:MouseEvent) : void
      {
         this.regX = param1.stageX - x;
         this.regY = param1.stageY - y;
         var _loc2_:DisplayObject = systemManager.getSandboxRoot();
         _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.systemManager_mouseMoveHandler,true);
         _loc2_.addEventListener(MouseEvent.MOUSE_UP,this.systemManager_mouseUpHandler,true);
         _loc2_.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.stage_mouseLeaveHandler);
         systemManager.deployMouseShields(true);
      }
      
      protected function stopDragging() : void
      {
         var _loc1_:DisplayObject = systemManager.getSandboxRoot();
         _loc1_.removeEventListener(MouseEvent.MOUSE_MOVE,this.systemManager_mouseMoveHandler,true);
         _loc1_.removeEventListener(MouseEvent.MOUSE_UP,this.systemManager_mouseUpHandler,true);
         _loc1_.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.stage_mouseLeaveHandler);
         this.regX = NaN;
         this.regY = NaN;
         systemManager.deployMouseShields(false);
      }
      
      mx_internal function getTitleBar() : UIComponent
      {
         return this.titleBar;
      }
      
      mx_internal function getTitleTextField() : IUITextField
      {
         return this.titleTextField;
      }
      
      mx_internal function getStatusTextField() : IUITextField
      {
         return this.statusTextField;
      }
      
      mx_internal function getControlBar() : IUIComponent
      {
         return this.controlBar;
      }
      
      private function titleBar_mouseDownHandler(param1:MouseEvent) : void
      {
         if(param1.target == this.closeButton)
         {
            return;
         }
         if(enabled && isPopUp && isNaN(this.regX))
         {
            this.startDragging(param1);
         }
      }
      
      private function systemManager_mouseMoveHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(isNaN(this.regX) || isNaN(this.regY))
         {
            return;
         }
         move(param1.stageX - this.regX,param1.stageY - this.regY);
      }
      
      private function systemManager_mouseUpHandler(param1:MouseEvent) : void
      {
         if(!isNaN(this.regX))
         {
            this.stopDragging();
         }
      }
      
      private function stage_mouseLeaveHandler(param1:Event) : void
      {
         if(!isNaN(this.regX))
         {
            this.stopDragging();
         }
      }
      
      private function closeButton_clickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
      }
   }
}
