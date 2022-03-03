package anifire.products.view
{
   import anifire.constant.ThemeConstants;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.ITheme;
   import anifire.managers.ThemeManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import mx.utils.StringUtil;
   
   public class ProductManager extends EventDispatcher
   {
      
      public static const PRODUCT_TYPE_PROP:String = "prop";
      
      public static const PRODUCT_TYPE_BG:String = "bg";
      
      private static var _instance:ProductManager;
       
      
      private var _searchKeyword:String;
      
      public function ProductManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : ProductManager
      {
         if(_instance == null)
         {
            _instance = new ProductManager();
         }
         return _instance;
      }
      
      private function filterProduct(param1:Object) : Boolean
      {
         var _loc2_:IProduct = param1 as IProduct;
         var _loc3_:RegExp = new RegExp(this._searchKeyword,"i");
         return _loc2_.enable && (_loc2_.name.search(_loc3_) > -1 || _loc2_.fileName.search(_loc3_) > -1);
      }
      
      public function searchProduct(param1:String, param2:String = null, param3:String = null) : ArrayCollection
      {
         var _loc6_:ITheme = null;
         var _loc7_:IIterator = null;
         var _loc4_:ArrayCollection = new ArrayCollection();
         if(param1 == null)
         {
            return _loc4_;
         }
         param1 = StringUtil.trim(param1);
         if(param1 == "")
         {
            return _loc4_;
         }
         this._searchKeyword = param1;
         var _loc5_:Array = new Array();
         if(param3)
         {
            if(_loc6_ = ThemeManager.instance.getTheme(param3))
            {
               _loc5_ = _loc5_.concat(_loc6_.getProducts(param2));
            }
            if(param3 == ThemeConstants.LIL_PEEPZ_THEME_ID)
            {
               if(_loc6_ = ThemeManager.instance.getTheme(ThemeConstants.COMMON_THEME_ID))
               {
                  _loc5_ = _loc5_.concat(_loc6_.getProducts(param2));
               }
            }
         }
         else
         {
            _loc7_ = ThemeManager.instance.iterator();
            while(_loc7_.hasNext)
            {
               if((_loc6_ = _loc7_.next as ITheme) && _loc6_.id != ThemeConstants.COMMON_THEME_ID)
               {
                  _loc5_ = _loc5_.concat(_loc6_.getProducts(param2));
               }
            }
            if(_loc6_ = ThemeManager.instance.getTheme(ThemeConstants.COMMON_THEME_ID))
            {
               _loc5_ = _loc5_.concat(_loc6_.getProducts(param2));
            }
         }
         (_loc4_ = new ArrayCollection(_loc5_)).filterFunction = this.filterProduct;
         _loc4_.refresh();
         return _loc4_;
      }
   }
}
