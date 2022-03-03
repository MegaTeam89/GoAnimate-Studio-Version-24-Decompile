package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   
   public class SuperCommand implements ICommand
   {
       
      
      protected var _type:String = "SuperCommand";
      
      private var _sceneId:String = null;
      
      private var _undoSceneXmlStr:String;
      
      private var _redoSceneXmlStr:String;
      
      private var _undoSoundInfos:Array;
      
      private var _redoSoundInfos:Array;
      
      public function SuperCommand(param1:String = "")
      {
         super();
         if(param1 == "")
         {
            param1 = Console.getConsole().currentSceneId;
         }
         this._sceneId = param1;
         var _loc2_:Array = Console.getConsole().timeline.getAllSoundInfo();
         this._undoSoundInfos = _loc2_;
      }
      
      protected function get sceneId() : String
      {
         return this._sceneId;
      }
      
      public function undo() : void
      {
         var _loc1_:Array = null;
         var _loc2_:AnimeScene = null;
         try
         {
            _loc1_ = Console.getConsole().timeline.getAllSoundInfo();
            this._redoSoundInfos = _loc1_;
            _loc2_ = Console.getConsole().getScenebyId(this._sceneId);
            if(_loc2_ != null)
            {
               this._redoSceneXmlStr = _loc2_.serialize(-1,false);
               if(this._undoSceneXmlStr)
               {
                  this.restoreSceneData(new XML(this._undoSceneXmlStr));
               }
            }
            Console.getConsole().timeline.setAllSoundInfo(this._undoSoundInfos);
         }
         catch(e:Error)
         {
         }
      }
      
      public function redo() : void
      {
         try
         {
            if(this._redoSceneXmlStr)
            {
               this.restoreSceneData(new XML(this._redoSceneXmlStr));
            }
            Console.getConsole().timeline.setAllSoundInfo(this._redoSoundInfos);
         }
         catch(e:Error)
         {
         }
      }
      
      public function execute() : void
      {
         CommandStack.getInstance().putCommand(this);
      }
      
      public function set sceneUndoXML(param1:XML) : void
      {
         this._undoSceneXmlStr = param1.toXMLString();
      }
      
      protected function backupSceneData() : XML
      {
         var scene:AnimeScene = Console.getConsole().getScenebyId(this._sceneId);
         try
         {
            this._undoSceneXmlStr = scene.serialize(-1,false);
            return new XML(this._undoSceneXmlStr);
         }
         catch(e:Error)
         {
            _undoSceneXmlStr = null;
            return new XML();
         }
      }
      
      protected function restoreSceneData(param1:XML) : void
      {
         var _loc2_:AnimeScene = Console.getConsole().getScenebyId(this._sceneId);
         if(Console.getConsole().currentSceneId != this._sceneId)
         {
            Console.getConsole().setCurrentSceneById(this._sceneId);
         }
         _loc2_.deSerialize(param1,true,true,false);
         Console.getConsole().setCurrentSceneVisible();
         _loc2_.refreshEffectTray(Console.getConsole().effectTray);
      }
      
      public function toString() : String
      {
         return this._type;
      }
   }
}
