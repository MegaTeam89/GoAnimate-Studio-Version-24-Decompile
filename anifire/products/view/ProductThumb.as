package anifire.products.view
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.components.studio.ILock;
   import anifire.constant.AnimeConstants;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductImage;
   import anifire.interfaces.IProductThumb;
   import anifire.products.AbstractProductImageFactory;
   import anifire.products.ProductImage;
   import anifire.products.ProductThumbImageFactory;
   import anifire.util.UtilLicense;
   import anifire.util.UtilSite;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.effects.Fade;
   
   public class ProductThumb extends Canvas implements IProductThumb
   {
       
      
      private var _image:DisplayObject;
      
      private var _imageHolder:Image;
      
      private var _thumbCanvas:ThumbnailCanvas;
      
      private var _product:IProduct;
      
      private var _colorSetId:String = "";
      
      public function ProductThumb()
      {
         super();
         this._imageHolder = new Image();
         this._imageHolder.graphics.beginFill(0,0);
         this._imageHolder.drawRoundRect(0,0,this.tileWidth,this.tileHeight);
         this._imageHolder.graphics.endFill();
         this.width = this.tileWidth;
         this.height = this.tileHeight;
         this.scrollRect = new Rectangle(0,0,this.tileWidth,this.tileHeight);
      }
      
      public function set colorSetId(param1:String) : void
      {
         if(param1)
         {
            this._colorSetId = param1;
         }
      }
      
      public function get colorSetId() : String
      {
         return this._colorSetId;
      }
      
      protected function get thumbCanvas() : ThumbnailCanvas
      {
         return this._thumbCanvas;
      }
      
      protected function get tileWidth() : Number
      {
         return AnimeConstants.TILE_PROP_WIDTH;
      }
      
      protected function get tileHeight() : Number
      {
         return AnimeConstants.TILE_PROP_HEIGHT;
      }
      
      public function set locked(param1:ILock) : void
      {
         if(this._thumbCanvas)
         {
            this._thumbCanvas.locked = param1;
         }
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
         if(param1)
         {
            this._product = param1;
            if(UtilLicense.shouldShowToolTipForCurrentLicensor())
            {
               this._imageHolder.toolTip = this._product.name;
            }
            if(UtilSite.isDevelopmentSite)
            {
               this._imageHolder.toolTip = this._product.toString();
            }
            if(this._image && this._imageHolder.contains(this._image))
            {
               this._image.removeEventListener(Event.COMPLETE,this.onImageReady);
               this._imageHolder.removeChild(this._image);
            }
            this._image = this.createImage(this._product);
            if(this._image)
            {
               this._image.addEventListener(Event.COMPLETE,this.onImageReady);
               this._imageHolder.addChild(this._image);
            }
            this._thumbCanvas = this.createThumbnail(this._imageHolder,this.product);
            this.addChild(this._thumbCanvas);
            this._imageHolder.addEventListener(MouseEvent.MOUSE_DOWN,this.product.doDrag);
         }
      }
      
      protected function createImage(param1:IProduct) : DisplayObject
      {
         var _loc2_:AbstractProductImageFactory = new ProductThumbImageFactory();
         var _loc3_:IProductImage = _loc2_.createImage(param1);
         if(_loc3_ is ProductImage)
         {
            ProductImage(_loc3_).colorSetId = this._colorSetId;
         }
         _loc3_.product = param1;
         if(_loc3_ is DisplayObject)
         {
            return _loc3_ as DisplayObject;
         }
         return null;
      }
      
      protected function createThumbnail(param1:DisplayObject, param2:IProduct) : ThumbnailCanvas
      {
         return new ThumbnailCanvas(this.tileWidth,this.tileHeight,param1,param2,false,false,true,this._colorSetId);
      }
      
      private function onImageReady(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Fade = null;
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageReady);
         if(param1.target is DisplayObject)
         {
            _loc2_ = DisplayObject(param1.target);
            _loc3_ = new Fade(_loc2_);
            _loc3_.alphaFrom = 0;
            _loc3_.alphaTo = 1;
            _loc3_.duration = 500;
            _loc3_.play();
         }
      }
   }
}
