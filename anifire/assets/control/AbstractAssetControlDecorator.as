package anifire.assets.control
{
   import anifire.interfaces.IAssetControl;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import mx.core.UIComponent;
   
   public class AbstractAssetControlDecorator extends UIComponent implements IAssetControl
   {
       
      
      private var _decorated:IAssetControl;
      
      public function AbstractAssetControlDecorator(param1:IAssetControl)
      {
         super();
         this._decorated = param1;
         this.addChild(param1 as DisplayObject);
      }
      
      protected function get decorated() : IAssetControl
      {
         if(this._decorated == null)
         {
            throw new Error("This object has been destroyed, but this is still being referred and used somewhere else, find it out!!!");
         }
         return this._decorated;
      }
      
      public function get border() : UIComponent
      {
         return this.decorated.border;
      }
      
      public function get asset() : IEventDispatcher
      {
         return this.decorated.asset;
      }
      
      public function get borderWidth() : Number
      {
         return this.decorated.drawingScale * AssetControl.BORDER_WIDTH;
      }
      
      public function set drawingScale(param1:Number) : void
      {
         this.decorated.drawingScale = param1;
      }
      
      public function get drawingScale() : Number
      {
         return this.decorated.drawingScale;
      }
      
      public function set asset(param1:IEventDispatcher) : void
      {
         this.decorated.asset = param1;
      }
      
      public function destroy(param1:String = "rip") : void
      {
         this.decorated.destroy(param1);
         this.removeChild(this._decorated as DisplayObject);
         this._decorated = null;
      }
   }
}
