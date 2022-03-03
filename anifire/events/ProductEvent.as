package anifire.events
{
   import flash.events.Event;
   
   public class ProductEvent extends Event
   {
      
      public static const PRODUCT_PURCHASED:String = "PRODUCT_PURCHASED";
       
      
      public function ProductEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
