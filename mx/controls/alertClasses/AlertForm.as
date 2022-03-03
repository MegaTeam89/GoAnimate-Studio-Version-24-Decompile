package mx.controls.alertClasses
{
   import flash.display.DisplayObject;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextLineMetrics;
   import flash.ui.Keyboard;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.core.IFlexModuleFactory;
   import mx.core.IFontContextComponent;
   import mx.core.IUITextField;
   import mx.core.UIComponent;
   import mx.core.UITextField;
   import mx.core.mx_internal;
   import mx.events.CloseEvent;
   import mx.managers.IActiveWindowManager;
   import mx.managers.IFocusManagerContainer;
   import mx.managers.ISystemManager;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class AlertForm extends UIComponent implements IFontContextComponent
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      mx_internal var textField:IUITextField;
      
      private var textWidth:Number;
      
      private var textHeight:Number;
      
      private var icon:DisplayObject;
      
      mx_internal var buttons:Array;
      
      mx_internal var defaultButton:Button;
      
      private var defaultButtonChanged:Boolean = false;
      
      public function AlertForm()
      {
         this.buttons = [];
         super();
      }
      
      public function get fontContext() : IFlexModuleFactory
      {
         return moduleFactory;
      }
      
      public function set fontContext(param1:IFlexModuleFactory) : void
      {
         this.moduleFactory = param1;
      }
      
      override protected function createChildren() : void
      {
         var _loc5_:String = null;
         var _loc6_:Button = null;
         super.createChildren();
         this.createTextField(-1);
         var _loc1_:Class = Alert(parent).iconClass;
         if(_loc1_ && !this.icon)
         {
            this.icon = new _loc1_();
            addChild(this.icon);
         }
         var _loc2_:Alert = Alert(parent);
         var _loc3_:uint = _loc2_.buttonFlags;
         var _loc4_:uint = _loc2_.defaultButtonFlag;
         if(_loc3_ & Alert.OK)
         {
            _loc5_ = String(Alert.okLabel);
            _loc6_ = this.createButton(_loc5_,"OK");
            if(_loc4_ == Alert.OK)
            {
               this.defaultButton = _loc6_;
            }
         }
         if(_loc3_ & Alert.YES)
         {
            _loc5_ = String(Alert.yesLabel);
            _loc6_ = this.createButton(_loc5_,"YES");
            if(_loc4_ == Alert.YES)
            {
               this.defaultButton = _loc6_;
            }
         }
         if(_loc3_ & Alert.NO)
         {
            _loc5_ = String(Alert.noLabel);
            _loc6_ = this.createButton(_loc5_,"NO");
            if(_loc4_ == Alert.NO)
            {
               this.defaultButton = _loc6_;
            }
         }
         if(_loc3_ & Alert.CANCEL)
         {
            _loc5_ = String(Alert.cancelLabel);
            _loc6_ = this.createButton(_loc5_,"CANCEL");
            if(_loc4_ == Alert.CANCEL)
            {
               this.defaultButton = _loc6_;
            }
         }
         if(!this.defaultButton && this.buttons.length)
         {
            this.defaultButton = this.buttons[0];
         }
         if(this.defaultButton)
         {
            this.defaultButtonChanged = true;
            invalidateProperties();
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ISystemManager = null;
         var _loc3_:IActiveWindowManager = null;
         super.commitProperties();
         if(hasFontContextChanged() && this.textField != null)
         {
            _loc1_ = getChildIndex(DisplayObject(this.textField));
            this.removeTextField();
            this.createTextField(_loc1_);
         }
         if(this.defaultButtonChanged && this.defaultButton)
         {
            this.defaultButtonChanged = false;
            Alert(parent).defaultButton = this.defaultButton;
            if(parent is IFocusManagerContainer)
            {
               _loc2_ = Alert(parent).systemManager;
               _loc3_ = IActiveWindowManager(_loc2_.getImplementation("mx.managers::IActiveWindowManager"));
               if(_loc3_)
               {
                  _loc3_.activate(IFocusManagerContainer(parent));
               }
            }
            this.defaultButton.setFocus();
         }
      }
      
      override protected function measure() : void
      {
         super.measure();
         var _loc1_:String = Alert(parent).title;
         var _loc2_:TextLineMetrics = Alert(parent).getTitleTextField().getUITextFormat().measureText(_loc1_);
         var _loc3_:int = Math.max(this.buttons.length,2);
         var _loc4_:Number = _loc3_ * this.buttons[0].width + (_loc3_ - 1) * 8;
         var _loc5_:Number = Math.max(_loc4_,_loc2_.width);
         this.textField.width = 2 * _loc5_;
         this.textWidth = this.textField.textWidth + UITextField.TEXT_WIDTH_PADDING;
         var _loc6_:Number = Math.max(_loc5_,this.textWidth);
         _loc6_ = Math.min(_loc6_,2 * _loc5_);
         if(this.textWidth < _loc6_ && this.textField.multiline == true)
         {
            this.textField.multiline = false;
            this.textField.wordWrap = false;
         }
         else if(this.textField.multiline == false)
         {
            this.textField.wordWrap = true;
            this.textField.multiline = true;
         }
         _loc6_ += 16;
         if(this.icon)
         {
            _loc6_ += this.icon.width + 8;
         }
         this.textHeight = this.textField.textHeight + UITextField.TEXT_HEIGHT_PADDING;
         var _loc7_:Number = this.textHeight;
         if(this.icon)
         {
            _loc7_ = Math.max(_loc7_,this.icon.height);
         }
         _loc7_ = (_loc7_ = Math.min(_loc7_,screen.height * 0.75)) + (this.buttons[0].height + 3 * 8);
         measuredWidth = _loc6_;
         measuredHeight = _loc7_;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         super.updateDisplayList(param1,param2);
         _loc4_ = param2 - this.buttons[0].height;
         _loc5_ = this.buttons.length * (this.buttons[0].width + 8) - 8;
         _loc3_ = Math.round((param1 - _loc5_) / 2);
         var _loc6_:int = 0;
         while(_loc6_ < this.buttons.length)
         {
            this.buttons[_loc6_].move(_loc3_,_loc4_);
            this.buttons[_loc6_].tabIndex = _loc6_ + 1;
            _loc3_ += this.buttons[_loc6_].width + 8;
            _loc6_++;
         }
         _loc5_ = this.textWidth;
         if(this.icon)
         {
            _loc5_ += this.icon.width + 8;
         }
         _loc3_ = Math.round((param1 - _loc5_) / 2);
         if(this.icon)
         {
            this.icon.x = _loc3_;
            this.icon.y = (_loc4_ - this.icon.height) / 2;
            _loc3_ += this.icon.width + 8;
         }
         var _loc7_:Number = this.textField.getExplicitOrMeasuredHeight();
         this.textField.move(_loc3_,Math.round((_loc4_ - _loc7_) / 2));
         this.textField.setActualSize(this.textWidth + 5,_loc7_);
      }
      
      override public function styleChanged(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.styleChanged(param1);
         if(!param1 || param1 == "styleName" || param1 == "buttonStyleName")
         {
            if(this.buttons)
            {
               _loc2_ = getStyle("buttonStyleName");
               _loc3_ = this.buttons.length;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  this.buttons[_loc4_].styleName = _loc2_;
                  _loc4_++;
               }
            }
         }
      }
      
      override protected function resourcesChanged() : void
      {
         var _loc1_:Button = null;
         super.resourcesChanged();
         _loc1_ = Button(getChildByName("OK"));
         if(_loc1_)
         {
            _loc1_.label = String(Alert.okLabel);
         }
         _loc1_ = Button(getChildByName("CANCEL"));
         if(_loc1_)
         {
            _loc1_.label = String(Alert.cancelLabel);
         }
         _loc1_ = Button(getChildByName("YES"));
         if(_loc1_)
         {
            _loc1_.label = String(Alert.yesLabel);
         }
         _loc1_ = Button(getChildByName("NO"));
         if(_loc1_)
         {
            _loc1_.label = String(Alert.noLabel);
         }
      }
      
      mx_internal function createTextField(param1:int) : void
      {
         if(!this.textField)
         {
            this.textField = IUITextField(createInFontContext(UITextField));
            this.textField.styleName = this;
            this.textField.text = Alert(parent).text;
            this.textField.multiline = true;
            this.textField.wordWrap = true;
            this.textField.selectable = true;
            if(param1 == -1)
            {
               addChild(DisplayObject(this.textField));
            }
            else
            {
               addChildAt(DisplayObject(this.textField),param1);
            }
         }
      }
      
      mx_internal function removeTextField() : void
      {
         if(this.textField)
         {
            removeChild(DisplayObject(this.textField));
            this.textField = null;
         }
      }
      
      private function createButton(param1:String, param2:String) : Button
      {
         var _loc3_:Button = new Button();
         _loc3_.label = param1;
         _loc3_.name = param2;
         var _loc4_:String;
         if(_loc4_ = getStyle("buttonStyleName"))
         {
            _loc3_.styleName = _loc4_;
         }
         _loc3_.addEventListener(MouseEvent.CLICK,this.clickHandler);
         _loc3_.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         _loc3_.owner = parent;
         addChild(_loc3_);
         _loc3_.setActualSize(Alert.buttonWidth,Alert.buttonHeight);
         this.buttons.push(_loc3_);
         return _loc3_;
      }
      
      private function removeAlert(param1:String) : void
      {
         var _loc2_:Alert = Alert(parent);
         _loc2_.visible = false;
         var _loc3_:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
         if(param1 == "YES")
         {
            _loc3_.detail = Alert.YES;
         }
         else if(param1 == "NO")
         {
            _loc3_.detail = Alert.NO;
         }
         else if(param1 == "OK")
         {
            _loc3_.detail = Alert.OK;
         }
         else if(param1 == "CANCEL")
         {
            _loc3_.detail = Alert.CANCEL;
         }
         _loc2_.dispatchEvent(_loc3_);
         PopUpManager.removePopUp(_loc2_);
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:uint = Alert(parent).buttonFlags;
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            if(_loc2_ & Alert.CANCEL || !(_loc2_ & Alert.NO))
            {
               this.removeAlert("CANCEL");
            }
            else if(_loc2_ & Alert.NO)
            {
               this.removeAlert("NO");
            }
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = Button(param1.currentTarget).name;
         this.removeAlert(_loc2_);
      }
   }
}
