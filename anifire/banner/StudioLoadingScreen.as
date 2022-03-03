package anifire.banner
{
   import anifire.util.UtilDict;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   import flash.display.Sprite;
   import mx.containers.Canvas;
   import mx.containers.ViewStack;
   import mx.controls.Image;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class StudioLoadingScreen extends Canvas
   {
       
      
      private var _354953208bannerHolder:Canvas;
      
      private var _3773vs:ViewStack;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _embed_mxml_images_loading_swf_162774498:Class;
      
      public function StudioLoadingScreen()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___StudioLoadingScreen_Canvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.backgroundAlpha = 0.5;
               this.backgroundColor = 0;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"vs",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "source":_embed_mxml_images_loading_swf_162774498,
                                          "horizontalCenter":0,
                                          "verticalCenter":0
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"bannerHolder",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._embed_mxml_images_loading_swf_162774498 = StudioLoadingScreen__embed_mxml_images_loading_swf_162774498;
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___StudioLoadingScreen_Canvas1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundAlpha = 0.5;
            this.backgroundColor = 0;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onCreationComplete() : void
      {
         var _loc1_:UIComponent = null;
         var _loc2_:Sprite = null;
         if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
         {
            this.vs.selectedIndex = 1;
            _loc1_ = new UIComponent();
            _loc1_.width = 620;
            _loc1_.height = 370;
            _loc1_.horizontalCenter = 0;
            _loc1_.verticalCenter = 0;
            this.bannerHolder.addChild(_loc1_);
            if(UtilUser.userType == UtilUser.BASIC_USER)
            {
               if(Math.random() < 0.3)
               {
                  _loc2_ = new GoPlusBanner();
                  GoPlusBanner(_loc2_).init(UtilSite.tlang);
                  GoPlusBanner(_loc2_).statusText = UtilDict.toDisplay("go","Initializing") + " ...";
                  _loc1_.addChild(_loc2_);
               }
               else if(Math.random() < 0.6)
               {
                  _loc2_ = new GoBusinessBanner();
                  GoBusinessBanner(_loc2_).init(UtilSite.tlang);
                  GoBusinessBanner(_loc2_).statusText = UtilDict.toDisplay("go","Initializing") + " ...";
                  _loc1_.addChild(_loc2_);
               }
               else
               {
                  _loc2_ = new GoSchoolBanner();
                  GoSchoolBanner(_loc2_).init(UtilSite.tlang);
                  GoSchoolBanner(_loc2_).statusText = UtilDict.toDisplay("go","Initializing") + " ...";
                  _loc1_.addChild(_loc2_);
               }
            }
            else if(UtilUser.userType == UtilUser.PLUS_USER)
            {
               if(Math.random() < 0.5)
               {
                  _loc2_ = new GoBusinessBanner();
                  GoBusinessBanner(_loc2_).init(UtilSite.tlang);
                  GoBusinessBanner(_loc2_).statusText = UtilDict.toDisplay("go","Initializing") + " ...";
                  _loc1_.addChild(_loc2_);
               }
               else
               {
                  _loc2_ = new GoSchoolBanner();
                  GoSchoolBanner(_loc2_).init(UtilSite.tlang);
                  GoSchoolBanner(_loc2_).statusText = UtilDict.toDisplay("go","Initializing") + " ...";
                  _loc1_.addChild(_loc2_);
               }
            }
            else
            {
               this.vs.selectedIndex = 0;
            }
         }
      }
      
      public function ___StudioLoadingScreen_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      [Bindable(event="propertyChange")]
      public function get bannerHolder() : Canvas
      {
         return this._354953208bannerHolder;
      }
      
      public function set bannerHolder(param1:Canvas) : void
      {
         var _loc2_:Object = this._354953208bannerHolder;
         if(_loc2_ !== param1)
         {
            this._354953208bannerHolder = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bannerHolder",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get vs() : ViewStack
      {
         return this._3773vs;
      }
      
      public function set vs(param1:ViewStack) : void
      {
         var _loc2_:Object = this._3773vs;
         if(_loc2_ !== param1)
         {
            this._3773vs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vs",_loc2_,param1));
            }
         }
      }
   }
}
