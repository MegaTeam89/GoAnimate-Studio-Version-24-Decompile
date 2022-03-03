package anifire.command
{
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   
   public class AddSoundCommand extends SuperCommand
   {
       
      
      private var _snd:AnimeSound;
      
      public function AddSoundCommand(param1:AnimeSound)
      {
         super();
         this._snd = param1;
         _type = "AddSoundCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
         Console.getConsole().addSound(this._snd);
      }
      
      override public function undo() : void
      {
         Console.getConsole().removeSound(this._snd.getID());
      }
      
      override public function redo() : void
      {
         Console.getConsole().addSound(this._snd);
      }
   }
}
