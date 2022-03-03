package anifire.command
{
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   
   public class AddSpeechCommand extends SuperCommand
   {
       
      
      private var _charId:String;
      
      private var _sound:AnimeSound;
      
      public function AddSpeechCommand(param1:AnimeSound, param2:String)
      {
         super();
         this._charId = param2;
         this._sound = param1;
         _type = "AddSpeechCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
      
      override public function undo() : void
      {
         super.undo();
         Console.getConsole().linkageController.deleteLinkageById(this._charId);
         Console.getConsole().speechManager.removeSoundById(this._sound.getID());
         Console.getConsole().currentScene.refreshEffectTray();
      }
      
      override public function redo() : void
      {
      }
   }
}
