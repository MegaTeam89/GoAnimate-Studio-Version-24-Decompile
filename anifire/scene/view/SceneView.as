package anifire.scene.view
{
   import anifire.assets.view.AssetViewFactory;
   import anifire.component.ProcessRegulator;
   import anifire.constant.AnimeConstants;
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.Prop;
   import anifire.events.AssetViewEvent;
   import anifire.events.SceneEvent;
   import anifire.events.SceneViewEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
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
   
   public class SceneView extends AbstractSceneView implements ICollection, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _2111656001assetLayer:Canvas;
      
      private var _196953076bgLayer:Canvas;
      
      private var _269120744mainLayer:Canvas;
      
      private var _1914646001sceneBg:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _assetViewFactory:AssetViewFactory;
      
      private var _isLoadingAssets:Boolean = false;
      
      private var _regulator:ProcessRegulator;
      
      private var _lastAssetView:IAssetView;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SceneView()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":AbstractSceneView,
            "events":{"creationComplete":"___SceneView_AbstractSceneView1_creationComplete"},
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
                           "id":"sceneBg",
                           "stylesFactory":function():void
                           {
                              this.backgroundColor = 16777215;
                              this.backgroundAlpha = 1;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"name":"sceneBg"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"bgLayer"
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"assetLayer",
                           "propertiesFactory":function():Object
                           {
                              return {"clipContent":false};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._assetViewFactory = new AssetViewFactory();
         this._regulator = new ProcessRegulator();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SceneView_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_scene_view_SceneViewWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SceneView[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.clipContent = false;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___SceneView_AbstractSceneView1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SceneView._watcherSetupUtil = param1;
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
      
      private function onCreationComplete() : void
      {
         this.mainLayer.addEventListener(AssetViewEvent.VIEW_CHANGE,this.onAssetViewChange);
      }
      
      public function get lastAssetView() : IAssetView
      {
         return this._lastAssetView;
      }
      
      private function onAssetViewChange(param1:AssetViewEvent) : void
      {
         param1.stopImmediatePropagation();
         if(this._isLoadingAssets)
         {
            return;
         }
         this.validateNow();
         this.dispatchEvent(new SceneViewEvent(SceneViewEvent.VIEW_CHANGE,true));
      }
      
      override protected function addEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(SceneEvent.ASSET_ADDED,this.onAssetAdded);
            param1.addEventListener(SceneEvent.ASSET_REMOVED,this.onAssetRemoved);
            param1.addEventListener(SceneEvent.ASSET_ORDER_CHANGE,this.onAssetOrderChange);
         }
      }
      
      override protected function removeEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(SceneEvent.ASSET_ADDED,this.onAssetAdded);
            param1.removeEventListener(SceneEvent.ASSET_REMOVED,this.onAssetRemoved);
            param1.removeEventListener(SceneEvent.ASSET_ORDER_CHANGE,this.onAssetOrderChange);
         }
      }
      
      override protected function unloadAllAssets() : void
      {
         var _loc1_:IAssetView = null;
         var _loc2_:Number = NaN;
         super.unloadAllAssets();
         this._isLoadingAssets = false;
         this._regulator.removeEventListener(Event.COMPLETE,this.onLoadAllAssetsComplete);
         _loc2_ = 0;
         while(_loc2_ < this.bgLayer.numChildren)
         {
            _loc1_ = IAssetView(this.bgLayer.getChildAt(_loc2_));
            _loc1_.destroy("unloaded from SceneView");
            _loc2_++;
         }
         this.bgLayer.removeAllChildren();
         _loc2_ = 0;
         while(_loc2_ < this.assetLayer.numChildren)
         {
            _loc1_ = IAssetView(this.assetLayer.getChildAt(_loc2_));
            _loc1_.destroy("unloaded from SceneView");
            _loc2_++;
         }
         this.assetLayer.removeAllChildren();
      }
      
      override protected function loadAllAssets() : void
      {
         var _loc1_:IAssetView = null;
         var _loc2_:IIterator = null;
         var _loc3_:IAsset = null;
         var _loc4_:IIterator = null;
         var _loc5_:uint = 0;
         super.loadAllAssets();
         if(!this._isLoadingAssets && this.sceneModel)
         {
            this._isLoadingAssets = true;
            this.visible = false;
            this._regulator.reset();
            this._regulator.addEventListener(Event.COMPLETE,this.onLoadAllAssetsComplete);
            _loc2_ = this.sceneModel.iterator("bg");
            while(_loc2_.hasNext)
            {
               _loc3_ = _loc2_.next as IAsset;
               _loc1_ = this.addAsset(_loc3_);
               this._regulator.addProcess(_loc1_,AssetViewEvent.VIEW_LOAD_COMPLETE);
            }
            _loc2_ = this.sceneModel.iterator("asset");
            _loc4_ = this.sceneModel.iterator("asset");
            _loc5_ = 0;
            while(_loc2_.hasNext)
            {
               _loc3_ = _loc2_.next as IAsset;
               while(_loc4_.hasNext)
               {
                  _loc3_ = _loc4_.next as IAsset;
                  if(_loc5_ == this.sceneModel.getAssetOrdering(_loc3_))
                  {
                     _loc1_ = this.addAsset(_loc3_);
                     this._regulator.addProcess(_loc1_,AssetViewEvent.VIEW_LOAD_COMPLETE);
                     break;
                  }
               }
               _loc4_.reset();
               _loc5_++;
            }
            this._regulator.startProcess();
         }
      }
      
      private function onLoadAllAssetsComplete(param1:Event) : void
      {
         this._isLoadingAssets = false;
         this.validateNow();
         this.visible = true;
         this.dispatchEvent(new SceneViewEvent(SceneViewEvent.VIEW_LOAD_COMPLETE,true));
      }
      
      private function onAssetAdded(param1:SceneEvent) : void
      {
         var _loc2_:IAssetView = null;
         if(param1 && param1.asset)
         {
            _loc2_ = this.addAsset(param1.asset);
            if(_loc2_)
            {
               _loc2_.addEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onAssetViewLoadComplete);
               _loc2_.loadImage();
            }
         }
      }
      
      private function onAssetViewLoadComplete(param1:AssetViewEvent) : void
      {
         IEventDispatcher(param1.currentTarget).removeEventListener(param1.type,this.onAssetViewLoadComplete);
         this._lastAssetView = param1.currentTarget as IAssetView;
         this.dispatchEvent(new SceneViewEvent(SceneViewEvent.ASSET_VIEW_ADDED,true));
      }
      
      private function addAsset(param1:IAsset) : IAssetView
      {
         var _loc2_:IAssetView = null;
         var _loc3_:int = 0;
         if(param1 is Background || param1 is Prop || param1 is Character || param1 is BubbleAsset)
         {
            _loc2_ = this._assetViewFactory.createAssetView(param1);
            if(_loc2_)
            {
               if(param1 is Background)
               {
                  this.bgLayer.removeAllChildren();
                  this.bgLayer.addChild(_loc2_ as DisplayObject);
               }
               else
               {
                  _loc3_ = this.assetLayer.numChildren;
                  if(this.sceneModel)
                  {
                     _loc3_ = this.sceneModel.getAssetOrdering(param1);
                  }
                  if(_loc3_ >= 0 && _loc3_ <= this.assetLayer.numChildren)
                  {
                     this.assetLayer.addChildAt(_loc2_ as DisplayObject,_loc3_);
                  }
                  if(_loc2_ is UIComponent)
                  {
                     UIComponent(_loc2_).buttonMode = true;
                  }
               }
               return _loc2_;
            }
         }
         return null;
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
         if(param1 is Background || param1 is Prop || param1 is Character || param1 is BubbleAsset)
         {
            if(param1 is Background)
            {
               _loc3_ = 0;
               while(_loc3_ < this.bgLayer.numChildren)
               {
                  _loc2_ = IAssetView(this.bgLayer.getChildAt(_loc3_));
                  if(_loc2_.asset == param1)
                  {
                     _loc2_.destroy("asset removed from SceneView");
                     this.bgLayer.removeChildAt(_loc3_);
                  }
                  _loc3_++;
               }
            }
            else
            {
               _loc3_ = 0;
               while(_loc3_ < this.assetLayer.numChildren)
               {
                  _loc2_ = IAssetView(this.assetLayer.getChildAt(_loc3_));
                  if(_loc2_.asset == param1)
                  {
                     _loc2_.destroy("asset removed from SceneView");
                     this.assetLayer.removeChildAt(_loc3_);
                  }
                  _loc3_++;
               }
            }
            this.validateNow();
            this.dispatchEvent(new SceneViewEvent(SceneViewEvent.VIEW_CHANGE,true));
         }
      }
      
      private function reorderAsset(param1:IAsset) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IAssetView = null;
         var _loc4_:Number = NaN;
         if(param1 is Prop || param1 is Character || param1 is BubbleAsset)
         {
            if(this.sceneModel)
            {
               _loc2_ = this.sceneModel.getAssetOrdering(param1);
               if(_loc2_ >= 0 && _loc2_ <= this.assetLayer.numChildren)
               {
                  _loc4_ = 0;
                  while(_loc4_ < this.assetLayer.numChildren)
                  {
                     _loc3_ = IAssetView(this.assetLayer.getChildAt(_loc4_));
                     if(_loc3_.asset == param1)
                     {
                        this.assetLayer.addChildAt(_loc3_ as DisplayObject,_loc2_);
                     }
                     _loc4_++;
                  }
                  this.validateNow();
                  this.dispatchEvent(new SceneViewEvent(SceneViewEvent.VIEW_CHANGE,true));
               }
            }
         }
      }
      
      private function onAssetOrderChange(param1:SceneEvent) : void
      {
         if(param1 && param1.asset)
         {
            this.reorderAsset(param1.asset);
         }
      }
      
      public function pause() : void
      {
         var _loc1_:IAssetView = null;
         var _loc2_:Number = NaN;
         _loc2_ = 0;
         while(_loc2_ < this.bgLayer.numChildren)
         {
            _loc1_ = IAssetView(this.bgLayer.getChildAt(_loc2_));
            _loc1_.pause();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.assetLayer.numChildren)
         {
            _loc1_ = IAssetView(this.assetLayer.getChildAt(_loc2_));
            _loc1_.pause();
            _loc2_++;
         }
      }
      
      public function resume() : void
      {
         var _loc1_:IAssetView = null;
         var _loc2_:Number = NaN;
         _loc2_ = 0;
         while(_loc2_ < this.bgLayer.numChildren)
         {
            _loc1_ = IAssetView(this.bgLayer.getChildAt(_loc2_));
            _loc1_.resume();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.assetLayer.numChildren)
         {
            _loc1_ = IAssetView(this.assetLayer.getChildAt(_loc2_));
            _loc1_.resume();
            _loc2_++;
         }
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         var _loc3_:uint = 0;
         var _loc2_:Array = new Array();
         if(param1 != "asset")
         {
            _loc3_ = 0;
            while(_loc3_ < this.bgLayer.numChildren)
            {
               _loc2_.push(this.bgLayer.getChildAt(_loc3_));
               _loc3_++;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < this.assetLayer.numChildren)
         {
            _loc2_.push(this.assetLayer.getChildAt(_loc3_));
            _loc3_++;
         }
         return new ArrayIterator(_loc2_);
      }
      
      public function refreshSceneBg(param1:String) : void
      {
         this.sceneBg.y = param1 == AnimeConstants.SCREEN_MODE_WIDE ? Number(AnimeConstants.WIDE_SCREEN_Y) : Number(AnimeConstants.SCREEN_Y);
         this.sceneBg.height = param1 == AnimeConstants.SCREEN_MODE_WIDE ? Number(AnimeConstants.WIDE_SCREEN_HEIGHT) : Number(AnimeConstants.SCREEN_HEIGHT);
      }
      
      public function ___SceneView_AbstractSceneView1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      private function _SceneView_bindingsSetup() : Array
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
         result[2] = new Binding(this,function():Number
         {
            return AnimeConstants.SCREEN_X;
         },null,"sceneBg.x");
         result[3] = new Binding(this,function():Number
         {
            return AnimeConstants.SCREEN_Y;
         },null,"sceneBg.y");
         result[4] = new Binding(this,function():Number
         {
            return AnimeConstants.SCREEN_WIDTH;
         },null,"sceneBg.width");
         result[5] = new Binding(this,function():Number
         {
            return AnimeConstants.SCREEN_HEIGHT;
         },null,"sceneBg.height");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get assetLayer() : Canvas
      {
         return this._2111656001assetLayer;
      }
      
      public function set assetLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._2111656001assetLayer;
         if(_loc2_ !== param1)
         {
            this._2111656001assetLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"assetLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bgLayer() : Canvas
      {
         return this._196953076bgLayer;
      }
      
      public function set bgLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._196953076bgLayer;
         if(_loc2_ !== param1)
         {
            this._196953076bgLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgLayer",_loc2_,param1));
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
      public function get sceneBg() : Canvas
      {
         return this._1914646001sceneBg;
      }
      
      public function set sceneBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._1914646001sceneBg;
         if(_loc2_ !== param1)
         {
            this._1914646001sceneBg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneBg",_loc2_,param1));
            }
         }
      }
   }
}
