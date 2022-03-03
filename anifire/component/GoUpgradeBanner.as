package anifire.component
{
   import anifire.constant.ServerConstants;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLog;
   import anifire.util.UtilNavigate;
   import anifire.util.UtilPlain;
   import anifire.util.UtilSite;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class GoUpgradeBanner extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _GoUpgradeBanner_Button1:Button;
      
      private var _3141bg:Image;
      
      private var _544786569txtMessage:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _number:Number = 1;
      
      private var _messages:Array;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function GoUpgradeBanner()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "events":{"click":"___GoUpgradeBanner_Canvas2_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "buttonMode":true,
                        "mouseChildren":false,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Image,
                           "id":"bg",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"txtMessage",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 16;
                              this.color = 16777215;
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":85,
                                 "y":5,
                                 "width":160,
                                 "height":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_GoUpgradeBanner_Button1",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":160,
                                 "height":40,
                                 "buttonMode":true,
                                 "x":90,
                                 "y":55,
                                 "styleName":"btnAddAction"
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._messages = ["Get as much as 4,000 GoBucks","Extra Text-to-speech Credits","Full Length Cartoons","Upload Images, Video and More...","Unlimited and Free Export to YouTube"];
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._GoUpgradeBanner_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_GoUpgradeBannerWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return GoUpgradeBanner[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         GoUpgradeBanner._watcherSetupUtil = param1;
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
      
      public function refresh() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            this._number = UtilPlain.randomNumberRange(1,4);
         }
         else
         {
            this._number = UtilPlain.randomNumberRange(1,5);
         }
         this.updateBanner();
      }
      
      private function updateBanner() : void
      {
         var _loc1_:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER);
         _loc1_ += "static/go/img/ad/upgrade_" + this._number + ".jpg";
         this.bg.source = _loc1_;
         this.txtMessage.text = UtilDict.toDisplay("go",this._messages[this._number - 1]);
      }
      
      private function onClick() : void
      {
         var _loc1_:String = "";
         switch(this._number)
         {
            case 1:
               _loc1_ = "bonus_gobuck";
               break;
            case 2:
               _loc1_ = "extra_tts";
               break;
            case 3:
               _loc1_ = "full_length";
               break;
            case 4:
               _loc1_ = "upload_asset";
               break;
            case 5:
               _loc1_ = "youtube_export";
         }
         UtilLog.triggerGoPlusFeature(_loc1_,this);
         UtilNavigate.toUpgradePage(_loc1_);
      }
      
      public function ___GoUpgradeBanner_Canvas2_click(param1:MouseEvent) : void
      {
         this.onClick();
      }
      
      private function _GoUpgradeBanner_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Upgrade to GoPlus");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_GoUpgradeBanner_Button1.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get bg() : Image
      {
         return this._3141bg;
      }
      
      public function set bg(param1:Image) : void
      {
         var _loc2_:Object = this._3141bg;
         if(_loc2_ !== param1)
         {
            this._3141bg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtMessage() : Text
      {
         return this._544786569txtMessage;
      }
      
      public function set txtMessage(param1:Text) : void
      {
         var _loc2_:Object = this._544786569txtMessage;
         if(_loc2_ !== param1)
         {
            this._544786569txtMessage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtMessage",_loc2_,param1));
            }
         }
      }
   }
}
