package anifire.products.view
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.core.CharThumb;
   import anifire.events.AssetPurchasedEvent;
   import anifire.events.CopyThumbEvent;
   import anifire.interfaces.IProduct;
   import anifire.util.UtilNavigate;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class CharProductThumb extends ProductThumb
   {
       
      
      public function CharProductThumb()
      {
         super();
      }
      
      public function set copyable(param1:Boolean) : void
      {
         if(thumbCanvas)
         {
            thumbCanvas.copyable = param1;
         }
      }
      
      override protected function get tileWidth() : Number
      {
         return AnimeConstants.TILE_CHAR_WIDTH;
      }
      
      override protected function get tileHeight() : Number
      {
         return AnimeConstants.TILE_CHAR_HEIGHT;
      }
      
      override protected function createThumbnail(param1:DisplayObject, param2:IProduct) : ThumbnailCanvas
      {
         var _loc3_:ThumbnailCanvas = super.createThumbnail(param1,param2);
         if((param2 as CharThumb).isCC)
         {
            _loc3_.addEventListener(CopyThumbEvent.USER_WANT_TO_COPY_THUMB,this.onCopy);
            _loc3_.addEventListener(AssetPurchasedEvent.ASSET_PURCHASED,this.onPurchased);
         }
         return _loc3_;
      }
      
      private function onPurchased(param1:Event) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function onCopy(param1:CopyThumbEvent) : void
      {
         if(param1 && param1.thumb)
         {
            UtilNavigate.goCopyCc(param1.thumb.xml.@cc_theme_id,!!param1.thumb.encryptId ? param1.thumb.encryptId : param1.thumb.id);
         }
      }
   }
}
