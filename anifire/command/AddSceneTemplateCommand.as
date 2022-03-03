package anifire.command
{
   import anifire.core.Console;
   import anifire.core.MovieData;
   import anifire.core.TemplateThumb;
   import anifire.timeline.Timeline;
   
   public class AddSceneTemplateCommand extends SuperCommand
   {
       
      
      private var _undoSoundInfos:Array;
      
      private var _redoSoundInfos:Array;
      
      private var _movie:MovieData;
      
      private var _template:TemplateThumb;
      
      private var _index:Number;
      
      private var _timeline:Timeline;
      
      public function AddSceneTemplateCommand(param1:MovieData, param2:TemplateThumb, param3:Number, param4:Timeline)
      {
         super();
         this._movie = param1;
         this._template = param2;
         this._index = param3;
         this._timeline = param4;
         _type = "AddSceneTemplateCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
         this._undoSoundInfos = this._timeline.getAllSoundInfo();
         Console.getConsole().insertSceneTemplate(this._template,this._index);
      }
      
      override public function undo() : void
      {
         this._redoSoundInfos = this._timeline.getAllSoundInfo();
         this._movie.removeMultipleScene(this._index,this._template.numScene);
         this._timeline.setAllSoundInfo(this._undoSoundInfos);
      }
      
      override public function redo() : void
      {
         Console.getConsole().insertSceneTemplate(this._template,this._index);
         this._timeline.setAllSoundInfo(this._redoSoundInfos);
      }
   }
}
