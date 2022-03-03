package anifire.assets.control
{
   import anifire.assets.interfaces.IReferencePoint;
   import anifire.command.ICommand;
   import anifire.command.ResizeAssetsCommand;
   import anifire.core.Console;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IAssetControl;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IResizable;
   import anifire.interfaces.IRotatable;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import mx.core.UIComponent;
   import mx.effects.Fade;
   
   public class StretchableAssetControl extends AbstractAssetControlDecorator
   {
       
      
      private const POINT_COLOR_LIGHT:uint = 11979662;
      
      private const POINT_COLOR_DARK:uint = 5405190;
      
      private const POINT_RADIUS:Number = 4;
      
      private const REFERENCE_COLOR_LIGHT:Number = 11979662;
      
      private const REFERENCE_COLOR_DARK:Number = 5405190;
      
      private var _points:Array;
      
      private var _selectedPoint:UIComponent;
      
      private var _tooltip:AssetResizeToolTip;
      
      private var _oldMouseDown:Point;
      
      private var _oldSize:Point;
      
      private var _refLayer:UIComponent;
      
      private var _fadeIn:Fade;
      
      public function StretchableAssetControl(param1:IAssetControl)
      {
         this._oldMouseDown = new Point();
         this._oldSize = new Point();
         this._refLayer = new UIComponent();
         this._fadeIn = new Fade();
         super(param1);
         this.addPoints();
         this.addAssetEventListeners(param1.asset);
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
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
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.ASSET_RESIZED,this.onAssetResize);
         }
      }
      
      private function updatePoints() : void
      {
         if(super.asset is IResizable)
         {
            UIComponent(this._points["top"]).x = 0;
            UIComponent(this._points["top"]).y = -IResizable(super.asset).height / 2 - super.borderWidth / 2;
            UIComponent(this._points["right"]).x = IResizable(super.asset).width / 2 + super.borderWidth / 2;
            UIComponent(this._points["right"]).y = 0;
            UIComponent(this._points["bottom"]).x = 0;
            UIComponent(this._points["bottom"]).y = IResizable(super.asset).height / 2 + super.borderWidth / 2;
            UIComponent(this._points["left"]).x = -IResizable(super.asset).width / 2 - super.borderWidth / 2;
            UIComponent(this._points["left"]).y = 0;
            UIComponent(this._points["left"]).visible = UIComponent(this._points["right"]).visible = IResizable(super.asset).height > 20;
            UIComponent(this._points["top"]).visible = UIComponent(this._points["bottom"]).visible = IResizable(super.asset).width > 20;
         }
      }
      
      private function addPoints() : void
      {
         this.addChild(this._refLayer);
         this._points = new Array();
         this._points["top"] = this.addPoint(RotatableControlPoint.POINT_ID_TOP);
         this._points["right"] = this.addPoint(RotatableControlPoint.POINT_ID_RIGHT);
         this._points["bottom"] = this.addPoint(RotatableControlPoint.POINT_ID_BOTTOM);
         this._points["left"] = this.addPoint(RotatableControlPoint.POINT_ID_LEFT);
         this.updatePoints();
      }
      
      private function addPoint(param1:uint) : UIComponent
      {
         var _loc2_:ResizableControlPoint = null;
         _loc2_ = new ResizableControlPoint(param1);
         _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.onPointMouseDown);
         _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.onPointMouseMove);
         _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.onPointRollOver);
         _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.onPointRollOut);
         this.addChild(_loc2_);
         return _loc2_;
      }
      
      private function onPointMouseMove(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this._refLayer.visible = true;
         }
      }
      
      private function get localRefPos() : Point
      {
         var _loc2_:Matrix = null;
         var _loc1_:Point = new Point();
         if(super.asset is IReferencePoint)
         {
            _loc1_ = new Point(IReferencePoint(super.asset).referenceX,IReferencePoint(super.asset).referenceY);
            _loc2_ = this.refMat;
            _loc2_.invert();
            _loc1_ = _loc2_.transformPoint(_loc1_);
         }
         return _loc1_;
      }
      
      private function get refMat() : Matrix
      {
         var _loc1_:Matrix = new Matrix();
         if(super.asset is IRotatable)
         {
            _loc1_.rotate(IRotatable(super.asset).rotation * Math.PI / 180);
         }
         if(super.asset is IMovable)
         {
            _loc1_.translate(IMovable(super.asset).x,IMovable(asset).y);
         }
         return _loc1_;
      }
      
      private function onPointMouseDown(param1:MouseEvent) : void
      {
         this._oldMouseDown.x = this.mouseX - this.localRefPos.x;
         this._oldMouseDown.y = this.mouseY - this.localRefPos.y;
         if(super.asset is IResizable)
         {
            this._oldSize.x = IResizable(super.asset).width;
            this._oldSize.y = IResizable(super.asset).height;
         }
         this._selectedPoint = param1.currentTarget as UIComponent;
         this._tooltip = Console.getConsole().mainStage.assetResizeToolTip;
         this.updateToolTip();
         this._tooltip.visible = true;
         var _loc2_:ICommand = new ResizeAssetsCommand();
         _loc2_.execute();
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
      }
      
      private function onPointRollOver(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this._selectedPoint = param1.currentTarget as UIComponent;
            this.updateReferenceLine();
            this._refLayer.visible = true;
         }
      }
      
      private function onPointRollOut(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this._refLayer.visible = false;
         }
      }
      
      private function updateToolTip() : void
      {
         var _loc1_:IResizable = null;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         if(super.asset is IResizable && this._tooltip)
         {
            _loc1_ = super.asset as IResizable;
            this._tooltip.setSize(_loc1_.width,_loc1_.height);
            _loc2_ = new Point();
            _loc3_ = new Point(10,10);
            if(this._selectedPoint == this._points["top"])
            {
               _loc2_.x = 0;
               _loc2_.y = -_loc1_.height / 2 - super.borderWidth;
            }
            else if(this._selectedPoint == this._points["right"])
            {
               _loc2_.x = _loc1_.width / 2 + super.borderWidth;
               _loc2_.y = 0;
            }
            else if(this._selectedPoint == this._points["bottom"])
            {
               _loc2_.x = 0;
               _loc2_.y = _loc1_.height / 2 + super.borderWidth;
            }
            else if(this._selectedPoint == this._points["left"])
            {
               _loc2_.x = -_loc1_.width / 2 - super.borderWidth;
               _loc2_.y = 0;
            }
            _loc2_ = this.localToGlobal(_loc2_);
            if(this._selectedPoint == this._points["top"])
            {
               _loc2_.x -= this._tooltip.width / 2;
               _loc2_.y -= this._tooltip.height + _loc3_.y;
            }
            else if(this._selectedPoint == this._points["right"])
            {
               _loc2_.x += _loc3_.x;
               _loc2_.y -= this._tooltip.height / 2;
            }
            else if(this._selectedPoint == this._points["bottom"])
            {
               _loc2_.x -= this._tooltip.width / 2;
               _loc2_.y += _loc3_.y;
            }
            else if(this._selectedPoint == this._points["left"])
            {
               _loc2_.x -= this._tooltip.width + _loc3_.x;
               _loc2_.y -= this._tooltip.height / 2;
            }
            _loc2_ = this._tooltip.parent.globalToLocal(_loc2_);
            this._tooltip.move(_loc2_.x,_loc2_.y);
         }
      }
      
      private function updateReferenceLine() : void
      {
         var _loc1_:Point = this.localRefPos;
         this._refLayer.graphics.clear();
         if(this._selectedPoint == this._points["left"] || this._selectedPoint == this._points["right"])
         {
            this._refLayer.graphics.lineStyle(this.drawingScale,this.REFERENCE_COLOR_DARK,0.1,true);
            this._refLayer.graphics.moveTo(_loc1_.x,_loc1_.y + 1000);
            this._refLayer.graphics.lineTo(_loc1_.x,_loc1_.y - 1000);
            this._refLayer.graphics.lineStyle(this.drawingScale,this.REFERENCE_COLOR_DARK,0.5,true);
            this._refLayer.graphics.moveTo(_loc1_.x + 1000,UIComponent(this._points["top"]).y);
            this._refLayer.graphics.lineTo(_loc1_.x - 1000,UIComponent(this._points["top"]).y);
            this._refLayer.graphics.lineStyle(this.drawingScale,this.REFERENCE_COLOR_DARK,0.5,true);
            this._refLayer.graphics.moveTo(_loc1_.x + 1000,UIComponent(this._points["bottom"]).y);
            this._refLayer.graphics.lineTo(_loc1_.x - 1000,UIComponent(this._points["bottom"]).y);
         }
         else
         {
            this._refLayer.graphics.lineStyle(this.drawingScale,this.REFERENCE_COLOR_DARK,0.1,true);
            this._refLayer.graphics.moveTo(_loc1_.x - 1000,_loc1_.y);
            this._refLayer.graphics.lineTo(_loc1_.x + 1000,_loc1_.y);
            this._refLayer.graphics.lineStyle(this.drawingScale,this.REFERENCE_COLOR_DARK,0.5,true);
            this._refLayer.graphics.moveTo(UIComponent(this._points["left"]).x,_loc1_.y - 1000);
            this._refLayer.graphics.lineTo(UIComponent(this._points["left"]).x,_loc1_.y + 1000);
            this._refLayer.graphics.lineStyle(this.drawingScale,this.REFERENCE_COLOR_DARK,0.5,true);
            this._refLayer.graphics.moveTo(UIComponent(this._points["right"]).x,_loc1_.y - 1000);
            this._refLayer.graphics.lineTo(UIComponent(this._points["right"]).x,_loc1_.y + 1000);
         }
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this._selectedPoint == this._points["left"] || this._selectedPoint == this._points["right"])
         {
            _loc2_ = Math.max(0,(this.mouseX - this.localRefPos.x) / this._oldMouseDown.x);
            _loc3_ = Math.abs(this._oldSize.x * _loc2_);
            if(param1.shiftKey)
            {
               _loc3_ = Math.round(_loc3_ / 50) * 50;
            }
            this.resizeWidth(_loc3_);
         }
         else
         {
            _loc4_ = Math.max(0,(this.mouseY - this.localRefPos.y) / this._oldMouseDown.y);
            _loc5_ = Math.abs(this._oldSize.y * _loc4_);
            if(param1.shiftKey)
            {
               _loc5_ = Math.round(_loc5_ / 50) * 50;
            }
            this.resizeHeight(_loc5_);
         }
         this.updateReferenceLine();
         this.updateToolTip();
      }
      
      override public function set drawingScale(param1:Number) : void
      {
         super.drawingScale = param1;
         UIComponent(this._points["top"]).scaleX = UIComponent(this._points["top"]).scaleY = param1;
         UIComponent(this._points["right"]).scaleX = UIComponent(this._points["right"]).scaleY = param1;
         UIComponent(this._points["bottom"]).scaleX = UIComponent(this._points["bottom"]).scaleY = param1;
         UIComponent(this._points["left"]).scaleX = UIComponent(this._points["left"]).scaleY = param1;
         this.redraw();
      }
      
      private function resizeWidth(param1:Number) : void
      {
         if(super.asset is IResizable)
         {
            IResizable(super.asset).width = param1;
         }
      }
      
      private function resizeHeight(param1:Number) : void
      {
         if(super.asset is IResizable)
         {
            IResizable(super.asset).height = param1;
         }
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         this._refLayer.visible = false;
         this._tooltip.visible = false;
      }
      
      private function onAssetResize(param1:AssetEvent) : void
      {
         this.redraw();
      }
   }
}
