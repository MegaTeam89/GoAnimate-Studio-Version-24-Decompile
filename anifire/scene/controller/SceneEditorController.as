package anifire.scene.controller
{
   import anifire.assets.control.AssetControlBox;
   import anifire.assets.control.AssetMotionControl;
   import anifire.assets.controller.AssetCollectionController;
   import anifire.assets.controller.AssetControllerFactory;
   import anifire.assets.interfaces.IReferencePoint;
   import anifire.assets.motion.CircularMotionControl;
   import anifire.assets.view.AssetViewCollection;
   import anifire.command.AddSceneTemplateCommand;
   import anifire.command.ICommand;
   import anifire.command.MoveAssetGroupCommand;
   import anifire.components.studio.AssetButtonBar;
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Background;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.PropThumb;
   import anifire.core.TemplateThumb;
   import anifire.core.Thumb;
   import anifire.events.SceneEvent;
   import anifire.events.SceneViewEvent;
   import anifire.geom.AlignmentTool;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetController;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IPlayable;
   import anifire.interfaces.ISceneModel;
   import anifire.scene.view.SceneEditor;
   import anifire.util.UtilMath;
   import anifire.util.UtilUser;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.managers.DragManager;
   
   public class SceneEditorController extends EventDispatcher
   {
       
      
      private var _sceneModel:ISceneModel;
      
      private var _sceneEditor:SceneEditor;
      
      private var _selection:AssetViewCollection;
      
      private var _mouseDown:Point;
      
      private var _oldPos:Point;
      
      private var _oldRef:Point;
      
      private var _moveCommand:MoveAssetGroupCommand;
      
      private var _isDragging:Boolean = false;
      
      private var _controller:Object;
      
      private var _buttonBar:AssetButtonBar;
      
      private var _controlBox:AssetControlBox;
      
      private var _motionControl:AssetMotionControl;
      
      private var _circularMotionControl:CircularMotionControl;
      
      private var _preselectAssetId:String = "";
      
      private var _alignTool:AlignmentTool;
      
      private var _snapObjectsEnabled:Boolean = true;
      
      private var _snapCameraEnabled:Boolean = true;
      
      private var _snapOldPositionEnabled:Boolean = true;
      
      public function SceneEditorController(param1:SceneEditor, param2:IEventDispatcher = null)
      {
         this._oldPos = new Point();
         this._oldRef = new Point();
         this._alignTool = new AlignmentTool();
         super(param2);
         this._sceneEditor = param1;
         this._controlBox = param1.controlBox;
         this._motionControl = param1.motionControl;
         this._circularMotionControl = param1.circularMotionControl;
         this._sceneEditor.addEventListener(MouseEvent.MOUSE_DOWN,this.onEditorMouseDown);
         this._sceneEditor.addEventListener(MouseEvent.MOUSE_UP,this.onEditorMouseUp);
         this._sceneEditor.addEventListener(MouseEvent.MOUSE_OVER,this.onEditorMouseOver);
         this._sceneEditor.addEventListener(MouseEvent.ROLL_OUT,this.onEditorRollOut);
         this._sceneEditor.view.addEventListener(MouseEvent.MOUSE_DOWN,this.onViewMouseDown);
         this._sceneEditor.view.addEventListener(DragEvent.DRAG_ENTER,this.onDragEnter);
         this._sceneEditor.view.addEventListener(DragEvent.DRAG_EXIT,this.onDragExit);
         this._sceneEditor.view.addEventListener(DragEvent.DRAG_DROP,this.onDragDrop);
         this._sceneEditor.addEventListener(Event.COPY,this.onCopy);
         this._sceneEditor.addEventListener(Event.PASTE,this.onPaste);
         this._sceneEditor.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this._sceneEditor.addEventListener(SceneViewEvent.ASSET_VIEW_ADDED,this.onEditorAssetViewAdded);
         this._sceneEditor.addEventListener(SceneViewEvent.VIEW_LOAD_COMPLETE,this.onEditorViewLoadComplete);
         this._controlBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlMouseDown);
         this._selection = new AssetViewCollection();
         this._selection.addEventListener(Event.CHANGE,this.onSelectionChange);
      }
      
      public function get motionControl() : AssetMotionControl
      {
         return this._motionControl;
      }
      
      public function get selection() : AssetViewCollection
      {
         return this._selection;
      }
      
      public function get alignTool() : AlignmentTool
      {
         return this._alignTool;
      }
      
      private function onEditorViewLoadComplete(param1:SceneViewEvent) : void
      {
         if(this.preselectAssetId != "")
         {
            Console.getConsole().currentScene.selectedAsset = Console.getConsole().currentScene.getAssetById(this.preselectAssetId);
            this.preselectAssetId = "";
            this.showControl();
         }
      }
      
      private function onEditorAssetViewAdded(param1:SceneViewEvent) : void
      {
         var _loc2_:IAssetView = this._sceneEditor.view.view.lastAssetView as IAssetView;
         if(this.preselectAssetId != "")
         {
            Console.getConsole().currentScene.selectedAsset = Console.getConsole().currentScene.getAssetById(this.preselectAssetId);
            this.preselectAssetId = "";
            this.showControl();
         }
      }
      
      public function set preselectAssetId(param1:String) : void
      {
         this._preselectAssetId = param1;
      }
      
      public function get preselectAssetId() : String
      {
         return this._preselectAssetId;
      }
      
      private function onSelectionChange(param1:Event) : void
      {
         if(this._selection.selectedAsset)
         {
            this._controller = AssetControllerFactory.getController(this._selection.selectedAsset);
         }
         else
         {
            this._controller = AssetControllerFactory.getCollectionController(this._selection);
         }
         if(this._controller is IAssetController)
         {
            IAssetController(this._controller).view = this._selection.selectedAsset;
         }
         else if(this._controller is AssetCollectionController)
         {
            AssetCollectionController(this._controller).collection = this._selection;
         }
         this.hideButtonBar();
         this.hideControlBox();
         this.updateControlBox();
         this.updateButtonBar();
      }
      
      private function onAssetSelectionChange(param1:Event) : void
      {
         var _loc4_:IAssetView = null;
         var _loc5_:IAsset = null;
         var _loc2_:IIterator = this._sceneModel.selection.iterator();
         var _loc3_:IIterator = this._sceneEditor.view.iterator();
         var _loc6_:Array = new Array();
         this._motionControl.target = null;
         this._circularMotionControl.target = null;
         while(_loc2_.hasNext)
         {
            if(_loc5_ = _loc2_.next as IAsset)
            {
               _loc3_.reset();
               while(_loc3_.hasNext)
               {
                  if((_loc4_ = _loc3_.next as IAssetView) && _loc4_.asset == _loc5_)
                  {
                     _loc6_.push(_loc4_);
                  }
               }
            }
         }
         this._selection.replaceAllAssets(_loc6_);
         if(this._selection.selectedAsset)
         {
            Console.getConsole().showOverTray();
         }
         else
         {
            Console.getConsole().showOverTray(false);
         }
      }
      
      public function set sceneModel(param1:ISceneModel) : void
      {
         if(param1)
         {
            this._controlBox.target = null;
            this._motionControl.target = null;
            this._circularMotionControl.target = null;
            this._selection.clearCollection();
            this.removeModelEventListeners(this._sceneModel);
            if(this._sceneModel)
            {
               this._sceneModel.selection.removeEventListener(Event.CHANGE,this.onAssetSelectionChange);
               this._sceneModel.selection.clearCollection();
            }
            this._sceneModel = param1;
            this.addModelEventListeners(this._sceneModel);
            if(this._sceneModel)
            {
               this._sceneModel.selection.clearCollection();
               this._sceneModel.selection.addEventListener(Event.CHANGE,this.onAssetSelectionChange);
            }
         }
      }
      
      private function addModelEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(SceneEvent.ASSET_ADDED,this.onAssetAdded);
            param1.addEventListener(SceneEvent.ASSET_REMOVED,this.onAssetRemoved);
         }
      }
      
      private function removeModelEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(SceneEvent.ASSET_ADDED,this.onAssetAdded);
            param1.removeEventListener(SceneEvent.ASSET_REMOVED,this.onAssetRemoved);
         }
      }
      
      private function onAssetAdded(param1:SceneEvent) : void
      {
      }
      
      private function onAssetRemoved(param1:SceneEvent) : void
      {
         this._sceneModel.selection.clearCollection();
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:int = !!param1.shiftKey ? 10 : 1;
         if(param1.keyCode == Keyboard.DELETE || param1.keyCode == Keyboard.BACKSPACE)
         {
            Console.getConsole().deleteAsset();
         }
         else if(param1.keyCode == Keyboard.LEFT)
         {
            this.moveGroup(-_loc2_,0);
         }
         else if(param1.keyCode == Keyboard.UP)
         {
            this.moveGroup(0,-_loc2_);
         }
         else if(param1.keyCode == Keyboard.RIGHT)
         {
            this.moveGroup(_loc2_,0);
         }
         else if(param1.keyCode == Keyboard.DOWN)
         {
            this.moveGroup(0,_loc2_);
         }
      }
      
      private function onDragEnter(param1:DragEvent) : void
      {
         var _loc2_:Object = null;
         if(param1.dragSource.hasFormat(Thumb.DRAG_DATA_FORMAT))
         {
            _loc2_ = param1.dragSource.dataForFormat(Thumb.DRAG_DATA_FORMAT);
            if(_loc2_ is PropThumb && PropThumb(_loc2_).placeable == false)
            {
               return;
            }
            DragManager.acceptDragDrop(param1.target as UIComponent);
            this._sceneEditor.view.hideAllEffect();
            DragManager.showFeedback(DragManager.COPY);
         }
      }
      
      private function onDragExit(param1:DragEvent) : void
      {
         if(!Console.getConsole().mainStage.isCameraMode)
         {
            this._sceneEditor.view.showAllEffect();
         }
      }
      
      private function onDragDrop(param1:DragEvent) : void
      {
         var _loc5_:ICommand = null;
         var _loc2_:Thumb = Thumb(param1.dragSource.dataForFormat(Thumb.DRAG_DATA_FORMAT));
         var _loc3_:String = "";
         if(param1.dragSource.hasFormat("colorSetId"))
         {
            _loc3_ = String(param1.dragSource.dataForFormat("colorSetId"));
         }
         var _loc4_:DisplayObject = DisplayObject(param1.dragInitiator);
         if(_loc2_ is TemplateThumb)
         {
            (_loc5_ = new AddSceneTemplateCommand(Console.getConsole().movie,_loc2_ as TemplateThumb,Console.getConsole().currentSceneIndex + 1,Console.getConsole().timeline)).execute();
         }
         else
         {
            this._sceneModel.doCreateAsset(_loc2_,param1.localX,param1.localY,_loc3_);
         }
         Console.getConsole().currDragSource = null;
         if(!Console.getConsole().mainStage.isCameraMode)
         {
            this._sceneEditor.view.showAllEffect();
         }
      }
      
      private function onCopy(param1:Event) : void
      {
         Console.getConsole().copyAsset();
      }
      
      private function onPaste(param1:Event) : void
      {
         Console.getConsole().pasteAsset();
      }
      
      private function onControlMouseDown(param1:MouseEvent) : void
      {
         this.hideButtonBar();
      }
      
      private function hideButtonBar() : void
      {
         Console.getConsole().mainStage.hideButtonBar();
      }
      
      private function onEditorMouseDown(param1:MouseEvent) : void
      {
         this._sceneEditor.setFocus();
         if(!param1.shiftKey)
         {
            if(param1.target is DisplayObject && DisplayObject(param1.target).name == "editorBg")
            {
               this._sceneModel.selection.clearCollection();
            }
            else if(param1.target is DisplayObject && DisplayObject(param1.target).name == "sceneBg")
            {
               this._sceneModel.selection.clearCollection();
            }
         }
      }
      
      private function onViewMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:IAsset = null;
         if(param1.target is IAssetView)
         {
            this.hideButtonBar();
            this.hideControlBox();
            _loc2_ = IAssetView(param1.target).asset;
            if(param1.shiftKey)
            {
               if(this._sceneModel.selection.isInCollection(_loc2_))
               {
                  this._sceneModel.selection.removeAsset(_loc2_);
               }
               else
               {
                  this._sceneModel.selection.addAsset(_loc2_);
               }
            }
            else
            {
               if(!this._sceneModel.selection.isInCollection(_loc2_))
               {
                  this._sceneModel.selection.selectedAsset = IAssetView(param1.target).asset;
               }
               this.startDraggingGroup();
            }
         }
      }
      
      private function startDraggingGroup() : void
      {
         if(!(this._selection.selectedAsset && this._selection.selectedAsset.asset is Background))
         {
            this._moveCommand = new MoveAssetGroupCommand();
            this._isDragging = true;
            this._mouseDown = new Point(this._sceneEditor.mouseX,this._sceneEditor.mouseY);
            this.updateOriginalAssetPosition();
            this.updateAlignRects();
            this._sceneEditor.guideVisble = true;
            this._sceneEditor.addEventListener(MouseEvent.MOUSE_MOVE,this.onEditorMouseMove);
         }
      }
      
      private function updateOriginalAssetPosition() : void
      {
         if(this._controller is IMovable)
         {
            this._oldPos.x = IMovable(this._controller).x;
            this._oldPos.y = IMovable(this._controller).y;
         }
         if(this._controller is IReferencePoint)
         {
            this._oldRef.x = IReferencePoint(this._controller).referenceX;
            this._oldRef.y = IReferencePoint(this._controller).referenceY;
         }
      }
      
      private function onEditorMouseMove(param1:MouseEvent) : void
      {
         if(this._isDragging)
         {
            this.movingGroup(this._sceneEditor.mouseX - this._mouseDown.x,this._sceneEditor.mouseY - this._mouseDown.y,!param1.ctrlKey);
         }
      }
      
      private function onEditorMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is DisplayObject && DisplayObject(param1.target).name == "editorBg")
         {
            this._sceneEditor.selectionTool.activate();
         }
         else if(param1.target is DisplayObject && DisplayObject(param1.target).name == "sceneBg")
         {
            this._sceneEditor.selectionTool.activate();
         }
         else if(param1.target is IAssetView && IAssetView(param1.target).asset is Background)
         {
            this._sceneEditor.selectionTool.activate();
         }
         else
         {
            this._sceneEditor.selectionTool.deactivate();
         }
      }
      
      private function onEditorMouseUp(param1:MouseEvent) : void
      {
         this.showControl();
         if(this._isDragging)
         {
            this.stopDraggingGroup();
         }
      }
      
      private function onEditorRollOut(param1:MouseEvent) : void
      {
         if(this._isDragging)
         {
            this.stopDraggingGroup();
         }
      }
      
      private function stopDraggingGroup() : void
      {
         if(this._isDragging)
         {
            this._isDragging = false;
            this._sceneEditor.removeEventListener(MouseEvent.MOUSE_MOVE,this.onEditorMouseMove);
            if(!this._mouseDown.equals(new Point(this._sceneEditor.mouseX,this._sceneEditor.mouseY)))
            {
               this._moveCommand.execute();
            }
            this._sceneEditor.guideVisble = false;
            this.showControl();
         }
      }
      
      public function toggleSnapMode(param1:String = "all") : void
      {
         if(param1 == "snapObjects")
         {
            this._snapObjectsEnabled = !this._snapObjectsEnabled;
         }
         else if(param1 == "snapCamera")
         {
            this._snapCameraEnabled = !this._snapCameraEnabled;
            this._snapOldPositionEnabled = !this._snapOldPositionEnabled;
         }
         else
         {
            this._snapObjectsEnabled = !this._snapObjectsEnabled;
            this._snapCameraEnabled = !this._snapCameraEnabled;
            this._snapOldPositionEnabled = !this._snapOldPositionEnabled;
         }
      }
      
      public function updateAlignRects() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Asset = null;
         var _loc3_:IIterator = null;
         var _loc4_:DisplayObject = null;
         if(UtilUser.hasBusinessFeatures)
         {
            this._alignTool.reset();
            if(this._snapCameraEnabled)
            {
               if(this._sceneEditor.sceneModel is AnimeScene)
               {
                  _loc2_ = AnimeScene(this._sceneEditor.sceneModel).camera;
                  if(_loc2_)
                  {
                     _loc1_ = new Rectangle(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
                     this._alignTool.addRectangle(new Rectangle(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height),"camera");
                     this._alignTool.addCenter(new Point(_loc1_.x + _loc1_.width / 3,_loc1_.y + _loc1_.height / 3),_loc1_,"ruleOfThirds");
                     this._alignTool.addCenter(new Point(_loc1_.x + 2 * _loc1_.width / 3,_loc1_.y + _loc1_.height / 3),_loc1_,"ruleOfThirds");
                     this._alignTool.addCenter(new Point(_loc1_.x + _loc1_.width / 3,_loc1_.y + 2 * _loc1_.height / 3),_loc1_,"ruleOfThirds");
                     this._alignTool.addCenter(new Point(_loc1_.x + 2 * _loc1_.width / 3,_loc1_.y + 2 * _loc1_.height / 3),_loc1_,"ruleOfThirds");
                  }
               }
            }
            if(this._snapObjectsEnabled)
            {
               _loc3_ = this._sceneEditor.view.view.iterator("asset");
               if(_loc3_)
               {
                  while(_loc3_.hasNext)
                  {
                     if((_loc4_ = _loc3_.next as DisplayObject) && !this._selection.isInCollection(_loc4_ as IAssetView))
                     {
                        _loc1_ = _loc4_.getBounds(_loc4_);
                        this._alignTool.addRectangle(_loc1_);
                     }
                  }
               }
            }
            if(this._snapOldPositionEnabled)
            {
               _loc1_ = this._selection.getBounds(this._sceneEditor.view.view);
               this._alignTool.addCenter(UtilMath.getCenter(_loc1_),_loc1_,"oldPosition");
            }
         }
      }
      
      private function moveGroup(param1:Number, param2:Number) : void
      {
         this._moveCommand = new MoveAssetGroupCommand();
         this._moveCommand.execute();
         this.updateOriginalAssetPosition();
         this.movingGroup(param1,param2);
      }
      
      private function movingGroup(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:Point = null;
         if(this._controller is IMovable)
         {
            _loc4_ = new Point(this._oldPos.x + param1,this._oldPos.y + param2);
            this._sceneEditor.guideVisble = false;
            if(param3 && UtilUser.hasBusinessFeatures)
            {
               param1 = (_loc4_ = this.snapPoint(_loc4_)).x - this._oldPos.x;
               param2 = _loc4_.y - this._oldPos.y;
            }
            IMovable(this._controller).move(_loc4_.x,_loc4_.y);
         }
         if(this._controller is IReferencePoint)
         {
            IReferencePoint(this._controller).setReferencePoint(this._oldRef.x + param1,this._oldRef.y + param2);
         }
      }
      
      private function snapPoint(param1:Point) : Point
      {
         if(this._selection.selectedAsset && this._selection.selectedAsset.asset is EffectAsset && EffectAsset(this._selection.selectedAsset.asset).isCamera)
         {
            return param1;
         }
         var _loc2_:Rectangle = new Rectangle();
         _loc2_ = this._selection.getBounds(this._sceneEditor.view.view);
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.offset(-_loc2_.width / 2,-_loc2_.height / 2);
         var _loc3_:Point = this.snapRect(_loc2_);
         param1.offset(_loc3_.x,_loc3_.y);
         return param1;
      }
      
      public function snapRect(param1:Rectangle) : Point
      {
         var _loc2_:Point = this._alignTool.getSnappedDisplacement(param1);
         param1.offset(_loc2_.x,_loc2_.y);
         this._sceneEditor.guideLayer.redrawAlignGuide(this._alignTool,this._alignTool.rects,param1);
         this._sceneEditor.guideLayer.redrawSpacingGuide(this._alignTool);
         this._sceneEditor.guideVisble = true;
         return _loc2_;
      }
      
      public function showControl() : void
      {
         var _loc1_:IAssetView = null;
         if(this._selection.length == 1)
         {
            _loc1_ = this._selection.selectedAsset;
            if(_loc1_ is IPlayable)
            {
               IPlayable(_loc1_).pause();
            }
            this.showControlBox();
            this.showButtonBar();
            Console.getConsole().showOverTray();
         }
         else if(this._selection.length > 1)
         {
            this.showControlBox();
            this.showButtonBar();
            Console.getConsole().showOverTray(false);
         }
         else
         {
            this.hideButtonBar();
            this.hideControlBox();
            Console.getConsole().showOverTray(false);
         }
      }
      
      public function hideControl() : void
      {
         this.hideButtonBar();
         this.hideControlBox();
      }
      
      public function hideControlBox() : void
      {
         this._controlBox.visible = false;
      }
      
      private function showControlBox() : void
      {
         if(!this._controlBox.visible)
         {
            this._controlBox.visible = true;
            this._motionControl.visible = true;
            this._circularMotionControl.visible = true;
         }
      }
      
      private function updateControlBox() : void
      {
         var _loc3_:IAsset = null;
         var _loc1_:IAssetView = this._selection.selectedAsset;
         if(this._selection.length > 1)
         {
            this._controlBox.target = this._selection;
         }
         else if(_loc1_)
         {
            this._controlBox.target = _loc1_;
         }
         var _loc2_:AssetCollectionController = AssetControllerFactory.getCollectionController(this._selection);
         _loc2_.collection = this._selection;
         if(this._selection.length > 1)
         {
            this._motionControl.target = _loc2_;
         }
         else if(this._selection.selectedAsset)
         {
            _loc3_ = this._selection.selectedAsset.asset;
            this._motionControl.target = _loc3_;
         }
         else
         {
            this._motionControl.target = null;
            this._circularMotionControl.target = null;
         }
      }
      
      private function showButtonBar() : void
      {
         Console.getConsole().mainStage.showButtonBar();
      }
      
      private function updateButtonBar() : void
      {
         Console.getConsole().mainStage.updateButtonBar();
      }
   }
}
