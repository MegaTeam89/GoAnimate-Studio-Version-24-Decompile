package anifire.assets.view
{
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IRotatable;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class RotatableAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function RotatableAssetView(param1:IAssetView)
      {
         super(param1);
         if(param1.asset is IRotatable)
         {
            this.rotateImage(param1.asset as IRotatable);
         }
         param1.addEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onDecoratedLoadComplete);
         this.addAssetEventListeners(param1.asset);
      }
      
      private function onDecoratedLoadComplete(param1:Event) : void
      {
         this.rotateImage(decorated.asset as IRotatable);
      }
      
      private function rotateImage(param1:IRotatable) : void
      {
         if(param1)
         {
            this.rotation = param1.rotation;
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         decorated.removeEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onDecoratedLoadComplete);
         this.removeAssetEventListeners(super.asset);
         super.destroy(param1);
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(AssetEvent.ASSET_ROTATED,this.onAssetRotated);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.ASSET_ROTATED,this.onAssetRotated);
         }
      }
      
      private function onAssetRotated(param1:AssetEvent) : void
      {
         if(param1.asset is IRotatable)
         {
            this.rotateImage(param1.asset as IRotatable);
         }
      }
   }
}
