package anifire.scene.view
{
   import anifire.assets.image.EffectAssetImage;
   import anifire.assets.view.AssetViewFactory;
   import anifire.constant.AnimeConstants;
   import anifire.core.EffectAsset;
   import anifire.core.EffectThumb;
   import anifire.events.AssetViewEvent;
   import anifire.events.SceneEvent;
   import anifire.events.SceneViewEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.ISceneModel;
   import anifire.iterators.ArrayIterator;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class ScenePreview extends AbstractSceneView implements ICollection, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _2041073964cameraLayer:Canvas;
      
      private var _1643150912effectLayer:Canvas;
      
      private var _269120744mainLayer:Canvas;
      
      private var _3619493view:SceneView;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _assetViewFactory:AssetViewFactory;
      
      private var _isLoadingAssets:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function ScenePreview()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":AbstractSceneView,
            "events":{"creationComplete":"___ScenePreview_AbstractSceneView1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"mainLayer",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "clipContent":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.backgroundColor = 52326;
                              this.backgroundAlpha = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "name":"editorBg",
                                 "percentWidth":100,
                                 "percentHeight":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":SceneView,
                           "id":"view"
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"effectLayer",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "mouseChildren":false,
                                 "mouseEnabled":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"cameraLayer"
                        })]
                     };
                  }
               })]};
            }
         });
         this._assetViewFactory = new AssetViewFactory();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._ScenePreview_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_scene_view_ScenePreviewWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return ScenePreview[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.clipContent = false;
         this.addEventListener("creationComplete",this.___ScenePreview_AbstractSceneView1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         ScenePreview._watcherSetupUtil = param1;
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
      
      override public function set sceneModel(param1:ISceneModel) : void
      {
         super.sceneModel = param1;
         this.view.sceneModel = param1;
      }
      
      private function onCreationComplete() : void
      {
         this.cameraLayer.addEventListener(AssetViewEvent.VIEW_CHANGE,this.onCameraChange);
      }
      
      private function onCameraChange(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         if(this._isLoadingAssets)
         {
            return;
         }
         this.dispatchEvent(new SceneViewEvent(SceneViewEvent.VIEW_CHANGE,true));
      }
      
      override protected function addEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(SceneEvent.ASSET_ADDED,this.onAssetAdded);
            param1.addEventListener(SceneEvent.ASSET_REMOVED,this.onAssetRemoved);
         }
      }
      
      override protected function removeEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(SceneEvent.ASSET_ADDED,this.onAssetAdded);
            param1.removeEventListener(SceneEvent.ASSET_REMOVED,this.onAssetRemoved);
         }
      }
      
      override protected function unloadAllAssets() : void
      {
         var _loc1_:IAssetView = null;
         var _loc2_:Number = NaN;
         super.unloadAllAssets();
         this._isLoadingAssets = false;
         _loc2_ = 0;
         while(_loc2_ < this.effectLayer.numChildren)
         {
            _loc1_ = IAssetView(this.effectLayer.getChildAt(_loc2_));
            _loc1_.destroy("unloaded from ScenePreview");
            _loc2_++;
         }
         this.effectLayer.removeAllChildren();
         _loc2_ = 0;
         while(_loc2_ < this.cameraLayer.numChildren)
         {
            _loc1_ = IAssetView(this.cameraLayer.getChildAt(_loc2_));
            _loc1_.destroy("unloaded from ScenePreview");
            _loc2_++;
         }
         this.cameraLayer.removeAllChildren();
      }
      
      override protected function loadAllAssets() : void
      {
         var _loc1_:IIterator = null;
         var _loc2_:IAsset = null;
         super.loadAllAssets();
         if(!this._isLoadingAssets && this.sceneModel)
         {
            this._isLoadingAssets = true;
            _loc1_ = this.sceneModel.iterator("effect");
            while(_loc1_.hasNext)
            {
               _loc2_ = _loc1_.next as IAsset;
               this.addAsset(_loc2_);
            }
            this._isLoadingAssets = false;
         }
      }
      
      private function onAssetAdded(param1:SceneEvent) : void
      {
         if(param1 && param1.asset)
         {
            this.addAsset(param1.asset);
         }
      }
      
      private function addAsset(param1:IAsset) : void
      {
         var _loc2_:IAssetView = null;
         if(param1 is EffectAsset)
         {
            _loc2_ = this._assetViewFactory.createAssetView(param1);
            if(_loc2_)
            {
               if(EffectAsset(param1).getExactType() == EffectThumb.TYPE_ZOOM)
               {
                  this.cameraLayer.addChild(_loc2_ as DisplayObject);
                  if(_loc2_ is UIComponent)
                  {
                     UIComponent(_loc2_).buttonMode = true;
                  }
               }
               else
               {
                  this.effectLayer.addChild(_loc2_ as DisplayObject);
               }
               _loc2_.loadImage();
               if(_loc2_.assetImage is EffectAssetImage)
               {
                  EffectAssetImage(_loc2_.assetImage).showEffect(this.mainLayer);
               }
            }
         }
      }
      
      private function onAssetRemoved(param1:SceneEvent) : void
      {
         if(param1 && param1.asset)
         {
            this.removeAsset(param1.asset);
         }
      }
      
      private function removeAsset(param1:IAsset) : void
      {
         var _loc2_:IAssetView = null;
         var _loc3_:Number = NaN;
         if(param1 is EffectAsset)
         {
            _loc3_ = 0;
            while(_loc3_ < this.effectLayer.numChildren)
            {
               _loc2_ = IAssetView(this.effectLayer.getChildAt(_loc3_));
               if(_loc2_.asset == param1)
               {
                  _loc2_.destroy("asset removed from ScenePreview");
                  this.effectLayer.removeChildAt(_loc3_);
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.cameraLayer.numChildren)
            {
               _loc2_ = IAssetView(this.cameraLayer.getChildAt(_loc3_));
               if(_loc2_.asset == param1)
               {
                  _loc2_.destroy("asset removed from ScenePreview");
                  this.cameraLayer.removeChildAt(_loc3_);
                  this.dispatchEvent(new SceneViewEvent(SceneViewEvent.VIEW_CHANGE,true));
               }
               _loc3_++;
            }
         }
      }
      
      public function pause() : void
      {
         var _loc1_:IAssetView = null;
         var _loc2_:Number = NaN;
         this.view.pause();
         _loc2_ = 0;
         while(_loc2_ < this.effectLayer.numChildren)
         {
            _loc1_ = IAssetView(this.effectLayer.getChildAt(_loc2_));
            _loc1_.pause();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.cameraLayer.numChildren)
         {
            _loc1_ = IAssetView(this.cameraLayer.getChildAt(_loc2_));
            _loc1_.pause();
            _loc2_++;
         }
      }
      
      public function resume() : void
      {
         var _loc1_:IAssetView = null;
         var _loc2_:Number = NaN;
         this.view.resume();
         _loc2_ = 0;
         while(_loc2_ < this.effectLayer.numChildren)
         {
            _loc1_ = IAssetView(this.effectLayer.getChildAt(_loc2_));
            _loc1_.resume();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.cameraLayer.numChildren)
         {
            _loc1_ = IAssetView(this.cameraLayer.getChildAt(_loc2_));
            _loc1_.resume();
            _loc2_++;
         }
      }
      
      public function hideAllEffect() : void
      {
         this.cameraLayer.visible = this.effectLayer.visible = false;
      }
      
      public function showAllEffect() : void
      {
         this.cameraLayer.visible = this.effectLayer.visible = true;
      }
      
      public function hideEffect(param1:IAsset) : void
      {
         var _loc2_:IAssetView = null;
         var _loc3_:Number = NaN;
         _loc3_ = 0;
         while(_loc3_ < this.effectLayer.numChildren)
         {
            _loc2_ = IAssetView(this.effectLayer.getChildAt(_loc3_));
            if(_loc2_.asset == param1)
            {
               DisplayObject(_loc2_).visible = false;
               return;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.cameraLayer.numChildren)
         {
            _loc2_ = IAssetView(this.cameraLayer.getChildAt(_loc3_));
            if(_loc2_.asset == param1)
            {
               DisplayObject(_loc2_).visible = false;
               return;
            }
            _loc3_++;
         }
      }
      
      public function showEffect(param1:IAsset) : void
      {
         var _loc2_:IAssetView = null;
         var _loc3_:Number = NaN;
         _loc3_ = 0;
         while(_loc3_ < this.effectLayer.numChildren)
         {
            _loc2_ = IAssetView(this.effectLayer.getChildAt(_loc3_));
            if(_loc2_.asset == param1)
            {
               DisplayObject(_loc2_).visible = true;
               if(_loc2_.assetImage is EffectAssetImage)
               {
                  EffectAssetImage(_loc2_.assetImage).showEffect(this.mainLayer);
               }
               return;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.cameraLayer.numChildren)
         {
            _loc2_ = IAssetView(this.cameraLayer.getChildAt(_loc3_));
            if(_loc2_.asset == param1)
            {
               DisplayObject(_loc2_).visible = true;
               return;
            }
            _loc3_++;
         }
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         var _loc2_:Array = new Array();
         var _loc3_:IIterator = this.view.iterator(param1);
         while(_loc3_.hasNext)
         {
            _loc2_.push(_loc3_.next);
         }
         var _loc4_:uint = 0;
         if(param1 != "asset")
         {
            _loc4_ = 0;
            while(_loc4_ < this.effectLayer.numChildren)
            {
               _loc2_.push(this.effectLayer.getChildAt(_loc4_));
               _loc4_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < this.cameraLayer.numChildren)
         {
            _loc2_.push(this.cameraLayer.getChildAt(_loc4_));
            _loc4_++;
         }
         return new ArrayIterator(_loc2_);
      }
      
      public function ___ScenePreview_AbstractSceneView1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      private function _ScenePreview_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_WIDTH;
         },null,"this.width");
         result[1] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_HEIGHT;
         },null,"this.height");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get cameraLayer() : Canvas
      {
         return this._2041073964cameraLayer;
      }
      
      public function set cameraLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._2041073964cameraLayer;
         if(_loc2_ !== param1)
         {
            this._2041073964cameraLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cameraLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get effectLayer() : Canvas
      {
         return this._1643150912effectLayer;
      }
      
      public function set effectLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1643150912effectLayer;
         if(_loc2_ !== param1)
         {
            this._1643150912effectLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effectLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainLayer() : Canvas
      {
         return this._269120744mainLayer;
      }
      
      public function set mainLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._269120744mainLayer;
         if(_loc2_ !== param1)
         {
            this._269120744mainLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get view() : SceneView
      {
         return this._3619493view;
      }
      
      public function set view(param1:SceneView) : void
      {
         var _loc2_:Object = this._3619493view;
         if(_loc2_ !== param1)
         {
            this._3619493view = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"view",_loc2_,param1));
            }
         }
      }
   }
}
