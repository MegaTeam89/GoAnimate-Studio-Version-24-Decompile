package anifire.assets.image
{
   import anifire.constant.AnimeConstants;
   import anifire.core.EffectThumb;
   import anifire.effect.AnimeEffect;
   import anifire.effect.ProgramEffect;
   import anifire.effect.SuperEffect;
   import anifire.effect.ZoomEffect;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetImage;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IResizable;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   
   public class EffectAssetImage extends AbstractAssetImage implements IAssetImage, IResizable
   {
       
      
      private var _effect:SuperEffect;
      
      public function EffectAssetImage()
      {
         super();
      }
      
      public function set asset(param1:IAsset) : void
      {
         var _loc2_:IProduct = null;
         var _loc3_:Image = null;
         if(param1)
         {
            _loc2_ = param1.thumb as IProduct;
            if(_loc2_)
            {
               this._effect = (_loc2_ as EffectThumb).getNewEffect();
               this._effect.loadEffectImage(_loc2_.imageData as ByteArray);
               _loc3_ = new Image();
               if(this._effect is AnimeEffect)
               {
                  _loc3_.scrollRect = new Rectangle(0,AnimeConstants.screenY,AnimeConstants.SCREEN_WIDTH,AnimeConstants.screenHeight);
                  _loc3_.x = AnimeConstants.SCREEN_X;
                  _loc3_.y = AnimeConstants.screenY;
               }
               else if(this._effect is ProgramEffect)
               {
                  if(!(this._effect is ZoomEffect))
                  {
                     _loc3_.scrollRect = new Rectangle(0,AnimeConstants.screenY,AnimeConstants.SCREEN_WIDTH,AnimeConstants.screenHeight);
                     _loc3_.x = AnimeConstants.SCREEN_X;
                     _loc3_.y = AnimeConstants.screenY;
                  }
               }
               _loc3_.addChild(this._effect);
               this.addChild(_loc3_);
               super.rect.x = this._effect.x;
               super.rect.y = this._effect.y;
               super.rect.width = this._effect.width;
               super.rect.height = this._effect.height;
               this.dispatchImageReady();
            }
         }
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         if(this._effect)
         {
            this._effect.width = param1;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         if(this._effect)
         {
            this._effect.height = param1;
         }
      }
      
      public function resize(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         if(param1 != this.width || param2 != this.height)
         {
            this.width = param1;
            this.height = param2;
         }
      }
      
      public function showEffect(param1:DisplayObject) : void
      {
         if(param1 && this._effect is ProgramEffect)
         {
            this._effect.showEffect(param1);
         }
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         super.destroy(param1);
         if(this._effect is AnimeEffect)
         {
         }
         this._effect = null;
      }
      
      override public function pause() : void
      {
      }
      
      override public function resume() : void
      {
      }
   }
}
