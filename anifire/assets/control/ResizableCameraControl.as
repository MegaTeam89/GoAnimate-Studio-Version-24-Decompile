package anifire.assets.control
{
   import anifire.assets.controller.CameraController;
   import anifire.command.ICommand;
   import anifire.command.ResizeAssetsCommand;
   import anifire.constant.LicenseConstants;
   import anifire.core.Console;
   import anifire.core.ProgramEffectAsset;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IAssetControl;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IResizable;
   import anifire.util.UtilMath;
   import anifire.util.UtilPlain;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mx.core.UIComponent;
   
   public class ResizableCameraControl extends AbstractAssetControlDecorator
   {
      
      private static var controlSymbolBlue:Class = ResizableCameraControl_controlSymbolBlue;
      
      private static var controlSymbolPurple:Class = ResizableCameraControl_controlSymbolPurple;
      
      private static var iconMoveBlue:Class = ResizableCameraControl_iconMoveBlue;
      
      private static var iconMovePurple:Class = ResizableCameraControl_iconMovePurple;
       
      
      private const POINT_RADIUS:Number = 5;
      
      private var controlSymbol:Class;
      
      private var _iconMove:Class;
      
      private var _points:Array;
      
      private var _crosses:Array;
      
      private var _selectedPoint:Object;
      
      private var _tooltip:AssetResizeToolTip;
      
      private var _aspect:Number = 1;
      
      private var _oldCrossPt:Point;
      
      public function ResizableCameraControl(param1:IAssetControl)
      {
         this.controlSymbol = controlSymbolBlue;
         this._iconMove = iconMoveBlue;
         this._oldCrossPt = new Point();
         super(param1);
         if(param1.asset is ProgramEffectAsset)
         {
            if(ProgramEffectAsset(param1.asset).isShadow)
            {
               this._iconMove = iconMovePurple;
               this.controlSymbol = controlSymbolPurple;
            }
         }
         this.addPoints();
         this.addCrosses();
         this.addAssetEventListeners(param1.asset);
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(AssetEvent.CAMERA_GUIDE_CHANGED,this.onAssetResize);
            param1.addEventListener(AssetEvent.ASSET_RESIZED,this.onAssetResize);
         }
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         this.removeAssetEventListeners(super.asset);
         this._tooltip = null;
         this._points = null;
         this._selectedPoint = null;
         super.destroy(param1);
      }
      
      override public function set asset(param1:IEventDispatcher) : void
      {
         this.removeAssetEventListeners(super.asset);
         super.asset = param1;
         this.redraw();
         this.addAssetEventListeners(decorated.asset);
      }
      
      private function redraw() : void
      {
         this.updatePoints();
         this.updateCrosses();
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.CAMERA_GUIDE_CHANGED,this.onAssetResize);
            param1.removeEventListener(AssetEvent.ASSET_RESIZED,this.onAssetResize);
         }
      }
      
      private function updateToolTip() : void
      {
         var _loc1_:IResizable = null;
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(super.asset is IResizable && this._tooltip)
         {
            _loc1_ = super.asset as IResizable;
            this._tooltip.setSize(_loc1_.width,_loc1_.height);
            _loc2_ = new Point();
            _loc3_ = _loc1_.width;
            _loc4_ = _loc1_.height;
            if(this.asset is CameraController)
            {
               _loc5_ = LicenseConstants.getScreenRatio();
               _loc3_ = IResizable(this.asset).width;
               _loc4_ = IResizable(this.asset).width / _loc5_;
            }
            if(this._selectedPoint == this._points["topLeft"])
            {
               _loc2_.x = -_loc3_ / 2;
               _loc2_.y = -_loc4_ / 2;
            }
            else if(this._selectedPoint == this._points["topRight"])
            {
               _loc2_.x = _loc3_ / 2;
               _loc2_.y = -_loc4_ / 2;
            }
            else if(this._selectedPoint == this._points["bottomRight"])
            {
               _loc2_.x = _loc3_ / 2;
               _loc2_.y = _loc4_ / 2;
            }
            else if(this._selectedPoint == this._points["bottomLeft"])
            {
               _loc2_.x = -_loc3_ / 2;
               _loc2_.y = _loc4_ / 2;
            }
            _loc2_ = this.localToGlobal(_loc2_);
            if(this._selectedPoint == this._points["topLeft"])
            {
               _loc2_.x -= this._tooltip.width;
               _loc2_.y -= this._tooltip.height;
            }
            else if(this._selectedPoint == this._points["topRight"])
            {
               _loc2_.y -= this._tooltip.height;
            }
            else if(this._selectedPoint != this._points["bottomRight"])
            {
               if(this._selectedPoint == this._points["bottomLeft"])
               {
                  _loc2_.x -= this._tooltip.width;
               }
            }
            _loc2_ = this._tooltip.parent.globalToLocal(_loc2_);
            this._tooltip.move(_loc2_.x,_loc2_.y);
         }
      }
      
      override public function set drawingScale(param1:Number) : void
      {
         super.drawingScale = param1;
         UIComponent(this._points["topLeft"]).scaleX = UIComponent(this._points["topLeft"]).scaleY = param1;
         UIComponent(this._points["topRight"]).scaleX = UIComponent(this._points["topRight"]).scaleY = param1;
         UIComponent(this._points["bottomRight"]).scaleX = UIComponent(this._points["bottomRight"]).scaleY = param1;
         UIComponent(this._points["bottomLeft"]).scaleX = UIComponent(this._points["bottomLeft"]).scaleY = param1;
         this.redraw();
      }
      
      private function updateCrosses() : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         UIComponent(this._crosses["middle"]).x = 0;
         UIComponent(this._crosses["middle"]).y = 0;
         UtilPlain.removeAllSon(UIComponent(this._crosses["middle"]));
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Number = IResizable(this.asset).height / 4;
         var _loc3_:Sprite = new this._iconMove() as Sprite;
         _loc1_.addChild(_loc3_);
         _loc3_.width = _loc3_.height = _loc2_;
         _loc1_.x = _loc1_.y = -_loc2_ / 2;
         UIComponent(this._crosses["middle"]).addChild(_loc1_);
         if(IResizable(this.asset).width > 80)
         {
         }
         if(decorated.asset is CameraController && CameraController(decorated.asset).getAssetGuideStyle() == 1)
         {
            _loc4_ = new Sprite();
            _loc5_ = IResizable(this.asset).width;
            _loc6_ = IResizable(this.asset).height;
            _loc7_ = _loc5_ / 6;
            _loc8_ = _loc6_ / 6;
            _loc4_.graphics.lineStyle(0.5,932450,0.5);
            _loc4_.graphics.moveTo(-_loc7_,-_loc6_ / 2);
            _loc4_.graphics.lineTo(-_loc7_,_loc6_ / 2);
            _loc4_.graphics.moveTo(Number(_loc7_),-_loc6_ / 2);
            _loc4_.graphics.lineTo(Number(_loc7_),_loc6_ / 2);
            _loc4_.graphics.moveTo(-_loc5_ / 2,-_loc8_);
            _loc4_.graphics.lineTo(_loc5_ / 2,-_loc8_);
            _loc4_.graphics.moveTo(-_loc5_ / 2,Number(_loc8_));
            _loc4_.graphics.lineTo(_loc5_ / 2,Number(_loc8_));
            UIComponent(this._crosses["middle"]).addChild(_loc4_);
         }
      }
      
      private function updatePoints() : void
      {
         var _loc1_:IResizable = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(super.asset is IResizable)
         {
            _loc1_ = super.asset as IResizable;
            _loc2_ = _loc1_.width;
            _loc3_ = _loc1_.height;
            if(this.asset is CameraController)
            {
               _loc4_ = LicenseConstants.getScreenRatio();
               _loc2_ = IResizable(this.asset).width;
               _loc3_ = IResizable(this.asset).width / _loc4_;
            }
            UIComponent(this._points["topLeft"]).x = -_loc2_ / 2;
            UIComponent(this._points["topLeft"]).y = -_loc3_ / 2;
            UIComponent(this._points["topRight"]).x = _loc2_ / 2;
            UIComponent(this._points["topRight"]).y = -_loc3_ / 2;
            UIComponent(this._points["bottomRight"]).x = _loc2_ / 2;
            UIComponent(this._points["bottomRight"]).y = _loc3_ / 2;
            UIComponent(this._points["bottomLeft"]).x = -_loc2_ / 2;
            UIComponent(this._points["bottomLeft"]).y = _loc3_ / 2;
            UIComponent(this._points["topRight"]).rotation = 90;
            UIComponent(this._points["bottomRight"]).rotation = 180;
            UIComponent(this._points["bottomLeft"]).rotation = 270;
         }
      }
      
      private function addPoints() : void
      {
         this._points = new Array();
         this._points["topLeft"] = this.addPoint();
         this._points["topRight"] = this.addPoint();
         this._points["bottomRight"] = this.addPoint();
         this._points["bottomLeft"] = this.addPoint();
         this.updatePoints();
      }
      
      private function addPoint() : UIComponent
      {
         var _loc1_:UIComponent = new UIComponent();
         _loc1_.buttonMode = true;
         _loc1_.mouseChildren = false;
         _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.onPointMouseDown);
         var _loc2_:Sprite = new this.controlSymbol() as Sprite;
         _loc1_.addChild(_loc2_);
         this.addChild(_loc1_);
         return _loc1_;
      }
      
      private function addCrosses() : void
      {
         this._crosses = new Array();
         this._crosses["middle"] = this.addCross();
         UIComponent(this._crosses["middle"]).buttonMode = true;
         UIComponent(this._crosses["middle"]).mouseChildren = false;
         UIComponent(this._crosses["middle"]).addEventListener(MouseEvent.MOUSE_DOWN,this.onCrossMouseDown);
         this.updateCrosses();
      }
      
      private function addCross() : UIComponent
      {
         var _loc1_:UIComponent = new UIComponent();
         this.addChild(_loc1_);
         return _loc1_;
      }
      
      private function onCrossMouseDown(param1:MouseEvent) : void
      {
         this._oldCrossPt.x = this.mouseX;
         this._oldCrossPt.y = this.mouseY;
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
      }
      
      private function onPointMouseDown(param1:MouseEvent) : void
      {
         this._tooltip = Console.getConsole().mainStage.assetResizeToolTip;
         this.updateToolTip();
         this._tooltip.visible = true;
         this._selectedPoint = param1.target;
         if(super.asset is IResizable)
         {
            if(IResizable(super.asset).width > 0 && IResizable(super.asset).height > 0)
            {
               this._aspect = IResizable(super.asset).height / IResizable(super.asset).width;
            }
         }
         var _loc2_:ICommand = new ResizeAssetsCommand();
         _loc2_.execute();
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:IMovable = null;
         if(this._selectedPoint)
         {
            _loc2_ = this.mouseX;
            _loc3_ = this.mouseY;
            if(this._selectedPoint == this._points["topLeft"])
            {
               _loc2_ = Math.min(0,_loc2_);
               _loc3_ = Math.min(0,_loc3_);
            }
            else if(this._selectedPoint == this._points["topRight"])
            {
               _loc2_ = Math.max(0,_loc2_);
               _loc3_ = Math.min(0,_loc3_);
            }
            else if(this._selectedPoint == this._points["bottomRight"])
            {
               _loc2_ = Math.max(0,_loc2_);
               _loc3_ = Math.max(0,_loc3_);
            }
            else if(this._selectedPoint == this._points["bottomLeft"])
            {
               _loc2_ = Math.min(0,_loc2_);
               _loc3_ = Math.max(0,_loc3_);
            }
            this.resizeAsset(Math.abs(_loc2_ * 2),Math.abs(_loc3_ * 2));
            this.updateToolTip();
         }
         else
         {
            _loc4_ = super.asset as IMovable;
            _loc4_.x += this.mouseX - this._oldCrossPt.x;
            _loc4_.y += this.mouseY - this._oldCrossPt.y;
         }
      }
      
      private function resizeAsset(param1:Number, param2:Number, param3:Boolean = true) : void
      {
         var _loc4_:IResizable = null;
         var _loc5_:Number = NaN;
         if(super.asset is IResizable)
         {
            _loc4_ = super.asset as IResizable;
            param1 = UtilMath.boundaryCheck(param1,_loc4_.minWidth,_loc4_.maxWidth);
            param2 = UtilMath.boundaryCheck(param2,_loc4_.minHeight,_loc4_.maxHeight);
            if(param3)
            {
               if((_loc5_ = param2 / param1) > this._aspect)
               {
                  param1 = param2 / this._aspect;
               }
               else
               {
                  param2 = param1 * this._aspect;
               }
            }
            _loc4_.width = param1;
            _loc4_.height = param2;
         }
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         if(this._selectedPoint)
         {
            _loc2_ = this.mouseX;
            _loc3_ = this.mouseY;
            if(this._selectedPoint == this._points["topLeft"])
            {
               _loc2_ = Math.min(0,_loc2_);
               _loc3_ = Math.min(0,_loc3_);
            }
            else if(this._selectedPoint == this._points["topRight"])
            {
               _loc2_ = Math.max(0,_loc2_);
               _loc3_ = Math.min(0,_loc3_);
            }
            else if(this._selectedPoint == this._points["bottomRight"])
            {
               _loc2_ = Math.max(0,_loc2_);
               _loc3_ = Math.max(0,_loc3_);
            }
            else if(this._selectedPoint == this._points["bottomLeft"])
            {
               _loc2_ = Math.min(0,_loc2_);
               _loc3_ = Math.max(0,_loc3_);
            }
            this.resizeAsset(Math.abs(_loc2_ * 2),Math.abs(_loc3_ * 2));
            this._tooltip.visible = false;
            this._tooltip.x = 0;
            this._tooltip.y = 0;
            this._selectedPoint = null;
         }
      }
      
      private function onAssetResize(param1:AssetEvent) : void
      {
         this.redraw();
      }
   }
}
