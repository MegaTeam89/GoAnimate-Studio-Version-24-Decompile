package anifire.products.view
{
   import anifire.interfaces.IProductThumb;
   import anifire.util.UtilHashArray;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ProductThumbLibrary extends EventDispatcher
   {
      
      private static var _thumbs:UtilHashArray = new UtilHashArray();
       
      
      public function ProductThumbLibrary(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function getThumb(param1:String) : IProductThumb
      {
         var _loc2_:IProductThumb = IProductThumb(_thumbs.getValueByKey(param1));
         if(_loc2_ is DisplayObject)
         {
            DisplayObject(_loc2_).x = 0;
            DisplayObject(_loc2_).y = 0;
         }
         return _loc2_;
      }
      
      public static function addThumb(param1:String, param2:IProductThumb) : void
      {
         _thumbs.push(param1,param2);
      }
   }
}
