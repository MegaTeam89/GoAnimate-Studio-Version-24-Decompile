package mx.containers.utilityClasses
{
   import mx.core.Container;
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   public class Layout
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      protected var resourceManager:IResourceManager;
      
      private var _target:Container;
      
      public function Layout()
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
      }
      
      public function get target() : Container
      {
         return this._target;
      }
      
      public function set target(param1:Container) : void
      {
         this._target = param1;
      }
      
      public function measure() : void
      {
      }
      
      public function updateDisplayList(param1:Number, param2:Number) : void
      {
      }
   }
}
