package anifire.products.view
{
   import anifire.constant.AnimeConstants;
   
   public class EffectProductThumb extends ProductThumb
   {
       
      
      public function EffectProductThumb()
      {
         super();
      }
      
      override protected function get tileWidth() : Number
      {
         return AnimeConstants.TILE_BUBBLE_WIDTH;
      }
      
      override protected function get tileHeight() : Number
      {
         return AnimeConstants.TILE_BUBBLE_HEIGHT;
      }
   }
}
