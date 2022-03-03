package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   import anifire.assets.transition.model.AssetTransitionCollection;
   import anifire.command.SuperCommand;
   
   public class AddTransitionCommand extends SuperCommand
   {
       
      
      private var _transition:AssetTransition;
      
      private var _collection:AssetTransitionCollection;
      
      public function AddTransitionCommand(param1:AssetTransition, param2:AssetTransitionCollection)
      {
         super();
         _type = "AddTransitionCommand";
         this._transition = param1;
         this._collection = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         this._collection.addTransition(this._transition);
      }
      
      override public function undo() : void
      {
         this._collection.removeTransition(this._transition);
      }
      
      override public function redo() : void
      {
         this._collection.addTransition(this._transition);
      }
   }
}
