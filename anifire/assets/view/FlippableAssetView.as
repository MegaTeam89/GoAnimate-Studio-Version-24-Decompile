package anifire.assets.view
{
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IFlippable;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class FlippableAssetView extends AbstractAssetViewDecorator
   {
       
      
      private var _isFlipped:Boolean = false;
      
      public function FlippableAssetView(param1:IAssetView)
      {
         super(param1);
         this.addAssetEventListeners(param1.asset);
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
         this.updateDecorated();
      }
      
      private function updateDecorated() : void
      {
         if(decorated.asset is IFlippable)
         {
            this.flipImage(decorated.asset as IFlippable);
         }
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         this.removeAssetEventListeners(super.asset);
         super.destroy(param1);
      }
      
      private function flipImage(param1:IFlippable) : void
      {
         if(param1 && this._isFlipped != param1.isFlipped)
         {
            if(this.assetImage is DisplayObject)
            {
               try
               {
                  this._isFlipped = param1.isFlipped;
                  this.scaleX *= -1;
                  if(this.assetImage is IFlippable)
                  {
                     IFlippable(super.assetImage).flipIt();
                  }
                  this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
               }
               catch(e:Error)
               {
               }
            }
         }
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(AssetEvent.ASSET_HFLIPPED,this.onAssetHFlipped);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.ASSET_HFLIPPED,this.onAssetHFlipped);
         }
      }
      
      private function onAssetHFlipped(param1:AssetEvent) : void
      {
         this.flipImage(param1.asset as IFlippable);
      }
   }
}
