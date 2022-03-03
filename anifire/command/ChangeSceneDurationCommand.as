package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.timeline.Timeline;
   
   public class ChangeSceneDurationCommand extends SuperCommand
   {
       
      
      private var _scene:AnimeScene;
      
      private var _undoDurationMode:uint;
      
      private var _redoDurationMode:uint;
      
      private var _undoFrame:int;
      
      private var _redoFrame:int;
      
      private var _undoSoundInfos:Array;
      
      private var _redoSoundInfos:Array;
      
      private var _timeline:Timeline;
      
      public function ChangeSceneDurationCommand(param1:AnimeScene, param2:int, param3:uint, param4:Timeline, param5:Array = null)
      {
         super();
         this._scene = param1;
         this._redoFrame = param2;
         this._redoDurationMode = param3;
         this._timeline = param4;
         this._undoSoundInfos = param5;
         _type = "ChangeSceneDurationCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
         this._undoFrame = this._scene.customTotalFrames;
         this._undoDurationMode = this._scene.durationMode;
         if(!this._undoSoundInfos)
         {
            this._undoSoundInfos = this._timeline.getAllSoundInfo();
         }
         if(this._redoDurationMode == AnimeScene.DURATION_MODE_CUSTOM)
         {
            this._scene.setCustomTotalFrames(this._redoFrame);
         }
         else
         {
            this._scene.setDurationMode(this._redoDurationMode);
         }
      }
      
      override public function undo() : void
      {
         this._redoSoundInfos = this._timeline.getAllSoundInfo();
         if(this._undoDurationMode == AnimeScene.DURATION_MODE_CUSTOM)
         {
            this._scene.setCustomTotalFrames(this._undoFrame);
         }
         else
         {
            this._scene.setDurationMode(this._undoDurationMode);
         }
         this._timeline.setAllSoundInfo(this._undoSoundInfos);
      }
      
      override public function redo() : void
      {
         if(this._redoDurationMode == AnimeScene.DURATION_MODE_CUSTOM)
         {
            this._scene.setCustomTotalFrames(this._redoFrame);
         }
         else
         {
            this._scene.setDurationMode(this._redoDurationMode);
         }
         this._timeline.setAllSoundInfo(this._redoSoundInfos);
      }
   }
}
