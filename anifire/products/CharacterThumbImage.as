package anifire.products
{
   import anifire.color.SelectedColor;
   import anifire.component.CCThumb;
   import anifire.constant.AnimeConstants;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.interfaces.ICharProduct;
   import anifire.util.BitmapManager;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilHashBytes;
   import anifire.util.UtilPlain;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.containers.Canvas;
   import mx.controls.Image;
   
   public class CharacterThumbImage extends ProductImage
   {
       
      
      public function CharacterThumbImage()
      {
         super();
      }
      
      override protected function buildImage(param1:Object) : void
      {
         var _loc2_:CCThumb = null;
         var _loc4_:ICharProduct = null;
         var _loc5_:Object = null;
         var _loc6_:Loader = null;
         var _loc3_:Image = new Image();
         this.removeAllChildren();
         this.addChild(_loc3_);
         if(param1 && this.product is ICharProduct)
         {
            if((_loc4_ = this.product as ICharProduct).imageData is ByteArray)
            {
               _loc4_.useImageAsThumb = true;
            }
            if(_loc4_.raceCode == 0 || _loc4_.useImageAsThumb)
            {
               _loc6_ = new Loader();
               _loc3_.addChild(_loc6_);
               _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageReady);
               if(_loc4_.useImageAsThumb)
               {
                  _loc6_.loadBytes(ByteArray(_loc4_.imageData));
               }
               else
               {
                  _loc6_.loadBytes(ByteArray(_loc4_.imageData["figure"]));
               }
            }
            else if(_loc4_.raceCode == 1)
            {
               _loc2_ = new CCThumb();
               _loc3_.addChild(_loc2_);
               _loc5_ = _loc4_.imageData as Object;
               _loc2_.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onImageReady);
               _loc2_.init(_loc5_["xml"] as XML,_loc5_["imageData"] as UtilHashBytes,_loc4_.getLibraries());
            }
            else if(_loc4_.raceCode == 2)
            {
               _loc2_ = new CCThumb();
               _loc3_.addChild(_loc2_);
               _loc5_ = _loc4_.imageData as Object;
               _loc2_.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onImageReady);
               _loc2_.init(_loc5_["xml"] as XML,_loc5_["imageData"] as UtilHashBytes,_loc4_.getLibraries(),_loc4_.raceCode,_loc5_["figure"]);
            }
         }
      }
      
      private function onImageReady(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:Image = null;
         var _loc13_:Rectangle = null;
         var _loc14_:MovieClip = null;
         var _loc15_:BitmapData = null;
         var _loc16_:Bitmap = null;
         var _loc17_:ByteArray = null;
         var _loc18_:Image = null;
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageReady);
         if(param1 is LoadEmbedMovieEvent)
         {
            _loc2_ = null;
            _loc3_ = CCThumb(param1.currentTarget) as CCThumb;
            _loc4_ = Image(CCThumb(param1.currentTarget).parent);
         }
         else
         {
            _loc2_ = Loader(param1.target.loader);
            _loc3_ = _loc2_.content;
            _loc4_ = Image(_loc2_.parent);
         }
         var _loc5_:Canvas = Canvas(_loc4_.parent);
         if(_loc2_ != null && !(_loc3_ is Bitmap))
         {
            if((_loc14_ = UtilPlain.getCharacterFlip(MovieClip(_loc3_))) != null)
            {
               _loc14_.visible = false;
            }
         }
         var _loc6_:Number = _loc3_.width;
         var _loc7_:Number = _loc3_.height;
         var _loc8_:Number = 1;
         var _loc9_:Number = AnimeConstants.TILE_CHAR_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc10_:Number = AnimeConstants.TILE_CHAR_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         var _loc11_:Number = _loc3_.width;
         var _loc12_:Number = _loc3_.height;
         if(_loc2_ != null)
         {
            if(!(_loc6_ <= _loc9_ && _loc7_ <= _loc10_))
            {
               if(_loc6_ > _loc9_ && _loc7_ <= _loc10_)
               {
                  _loc8_ = _loc9_ / _loc6_;
                  _loc11_ = _loc9_;
                  _loc12_ *= _loc8_;
               }
               else if(_loc6_ <= _loc9_ && _loc7_ > _loc10_)
               {
                  _loc8_ = _loc10_ / _loc7_;
                  _loc11_ *= _loc8_;
                  _loc12_ = _loc10_;
               }
               else
               {
                  _loc8_ = _loc9_ / _loc6_;
                  if(_loc7_ * _loc8_ > _loc10_)
                  {
                     _loc8_ = _loc10_ / _loc7_;
                     _loc11_ *= _loc8_;
                     _loc12_ = _loc10_;
                  }
                  else
                  {
                     _loc11_ = _loc9_;
                     _loc12_ *= _loc8_;
                  }
               }
            }
         }
         if(_loc11_ != _loc3_.width || _loc12_ != _loc3_.height)
         {
            if(_loc2_ != null)
            {
               if(!(_loc3_ is Bitmap))
               {
                  _loc3_.width = _loc11_;
                  _loc3_.height = _loc12_;
               }
            }
         }
         if(_loc2_ != null)
         {
            if(_loc3_ is Bitmap)
            {
               _loc15_ = BitmapManager.resampleDisplayObject(_loc3_,_loc8_);
               _loc16_ = new Bitmap(_loc15_);
               _loc4_.removeChildAt(0);
               _loc4_.addChild(_loc16_);
               _loc16_.x = (AnimeConstants.TILE_CHAR_WIDTH - _loc16_.width) / 2;
               _loc16_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc16_.height) / 2;
            }
            else
            {
               _loc13_ = _loc2_.getBounds(_loc2_);
               _loc2_.x = AnimeConstants.TILE_CHAR_WIDTH / 2;
               _loc2_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc3_.height) / 2;
               _loc2_.y -= _loc13_.top;
            }
         }
         else
         {
            _loc3_.x = (AnimeConstants.TILE_CHAR_WIDTH - _loc3_.width) / 2;
            _loc3_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc3_.height) / 2;
         }
         UtilPlain.stopFamily(_loc3_);
         this.updateThumbColor(_loc3_);
         if(this.product is ICharProduct)
         {
            if(_loc17_ = ICharProduct(this.product).propImageData as ByteArray)
            {
               _loc2_ = new Loader();
               _loc18_ = new Image();
               this.addChild(_loc18_);
               _loc18_.addChild(_loc2_);
               _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPropImageReady);
               _loc2_.loadBytes(_loc17_);
            }
         }
         else
         {
            dispatchImageReady();
         }
      }
      
      private function onPropImageReady(param1:Event) : void
      {
         this.addWearClipToHeadContainer(LoaderInfo(param1.target).loader,this);
         dispatchImageReady();
      }
      
      private function addWearClipToHeadContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if((_loc5_ = UtilPlain.getHead(_loc4_)) != null)
            {
               param1.name = AnimeConstants.MOVIECLIP_THE_WEAR;
               _loc5_.addChild(param1);
            }
         }
      }
      
      private function updateWearPosition(param1:DisplayObjectContainer) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:DisplayObject = null;
         var _loc5_:uint = 0;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(param1,"theTop");
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            if(param1.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha != 0)
            {
               _loc3_ = param1.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).getBounds(param1).y;
            }
            else
            {
               _loc5_ = 0;
               _loc5_ = param1.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = param1.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_HEAD && _loc4_.name != AnimeConstants.MOVIECLIP_THE_WEAR)
                  {
                     _loc3_ = _loc4_.getBounds(param1).y;
                     break;
                  }
                  _loc5_--;
               }
            }
            _loc2_.y = _loc3_;
         }
      }
      
      private function updateWearSize(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         if(param1)
         {
            try
            {
               param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(param2,this as DisplayObjectContainer,UtilPlain.PROPERTY_SCALEX));
               param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(param2,this as DisplayObjectContainer,UtilPlain.PROPERTY_SCALEY));
            }
            catch(e:Error)
            {
            }
         }
      }
      
      override protected function updateThumbColor(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:XML = null;
         var _loc4_:UtilHashArray = null;
         var _loc5_:int = 0;
         var _loc6_:SelectedColor = null;
         if(this.colorSetId && this.colorSetId != "" && this.product is ICharProduct && ICharProduct(this.product).isCC == false)
         {
            _loc3_ = this.product.colorRef.getValueByKey(this.colorSetId);
            _loc4_ = new UtilHashArray();
            _loc5_ = 0;
            while(_loc5_ < _loc3_.color.length())
            {
               _loc6_ = new SelectedColor(_loc3_.color[_loc5_].@r,_loc3_.color[_loc5_].attribute("oc").length() == 0 ? uint(uint.MAX_VALUE) : uint(_loc3_.color[_loc5_].@oc),uint(_loc3_.color[_loc5_]));
               _loc4_.push(_loc3_.color[_loc5_].@r,_loc6_);
               _loc5_++;
            }
            if(_loc4_.length > 0)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc4_.length)
               {
                  UtilColor.setAssetPartColor(param1,_loc4_.getKey(_loc2_),SelectedColor(_loc4_.getValueByIndex(_loc2_)).dstColor);
                  _loc2_++;
               }
            }
         }
      }
   }
}
