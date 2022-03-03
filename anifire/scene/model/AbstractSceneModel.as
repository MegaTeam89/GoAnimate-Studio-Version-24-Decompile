package anifire.scene.model
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class AbstractSceneModel extends EventDispatcher
   {
       
      
      public function AbstractSceneModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
   }
}
