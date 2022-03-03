package anifire.products
{
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductImage;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class AbstractProductImageFactory extends EventDispatcher
   {
       
      
      public function AbstractProductImageFactory(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function createImage(param1:IProduct) : IProductImage
      {
         return null;
      }
   }
}
