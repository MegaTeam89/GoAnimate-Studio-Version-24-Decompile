package anifire.products.view
{
   import anifire.components.containers.SoundTileCell;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.components.studio.ILock;
   import anifire.core.SoundThumb;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductThumb;
   import mx.containers.Canvas;
   
   public class SoundProductThumb extends Canvas implements IProductThumb
   {
       
      
      private var _product:IProduct;
      
      private var _thumbCanvas:ThumbnailCanvas;
      
      public function SoundProductThumb()
      {
         super();
      }
      
      public function set locked(param1:ILock) : void
      {
      }
      
      public function set editable(param1:Boolean) : void
      {
         if(this._thumbCanvas)
         {
            this._thumbCanvas.editable = param1;
         }
      }
      
      public function get product() : IProduct
      {
         return this._product;
      }
      
      public function set product(param1:IProduct) : void
      {
         var _loc2_:SoundThumb = null;
         var _loc3_:SoundTileCell = null;
         if(param1 && param1 is SoundThumb)
         {
            this._product = param1;
            _loc2_ = SoundThumb(param1);
            _loc3_ = _loc2_.getTileCell();
            _loc3_.buttonMode = true;
            this._thumbCanvas = new ThumbnailCanvas(_loc3_.width,_loc3_.height,_loc3_,_loc2_,false,false,true);
            this.addChild(this._thumbCanvas);
         }
      }
   }
}
