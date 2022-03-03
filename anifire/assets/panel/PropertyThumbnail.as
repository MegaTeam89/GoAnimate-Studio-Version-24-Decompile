package anifire.assets.panel
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetView;
   import anifire.scene.view.SceneThumbnail;
   import mx.containers.Canvas;
   import mx.containers.ViewStack;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class PropertyThumbnail extends Canvas
   {
       
      
      private var _1693766620assetThumbnail:AssetThumbnail;
      
      private var _563989056sceneThumbnail:SceneThumbnail;
      
      private var _3773vs:ViewStack;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function PropertyThumbnail()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"vs",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 14540253;
                     this.cornerRadius = 10;
                     this.borderColor = 14540253;
                     this.borderStyle = "solid";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":SceneThumbnail,
                        "id":"sceneThumbnail"
                     }),new UIComponentDescriptor({
                        "type":AssetThumbnail,
                        "id":"assetThumbnail"
                     })]};
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
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set target(param1:Object) : void
      {
         var _loc2_:IAsset = null;
         if(param1 is IAssetView)
         {
            _loc2_ = IAssetView(param1).asset;
         }
         if(param1 is AnimeScene)
         {
            this.sceneThumbnail.target = param1;
            this.vs.selectedChild = this.sceneThumbnail;
         }
         else if(Console.getConsole().metaData.mver > 3 && _loc2_ is EffectAsset)
         {
            this.sceneThumbnail.target = EffectAsset(_loc2_).scene;
            this.vs.selectedChild = this.sceneThumbnail;
         }
         else
         {
            this.assetThumbnail.target = param1;
            this.vs.selectedChild = this.assetThumbnail;
         }
         this.visible = param1 != null;
      }
      
      [Bindable(event="propertyChange")]
      public function get assetThumbnail() : AssetThumbnail
      {
         return this._1693766620assetThumbnail;
      }
      
      public function set assetThumbnail(param1:AssetThumbnail) : void
      {
         var _loc2_:Object = this._1693766620assetThumbnail;
         if(_loc2_ !== param1)
         {
            this._1693766620assetThumbnail = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"assetThumbnail",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sceneThumbnail() : SceneThumbnail
      {
         return this._563989056sceneThumbnail;
      }
      
      public function set sceneThumbnail(param1:SceneThumbnail) : void
      {
         var _loc2_:Object = this._563989056sceneThumbnail;
         if(_loc2_ !== param1)
         {
            this._563989056sceneThumbnail = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneThumbnail",_loc2_,param1));
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
