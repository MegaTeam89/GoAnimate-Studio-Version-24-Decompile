package anifire.command
{
   public interface ICommand
   {
       
      
      function execute() : void;
      
      function undo() : void;
      
      function redo() : void;
      
      function toString() : String;
   }
}
