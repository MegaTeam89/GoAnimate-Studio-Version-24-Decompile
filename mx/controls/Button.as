package mx.controls
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFormatAlign;
   import flash.text.TextLineMetrics;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import mx.controls.dataGridClasses.DataGridListData;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.EdgeMetrics;
   import mx.core.FlexVersion;
   import mx.core.IBorder;
   import mx.core.IButton;
   import mx.core.IDataRenderer;
   import mx.core.IFlexAsset;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModuleFactory;
   import mx.core.IFontContextComponent;
   import mx.core.IInvalidating;
   import mx.core.ILayoutDirectionElement;
   import mx.core.IProgrammaticSkin;
   import mx.core.IStateClient;
   import mx.core.IUIComponent;
   import mx.core.IUITextField;
   import mx.core.UIComponent;
   import mx.core.UITextField;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.MoveEvent;
   import mx.events.SandboxMouseEvent;
   import mx.managers.IFocusManagerComponent;
   import mx.styles.ISimpleStyleClient;
   
   use namespace mx_internal;
   
   public class Button extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IListItemRenderer, IFontContextComponent, IButton
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
      
      mx_internal static var createAccessibilityImplementation:Function;
      
      mx_internal static var TEXT_WIDTH_PADDING:Number = UITextField.TEXT_WIDTH_PADDING + 1;
       
      
      private var skins:Array;
      
      mx_internal var currentSkin:IFlexDisplayObject;
      
      protected var icons:Array;
      
      mx_internal var currentIcon:IFlexDisplayObject;
      
      private var autoRepeatTimer:Timer;
      
      mx_internal var buttonOffset:Number = 0;
      
      mx_internal var centerContent:Boolean = true;
      
      mx_internal var extraSpacing:Number = 20.0;
      
      private var styleChangedFlag:Boolean = true;
      
      private var skinMeasuredWidth:Number;
      
      private var skinMeasuredHeight:Number;
      
      private var oldUnscaledWidth:Number;
      
      private var selectedSet:Boolean;
      
      private var labelSet:Boolean;
      
      mx_internal var checkedDefaultSkin:Boolean = false;
      
      mx_internal var defaultSkinUsesStates:Boolean = false;
      
      mx_internal var checkedDefaultIcon:Boolean = false;
      
      mx_internal var defaultIconUsesStates:Boolean = false;
      
      mx_internal var skinName:String = "skin";
      
      mx_internal var emphasizedSkinName:String = "emphasizedSkin";
      
      mx_internal var upSkinName:String = "upSkin";
      
      mx_internal var overSkinName:String = "overSkin";
      
      mx_internal var downSkinName:String = "downSkin";
      
      mx_internal var disabledSkinName:String = "disabledSkin";
      
      mx_internal var selectedUpSkinName:String = "selectedUpSkin";
      
      mx_internal var selectedOverSkinName:String = "selectedOverSkin";
      
      mx_internal var selectedDownSkinName:String = "selectedDownSkin";
      
      mx_internal var selectedDisabledSkinName:String = "selectedDisabledSkin";
      
      mx_internal var iconName:String = "icon";
      
      mx_internal var upIconName:String = "upIcon";
      
      mx_internal var overIconName:String = "overIcon";
      
      mx_internal var downIconName:String = "downIcon";
      
      mx_internal var disabledIconName:String = "disabledIcon";
      
      mx_internal var selectedUpIconName:String = "selectedUpIcon";
      
      mx_internal var selectedOverIconName:String = "selectedOverIcon";
      
      mx_internal var selectedDownIconName:String = "selectedDownIcon";
      
      mx_internal var selectedDisabledIconName:String = "selectedDisabledIcon";
      
      private var enabledChanged:Boolean = false;
      
      protected var textField:IUITextField;
      
      private var toolTipSet:Boolean = false;
      
      private var _autoRepeat:Boolean = false;
      
      private var _data:Object;
      
      mx_internal var _emphasized:Boolean = false;
      
      private var emphasizedChanged:Boolean = false;
      
      private var _label:String = "";
      
      private var labelChanged:Boolean = false;
      
      mx_internal var _labelPlacement:String = "right";
      
      private var _listData:BaseListData;
      
      private var _phase:String = "up";
      
      mx_internal var phaseChanged:Boolean = false;
      
      mx_internal var _selected:Boolean = false;
      
      public var selectedField:String = null;
      
      private var skinLayoutDirectionSet:Boolean = false;
      
      private var _skinLayoutDirection:String;
      
      public var stickyHighlighting:Boolean = false;
      
      mx_internal var _toggle:Boolean = false;
      
      mx_internal var toggleChanged:Boolean = false;
      
      protected var _currentButtonState:String;
      
      public function Button()
      {
         this.skins = [];
         this.icons = [];
         super();
         mouseChildren = false;
         addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      override public function get baselinePosition() : Number
      {
         if(!validateBaselinePosition())
         {
            return NaN;
         }
         return this.textField.y + this.textField.baselinePosition;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(super.enabled == param1)
         {
            return;
         }
         super.enabled = param1;
         this.enabledChanged = true;
         invalidateProperties();
         invalidateDisplayList();
      }
      
      override public function set toolTip(param1:String) : void
      {
         super.toolTip = param1;
         if(param1)
         {
            this.toolTipSet = true;
         }
         else
         {
            this.toolTipSet = false;
            invalidateDisplayList();
         }
      }
      
      public function get autoRepeat() : Boolean
      {
         return this._autoRepeat;
      }
      
      public function set autoRepeat(param1:Boolean) : void
      {
         this._autoRepeat = param1;
         if(param1)
         {
            this.autoRepeatTimer = new Timer(1);
         }
         else
         {
            this.autoRepeatTimer = null;
         }
      }
      
      [Bindable("dataChange")]
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         this._data = param1;
         if(this._listData && this._listData is DataGridListData && DataGridListData(this._listData).dataField != null)
         {
            _loc2_ = this._data[DataGridListData(this._listData).dataField];
            _loc3_ = "";
         }
         else if(this._listData)
         {
            if(this.selectedField)
            {
               _loc2_ = this._data[this.selectedField];
            }
            _loc3_ = this._listData.label;
         }
         else
         {
            _loc2_ = this._data;
         }
         if(_loc2_ !== undefined && !this.selectedSet)
         {
            this.selected = _loc2_ as Boolean;
            this.selectedSet = false;
         }
         if(_loc3_ !== undefined && !this.labelSet)
         {
            this.label = _loc3_;
            this.labelSet = false;
         }
         dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
      }
      
      public function get emphasized() : Boolean
      {
         return this._emphasized;
      }
      
      public function set emphasized(param1:Boolean) : void
      {
         this._emphasized = param1;
         this.emphasizedChanged = true;
         invalidateDisplayList();
      }
      
      public function get fontContext() : IFlexModuleFactory
      {
         return moduleFactory;
      }
      
      public function set fontContext(param1:IFlexModuleFactory) : void
      {
         this.moduleFactory = param1;
      }
      
      [Bindable("labelChanged")]
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this.labelSet = true;
         if(this._label != param1)
         {
            this._label = param1;
            this.labelChanged = true;
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("labelChanged"));
         }
      }
      
      [Bindable("labelPlacementChanged")]
      public function get labelPlacement() : String
      {
         return this._labelPlacement;
      }
      
      public function set labelPlacement(param1:String) : void
      {
         this._labelPlacement = param1;
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("labelPlacementChanged"));
      }
      
      [Bindable("dataChange")]
      public function get listData() : BaseListData
      {
         return this._listData;
      }
      
      public function set listData(param1:BaseListData) : void
      {
         this._listData = param1;
      }
      
      mx_internal function get phase() : String
      {
         return this._phase;
      }
      
      mx_internal function set phase(param1:String) : void
      {
         this._phase = param1;
         this.phaseChanged = true;
         invalidateSize();
         invalidateProperties();
         invalidateDisplayList();
      }
      
      [Bindable("valueCommit")]
      [Bindable("click")]
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.selectedSet = true;
         this.setSelected(param1,true);
      }
      
      mx_internal function setSelected(param1:Boolean, param2:Boolean = false) : void
      {
         if(this._selected != param1)
         {
            this._selected = param1;
            invalidateDisplayList();
            if(this.toggle && !param2)
            {
               dispatchEvent(new Event(Event.CHANGE));
            }
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
         }
      }
      
      mx_internal function set skinLayoutDirection(param1:String) : void
      {
         this.skinLayoutDirectionSet = true;
         this._skinLayoutDirection = param1;
      }
      
      [Bindable("toggleChanged")]
      public function get toggle() : Boolean
      {
         return this._toggle;
      }
      
      public function set toggle(param1:Boolean) : void
      {
         this._toggle = param1;
         this.toggleChanged = true;
         invalidateProperties();
         invalidateDisplayList();
         dispatchEvent(new Event("toggleChanged"));
      }
      
      override protected function initializeAccessibility() : void
      {
         if(Button.createAccessibilityImplementation != null)
         {
            Button.createAccessibilityImplementation(this);
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(!this.textField)
         {
            this.textField = IUITextField(createInFontContext(UITextField));
            this.textField.styleName = this;
            addChild(DisplayObject(this.textField));
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:String = null;
         super.commitProperties();
         if(hasFontContextChanged() && this.textField != null)
         {
            removeChild(DisplayObject(this.textField));
            this.textField = null;
         }
         if(!this.textField)
         {
            this.textField = IUITextField(createInFontContext(UITextField));
            this.textField.styleName = this;
            addChild(DisplayObject(this.textField));
            this.enabledChanged = true;
            this.toggleChanged = true;
         }
         if(!initialized)
         {
            this.viewSkin();
            this.viewIcon();
         }
         if(this.enabledChanged)
         {
            this.textField.enabled = enabled;
            if(this.currentIcon && this.currentIcon is IUIComponent)
            {
               IUIComponent(this.currentIcon).enabled = enabled;
            }
            this.enabledChanged = false;
         }
         if(this.toggleChanged)
         {
            if(!this.toggle)
            {
               this.selected = false;
            }
            this.toggleChanged = false;
         }
         if(this.phaseChanged)
         {
            _loc1_ = this._currentButtonState;
            if(_loc1_ != this.getCurrentButtonState())
            {
               stateChanged(_loc1_,this._currentButtonState,false);
            }
            this.phaseChanged = false;
         }
      }
      
      override protected function measure() : void
      {
         var _loc9_:TextLineMetrics = null;
         super.measure();
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         if(this.label)
         {
            _loc1_ = (_loc9_ = measureText(this.label)).width + mx_internal::TEXT_WIDTH_PADDING;
            _loc2_ = _loc9_.height + UITextField.TEXT_HEIGHT_PADDING;
         }
         var _loc3_:IFlexDisplayObject = this.getCurrentIcon();
         var _loc4_:Number = !!_loc3_ ? Number(_loc3_.width) : Number(0);
         var _loc5_:Number = !!_loc3_ ? Number(_loc3_.height) : Number(0);
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(this.labelPlacement == ButtonLabelPlacement.LEFT || this.labelPlacement == ButtonLabelPlacement.RIGHT)
         {
            _loc6_ = _loc1_ + _loc4_;
            if(_loc1_ && _loc4_)
            {
               _loc6_ += getStyle("horizontalGap");
            }
            _loc7_ = Math.max(_loc2_,_loc5_);
         }
         else
         {
            _loc6_ = Math.max(_loc1_,_loc4_);
            _loc7_ = _loc2_ + _loc5_;
            if(_loc2_ && _loc5_)
            {
               _loc7_ += getStyle("verticalGap");
            }
         }
         if(_loc1_ || _loc4_)
         {
            _loc6_ += getStyle("paddingLeft") + getStyle("paddingRight");
            _loc7_ += getStyle("paddingTop") + getStyle("paddingBottom");
         }
         var _loc8_:EdgeMetrics;
         if(_loc8_ = this.currentSkin && this.currentSkin is IBorder && !(this.currentSkin is IFlexAsset) ? IBorder(this.currentSkin).borderMetrics : null)
         {
            _loc6_ += _loc8_.left + _loc8_.right;
            _loc7_ += _loc8_.top + _loc8_.bottom;
         }
         if(this.currentSkin && (isNaN(this.skinMeasuredWidth) || isNaN(this.skinMeasuredHeight)))
         {
            this.skinMeasuredWidth = this.currentSkin.measuredWidth;
            this.skinMeasuredHeight = this.currentSkin.measuredHeight;
         }
         if(!isNaN(this.skinMeasuredWidth))
         {
            _loc6_ = Math.max(this.skinMeasuredWidth,_loc6_);
         }
         if(!isNaN(this.skinMeasuredHeight))
         {
            _loc7_ = Math.max(this.skinMeasuredHeight,_loc7_);
         }
         measuredMinWidth = measuredWidth = _loc6_;
         measuredMinHeight = measuredHeight = _loc7_;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc5_:IFlexDisplayObject = null;
         var _loc6_:Boolean = false;
         super.updateDisplayList(param1,param2);
         if(this.emphasizedChanged)
         {
            this.changeSkins();
            this.emphasizedChanged = false;
         }
         var _loc3_:int = this.skins.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            (_loc5_ = IFlexDisplayObject(this.skins[_loc4_])).setActualSize(param1,param2);
            _loc4_++;
         }
         this.viewSkin();
         this.viewIcon();
         this.layoutContents(param1,param2,this.phase == ButtonPhase.DOWN);
         if(this.oldUnscaledWidth > param1 || this.textField.text != this.label || this.labelChanged || this.styleChangedFlag)
         {
            this.textField.text = this.label;
            _loc6_ = this.textField.truncateToFit();
            if(!this.toolTipSet)
            {
               if(_loc6_)
               {
                  super.toolTip = this.label;
               }
               else
               {
                  super.toolTip = null;
               }
            }
            this.styleChangedFlag = false;
            this.labelChanged = false;
         }
         this.oldUnscaledWidth = param1;
      }
      
      override public function styleChanged(param1:String) : void
      {
         this.styleChangedFlag = true;
         super.styleChanged(param1);
         if(!param1 || param1 == "styleName")
         {
            this.changeSkins();
            this.changeIcons();
            if(initialized)
            {
               this.viewSkin();
               this.viewIcon();
            }
         }
         else if(param1.toLowerCase().indexOf("skin") != -1)
         {
            this.changeSkins();
         }
         else if(param1.toLowerCase().indexOf("icon") != -1)
         {
            this.changeIcons();
            invalidateSize();
         }
      }
      
      override protected function adjustFocusRect(param1:DisplayObject = null) : void
      {
         super.adjustFocusRect(!this.currentSkin ? DisplayObject(this.currentIcon) : this);
      }
      
      override protected function get currentCSSState() : String
      {
         return this.getCurrentButtonState();
      }
      
      mx_internal function viewSkin() : void
      {
         var _loc1_:String = null;
         if(!enabled)
         {
            _loc1_ = !!this.selected ? this.selectedDisabledSkinName : this.disabledSkinName;
         }
         else if(this.phase == ButtonPhase.UP)
         {
            _loc1_ = !!this.selected ? this.selectedUpSkinName : this.upSkinName;
         }
         else if(this.phase == ButtonPhase.OVER)
         {
            _loc1_ = !!this.selected ? this.selectedOverSkinName : this.overSkinName;
         }
         else if(this.phase == ButtonPhase.DOWN)
         {
            _loc1_ = !!this.selected ? this.selectedDownSkinName : this.downSkinName;
         }
         this.viewSkinForPhase(_loc1_,this.getCurrentButtonState());
      }
      
      mx_internal function viewSkinForPhase(param1:String, param2:String) : void
      {
         var _loc4_:IFlexDisplayObject = null;
         var _loc5_:Number = NaN;
         var _loc6_:ISimpleStyleClient = null;
         var _loc3_:Class = Class(getStyle(param1));
         if(!_loc3_)
         {
            _loc3_ = !!this._emphasized ? Class(getStyle(this.emphasizedSkinName)) : Class(getStyle(this.skinName));
            _loc3_ = !_loc3_ && this._emphasized ? Class(getStyle(this.skinName)) : _loc3_;
            if(this.defaultSkinUsesStates)
            {
               param1 = this.skinName;
            }
            if(!this.checkedDefaultSkin && _loc3_)
            {
               if(!((_loc4_ = IFlexDisplayObject(new _loc3_())) is IProgrammaticSkin) && _loc4_ is IStateClient)
               {
                  this.defaultSkinUsesStates = true;
                  param1 = this.skinName;
               }
               if(_loc4_)
               {
                  this.checkedDefaultSkin = true;
                  if(_loc4_ is ILayoutDirectionElement && this.skinLayoutDirectionSet)
                  {
                     ILayoutDirectionElement(_loc4_).layoutDirection = this._skinLayoutDirection;
                  }
               }
            }
         }
         if(!(_loc4_ = IFlexDisplayObject(getChildByName(param1))))
         {
            if(_loc3_)
            {
               (_loc4_ = IFlexDisplayObject(new _loc3_())).name = param1;
               if(_loc6_ = _loc4_ as ISimpleStyleClient)
               {
                  _loc6_.styleName = this;
               }
               if(_loc4_ is ILayoutDirectionElement && this.skinLayoutDirectionSet)
               {
                  ILayoutDirectionElement(_loc4_).layoutDirection = this._skinLayoutDirection;
               }
               addChild(DisplayObject(_loc4_));
               _loc4_.setActualSize(unscaledWidth,unscaledHeight);
               if(_loc4_ is IInvalidating && initialized)
               {
                  IInvalidating(_loc4_).validateNow();
               }
               else if(_loc4_ is IProgrammaticSkin && initialized)
               {
                  IProgrammaticSkin(_loc4_).validateDisplayList();
               }
               this.skins.push(_loc4_);
            }
         }
         if(this.currentSkin)
         {
            this.currentSkin.visible = false;
         }
         this.currentSkin = _loc4_;
         if(this.defaultSkinUsesStates && this.currentSkin is IStateClient)
         {
            IStateClient(this.currentSkin).currentState = param2;
            if(this.currentSkin is IInvalidating)
            {
               IInvalidating(this.currentSkin).validateNow();
            }
         }
         if(this.currentSkin)
         {
            this.currentSkin.visible = true;
         }
         if(enabled)
         {
            if(this.phase == ButtonPhase.OVER)
            {
               _loc5_ = this.textField.getStyle("textRollOverColor");
            }
            else if(this.phase == ButtonPhase.DOWN)
            {
               _loc5_ = this.textField.getStyle("textSelectedColor");
            }
            else
            {
               _loc5_ = this.textField.getStyle("color");
            }
            this.textField.setColor(_loc5_);
         }
      }
      
      mx_internal function getCurrentIconName() : String
      {
         var _loc1_:String = null;
         if(!enabled)
         {
            _loc1_ = !!this.selected ? this.selectedDisabledIconName : this.disabledIconName;
         }
         else if(this.phase == ButtonPhase.UP)
         {
            _loc1_ = !!this.selected ? this.selectedUpIconName : this.upIconName;
         }
         else if(this.phase == ButtonPhase.OVER)
         {
            _loc1_ = !!this.selected ? this.selectedOverIconName : this.overIconName;
         }
         else if(this.phase == ButtonPhase.DOWN)
         {
            _loc1_ = !!this.selected ? this.selectedDownIconName : this.downIconName;
         }
         return _loc1_;
      }
      
      mx_internal function getCurrentIcon() : IFlexDisplayObject
      {
         var _loc1_:String = this.getCurrentIconName();
         if(!_loc1_)
         {
            return null;
         }
         return this.viewIconForPhase(_loc1_);
      }
      
      mx_internal function viewIcon() : void
      {
         var _loc1_:String = this.getCurrentIconName();
         this.viewIconForPhase(_loc1_);
      }
      
      mx_internal function viewIconForPhase(param1:String) : IFlexDisplayObject
      {
         var _loc3_:IFlexDisplayObject = null;
         var _loc4_:Boolean = false;
         var _loc2_:Class = Class(getStyle(param1));
         if(!_loc2_)
         {
            _loc2_ = Class(getStyle(this.iconName));
            if(this.defaultIconUsesStates)
            {
               param1 = this.iconName;
            }
            if(!this.checkedDefaultIcon && _loc2_)
            {
               _loc3_ = IFlexDisplayObject(new _loc2_());
               if(!(_loc3_ is IProgrammaticSkin) && _loc3_ is IStateClient)
               {
                  this.defaultIconUsesStates = true;
                  param1 = this.iconName;
               }
               if(_loc3_)
               {
                  this.checkedDefaultIcon = true;
               }
            }
         }
         _loc3_ = IFlexDisplayObject(getChildByName(param1));
         if(_loc3_ == null)
         {
            if(_loc2_ != null)
            {
               _loc3_ = IFlexDisplayObject(new _loc2_());
               _loc3_.name = param1;
               if(_loc3_ is ISimpleStyleClient)
               {
                  ISimpleStyleClient(_loc3_).styleName = this;
               }
               addChild(DisplayObject(_loc3_));
               _loc4_ = false;
               if(_loc3_ is IInvalidating)
               {
                  IInvalidating(_loc3_).validateNow();
                  _loc4_ = true;
               }
               else if(_loc3_ is IProgrammaticSkin)
               {
                  IProgrammaticSkin(_loc3_).validateDisplayList();
                  _loc4_ = true;
               }
               if(_loc3_ && _loc3_ is IUIComponent)
               {
                  IUIComponent(_loc3_).enabled = enabled;
               }
               if(_loc4_)
               {
                  _loc3_.setActualSize(_loc3_.measuredWidth,_loc3_.measuredHeight);
               }
               this.icons.push(_loc3_);
            }
         }
         if(this.currentIcon != null)
         {
            this.currentIcon.visible = false;
         }
         this.currentIcon = _loc3_;
         if(this.defaultIconUsesStates && this.currentIcon is IStateClient)
         {
            IStateClient(this.currentIcon).currentState = this.getCurrentButtonState();
            if(this.currentIcon is IInvalidating)
            {
               IInvalidating(this.currentIcon).validateNow();
            }
         }
         if(this.currentIcon != null)
         {
            this.currentIcon.visible = true;
         }
         return _loc3_;
      }
      
      mx_internal function getCurrentButtonState() : String
      {
         this._currentButtonState = "";
         if(!enabled)
         {
            this._currentButtonState = !!this.selected ? "selectedDisabled" : "disabled";
         }
         else if(this.phase == ButtonPhase.UP)
         {
            this._currentButtonState = !!this.selected ? "selectedUp" : "up";
         }
         else if(this.phase == ButtonPhase.OVER)
         {
            this._currentButtonState = !!this.selected ? "selectedOver" : "over";
         }
         else if(this.phase == ButtonPhase.DOWN)
         {
            this._currentButtonState = !!this.selected ? "selectedDown" : "down";
         }
         return this._currentButtonState;
      }
      
      mx_internal function layoutContents(param1:Number, param2:Number, param3:Boolean) : void
      {
         var _loc20_:TextLineMetrics = null;
         var _loc28_:MoveEvent = null;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         var _loc12_:Number = 0;
         var _loc13_:Number = 0;
         var _loc14_:Number = getStyle("paddingLeft");
         var _loc15_:Number = getStyle("paddingRight");
         var _loc16_:Number = getStyle("paddingTop");
         var _loc17_:Number = getStyle("paddingBottom");
         var _loc18_:Number = 0;
         var _loc19_:Number = 0;
         if(this.label)
         {
            _loc18_ = (_loc20_ = measureText(this.label)).width + mx_internal::TEXT_WIDTH_PADDING;
            _loc19_ = _loc20_.height + UITextField.TEXT_HEIGHT_PADDING;
         }
         else
         {
            _loc19_ = (_loc20_ = measureText("Wj")).height + UITextField.TEXT_HEIGHT_PADDING;
         }
         var _loc21_:Number = !!param3 ? Number(this.buttonOffset) : Number(0);
         var _loc22_:String;
         if((_loc22_ = getStyle("textAlign")) == "start")
         {
            _loc22_ = TextFormatAlign.LEFT;
         }
         else if(_loc22_ == "end")
         {
            _loc22_ = TextFormatAlign.RIGHT;
         }
         var _loc23_:Number = param1;
         var _loc24_:Number = param2;
         var _loc25_:EdgeMetrics;
         if(_loc25_ = this.currentSkin && this.currentSkin is IBorder && !(this.currentSkin is IFlexAsset) ? IBorder(this.currentSkin).borderMetrics : null)
         {
            _loc23_ -= _loc25_.left + _loc25_.right;
            _loc24_ -= _loc25_.top + _loc25_.bottom;
         }
         if(this.currentIcon)
         {
            _loc8_ = this.currentIcon.width;
            _loc9_ = this.currentIcon.height;
         }
         if(this.labelPlacement == ButtonLabelPlacement.LEFT || this.labelPlacement == ButtonLabelPlacement.RIGHT)
         {
            _loc12_ = getStyle("horizontalGap");
            if(_loc8_ == 0 || _loc18_ == 0)
            {
               _loc12_ = 0;
            }
            if(_loc18_ > 0)
            {
               this.textField.width = _loc4_ = Math.max(Math.min(_loc23_ - _loc8_ - _loc12_ - _loc14_ - _loc15_,_loc18_),0);
            }
            else
            {
               this.textField.width = _loc4_ = 0;
            }
            this.textField.height = _loc5_ = Math.min(_loc24_,_loc19_);
            if(_loc22_ == "left")
            {
               _loc6_ += _loc14_;
            }
            else if(_loc22_ == "right")
            {
               _loc6_ += _loc23_ - _loc4_ - _loc8_ - _loc12_ - _loc15_;
            }
            else
            {
               _loc6_ += (_loc23_ - _loc4_ - _loc8_ - _loc12_ - _loc14_ - _loc15_) / 2 + _loc14_;
            }
            if(this.labelPlacement == ButtonLabelPlacement.RIGHT)
            {
               _loc10_ = (_loc6_ += _loc8_ + _loc12_) - (_loc8_ + _loc12_);
            }
            else
            {
               _loc10_ = _loc6_ + _loc4_ + _loc12_;
            }
            _loc11_ = (_loc24_ - _loc9_ - _loc16_ - _loc17_) / 2 + _loc16_;
            _loc7_ = (_loc24_ - _loc5_ - _loc16_ - _loc17_) / 2 + _loc16_;
         }
         else
         {
            _loc13_ = getStyle("verticalGap");
            if(_loc9_ == 0 || this.label == "")
            {
               _loc13_ = 0;
            }
            if(_loc18_ > 0)
            {
               this.textField.width = _loc4_ = Math.max(_loc23_ - _loc14_ - _loc15_,0);
               this.textField.height = _loc5_ = Math.min(_loc24_ - _loc9_ - _loc16_ - _loc17_ - _loc13_,_loc19_);
            }
            else
            {
               this.textField.width = _loc4_ = 0;
               this.textField.height = _loc5_ = 0;
            }
            _loc6_ = _loc14_;
            if(_loc22_ == "left")
            {
               _loc10_ += _loc14_;
            }
            else if(_loc22_ == "right")
            {
               _loc10_ += Math.max(_loc23_ - _loc8_ - _loc15_,_loc14_);
            }
            else
            {
               _loc10_ += (_loc23_ - _loc8_ - _loc14_ - _loc15_) / 2 + _loc14_;
            }
            if(this.labelPlacement == ButtonLabelPlacement.TOP)
            {
               _loc7_ += (_loc24_ - _loc5_ - _loc9_ - _loc16_ - _loc17_ - _loc13_) / 2 + _loc16_;
               _loc11_ += _loc7_ + _loc5_ + _loc13_;
            }
            else
            {
               _loc11_ += (_loc24_ - _loc5_ - _loc9_ - _loc16_ - _loc17_ - _loc13_) / 2 + _loc16_;
               _loc7_ += _loc11_ + _loc9_ + _loc13_;
            }
         }
         var _loc26_:Number = _loc21_;
         var _loc27_:Number = _loc21_;
         if(_loc25_)
         {
            _loc26_ += _loc25_.left;
            _loc27_ += _loc25_.top;
         }
         if(FlexVersion.compatibilityVersion >= FlexVersion.VERSION_4_0)
         {
            _loc7_ += getStyle("labelVerticalOffset");
         }
         this.textField.x = Math.round(_loc6_ + _loc26_);
         this.textField.y = Math.round(_loc7_ + _loc27_);
         if(this.currentIcon)
         {
            _loc10_ += _loc26_;
            _loc11_ += _loc27_;
            (_loc28_ = new MoveEvent(MoveEvent.MOVE)).oldX = this.currentIcon.x;
            _loc28_.oldY = this.currentIcon.y;
            this.currentIcon.x = Math.round(_loc10_);
            this.currentIcon.y = Math.round(_loc11_);
            this.currentIcon.dispatchEvent(_loc28_);
         }
         if(this.currentSkin)
         {
            setChildIndex(DisplayObject(this.currentSkin),numChildren - 1);
         }
         if(this.currentIcon)
         {
            setChildIndex(DisplayObject(this.currentIcon),numChildren - 1);
         }
         if(this.textField)
         {
            setChildIndex(DisplayObject(this.textField),numChildren - 1);
         }
      }
      
      mx_internal function changeSkins() : void
      {
         var _loc1_:int = this.skins.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            removeChild(this.skins[_loc2_]);
            _loc2_++;
         }
         this.skins = [];
         this.skinMeasuredWidth = NaN;
         this.skinMeasuredHeight = NaN;
         this.checkedDefaultSkin = false;
         this.defaultSkinUsesStates = false;
         if(initialized)
         {
            this.viewSkin();
            invalidateSize();
         }
      }
      
      mx_internal function changeIcons() : void
      {
         var _loc1_:int = this.icons.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            removeChild(this.icons[_loc2_]);
            _loc2_++;
         }
         this.icons = [];
         this.checkedDefaultIcon = false;
         this.defaultIconUsesStates = false;
      }
      
      mx_internal function buttonPressed() : void
      {
         this.phase = ButtonPhase.DOWN;
         dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
         if(this.autoRepeat)
         {
            this.autoRepeatTimer.delay = getStyle("repeatDelay");
            this.autoRepeatTimer.addEventListener(TimerEvent.TIMER,this.autoRepeatTimer_timerDelayHandler);
            this.autoRepeatTimer.start();
         }
      }
      
      mx_internal function buttonReleased() : void
      {
         systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_UP,this.systemManager_mouseUpHandler,true);
         systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.stage_mouseLeaveHandler);
         if(this.autoRepeatTimer)
         {
            this.autoRepeatTimer.removeEventListener(TimerEvent.TIMER,this.autoRepeatTimer_timerDelayHandler);
            this.autoRepeatTimer.removeEventListener(TimerEvent.TIMER,this.autoRepeatTimer_timerHandler);
            this.autoRepeatTimer.reset();
         }
      }
      
      mx_internal function getTextField() : IUITextField
      {
         return this.textField;
      }
      
      override protected function focusOutHandler(param1:FocusEvent) : void
      {
         super.focusOutHandler(param1);
         if(this.phase != ButtonPhase.UP)
         {
            this.phase = ButtonPhase.UP;
         }
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            this.buttonPressed();
         }
      }
      
      override protected function keyUpHandler(param1:KeyboardEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         if(param1.keyCode == Keyboard.SPACE)
         {
            this.buttonReleased();
            if(this.phase == ButtonPhase.DOWN)
            {
               dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            this.phase = ButtonPhase.UP;
         }
      }
      
      protected function rollOverHandler(param1:MouseEvent) : void
      {
         if(this.phase == ButtonPhase.UP)
         {
            if(param1.buttonDown)
            {
               return;
            }
            this.phase = ButtonPhase.OVER;
            param1.updateAfterEvent();
         }
         else if(this.phase == ButtonPhase.OVER)
         {
            this.phase = ButtonPhase.DOWN;
            param1.updateAfterEvent();
            if(this.autoRepeatTimer)
            {
               this.autoRepeatTimer.start();
            }
         }
      }
      
      protected function rollOutHandler(param1:MouseEvent) : void
      {
         if(this.phase == ButtonPhase.OVER)
         {
            this.phase = ButtonPhase.UP;
            param1.updateAfterEvent();
         }
         else if(this.phase == ButtonPhase.DOWN && !this.stickyHighlighting)
         {
            this.phase = ButtonPhase.OVER;
            param1.updateAfterEvent();
            if(this.autoRepeatTimer)
            {
               this.autoRepeatTimer.stop();
            }
         }
      }
      
      protected function mouseDownHandler(param1:MouseEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_UP,this.systemManager_mouseUpHandler,true);
         systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.stage_mouseLeaveHandler);
         this.buttonPressed();
         param1.updateAfterEvent();
      }
      
      protected function mouseUpHandler(param1:MouseEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         this.phase = ButtonPhase.OVER;
         this.buttonReleased();
         if(!this.toggle)
         {
            param1.updateAfterEvent();
         }
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         if(!enabled)
         {
            param1.stopImmediatePropagation();
            return;
         }
         if(this.toggle)
         {
            this.setSelected(!this.selected);
            param1.updateAfterEvent();
         }
      }
      
      private function systemManager_mouseUpHandler(param1:MouseEvent) : void
      {
         if(contains(DisplayObject(param1.target)))
         {
            return;
         }
         this.phase = ButtonPhase.UP;
         this.buttonReleased();
         param1.updateAfterEvent();
      }
      
      private function stage_mouseLeaveHandler(param1:Event) : void
      {
         this.phase = ButtonPhase.UP;
         this.buttonReleased();
      }
      
      private function autoRepeatTimer_timerDelayHandler(param1:Event) : void
      {
         if(!enabled)
         {
            return;
         }
         dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
         if(this.autoRepeat)
         {
            this.autoRepeatTimer.reset();
            this.autoRepeatTimer.removeEventListener(TimerEvent.TIMER,this.autoRepeatTimer_timerDelayHandler);
            this.autoRepeatTimer.delay = getStyle("repeatInterval");
            this.autoRepeatTimer.addEventListener(TimerEvent.TIMER,this.autoRepeatTimer_timerHandler);
            this.autoRepeatTimer.start();
         }
      }
      
      private function autoRepeatTimer_timerHandler(param1:Event) : void
      {
         if(!enabled)
         {
            return;
         }
         dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
      }
   }
}
