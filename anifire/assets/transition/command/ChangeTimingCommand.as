package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   
   public class ChangeTimingCommand extends ChangeAssetTransitionCommand
   {
       
      
      private var _newTiming:uint;
      
      public function ChangeTimingCommand(param1:AssetTransition, param2:uint)
      {
         super(param1);
         this._newTiming = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         transition.timing = this._newTiming;
      }
   }
}
