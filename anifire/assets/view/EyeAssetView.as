package anifire.assets.view
{
   import anifire.events.AssetEvent;
   import anifire.events.CharacterAssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IEye;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class EyeAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function EyeAssetView(param1:IAssetView)
      {
         super(param1);
         this.addAssetEventListeners(param1.asset);
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
         if(super.asset is IEye)
         {
            this.setEye(super.asset as IEye);
         }
      }
      
      private function setEye(param1:IEye) : void
      {
         if(super.assetImage is IEye)
         {
            IEye(super.assetImage).lookAtCamera = param1.lookAtCamera;
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
            param1.addEventListener(CharacterAssetEvent.EYE_CHANGE,this.onEyeChanged);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(CharacterAssetEvent.EYE_CHANGE,this.onEyeChanged);
         }
      }
      
      private function onEyeChanged(param1:AssetEvent) : void
      {
         if(param1.asset is IEye)
         {
            this.setEye(param1.asset as IEye);
         }
      }
   }
}
