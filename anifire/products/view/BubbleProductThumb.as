package anifire.products.view
{
   import anifire.components.studio.ILock;
   import anifire.constant.AnimeConstants;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductImage;
   import anifire.interfaces.IProductThumb;
   import anifire.products.BubbleThumbImage;
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
   
   public class BubbleProductThumb extends Canvas implements IProductThumb
   {
       
      
      private var _productImage:IProductImage;
      
      private var _imageHolder:Image;
      
      private var _product:IProduct;
      
      public function BubbleProductThumb()
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
      
      public function set locked(param1:ILock) : void
      {
      }
      
      public function set editable(param1:Boolean) : void
      {
      }
      
      protected function get tileWidth() : Number
      {
         return AnimeConstants.TILE_BUBBLE_WIDTH;
      }
      
      protected function get tileHeight() : Number
      {
         return AnimeConstants.TILE_BUBBLE_HEIGHT;
      }
      
      public function get product() : IProduct
      {
         return this._product;
      }
      
      public function set product(param1:IProduct) : void
      {
         var _loc2_:IProduct = null;
         var _loc3_:Canvas = null;
         if(param1)
         {
            this._product = param1;
            _loc2_ = IProduct(param1);
            if(UtilLicense.shouldShowToolTipForCurrentLicensor())
            {
               this._imageHolder.toolTip = _loc2_.name;
            }
            if(UtilSite.isDevelopmentSite)
            {
               this._imageHolder.toolTip = _loc2_.toString();
            }
            if(this._productImage is DisplayObject && this._imageHolder.contains(DisplayObject(this._productImage)))
            {
               this._imageHolder.removeChild(DisplayObject(this._productImage));
            }
            this._productImage = new BubbleThumbImage();
            if(this._productImage is IEventDispatcher)
            {
               IEventDispatcher(this._productImage).addEventListener(Event.COMPLETE,this.onImageReady);
            }
            this._productImage.product = _loc2_;
            if(this._productImage is DisplayObject)
            {
               this._imageHolder.addChild(DisplayObject(this._productImage));
            }
            _loc3_ = new Canvas();
            _loc3_.buttonMode = true;
            _loc3_.width = AnimeConstants.TILE_BUBBLE_WIDTH;
            _loc3_.height = AnimeConstants.TILE_BUBBLE_HEIGHT;
            _loc3_.scrollRect = new Rectangle(0,0,_loc3_.width,_loc3_.height);
            _loc3_.styleName = "tileBubble";
            _loc3_.addChild(this._imageHolder);
            this.addChild(_loc3_);
            this._imageHolder.addEventListener(MouseEvent.MOUSE_DOWN,_loc2_.doDrag);
         }
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
