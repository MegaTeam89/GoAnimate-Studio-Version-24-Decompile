package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   
   public class ChangeTypeCommand extends ChangeAssetTransitionCommand
   {
       
      
      private var _newType:String;
      
      public function ChangeTypeCommand(param1:AssetTransition, param2:String)
      {
         super(param1);
         this._newType = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         transition.type = this._newType;
      }
   }
}
