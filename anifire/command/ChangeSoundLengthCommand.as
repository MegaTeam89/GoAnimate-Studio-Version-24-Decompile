package anifire.command
{
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.timeline.ElementInfo;
   import anifire.timeline.SoundTrackArea;
   import anifire.util.UtilUnitConvert;
   
   public class ChangeSoundLengthCommand extends SuperCommand
   {
       
      
      private var _id:String;
      
      private var _undoInfo:ElementInfo;
      
      private var _redoInfo:ElementInfo;
      
      public function ChangeSoundLengthCommand(param1:String, param2:ElementInfo)
      {
         super();
         this._id = param1;
         this._undoInfo = param2;
         _type = "ChangeSoundLengthCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function undo() : void
      {
         this._redoInfo = Console.getConsole().timeline.getSoundInfoById(this._id);
         Console.getConsole().timeline.setSoundInfoById(this._id,this._undoInfo.startPixel,this._undoInfo.totalPixel,null,this._undoInfo.y);
         var _loc1_:AnimeSound = Console.getConsole().sounds.getSoundById(this._id) as AnimeSound;
         _loc1_.startFrame = UtilUnitConvert.xToFrame(this._undoInfo.startPixel);
         _loc1_.endFrame = UtilUnitConvert.xToFrame(this._undoInfo.startPixel + this._undoInfo.totalPixel) - 1;
         _loc1_.trackNum = SoundTrackArea.pixelToTrack(this._undoInfo.y);
      }
      
      override public function redo() : void
      {
         Console.getConsole().timeline.setSoundInfoById(this._id,this._redoInfo.startPixel,this._redoInfo.totalPixel,null,this._redoInfo.y);
         var _loc1_:AnimeSound = Console.getConsole().sounds.getSoundById(this._id) as AnimeSound;
         _loc1_.startFrame = UtilUnitConvert.xToFrame(this._redoInfo.startPixel);
         _loc1_.endFrame = UtilUnitConvert.xToFrame(this._redoInfo.startPixel + this._redoInfo.totalPixel) - 1;
         _loc1_.trackNum = SoundTrackArea.pixelToTrack(this._redoInfo.y);
      }
   }
}
