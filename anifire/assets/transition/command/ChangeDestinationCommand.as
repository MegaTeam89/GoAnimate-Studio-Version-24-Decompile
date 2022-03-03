package anifire.assets.transition.command
{
   import anifire.assets.transition.interfaces.IDestination;
   import anifire.assets.transition.model.AssetTransition;
   
   public class ChangeDestinationCommand extends ChangeAssetTransitionCommand
   {
       
      
      private var _newDestination:uint;
      
      public function ChangeDestinationCommand(param1:AssetTransition, param2:uint)
      {
         super(param1);
         this._newDestination = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         if(transition.setting is IDestination)
         {
            IDestination(transition.setting).destination = this._newDestination;
         }
      }
   }
}
