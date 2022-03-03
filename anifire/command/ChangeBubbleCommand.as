package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.BubbleAsset;
   import anifire.core.Console;
   
   public class ChangeBubbleCommand extends SuperCommand
   {
       
      
      private var _id:String;
      
      private var _undoXML:XML;
      
      private var _redoXML:XML;
      
      public function ChangeBubbleCommand(param1:String, param2:XML)
      {
         super();
         this._id = param1;
         this._undoXML = param2;
         _type = "ChangeBubbleCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = null;
         var _loc2_:BubbleAsset = null;
         try
         {
            _loc1_ = Console.getConsole().getScenebyId(sceneId);
            _loc2_ = BubbleAsset(_loc1_.getAssetById(this._id));
            if(_loc2_ != null)
            {
               if(Console.getConsole().currentSceneId != sceneId)
               {
                  Console.getConsole().setCurrentSceneById(sceneId);
               }
               Console.getConsole().setCurrentSceneVisible();
               this._redoXML = _loc2_.bubble.serialize();
               _loc2_.bubble.deSerialize(this._undoXML);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:BubbleAsset = BubbleAsset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            _loc2_.bubble.deSerialize(this._redoXML);
         }
      }
   }
}
