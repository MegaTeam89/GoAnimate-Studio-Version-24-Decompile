package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   import anifire.assets.transition.model.AssetTransitionCollection;
   import anifire.command.SuperCommand;
   
   public class RemoveTransitionCommand extends SuperCommand
   {
       
      
      private var _transition:AssetTransition;
      
      private var _collection:AssetTransitionCollection;
      
      private var _index:int;
      
      public function RemoveTransitionCommand(param1:AssetTransition, param2:AssetTransitionCollection)
      {
         super();
         _type = "RemoveTransitionCommand";
         this._transition = param1;
         this._collection = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         this._index = this._collection.removeTransition(this._transition);
      }
      
      override public function undo() : void
      {
         this._collection.addTransitionAt(this._transition,this._index);
      }
      
      override public function redo() : void
      {
         this._index = this._collection.removeTransition(this._transition);
      }
   }
}
