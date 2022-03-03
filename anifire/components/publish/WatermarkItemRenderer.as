package anifire.components.publish
{
   import anifire.util.UtilDict;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class WatermarkItemRenderer extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1502128937defaultWM:Image;
      
      private var _213424028watermark:Image;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _embed_mxml_style_no_watermark_png_628405828:Class;
      
      private var _embed_mxml_style_watermark_logo_swf_1012554546:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function WatermarkItemRenderer()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Image,
                  "id":"watermark",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "source":_embed_mxml_style_no_watermark_png_628405828,
                        "maxHeight":60,
                        "maxWidth":120,
                        "buttonMode":true,
                        "horizontalCenter":0,
                        "verticalCenter":0,
                        "maintainAspectRatio":true,
                        "smoothBitmapContent":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Image,
                  "id":"defaultWM",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "source":_embed_mxml_style_watermark_logo_swf_1012554546,
                        "buttonMode":true,
                        "horizontalCenter":0,
                        "verticalCenter":0,
                        "visible":false,
                        "includeInLayout":false
                     };
                  }
               })]};
            }
         });
         this._embed_mxml_style_no_watermark_png_628405828 = WatermarkItemRenderer__embed_mxml_style_no_watermark_png_628405828;
         this._embed_mxml_style_watermark_logo_swf_1012554546 = WatermarkItemRenderer__embed_mxml_style_watermark_logo_swf_1012554546;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._WatermarkItemRenderer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_publish_WatermarkItemRendererWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return WatermarkItemRenderer[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.minHeight = 100;
         this.minWidth = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         WatermarkItemRenderer._watcherSetupUtil = param1;
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
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:WatermarkData = null;
         super.data = param1;
         if(param1 is WatermarkData)
         {
            _loc2_ = param1 as WatermarkData;
            if(_loc2_.id == WatermarkManager.DEFAULT_WATERMARK_ID)
            {
               this.watermark.includeInLayout = this.watermark.visible = false;
               this.defaultWM.includeInLayout = this.defaultWM.visible = true;
            }
            else if(_loc2_.id == WatermarkManager.NO_WATERMARK_ID)
            {
               this.watermark.toolTip = UtilDict.toDisplay("go","Use no watermark");
            }
            else
            {
               this.watermark.source = _loc2_.url;
            }
         }
      }
      
      private function _WatermarkItemRenderer_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","GoAnimate");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"defaultWM.toolTip");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get defaultWM() : Image
      {
         return this._1502128937defaultWM;
      }
      
      public function set defaultWM(param1:Image) : void
      {
         var _loc2_:Object = this._1502128937defaultWM;
         if(_loc2_ !== param1)
         {
            this._1502128937defaultWM = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"defaultWM",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get watermark() : Image
      {
         return this._213424028watermark;
      }
      
      public function set watermark(param1:Image) : void
      {
         var _loc2_:Object = this._213424028watermark;
         if(_loc2_ !== param1)
         {
            this._213424028watermark = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"watermark",_loc2_,param1));
            }
         }
      }
   }
}
