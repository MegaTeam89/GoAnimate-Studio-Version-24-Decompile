package mx.containers
{
   import flash.events.Event;
   import mx.containers.utilityClasses.BoxLayout;
   import mx.core.Container;
   import mx.core.IUIComponent;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class Box extends Container
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      mx_internal var layoutObject:BoxLayout;
      
      public function Box()
      {
         this.layoutObject = new BoxLayout();
         super();
         this.layoutObject.target = this;
      }
      
      [Bindable("directionChanged")]
      public function get direction() : String
      {
         return this.layoutObject.direction;
      }
      
      public function set direction(param1:String) : void
      {
         this.layoutObject.direction = param1;
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("directionChanged"));
      }
      
      override protected function measure() : void
      {
         super.measure();
         this.layoutObject.measure();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         this.layoutObject.updateDisplayList(param1,param2);
      }
      
      public function pixelsToPercent(param1:Number) : Number
      {
         var _loc8_:IUIComponent = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:Boolean = this.isVertical();
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = numChildren;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = getLayoutChildAt(_loc6_);
            _loc9_ = !!_loc2_ ? Number(_loc8_.height) : Number(_loc8_.width);
            _loc10_ = !!_loc2_ ? Number(_loc8_.percentHeight) : Number(_loc8_.percentWidth);
            if(!isNaN(_loc10_))
            {
               _loc3_ += _loc10_;
               _loc4_ += _loc9_;
            }
            _loc6_++;
         }
         var _loc7_:Number = 100;
         if(_loc4_ != param1)
         {
            _loc7_ = _loc4_ * _loc3_ / (_loc4_ - param1) - _loc3_;
         }
         return _loc7_;
      }
      
      mx_internal function isVertical() : Boolean
      {
         return this.direction != BoxDirection.HORIZONTAL;
      }
   }
}
