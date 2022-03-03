package anifire.products
{
   import anifire.constant.AnimeConstants;
   import anifire.effect.SuperEffect;
   import anifire.event.EffectEvt;
   import anifire.interfaces.IEffectProduct;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   
   public class EffectThumbImage extends ProductImage
   {
       
      
      public function EffectThumbImage()
      {
         super();
      }
      
      override protected function buildImage(param1:Object) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc2_:IEffectProduct = this.product as IEffectProduct;
         var _loc3_:SuperEffect = _loc2_.getNewEffect();
         this.visible = false;
         _loc3_.addEventListener(EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE,this.onImageReady);
         _loc4_ = _loc3_.loadThumbnail(param1 as ByteArray);
         var _loc5_:Image;
         (_loc5_ = new Image()).addChild(_loc4_);
         this.removeAllChildren();
         this.addChild(_loc5_);
      }
      
      private function onImageReady(param1:EffectEvt) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageReady);
         var _loc2_:DisplayObject = param1.thumbnail;
         var _loc3_:Rectangle = _loc2_.getBounds(_loc2_);
         var _loc4_:Number = 1;
         var _loc5_:Number = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc6_:Number = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc3_.width <= _loc5_ && _loc3_.height <= _loc6_))
         {
            if(_loc3_.width > _loc5_ && _loc3_.height <= _loc6_)
            {
               _loc4_ = _loc5_ / _loc3_.width;
            }
            else if(_loc3_.width <= _loc5_ && _loc3_.height > _loc6_)
            {
               _loc4_ = _loc6_ / _loc3_.height;
            }
            else
            {
               _loc4_ = _loc5_ / _loc3_.width;
               if(_loc3_.height * _loc4_ > _loc6_)
               {
                  _loc4_ = _loc6_ / _loc3_.height;
               }
            }
         }
         _loc2_.scaleX = _loc4_;
         _loc2_.scaleY = _loc4_;
         _loc2_.x = -1 * (_loc3_.left + _loc3_.right) / 2 * _loc4_ + AnimeConstants.TILE_BUBBLE_WIDTH / 2;
         _loc2_.y = -1 * (_loc3_.top + _loc3_.bottom) / 2 * _loc4_ + AnimeConstants.TILE_BUBBLE_HEIGHT / 2;
         this.visible = true;
         dispatchImageReady();
      }
   }
}
