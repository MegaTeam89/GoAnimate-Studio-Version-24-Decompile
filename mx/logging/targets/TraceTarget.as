package mx.logging.targets
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class TraceTarget extends LineFormattedTarget
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      public function TraceTarget()
      {
         super();
      }
      
      override mx_internal function internalLog(param1:String) : void
      {
         trace(param1);
      }
   }
}
