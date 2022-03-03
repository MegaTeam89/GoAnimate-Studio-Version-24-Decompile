package anifire.assets.view
{
   import anifire.interfaces.IAsset;
   import mx.core.UIComponent;
   
   public class AbstractAssetView extends UIComponent
   {
       
      
      private var _asset:IAsset;
      
      public function AbstractAssetView()
      {
         super();
      }
      
      public function get asset() : IAsset
      {
         return this._asset;
      }
      
      public function set asset(param1:IAsset) : void
      {
         if(param1)
         {
            this._asset = param1;
         }
      }
   }
}
