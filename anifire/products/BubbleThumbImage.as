package anifire.products
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleMgr;
   import anifire.constant.AnimeConstants;
   import anifire.event.CoreEvent;
   import anifire.interfaces.IBubbleProduct;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductImage;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.containers.Canvas;
   import mx.controls.Image;
   
   public class BubbleThumbImage extends Canvas implements IProductImage
   {
      
      private static const Glegoo:Class = BubbleThumbImage_Glegoo;
      
      private static const Honey:Class = BubbleThumbImage_Honey;
      
      private static const IHate:Class = BubbleThumbImage_IHate;
      
      private static const Woodstamp:Class = BubbleThumbImage_Woodstamp;
      
      private static const Arial:Class = BubbleThumbImage_Arial;
      
      private static const ComingSoon:Class = BubbleThumbImage_ComingSoon;
      
      private static const LilitaOne:Class = BubbleThumbImage_LilitaOne;
       
      
      private var _product:IProduct;
      
      public function BubbleThumbImage()
      {
         super();
      }
      
      public function set product(param1:IProduct) : void
      {
         var _loc2_:IBubbleProduct = null;
         var _loc3_:Image = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:Bubble = null;
         var _loc6_:Rectangle = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(param1 && param1 is IBubbleProduct)
         {
            this._product = param1;
            this.removeAllChildren();
            _loc2_ = param1 as IBubbleProduct;
            if(_loc2_.isShowMsg)
            {
               _loc2_.addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,this.onImageDataReady);
               _loc2_.loadImageData();
            }
            else
            {
               _loc3_ = new Image();
               this.addChild(_loc3_);
               if(param1.id == "blank2")
               {
                  _loc4_ = new Woodstamp() as DisplayObject;
                  _loc3_.addChild(_loc4_);
               }
               else if(param1.id == "blank3")
               {
                  _loc4_ = new Glegoo() as DisplayObject;
                  _loc3_.addChild(_loc4_);
               }
               else if(param1.id == "blank4")
               {
                  _loc4_ = new Honey() as DisplayObject;
                  _loc3_.addChild(_loc4_);
               }
               else if(param1.id == "blank5")
               {
                  _loc4_ = new IHate() as DisplayObject;
                  _loc3_.addChild(_loc4_);
               }
               else if(param1.id == "blank6")
               {
                  _loc4_ = new Arial() as DisplayObject;
                  _loc3_.addChild(_loc4_);
               }
               else if(param1.id == "blank7")
               {
                  _loc4_ = new LilitaOne() as DisplayObject;
                  _loc3_.addChild(_loc4_);
               }
               else if(param1.id == "blank8")
               {
                  _loc4_ = new ComingSoon() as DisplayObject;
                  _loc3_.addChild(_loc4_);
               }
               else
               {
                  (_loc5_ = BubbleMgr.getBubbleByXML(XML(_loc2_.imageData))).text = "";
                  _loc3_.addChild(_loc5_);
                  _loc6_ = _loc5_.getSize();
                  _loc7_ = 1;
                  _loc8_ = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
                  _loc9_ = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
                  if(!(_loc6_.width <= _loc8_ && _loc6_.height <= _loc9_))
                  {
                     if(_loc6_.width > _loc8_ && _loc6_.height <= _loc9_)
                     {
                        _loc7_ = _loc8_ / _loc6_.width;
                     }
                     else if(_loc6_.width <= _loc8_ && _loc6_.height > _loc9_)
                     {
                        _loc7_ = _loc9_ / _loc6_.height;
                     }
                     else
                     {
                        _loc7_ = _loc8_ / _loc6_.width;
                        if(_loc6_.height * _loc7_ > _loc9_)
                        {
                           _loc7_ = _loc9_ / _loc6_.height;
                        }
                     }
                  }
                  this.scaleX = _loc7_;
                  this.scaleY = _loc7_;
                  _loc5_.stopAfterRedraw = true;
                  this.move(AnimeConstants.TILE_BUBBLE_WIDTH / 2,AnimeConstants.TILE_BUBBLE_HEIGHT / 2);
               }
               this.dispatchImageReady();
            }
         }
      }
      
      private function onImageDataReady(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageDataReady);
         var _loc2_:Image = new Image();
         this.addChild(_loc2_);
         var _loc3_:Loader = new Loader();
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageReady);
         _loc3_.loadBytes(ByteArray(IBubbleProduct(this._product).thumbImageData));
         _loc2_.addChild(_loc3_);
      }
      
      private function onImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageReady);
         var _loc2_:Loader = param1.target.loader as Loader;
         var _loc3_:Rectangle = new Rectangle(AnimeConstants.TILE_INSETS,AnimeConstants.TILE_INSETS,AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2,AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2);
         this.dispatchImageReady();
      }
      
      protected function dispatchImageReady() : void
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
