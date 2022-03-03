package anifire.assets.view
{
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IMovable;
   import flash.events.IEventDispatcher;
   
   public class MovableAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function MovableAssetView(param1:IAssetView)
      {
         super(param1);
         if(param1.asset is IMovable)
         {
            this.moveImage(param1.asset as IMovable);
         }
         this.addAssetEventListeners(param1.asset);
      }
      
      private function moveImage(param1:IMovable) : void
      {
         this.move(param1.x,param1.y);
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
            param1.addEventListener(AssetEvent.ASSET_MOVED,this.onAssetMoved);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.ASSET_MOVED,this.onAssetMoved);
         }
      }
      
      private function onAssetMoved(param1:AssetEvent) : void
      {
         if(param1.asset is IMovable)
         {
            this.moveImage(param1.asset as IMovable);
         }
      }
   }
}
