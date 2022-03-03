package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   
   public class ChangeDirectionCommand extends ChangeAssetTransitionCommand
   {
       
      
      private var _newDirection:int;
      
      public function ChangeDirectionCommand(param1:AssetTransition, param2:int)
      {
         super(param1);
         this._newDirection = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         transition.direction = this._newDirection;
      }
   }
}
