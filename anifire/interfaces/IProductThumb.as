package anifire.interfaces
{
   import flash.events.IEventDispatcher;
   
   public interface IProductThumb extends IEventDispatcher
   {
       
      
      function set product(param1:IProduct) : void;
      
      function get product() : IProduct;
      
      function set editable(param1:Boolean) : void;
   }
}
