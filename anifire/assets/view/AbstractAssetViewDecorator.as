package anifire.assets.view
{
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetView;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import mx.core.UIComponent;
   
   public class AbstractAssetViewDecorator extends UIComponent implements IAssetView
   {
       
      
      private var _decorated:IAssetView;
      
      private var _lastWords:String;
      
      public function AbstractAssetViewDecorator(param1:IAssetView)
      {
         super();
         this._decorated = param1;
         this.addChild(param1 as DisplayObject);
         param1.addEventListener(AssetViewEvent.VIEW_CHANGE,this.onDecoratedChange);
      }
      
      protected function onDecoratedChange(param1:Event) : void
      {
      }
      
      public function startProcess(param1:Boolean = false, param2:Number = 0) : void
      {
         this.loadImage();
      }
      
      public function loadImage() : void
      {
         this.decorated.loadImage();
      }
      
      public function get asset() : IAsset
      {
         return this.decorated.asset;
      }
      
      public function get assetImage() : DisplayObject
      {
         return this.decorated.assetImage;
      }
      
      public function destroy(param1:String = "rip") : void
      {
         this.decorated.removeEventListener(AssetViewEvent.VIEW_CHANGE,this.onDecoratedChange);
         this.decorated.destroy();
         this.removeChild(this.decorated as DisplayObject);
         this._decorated = null;
         this._lastWords = param1;
      }
      
      protected function get decorated() : IAssetView
      {
         if(this._decorated == null)
         {
            throw new Error("This object has been destroyed!!! Last words: " + this._lastWords);
         }
         return this._decorated;
      }
      
      public function goToAndPause(param1:Number) : void
      {
         this.pause();
      }
      
      public function pause() : void
      {
         this.decorated.pause();
      }
      
      public function resume() : void
      {
         this.decorated.resume();
      }
   }
}
