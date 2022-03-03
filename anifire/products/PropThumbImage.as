package anifire.products
{
   import anifire.constant.AnimeConstants;
   import anifire.interfaces.IPropProduct;
   import anifire.util.UtilCommonLoader;
   import anifire.util.UtilFileFormat;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   
   public class PropThumbImage extends ProductImage
   {
       
      
      private var _loader:Loader;
      
      public function PropThumbImage()
      {
         super();
         this._loader = new Loader();
         var _loc1_:Image = new Image();
         _loc1_.addChild(this._loader);
         this.addChild(_loc1_);
      }
      
      override protected function buildImage(param1:Object) : void
      {
         var _loc2_:IPropProduct = null;
         if(param1 is ByteArray)
         {
            if(this.product is IPropProduct)
            {
               _loc2_ = IPropProduct(this.product);
               if(UtilFileFormat.checkByteArrayMatchItsExt(_loc2_.getStateNum() > 0 ? _loc2_.defaultStateId : _loc2_.id,param1 as ByteArray))
               {
                  this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageReady);
                  this._loader.loadBytes(ByteArray(param1),UtilCommonLoader.externalLoaderContext);
               }
            }
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
         var _loc8_:DisplayObject = null;
         var _loc2_:Number = param1.content.width;
         var _loc3_:Number = param1.content.height;
         var _loc4_:Number = 1;
         var _loc5_:Number = AnimeConstants.TILE_PROP_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc6_:Number = AnimeConstants.TILE_PROP_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc2_ <= _loc5_ && _loc3_ <= _loc6_))
         {
            if(_loc2_ > _loc5_ && _loc3_ <= _loc6_)
            {
               _loc4_ = _loc5_ / _loc2_;
               param1.content.width = _loc5_;
               param1.content.height *= _loc4_;
            }
            else if(_loc2_ <= _loc5_ && _loc3_ > _loc6_)
            {
               _loc4_ = _loc6_ / _loc3_;
               param1.content.width *= _loc4_;
               param1.content.height = _loc6_;
            }
            else
            {
               _loc4_ = _loc5_ / _loc2_;
               if(_loc3_ * _loc4_ > _loc6_)
               {
                  _loc4_ = _loc6_ / _loc3_;
                  param1.content.width *= _loc4_;
                  param1.content.height = _loc6_;
               }
               else
               {
                  param1.content.width = _loc5_;
                  param1.content.height *= _loc4_;
               }
            }
         }
         var _loc7_:Rectangle = param1.getBounds(param1);
         param1.x = (AnimeConstants.TILE_PROP_WIDTH - param1.content.width) / 2;
         param1.y = (AnimeConstants.TILE_PROP_HEIGHT - param1.content.height) / 2;
         param1.x -= _loc7_.left;
         param1.y -= _loc7_.top;
         if(param1.content is MovieClip)
         {
            _loc8_ = DisplayObject(param1.content);
            UtilPlain.stopFamily(_loc8_);
         }
         this.updateThumbColor(_loc8_);
      }
   }
}
