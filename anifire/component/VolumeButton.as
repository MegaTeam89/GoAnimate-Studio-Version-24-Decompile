package anifire.component
{
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.VSlider;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.formatters.NumberFormatter;
   
   use namespace mx_internal;
   
   public class VolumeButton extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _281986877_sliderControl:Canvas;
      
      private var _2947092_vol:VSlider;
      
      private var _1931449851percentFormatter:NumberFormatter;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private const MIN_VOL:Number = 0;
      
      private const MAX_VOL:Number = 4;
      
      private const VOL_INCREMENT:Number = 0.25;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function VolumeButton()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___VolumeButton_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":42,
                  "height":40,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Button,
                     "events":{"click":"___VolumeButton_Button1_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnVolumeSlide",
                           "left":5,
                           "bottom":3,
                           "buttonMode":true,
                           "useHandCursor":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_sliderControl",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"imgVolumeSlideBg",
                           "bottom":0,
                           "width":42,
                           "height":125,
                           "visible":false,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VSlider,
                              "id":"_vol",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "top":5,
                                    "x":8,
                                    "height":80,
                                    "liveDragging":true,
                                    "sliderThumbClass":ZoomSliderThumb,
                                    "buttonMode":true,
                                    "dataTipFormatFunction":zoomSliderDataTip,
                                    "styleName":"zoomSlider"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"imgBtnVolume",
                                    "bottom":0,
                                    "width":42,
                                    "height":42
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._VolumeButton_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_VolumeButtonWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return VolumeButton[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 42;
         this.height = 40;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.clipContent = false;
         this._VolumeButton_NumberFormatter1_i();
         this.addEventListener("creationComplete",this.___VolumeButton_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         VolumeButton._watcherSetupUtil = param1;
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
      
      public function set volume(param1:Number) : void
      {
         if(param1 >= this.MIN_VOL && param1 <= this.MAX_VOL)
         {
            this._vol.value = param1;
         }
      }
      
      private function showSlider() : void
      {
         this._sliderControl.visible = true;
         this._sliderControl.addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
      }
      
      private function hideSlider() : void
      {
         this._sliderControl.visible = false;
         this._sliderControl.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
         this.dispatchVolume();
      }
      
      private function init() : void
      {
      }
      
      private function onClickVolume() : void
      {
         this.showSlider();
      }
      
      private function onMouseOut(param1:Event) : void
      {
         this.hideSlider();
      }
      
      private function dispatchVolume() : void
      {
         var _loc1_:Number = this._vol.value;
         var _loc2_:ExtraDataEvent = new ExtraDataEvent(ExtraDataEvent.UPDATE,this,_loc1_);
         this.dispatchEvent(_loc2_);
      }
      
      private function zoomSliderDataTip(param1:Number) : String
      {
         return this.percentFormatter.format(100 * param1) + " %";
      }
      
      private function _VolumeButton_NumberFormatter1_i() : NumberFormatter
      {
         var _loc1_:NumberFormatter = new NumberFormatter();
         _loc1_.precision = 0;
         _loc1_.rounding = "nearest";
         this.percentFormatter = _loc1_;
         BindingManager.executeBindings(this,"percentFormatter",this.percentFormatter);
         return _loc1_;
      }
      
      public function ___VolumeButton_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___VolumeButton_Button1_click(param1:MouseEvent) : void
      {
         this.onClickVolume();
      }
      
      private function _VolumeButton_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return MIN_VOL;
         },null,"_vol.minimum");
         result[1] = new Binding(this,function():Number
         {
            return MAX_VOL;
         },null,"_vol.maximum");
         result[2] = new Binding(this,function():Number
         {
            return VOL_INCREMENT;
         },null,"_vol.snapInterval");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderControl() : Canvas
      {
         return this._281986877_sliderControl;
      }
      
      public function set _sliderControl(param1:Canvas) : void
      {
         var _loc2_:Object = this._281986877_sliderControl;
         if(_loc2_ !== param1)
         {
            this._281986877_sliderControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderControl",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vol() : VSlider
      {
         return this._2947092_vol;
      }
      
      public function set _vol(param1:VSlider) : void
      {
         var _loc2_:Object = this._2947092_vol;
         if(_loc2_ !== param1)
         {
            this._2947092_vol = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vol",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get percentFormatter() : NumberFormatter
      {
         return this._1931449851percentFormatter;
      }
      
      public function set percentFormatter(param1:NumberFormatter) : void
      {
         var _loc2_:Object = this._1931449851percentFormatter;
         if(_loc2_ !== param1)
         {
            this._1931449851percentFormatter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"percentFormatter",_loc2_,param1));
            }
         }
      }
   }
}
