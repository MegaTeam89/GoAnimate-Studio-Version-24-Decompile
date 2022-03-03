package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Console;
   import anifire.interfaces.IFlippable;
   
   public class FlipAssetCommand extends SuperCommand
   {
       
      
      private var _assetId:String;
      
      private var _isFlipped:Boolean = false;
      
      public function FlipAssetCommand(param1:String)
      {
         super();
         this._assetId = param1;
         _type = "FlipAssetCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = Asset(_loc1_.getAssetById(this._assetId));
         if(_loc2_ is IFlippable)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            IFlippable(_loc2_).flipIt();
         }
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = Asset(_loc1_.getAssetById(this._assetId));
         if(_loc2_ is IFlippable)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            IFlippable(_loc2_).flipIt();
         }
      }
   }
}
