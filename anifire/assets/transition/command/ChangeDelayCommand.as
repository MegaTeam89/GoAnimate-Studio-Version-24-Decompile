package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   
   public class ChangeDelayCommand extends ChangeAssetTransitionCommand
   {
       
      
      private var _newDelay:int;
      
      public function ChangeDelayCommand(param1:AssetTransition, param2:int)
      {
         super(param1);
         this._newDelay = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         transition.delay = this._newDelay;
      }
   }
}
