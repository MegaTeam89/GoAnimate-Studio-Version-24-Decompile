package anifire.interfaces
{
   import flash.events.IEventDispatcher;
   
   public interface ISceneView extends IEventDispatcher
   {
       
      
      function get sceneModel() : ISceneModel;
      
      function set sceneModel(param1:ISceneModel) : void;
   }
}
