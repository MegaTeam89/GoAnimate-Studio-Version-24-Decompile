package anifire.assets.view
{
   import anifire.events.AssetViewEvent;
   import anifire.events.BubbleAssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IBubble;
   import anifire.interfaces.IBubbleTail;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class BubbleAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function BubbleAssetView(param1:IAssetView)
      {
         super(param1);
         param1.addEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onDecoratedLoadComplete);
         this.addAssetEventListeners(param1.asset);
      }
      
      private function onDecoratedLoadComplete(param1:Event) : void
      {
         this.updateDecorated();
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
      }
      
      private function updateDecorated() : void
      {
         if(decorated.asset is IBubble)
         {
            this.changeBgColor(decorated.asset as IBubble);
         }
         if(decorated.asset is IBubbleTail)
         {
            this.moveTail(decorated.asset as IBubbleTail);
         }
         if(decorated.asset is IBubble)
         {
            this.resizeBubble(decorated.asset as IBubble);
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
            param1.addEventListener(BubbleAssetEvent.BG_COLOR_CHANGE,this.onBgColorChange);
            param1.addEventListener(BubbleAssetEvent.TAIL_MOVED,this.onTailMoved);
            param1.addEventListener(BubbleAssetEvent.BUBBLE_RESIZED,this.onResized);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(BubbleAssetEvent.BG_COLOR_CHANGE,this.onBgColorChange);
            param1.removeEventListener(BubbleAssetEvent.TAIL_MOVED,this.onTailMoved);
            param1.removeEventListener(BubbleAssetEvent.BUBBLE_RESIZED,this.onResized);
         }
      }
      
      private function changeBgColor(param1:IBubble) : void
      {
         if(super.assetImage is IBubble)
         {
            IBubble(super.assetImage).bgColor = param1.bgColor;
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
      }
      
      private function moveTail(param1:IBubbleTail) : void
      {
         if(super.assetImage is IBubbleTail)
         {
            IBubbleTail(super.assetImage).tailX = param1.tailX;
            IBubbleTail(super.assetImage).tailY = param1.tailY;
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
      }
      
      private function resizeBubble(param1:IBubble) : void
      {
         if(super.assetImage is IBubble)
         {
            IBubble(super.assetImage).resizeBubble(param1.bubbleSize);
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
      }
      
      private function onBgColorChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubble)
         {
            this.changeBgColor(param1.asset as IBubble);
         }
      }
      
      private function onTailMoved(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleTail)
         {
            this.moveTail(param1.asset as IBubbleTail);
         }
      }
      
      private function onResized(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubble)
         {
            this.resizeBubble(param1.asset as IBubble);
         }
      }
   }
}
