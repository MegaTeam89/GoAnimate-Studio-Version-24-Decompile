package anifire.assets.transition.command
{
   import anifire.assets.transition.model.AssetTransition;
   import anifire.assets.transition.model.AssetTransitionHelper;
   import anifire.command.SuperCommand;
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   
   public class ChangeAssetTransitionCommand extends SuperCommand
   {
       
      
      private var _oldXml:XML;
      
      private var _newXml:XML;
      
      private var _transition:AssetTransition;
      
      public function ChangeAssetTransitionCommand(param1:AssetTransition)
      {
         super();
         _type = "ChangeAssetTransitionCommand";
         this._transition = param1;
      }
      
      public function get transition() : AssetTransition
      {
         return this._transition;
      }
      
      override public function execute() : void
      {
         super.execute();
         this._oldXml = this._transition.convertToXml();
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().movie.getSceneById(this.sceneId);
         if(_loc1_)
         {
            this._transition = AssetTransitionHelper.getTransition(this._transition.id,_loc1_.assetTransitions);
         }
         if(this._transition)
         {
            this._newXml = this._transition.convertToXml();
            this._transition.convertFromXml(this._oldXml);
         }
      }
      
      override public function redo() : void
      {
         if(this._transition)
         {
            this._transition.convertFromXml(this._newXml);
         }
      }
   }
}
