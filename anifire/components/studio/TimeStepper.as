package anifire.components.studio
{
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   public class TimeStepper extends Canvas
   {
       
      
      private var _109223313scDur:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _value:Number = 0;
      
      private var _stepSize:Number = 0.125;
      
      private var _minimum:Number = 0;
      
      private var _maximum:Number = 999999;
      
      mx_internal var _TimeStepper_StylesInit_done:Boolean = false;
      
      public function TimeStepper()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":TextInput,
                  "id":"scDur",
                  "events":{
                     "enter":"__scDur_enter",
                     "focusOut":"__scDur_focusOut"
                  },
                  "stylesFactory":function():void
                  {
                     this.paddingTop = 2;
                     this.paddingLeft = 0;
                     this.paddingRight = 13;
                     this.textAlign = "center";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "buttonMode":true,
                        "styleName":"myTextInput",
                        "text":"0s",
                        "width":50,
                        "height":26
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "right":0,
                        "verticalCenter":0,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___TimeStepper_Button1_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnUpArrow",
                                 "buttonMode":true,
                                 "height":13,
                                 "width":13
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___TimeStepper_Button2_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnDownArrow",
                                 "buttonMode":true,
                                 "height":13,
                                 "width":13
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_TimeStepper_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onUpClick() : void
      {
         var _loc1_:Number = this.value;
         this.value = this._value + this._stepSize;
         if(this.value != _loc1_)
         {
            this.dispatchEvent(new Event("change"));
         }
      }
      
      private function onDownClick() : void
      {
         var _loc1_:Number = this.value;
         this.value = this._value - this._stepSize;
         if(this.value != _loc1_)
         {
            this.dispatchEvent(new Event("change"));
         }
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set stepSize(param1:Number) : void
      {
         this._stepSize = param1;
      }
      
      public function set value(param1:Number) : void
      {
         param1 = Math.round(param1 / this._stepSize) * this._stepSize;
         if(param1 < this._minimum)
         {
            param1 = this._minimum;
         }
         else if(param1 > this._maximum)
         {
            param1 = this._maximum;
         }
         if(param1 != this._value)
         {
            this._value = param1;
         }
         this.scDur.text = this._value.toFixed(2) + "s";
      }
      
      public function set minimum(param1:Number) : void
      {
         this._minimum = param1;
      }
      
      public function set maximum(param1:Number) : void
      {
         this._maximum = param1;
      }
      
      private function onTextInputChange(param1:Event) : void
      {
         var _loc2_:Number = this.value;
         this.value = UtilUnitConvert.removeUnit(this.scDur.text,"s");
         if(this.value != _loc2_)
         {
            this.dispatchEvent(new Event("change"));
         }
      }
      
      public function __scDur_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __scDur_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function ___TimeStepper_Button1_click(param1:MouseEvent) : void
      {
         this.onUpClick();
      }
      
      public function ___TimeStepper_Button2_click(param1:MouseEvent) : void
      {
         this.onDownClick();
      }
      
      mx_internal function _TimeStepper_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_TimeStepper_StylesInit_done)
         {
            return;
         }
         mx_internal::_TimeStepper_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".myTextInput");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".myTextInput",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.borderColor = 14342874;
               this.backgroundColor = 15395562;
               this.cornerRadius = 4;
               this.fontSize = 12;
               this.backgroundAlpha = 1;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scDur() : TextInput
      {
         return this._109223313scDur;
      }
      
      public function set scDur(param1:TextInput) : void
      {
         var _loc2_:Object = this._109223313scDur;
         if(_loc2_ !== param1)
         {
            this._109223313scDur = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scDur",_loc2_,param1));
            }
         }
      }
   }
}
