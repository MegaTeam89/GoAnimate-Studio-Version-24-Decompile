package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.MovieData;
   import anifire.interfaces.IIterator;
   import anifire.scene.model.SceneSelection;
   import anifire.timeline.Timeline;
   
   public class RemoveSceneCommand extends SuperCommand
   {
       
      
      private var _undoSoundInfos:Array;
      
      private var _redoSoundInfos:Array;
      
      private var _movie:MovieData;
      
      private var _timeline:Timeline;
      
      private var _selection:SceneSelection;
      
      private var _indexArray:Array;
      
      public function RemoveSceneCommand(param1:MovieData, param2:SceneSelection, param3:Timeline)
      {
         super();
         this._movie = param1;
         this._timeline = param3;
         this._selection = param2.clone();
         _type = "RemoveSceneCommand";
      }
      
      override public function execute() : void
      {
         var _loc1_:AnimeScene = null;
         var _loc2_:int = 0;
         super.execute();
         this._undoSoundInfos = this._timeline.getAllSoundInfo();
         this._indexArray = new Array();
         var _loc3_:IIterator = this._selection.iterator();
         while(_loc3_.hasNext)
         {
            _loc1_ = _loc3_.next as AnimeScene;
            _loc2_ = this._movie.getSceneIndex(_loc1_);
            this._indexArray.push(_loc2_);
            this._movie.removeSceneAt(_loc2_);
         }
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = null;
         var _loc2_:int = 0;
         this._redoSoundInfos = this._timeline.getAllSoundInfo();
         var _loc3_:IIterator = this._selection.iterator("reverse");
         var _loc4_:int = this._indexArray.length - 1;
         while(_loc4_ >= 0)
         {
            _loc1_ = _loc3_.next as AnimeScene;
            this._movie.addSceneAt(_loc1_,this._indexArray[_loc4_]);
            _loc4_--;
         }
         this._timeline.setAllSoundInfo(this._undoSoundInfos);
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = null;
         var _loc2_:int = 0;
         var _loc3_:IIterator = this._selection.iterator();
         while(_loc3_.hasNext)
         {
            _loc1_ = _loc3_.next as AnimeScene;
            _loc2_ = this._movie.getSceneIndex(_loc1_);
            this._indexArray.push(_loc2_);
            this._movie.removeSceneAt(_loc2_);
         }
         this._timeline.setAllSoundInfo(this._redoSoundInfos);
      }
   }
}
