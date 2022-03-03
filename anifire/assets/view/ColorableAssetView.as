package anifire.assets.view
{
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IColorable;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class ColorableAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function ColorableAssetView(param1:IAssetView)
      {
         super(param1);
         this.addAssetEventListeners(param1.asset);
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
         if(super.asset is IColorable)
         {
            this.coloringImage(super.asset as IColorable);
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
            param1.addEventListener(AssetEvent.COLOR_CHANGE,this.onAssetColorChange);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(AssetEvent.COLOR_CHANGE,this.onAssetColorChange);
         }
      }
      
      private function onAssetColorChange(param1:AssetEvent) : void
      {
         if(param1.asset is IColorable)
         {
            this.coloringImage(param1.asset as IColorable);
         }
      }
      
      private function coloringImage(param1:IColorable) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         if(super.assetImage is IColorable)
         {
            IColorable(super.assetImage).restoreColor();
            if(param1.customColor.length > 0)
            {
               _loc2_ = 0;
               while(_loc2_ < param1.customColor.length)
               {
                  _loc3_ = param1.customColor.getKey(_loc2_);
                  _loc4_ = param1.customColor.getValueByIndex(_loc2_)["dstColor"];
                  IColorable(super.assetImage).changeColor(_loc3_,_loc4_);
                  _loc2_++;
               }
            }
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
      }
   }
}
