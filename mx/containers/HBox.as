package mx.containers
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class HBox extends Box
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      public function HBox()
      {
         super();
         mx_internal::layoutObject.direction = BoxDirection.HORIZONTAL;
      }
      
      override public function set direction(param1:String) : void
      {
      }
   }
}
