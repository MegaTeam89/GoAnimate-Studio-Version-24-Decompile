package anifire.playerComponent
{
   import anifire.constant.ServerConstants;
   import anifire.playback.PlayerEvent;
   import anifire.util.Util;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   import mx.utils.StringUtil;
   
   public class PlayerWatermark extends Canvas
   {
       
      
      private var _1581931332customLogo:Image;
      
      private var _437188724defaultLogo:Button;
      
      private var _1915233234licensorLogo:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _PlayerWatermark_StylesInit_done:Boolean = false;
      
      private var _embed_css__styles_player_watermark_new_swf__2042183570_1311154089:Class;
      
      public function PlayerWatermark()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___PlayerWatermark_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":550,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Button,
                     "id":"defaultLogo",
                     "events":{"click":"__defaultLogo_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnLogo",
                           "left":5,
                           "bottom":5,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Image,
                     "id":"customLogo",
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "bottom";
                        this.horizontalAlign = "left";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "left":5,
                           "bottom":5,
                           "maxHeight":40,
                           "maxWidth":100,
                           "maintainAspectRatio":true,
                           "smoothBitmapContent":true,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"licensorLogo",
                     "events":{"click":"__licensorLogo_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnLicensorLogo",
                           "x":400,
                           "y":310
                        };
                     }
                  })]
               };
            }
         });
         this._embed_css__styles_player_watermark_new_swf__2042183570_1311154089 = _class_embed_css__styles_player_watermark_new_swf__2042183570_1311154089;
         super();
         mx_internal::_document = this;
         this.width = 550;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___PlayerWatermark_Canvas1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_PlayerWatermark_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onCreationComplete() : void
      {
         if(Util.isVideoRecording())
         {
            this.defaultLogo.styleName = "goLogoNew";
         }
      }
      
      public function loadDefaultLogo() : void
      {
         this.defaultLogo.visible = true;
      }
      
      public function loadCustomLogoByUrl(param1:String) : void
      {
         this.customLogo.source = param1;
         this.customLogo.visible = true;
      }
      
      public function loadCustomLogoByAssetId(param1:String) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         if(param1)
         {
            param1 = StringUtil.trim(param1);
            if(param1.length > 0)
            {
               _loc2_ = new URLVariables();
               Util.addFlashVarsToURLvar(_loc2_);
               if(_loc2_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
               {
                  delete _loc2_[ServerConstants.PARAM_ASSET_ID];
               }
               _loc2_[ServerConstants.PARAM_ASSET_ID] = param1;
               _loc3_ = new URLRequest(ServerConstants.ACTION_GET_ASSET);
               _loc3_.method = URLRequestMethod.POST;
               _loc3_.data = _loc2_;
               (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this.onLoadLogoComplete);
               _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadLogoFail);
               _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadLogoFail);
               _loc4_.load(_loc3_);
            }
         }
      }
      
      private function onLoadLogoComplete(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(Event.COMPLETE,this.onLoadLogoComplete);
         IEventDispatcher(param1.target).removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadLogoFail);
         IEventDispatcher(param1.target).removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadLogoFail);
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         this.customLogo.source = _loc3_;
         this.customLogo.visible = true;
      }
      
      private function onLoadLogoFail(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(Event.COMPLETE,this.onLoadLogoComplete);
         IEventDispatcher(param1.target).removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadLogoFail);
         IEventDispatcher(param1.target).removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadLogoFail);
      }
      
      private function onLogoClick() : void
      {
         var _loc1_:PlayerEvent = new PlayerEvent(PlayerEvent.LOGO_CLICK,null,true);
         this.dispatchEvent(_loc1_);
      }
      
      public function turnOnLogo(param1:Boolean) : void
      {
         this.defaultLogo.buttonMode = param1;
         this.defaultLogo.enabled = param1;
         this.licensorLogo.buttonMode = param1;
         this.licensorLogo.enabled = param1;
      }
      
      public function ___PlayerWatermark_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function __defaultLogo_click(param1:MouseEvent) : void
      {
         this.onLogoClick();
      }
      
      public function __licensorLogo_click(param1:MouseEvent) : void
      {
         this.onLogoClick();
      }
      
      mx_internal function _PlayerWatermark_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_PlayerWatermark_StylesInit_done)
         {
            return;
         }
         mx_internal::_PlayerWatermark_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".goLogoNew");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".goLogoNew",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.upSkin = _embed_css__styles_player_watermark_new_swf__2042183570_1311154089;
               this.downSkin = _embed_css__styles_player_watermark_new_swf__2042183570_1311154089;
               this.overSkin = _embed_css__styles_player_watermark_new_swf__2042183570_1311154089;
               this.disabledSkin = _embed_css__styles_player_watermark_new_swf__2042183570_1311154089;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get customLogo() : Image
      {
         return this._1581931332customLogo;
      }
      
      public function set customLogo(param1:Image) : void
      {
         var _loc2_:Object = this._1581931332customLogo;
         if(_loc2_ !== param1)
         {
            this._1581931332customLogo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"customLogo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get defaultLogo() : Button
      {
         return this._437188724defaultLogo;
      }
      
      public function set defaultLogo(param1:Button) : void
      {
         var _loc2_:Object = this._437188724defaultLogo;
         if(_loc2_ !== param1)
         {
            this._437188724defaultLogo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"defaultLogo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get licensorLogo() : Button
      {
         return this._1915233234licensorLogo;
      }
      
      public function set licensorLogo(param1:Button) : void
      {
         var _loc2_:Object = this._1915233234licensorLogo;
         if(_loc2_ !== param1)
         {
            this._1915233234licensorLogo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"licensorLogo",_loc2_,param1));
            }
         }
      }
   }
}
