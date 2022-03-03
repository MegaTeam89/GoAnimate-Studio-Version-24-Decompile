package anifire.products.view
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.interfaces.IProduct;
   import flash.display.DisplayObject;
   
   public class BgProductThumb extends ProductThumb
   {
       
      
      public function BgProductThumb()
      {
         super();
      }
      
      override protected function get tileWidth() : Number
      {
         return AnimeConstants.TILE_BACKGROUND_WIDTH;
      }
      
      override protected function get tileHeight() : Number
      {
         return AnimeConstants.TILE_BACKGROUND_HEIGHT;
      }
      
      override protected function createThumbnail(param1:DisplayObject, param2:IProduct) : ThumbnailCanvas
      {
         return super.createThumbnail(param1,param2);
      }
   }
}
