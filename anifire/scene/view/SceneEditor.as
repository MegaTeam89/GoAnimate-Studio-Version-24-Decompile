package anifire.scene.view
{
   import anifire.assets.control.AssetControlBox;
   import anifire.assets.control.AssetMotionControl;
   import anifire.assets.motion.CircularMotionControl;
   import anifire.constant.AnimeConstants;
   import anifire.interfaces.ISceneModel;
   import anifire.scene.controller.SceneEditorController;
   import anifire.util.UtilUser;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class SceneEditor extends AbstractSceneView implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1558819770_maskLayer:Canvas;
      
      private var _1752328296circularMotionControl:CircularMotionControl;
      
      private var _637388590controlBox:AssetControlBox;
      
      private var _47458229guideLayer:SceneAlignGuide;
      
      private var _367936711motionControl:AssetMotionControl;
      
      private var _1039444292selectionTool:AssetSelectionTool;
      
      private var _3619493view:ScenePreview;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _controller:SceneEditorController;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SceneEditor()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":AbstractSceneView,
            "events":{"creationComplete":"___SceneEditor_AbstractSceneView1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
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
                  "type":ScenePreview,
                  "id":"view"
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_maskLayer",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "visible":true,
                        "styleName":"canvasTheater",
                        "mouseChildren":false,
                        "mouseEnabled":false,
                        "mouseFocusEnabled":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":AssetControlBox,
                  "id":"controlBox",
                  "propertiesFactory":function():Object
                  {
                     return {"visible":false};
                  }
               }),new UIComponentDescriptor({
                  "type":AssetMotionControl,
                  "id":"motionControl"
               }),new UIComponentDescriptor({
                  "type":CircularMotionControl,
                  "id":"circularMotionControl"
               }),new UIComponentDescriptor({
                  "type":SceneAlignGuide,
                  "id":"guideLayer",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "percentWidth":100,
                        "percentHeight":100,
                        "mouseChildren":false,
                        "mouseEnabled":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":AssetSelectionTool,
                  "id":"selectionTool",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
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
         var bindings:Array = this._SceneEditor_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_scene_view_SceneEditorWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SceneEditor[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___SceneEditor_AbstractSceneView1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SceneEditor._watcherSetupUtil = param1;
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
      
      public function get controller() : SceneEditorController
      {
         return this._controller;
      }
      
      private function onCreationComplete() : void
      {
         this._controller = new SceneEditorController(this);
         this.scrollRect = new Rectangle(0,0,AnimeConstants.STAGE_WIDTH + AnimeConstants.STAGE_PADDING * 2,AnimeConstants.STAGE_HEIGHT + AnimeConstants.STAGE_PADDING * 2);
         this.drawOffStageArea();
         this.motionControl.sceneEditor = this;
      }
      
      override public function set sceneModel(param1:ISceneModel) : void
      {
         super.sceneModel = param1;
         this.controller.sceneModel = param1;
         this.view.sceneModel = param1;
      }
      
      public function pause() : void
      {
         this.view.pause();
      }
      
      public function resume() : void
      {
         this.view.resume();
      }
      
      public function set interactive(param1:Boolean) : void
      {
      }
      
      public function redrawOffStageArea(param1:String = "normal_screen_node") : void
      {
         this.drawOffStageArea(param1);
      }
      
      private function drawOffStageArea(param1:String = "normal_screen_node") : void
      {
         this._maskLayer.graphics.clear();
         this._maskLayer.graphics.lineStyle(0,0,0);
         this._maskLayer.graphics.beginFill(FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".mainStage").getStyle("backgroundColor"),0.5);
         this._maskLayer.graphics.drawRect(0,0,this._maskLayer.width,this._maskLayer.height);
         this._maskLayer.graphics.drawRect((this._maskLayer.width - AnimeConstants.SCREEN_WIDTH) / 2,(this._maskLayer.height - AnimeConstants.screenHeight) / 2,AnimeConstants.SCREEN_WIDTH,AnimeConstants.screenHeight);
         this._maskLayer.graphics.endFill();
      }
      
      public function set guideVisble(param1:Boolean) : void
      {
         if(UtilUser.hasBusinessFeatures)
         {
            this.guideLayer.visible = param1;
         }
      }
      
      public function ___SceneEditor_AbstractSceneView1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      private function _SceneEditor_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_WIDTH + AnimeConstants.STAGE_PADDING * 2;
         },null,"this.width");
         result[1] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_HEIGHT + AnimeConstants.STAGE_PADDING * 2;
         },null,"this.height");
         result[2] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },null,"view.x");
         result[3] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },null,"view.y");
         result[4] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },null,"controlBox.x");
         result[5] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },null,"controlBox.y");
         result[6] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },null,"motionControl.x");
         result[7] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },null,"motionControl.y");
         result[8] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },null,"circularMotionControl.x");
         result[9] = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },null,"circularMotionControl.y");
         result[10] = new Binding(this,function():SceneEditor
         {
            return this;
         },null,"selectionTool.canvas");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskLayer() : Canvas
      {
         return this._1558819770_maskLayer;
      }
      
      public function set _maskLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1558819770_maskLayer;
         if(_loc2_ !== param1)
         {
            this._1558819770_maskLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get circularMotionControl() : CircularMotionControl
      {
         return this._1752328296circularMotionControl;
      }
      
      public function set circularMotionControl(param1:CircularMotionControl) : void
      {
         var _loc2_:Object = this._1752328296circularMotionControl;
         if(_loc2_ !== param1)
         {
            this._1752328296circularMotionControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"circularMotionControl",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get controlBox() : AssetControlBox
      {
         return this._637388590controlBox;
      }
      
      public function set controlBox(param1:AssetControlBox) : void
      {
         var _loc2_:Object = this._637388590controlBox;
         if(_loc2_ !== param1)
         {
            this._637388590controlBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"controlBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get guideLayer() : SceneAlignGuide
      {
         return this._47458229guideLayer;
      }
      
      public function set guideLayer(param1:SceneAlignGuide) : void
      {
         var _loc2_:Object = this._47458229guideLayer;
         if(_loc2_ !== param1)
         {
            this._47458229guideLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"guideLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get motionControl() : AssetMotionControl
      {
         return this._367936711motionControl;
      }
      
      public function set motionControl(param1:AssetMotionControl) : void
      {
         var _loc2_:Object = this._367936711motionControl;
         if(_loc2_ !== param1)
         {
            this._367936711motionControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"motionControl",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get selectionTool() : AssetSelectionTool
      {
         return this._1039444292selectionTool;
      }
      
      public function set selectionTool(param1:AssetSelectionTool) : void
      {
         var _loc2_:Object = this._1039444292selectionTool;
         if(_loc2_ !== param1)
         {
            this._1039444292selectionTool = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selectionTool",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get view() : ScenePreview
      {
         return this._3619493view;
      }
      
      public function set view(param1:ScenePreview) : void
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
