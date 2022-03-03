package anifire.assets.control
{
   import anifire.assets.controller.AssetCollectionController;
   import anifire.assets.image.AssetCollectionImage;
   import anifire.assets.interfaces.IReferencePoint;
   import anifire.assets.model.AssetCollectionShadow;
   import anifire.assets.view.AssetViewFactory;
   import anifire.command.ICommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.core.Console;
   import anifire.core.ProgramEffectAsset;
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetController;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IMotion;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.ISlidable;
   import anifire.scene.view.SceneEditor;
   import anifire.util.UtilUser;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.core.UIComponent;
   
   public class AssetMotionControl extends UIComponent
   {
       
      
      private var _motionPath:AssetMotionPath;
      
      private var _assetViewFactory:AssetViewFactory;
      
      private var _controller:IAssetController;
      
      private var _target:IEventDispatcher;
      
      private var _shadow:Object;
      
      private var _shadowView:UIComponent;
      
      private var _shadowLayer:UIComponent;
      
      private var _shadowCameraLayer:UIComponent;
      
      private var _pathLayer:UIComponent;
      
      private var _controlBox:AssetControlBox;
      
      private var _mouseDown:Point;
      
      private var _shadowPos:Point;
      
      private var _shadowRef:Point;
      
      private var _sceneEditor:SceneEditor;
      
      public function AssetMotionControl()
      {
         this._motionPath = new AssetMotionPath();
         this._assetViewFactory = new AssetViewFactory();
         this._shadowLayer = new UIComponent();
         this._shadowCameraLayer = new UIComponent();
         this._pathLayer = new UIComponent();
         this._controlBox = new AssetControlBox();
         super();
         this.addChild(this._shadowCameraLayer);
         this.addChild(this._shadowLayer);
         this.addChild(this._controlBox);
         this._pathLayer.addChild(this._motionPath);
         this.addChild(this._pathLayer);
         this._motionPath.addEventListener(Event.CHANGE,this.onMotionPathChange);
         this._motionPath.addEventListener("removeSlideMotion",this.onMotionRemoved);
      }
      
      public function set sceneEditor(param1:SceneEditor) : void
      {
         this._sceneEditor = param1;
      }
      
      public function set motionPathGrowthColor(param1:uint) : void
      {
         this._motionPath.growthColor = param1;
      }
      
      public function get controlBox() : AssetControlBox
      {
         return this._controlBox;
      }
      
      public function set controlBox(param1:AssetControlBox) : void
      {
         this._controlBox = param1;
      }
      
      private function clearShadowCamera() : void
      {
      }
      
      private function updateShadowCamera() : void
      {
         this.clearShadowCamera();
      }
      
      private function onMotionRemoved(param1:Event) : void
      {
         var _loc2_:ICommand = new RemoveMotionCommand();
         _loc2_.execute();
         if(this._target is ISlidable)
         {
            ISlidable(this._target).removeSlideMotion();
         }
      }
      
      private function onMotionPathChange(param1:Event) : void
      {
         this.commitMotionData();
      }
      
      private function commitMotionData() : void
      {
         var _loc1_:Boolean = false;
         if(this._target is IMotion)
         {
            _loc1_ = this._motionPath.pathOriented;
            IMotion(this._target).motionData.path = this._motionPath.path;
            IMotion(this._target).motionData.pathOriented = _loc1_;
         }
      }
      
      private function removeShadow() : void
      {
         if(this._shadowView)
         {
            this.updateShadowCamera();
            this._shadowView.removeEventListener(Event.COMPLETE,this.onShadowImageReady);
            if(this._shadowView is IAssetView)
            {
               IAssetView(this._shadowView).destroy("destroyed by AssetMotionControl");
            }
            try
            {
               this._shadowLayer.removeChild(this._shadowView);
            }
            catch(e:Error)
            {
            }
            this._shadowView = null;
            this._shadow = null;
            this._controlBox.target = null;
         }
      }
      
      private function updateShadow() : void
      {
         if(this._target is IMotion)
         {
            if(this._shadow != IMotion(this._target).shadow)
            {
               this._shadow = IMotion(this._target).shadow;
               if(this._shadow)
               {
                  this.createShadowView(this._shadow);
               }
               else
               {
                  this.removeShadow();
               }
            }
         }
         else
         {
            this.removeShadow();
         }
      }
      
      private function updatePath() : void
      {
         if(this._motionPath)
         {
            this._motionPath.visible = false;
         }
         try
         {
         }
         catch(e:Error)
         {
         }
         if(this._target is IMotion && IMotion(this._target).motionData)
         {
            if(this._target is ProgramEffectAsset && Console.getConsole().metaData.mver > 3)
            {
               this._motionPath.growthColor = 6110118;
               this._motionPath.distLabel = false;
            }
            else
            {
               this._motionPath.growthColor = 5405190;
               this._motionPath.distLabel = true;
            }
            this._motionPath.removeEventListener(Event.CHANGE,this.onMotionPathChange);
            this._motionPath.path = IMotion(this._target).motionData.path;
            this._motionPath.pathOriented = IMotion(this._target).motionData.pathOriented;
            this._motionPath.addEventListener(Event.CHANGE,this.onMotionPathChange);
            this._motionPath.visible = true;
            this._motionPath.mouseChildren = IMotion(this._target).motionData.maxInterPointNum > 0;
         }
      }
      
      public function set target(param1:Object) : void
      {
         this.removeAssetEventListeners(this._target);
         if(this._target is IMotion)
         {
            IMotion(this._target).motionData = null;
         }
         this._target = param1 as IEventDispatcher;
         this.addAssetEventListeners(this._target);
         this.updatePath();
         this.updateShadow();
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(AssetEvent.MOTION_CHANGE,this.onAssetMotionChange);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.MOTION_CHANGE,this.onAssetMotionChange);
         }
      }
      
      private function onAssetMotionChange(param1:AssetEvent) : void
      {
         this.updatePath();
         this.updateShadow();
      }
      
      private function createShadowView(param1:Object) : void
      {
         if(param1 is IAsset)
         {
            this._shadowView = this._assetViewFactory.createAssetView(param1 as IAsset) as UIComponent;
            if(this._shadowView)
            {
               this._shadowView.addEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onShadowImageReady);
               if(this._shadowView is IAssetView)
               {
                  IAssetView(this._shadowView).loadImage();
               }
            }
         }
         else if(param1 is AssetCollectionShadow)
         {
            this._shadowView = new AssetCollectionImage();
            if(this._shadowView && this._target is AssetCollectionController)
            {
               AssetCollectionImage(this._shadowView).collection = AssetCollectionController(this._target).collection;
            }
            this._shadowView.x = AssetCollectionShadow(param1).x - AssetCollectionController(this._target).width / 2;
            this._shadowView.y = AssetCollectionShadow(param1).y - AssetCollectionController(this._target).height / 2;
            AssetCollectionShadow(param1).addEventListener(Event.CHANGE,this.onShadowChange);
         }
         if(this._shadowView)
         {
            this._shadowView.buttonMode = true;
            this._shadowView.addEventListener(MouseEvent.MOUSE_DOWN,this.onShadowMouseDown);
            this._shadowLayer.addChild(this._shadowView);
            this._shadowLayer.alpha = 0.5;
            this.clearShadowCamera();
         }
      }
      
      private function onShadowChange(param1:Event) : void
      {
         if(this._shadowView && this._target is AssetCollectionController)
         {
            this._shadowView.x = AssetCollectionShadow(param1.target).x - AssetCollectionController(this._target).width / 2;
            this._shadowView.y = AssetCollectionShadow(param1.target).y - AssetCollectionController(this._target).height / 2;
         }
      }
      
      private function onShadowMouseDown(param1:MouseEvent) : void
      {
         this._mouseDown = new Point(this.mouseX,this.mouseY);
         if(this._shadow is IMovable)
         {
            this._shadowPos = new Point(IMovable(this._shadow).x,IMovable(this._shadow).y);
         }
         if(this._shadow is IReferencePoint)
         {
            this._shadowRef = new Point(IReferencePoint(this._shadow).referenceX,IReferencePoint(this._shadow).referenceY);
         }
         this._controlBox.visible = false;
         if(this._sceneEditor)
         {
            this._sceneEditor.guideVisble = true;
            this._sceneEditor.controller.updateAlignRects();
         }
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(this.mouseX - this._mouseDown.x,this.mouseY - this._mouseDown.y);
         var _loc3_:Point = new Point(this._shadowPos.x + _loc2_.x,this._shadowPos.y + _loc2_.y);
         if(!param1.ctrlKey && UtilUser.hasAdminFeatures)
         {
            _loc3_ = this.snapPoint(_loc3_);
            _loc2_.x = _loc3_.x - this._shadowPos.x;
            _loc2_.y = _loc3_.y - this._shadowPos.y;
            this._sceneEditor.guideVisble = true;
         }
         else
         {
            this._sceneEditor.guideVisble = false;
         }
         if(this._shadow is IMovable)
         {
            IMovable(this._shadow).move(_loc3_.x,_loc3_.y);
         }
         if(this._shadow is IReferencePoint)
         {
            IReferencePoint(this._shadow).setReferencePoint(this._shadowRef.x + _loc2_.x,this._shadowRef.y + _loc2_.y);
         }
      }
      
      private function snapPoint(param1:Point) : Point
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Point = null;
         if(this._sceneEditor)
         {
            _loc2_ = new Rectangle();
            _loc2_ = this._shadowView.getBounds(this._sceneEditor.view.view);
            _loc2_.x = param1.x;
            _loc2_.y = param1.y;
            _loc2_.offset(-_loc2_.width / 2,-_loc2_.height / 2);
            _loc3_ = this._sceneEditor.controller.snapRect(_loc2_);
            param1.offset(_loc3_.x,_loc3_.y);
         }
         return param1;
      }
      
      private function onMouseUp(param1:Event) : void
      {
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._controlBox.visible = true;
         this._sceneEditor.guideVisble = false;
      }
      
      private function onShadowImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.currentTarget).removeEventListener(param1.type,this.onShadowImageReady);
         if(this._shadowView is IAssetView)
         {
            IAssetView(this._shadowView).pause();
         }
         this._controlBox.target = this._shadowView;
      }
      
      public function refreshShadowControl() : void
      {
         this._controlBox.target = null;
         this._controlBox.target = this._shadowView;
      }
   }
}
