package anifire.assets.view
{
   import anifire.assets.image.AssetImageFactory;
   import anifire.assets.image.CharacterAssetImage;
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetImage;
   import anifire.interfaces.IAssetView;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class AssetView extends AbstractAssetView implements IAssetView
   {
       
      
      private var _imageFactory:AssetImageFactory;
      
      private var _assetImage:IAssetImage;
      
      private var _newImage:IAssetImage;
      
      public function AssetView(param1:IAsset)
      {
         this._imageFactory = new AssetImageFactory();
         super();
         super.asset = param1;
         this.addAssetEventListeners(param1);
      }
      
      public function get assetImage() : DisplayObject
      {
         return this._assetImage as DisplayObject;
      }
      
      public function startProcess(param1:Boolean = false, param2:Number = 0) : void
      {
         this.loadImage();
      }
      
      public function loadImage() : void
      {
         this.createImage(super.asset);
      }
      
      private function createImage(param1:IAsset) : void
      {
         if(this._newImage)
         {
            this._newImage.removeEventListener(Event.COMPLETE,this.onImageReady);
         }
         this._newImage = this._imageFactory.createImage(param1);
         if(this._newImage)
         {
            this._newImage.addEventListener(Event.COMPLETE,this.onImageReady);
            this._newImage.asset = param1;
         }
      }
      
      private function onImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.currentTarget).removeEventListener(param1.type,this.onImageReady);
         if(this._assetImage)
         {
            try
            {
               this.removeChild(this._assetImage as DisplayObject);
            }
            catch(e:Error)
            {
            }
            this._assetImage.destroy();
         }
         this._assetImage = this._newImage;
         if(this._assetImage is DisplayObject)
         {
            this.addChild(this._assetImage as DisplayObject);
            if(this._assetImage is CharacterAssetImage)
            {
               DisplayObject(this._assetImage).blendMode = BlendMode.LAYER;
            }
         }
         this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_LOAD_COMPLETE,true));
         this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_IMAGE_CHANGE,true));
      }
      
      public function destroy(param1:String = "rip") : void
      {
         this.removeAssetEventListeners(super.asset);
         if(this._assetImage)
         {
            try
            {
               this.removeChild(this._assetImage as DisplayObject);
            }
            catch(e:Error)
            {
            }
            this._assetImage.destroy();
            this._assetImage = null;
         }
         if(this._newImage)
         {
            this._newImage.removeEventListener(Event.COMPLETE,this.onImageReady);
            this._newImage.destroy();
            this._newImage = null;
         }
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(AssetEvent.STATE_CHANGE,this.onAssetStateChange);
            param1.addEventListener(AssetEvent.ACTION_CHANGE,this.onAssetStateChange);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.STATE_CHANGE,this.onAssetStateChange);
            param1.removeEventListener(AssetEvent.ACTION_CHANGE,this.onAssetStateChange);
         }
      }
      
      private function onAssetStateChange(param1:AssetEvent) : void
      {
         if(param1.asset)
         {
            this.createImage(param1.asset);
         }
      }
      
      public function goToAndPause(param1:Number) : void
      {
         this.pause();
      }
      
      public function pause() : void
      {
         if(this._assetImage)
         {
            this._assetImage.pause();
         }
      }
      
      public function resume() : void
      {
         if(this._assetImage)
         {
            this._assetImage.resume();
         }
      }
   }
}
