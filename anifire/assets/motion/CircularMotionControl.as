package anifire.assets.motion
{
   import anifire.assets.interfaces.ISupportCircularMotion;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IRotatable;
   import anifire.util.UtilDraw;
   import anifire.util.UtilMath;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mx.core.UIComponent;
   
   public class CircularMotionControl extends UIComponent
   {
       
      
      private var _motion:ICircularMotion;
      
      private var _refLayer:UIComponent;
      
      private var _shadowView:CircularMotionShadowView;
      
      private var _target:Object;
      
      private var _tooltip:CircularMotionToolTip;
      
      private var _isCW:Boolean;
      
      private var _oldRotation:Number;
      
      private var _oldMouseRotation:Number;
      
      public function CircularMotionControl()
      {
         this._refLayer = new UIComponent();
         this._shadowView = new CircularMotionShadowView();
         this._tooltip = new CircularMotionToolTip();
         super();
         this._shadowView.addEventListener(MouseEvent.MOUSE_DOWN,this.onShadowMouseDown);
         this.addChild(this._shadowView);
         this._refLayer.mouseChildren = false;
         this._refLayer.mouseEnabled = false;
         this.addChild(this._refLayer);
         this._tooltip.mouseChildren = false;
         this._tooltip.mouseEnabled = false;
         this.addChild(this._tooltip);
      }
      
      private function onShadowMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         this.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         if(this._motion)
         {
            this._isCW = this._motion.isCW;
            _loc2_ = this.startPos;
            _loc3_ = new Point(_loc2_.x - this._motion.center.x,_loc2_.y - this._motion.center.y);
            if(_loc3_.length == 0)
            {
               _loc3_.x = 10;
            }
            _loc4_ = new Point(this.mouseX - this._motion.center.x,this.mouseY - this._motion.center.y);
            this._oldMouseRotation = UtilMath.signedAngleBetweenVectors(_loc3_,_loc4_);
            this._oldRotation = this._motion.rotation;
         }
      }
      
      private function onStageMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Number = NaN;
         if(this._motion)
         {
            _loc2_ = this.startPos;
            _loc3_ = new Point(_loc2_.x - this._motion.center.x,_loc2_.y - this._motion.center.y);
            if(_loc3_.length == 0)
            {
               _loc3_.x = 10;
            }
            _loc4_ = new Point(this.mouseX - this._motion.center.x,this.mouseY - this._motion.center.y);
            _loc5_ = this._oldRotation + UtilMath.signedAngleBetweenVectors(_loc3_,_loc4_) - this._oldMouseRotation;
            if(param1.shiftKey)
            {
               _loc5_ = Math.round(_loc5_ / 45) * 45;
            }
            if(this._isCW)
            {
               if(_loc5_ <= 0)
               {
                  _loc5_ += 360;
               }
            }
            else if(_loc5_ >= 0)
            {
               _loc5_ -= 360;
            }
            this._motion.rotation = _loc5_;
         }
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
      }
      
      private function set cirularMotion(param1:ICircularMotion) : void
      {
         if(this._motion != param1)
         {
            if(this._motion is IEventDispatcher)
            {
               IEventDispatcher(this._motion).removeEventListener(Event.CHANGE,this.onMotionChange);
            }
            this._motion = param1;
            if(this._motion is IEventDispatcher)
            {
               IEventDispatcher(this._motion).addEventListener(Event.CHANGE,this.onMotionChange);
            }
            if(param1)
            {
               this._shadowView.target = this._target;
               this.updateShadowImage();
               this.updateReferenceLine();
               this.updateToolTip();
               this.visible = true;
               this._refLayer.visible = true;
               this._tooltip.visible = true;
               this._shadowView.visible = true;
            }
            else
            {
               this.visible = false;
               this._refLayer.visible = false;
               this._tooltip.visible = false;
               this._shadowView.visible = false;
            }
         }
      }
      
      public function set target(param1:Object) : void
      {
         if(this._target != param1)
         {
            if(this._target is IEventDispatcher)
            {
               IEventDispatcher(this._target).removeEventListener(AssetEvent.ASSET_MOVED,this.onAssetMoved);
               IEventDispatcher(this._target).removeEventListener(AssetEvent.MOTION_CHANGE,this.onAssetMotionChange);
            }
            this._target = param1;
            if(this._target is IEventDispatcher)
            {
               IEventDispatcher(this._target).addEventListener(AssetEvent.ASSET_MOVED,this.onAssetMoved);
               IEventDispatcher(this._target).addEventListener(AssetEvent.MOTION_CHANGE,this.onAssetMotionChange);
            }
            if(param1 is ISupportCircularMotion)
            {
               this.cirularMotion = ISupportCircularMotion(param1).circularMotion;
               this.visible = true;
            }
            else
            {
               this.visible = false;
               this.cirularMotion = null;
            }
         }
      }
      
      private function onMotionChange(param1:Event) : void
      {
         this.updateReferenceLine();
         this.updateToolTip();
         this.updateShadowImage();
      }
      
      private function onAssetMoved(param1:Event) : void
      {
         this.updateReferenceLine();
         this.updateShadowImage();
      }
      
      private function onAssetMotionChange(param1:Event) : void
      {
         if(this._target is ISupportCircularMotion)
         {
            this.cirularMotion = ISupportCircularMotion(this._target).circularMotion;
         }
      }
      
      private function get startPos() : Point
      {
         var _loc1_:Point = new Point();
         if(this._target is IMovable)
         {
            _loc1_.x = IMovable(this._target).x;
            _loc1_.y = IMovable(this._target).y;
         }
         return _loc1_;
      }
      
      private function get startRotation() : Number
      {
         if(this._target is IRotatable)
         {
            return IRotatable(this._target).rotation;
         }
         return 0;
      }
      
      private function updateReferenceLine() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         this._refLayer.graphics.clear();
         if(this._motion)
         {
            _loc1_ = this.startPos;
            _loc2_ = UtilMath.rotatePoint(_loc1_,this._motion.rotation,this._motion.center);
            this._refLayer.graphics.lineStyle(1,16742144,0.2);
            this._refLayer.graphics.moveTo(this._motion.center.x,this._motion.center.y);
            this._refLayer.graphics.lineTo(_loc2_.x,_loc2_.y);
            this._refLayer.graphics.lineStyle(1,16742144,0.8);
            UtilDraw.drawArcFromPoint(this._refLayer.graphics,this._motion.center,_loc1_,this._motion.rotation);
            this._refLayer.graphics.endFill();
         }
      }
      
      private function updateToolTip() : void
      {
         if(this._motion)
         {
            this._tooltip.move(this._motion.center.x - 10,this._motion.center.y + 10);
            this._tooltip.setAngle(Math.abs(this._motion.rotation));
         }
      }
      
      private function updateShadowImage() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         if(this._motion)
         {
            _loc1_ = this.startPos;
            _loc2_ = UtilMath.rotatePoint(_loc1_,this._motion.rotation,this._motion.center);
            this._shadowView.move(_loc2_.x,_loc2_.y);
            this._shadowView.rotation = this.startRotation + this._motion.rotation;
         }
      }
   }
}
