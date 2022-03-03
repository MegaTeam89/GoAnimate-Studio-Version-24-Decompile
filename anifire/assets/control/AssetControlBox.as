package anifire.assets.control
{
   import anifire.assets.controller.AssetCollectionController;
   import anifire.assets.controller.AssetControllerFactory;
   import anifire.assets.view.AssetViewCollection;
   import anifire.core.Console;
   import anifire.interfaces.IAssetControl;
   import anifire.interfaces.IAssetController;
   import anifire.interfaces.IAssetView;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import mx.core.UIComponent;
   
   public class AssetControlBox extends UIComponent
   {
       
      
      private var _control:IAssetControl;
      
      private var _controller:IEventDispatcher;
      
      public function AssetControlBox()
      {
         super();
      }
      
      public function get controller() : IEventDispatcher
      {
         return this._controller;
      }
      
      public function set drawingScale(param1:Number) : void
      {
         if(this._control)
         {
            this._control.drawingScale = param1;
         }
      }
      
      public function set target(param1:Object) : void
      {
         if(this._control)
         {
            this._control.destroy();
            try
            {
               this.removeChild(this._control as DisplayObject);
            }
            catch(e:Error)
            {
            }
            this._control = null;
         }
         if(this._controller)
         {
            this._controller = null;
         }
         if(param1 is IAssetView)
         {
            this._controller = AssetControllerFactory.createController(param1 as IAssetView);
            if(this._controller is IAssetController)
            {
               IAssetController(this._controller).view = param1 as IAssetView;
            }
         }
         else if(param1 is AssetViewCollection)
         {
            this._controller = AssetControllerFactory.getCollectionController(param1 as AssetViewCollection);
            if(this._controller is AssetCollectionController)
            {
               AssetCollectionController(this._controller).collection = param1 as AssetViewCollection;
            }
         }
         if(this._controller)
         {
            this._control = AssetControlFactory.createControl(param1);
            if(this._control)
            {
               this._control.drawingScale = 1 / Console.getConsole().stageScale;
               this._control.asset = this._controller;
               this.addChild(this._control as DisplayObject);
            }
         }
      }
   }
}
