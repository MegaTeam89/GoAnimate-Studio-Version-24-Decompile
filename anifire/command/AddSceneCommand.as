package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.MovieData;
   import anifire.scene.model.SceneManager;
   import anifire.timeline.Timeline;
   
   public class AddSceneCommand extends SuperCommand
   {
       
      
      private var _undoSoundInfos:Array;
      
      private var _redoSoundInfos:Array;
      
      private var _movie:MovieData;
      
      private var _scene:AnimeScene;
      
      private var _index:Number;
      
      private var _timeline:Timeline;
      
      public function AddSceneCommand(param1:MovieData, param2:AnimeScene, param3:Number, param4:Timeline)
      {
         super(param2.id);
         this._movie = param1;
         this._scene = param2;
         this._index = param3;
         this._timeline = param4;
         _type = "AddSceneCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
         this._undoSoundInfos = this._timeline.getAllSoundInfo();
         this._movie.addSceneAt(this._scene,this._index);
         SceneManager.checkSceneNum(this._movie.length);
      }
      
      override public function undo() : void
      {
         this._redoSoundInfos = this._timeline.getAllSoundInfo();
         this._movie.removeSceneAt(this._index);
         this._timeline.setAllSoundInfo(this._undoSoundInfos);
      }
      
      override public function redo() : void
      {
         this._movie.addSceneAt(this._scene,this._index);
         this._timeline.setAllSoundInfo(this._redoSoundInfos);
      }
   }
}
