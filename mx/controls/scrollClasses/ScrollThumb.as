package mx.controls.scrollClasses
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mx.controls.Button;
   import mx.core.mx_internal;
   import mx.events.ScrollEventDetail;
   
   use namespace mx_internal;
   
   public class ScrollThumb extends Button
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      private var ymin:Number;
      
      private var ymax:Number;
      
      private var datamin:Number;
      
      private var datamax:Number;
      
      private var lastY:Number;
      
      public function ScrollThumb()
      {
         super();
         explicitMinHeight = 10;
         stickyHighlighting = true;
      }
      
      override mx_internal function buttonReleased() : void
      {
         super.buttonReleased();
         this.stopDragThumb();
      }
      
      mx_internal function setRange(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.ymin = param1;
         this.ymax = param2;
         this.datamin = param3;
         this.datamax = param4;
      }
      
      private function stopDragThumb() : void
      {
         var _loc1_:ScrollBar = ScrollBar(parent);
         _loc1_.isScrolling = false;
         _loc1_.dispatchScrollEvent(_loc1_.oldPosition,ScrollEventDetail.THUMB_POSITION);
         _loc1_.oldPosition = NaN;
         systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,true);
      }
      
      override protected function mouseDownHandler(param1:MouseEvent) : void
      {
         super.mouseDownHandler(param1);
         var _loc2_:ScrollBar = ScrollBar(parent);
         _loc2_.oldPosition = _loc2_.scrollPosition;
         this.lastY = param1.localY;
         systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,true);
      }
      
      private function mouseMoveHandler(param1:MouseEvent) : void
      {
         if(this.ymin == this.ymax)
         {
            return;
         }
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         _loc2_ = globalToLocal(_loc2_);
         var _loc3_:Number = _loc2_.y - this.lastY;
         _loc3_ += y;
         if(_loc3_ < this.ymin)
         {
            _loc3_ = this.ymin;
         }
         else if(_loc3_ > this.ymax)
         {
            _loc3_ = this.ymax;
         }
         var _loc4_:ScrollBar;
         (_loc4_ = ScrollBar(parent)).isScrolling = true;
         $y = _loc3_;
         var _loc5_:Number = _loc4_.scrollPosition;
         var _loc6_:Number = Math.round((this.datamax - this.datamin) * (y - this.ymin) / (this.ymax - this.ymin)) + this.datamin;
         _loc4_.scrollPosition = _loc6_;
         _loc4_.dispatchScrollEvent(_loc5_,ScrollEventDetail.THUMB_TRACK);
         param1.updateAfterEvent();
      }
   }
}
