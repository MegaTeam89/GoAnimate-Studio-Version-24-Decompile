package anifire.assets.view
{
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IResizable;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class ResizableAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function ResizableAssetView(param1:IAssetView)
      {
         super(param1);
         if(param1.asset is IResizable)
         {
            this.resizeImage(param1.asset as IResizable);
         }
         this.addAssetEventListeners(param1.asset);
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
         if(decorated.asset is IResizable)
         {
            this.resizeImage(decorated.asset as IResizable);
         }
      }
      
      private function resizeImage(param1:IResizable) : void
      {
         if(super.assetImage is IResizable)
         {
            IResizable(super.assetImage).width = param1.width;
            IResizable(super.assetImage).height = param1.height;
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
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
         if(param1.asset is IResizable)
         {
            this.resizeImage(param1.asset as IResizable);
         }
      }
   }
}
