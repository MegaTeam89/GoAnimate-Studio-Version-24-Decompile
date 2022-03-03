package anifire.assets.view
{
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IScalable;
   import flash.events.IEventDispatcher;
   
   public class ScalableAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function ScalableAssetView(param1:IAssetView)
      {
         super(param1);
         if(param1.asset is IScalable)
         {
            this.scaleImage(param1.asset as IScalable);
         }
         this.addAssetEventListeners(param1.asset);
      }
      
      private function scaleImage(param1:IScalable) : void
      {
         this.scaleX = param1.scaleX;
         this.scaleY = param1.scaleY;
         this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         this.removeAssetEventListeners(super.asset);
         super.destroy(param1);
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(AssetEvent.ASSET_RESIZED,this.onAssetResized);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.ASSET_RESIZED,this.onAssetResized);
         }
      }
      
      private function onAssetResized(param1:AssetEvent) : void
      {
         if(param1.asset is IScalable)
         {
            this.scaleImage(param1.asset as IScalable);
         }
      }
   }
}
