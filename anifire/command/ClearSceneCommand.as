package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   import anifire.scene.model.SceneManager;
   
   public class ClearSceneCommand extends SuperCommand
   {
       
      
      private var _undoXML:XML;
      
      private var _scene:AnimeScene;
      
      public function ClearSceneCommand(param1:AnimeScene)
      {
         super();
         this._scene = param1;
         _type = "ClearSceneCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
         this._undoXML = backupSceneData();
         this._scene.deSerialize(,true);
         SceneManager.addDefaultZoomEffect(this._scene);
      }
      
      override public function undo() : void
      {
         this._scene.deSerialize(this._undoXML,true,true,false);
         Console.getConsole().currentScene = this._scene;
      }
      
      override public function redo() : void
      {
         this._scene.deSerialize(,true);
         SceneManager.addDefaultZoomEffect(this._scene);
         Console.getConsole().currentScene = this._scene;
      }
   }
}
