package anifire.assets.motion
{
   import anifire.assets.controller.AssetCollectionController;
   import anifire.assets.image.AssetCollectionImage;
   import anifire.assets.image.AssetImageFactory;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetImage;
   import flash.display.DisplayObject;
   import flash.filters.GlowFilter;
   import mx.core.UIComponent;
   
   public class CircularMotionShadowView extends UIComponent
   {
       
      
      private var _target:Object;
      
      private var _image:UIComponent;
      
      public function CircularMotionShadowView()
      {
         super();
      }
      
      public function set target(param1:Object) : void
      {
         this._target = param1;
         this.createView();
      }
      
      public function createView() : void
      {
         var _loc1_:AssetImageFactory = null;
         if(this._image is DisplayObject)
         {
            this.removeChild(this._image as DisplayObject);
            this._image = null;
         }
         if(this._target)
         {
            if(this._target is IAsset)
            {
               _loc1_ = new AssetImageFactory();
               this._image = _loc1_.createImage(this._target as IAsset) as UIComponent;
               if(this._image is IAssetImage)
               {
                  IAssetImage(this._image).asset = this._target as IAsset;
               }
            }
            else if(this._target is AssetCollectionController)
            {
               this._image = new AssetCollectionImage() as UIComponent;
               AssetCollectionImage(this._image).collection = AssetCollectionController(this._target).collection;
               this._image.x -= AssetCollectionController(this._target).width / 2;
               this._image.y -= AssetCollectionController(this._target).height / 2;
            }
            if(this._image)
            {
               this.addChild(this._image);
               this._image.buttonMode = true;
               this._image.alpha = 0.5;
               this._image.filters = [new GlowFilter(16777215,0,6,6,5)];
            }
         }
      }
   }
}
