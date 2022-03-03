package anifire.scene.view
{
   import anifire.interfaces.ISceneModel;
   import anifire.interfaces.ISceneView;
   import flash.events.IEventDispatcher;
   import mx.containers.Canvas;
   
   public class AbstractSceneView extends Canvas implements ISceneView
   {
       
      
      private var _sceneModel:ISceneModel;
      
      public function AbstractSceneView()
      {
         super();
      }
      
      public function set sceneModel(param1:ISceneModel) : void
      {
         if(param1)
         {
            if(this._sceneModel)
            {
               this.removeEventListeners(this._sceneModel);
               this.unloadAllAssets();
            }
            this._sceneModel = param1;
            this.loadAllAssets();
            this.addEventListeners(this._sceneModel);
         }
      }
      
      protected function addEventListeners(param1:IEventDispatcher) : void
      {
      }
      
      protected function removeEventListeners(param1:IEventDispatcher) : void
      {
      }
      
      protected function unloadAllAssets() : void
      {
      }
      
      protected function loadAllAssets() : void
      {
      }
      
      public function get sceneModel() : ISceneModel
      {
         return this._sceneModel;
      }
   }
}
