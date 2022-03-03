package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   
   public class ChangeSectionCommand extends ChangeAssetTransitionCommand
   {
       
      
      private var _newSection:int;
      
      public function ChangeSectionCommand(param1:AssetTransition, param2:int)
      {
         super(param1);
         this._newSection = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         transition.section = this._newSection;
      }
   }
}
