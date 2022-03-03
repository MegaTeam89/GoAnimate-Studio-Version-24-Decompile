package anifire.assets.view
{
   import anifire.core.EffectAsset;
   import anifire.interfaces.IAssetCollection;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IIterator;
   import anifire.iterators.ArrayIterator;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class AssetEditor extends AbstractAssetViewDecorator implements IAssetCollection
   {
       
      
      private var _controller:AssetEditorController;
      
      public function AssetEditor(param1:IAssetView)
      {
         super(param1);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._controller = new AssetEditorController(this);
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this.dispatchEvent(param1);
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         if(this._controller)
         {
            this._controller.destroy();
            this._controller = null;
         }
         if(decorated)
         {
            decorated.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         super.destroy(param1);
      }
      
      public function addAsset(param1:IAssetCollection) : Boolean
      {
         return false;
      }
      
      public function removeAsset(param1:IAssetCollection) : Boolean
      {
         return false;
      }
      
      public function clearCollection() : void
      {
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         return new ArrayIterator([this]);
      }
      
      override public function getBounds(param1:DisplayObject) : Rectangle
      {
         if(this.asset is EffectAsset && EffectAsset(asset).isCamera)
         {
            return new Rectangle(EffectAsset(asset).x,EffectAsset(asset).y,EffectAsset(asset).width,EffectAsset(asset).height);
         }
         return super.getBounds(param1);
      }
   }
}
