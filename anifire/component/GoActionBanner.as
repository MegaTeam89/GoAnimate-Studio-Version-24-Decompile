package anifire.component
{
   import anifire.core.CharThumb;
   import anifire.util.UtilDict;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class GoActionBanner extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _GoActionBanner_Button1:Button;
      
      private var _1290634255_actionNum:Label;
      
      private var _1312128075_banner:Canvas;
      
      private var _94436_bg:Image;
      
      private var _91078603_mask:Canvas;
      
      private var _840813987_packName:Label;
      
      private var _1282133823fadeIn:Fade;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _thumb:CharThumb;
      
      mx_internal var _GoActionBanner_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function GoActionBanner()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___GoActionBanner_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_banner",
                  "effects":["showEffect"],
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "buttonMode":true,
                        "mouseChildren":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_mask"
                        }),new UIComponentDescriptor({
                           "type":Image,
                           "id":"_bg",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_packName",
                           "stylesFactory":function():void
                           {
                              this.textAlign = "right";
                              this.fontSize = 18;
                              this.fontWeight = "bold";
                              this.color = 16777215;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "right":5
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_actionNum",
                           "stylesFactory":function():void
                           {
                              this.textAlign = "right";
                              this.fontSize = 12;
                              this.color = 16777215;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "top":25,
                                 "percentWidth":100,
                                 "right":5
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_GoActionBanner_Button1",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "maxWidth":170,
                                 "buttonMode":true,
                                 "top":65,
                                 "right":5,
                                 "styleName":"btnAddAction"
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._GoActionBanner_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_GoActionBannerWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return GoActionBanner[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this._GoActionBanner_Fade1_i();
         this.addEventListener("creationComplete",this.___GoActionBanner_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         GoActionBanner._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_GoActionBanner_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function init() : void
      {
      }
      
      public function refresh(param1:CharThumb) : void
      {
         if(param1)
         {
            this._thumb = param1;
            if(param1.actionpackXml)
            {
               this.updateBanner(param1.actionpackXml);
            }
            else
            {
               this._banner.includeInLayout = this._banner.visible = false;
               this.loadActionPacksXml(param1.id);
            }
         }
      }
      
      private function loadActionPacksXml(param1:String) : void
      {
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.onXmlLoaded);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadXmlFail);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadXmlFail);
         _loc2_.load(UtilNetwork.getActionPacksRequest(param1));
      }
      
      private function onLoadXmlFail(param1:Event) : void
      {
      }
      
      private function onXmlLoaded(param1:Event) : void
      {
         var _loc3_:XML = null;
         var _loc2_:String = String(param1.target.data).charAt();
         if(_loc2_ == "0")
         {
            _loc3_ = new XML(String(param1.target.data).substring(1));
            this._thumb.actionpackXml = _loc3_;
            this.updateBanner(_loc3_);
         }
      }
      
      private function updateBanner(param1:XML) : void
      {
         var packs:XMLList = null;
         var myPack:XML = null;
         var url:String = null;
         var regularExp:RegExp = null;
         var xml:XML = param1;
         if(xml)
         {
            packs = xml.pack.(@sold == "0");
            if(packs.length() > 0)
            {
               myPack = packs[UtilPlain.randomNumberRange(0,packs.length() - 1)];
               url = myPack.image;
               regularExp = /.jpg/g;
               url = url.replace(regularExp,"_studio.jpg");
               this._bg.source = url;
               this._packName.text = UtilDict.toDisplay("store",String(myPack.title));
               this._actionNum.text = "x" + myPack..action.length() + " " + UtilDict.toDisplay("go","Actions");
               this._banner.includeInLayout = this._banner.visible = true;
            }
         }
      }
      
      private function _GoActionBanner_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         this.fadeIn = _loc1_;
         BindingManager.executeBindings(this,"fadeIn",this.fadeIn);
         return _loc1_;
      }
      
      public function ___GoActionBanner_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function _GoActionBanner_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,null,function(param1:*):void
         {
            _banner.setStyle("showEffect",param1);
         },"_banner.showEffect","fadeIn");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add more actions");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_GoActionBanner_Button1.label");
         return result;
      }
      
      mx_internal function _GoActionBanner_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_GoActionBanner_StylesInit_done)
         {
            return;
         }
         mx_internal::_GoActionBanner_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".btnAddAction");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnAddAction",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.borderColor = 13395456;
               this.color = 16777215;
               this.cornerRadius = 5;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontSize = 15;
               this.fillColors = [16737792,16737792,16737792,16737792];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 16737792;
               this.textSelectedColor = 16777215;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _actionNum() : Label
      {
         return this._1290634255_actionNum;
      }
      
      public function set _actionNum(param1:Label) : void
      {
         var _loc2_:Object = this._1290634255_actionNum;
         if(_loc2_ !== param1)
         {
            this._1290634255_actionNum = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_actionNum",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _banner() : Canvas
      {
         return this._1312128075_banner;
      }
      
      public function set _banner(param1:Canvas) : void
      {
         var _loc2_:Object = this._1312128075_banner;
         if(_loc2_ !== param1)
         {
            this._1312128075_banner = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_banner",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Image
      {
         return this._94436_bg;
      }
      
      public function set _bg(param1:Image) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _mask() : Canvas
      {
         return this._91078603_mask;
      }
      
      public function set _mask(param1:Canvas) : void
      {
         var _loc2_:Object = this._91078603_mask;
         if(_loc2_ !== param1)
         {
            this._91078603_mask = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mask",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _packName() : Label
      {
         return this._840813987_packName;
      }
      
      public function set _packName(param1:Label) : void
      {
         var _loc2_:Object = this._840813987_packName;
         if(_loc2_ !== param1)
         {
            this._840813987_packName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_packName",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
            }
         }
      }
   }
}
