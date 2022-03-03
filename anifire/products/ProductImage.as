package anifire.products
{
   import anifire.color.SelectedColor;
   import anifire.event.CoreEvent;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductImage;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashArray;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import mx.containers.Canvas;
   
   public class ProductImage extends Canvas implements IProductImage
   {
       
      
      private var _product:IProduct;
      
      private var _colorSetId:String = "";
      
      public function ProductImage()
      {
         super();
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
      
      public function get product() : IProduct
      {
         return this._product;
      }
      
      public function set product(param1:IProduct) : void
      {
         if(param1)
         {
            this._product = param1;
            if(this._product.imageData)
            {
               this.buildImage(this._product.imageData);
            }
            else if(this._product is IEventDispatcher)
            {
               IEventDispatcher(this._product).addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,this.onImageDataReady);
               this._product.loadImageData();
            }
         }
      }
      
      protected function buildImage(param1:Object) : void
      {
         this.removeAllChildren();
      }
      
      private function onImageDataReady(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageDataReady);
         this.buildImage(this._product.imageData);
      }
      
      protected function dispatchImageReady() : void
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      protected function updateThumbColor(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:XML = null;
         var _loc4_:UtilHashArray = null;
         var _loc5_:int = 0;
         var _loc6_:SelectedColor = null;
         if(this._colorSetId && this._colorSetId != "")
         {
            _loc3_ = this.product.colorRef.getValueByKey(this._colorSetId);
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
