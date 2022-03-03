package mx.containers.errors
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class ConstraintError extends Error
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      public function ConstraintError(param1:String)
      {
         super(param1);
      }
   }
}
