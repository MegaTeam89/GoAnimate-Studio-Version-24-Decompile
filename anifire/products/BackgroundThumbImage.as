package anifire.products
{
   import anifire.constant.AnimeConstants;
   import anifire.util.Util;
   import anifire.util.UtilCommonLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   
   public class BackgroundThumbImage extends ProductImage
   {
       
      
      private var _loader:Loader;
      
      public function BackgroundThumbImage()
      {
         super();
         this._loader = new Loader();
         var _loc1_:Image = new Image();
         _loc1_.addChild(this._loader);
         this.addChild(_loc1_);
      }
      
      override protected function buildImage(param1:Object) : void
      {
         if(param1 is ByteArray)
         {
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageReady);
            this._loader.loadBytes(ByteArray(param1),UtilCommonLoader.externalLoaderContext);
         }
      }
      
      private function onImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageReady);
         this.resizeImage(param1.target.loader);
         dispatchImageReady();
      }
      
      private function resizeImage(param1:Loader) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Bitmap = null;
         var _loc2_:Image = Image(param1.parent);
         var _loc3_:DisplayObject = DisplayObject(param1.content);
         this.updateThumbColor(_loc3_);
         if(param1.contentLoaderInfo.content is Bitmap)
         {
            (_loc5_ = Bitmap(param1.contentLoaderInfo.content)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc5_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         }
         else
         {
            _loc4_ = Util.capturePicture(param1,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
            (_loc5_ = new Bitmap(_loc4_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc5_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         }
         _loc2_.removeChild(param1);
         _loc5_.smoothing = true;
         _loc2_.smoothBitmapContent = true;
         _loc2_.addChild(_loc5_);
         _loc5_.x = AnimeConstants.TILE_INSETS;
         _loc5_.y = AnimeConstants.TILE_INSETS;
      }
   }
}
