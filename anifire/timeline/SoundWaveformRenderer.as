package anifire.timeline
{
   import anifire.core.sound.SoundWaveformData;
   import anifire.util.UtilDict;
   import anifire.util.UtilMath;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   
   use namespace mx_internal;
   
   public class SoundWaveformRenderer extends Canvas implements IBindingClient
   {
      
      public static const WAVEFORM_COLOR_MUSIC:uint = 6393217;
      
      public static const WAVEFORM_COLOR_EFFECT:uint = 9080660;
      
      public static const WAVEFORM_COLOR_VOICE:uint = 7567762;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1872564868cautionIcon:Image;
      
      private var _232221739loadingIcon:Image;
      
      private var _892481550status:Label;
      
      private var _3642105wave:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _samples:Array;
      
      private var _drawnWidth:Number = 0;
      
      private var _color:uint = 6393217;
      
      private var _repeat:Boolean;
      
      private var _embed_mxml_image_icon_loading_swf_742683607:Class;
      
      private var _embed_mxml_image_icon_caution_png_741833491:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SoundWaveformRenderer()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "creationComplete":"___SoundWaveformRenderer_Canvas1_creationComplete",
               "resize":"___SoundWaveformRenderer_Canvas1_resize"
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"wave",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "id":"status",
                  "stylesFactory":function():void
                  {
                     this.color = 5592405;
                     this.fontSize = 11;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "mouseChildren":false,
                        "buttonMode":true,
                        "useHandCursor":true,
                        "y":1,
                        "x":24
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Image,
                  "id":"cautionIcon",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "source":_embed_mxml_image_icon_caution_png_741833491,
                        "x":6,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Image,
                  "id":"loadingIcon",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "source":_embed_mxml_image_icon_loading_swf_742683607,
                        "x":6
                     };
                  }
               })]};
            }
         });
         this._embed_mxml_image_icon_loading_swf_742683607 = SoundWaveformRenderer__embed_mxml_image_icon_loading_swf_742683607;
         this._embed_mxml_image_icon_caution_png_741833491 = SoundWaveformRenderer__embed_mxml_image_icon_caution_png_741833491;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SoundWaveformRenderer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SoundWaveformRendererWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SoundWaveformRenderer[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___SoundWaveformRenderer_Canvas1_creationComplete);
         this.addEventListener("resize",this.___SoundWaveformRenderer_Canvas1_resize);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SoundWaveformRenderer._watcherSetupUtil = param1;
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
      
      public function reset() : void
      {
         this._samples = null;
         this.wave.graphics.clear();
      }
      
      public function init(param1:Array, param2:uint, param3:Boolean) : void
      {
         if(!this._samples)
         {
            this._samples = param1;
            this._color = param2;
            this._repeat = param3;
            this.redraw();
         }
      }
      
      private function redraw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:Number = NaN;
         if(this._samples && this._drawnWidth > 0)
         {
            this.wave.cacheAsBitmap = false;
            this.wave.graphics.clear();
            _loc1_ = this._drawnWidth;
            _loc2_ = this.height;
            _loc3_ = this.samples.length / 2;
            this.wave.graphics.lineStyle(1,this._color);
            this.wave.graphics.beginFill(this._color);
            this.wave.graphics.moveTo(_loc1_,_loc2_ / 2);
            this.wave.graphics.lineTo(0,_loc2_ / 2);
            _loc5_ = SoundWaveformData.PIXEL_PER_SAMPLE;
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc1_ / SoundWaveformData.PIXEL_PER_SAMPLE)
            {
               if((_loc6_ = _loc7_) >= _loc3_)
               {
                  if(!this._repeat)
                  {
                     break;
                  }
                  _loc6_ %= _loc3_;
               }
               _loc4_ = UtilMath.boundaryCheck(_loc2_ / 2 - Math.abs(this.samples[2 * _loc6_]) * _loc2_ / 2,0,_loc2_);
               this.wave.graphics.lineTo(_loc7_ * _loc5_,_loc4_);
               _loc4_ = UtilMath.boundaryCheck(_loc2_ / 2 + Math.abs(this.samples[2 * _loc6_ + 1]) * _loc2_ / 2,0,_loc2_);
               this.wave.graphics.lineTo(_loc7_ * _loc5_,_loc4_);
               _loc7_++;
            }
            this.wave.graphics.endFill();
            this.wave.cacheAsBitmap = true;
            this.status.visible = false;
            this.loadingIcon.visible = false;
         }
      }
      
      protected function onCreationComplete(param1:FlexEvent) : void
      {
         this._drawnWidth = this.width + 100;
         this.redraw();
      }
      
      protected function onResize(param1:ResizeEvent) : void
      {
         if(this.width > this._drawnWidth && this._drawnWidth > 0)
         {
            this._drawnWidth = this.width + 500;
            this.redraw();
         }
         this.wave.scrollRect = new Rectangle(0,0,this.width,this.height);
         this.status.width = Math.max(0,this.width - 12 - 18);
      }
      
      public function get samples() : Array
      {
         return this._samples;
      }
      
      public function showWarning() : void
      {
         if(this.cautionIcon.visible == false)
         {
            this.status.text = UtilDict.toDisplay("go","Cannot generate waveform");
            this.cautionIcon.visible = true;
            this.loadingIcon.visible = false;
         }
      }
      
      public function ___SoundWaveformRenderer_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      public function ___SoundWaveformRenderer_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.onResize(param1);
      }
      
      private function _SoundWaveformRenderer_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Generating waveform...");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"status.text");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get cautionIcon() : Image
      {
         return this._1872564868cautionIcon;
      }
      
      public function set cautionIcon(param1:Image) : void
      {
         var _loc2_:Object = this._1872564868cautionIcon;
         if(_loc2_ !== param1)
         {
            this._1872564868cautionIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cautionIcon",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loadingIcon() : Image
      {
         return this._232221739loadingIcon;
      }
      
      public function set loadingIcon(param1:Image) : void
      {
         var _loc2_:Object = this._232221739loadingIcon;
         if(_loc2_ !== param1)
         {
            this._232221739loadingIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadingIcon",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : Label
      {
         return this._892481550status;
      }
      
      public function set status(param1:Label) : void
      {
         var _loc2_:Object = this._892481550status;
         if(_loc2_ !== param1)
         {
            this._892481550status = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"status",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wave() : Canvas
      {
         return this._3642105wave;
      }
      
      public function set wave(param1:Canvas) : void
      {
         var _loc2_:Object = this._3642105wave;
         if(_loc2_ !== param1)
         {
            this._3642105wave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wave",_loc2_,param1));
            }
         }
      }
   }
}
