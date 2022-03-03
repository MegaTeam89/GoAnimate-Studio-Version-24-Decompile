package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   
   public class ChangeDurationCommand extends ChangeAssetTransitionCommand
   {
       
      
      private var _newDuration:int;
      
      public function ChangeDurationCommand(param1:AssetTransition, param2:int)
      {
         super(param1);
         this._newDuration = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         transition.duration = this._newDuration;
      }
   }
}
