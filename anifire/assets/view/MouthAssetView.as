package anifire.assets.view
{
   import anifire.events.AssetEvent;
   import anifire.events.CharacterAssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IMouth;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class MouthAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function MouthAssetView(param1:IAssetView)
      {
         super(param1);
         this.addAssetEventListeners(param1.asset);
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
         if(super.asset is IMouth)
         {
            this.setMouth(super.asset as IMouth);
         }
      }
      
      private function setMouth(param1:IMouth) : void
      {
         if(super.assetImage is IMouth)
         {
            IMouth(super.assetImage).demoSpeech = param1.demoSpeech;
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
            param1.addEventListener(CharacterAssetEvent.MOUTH_CHANGE,this.onMouthChanged);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(CharacterAssetEvent.MOUTH_CHANGE,this.onMouthChanged);
         }
      }
      
      private function onMouthChanged(param1:AssetEvent) : void
      {
         if(param1.asset is IMouth)
         {
            this.setMouth(param1.asset as IMouth);
         }
      }
   }
}
