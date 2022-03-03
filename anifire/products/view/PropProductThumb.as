package anifire.products.view
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.interfaces.IProduct;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class PropProductThumb extends ProductThumb
   {
       
      
      public function PropProductThumb()
      {
         super();
         this.scrollRect = new Rectangle(0,0,this.tileWidth + 5,this.tileHeight + 5);
      }
      
      override protected function createThumbnail(param1:DisplayObject, param2:IProduct) : ThumbnailCanvas
      {
         return new ThumbnailCanvas(this.tileWidth,this.tileHeight,param1,param2,false,false,true,this.colorSetId,true,0,true);
      }
   }
}
