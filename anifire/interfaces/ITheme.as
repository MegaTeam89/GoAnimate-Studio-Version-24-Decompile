package anifire.interfaces
{
   import anifire.util.UtilHashArray;
   
   public interface ITheme
   {
       
      
      function getPropThumbById(param1:String) : IThumb;
      
      function getThemeXML() : XML;
      
      function assetPurchased(param1:String) : Boolean;
      
      function changePurchase(param1:String, param2:String, param3:Boolean) : void;
      
      function doOutputThumbs(param1:XML) : UtilHashArray;
      
      function isStateExists(param1:XML, param2:IBehavior) : Boolean;
      
      function get id() : String;
      
      function getProducts(param1:String = null) : Array;
   }
}
