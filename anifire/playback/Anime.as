package anifire.playback
{
   import anifire.component.ProgressMonitor;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.AssetLinkage;
   import anifire.core.CCLipSyncController;
   import anifire.event.AVM2SoundEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.events.SceneBufferEvent;
   import anifire.fonts.PlayerFontManager;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
   import anifire.iterators.ArrayIterator;
   import anifire.playback.asset.transition.sound.TransitionSound;
   import anifire.playerEffect.EffectAsset;
   import anifire.util.Util;
   import anifire.util.UtilEventDispatcher;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilUnitConvert;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.external.ExternalInterface;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import mx.graphics.codec.PNGEncoder;
   import mx.utils.Base64Encoder;
   
   public class Anime implements ICollection
   {
      
      private static const STATE_NULL:int = 0;
      
      private static const STATE_PLAYING:int = 1;
      
      private static const STATE_PAUSING:int = 2;
      
      protected static const COMMAND_NULL:int = 0;
      
      protected static const COMMAND_PLAY:int = 1;
      
      protected static const COMMAND_PAUSE:int = 2;
      
      protected static const COMMAND_GOTO_AND_PAUSE:int = 3;
      
      protected static const COMMAND_SET_VOLUME:int = 4;
      
      protected static const COMMAND_REMOVE_ENTER_FRAME:int = 5;
      
      protected static const COMMAND_ADD_ENTER_FRAME:int = 6;
      
      protected static const COMMAND_END:int = 7;
      
      protected static const COMMAND_GOTO_AND_PAUSE_RESET:int = 8;
       
      
      private var _animeScenes:Array;
      
      private var _sounds:Array;
      
      private var _embedSounds:Array;
      
      private var _soundsIndexByFrame:UtilHashArray;
      
      private var _soundsIndexByStartFrame:UtilHashArray;
      
      private var _soundsIndexByEndFrame:UtilHashArray;
      
      private var _currentSceneIndex:Number = -1;
      
      private var _currentFrame:Number = 0;
      
      private var _dataStock:PlayerDataStock = null;
      
      private var _animeStage:MovieClip = null;
      
      private var _state:int = 0;
      
      private var _eventDispatcher:UtilEventDispatcher;
      
      private var _currentCommand:int = 0;
      
      private var _currentCommandArg:Array;
      
      private var _duration:Number = -1;
      
      private var _movieDurationPerMovie:UtilHashArray;
      
      private var _prevSystemTime:Number = -1;
      
      private var _prevFrame:Number = -1;
      
      private var _flashVars:UtilHashArray;
      
      private var _downloadManager:DownloadManager;
      
      private var _isInitialized:Boolean = false;
      
      private var _startFrameOffsetForEachMovie:UtilHashArray;
      
      private var _movieInfo:Object;
      
      private var pauseAtFirstFrame:Boolean = false;
      
      private var _isScenePreview:Boolean = false;
      
      private var _scenePreviewFirstStart:Boolean = false;
      
      private var _frameNum:Number = 0;
      
      private var _licensedSoundInfo:String = "";
      
      private var _isSceneCharacterChecked:Boolean = false;
      
      private var _isPreview:Boolean = false;
      
      private var _hiddenMovieTag:String = "";
      
      private var _assetSound:AssetSound;
      
      private var _currentSpeechId:String;
      
      private var _initRemoteData:Boolean = false;
      
      private var firstLoad:Boolean = true;
      
      private var setVolumeAtFirstLoad:Boolean = false;
      
      private var lastNum:Number = 0;
      
      private var photoTaken:Boolean = false;
      
      private var en:PNGEncoder;
      
      private var encoder:Base64Encoder;
      
      private var _allSceneBufferReady:Boolean = false;
      
      private var _isReset:Boolean = false;
      
      private var _isResetCompleted:Boolean = false;
      
      private var photoArray:Array;
      
      private var photoExistArray:Array;
      
      private var is_golite_preview:int;
      
      private var _volume:Number = 0.5;
      
      public function Anime()
      {
         this._animeScenes = new Array();
         this._sounds = new Array();
         this._embedSounds = new Array();
         this._soundsIndexByFrame = new UtilHashArray();
         this._soundsIndexByStartFrame = new UtilHashArray();
         this._soundsIndexByEndFrame = new UtilHashArray();
         this._eventDispatcher = new UtilEventDispatcher();
         this._flashVars = new UtilHashArray();
         this._downloadManager = DownloadManager.getInstance();
         this._startFrameOffsetForEachMovie = new UtilHashArray();
         this._movieInfo = {};
         this.en = new PNGEncoder();
         this.encoder = new Base64Encoder();
         this.photoArray = new Array();
         this.photoExistArray = new Array();
         this.is_golite_preview = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_GOLITE_PREVIEW);
         super();
         this.setDataStock(new PlayerDataStock());
         this.setMovieContainer(new MovieClip());
      }
      
      public function get licensedSoundInfo() : String
      {
         return this._licensedSoundInfo;
      }
      
      public function set movieInfo(param1:Object) : void
      {
         this._movieInfo = param1;
      }
      
      public function get movieInfo() : Object
      {
         return this._movieInfo;
      }
      
      public function get hiddenMovieTag() : String
      {
         return this._hiddenMovieTag;
      }
      
      private function get movieDurationPerMovie() : UtilHashArray
      {
         return this._movieDurationPerMovie;
      }
      
      private function set movieDurationPerMovie(param1:UtilHashArray) : void
      {
         this._movieDurationPerMovie = param1;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function get downloadManager() : DownloadManager
      {
         return this._downloadManager;
      }
      
      private function set downloadManager(param1:DownloadManager) : void
      {
         this._downloadManager = param1;
      }
      
      protected function get flashVars() : UtilHashArray
      {
         return this._flashVars;
      }
      
      protected function set flashVars(param1:UtilHashArray) : void
      {
         this._flashVars = param1;
      }
      
      public function getDuration() : Number
      {
         return this._duration;
      }
      
      public function get totalDurationInSecond() : Number
      {
         return UtilUnitConvert.frameToSec(this._duration);
      }
      
      private function setDuration(param1:Number) : void
      {
         this._duration = param1;
      }
      
      private function get startFrameOffsetForEachMovie() : UtilHashArray
      {
         return this._startFrameOffsetForEachMovie;
      }
      
      private function updateStartFrameOffsetForEachMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         this.movieDurationPerMovie = this.startFrameOffsetForEachMovie.clone();
         var _loc6_:int = this.getNumScene();
         _loc1_ = 0;
         while(_loc1_ < this.startFrameOffsetForEachMovie.length)
         {
            this.movieDurationPerMovie.push(this.movieDurationPerMovie.getKey(_loc1_),0);
            this.startFrameOffsetForEachMovie.push(this.startFrameOffsetForEachMovie.getKey(_loc1_),0);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc6_)
         {
            _loc3_ = this.getSceneByIndex(_loc1_).movieId;
            _loc4_ = this.movieDurationPerMovie.getIndex(_loc3_);
            _loc5_ = this.getSceneByIndex(_loc1_).getDuration();
            _loc2_ = this.movieDurationPerMovie.getValueByIndex(_loc4_) as Number;
            this.movieDurationPerMovie.push(_loc3_,_loc2_ + _loc5_);
            _loc1_++;
         }
         if(this.startFrameOffsetForEachMovie.length > 0)
         {
            this.startFrameOffsetForEachMovie.push(this.startFrameOffsetForEachMovie.getKey(0),0);
         }
         _loc1_ = 1;
         while(_loc1_ < this.startFrameOffsetForEachMovie.length)
         {
            _loc3_ = this.startFrameOffsetForEachMovie.getKey(_loc1_);
            _loc4_ = _loc1_;
            _loc7_ = this.startFrameOffsetForEachMovie.getValueByIndex(_loc4_ - 1) as Number;
            _loc5_ = this.movieDurationPerMovie.getValueByIndex(_loc1_ - 1) as Number;
            this.startFrameOffsetForEachMovie.push(_loc3_,_loc7_ + _loc5_);
            _loc1_++;
         }
      }
      
      public function get currentFrame() : Number
      {
         return this._currentFrame;
      }
      
      private function getCurCommand() : int
      {
         return this._currentCommand;
      }
      
      private function getCurCommandArg() : Array
      {
         return this._currentCommandArg;
      }
      
      private function setCurCommand(param1:int, param2:Array = null) : void
      {
         this._currentCommand = param1;
         this._currentCommandArg = param2;
      }
      
      private function removeCurCommand() : void
      {
         this._currentCommand = COMMAND_NULL;
         this._currentCommandArg = null;
      }
      
      private function getCurrentSceneIndex() : Number
      {
         return this._currentSceneIndex;
      }
      
      private function setCurrentScene(param1:Number, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc4_:AnimeScene = null;
         var _loc5_:Sprite = null;
         var _loc6_:AnimeScene = null;
         var _loc7_:Sprite = null;
         var _loc8_:DisplayObjectContainer = null;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Matrix = null;
         var _loc15_:BitmapData = null;
         if(param1 != this.getCurrentSceneIndex())
         {
            _loc4_ = this.getSceneByIndex(param1);
            if(param2)
            {
               if((_loc6_ = this.getSceneByIndex(this.getCurrentSceneIndex())).getSceneMasterContainer() is Sprite)
               {
                  (_loc7_ = _loc6_.getSceneContainer() as Sprite).soundTransform = new SoundTransform(0);
               }
               if(_loc4_.getTransitionNum() > 0)
               {
                  if(_loc8_ = this.getMovieContainer().parent.parent.parent.parent)
                  {
                     _loc9_ = _loc8_.scaleX;
                     _loc10_ = AnimeConstants.SCREEN_WIDTH * _loc9_;
                     _loc11_ = AnimeConstants.SCREEN_HEIGHT * _loc9_;
                     if(_loc6_.sizingAssetRect)
                     {
                        _loc13_ = _loc12_ = _loc10_ / _loc6_.sizingAssetRect.width;
                     }
                     else
                     {
                        _loc12_ = _loc10_ / AnimeConstants.PLAYER_WIDTH;
                        _loc13_ = _loc11_ / AnimeConstants.PLAYER_HEIGHT;
                     }
                     _loc14_ = new Matrix();
                     _loc15_ = new BitmapData(_loc10_,_loc11_);
                     if(_loc6_.sizingAssetRect)
                     {
                        _loc14_.translate(-AnimeConstants.SCREEN_X,-AnimeConstants.SCREEN_Y);
                     }
                     else
                     {
                        _loc14_.translate(-AnimeConstants.SCREEN_X,-AnimeConstants.SCREEN_Y);
                     }
                     _loc14_.scale(_loc9_,_loc9_);
                     _loc15_.draw(_loc6_.getSceneMasterContainer(),_loc14_);
                     _loc6_.endSceneCapture = _loc15_;
                  }
               }
               _loc6_.destroy();
            }
            this._currentSceneIndex = param1;
            if(_loc4_.readyToPlay || this._currentSceneIndex == 0)
            {
               this.putSceneToStage(this.getCurrentSceneIndex());
            }
            if(_loc4_.getSceneMasterContainer() is Sprite)
            {
               (_loc5_ = _loc4_.getSceneMasterContainer() as Sprite).soundTransform = new SoundTransform(1);
            }
            if(!param3 && _loc4_ == this.getSceneByIndex(this.searchSceneIndexByFrame(this.currentFrame)))
            {
               this.setCurrentSceneSound(_loc4_);
            }
         }
      }
      
      public function destroyAllScene() : void
      {
         var _loc2_:int = 0;
         var _loc3_:AnimeScene = null;
         var _loc1_:Number = this.getNumScene();
         if(_loc1_ > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.getSceneByIndex(_loc2_).destroy(true);
               _loc2_++;
            }
            while(this.getNumScene() > 0)
            {
               _loc3_ = this.getAnimeScene().pop();
               _loc3_ = null;
            }
         }
      }
      
      private function stopAssetMusicInFirstAppearScene(param1:Asset, param2:Asset = null, param3:String = "") : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:AnimeScene = null;
         var _loc9_:AnimeScene = null;
         var _loc10_:Boolean = false;
         if(param1 is Background)
         {
            _loc6_ = param1.id;
            _loc9_ = (_loc8_ = this._animeScenes[this.getCurrentSceneIndex()] as AnimeScene).prevScene;
            while(_loc9_ != null)
            {
               if(_loc9_.getBgByID(_loc6_) == null)
               {
                  break;
               }
               param1 = _loc9_.getBgByID(_loc6_);
               _loc9_ = _loc9_.prevScene;
            }
            param1.stopMusic();
         }
         else if(param1 is Character && param3 != "")
         {
            _loc7_ = param1.id;
            _loc9_ = (_loc8_ = this._animeScenes[this.getCurrentSceneIndex()] as AnimeScene).prevScene;
            _loc10_ = false;
            while(_loc9_ != null)
            {
               if(param3 == "prop")
               {
                  if(_loc9_.getCharByID(_loc7_) != null && _loc9_.getCharByID(_loc7_).prop != null && _loc9_.getCharByID(_loc7_).prop.file == (param2 as Prop).file)
                  {
                     param2 = _loc9_.getCharByID(_loc7_).prop;
                  }
                  else
                  {
                     _loc10_ = true;
                  }
               }
               else if(param3 == "head")
               {
                  if(_loc9_.getCharByID(_loc7_) != null && _loc9_.getCharByID(_loc7_).head != null && _loc9_.getCharByID(_loc7_).head.file == (param2 as Prop).file)
                  {
                     param2 = _loc9_.getCharByID(_loc7_).head;
                  }
                  else
                  {
                     _loc10_ = true;
                  }
               }
               else if(param3 == "wear")
               {
                  if(_loc9_.getCharByID(_loc7_) != null && _loc9_.getCharByID(_loc7_).wear != null && _loc9_.getCharByID(_loc7_).wear.file == (param2 as Prop).file)
                  {
                     param2 = _loc9_.getCharByID(_loc7_).wear;
                  }
                  else
                  {
                     _loc10_ = true;
                  }
               }
               if(_loc10_ == true)
               {
                  break;
               }
               _loc9_ = _loc9_.prevScene;
            }
            param2.stopMusic();
         }
         else if(param1 is Prop)
         {
            _loc5_ = param1.id;
            _loc9_ = (_loc8_ = this._animeScenes[this.getCurrentSceneIndex()] as AnimeScene).prevScene;
            while(_loc9_ != null)
            {
               if(_loc9_.getPropById(_loc5_) == null)
               {
                  break;
               }
               param1 = _loc9_.getPropById(_loc5_);
               _loc9_ = _loc9_.prevScene;
            }
            param1.stopMusic();
         }
         else if(param1 is EffectAsset)
         {
            _loc4_ = param1.id;
            _loc9_ = (_loc8_ = this._animeScenes[this.getCurrentSceneIndex()] as AnimeScene).prevScene;
            while(_loc9_ != null)
            {
               if(_loc9_.getEffectById(_loc4_) == null)
               {
                  break;
               }
               param1 = _loc9_.getEffectById(_loc4_);
               _loc9_ = _loc9_.prevScene;
            }
            param1.stopMusic();
         }
      }
      
      private function setCurrentSceneSound(param1:AnimeScene) : void
      {
         var _loc2_:AnimeScene = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Character = null;
         var _loc10_:Character = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:Behaviour = null;
         var _loc14_:Behaviour = null;
         if(param1 != null)
         {
            _loc2_ = param1.prevScene;
            if(_loc2_ != null)
            {
               if(_loc2_.getNumBg() == 0)
               {
                  if(param1.getNumBg() != 0)
                  {
                     param1.getBgByIndex(0).playMusic(0,0,new SoundTransform(this.volume));
                  }
               }
               else if(param1.getNumBg() != 0)
               {
                  if(_loc2_.getBgByIndex(0).id != param1.getBgByIndex(0).id)
                  {
                     this.stopAssetMusicInFirstAppearScene(_loc2_.getBgByIndex(0));
                     param1.getBgByIndex(0).playMusic(0,0,new SoundTransform(this.volume));
                  }
               }
               else
               {
                  this.stopAssetMusicInFirstAppearScene(_loc2_.getBgByIndex(0));
               }
               _loc3_ = false;
               _loc4_ = 0;
               _loc5_ = 0;
               _loc6_ = new Array();
               _loc4_ = 0;
               while(_loc4_ < param1.getNumProp())
               {
                  _loc11_ = param1.getPropByIndex(_loc4_).id;
                  if(_loc2_.getPropById(_loc11_) == null)
                  {
                     param1.getPropByIndex(_loc4_).playMusic(0,0,new SoundTransform(this.volume));
                  }
                  else
                  {
                     _loc6_.push(param1.getPropByIndex(_loc4_).id);
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc2_.getNumProp())
               {
                  _loc3_ = false;
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_.length)
                  {
                     if(_loc2_.getPropByIndex(_loc4_).id == _loc6_[_loc5_])
                     {
                        _loc3_ = true;
                        break;
                     }
                     _loc5_++;
                  }
                  if(!_loc3_)
                  {
                     this.stopAssetMusicInFirstAppearScene(_loc2_.getPropByIndex(_loc4_));
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < param1.getNumChar())
               {
                  _loc7_ = param1.getCharByIndex(_loc4_).id;
                  _loc9_ = _loc2_.getCharByID(_loc7_);
                  if(param1.getCharByIndex(_loc4_).prop != null && param1.getCharByIndex(_loc4_).prop.sound != null)
                  {
                     _loc8_ = param1.getCharByIndex(_loc4_).prop.file;
                     if(_loc9_ == null || _loc9_ != null && _loc9_.prop == null || _loc9_ != null && _loc9_.prop.file != _loc8_)
                     {
                        param1.getCharByIndex(_loc4_).prop.playMusic(0,0,new SoundTransform(this.volume));
                     }
                  }
                  if(param1.getCharByIndex(_loc4_).head != null && param1.getCharByIndex(_loc4_).head.sound != null)
                  {
                     _loc8_ = param1.getCharByIndex(_loc4_).head.file;
                     if(_loc9_ == null || _loc9_ != null && _loc9_.head == null || _loc9_ != null && _loc9_.head.file != _loc8_)
                     {
                        param1.getCharByIndex(_loc4_).head.playMusic(0,0,new SoundTransform(this.volume));
                     }
                  }
                  if(param1.getCharByIndex(_loc4_).wear != null && param1.getCharByIndex(_loc4_).wear.sound != null)
                  {
                     _loc8_ = param1.getCharByIndex(_loc4_).wear.file;
                     if(_loc9_ == null || _loc9_ != null && _loc9_.wear == null || _loc9_ != null && _loc9_.wear.file != _loc8_)
                     {
                        param1.getCharByIndex(_loc4_).wear.playMusic(0,0,new SoundTransform(this.volume));
                     }
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc2_.getNumChar())
               {
                  _loc7_ = _loc2_.getCharByIndex(_loc4_).id;
                  _loc10_ = param1.getCharByID(_loc7_);
                  if(_loc2_.getCharByIndex(_loc4_).prop != null && _loc2_.getCharByIndex(_loc4_).prop.sound != null)
                  {
                     _loc8_ = _loc2_.getCharByIndex(_loc4_).prop.file;
                     if(_loc10_ == null || _loc10_ != null && _loc10_.prop == null || _loc10_ != null && _loc10_.prop.file != _loc8_)
                     {
                        this.stopAssetMusicInFirstAppearScene(_loc2_.getCharByIndex(_loc4_),_loc2_.getCharByIndex(_loc4_).prop,"prop");
                     }
                  }
                  if(_loc2_.getCharByIndex(_loc4_).head != null && _loc2_.getCharByIndex(_loc4_).head.sound != null)
                  {
                     _loc8_ = _loc2_.getCharByIndex(_loc4_).head.file;
                     if(_loc10_ == null || _loc10_ != null && _loc10_.head == null || _loc10_ != null && _loc10_.head.file != _loc8_)
                     {
                        this.stopAssetMusicInFirstAppearScene(_loc2_.getCharByIndex(_loc4_),_loc2_.getCharByIndex(_loc4_).head,"head");
                     }
                  }
                  if(_loc2_.getCharByIndex(_loc4_).wear != null && _loc2_.getCharByIndex(_loc4_).wear.sound != null)
                  {
                     _loc8_ = _loc2_.getCharByIndex(_loc4_).wear.file;
                     if(_loc10_ == null || _loc10_ != null && _loc10_.wear == null || _loc10_ != null && _loc10_.wear.file != _loc8_)
                     {
                        this.stopAssetMusicInFirstAppearScene(_loc2_.getCharByIndex(_loc4_),_loc2_.getCharByIndex(_loc4_).wear,"wear");
                     }
                  }
                  _loc4_++;
               }
               _loc6_ = new Array();
               _loc4_ = 0;
               while(_loc4_ < param1.getNumEffect())
               {
                  _loc12_ = param1.getEffectByIndex(_loc4_).id;
                  if(_loc2_.getEffectById(_loc12_) == null)
                  {
                     param1.getEffectByIndex(_loc4_).playMusic(0,0,new SoundTransform(this.volume));
                  }
                  else
                  {
                     _loc6_.push(param1.getEffectByIndex(_loc4_).id);
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc2_.getNumEffect())
               {
                  _loc3_ = false;
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_.length)
                  {
                     if(_loc2_.getEffectByIndex(_loc4_).id == _loc6_[_loc5_])
                     {
                        _loc3_ = true;
                        break;
                     }
                     _loc5_++;
                  }
                  if(!_loc3_)
                  {
                     this.stopAssetMusicInFirstAppearScene(_loc2_.getEffectByIndex(_loc4_));
                  }
                  _loc4_++;
               }
               _loc6_ = new Array();
               _loc4_ = 0;
               while(_loc4_ < param1.getNumChar())
               {
                  if(param1.getCharByIndex(_loc4_).action.isFirstBehavior)
                  {
                     param1.getCharByIndex(_loc4_).playMusic(0,0,new SoundTransform(this.volume));
                  }
                  else
                  {
                     _loc13_ = param1.getCharByIndex(_loc4_).action;
                     while(!_loc13_.isFirstBehavior)
                     {
                        _loc13_ = _loc13_.prevBehavior;
                     }
                     _loc6_.push(param1.getCharByIndex(_loc4_));
                  }
                  _loc4_++;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc2_.getNumChar())
               {
                  _loc3_ = false;
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_.length)
                  {
                     if(_loc2_.getCharByIndex(_loc4_).motion != null)
                     {
                        if(_loc2_.getCharByIndex(_loc4_).motion == (_loc6_[_loc5_] as Character).action.prevBehavior)
                        {
                           _loc3_ = true;
                        }
                     }
                     else if(_loc2_.getCharByIndex(_loc4_).action == (_loc6_[_loc5_] as Character).action.prevBehavior)
                     {
                        _loc3_ = true;
                     }
                     if(_loc3_)
                     {
                        break;
                     }
                     _loc5_++;
                  }
                  if(!_loc3_)
                  {
                     if(_loc2_.getCharByIndex(_loc4_).motion != null)
                     {
                        _loc14_ = _loc2_.getCharByIndex(_loc4_).motion;
                     }
                     else
                     {
                        _loc14_ = _loc2_.getCharByIndex(_loc4_).action;
                     }
                     while(_loc14_.isFirstBehavior != true)
                     {
                        if(_loc14_.prevBehavior == null)
                        {
                           break;
                        }
                        _loc14_ = _loc14_.prevBehavior;
                     }
                     _loc14_.myChar.stopMusic();
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      private function addSound(param1:AnimeSound) : void
      {
         this._sounds.push(param1);
         if(param1 is EmbedSound)
         {
            this._embedSounds.push(param1);
         }
      }
      
      private function getSoundByIndex(param1:int) : AnimeSound
      {
         return this._sounds[param1];
      }
      
      private function getSoundById(param1:String) : AnimeSound
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._sounds.length)
         {
            if(AnimeSound(this._sounds[_loc2_]).id == param1)
            {
               return AnimeSound(this._sounds[_loc2_]);
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getEmbedSoundByIndex(param1:int) : EmbedSound
      {
         return this._embedSounds[param1] as EmbedSound;
      }
      
      private function getSoundsByFrame(param1:Number) : Array
      {
         var _loc2_:Array = this._soundsIndexByFrame.getValueByKey(param1.toString());
         return _loc2_ == null ? new Array() : _loc2_;
      }
      
      private function getSoundsByStartFrame(param1:Number) : Array
      {
         var _loc2_:Array = this._soundsIndexByStartFrame.getValueByKey(param1.toString());
         return _loc2_ == null ? new Array() : _loc2_;
      }
      
      private function getSoundsByEndFrame(param1:Number) : Array
      {
         var _loc2_:Array = this._soundsIndexByEndFrame.getValueByKey(param1.toString());
         return _loc2_ == null ? new Array() : _loc2_;
      }
      
      private function getNumSounds() : int
      {
         return this._sounds.length;
      }
      
      private function getNumEmbedSounds() : int
      {
         return this._embedSounds.length;
      }
      
      public function getDataStock() : PlayerDataStock
      {
         return this._dataStock;
      }
      
      public function setDataStock(param1:PlayerDataStock) : void
      {
         this._dataStock = param1;
      }
      
      public function getMovieContainer() : MovieClip
      {
         return this._animeStage;
      }
      
      private function setMovieContainer(param1:MovieClip) : void
      {
         this._animeStage = param1;
      }
      
      private function showMovieContainer() : void
      {
         this.getMovieContainer().visible = true;
      }
      
      private function hideMovieContainer() : void
      {
         this.getMovieContainer().visible = false;
      }
      
      private function addScene(param1:AnimeScene) : void
      {
         this._animeScenes.push(param1);
      }
      
      public function getSceneByIndex(param1:int) : AnimeScene
      {
         return this._animeScenes[param1];
      }
      
      private function getSceneById(param1:String) : AnimeScene
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._animeScenes.length)
         {
            if(AnimeScene(this._animeScenes[_loc2_]).id == param1)
            {
               return AnimeScene(this._animeScenes[_loc2_]);
            }
            _loc2_++;
         }
         return null;
      }
      
      private function searchSceneIndexByFrame(param1:Number) : int
      {
         var _loc5_:AnimeScene = null;
         var _loc2_:int = 0;
         var _loc3_:int = this.getNumScene() - 1;
         var _loc4_:int = 0;
         while(_loc2_ <= _loc3_)
         {
            _loc4_ = Math.floor((_loc2_ + _loc3_) / 2);
            if((_loc5_ = this.getSceneByIndex(_loc4_)).getStartFrame() > param1)
            {
               _loc3_ = _loc4_ - 1;
            }
            else if(_loc5_.getEndFrame() < param1)
            {
               _loc2_ = _loc4_ + 1;
            }
            else
            {
               _loc2_ = _loc3_ + 1;
            }
         }
         return _loc4_;
      }
      
      public function getNumScene() : Number
      {
         return this._animeScenes.length;
      }
      
      public function getAnimeScene() : Array
      {
         return this._animeScenes;
      }
      
      private function sortSceneXmlByZorder(param1:XMLList) : Array
      {
         var _loc3_:XML = null;
         var _loc2_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length())
         {
            _loc3_ = param1[_loc4_];
            _loc2_.push(_loc3_);
            _loc4_++;
         }
         _loc2_.sort(AnimeScene.compareSceneXmlZorder);
         return _loc2_;
      }
      
      private function doShowMovieContainer(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowMovieContainer);
         this.showMovieContainer();
      }
      
      private function isSkipScene(param1:XML) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.toXMLString().toLowerCase().indexOf(AnimeConstants.MAGIC_KEY) > -1)
         {
            _loc2_ = true;
         }
         if(Number(param1.@adelay) < 4.8)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      protected function init(param1:PlayerDataStock, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc7_:XML = null;
         var _loc8_:Number = NaN;
         var _loc9_:Array = null;
         var _loc10_:AnimeScene = null;
         var _loc11_:XML = null;
         var _loc12_:Array = null;
         var _loc13_:AnimeSound = null;
         var _loc14_:ProgressiveSound = null;
         var _loc15_:StreamSound = null;
         var _loc16_:XML = null;
         var _loc17_:XML = null;
         var _loc18_:XMLList = null;
         var _loc19_:XML = null;
         var _loc20_:AssetLinkage = null;
         var _loc21_:String = null;
         var _loc22_:AnimeSound = null;
         var _loc23_:Boolean = false;
         var _loc24_:AnimeScene = null;
         var _loc25_:Character = null;
         this._assetSound = new AssetSound(this);
         this._isPreview = param2;
         this.setDataStock(param1);
         this.downloadManager = DownloadManager.getInstance();
         this.downloadManager.init();
         var _loc6_:int = 0;
         while(_loc6_ < param1.getFilmXmlArray().length)
         {
            _loc7_ = param1.getFilmXmlArray()[_loc6_] as XML;
            _loc8_ = XML(_loc7_.child("meta")[0]).child("mver")[0] != null ? Number(Number(XML(_loc7_.child("meta")[0]).child("mver")[0])) : Number(0);
            this.startFrameOffsetForEachMovie.push(_loc6_.toString(),0);
            this._hiddenMovieTag += _loc7_.meta.hiddenTag;
            _loc9_ = this.sortSceneXmlByZorder(_loc7_.child(AnimeScene.XML_TAG));
            _loc3_ = 0;
            while(_loc3_ < _loc9_.length)
            {
               _loc11_ = _loc9_[_loc3_] as XML;
               if(!this.isSkipScene(_loc11_))
               {
                  (_loc10_ = new AnimeScene()).init(_loc11_,this,this.getDataStock().getThemeXMLs(),this.getDataStock(),_loc8_,_loc6_.toString(),param2);
                  this.addScene(_loc10_);
               }
               _loc3_++;
            }
            this._licensedSoundInfo = "";
            _loc3_ = 0;
            while(_loc3_ < _loc7_.child(AnimeSound.XML_TAG).length())
            {
               _loc16_ = _loc7_.child(AnimeSound.XML_TAG)[_loc3_];
               _loc12_ = AnimeSound.createAndInitSounds(_loc16_,this.getDataStock().getThemeXMLs(),_loc6_.toString(),this.getDataStock());
               _loc4_ = 0;
               while(_loc4_ < _loc12_.length)
               {
                  if((_loc13_ = _loc12_[_loc4_] as AnimeSound).isSpeech)
                  {
                     _loc13_.mute_inner_volume();
                  }
                  this.addSound(_loc13_);
                  if(_loc13_ is ProgressiveSound)
                  {
                     (_loc14_ = _loc13_ as ProgressiveSound).addEventListener(PlayerEvent.BUFFER_EXHAUST,this.onBufferExhaust,false,0,true);
                  }
                  else if(_loc13_ is StreamSound)
                  {
                     (_loc15_ = _loc13_ as StreamSound).addEventListener(AVM2SoundEvent.BUFFER_EXHAUST,this.onBufferExhaust,false,0,true);
                  }
                  _loc4_++;
               }
               if(_loc16_.hasOwnProperty("info"))
               {
                  this._licensedSoundInfo += _loc16_.info.title + " - Author: " + _loc16_.info.author + "\n";
               }
               _loc3_++;
            }
            _loc18_ = _loc7_..text;
            for each(_loc17_ in _loc18_)
            {
               if(_loc17_.@embed != "false" && _loc17_.hasOwnProperty("@font"))
               {
                  PlayerFontManager.instance.addFont(_loc17_.@font);
               }
            }
            _loc3_ = 0;
            while(_loc3_ < _loc7_.child(AssetLinkage.XML_TAG).length())
            {
               _loc19_ = _loc7_.child(AssetLinkage.XML_TAG)[_loc3_];
               (_loc20_ = new AssetLinkage()).deserialize(_loc19_);
               _loc21_ = _loc20_.getSoundId();
               _loc22_ = this.getSoundById(_loc21_);
               _loc23_ = false;
               if(_loc22_)
               {
                  _loc22_.addEventListener(SpeechPitchEvent.PITCH,this.onPitchReach);
                  _loc22_.speechData = _loc20_.getSceneAndCharId();
                  if(_loc24_ = this.getSceneById(_loc20_.getSceneId()))
                  {
                     _loc24_.narration = _loc22_;
                     if(_loc25_ = _loc24_.getCharByID(_loc20_.getCharId()))
                     {
                        if(!_loc25_.head)
                        {
                        }
                        _loc23_ = true;
                     }
                     _loc23_ = true;
                  }
                  if(!_loc23_)
                  {
                     _loc22_.mute_inner_volume();
                  }
                  else
                  {
                     _loc22_.unmute_inner_volume();
                  }
               }
               _loc3_++;
            }
            _loc6_++;
         }
         this.hideMovieContainer();
         this.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doShowMovieContainer,false,0,true);
         PlayerFontManager.instance.anime = this;
         PlayerFontManager.instance.addEventListener(Event.COMPLETE,this.onAllFontsLoaded);
         PlayerFontManager.instance.loadAllFonts();
         this._isInitialized = true;
      }
      
      private function onAllFontsLoaded(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onAllFontsLoaded);
         this.initDependency();
      }
      
      private function onPitchReach(param1:SpeechPitchEvent) : void
      {
         var _loc2_:AnimeScene = null;
         var _loc3_:Character = null;
         if(param1.sceneId == this.getSceneByIndex(this._currentSceneIndex).id)
         {
            CCLipSyncController.getInstance().speechSource = param1.target as IEventDispatcher;
            if(param1.soundId != this._currentSpeechId)
            {
               this._currentSpeechId = param1.soundId;
               _loc2_ = this.getSceneById(param1.sceneId);
               if(_loc2_)
               {
                  _loc3_ = _loc2_.getCharByID(param1.charId);
                  CCLipSyncController.getInstance().speakingCharacter = _loc3_;
               }
            }
         }
      }
      
      private function onBufferExhaust(param1:Event) : void
      {
         this.removeEnterFrame();
         this.dispatchEvent(new PlayerEvent(PlayerEvent.BUFFER_EXHAUST));
         this.downloadManager.addEventListener(PlayerEvent.BUFFER_READY,this.onBufferReady,false,0,true);
         this.downloadManager.reorganizeCustomerQueue(UtilUnitConvert.frameToSec(this.currentFrame) * 1000);
      }
      
      private function onBufferReady(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onBufferReady);
         this.addEnterFrame();
         this.dispatchEvent(new PlayerEvent(PlayerEvent.BUFFER_READY));
      }
      
      private function initDependency() : void
      {
         var _loc7_:int = 0;
         var _loc8_:AnimeScene = null;
         var _loc9_:AnimeScene = null;
         var _loc10_:AnimeScene = null;
         var _loc11_:Array = null;
         var _loc12_:AnimeSound = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:Number = this.getNumScene();
         var _loc3_:UtilHashArray = this.getDataStock().getThemeXMLs();
         var _loc4_:UtilLoadMgr = new UtilLoadMgr();
         if(_loc2_ > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc8_ = _loc7_ < _loc2_ - 1 ? this.getSceneByIndex(_loc7_ + 1) : null;
               _loc9_ = _loc7_ > 0 ? this.getSceneByIndex(_loc7_ - 1) : null;
               (_loc10_ = this.getSceneByIndex(_loc7_)).initDependency(_loc8_,_loc9_,_loc1_ + 1,this.downloadManager,_loc3_);
               _loc1_ += _loc10_.getDuration();
               ++TransitionSound.soundIndex;
               _loc7_++;
            }
            this.setDuration(_loc1_);
            if(this.getNumScene() > 0)
            {
               this.setCurrentScene(0,false);
            }
         }
         this.updateStartFrameOffsetForEachMovie();
         var _loc5_:int = 0;
         while(_loc5_ < this.getNumSounds())
         {
            (_loc12_ = this.getSoundByIndex(_loc5_)).initDependency(this.startFrameOffsetForEachMovie.getValueByKey(_loc12_.movieId) as Number,this.movieDurationPerMovie.getValueByKey(_loc12_.movieId) as Number,this.downloadManager);
            if(!this._soundsIndexByStartFrame.containsKey(_loc12_.getStartFrame().toString()))
            {
               this._soundsIndexByStartFrame.push(_loc12_.getStartFrame().toString(),new Array());
            }
            (_loc11_ = this._soundsIndexByStartFrame.getValueByKey(_loc12_.getStartFrame().toString()) as Array).push(_loc12_);
            if(!this._soundsIndexByEndFrame.containsKey(_loc12_.getEndFrame().toString()))
            {
               this._soundsIndexByEndFrame.push(_loc12_.getEndFrame().toString(),new Array());
            }
            (_loc11_ = this._soundsIndexByEndFrame.getValueByKey(_loc12_.getEndFrame().toString()) as Array).push(_loc12_);
            _loc13_ = _loc12_.getEndFrame();
            _loc14_ = _loc12_.getStartFrame();
            while(_loc14_ <= _loc13_)
            {
               if(!this._soundsIndexByFrame.containsKey(_loc14_.toString()))
               {
                  this._soundsIndexByFrame.push(_loc14_.toString(),new Array());
               }
               (_loc11_ = this._soundsIndexByFrame.getValueByKey(_loc14_.toString()) as Array).push(this.getSoundByIndex(_loc5_));
               _loc14_++;
            }
            _loc5_++;
         }
         this.downloadManager.initDependency(UtilUnitConvert.frameToSec(this.getDuration() * 1000),this.getMovieContainer().stage,this._frameNum);
         var _loc6_:PlayerEvent = new PlayerEvent(PlayerEvent.MOVIE_STRUCTURE_READY);
         this.dispatchEvent(_loc6_);
         this.initRemoteData(0);
      }
      
      private function doDispatchMovieStartBufferReady(param1:Event) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doDispatchMovieStartBufferReady);
         }
         var _loc2_:PlayerEvent = new PlayerEvent(PlayerEvent.BUFFER_READY_WHEN_MOVIE_START);
         this.dispatchEvent(_loc2_);
         this.addEnterFrame();
      }
      
      protected function startPlay() : void
      {
         this.setState(Anime.STATE_PLAYING);
         if(this.getNumScene() > 0)
         {
            this.setCurrentScene(0,false);
         }
         this.addEnterFrame();
      }
      
      private function putSceneToStage(param1:int) : void
      {
         try
         {
            this.getSceneByIndex(param1).prepareImage();
            UtilPlain.removeAllSon(this.getMovieContainer());
            this.getMovieContainer().addChild(this.getSceneByIndex(param1).getSceneMasterContainer());
         }
         catch(e:Error)
         {
         }
      }
      
      public function initRemoteDataByScene(param1:AnimeScene) : void
      {
         this.initRemoteData((param1 as AnimeScene).getStartFrame());
      }
      
      private function initRemoteData(param1:Number) : void
      {
         var _loc5_:EmbedSound = null;
         var _loc7_:AnimeScene = null;
         if(this._initRemoteData)
         {
            return;
         }
         this._initRemoteData = true;
         this.removeEnterFrame();
         var _loc2_:int = this.searchSceneIndexByFrame(param1);
         var _loc3_:int = this.getNumScene();
         var _loc4_:RemoteDataManager;
         (_loc4_ = RemoteDataManager.getInstance()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onInitAllRemoteDataCompleted,false,0,true);
         ProgressMonitor.getInstance().addProgressEventDispatcher(_loc4_);
         _loc4_.init(this.getDataStock());
         var _loc6_:int = 0;
         while(_loc6_ < this.getNumEmbedSounds())
         {
            _loc5_ = this.getEmbedSoundByIndex(_loc6_);
            _loc4_.addTask(_loc5_);
            _loc6_++;
         }
         var _loc8_:int = _loc2_;
         while(_loc8_ < _loc2_ + _loc3_ && _loc8_ < this.getNumScene())
         {
            _loc7_ = this.getSceneByIndex(_loc8_);
            _loc4_.addTask(_loc7_);
            _loc8_++;
         }
         _loc4_.commit();
      }
      
      private function onInitEachRemoteDataCompleted(... rest) : void
      {
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOADING_BYTES));
      }
      
      private function onInitAllRemoteDataCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitAllRemoteDataCompleted);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
         this._allSceneBufferReady = true;
         this.downloadManager.addEventListener(PlayerEvent.BUFFER_READY,this.doDispatchMovieStartBufferReady,false,0,true);
         this.downloadManager.startDownload();
      }
      
      private function addEnterFrame() : void
      {
         if(this.getNumScene() <= 0 || this.getDuration() == -1)
         {
            return;
         }
         if(!this.getMovieContainer().hasEventListener(Event.ENTER_FRAME))
         {
            this.getMovieContainer().addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
         }
         SceneBufferManager.highSpeedMode = false;
      }
      
      private function removeEnterFrame() : void
      {
         if(this.getMovieContainer().hasEventListener(Event.ENTER_FRAME))
         {
            this.getMovieContainer().removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         SceneBufferManager.highSpeedMode = true;
      }
      
      private function traceMemory(param1:Number, param2:String) : void
      {
         if(this.lastNum != param1)
         {
         }
         this.lastNum = param1;
      }
      
      private function onSceneBufferReady(param1:SceneBufferEvent) : void
      {
         this.putSceneToStage(this.getCurrentSceneIndex());
         this.addEnterFrame();
         this.dispatchEvent(new PlayerEvent(PlayerEvent.BUFFER_READY));
      }
      
      private function onEnterFrame(... rest) : void
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc8_:AnimeSound = null;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         var _loc12_:AnimeSound = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:AnimeScene = null;
         var _loc16_:BitmapData = null;
         var _loc17_:ByteArray = null;
         var _loc18_:String = null;
         var _loc19_:Number = NaN;
         if(!this._allSceneBufferReady)
         {
            this.removeEnterFrame();
            return;
         }
         ++this._currentFrame;
         if(this._currentFrame >= this.getDuration())
         {
            --this._currentFrame;
            this.pause();
            if(this._assetSound.hasEventListener("AssetSoundRdy"))
            {
               this._assetSound.removeEventListener("AssetSoundRdy",this.AssetSoundRdyHandeler);
            }
            this._assetSound.getSceneToStop(this.getSceneByIndex(this.getCurrentSceneIndex()),this.currentFrame);
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_MOVIE_END));
            return;
         }
         var _loc2_:AnimeScene = this.getSceneByIndex(this.getCurrentSceneIndex());
         var _loc3_:Boolean = false;
         if(this._currentFrame >= _loc2_.getEndFrame() && this.getCurrentSceneIndex() < this.getNumScene() - 1)
         {
            CCLipSyncController.getInstance().speakingCharacter = null;
            this._currentSpeechId = null;
            _loc3_ = true;
            this.setCurrentScene(this.getCurrentSceneIndex() + 1);
            _loc2_ = this.getSceneByIndex(this.getCurrentSceneIndex());
         }
         var _loc4_:Boolean = true;
         if(!_loc2_.readyToPlay)
         {
            _loc4_ = false;
         }
         if(SceneBufferManager.instance.isBufferReady == false)
         {
            _loc4_ = false;
         }
         var _loc7_:Boolean = true;
         if((_loc5_ = this.getSoundsByStartFrame(this._currentFrame)) != null)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               if((_loc8_ = _loc5_[_loc6_] as AnimeSound).getBufferProgress() < 100)
               {
                  _loc7_ = false;
                  break;
               }
               _loc6_++;
            }
         }
         if(!_loc7_)
         {
            _loc4_ = false;
            this.removeEnterFrame();
         }
         if(_loc4_ == false)
         {
            --this._currentFrame;
            SceneBufferManager.highSpeedMode = true;
            this.removeEnterFrame();
            this.dispatchEvent(new PlayerEvent(PlayerEvent.BUFFER_EXHAUST));
            if(!_loc2_.readyToPlay)
            {
               SceneBufferManager.highSpeedMode = true;
               SceneBufferManager.instance.addEventListener(SceneBufferEvent.BUFFER_READY,this.onSceneBufferReady);
               SceneBufferManager.instance.startBuffering(this.getCurrentSceneIndex(),this);
            }
         }
         else
         {
            SceneBufferManager.highSpeedMode = false;
            if(this.firstLoad)
            {
               this.firstLoad = false;
               _loc15_ = this.getSceneByIndex(this.getCurrentSceneIndex());
               ExternalInterface.addCallback("getPhotoArray",this.sendPhotoArray);
               this._assetSound.getSceneToPlay(this.currentFrame,_loc15_);
            }
            if(this.is_golite_preview == 1)
            {
               if(!this.photoTaken && this.getCurrentSceneIndex() > Math.floor(this.getNumScene() / 2) - 2 && AnimeScene(this._animeScenes[this.getCurrentSceneIndex()]).getEndFrame() - 1 == this.currentFrame && this.photoExistArray.indexOf(this.currentFrame) == -1)
               {
                  _loc16_ = Util.capturePicture(this.getMovieContainer(),new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT),AnimeConstants.SCREEN_WIDTH + AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_HEIGHT + AnimeConstants.SCREEN_Y);
                  if(this.photoExistArray.length == 4)
                  {
                     this.photoTaken = true;
                  }
                  _loc17_ = this.en.encode(_loc16_);
                  this.encoder.encodeBytes(_loc17_,0,_loc17_.length);
                  _loc18_ = this.encoder.flush();
                  this.photoArray.push(_loc18_);
                  this.photoExistArray.push(this.currentFrame);
               }
            }
            _loc9_ = new Date().time;
            _loc10_ = true;
            _loc11_ = 1;
            if(this._prevSystemTime < 0 || this._prevFrame < 0)
            {
               _loc10_ = false;
            }
            else if(_loc3_)
            {
               _loc10_ = false;
            }
            else if((_loc11_ = (_loc9_ - this._prevSystemTime) / 1000 / (this._currentFrame - this._prevFrame) * AnimeConstants.FRAME_PER_SEC) < 2)
            {
               _loc10_ = false;
            }
            else if(this._currentFrame % 2 == 0)
            {
               _loc10_ = false;
            }
            if(!_loc10_)
            {
               _loc2_.play(this._currentFrame);
            }
            if((_loc5_ = this.getSoundsByFrame(this._currentFrame)) != null)
            {
               _loc19_ = UtilUnitConvert.frameToSec(this._currentFrame) * 1000;
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  (_loc12_ = _loc5_[_loc6_] as AnimeSound).play(_loc19_);
                  _loc6_++;
               }
            }
            _loc5_ = this.getSoundsByEndFrame(this._currentFrame);
            _loc13_ = UtilUnitConvert.frameToSec(this.currentFrame,true) * 1000;
            if(_loc5_ != null)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  (_loc12_ = _loc5_[_loc6_] as AnimeSound).pause(_loc13_);
                  _loc6_++;
               }
            }
            if(this._isScenePreview == true && this._currentFrame < 10)
            {
               this.execute(Anime.COMMAND_PAUSE);
            }
            if(this.pauseAtFirstFrame)
            {
               this.pauseAtFirstFrame = false;
               this.execute(Anime.COMMAND_PAUSE);
            }
            if(this.getState() == Anime.STATE_PAUSING)
            {
               this.pauseAtFirstFrame = false;
               this.execute(Anime.COMMAND_PAUSE);
               this.pause();
            }
            if(this.setVolumeAtFirstLoad)
            {
               this.setVolumeAtFirstLoad = false;
               this.setVolume(this.volume);
            }
            this._prevFrame = this._currentFrame;
            this._prevSystemTime = _loc9_;
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_TIME_CHANGE));
            if((_loc14_ = _loc2_.getLastActionFrame()) - this._currentFrame <= 1 && _loc14_ > this._currentFrame)
            {
               this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_SCENE_LAST_ACTION_FRAME_REACHED));
            }
         }
         this.dispatchEvent(new PlayerEvent(Event.ENTER_FRAME,_loc11_));
      }
      
      private function sendPhotoArray() : Array
      {
         return this.photoArray;
      }
      
      private function pause(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:AnimeSound = null;
         try
         {
            this.setState(Anime.STATE_PAUSING);
            if(this._assetSound.hasEventListener("AssetSoundRdy"))
            {
               this._assetSound.removeEventListener("AssetSoundRdy",this.AssetSoundRdyHandeler);
            }
            this.removeEnterFrame();
            if(param1)
            {
               this.getSceneByIndex(this.getCurrentSceneIndex()).pause();
               this._assetSound.getSceneToStop(this.getSceneByIndex(this.searchSceneIndexByFrame(this.currentFrame)),this.currentFrame);
            }
            _loc3_ = UtilUnitConvert.frameToSec(this.currentFrame,true) * 1000;
            _loc2_ = 0;
            while(_loc2_ < this.getSoundsByFrame(this._currentFrame).length)
            {
               (_loc4_ = this.getSoundsByFrame(this._currentFrame)[_loc2_] as AnimeSound).pause(_loc3_);
               _loc2_++;
            }
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PAUSE));
         }
         catch(e:Error)
         {
         }
      }
      
      private function resume() : void
      {
         var _loc1_:int = 0;
         this.setState(Anime.STATE_PLAYING);
         this._assetSound.addEventListener("AssetSoundRdy",this.AssetSoundRdyHandeler,false,0,true);
         this._assetSound.getSceneToPlay(this.currentFrame,this._animeScenes[this.searchSceneIndexByFrame(this.currentFrame)] as AnimeScene);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.RESUME));
      }
      
      private function AssetSoundRdyHandeler(param1:Event) : void
      {
         var _loc3_:AnimeSound = null;
         if(this._assetSound.hasEventListener("AssetSoundRdy"))
         {
            this._assetSound.removeEventListener("AssetSoundRdy",this.AssetSoundRdyHandeler);
         }
         this.addEnterFrame();
         this.getSceneByIndex(this.getCurrentSceneIndex()).resume();
         var _loc2_:int = 0;
         while(_loc2_ < this.getSoundsByFrame(this._currentFrame).length)
         {
            _loc3_ = this.getSoundsByFrame(this._currentFrame)[_loc2_] as AnimeSound;
            _loc3_.resume();
            _loc2_++;
         }
      }
      
      private function goToAndPause(param1:Number, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:AnimeScene = null;
         var _loc7_:AnimeScene = null;
         var _loc8_:AnimeSound = null;
         this.setState(Anime.STATE_PAUSING);
         this._currentFrame = param1;
         if(this.getNumScene() > 0)
         {
            _loc5_ = this.searchSceneIndexByFrame(param1);
            if((_loc6_ = this.getSceneByIndex(_loc5_)).getTransitionNum() > 0)
            {
               if(_loc6_.getTransitionFrameNum() > _loc6_.movieToSceneFrame(param1))
               {
                  _loc5_--;
                  param1 = this.getSceneByIndex(_loc5_).getEndFrame();
                  this._currentFrame = param1;
               }
            }
            if(_loc5_ != this.getCurrentSceneIndex())
            {
               this.setCurrentScene(_loc5_,true,param2);
            }
            (_loc7_ = this.getSceneByIndex(this.getCurrentSceneIndex())).goToAndPause(param1);
         }
         var _loc4_:Number = UtilUnitConvert.frameToSec(param1) * 1000;
         _loc3_ = 0;
         while(_loc3_ < this.getSoundsByFrame(this._currentFrame).length)
         {
            (_loc8_ = this.getSoundsByFrame(this._currentFrame)[_loc3_] as AnimeSound).goToAndPause(_loc4_);
            _loc3_++;
         }
         this.downloadManager.reorganizeCustomerQueue(UtilUnitConvert.frameToSec(param1) * 1000);
         this.fadeVolume(1);
      }
      
      private function goToAndPauseReset() : void
      {
         var _loc1_:AnimeScene = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.getNumScene())
         {
            this.getSceneByIndex(_loc2_).goToAndPauseReset();
            _loc2_++;
         }
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      private function setVolume(param1:Number) : void
      {
         var _loc2_:int = 0;
         this._volume = param1;
         if(this.firstLoad)
         {
            this.setVolumeAtFirstLoad = true;
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumSounds())
         {
            this.getSoundByIndex(_loc2_).setVolume(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumScene())
         {
            this.getSceneByIndex(_loc2_).setVolume(param1);
            _loc2_++;
         }
         if(this._assetSound != null)
         {
            this._assetSound.setSceneVolume(this._currentFrame,this._animeScenes[this.searchSceneIndexByFrame(this.currentFrame)] as AnimeScene,param1);
         }
      }
      
      private function fadeVolume(param1:Number) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.getNumSounds())
         {
            this.getSoundByIndex(_loc2_).fadeVolume(param1);
            _loc2_++;
         }
      }
      
      private function isBufferReadyAtFrame(param1:Number) : Boolean
      {
         var _loc2_:int = this.searchSceneIndexByFrame(param1);
         if(this.getSceneByIndex(_loc2_).getBufferProgress() >= 100)
         {
            return true;
         }
         return false;
      }
      
      public function set scenePreviewFirstStart(param1:Number) : void
      {
         this._scenePreviewFirstStart = true;
         this._isScenePreview = true;
         this._frameNum = UtilUnitConvert.frameToSec(param1) * 1000;
      }
      
      protected function execute(param1:int, ... rest) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Array = null;
         switch(param1)
         {
            case Anime.COMMAND_PLAY:
               if(!(this.firstLoad && this.getState() == Anime.STATE_NULL))
               {
                  if(this.currentFrame < this.getDuration())
                  {
                     this.resume();
                  }
                  else
                  {
                     this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_MOVIE_END));
                  }
               }
               this.pauseAtFirstFrame = false;
               break;
            case Anime.COMMAND_PAUSE:
               if(this.firstLoad && (this.getState() == Anime.STATE_NULL || this.getState() == Anime.STATE_PAUSING))
               {
                  this.pauseAtFirstFrame = true;
               }
               else if(this.getState() == Anime.STATE_PLAYING)
               {
                  _loc5_ = true;
                  if(rest.length > 0)
                  {
                     _loc5_ = rest[0];
                  }
                  this.pause(_loc5_);
               }
               else if(this._assetSound != null)
               {
                  if(this._assetSound.hasEventListener("AssetSoundRdy"))
                  {
                     this._assetSound.removeEventListener("AssetSoundRdy",this.AssetSoundRdyHandeler);
                  }
                  this._assetSound.getSceneToStop(this.getSceneByIndex(this.searchSceneIndexByFrame(this.currentFrame)),this.currentFrame);
               }
               break;
            case Anime.COMMAND_GOTO_AND_PAUSE:
               if(this._isScenePreview == true)
               {
                  this._isScenePreview = false;
               }
               _loc3_ = Number(rest[0]);
               _loc4_ = Boolean(rest[1]);
               if(this.isBufferReadyAtFrame(_loc3_))
               {
                  this.goToAndPause(_loc3_,_loc4_);
               }
               else
               {
                  (_loc6_ = new Array()).push(_loc3_,_loc4_);
                  this.setCurCommand(param1,_loc6_);
                  this.addEventListener(PlayerEvent.INIT_REMOTE_DATA_COMPLETE,this.re_Execute,false,0,true);
                  this._currentFrame = _loc3_;
                  this.initRemoteData(_loc3_);
               }
               break;
            case Anime.COMMAND_SET_VOLUME:
               this.setVolume(rest[0] as Number);
               break;
            case Anime.COMMAND_REMOVE_ENTER_FRAME:
               this.removeEnterFrame();
               break;
            case Anime.COMMAND_ADD_ENTER_FRAME:
               this.addEnterFrame();
               break;
            case Anime.COMMAND_END:
               this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_MOVIE_END));
               break;
            case COMMAND_GOTO_AND_PAUSE_RESET:
               this.goToAndPauseReset();
         }
      }
      
      private function re_Execute(... rest) : void
      {
         this.removeAllListener(PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
         var _loc2_:int = this.getCurCommand();
         var _loc3_:Array = this.getCurCommandArg();
         this.removeCurCommand();
         this.execute(_loc2_,_loc3_[0],_loc3_[1]);
      }
      
      private function setState(param1:int) : void
      {
         switch(param1)
         {
            case Anime.STATE_NULL:
               this._state = param1;
               break;
            case Anime.STATE_PAUSING:
               this._state = param1;
               break;
            case Anime.STATE_PAUSING:
               this._state = param1;
               break;
            case Anime.STATE_PLAYING:
               this._state = param1;
         }
      }
      
      public function destroy() : void
      {
         this.downloadManager.destroy();
         this.getDataStock().destroy();
         if(this._isInitialized)
         {
            this.pause();
         }
      }
      
      private function getState() : int
      {
         return this._state;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      protected function dispatchEvent(param1:PlayerEvent) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      protected function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      protected function removeAllListener(param1:String, param2:Boolean = false) : void
      {
         return this._eventDispatcher.removeAllListener(param1,param2);
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         switch(param1)
         {
            case "scene":
               return new ArrayIterator(this._animeScenes);
            case "sound":
               return new ArrayIterator(this._sounds);
            default:
               return new ArrayIterator(this._animeScenes);
         }
      }
   }
}
