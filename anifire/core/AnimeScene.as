package anifire.core
{
   import anifire.assets.model.AssetOrdering;
   import anifire.assets.model.AssetSelection;
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.model.AssetTransitionCollection;
   import anifire.assets.transition.model.AssetTransitionEvent;
   import anifire.assets.transition.model.AssetTransitionHelper;
   import anifire.bubble.BubbleMgr;
   import anifire.command.AddAssetCommand;
   import anifire.command.ICommand;
   import anifire.component.*;
   import anifire.components.containers.*;
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.EffectTrayEvent;
   import anifire.constant.AnimeConstants;
   import anifire.core.sound.ProgressiveSound;
   import anifire.effect.EffectMgr;
   import anifire.effect.ZoomEffect;
   import anifire.errors.SerializeError;
   import anifire.event.CoreEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.events.SceneEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.ISceneModel;
   import anifire.interfaces.IXmlConvertable;
   import anifire.iterators.ArrayIterator;
   import anifire.iterators.NullIterator;
   import anifire.managers.*;
   import anifire.scene.model.AbstractSceneModel;
   import anifire.tutorial.*;
   import anifire.util.*;
   import caurina.transitions.*;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.collections.Sort;
   import mx.collections.SortField;
   import mx.collections.XMLListCollection;
   import mx.controls.Button;
   import mx.events.CollectionEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipFile;
   
   public class AnimeScene extends AbstractSceneModel implements ISceneModel
   {
      
      private static var _logger:ILogger = Log.getLogger("core.AnimeScene");
      
      private static const ASSET_CREATION_MODE_NEW_INSTANCE:String = "new instance";
      
      private static const ASSET_CREATION_MODE_OLD_INSTANCE:String = "old instance";
      
      private static const ASSET_CREATION_MODE_NULL:String = "nothing";
      
      public static var XML_NODE_NAME:String = "scene";
      
      private static var _existIDs:UtilHashArray = new UtilHashArray();
      
      private static var _sceneNum:int = 0;
      
      public static const DURATION_MODE_AUTO:uint = 0;
      
      public static const DURATION_MODE_CUSTOM:uint = 1;
      
      public static const DURATION_MODE_SPEECH:uint = 2;
       
      
      private var _console:Console;
      
      private var _id:String;
      
      private var _name:String;
      
      private var _background:Background;
      
      private var _transition:GoTransition;
      
      private var _assetTransitions:AssetTransitionCollection;
      
      private var _characters:UtilHashArray;
      
      private var _bubbles:UtilHashArray;
      
      private var _props:UtilHashArray;
      
      private var _effects:UtilHashArray;
      
      private var _cloneableAssetsInfo:UtilHashArray;
      
      private var _assetOrdering:AssetOrdering;
      
      private var _effectOrdering:AssetOrdering;
      
      private var _totalFrames:int = 60;
      
      private var _durationMode:uint = 0;
      
      private var _customTotalFrames:int = 60;
      
      private var _changed:Boolean;
      
      private var _isDragEnter:Boolean;
      
      private var _asset_creation_mode:String = "old instance";
      
      private var _asset_creation_thumb:Thumb;
      
      private var _asset_creation_dx:Number;
      
      private var _asset_creation_dy:Number;
      
      private var _sizingAsset:Asset;
      
      private const MOTION_TIME:Number = UtilUnitConvert.secToPixel(AnimeConstants.MOTION_DURATION);
      
      private const BACKGROUND_INDEX:int = 0;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _oldMousePoint:Point;
      
      private var _preselectAssetId:String = "";
      
      private var _sceneXML:XML;
      
      private var _combgId:String = "";
      
      private var _selection:AssetSelection;
      
      public function AnimeScene(param1:String = "")
      {
         this._assetOrdering = new AssetOrdering();
         this._effectOrdering = new AssetOrdering();
         this._eventDispatcher = new EventDispatcher();
         this._selection = new AssetSelection();
         super();
         ++_sceneNum;
         this._id = this.generateNewID(param1);
         this._name = param1;
         this._characters = new UtilHashArray();
         this._bubbles = new UtilHashArray();
         this._props = new UtilHashArray();
         this._effects = new UtilHashArray();
         this._cloneableAssetsInfo = new UtilHashArray();
         this._assetTransitions = new AssetTransitionCollection();
         this._assetTransitions.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onAssetTransitionChange);
         this._assetTransitions.addEventListener(AssetTransitionEvent.TIMING_CHANGE,this.onAssetTransitionChange);
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray) : UtilHashArray
      {
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:UtilHashArray = new UtilHashArray();
         _loc4_ = 0;
         while(_loc4_ < param1.child(Background.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(Background.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,Background.getThemeTrees(_loc5_,param2));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(Character.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(Character.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,Character.getThemeTrees(_loc5_,param2,param3));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(Prop.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(Prop.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,Prop.getThemeTrees(_loc5_,param2,param3));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(EffectAsset.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(EffectAsset.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,EffectAsset.getThemeTrees(_loc5_,param2));
            _loc4_++;
         }
         return _loc6_;
      }
      
      public function get selection() : AssetSelection
      {
         return this._selection;
      }
      
      public function get transition() : GoTransition
      {
         return this._transition;
      }
      
      public function set transition(param1:GoTransition) : void
      {
         if(this._transition)
         {
            this._transition.removeEventListener(Event.CHANGE,this.onTransitionChange);
         }
         if(param1)
         {
            this._transition = param1;
            this.addCloneableAssetInfo(this._transition.id,"transition");
         }
         else
         {
            if(this._transition)
            {
               this.removeCloneableAssetInfo(this._transition.id);
            }
            this._transition = param1;
         }
         if(this._transition)
         {
            this._transition.addEventListener(Event.CHANGE,this.onTransitionChange);
         }
         this.updateSystemDuration();
         this.dispatchEvent(new SceneEvent(SceneEvent.TRANSITION_CHANGE));
      }
      
      private function onTransitionChange(param1:Event) : void
      {
         this.dispatchEvent(new SceneEvent(SceneEvent.TRANSITION_CHANGE));
         this.updateSystemDuration();
      }
      
      public function get assetTransitions() : AssetTransitionCollection
      {
         return this._assetTransitions;
      }
      
      public function get duration() : Number
      {
         return UtilUnitConvert.frameToDuration(this.totalFrames);
      }
      
      public function get customDuration() : Number
      {
         return UtilUnitConvert.frameToDuration(this.customTotalFrames);
      }
      
      public function get totalFrames() : int
      {
         return this._totalFrames;
      }
      
      public function set totalFrames(param1:int) : void
      {
         param1 = Math.round(param1 / AnimeConstants.SCENE_FRAME_INTERVAL) * AnimeConstants.SCENE_FRAME_INTERVAL;
         if(param1 < AnimeConstants.SCENE_FRAME_MINIMUM)
         {
            param1 = AnimeConstants.SCENE_FRAME_MINIMUM;
         }
         else if(param1 > AnimeConstants.SCENE_FRAME_MAXIMUM)
         {
            param1 = AnimeConstants.SCENE_FRAME_MAXIMUM;
         }
         if(this._totalFrames != param1)
         {
            this._totalFrames = param1;
            this.dispatchEvent(new SceneEvent(SceneEvent.DURATION_CHANGE));
            if(this.transition && this.transition.duration > param1)
            {
               this.transition.duration = param1;
            }
         }
      }
      
      public function get durationMode() : uint
      {
         return this._durationMode;
      }
      
      public function setDurationMode(param1:uint = 0) : void
      {
         if(param1 != this._durationMode)
         {
            this._durationMode = param1;
            switch(param1)
            {
               case AnimeScene.DURATION_MODE_CUSTOM:
                  this.totalFrames = this.customTotalFrames;
                  break;
               case AnimeScene.DURATION_MODE_SPEECH:
                  this.totalFrames = this.speechTotalFrames;
                  break;
               default:
                  this.totalFrames = this.systemTotalFrames;
            }
            this.dispatchEvent(new SceneEvent(SceneEvent.DURATION_MODE_CHANGE));
         }
      }
      
      public function get customTotalFrames() : int
      {
         return this._customTotalFrames;
      }
      
      public function setCustomTotalFrames(param1:int) : void
      {
         param1 = Math.round(param1 / AnimeConstants.SCENE_FRAME_INTERVAL) * AnimeConstants.SCENE_FRAME_INTERVAL;
         if(param1 < AnimeConstants.SCENE_FRAME_MINIMUM)
         {
            param1 = AnimeConstants.SCENE_FRAME_MINIMUM;
         }
         else if(param1 > AnimeConstants.SCENE_FRAME_MAXIMUM)
         {
            param1 = AnimeConstants.SCENE_FRAME_MAXIMUM;
         }
         if(this._customTotalFrames != param1)
         {
            this._customTotalFrames = param1;
            this.totalFrames = this.customTotalFrames;
         }
         this.setDurationMode(AnimeScene.DURATION_MODE_CUSTOM);
      }
      
      private function updateSystemDuration() : void
      {
         if(this.durationMode == AnimeScene.DURATION_MODE_AUTO)
         {
            this.totalFrames = this.systemTotalFrames;
         }
         else if(this.durationMode == AnimeScene.DURATION_MODE_SPEECH)
         {
            this.totalFrames = this.speechTotalFrames;
         }
      }
      
      private function get systemTotalFrames() : int
      {
         var _loc1_:int = 0;
         var _loc8_:BubbleAsset = null;
         var _loc9_:Character = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            if(_loc8_ = this._bubbles.getValueByIndex(_loc1_) as BubbleAsset)
            {
               _loc3_ = Math.max(_loc3_,AnimeConstants.FRAME_PER_SEC + AnimeConstants.FRAME_PER_BUBBLE_WORD * UtilString.countWord(_loc8_.text));
            }
            _loc1_++;
         }
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            if(_loc9_ = this._characters.getValueByIndex(_loc1_) as Character)
            {
               _loc4_ = Math.max(_loc4_,_loc9_.getActionDefaultTotalFrame());
            }
            _loc1_++;
         }
         var _loc5_:int = AssetTransitionHelper.getTotalFrameOfTransitionBeforeNarration(this._assetTransitions) + Console.getConsole().speechManager.getSpeechTotalFrame(this);
         var _loc6_:int = 0;
         if(this.transition)
         {
            _loc6_ = this.transition.duration;
         }
         var _loc7_:int = AssetTransitionHelper.totalFramesByAssetTransition(this);
         _loc2_ = Math.max(_loc2_,_loc4_,_loc3_,_loc5_,_loc6_,_loc7_);
         _loc2_ = Math.round(_loc2_ / AnimeConstants.SCENE_FRAME_INTERVAL) * AnimeConstants.SCENE_FRAME_INTERVAL;
         if(_loc2_ == 0)
         {
            _loc2_ = AnimeConstants.SCENE_FRAME_DEFAULT;
         }
         return _loc2_;
      }
      
      private function get speechTotalFrames() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = AssetTransitionHelper.getTotalFrameOfTransitionBeforeNarration(this._assetTransitions) + Console.getConsole().speechManager.getSpeechTotalFrame(this);
         _loc2_ = Math.max(_loc2_,_loc3_);
         _loc2_ = Math.round(_loc2_ / AnimeConstants.SCENE_FRAME_INTERVAL) * AnimeConstants.SCENE_FRAME_INTERVAL;
         if(_loc2_ == 0)
         {
            _loc2_ = AnimeConstants.SCENE_FRAME_DEFAULT;
         }
         return _loc2_;
      }
      
      public function get combgId() : String
      {
         return this._combgId;
      }
      
      public function set combgId(param1:String) : void
      {
         this._combgId = param1;
      }
      
      public function set sceneXML(param1:XML) : void
      {
         this._sceneXML = param1;
      }
      
      public function get sceneXML() : XML
      {
         return this._sceneXML;
      }
      
      public function get sizingAsset() : Asset
      {
         return this._sizingAsset;
      }
      
      public function get camera() : Asset
      {
         return this._sizingAsset;
      }
      
      public function set dragEnter(param1:Boolean) : void
      {
         this._isDragEnter = param1;
      }
      
      private function onAssetTransitionChange(param1:Event) : void
      {
         this.updateSystemDuration();
         AssetTransitionHelper.checkAssetTransitionConflict(this);
      }
      
      public function doUpdateTimelineLength(param1:Number = -1, param2:Boolean = false) : void
      {
         this.updateSystemDuration();
      }
      
      public function get console() : Console
      {
         return this._console;
      }
      
      public function set console(param1:Console) : void
      {
         this._console = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
         _existIDs.push(param1,param1);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get background() : Background
      {
         return this._background;
      }
      
      public function set background(param1:Background) : void
      {
         this._background = param1;
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function set changed(param1:Boolean) : void
      {
      }
      
      public function get characters() : UtilHashArray
      {
         return this._characters;
      }
      
      public function get props() : UtilHashArray
      {
         return this._props;
      }
      
      public function get effects() : UtilHashArray
      {
         return this._effects;
      }
      
      public function get bubbles() : UtilHashArray
      {
         return this._bubbles;
      }
      
      public function set preselectAssetId(param1:String) : void
      {
         this._preselectAssetId = param1;
      }
      
      public function get preselectAssetId() : String
      {
         return this._preselectAssetId;
      }
      
      public function removeSound() : void
      {
      }
      
      public function muteSound(param1:Boolean) : void
      {
      }
      
      public function getNumberOfAssests() : int
      {
         if(this._background == null)
         {
            return this._characters.length + this._bubbles.length + this._props.length + this._effects.length + 0;
         }
         return this._characters.length + this._bubbles.length + this._props.length + this._effects.length + 1;
      }
      
      public function getCharacterById(param1:String) : Character
      {
         return Character(this._characters.getValueByKey(param1));
      }
      
      public function getCharacterInNextSceneById(param1:String) : Character
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = Console.getConsole().getScene(_loc2_ + 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getCharacterById(param1);
      }
      
      public function getCharacterInPrevSceneById(param1:String) : Character
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = Console.getConsole().getScene(_loc2_ - 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getCharacterById(param1);
      }
      
      public function getBubbleAssetById(param1:String) : BubbleAsset
      {
         return BubbleAsset(this._bubbles.getValueByKey(param1));
      }
      
      public function getPropById(param1:String) : Prop
      {
         return Prop(this._props.getValueByKey(param1));
      }
      
      public function getPropInNextSceneById(param1:String) : Prop
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = Console.getConsole().getScene(_loc2_ + 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getPropById(param1);
      }
      
      public function getPropInPrevSceneById(param1:String) : Prop
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = Console.getConsole().getScene(_loc2_ - 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getPropById(param1);
      }
      
      private function getEffectAssetByType(param1:String) : EffectAsset
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getExactType() == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getEffectAssetById(param1:String, param2:Number = 0) : EffectAsset
      {
         var _loc3_:int = this._console.getSceneIndex(this);
         var _loc4_:AnimeScene;
         if((_loc4_ = Console.getConsole().getScene(_loc3_ + param2)) == null)
         {
            return null;
         }
         return EffectAsset(_loc4_.effects.getValueByKey(param1));
      }
      
      public function getAssetById(param1:String) : Asset
      {
         if(param1.indexOf("BG") != -1)
         {
            return this._background;
         }
         if(param1.indexOf("AVATOR") != -1)
         {
            return this.getCharacterById(param1);
         }
         if(param1.indexOf("BUBBLE") != -1)
         {
            return this.getBubbleAssetById(param1);
         }
         if(param1.indexOf("EFFECT") != -1)
         {
            return this.getEffectAssetById(param1);
         }
         if(param1.indexOf("PROP") != -1)
         {
            return this.getPropById(param1);
         }
         return null;
      }
      
      private function addCharacter(param1:String, param2:Character) : void
      {
         this._characters.push(param1,param2);
      }
      
      private function addBubble(param1:String, param2:BubbleAsset) : void
      {
         this._bubbles.push(param1,param2);
         Console.getConsole().effectTray.addBubble(param1,Thumb(param2.thumb).name);
         this.refreshEffectTray(Console.getConsole().effectTray);
      }
      
      private function addProp(param1:String, param2:Prop) : void
      {
         this._props.push(param1,param2);
      }
      
      private function addEffect(param1:String, param2:EffectAsset) : void
      {
         this._effects.push(param1,param2);
         Console.getConsole().effectTray.addEffect(param1,param2.getType(),Thumb(param2.thumb).name);
         this.refreshEffectTray(Console.getConsole().effectTray);
      }
      
      private function getCloeableAssetInfo(param1:String) : String
      {
         return this._cloneableAssetsInfo.getValueByKey(param1);
      }
      
      private function getCloneableAssetIndex(param1:String) : int
      {
         return this._cloneableAssetsInfo.getIndex(param1);
      }
      
      private function addCloneableAssetInfo(param1:String, param2:String, param3:int = -1) : void
      {
         var _loc4_:UtilHashArray = null;
         if(param3 == -1)
         {
            this._cloneableAssetsInfo.push(param1,param2);
         }
         else
         {
            (_loc4_ = new UtilHashArray()).push(param1,param2);
            this._cloneableAssetsInfo.insert(param3,_loc4_);
         }
      }
      
      private function removeCloneableAssetInfo(param1:String) : void
      {
         var _loc2_:int = this._cloneableAssetsInfo.getIndex(param1);
         if(_loc2_ != -1)
         {
            this._cloneableAssetsInfo.remove(_loc2_,1);
         }
      }
      
      private function removeAllCharacters() : void
      {
         this._characters.removeAll();
      }
      
      private function removeCharacter(param1:Character) : void
      {
         this._characters.remove(this._characters.getIndex(param1.id),1);
      }
      
      private function removeAllBubbles() : void
      {
         this._bubbles.removeAll();
      }
      
      private function removeBubble(param1:BubbleAsset) : void
      {
         var _loc2_:int = this._bubbles.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._bubbles.remove(_loc2_,1);
            this.refreshEffectTray(Console.getConsole().effectTray);
         }
      }
      
      private function removeAllAttachedAssets() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Prop = null;
         var _loc3_:BubbleAsset = null;
         var _loc4_:EffectAsset = null;
         _loc1_ = this._props.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = Prop(this._props.getValueByIndex(_loc1_));
            if(_loc2_.attachedBg)
            {
               this.removeAsset(_loc2_);
               _loc2_.deleteAsset(false);
            }
            _loc1_--;
         }
         _loc1_ = this._bubbles.length - 1;
         while(_loc1_ >= 0)
         {
            _loc3_ = BubbleAsset(this._bubbles.getValueByIndex(_loc1_));
            if(_loc3_.attachedBg)
            {
               this.removeAsset(_loc3_);
               _loc3_.deleteAsset(false);
            }
            _loc1_--;
         }
         _loc1_ = this._effects.length - 1;
         while(_loc1_ >= 0)
         {
            if((_loc4_ = EffectAsset(this._effects.getValueByIndex(_loc1_))).attachedBg)
            {
               this.removeAsset(_loc4_);
               _loc4_.deleteAsset(false);
            }
            _loc1_--;
         }
      }
      
      private function removeAllProps() : void
      {
         this._props.removeAll();
      }
      
      private function removeProp(param1:Prop) : void
      {
         var _loc2_:int = this._props.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._props.remove(_loc2_,1);
         }
      }
      
      private function removeAllEffects() : void
      {
         this._effects.removeAll();
      }
      
      private function removeEffect(param1:EffectAsset) : void
      {
         var _loc2_:int = this._effects.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._effects.remove(_loc2_,1);
            this.refreshEffectTray(Console.getConsole().effectTray);
         }
         if(param1.getExactType() == EffectThumb.TYPE_ZOOM)
         {
            this._sizingAsset = null;
            this.dispatchEvent(new SceneEvent(SceneEvent.CAMERA_REMOVED,param1));
         }
      }
      
      private function removeBackground() : void
      {
         this._background = null;
      }
      
      private function removeTransition() : void
      {
         this.transition = null;
      }
      
      private function doDeserialize(param1:LoadMgrEvent) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc6_:Object;
         _loc3_ = (_loc6_ = _loc2_.getExtraData())["xml"];
         _loc5_ = (_loc4_ = _loc6_["removeAll"]) == "false" ? false : true;
         this.deSerialize(_loc3_,_loc5_,true,false);
      }
      
      public function addAsset(param1:Asset, param2:Boolean = false) : void
      {
         var onAddedHandler:Function = null;
         var onAddedBGSoundHandler:Function = null;
         var loadMgr:UtilLoadMgr = null;
         var needToLoad:Boolean = false;
         var extraData:Object = null;
         var assetThemeId:String = null;
         var assetTheme:Theme = null;
         var bgUsedThumbs:UtilHashArray = null;
         var curThumb:Thumb = null;
         var k:Number = NaN;
         var i:int = 0;
         var state:State = null;
         var onAddedCharSoundHandler:Function = null;
         var randomText:String = null;
         var _fontMgr:FontManager = null;
         var onAddedPropSoundHandler:Function = null;
         var onAddedEffectSoundHandler:Function = null;
         var needAdd:Boolean = false;
         var programEffAsset:ProgramEffectAsset = null;
         var prevAsset:EffectAsset = null;
         var asset:Asset = param1;
         var forceAtBottom:Boolean = param2;
         if(asset is Background)
         {
            onAddedBGSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(!!Console.getConsole().soundMute ? Number(0) : Number(1)));
               }
               asset.removeEventListener("SoundAdded",onAddedBGSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedBGSoundHandler);
            if(asset.thumb.xml == null)
            {
               if(this._background != null)
               {
                  this.removeAsset(this._background);
               }
               this._background = Background(asset);
               this.addCloneableAssetInfo(asset.id,"background");
               this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_ADDED,asset));
               Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.BG_ADDED,this));
            }
            else if(asset.thumb.xml != null)
            {
               this.combgId = asset.thumb.themeId + "." + asset.thumb.id;
               loadMgr = new UtilLoadMgr();
               needToLoad = false;
               extraData = new Object();
               assetThemeId = asset.thumb.theme.id;
               assetTheme = ThemeManager.instance.getTheme(assetThemeId);
               extraData["xml"] = asset.thumb.xml;
               extraData["removeAll"] = "false";
               loadMgr.setExtraData(extraData);
               loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doDeserialize);
               bgUsedThumbs = new UtilHashArray();
               bgUsedThumbs = asset.thumb.theme.doOutputThumbs(asset.thumb.xml);
               k = 0;
               k = 0;
               while(k < bgUsedThumbs.length)
               {
                  curThumb = bgUsedThumbs.getValueByIndex(k);
                  if(curThumb is BackgroundThumb && !BackgroundThumb(curThumb).isThumbReady())
                  {
                     needToLoad = true;
                     loadMgr.addEventDispatcher(curThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                     curThumb.loadImageData();
                  }
                  else if(!(curThumb is CharThumb))
                  {
                     if(curThumb is PropThumb)
                     {
                        if(PropThumb(curThumb).states.length > 0)
                        {
                           i = 0;
                           while(i < PropThumb(curThumb).states.length)
                           {
                              state = PropThumb(curThumb).states[i];
                              if(state.imageData == null && asset.thumb.theme.isStateExists(asset.thumb.xml,state))
                              {
                                 needToLoad = true;
                                 loadMgr.addEventDispatcher(state,CoreEvent.LOAD_STATE_COMPLETE);
                                 PropThumb(curThumb).loadState(state);
                              }
                              i++;
                           }
                        }
                        else if(curThumb.imageData == null)
                        {
                           needToLoad = true;
                           loadMgr.addEventDispatcher(curThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                           curThumb.loadImageData();
                        }
                     }
                     else if(!(curThumb is BubbleThumb))
                     {
                        if(curThumb is EffectThumb && !EffectThumb(curThumb).isThumbReady())
                        {
                           needToLoad = true;
                           loadMgr.addEventDispatcher(curThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                           curThumb.loadImageData();
                        }
                     }
                  }
                  k++;
               }
               if(needToLoad)
               {
                  loadMgr.commit();
               }
               if(!needToLoad)
               {
                  this.deSerialize(asset.thumb.xml,false,true,false);
               }
            }
         }
         else if(asset is Character)
         {
            onAddedCharSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(!!Console.getConsole().soundMute ? Number(0) : Number(1)));
               }
               asset.removeEventListener("SoundAdded",onAddedCharSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedCharSoundHandler);
            this.addCharacter(asset.id,Character(asset));
            this.addCloneableAssetInfo(asset.id,"char");
            this._assetOrdering.addAsset(asset);
            if(Console.getConsole().mainStage.isCameraMode && Console.getConsole().stageScale > 1)
            {
               asset.scaleX = 1 / Console.getConsole().stageScale;
               asset.scaleY = 1 / Console.getConsole().stageScale;
               asset.scaleX = asset.scaleY = Math.max(asset.scaleX,asset.scaleY);
            }
            this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_ADDED,asset));
            Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_ADDED,asset));
         }
         else if(asset is BubbleAsset)
         {
            if((asset as BubbleAsset).fromTray)
            {
               randomText = PresetMsg.getInstance().getRandomMsg(Console.getConsole().thumbTray.getCurrentThemeId());
               if(randomText != "" && randomText != null)
               {
                  (asset as BubbleAsset).text = randomText;
                  (asset as BubbleAsset).bubble.backupText = randomText;
               }
               _fontMgr = FontManager.getFontManager();
               if(!_fontMgr.isFontLoaded((asset as BubbleAsset).bubble.textFont) && (asset as BubbleAsset).bubble.textEmbed == true)
               {
                  _fontMgr.loadFont((asset as BubbleAsset).bubble.textFont,(asset as BubbleAsset).bubble.addedToStageHandler);
               }
               if(Console.getConsole().stageScale > 1 && Console.getConsole().mainStage.isCameraMode)
               {
                  (asset as BubbleAsset).setSize(1 / Console.getConsole().stageScale);
               }
            }
            this.addBubble(asset.id,BubbleAsset(asset));
            if(BubbleAsset(asset).bubble.type == BubbleMgr.BLANK)
            {
               this.addCloneableAssetInfo(asset.id,"bubble");
            }
            this._assetOrdering.addAsset(asset);
            BubbleAsset(asset).bubble.buttonMode = true;
            if(asset.isLoadded)
            {
            }
            asset.isLoadded = false;
            this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_ADDED,asset));
            if((asset as BubbleAsset).fromTray)
            {
               this.selectedAsset = asset;
               Console.getConsole().sceneController.preselectAssetId = asset.id;
            }
         }
         else if(asset is Prop)
         {
            if(asset is VideoProp && this.isVideoTypeExist())
            {
               this.deleteAllVideos();
            }
            onAddedPropSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(!!Console.getConsole().soundMute ? Number(0) : Number(1)));
               }
               asset.removeEventListener("SoundAdded",onAddedPropSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedPropSoundHandler);
            this._assetOrdering.addAsset(asset);
            if(Prop(asset).attachedBg && forceAtBottom)
            {
               this.addProp(asset.id,Prop(asset));
               this.addCloneableAssetInfo(asset.id,"prop",0);
               this._assetOrdering.sendToBack(asset);
            }
            else
            {
               this.addProp(asset.id,Prop(asset));
               this.addCloneableAssetInfo(asset.id,"prop");
            }
            if(asset.isLoadded)
            {
            }
            asset.isLoadded = false;
            if(Console.getConsole().mainStage.isCameraMode && Console.getConsole().stageScale > 1)
            {
               asset.scaleX = 1 / Console.getConsole().stageScale;
               asset.scaleY = 1 / Console.getConsole().stageScale;
               asset.scaleX = asset.scaleY = Math.max(asset.scaleX,asset.scaleY);
            }
            this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_ADDED,asset));
         }
         else if(asset is EffectAsset)
         {
            onAddedEffectSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(!!Console.getConsole().soundMute ? Number(0) : Number(1)));
               }
               asset.removeEventListener("SoundAdded",onAddedEffectSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedEffectSoundHandler);
            if(asset is AnimeEffectAsset)
            {
               needAdd = true;
            }
            else
            {
               programEffAsset = asset as ProgramEffectAsset;
               if(this.isProgramEffectTypeExist(programEffAsset.getExactType()))
               {
                  needAdd = false;
               }
               else
               {
                  needAdd = true;
               }
               if(programEffAsset.getExactType() == EffectThumb.TYPE_ZOOM)
               {
                  programEffAsset.needControl = true;
                  if(!needAdd)
                  {
                     if(!Console.getConsole().mainStage.isCameraMode)
                     {
                        EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)).deleteAsset(false);
                        needAdd = true;
                     }
                  }
               }
               if(programEffAsset.getExactType() == EffectThumb.TYPE_FADING)
               {
                  if(!needAdd)
                  {
                     EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_FADING)).deleteAsset(false);
                     needAdd = true;
                  }
               }
            }
            this._effectOrdering.addAsset(asset);
            if(needAdd)
            {
               this.addEffect(asset.id,EffectAsset(asset));
               if(EffectAsset(asset).effect is ZoomEffect)
               {
                  EffectAsset(asset).effect.buttonMode = true;
                  EffectAsset(asset).refreshMotionShadow();
                  this._sizingAsset = asset;
                  prevAsset = this.getEffectAssetById(asset.id,-1);
                  if(prevAsset && !EffectAsset(asset).fromSpeech && EffectAsset(asset).fromTray)
                  {
                     asset.width = prevAsset.width;
                     asset.height = prevAsset.height;
                     asset.x = prevAsset.x;
                     asset.y = prevAsset.y;
                     if(prevAsset.motionShadow)
                     {
                        asset.width = prevAsset.motionShadow.width;
                        asset.height = prevAsset.motionShadow.height;
                        asset.x = prevAsset.motionShadow.x;
                        asset.y = prevAsset.motionShadow.y;
                     }
                     if(EffectAsset(asset).motionShadow)
                     {
                        EffectAsset(asset).motionShadow.width = asset.width;
                        EffectAsset(asset).motionShadow.height = asset.height;
                        EffectAsset(asset).motionShadow.x = asset.x;
                        EffectAsset(asset).motionShadow.y = asset.y;
                     }
                  }
                  this.dispatchEvent(new SceneEvent(SceneEvent.CAMERA_ADDED,asset));
               }
            }
            if(Thumb(asset.thumb).shouldBeCopyToNextScene)
            {
               this.addCloneableAssetInfo(asset.id,"effect");
            }
            this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_ADDED,asset));
         }
         var movieThumb:Thumb = asset.thumb as Thumb;
         if(asset is Character && asset.mThumbId)
         {
            movieThumb = Theme(asset.thumb.theme).getCharThumbById(asset.mThumbId);
         }
         Console.getConsole().addThumbToMovieTheme(movieThumb as Thumb);
      }
      
      public function freezeAssets() : void
      {
      }
      
      public function meltAllAssets() : void
      {
      }
      
      private function deleteAllVideos() : void
      {
         var _loc1_:Prop = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.props.length)
         {
            _loc1_ = this.props.getValueByIndex(_loc2_) as Prop;
            if(_loc1_ is VideoProp)
            {
               _loc1_.deleteAsset();
               this.removeAsset(_loc1_);
            }
            _loc2_++;
         }
      }
      
      public function deleteAllAssets() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.deleteAsset(false);
         }
         _loc1_ = this._characters.length - 1;
         while(_loc1_ >= 0)
         {
            Character(this._characters.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_--;
         }
         _loc1_ = this._props.length - 1;
         while(_loc1_ >= 0)
         {
            Prop(this._props.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_--;
         }
         _loc1_ = this._bubbles.length - 1;
         while(_loc1_ >= 0)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_--;
         }
         _loc1_ = this._effects.length - 1;
         while(_loc1_ >= 0)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_--;
         }
      }
      
      public function removeAllAssets() : void
      {
         this.removeSound();
         this.removeBackground();
         this.removeAllCharacters();
         this.removeAllBubbles();
         this.removeAllProps();
         this.removeAllEffects();
      }
      
      public function destroy(param1:String = "rip") : void
      {
         this.deleteAllAssets();
         this.removeAllAssets();
      }
      
      public function removeAsset(param1:Asset) : void
      {
         if(param1 is Background)
         {
            this.removeAllAttachedAssets();
            this.removeBackground();
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is Character)
         {
            this.removeCharacter(Character(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is BubbleAsset)
         {
            this.removeBubble(BubbleAsset(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is Prop)
         {
            this.removeProp(Prop(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is EffectAsset)
         {
            this.removeEffect(EffectAsset(param1));
         }
         this._assetOrdering.removeAsset(param1);
         this._effectOrdering.removeAsset(param1);
         this._assetTransitions.removeByAssetId(param1.id);
         this.updateSystemDuration();
         this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_REMOVED,param1));
      }
      
      public function bringForward(param1:Asset = null) : Boolean
      {
         if(param1 == null)
         {
            param1 = this.selectedAsset;
         }
         this._assetOrdering.bringForward(param1);
         this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_ORDER_CHANGE,param1));
         return false;
      }
      
      public function getAssetOrdering(param1:IAsset) : int
      {
         if(param1 is EffectAsset)
         {
            return this._effectOrdering.getOrdering(param1);
         }
         return this._assetOrdering.getOrdering(param1);
      }
      
      public function getOverallOrdering(param1:IAsset) : int
      {
         if(param1 is EffectAsset)
         {
            return this._effectOrdering.getOrdering(param1) + this._assetOrdering.length + 1;
         }
         return this._assetOrdering.getOrdering(param1) + 1;
      }
      
      public function sendBackward(param1:Asset = null) : Boolean
      {
         if(param1 == null)
         {
            param1 = this.selectedAsset;
         }
         this._assetOrdering.sendBackward(param1);
         this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_ORDER_CHANGE,param1));
         return false;
      }
      
      private function getFacingFromThemeXMLByThumbId(param1:XML, param2:String) : String
      {
         var charXML:XML = null;
         var themeXML:XML = param1;
         var thumbId:String = param2;
         try
         {
            charXML = themeXML.char.(@id == thumbId)[0];
            if(charXML != null)
            {
               return charXML.@facing;
            }
         }
         catch(e:Error)
         {
         }
         return AnimeConstants.FACING_UNKNOW;
      }
      
      private function putDataBySceneXML(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Theme = null;
         var _loc8_:BackgroundThumb = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:CharThumb = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:PropThumb = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:PropThumb = null;
         var _loc20_:EffectThumb = null;
         var _loc21_:int = 0;
         var _loc22_:String = null;
         for each(_loc2_ in param1.children())
         {
            _loc3_ = _loc2_.name();
            _loc4_ = _loc3_ == Character.XML_NODE_NAME ? _loc2_.action : _loc2_.file;
            _loc5_ = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
            _loc6_ = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
            if((_loc7_ = ThemeManager.instance.getTheme(_loc5_)) == null)
            {
               continue;
            }
            switch(_loc3_)
            {
               case Background.XML_NODE_NAME:
                  _loc8_ = _loc7_.getBackgroundThumbById(_loc6_);
                  this.console.putData(_loc8_.theme.id + ".bg." + _loc8_.id,ByteArray(_loc8_.imageData));
                  break;
               case Character.XML_NODE_NAME:
                  _loc9_ = UtilXmlInfo.getZipFileNameOfBehaviour(_loc2_.action,true);
                  _loc10_ = UtilXmlInfo.getThumbIdFromFileName(_loc9_);
                  _loc11_ = UtilXmlInfo.getCharIdFromFileName(_loc9_);
                  _loc12_ = _loc7_.getCharThumbById(_loc11_);
                  this.console.putData(_loc12_.theme.id + ".char." + _loc12_.id + "." + _loc10_,_loc12_.getActionById(_loc10_).imageData);
                  _loc21_ = 0;
                  while(_loc21_ < _loc12_.getLibraryNum())
                  {
                     _loc22_ = _loc12_.getLibraryIdByIndex(_loc21_);
                     this.console.putData(_loc22_,_loc12_.getLibraryById(_loc22_));
                     _loc21_++;
                  }
                  this.putDataBySceneXML(_loc2_);
                  break;
               case Prop.XML_NODE_NAME:
               case Prop.XML_NODE_NAME_WEAR:
                  _loc13_ = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
                  _loc14_ = _loc4_.split(".").length == 3 ? _loc13_ : UtilXmlInfo.getCharIdFromFileName(_loc4_);
                  if((_loc15_ = _loc7_.getPropThumbById(_loc14_) as PropThumb).getStateNum() == 0)
                  {
                     this.console.putData(_loc15_.theme.id + ".prop." + _loc15_.id,ByteArray(_loc15_.imageData));
                  }
                  else
                  {
                     this.console.putData(_loc15_.theme.id + ".prop." + _loc15_.id + "." + _loc15_.getStateById(_loc13_).id,ByteArray(_loc15_.getStateById(_loc13_).imageData));
                  }
                  break;
               case Prop.XML_NODE_NAME_HEAD:
                  _loc16_ = UtilXmlInfo.getZipFileNameOfProp(_loc4_);
                  _loc17_ = UtilXmlInfo.getThumbIdFromFileName(_loc16_);
                  _loc18_ = UtilXmlInfo.getCharIdFromFileName(_loc16_);
                  if(_loc17_.indexOf(".head.") != -1)
                  {
                     _loc18_ = UtilXmlInfo.getFacialThumbIdFromFileName(_loc17_);
                     _loc17_ = UtilXmlInfo.getFacialIdFromFileName(_loc17_);
                  }
                  else
                  {
                     _loc18_ = _loc17_;
                  }
                  if((_loc19_ = _loc7_.getPropThumbById(_loc18_) as PropThumb).getStateNum() == 0)
                  {
                     this.console.putData(_loc19_.theme.id + ".prop." + _loc19_.id,_loc19_.imageData);
                  }
                  else
                  {
                     this.console.putData(_loc19_.theme.id + ".prop." + _loc19_.id + "." + _loc19_.getStateById(_loc17_).id,_loc19_.getStateById(_loc17_).imageData);
                  }
                  break;
               case EffectAsset.XML_NODE_NAME:
                  _loc20_ = _loc7_.getEffectThumbById(_loc6_);
                  this.console.putData(_loc20_.theme.id + ".effect." + _loc20_.id,ByteArray(_loc20_.imageData));
                  break;
            }
         }
      }
      
      public function deSerialize(param1:XML, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : void
      {
         var filename:String = null;
         var id:String = null;
         var theme:Theme = null;
         var themeId:String = null;
         var thumbId:String = null;
         var nodeXML:XML = null;
         var item:XML = null;
         var k:int = 0;
         var j:int = 0;
         var sceneNode:XML = param1;
         var removeAll:Boolean = param2;
         var doLoadBytes:Boolean = param3;
         var unloadAfterFinish:Boolean = param4;
         var sortedIndex:Array = UtilXmlInfo.getAndSortXMLattribute(sceneNode,"index");
         if(sceneNode.hasOwnProperty("@combgId"))
         {
            this.combgId = sceneNode.@combgId;
         }
         if(removeAll)
         {
            this._cloneableAssetsInfo = new UtilHashArray();
            this.deleteAllAssets();
            this.removeAllAssets();
         }
         else
         {
            k = 1;
            j = sortedIndex.length;
            while(j > 0)
            {
               nodeXML = sceneNode.children().(@index == String(sortedIndex[j - 1]))[0];
               nodeXML.@newIndex = k;
               k++;
               j--;
            }
            nodeXML = sceneNode.child("bg")[0];
            nodeXML.@newIndex = 0;
            sortedIndex = UtilXmlInfo.getAndSortXMLattribute(sceneNode,"newIndex");
         }
         var loadMgr:UtilLoadMgr = new UtilLoadMgr();
         var exdata:Object = new Object();
         exdata["unloadAfterFinish"] = unloadAfterFinish;
         exdata["doLoadBytes"] = doLoadBytes;
         loadMgr.setExtraData(exdata);
         loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onDeserializeAndAddComplete);
         var xmlc:XMLListCollection = new XMLListCollection(sceneNode.children());
         var nameSort:Sort = new Sort();
         nameSort.fields = [new SortField(!!removeAll ? "@index" : "@newIndex",true,false,true)];
         xmlc.sort = nameSort;
         xmlc.refresh();
         sceneNode.setChildren(xmlc.copy());
         var i:int = 0;
         while(i < sceneNode.children().length())
         {
            nodeXML = sceneNode.children()[i];
            this.deserializeAsset(nodeXML,removeAll,true,doLoadBytes,loadMgr);
            i++;
         }
         loadMgr.commit();
         if(sceneNode.hasOwnProperty(AssetTransitionConstants.TAG_NAME_TRANSITION_LIST))
         {
            this._assetTransitions.convertFromXml(sceneNode.child(AssetTransitionConstants.TAG_NAME_TRANSITION_LIST)[0]);
         }
         if(removeAll)
         {
            this.deserializeSceneLength(sceneNode,true);
         }
      }
      
      public function deserializeSceneLength(param1:XML, param2:Boolean = false) : void
      {
         if(param1.hasOwnProperty("@adelay"))
         {
            this._totalFrames = int(param1.@adelay);
         }
         if(param1.hasOwnProperty("@lock"))
         {
            if(param1.@lock == "Y")
            {
               this._durationMode = AnimeScene.DURATION_MODE_CUSTOM;
               this._customTotalFrames = int(param1.@adelay);
            }
            else if(param1.@lock == "S")
            {
               this._durationMode = AnimeScene.DURATION_MODE_SPEECH;
               this._customTotalFrames = int(param1.@adelay);
            }
            else
            {
               this._durationMode = AnimeScene.DURATION_MODE_AUTO;
               this._customTotalFrames = AnimeConstants.SCENE_FRAME_DEFAULT;
            }
         }
         this.dispatchEvent(new SceneEvent(SceneEvent.DURATION_CHANGE));
      }
      
      private function onDeserializeAndAddComplete(param1:LoadMgrEvent) : void
      {
         var _loc2_:Object = UtilLoadMgr(param1.currentTarget).getExtraData();
         var _loc3_:Boolean = _loc2_["unloadAfterFinish"];
         var _loc4_:Boolean = _loc2_["doLoadBytes"];
         setTimeout(this.dispatchDeserializeComplete,300,_loc3_,_loc4_);
      }
      
      public function dispatchDeserializeComplete(param1:Boolean, param2:Boolean) : void
      {
         if(!param2)
         {
         }
         if(param1)
         {
            this.unloadAllAssets(false);
         }
         else
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ALL_ASSETS_COMPLETE,this));
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.DESERIALIZE_SCENE_COMPLETE,this));
      }
      
      public function isAssetAlreadyExist(param1:XML) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Character = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Prop = null;
         var _loc2_:String = param1.name();
         if(_loc2_ == Character.XML_NODE_NAME)
         {
            _loc3_ = 0;
            while(_loc3_ < this._characters.length)
            {
               _loc4_ = Character(this._characters.getValueByIndex(_loc3_));
               if(param1.children() == XML(_loc4_.serialize()).children())
               {
                  return true;
               }
               _loc3_++;
            }
         }
         else if(_loc2_ == BubbleAsset.XML_NODE_NAME)
         {
            _loc5_ = 0;
            while(_loc5_ < this._bubbles.length)
            {
               if(param1.children() == XML(BubbleAsset(this._bubbles.getValueByIndex(_loc5_)).serialize()).children())
               {
                  return true;
               }
               _loc5_++;
            }
         }
         else if(_loc2_ == Prop.XML_NODE_NAME)
         {
            _loc6_ = 0;
            while(_loc6_ < this._props.length)
            {
               _loc7_ = Prop(this._props.getValueByIndex(_loc6_));
               if(param1.children() == XML(_loc7_.serialize()).children())
               {
                  return true;
               }
               _loc6_++;
            }
         }
         return false;
      }
      
      private function indentAsset(param1:XML) : XML
      {
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         try
         {
            _loc2_ = false;
            _loc3_ = null;
            do
            {
               _loc2_ = this.isAssetAlreadyExist(param1);
               if(_loc2_)
               {
                  _loc3_ = String(param1.child("x")[0]).split(",");
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.length)
                  {
                     _loc3_[_loc4_] = Number(_loc3_[_loc4_]) + 10;
                     _loc4_++;
                  }
                  param1.child("x")[0] = _loc3_.toString();
                  _loc3_ = String(param1.child("y")[0]).split(",");
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.length)
                  {
                     _loc3_[_loc4_] = Number(_loc3_[_loc4_]) + 10;
                     _loc4_++;
                  }
                  param1.child("y")[0] = _loc3_.toString();
               }
            }
            while(_loc2_);
            
         }
         catch(e:Error)
         {
         }
         return param1;
      }
      
      private function checkLinkWithComBg(param1:Asset) : void
      {
         var combgThemeId:String = null;
         var combgId:String = null;
         var bgThumb:BackgroundThumb = null;
         var xmlList:XMLList = null;
         var fxId:String = null;
         var asset:Asset = param1;
         try
         {
            if(this.combgId && this.combgId != "")
            {
               combgThemeId = this.combgId.split(".")[0];
               combgId = this.combgId.split(".")[1];
               bgThumb = ThemeManager.instance.getTheme(combgThemeId).getBackgroundThumbById(combgId);
               if(asset is Prop)
               {
                  xmlList = bgThumb.xml.prop.(hasOwnProperty("file") && file == Prop(asset).fileId);
               }
               else if(asset is BubbleAsset)
               {
                  xmlList = bgThumb.xml.bubbleAsset.bubble.(text == BubbleAsset(asset).text);
               }
               else if(asset is EffectAsset)
               {
                  fxId = bgThumb.xml.effectAsset.effect.@id;
                  if(fxId == EffectAsset(asset).effect.id)
                  {
                     asset.attachedBg = true;
                  }
               }
               if(xmlList && xmlList.length() > 0)
               {
                  asset.attachedBg = true;
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function deserializeAsset(param1:XML, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:UtilLoadMgr = null) : Asset
      {
         var _loc8_:Asset = null;
         var _loc9_:Background = null;
         var _loc10_:Character = null;
         var _loc11_:Boolean = false;
         var _loc12_:BubbleAsset = null;
         var _loc13_:Prop = null;
         var _loc14_:EffectAsset = null;
         var _loc15_:GoTransition = null;
         var _loc6_:String = param1.name();
         var _loc7_:Boolean = false;
         switch(_loc6_)
         {
            case Background.XML_NODE_NAME:
               (_loc9_ = new Background(param1.@id)).capScreenLock = this.console.capScreenLock;
               if(param5 != null)
               {
                  param5.addEventDispatcher(_loc9_,CoreEvent.LOAD_ASSET_COMPLETE);
               }
               _loc9_.deSerialize(param1,this,param4);
               if(_loc9_.thumb != null && _loc9_.imageData)
               {
                  this.addAsset(_loc9_);
               }
               else
               {
                  _loc9_.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,_loc9_));
               }
               _loc8_ = _loc9_;
               break;
            case Character.XML_NODE_NAME:
               (_loc10_ = new Character(!!param3 ? param1.@id : "")).capScreenLock = this.console.capScreenLock;
               _loc11_ = this.isAssetAlreadyExist(param1);
               if(!param3)
               {
                  param1 = this.indentAsset(param1);
               }
               if(param5 != null)
               {
                  param5.addEventDispatcher(_loc10_,CoreEvent.LOAD_ASSET_COMPLETE);
               }
               _loc10_.deSerialize(param1,this,param4);
               if(_loc11_ && _loc10_.actionSequence)
               {
                  _loc10_.actionSequence.randomize();
               }
               if(_loc10_.thumb != null && _loc10_.imageData)
               {
                  this.addAsset(_loc10_);
               }
               else
               {
                  _loc10_.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,_loc10_));
               }
               _loc8_ = _loc10_;
               break;
            case BubbleAsset.XML_NODE_NAME:
               (_loc12_ = new BubbleAsset(!!param3 ? param1.@id : "")).capScreenLock = this.console.capScreenLock;
               if(!param3)
               {
                  param1 = this.indentAsset(param1);
               }
               _loc12_.deSerialize(param1,this);
               if(!param2)
               {
                  _loc12_.attachedBg = true;
                  _loc7_ = true;
               }
               this.checkLinkWithComBg(_loc12_);
               this.addAsset(_loc12_,_loc7_);
               _loc8_ = _loc12_;
               break;
            case Prop.XML_NODE_NAME:
               if(param1.@subtype == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
               {
                  _loc13_ = new VideoProp();
               }
               else
               {
                  _loc13_ = new Prop(!!param3 ? param1.@id : "");
               }
               _loc13_.capScreenLock = this.console.capScreenLock;
               if(!param3 && !(_loc13_ is VideoProp))
               {
                  param1 = this.indentAsset(param1);
               }
               if(param5 != null && !(_loc13_ is VideoProp))
               {
                  param5.addEventDispatcher(_loc13_,CoreEvent.LOAD_ASSET_COMPLETE);
               }
               _loc13_.deSerialize(param1,null,this,param3,param4);
               if(!param2)
               {
                  _loc13_.attachedBg = true;
                  _loc7_ = true;
               }
               this.checkLinkWithComBg(_loc13_);
               if(_loc13_.thumb != null && _loc13_.imageData)
               {
                  this.addAsset(_loc13_,_loc7_);
               }
               else
               {
                  _loc13_.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,_loc13_));
               }
               _loc8_ = _loc13_;
               break;
            case EffectAsset.XML_NODE_NAME:
               if(EffectAsset.getEffectType(param1) == EffectMgr.TYPE_ANIME)
               {
                  _loc14_ = new AnimeEffectAsset(!!param3 ? param1.@id : null);
               }
               else
               {
                  _loc14_ = new ProgramEffectAsset(!!param3 ? param1.@id : null);
               }
               _loc14_.capScreenLock = this.console.capScreenLock;
               _loc14_.deSerialize(param1,this,true);
               if(!param2)
               {
                  _loc14_.attachedBg = true;
               }
               this.checkLinkWithComBg(_loc14_);
               this.addAsset(_loc14_);
               _loc8_ = _loc14_;
               break;
            case GoTransition.XML_NODE_NAME:
               (_loc15_ = new GoTransition()).deserialize(param1);
               _loc15_.scene = this;
               this.transition = _loc15_;
         }
         return _loc8_;
      }
      
      private function onCallLaterHandler() : void
      {
         Console.getConsole().setCurrentScene(Console.getConsole().getSceneIndex(this));
         this.changed = true;
      }
      
      public function getLengthInPixel(param1:int = -1) : Number
      {
         if(param1 < 0)
         {
            param1 = Console.getConsole().getSceneIndex(this);
         }
         return this._console.timeline.getSceneInfoByIndex(param1).actionPixel;
      }
      
      public function getLength(param1:int = -1, param2:Boolean = true) : Number
      {
         if(param1 < 0)
         {
            param1 = Console.getConsole().getSceneIndex(this);
         }
         return UtilUnitConvert.pixelToFrame(this._console.timeline.getSceneInfoByIndex(param1).actionPixel,param2);
      }
      
      public function getLengthInSecond(param1:int = -1, param2:Boolean = true) : Number
      {
         if(param1 < 0)
         {
            param1 = Console.getConsole().getSceneIndex(this);
         }
         return UtilUnitConvert.pixelToSec(this._console.timeline.getSceneInfoByIndex(param1).actionPixel);
      }
      
      public function convertToXml() : XML
      {
         var index:int = 0;
         var adelay:Number = NaN;
         var lock:String = null;
         var combgString:String = null;
         var i:int = 0;
         var asset:IXmlConvertable = null;
         var bgThemeId:String = null;
         var bgId:String = null;
         var xml:XML = <scene/>;
         try
         {
            index = Console.getConsole().getSceneIndex(this);
            adelay = this._totalFrames;
            if(this.sceneXML)
            {
               this.sceneXML.@index = index;
               return this.sceneXML;
            }
            lock = "N";
            if(this.durationMode == AnimeScene.DURATION_MODE_CUSTOM)
            {
               lock = "Y";
            }
            else if(this.durationMode == AnimeScene.DURATION_MODE_SPEECH)
            {
               lock = "S";
            }
            xml.@id = this._id;
            xml.@adelay = Util.roundNum(adelay);
            xml.@lock = lock;
            xml.@index = index;
            combgString = this.combgId != "" ? " combgId=\"" + this.combgId + "\" " : "";
            if(this.combgId != "")
            {
               bgThemeId = this.combgId.split(".")[0];
               bgId = this.combgId.split(".")[1];
               try
               {
                  if(ThemeManager.instance.getTheme(bgThemeId).getBackgroundThumbById(bgId).getFileName() != this._background.thumb.themeId + "." + this._background.thumb.id)
                  {
                     combgString = "";
                  }
               }
               catch(e:Error)
               {
                  combgString = "";
               }
            }
            if(combgString != "")
            {
               xml.@combgId = this.combgId;
            }
            if(this._background)
            {
               xml.appendChild(this._background.convertToXml());
            }
            i = 0;
            i = 0;
            while(i < this._characters.length)
            {
               asset = this._characters.getValueByIndex(i) as IXmlConvertable;
               if(asset)
               {
                  xml.appendChild(asset.convertToXml());
               }
               i++;
            }
            i = 0;
            while(i < this._bubbles.length)
            {
               asset = this._bubbles.getValueByIndex(i) as IXmlConvertable;
               if(asset)
               {
                  xml.appendChild(asset.convertToXml());
               }
               i++;
            }
            i = 0;
            while(i < this._props.length)
            {
               asset = this._props.getValueByIndex(i) as IXmlConvertable;
               if(asset)
               {
                  xml.appendChild(asset.convertToXml());
               }
               i++;
            }
            i = 0;
            while(i < this._effects.length)
            {
               asset = this._effects.getValueByIndex(i) as IXmlConvertable;
               if(asset)
               {
                  xml.appendChild(asset.convertToXml());
               }
               i++;
            }
            if(this._transition)
            {
               xml.appendChild(this._transition.convertToXml());
            }
            xml.appendChild(this._assetTransitions.convertToXml());
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize scene: " + this.id);
         }
         return xml;
      }
      
      public function serialize(param1:int = -1, param2:Boolean = true) : String
      {
         var xmlStr:String = null;
         var adelay:Number = NaN;
         var combgString:String = null;
         var lock:String = null;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var effectAsset:EffectAsset = null;
         var m:int = 0;
         var combgThemeId:String = null;
         var combgId:String = null;
         var char:Character = null;
         var charData:UtilHashArray = null;
         var char_i:int = 0;
         var prop:Prop = null;
         var propData:UtilHashArray = null;
         var prop_i:int = 0;
         var index:int = param1;
         var stockdata:Boolean = param2;
         xmlStr = this.convertToXml().toXMLString();
         try
         {
            if(index < 0)
            {
               index = Console.getConsole().getSceneIndex(this);
            }
            adelay = this._totalFrames;
            if(this.sceneXML != null)
            {
               if(stockdata)
               {
                  this.putDataBySceneXML(this.sceneXML);
               }
               this.sceneXML.@index = index;
               return this.sceneXML.toString();
            }
            combgString = this.combgId != "" ? " combgId=\"" + this.combgId + "\" " : "";
            if(this.combgId != "")
            {
               combgThemeId = this.combgId.split(".")[0];
               combgId = this.combgId.split(".")[1];
               try
               {
                  if(ThemeManager.instance.getTheme(combgThemeId).getBackgroundThumbById(combgId).getFileName() != this._background.thumb.themeId + "." + this._background.thumb.id)
                  {
                     combgString = "";
                  }
               }
               catch(e:Error)
               {
                  combgString = "";
               }
            }
            lock = "N";
            if(this.durationMode == AnimeScene.DURATION_MODE_CUSTOM)
            {
               lock = "Y";
            }
            else if(this.durationMode == AnimeScene.DURATION_MODE_SPEECH)
            {
               lock = "S";
            }
            if(this._background != null)
            {
               if(stockdata)
               {
                  this.console.putData(this._background.thumb.theme.id + ".bg." + this._background.thumb.id,ByteArray(this._background.thumb.imageData));
               }
            }
            i = 0;
            while(i < this._characters.length)
            {
               char = Character(this._characters.getValueByIndex(i));
               if(stockdata)
               {
                  charData = char.getDataAndKey();
                  char_i = 0;
                  while(char_i < charData.length)
                  {
                     this.console.putData(charData.getKey(char_i),charData.getValueByIndex(char_i));
                     char_i++;
                  }
               }
               i++;
            }
            j = 0;
            while(j < this._bubbles.length)
            {
               j++;
            }
            k = 0;
            while(k < this._props.length)
            {
               prop = Prop(this._props.getValueByIndex(k));
               if(stockdata)
               {
                  if(PropThumb(prop.thumb).getStateNum() == 0)
                  {
                     this.console.putData(prop.thumb.theme.id + ".prop." + prop.thumb.id,ByteArray(prop.thumb.imageData));
                  }
                  else
                  {
                     propData = prop.getDataAndKey();
                     prop_i = 0;
                     while(prop_i < propData.length)
                     {
                        this.console.putData(propData.getKey(prop_i),propData.getValueByIndex(prop_i));
                        prop_i++;
                     }
                  }
               }
               k++;
            }
            m = 0;
            while(m < this._effects.length)
            {
               effectAsset = this._effects.getValueByIndex(m) as EffectAsset;
               if(stockdata)
               {
                  this.console.putData(effectAsset.thumb.theme.id + ".effect." + effectAsset.thumb.id,effectAsset.thumb.imageData as ByteArray);
               }
               m++;
            }
            if(this._transition != null)
            {
            }
         }
         catch(e:Error)
         {
            throw new SerializeError("Failed to serialize scene " + this.id,xmlStr,e);
         }
         return xmlStr;
      }
      
      public function get selectedAsset() : Asset
      {
         return this.selection.selectedAsset as Asset;
      }
      
      public function set selectedAsset(param1:Asset) : void
      {
         this.selection.selectedAsset = param1;
      }
      
      public function refreshEffectTray(param1:EffectTray = null) : void
      {
         var _loc3_:EffectAsset = null;
         var _loc4_:BubbleAsset = null;
         var _loc6_:Boolean = false;
         if(param1 == null)
         {
            param1 = Console.getConsole().effectTray;
         }
         param1.removeEventListener(EffectTrayEvent.EFFECT_PRESS,this.doEffectTrayClick);
         param1.removeEventListener(EffectTrayEvent.EFFECT_OVER,this.doEffectTrayOver);
         param1.removeEventListener(EffectTrayEvent.EFFECT_OUT,this.doEffectTrayOut);
         var _loc2_:int = 0;
         param1.reset();
         var _loc5_:String;
         if((_loc5_ = Console.getConsole().linkageController.getSpeechSoundIdByScene(this)) != "")
         {
            param1.addSpeech(_loc5_);
         }
         _loc2_ = 0;
         while(_loc2_ < this.bubbles.length)
         {
            _loc4_ = this.bubbles.getValueByIndex(_loc2_) as BubbleAsset;
            param1.addBubble(_loc4_.id,Thumb(_loc4_.thumb).name);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.effects.length)
         {
            _loc3_ = this.effects.getValueByIndex(_loc2_) as EffectAsset;
            _loc6_ = false;
            if(Console.getConsole().metaData.mver > 3)
            {
               if(_loc3_ is ProgramEffectAsset && ProgramEffectAsset(_loc3_).effect is ZoomEffect)
               {
                  _loc6_ = true;
               }
            }
            if(!_loc6_)
            {
               param1.addEffect(_loc3_.id,_loc3_.getType(),Thumb(_loc3_.thumb).name);
            }
            _loc2_++;
         }
         param1.addEventListener(EffectTrayEvent.EFFECT_PRESS,this.doEffectTrayClick);
         param1.addEventListener(EffectTrayEvent.EFFECT_OVER,this.doEffectTrayOver);
         param1.addEventListener(EffectTrayEvent.EFFECT_OUT,this.doEffectTrayOut);
      }
      
      public function updateEffectTray(param1:Number, param2:Number) : void
      {
         var _loc4_:EffectAsset = null;
         var _loc5_:BubbleAsset = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.bubbles.length)
         {
            (_loc5_ = this.bubbles.getValueByIndex(_loc3_) as BubbleAsset).updateTimeByScene(param1,param2);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.effects.length)
         {
            (_loc4_ = this.effects.getValueByIndex(_loc3_) as EffectAsset).updateTimeByScene(param1,param2);
            _loc3_++;
         }
      }
      
      public function onCloneAndAddComplete(param1:LoadMgrEvent) : void
      {
         var _loc2_:Object = UtilLoadMgr(param1.currentTarget).getExtraData();
         var _loc3_:AnimeScene = _loc2_["scene"];
         if(this.preselectAssetId != "")
         {
            _loc3_.selectedAsset = _loc3_.getAssetById(this.preselectAssetId);
            this.preselectAssetId = "";
         }
      }
      
      public function cloneNext() : AnimeScene
      {
         var _loc2_:Asset = null;
         var _loc3_:Asset = null;
         var _loc4_:IIterator = null;
         var _loc1_:AnimeScene = new AnimeScene();
         _loc1_.console = this.console;
         if(this._background && Thumb(this._background.thumb).shouldBeCopyToNextScene)
         {
            _loc2_ = this._background.cloneNext();
            _loc2_.scene = _loc1_;
            _loc1_.addAsset(_loc2_);
         }
         _loc4_ = this._assetOrdering.iterator();
         while(_loc4_.hasNext)
         {
            _loc2_ = _loc4_.next as Asset;
            if(_loc2_ && _loc2_.shouldBeCopyToNextScene)
            {
               if(!AssetTransitionHelper.isAlreadyOut(_loc2_.id,this._assetTransitions))
               {
                  _loc3_ = _loc2_.cloneNext();
                  _loc3_.scene = _loc1_;
                  _loc1_.addAsset(_loc3_);
               }
            }
         }
         _loc4_ = this._effectOrdering.iterator();
         while(_loc4_.hasNext)
         {
            _loc2_ = _loc4_.next as Asset;
            if(_loc2_ && _loc2_.shouldBeCopyToNextScene)
            {
               _loc3_ = _loc2_.cloneNext();
               _loc3_.scene = _loc1_;
               if(_loc3_ is ProgramEffectAsset)
               {
                  ProgramEffectAsset(_loc3_).fixZoomDur(_loc1_.duration);
               }
               _loc1_.addAsset(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function clone() : AnimeScene
      {
         var _loc2_:Asset = null;
         var _loc3_:Asset = null;
         var _loc4_:IIterator = null;
         var _loc1_:AnimeScene = new AnimeScene();
         _loc1_.console = this.console;
         _loc1_.combgId = this.combgId;
         if(this._background)
         {
            _loc2_ = this._background.clone(true);
            _loc2_.scene = _loc1_;
            _loc1_.addAsset(_loc2_);
         }
         _loc4_ = this._assetOrdering.iterator();
         while(_loc4_.hasNext)
         {
            _loc2_ = _loc4_.next as Asset;
            if(_loc2_)
            {
               _loc3_ = _loc2_.clone(true);
               _loc3_.scene = _loc1_;
               _loc1_.addAsset(_loc3_);
            }
         }
         _loc4_ = this._effectOrdering.iterator();
         while(_loc4_.hasNext)
         {
            _loc2_ = _loc4_.next as Asset;
            if(_loc2_)
            {
               _loc3_ = _loc2_.clone(true);
               _loc3_.scene = _loc1_;
               _loc1_.addAsset(_loc3_);
            }
         }
         return _loc1_;
      }
      
      private function doEffectTrayClick(param1:EffectTrayEvent) : void
      {
         var _loc2_:Asset = this.getAssetById(param1.id);
         if(_loc2_ is BubbleAsset)
         {
            (_loc2_ as BubbleAsset).showMenu(Console.getConsole().mainStage.stage.mouseX,Console.getConsole().mainStage.stage.mouseY);
         }
         else if(_loc2_ is EffectAsset)
         {
            (_loc2_ as EffectAsset).showMenu(Console.getConsole().mainStage.stage.mouseX,Console.getConsole().mainStage.stage.mouseY);
         }
         else
         {
            this.showSpeechMenu(Console.getConsole().mainStage.stage.mouseX,Console.getConsole().mainStage.stage.mouseY);
         }
      }
      
      public function showSpeechMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:ScrollableArrowMenu = null;
         var _loc3_:* = "";
         var _loc6_:Boolean = true;
         _loc3_ = "<root><menuItem label=\"" + UtilDict.toDisplay("go","Play") + "\"value=\"" + "play" + "\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",EffectAsset.MENU_LABEL_EDIT) + "\"value=\"" + EffectAsset.MENU_LABEL_EDIT + "\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",EffectAsset.MENU_LABEL_DELETE) + "\"value=\"" + EffectAsset.MENU_LABEL_DELETE + "\"/></root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = ScrollableArrowMenu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doSpeechMenuClick);
         _loc5_.show(param1 - 80,param2);
      }
      
      public function doSpeechMenuClick(param1:MenuEvent) : void
      {
         var _loc5_:AnimeSound = null;
         var _loc6_:Asset = null;
         var _loc7_:int = 0;
         var _loc8_:Character = null;
         var _loc9_:Boolean = false;
         var _loc10_:EffectAsset = null;
         var _loc2_:XML = XML(param1.item);
         var _loc3_:String = Console.getConsole().linkageController.getSpeechSoundIdByScene(this);
         var _loc4_:String = Console.getConsole().linkageController.getTargetIdOfSpeech(_loc3_);
         if(_loc2_.attribute("value").toString() == "play")
         {
            (_loc5_ = Console.getConsole().speechManager.getValueByKey(_loc3_)).playSound();
         }
         else if(_loc2_.attribute("value").toString() == EffectAsset.MENU_LABEL_EDIT)
         {
            _loc6_ = this.getCharacterById(_loc4_.split(AssetLinkage.LINK)[1]);
            this.selectedAsset = _loc6_;
            Console.getConsole().showControl();
            Console.getConsole().propertiesWindow.showSpeechPanel();
         }
         else if(_loc2_.attribute("value").toString() == EffectAsset.MENU_LABEL_DELETE)
         {
            Console.getConsole().speechManager.removeSoundById(_loc3_);
            _loc7_ = this.effects.length - 1;
            while(_loc7_ >= 0)
            {
               if((_loc10_ = this.effects.getValueByIndex(_loc7_) as EffectAsset).fromSpeech)
               {
                  _loc10_.deleteAsset();
               }
               _loc7_--;
            }
            this.refreshEffectTray(Console.getConsole().effectTray);
            if(_loc9_ = (_loc8_ = this.getCharacterById(_loc4_.split(AssetLinkage.LINK)[1])).restoreActionFromTalk())
            {
               this.doUpdateTimelineLength(-1,true);
            }
            this.selectedAsset = null;
         }
      }
      
      private function doEffectTrayOver(param1:EffectTrayEvent) : void
      {
         var _loc2_:Asset = this.getAssetById(param1.id);
         if(_loc2_ != null && Console.getConsole().currentScene == this)
         {
            this.selectedAsset = null;
         }
      }
      
      private function doEffectTrayOut(param1:EffectTrayEvent) : void
      {
      }
      
      private function getAssetId(param1:Thumb) : AssetLocation
      {
         var _loc5_:int = 0;
         var _loc6_:UtilHashArray = null;
         var _loc7_:Asset = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:Asset = null;
         var _loc10_:UtilHashArray = null;
         var _loc11_:Prop = null;
         var _loc12_:UtilHashArray = null;
         var _loc13_:Prop = null;
         var _loc14_:UtilHashArray = null;
         var _loc15_:EffectAsset = null;
         var _loc2_:String = param1.id;
         var _loc3_:AnimeScene = Console.getConsole().movie.getPrevScene(this);
         var _loc4_:AnimeScene = Console.getConsole().movie.getNextScene(this);
         if(param1 is CharThumb)
         {
            if(_loc3_ != null)
            {
               _loc6_ = _loc3_.characters;
               _loc5_ = 0;
               while(_loc5_ < _loc6_.length)
               {
                  _loc7_ = _loc6_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc7_.thumb.id)
                  {
                     if(this.getAssetById(_loc7_.id) == null)
                     {
                        return new AssetLocation(_loc7_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
            if(_loc4_ != null)
            {
               _loc8_ = _loc4_.characters;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.length)
               {
                  _loc9_ = _loc8_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc9_.thumb.id)
                  {
                     if(this.getAssetById(_loc9_.id) == null)
                     {
                        return new AssetLocation(_loc9_.id,_loc4_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         else if(param1 is PropThumb)
         {
            if(_loc3_ != null)
            {
               _loc10_ = _loc3_.props;
               _loc5_ = 0;
               while(_loc5_ < _loc10_.length)
               {
                  _loc11_ = _loc10_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc11_.thumb.id)
                  {
                     if(this.getAssetById(_loc11_.id) == null)
                     {
                        return new AssetLocation(_loc11_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
            if(_loc4_ != null)
            {
               _loc12_ = _loc4_.props;
               _loc5_ = 0;
               while(_loc5_ < _loc12_.length)
               {
                  _loc13_ = _loc12_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc13_.thumb.id)
                  {
                     if(this.getAssetById(_loc13_.id) == null)
                     {
                        return new AssetLocation(_loc13_.id,_loc4_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         else if(param1 is EffectThumb)
         {
            if(_loc3_ != null)
            {
               if(EffectThumb(param1).getExactType() == EffectThumb.TYPE_ZOOM && EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)) != null)
               {
                  EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)).deleteAsset(false);
               }
               _loc14_ = _loc3_.effects;
               _loc5_ = 0;
               while(_loc5_ < _loc14_.length)
               {
                  _loc15_ = _loc14_.getValueByIndex(_loc5_);
                  if(EffectThumb(param1).getExactType() == EffectThumb(_loc15_.thumb).getExactType())
                  {
                     if(this.getAssetById(_loc15_.id) == null)
                     {
                        return new AssetLocation(_loc15_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         return null;
      }
      
      public function pasteAssets(param1:Array) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:ICommand = null;
         var _loc5_:Asset = null;
         var _loc6_:String = null;
         if(param1 && param1.length > 0)
         {
            _loc2_ = 0;
            for each(_loc3_ in param1)
            {
               if(XML(_loc3_).name().toString() == "char")
               {
                  _loc2_++;
               }
            }
            if(this._characters.length + _loc2_ > FeatureManager.maxCharacterPerScene)
            {
               UtilPopUp.alert(UtilDict.toDisplay("go","At this time, each scene may only have a maximum of 3 characters."));
               return;
            }
            (_loc4_ = new AddAssetCommand()).execute();
            for each(_loc6_ in param1)
            {
               _loc5_ = this.deserializeAsset(XML(_loc6_),true,false);
            }
            if(_loc5_ && param1.length == 1)
            {
               Console.getConsole().currentScene.selectedAsset = _loc5_;
               Console.getConsole().sceneController.preselectAssetId = _loc5_.id;
            }
         }
      }
      
      private function doCreateAssetAtSceneAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Thumb = _loc3_[0] as Thumb;
         var _loc5_:Number = _loc3_[1];
         var _loc6_:Number = _loc3_[2];
         var _loc7_:String = _loc3_[3];
         Util.gaTracking("/gostudio/assets/" + _loc4_.theme.id + "/complete/" + _loc4_.id,Console.getConsole().mainStage.stage);
         this.createAsset(_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      private function replaceVideo(param1:Event) : void
      {
         this.deleteAllVideos();
         var _loc2_:Array = Button(param1.currentTarget).data as Array;
         this.createAsset(_loc2_[0],_loc2_[1],_loc2_[2]);
      }
      
      public function doCreateAsset(param1:Thumb, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Boolean = false) : void
      {
         var _loc7_:Vector.<XML> = null;
         var _loc8_:ICommand = null;
         var _loc6_:Thumb = param1;
         if(param1 is CharThumb)
         {
            if(this._characters.length >= FeatureManager.maxCharacterPerScene)
            {
               UtilPopUp.alert(UtilDict.toDisplay("go","At this time, each scene may only have a maximum of 3 characters."));
               return;
            }
            if(param1.path)
            {
               _loc7_ = new Vector.<XML>();
               if(CharThumb(param1).propXML.length > 0)
               {
                  _loc7_ = CharThumb(param1).propXML.concat();
               }
               _loc6_ = Theme(param1.theme).getCharThumbById(param1.path);
               CharThumb(_loc6_).propXML = _loc7_.concat();
               CharThumb(_loc6_).mThumbId = param1.id;
            }
         }
         if(!(param1 is SoundThumb))
         {
            (_loc8_ = new AddAssetCommand()).execute();
         }
         this.createAsset(_loc6_,param2,param3,param4,param5);
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         var _loc2_:Array = null;
         if(param1 == "bg")
         {
            return new ArrayIterator([this._background]);
         }
         if(param1 == "asset")
         {
            _loc2_ = this._characters.getArray();
            if(_loc2_)
            {
               _loc2_ = _loc2_.concat(this._props.getArray());
            }
            if(_loc2_)
            {
               _loc2_ = _loc2_.concat(this._bubbles.getArray());
            }
            return new ArrayIterator(_loc2_);
         }
         if(param1 == "effect")
         {
            return new ArrayIterator(this._effects.getArray());
         }
         return new NullIterator();
      }
      
      public function createAsset(param1:Thumb, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Boolean = false) : void
      {
         var _loc6_:GoAlert = null;
         var _loc7_:Asset = null;
         var _loc8_:UtilLoadMgr = null;
         var _loc9_:Array = null;
         var _loc10_:CharThumb = null;
         var _loc11_:AssetLocation = null;
         var _loc12_:String = null;
         var _loc13_:BackgroundThumb = null;
         var _loc14_:BubbleThumb = null;
         var _loc15_:SoundThumb = null;
         var _loc16_:AnimeScene = null;
         var _loc17_:PropThumb = null;
         var _loc18_:AssetLocation = null;
         var _loc19_:String = null;
         var _loc20_:EffectThumb = null;
         var _loc21_:AssetLocation = null;
         var _loc22_:String = null;
         if(param1 is VideoPropThumb && this.isVideoTypeExist())
         {
            (_loc6_ = GoAlert(PopUpManager.createPopUp(Console.getConsole().mainStage,GoAlert,true)))._lblConfirm.text = "";
            _loc6_._txtDelete.text = UtilDict.toDisplay("go","goalert_confirmreplacevideo");
            _loc6_._btnDelete.label = UtilDict.toDisplay("go","goalert_confirmreplacevideoyes");
            _loc6_._btnDelete.data = new Array(param1,param2,param3);
            _loc6_._btnDelete.addEventListener(MouseEvent.CLICK,this.replaceVideo);
            _loc6_._btnCancel.label = UtilDict.toDisplay("go","goalert_confirmreplacevideono");
            _loc6_._btnCancel.data = new Array(param1,param2,param3);
            _loc6_.x = (_loc6_.stage.width - _loc6_.width) / 2;
            _loc6_.y = 100;
            return;
         }
         if(Console.getConsole().initCreation == true)
         {
            Console.getConsole().initCreation = false;
            Util.gaTracking("/gostudio/sigAction",Console.getConsole().mainStage.stage);
         }
         if(param3 >= 0)
         {
            if(param1 is CharThumb)
            {
               if(!(_loc10_ = param1 as CharThumb).isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(_loc10_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  if(_loc10_.theme.id == "ugc" && CharThumb(param1).isSWFCharacter())
                  {
                     _loc10_.loadActionsAndMotions();
                  }
                  else
                  {
                     _loc10_.loadAction();
                  }
               }
               else
               {
                  if((_loc11_ = this.getAssetId(param1)) != null)
                  {
                     _loc12_ = _loc11_.assetId;
                  }
                  else
                  {
                     _loc12_ = "";
                  }
                  (_loc7_ = new Character(_loc12_)).setReferencePoint(param2,param3);
                  _loc7_.move(param2,param3);
                  Character(_loc7_).facing = CharThumb(param1).facing;
                  Character(_loc7_).fromTray = true;
                  if(CharThumb(param1).mThumbId)
                  {
                     Character(_loc7_).mThumbId = CharThumb(param1).mThumbId;
                  }
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is BackgroundThumb)
            {
               if(!(_loc13_ = param1 as BackgroundThumb).isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(_loc13_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  _loc13_.loadImageData();
               }
               else
               {
                  (_loc7_ = new Background()).x = AnimeConstants.SCREEN_X;
                  _loc7_.y = AnimeConstants.SCREEN_Y;
                  _loc7_.width = AnimeConstants.SCREEN_WIDTH;
                  _loc7_.height = AnimeConstants.SCREEN_HEIGHT;
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is BubbleThumb)
            {
               (_loc7_ = new BubbleAsset()).setReferencePoint(param2,param3);
               _loc7_.move(param2,param3);
               BubbleAsset(_loc7_).fromTray = true;
               Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               _loc14_ = param1 as BubbleThumb;
               _loc7_.type = _loc14_.type;
               if(_loc14_.isShowMsg)
               {
                  Console.getConsole().showBubbleMsgWindow(_loc14_,BubbleAsset(_loc7_));
               }
            }
            else if(param1 is SoundThumb)
            {
               _loc15_ = param1 as SoundThumb;
               _loc16_ = this;
               if(_loc15_.isLoading == false)
               {
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loading/" + param1.id,Console.getConsole().mainStage.stage);
                  Console.getConsole().addSoundThumbAtScene(_loc15_,_loc16_);
                  Console.getConsole().addThumbToMovieTheme(_loc15_);
               }
               else
               {
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is PropThumb)
            {
               if(!(_loc17_ = param1 as PropThumb).isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(param1.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  _loc17_.loadState();
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loading/" + param1.id,Console.getConsole().mainStage.stage);
               }
               else
               {
                  if(_loc17_.placeable != false)
                  {
                     if((_loc18_ = this.getAssetId(param1)) != null)
                     {
                        _loc19_ = _loc18_.assetId;
                     }
                     else
                     {
                        _loc19_ = "";
                     }
                     if(param1 is VideoPropThumb)
                     {
                        _loc7_ = new VideoProp();
                     }
                     else
                     {
                        _loc7_ = new Prop(_loc19_);
                     }
                     _loc7_.setReferencePoint(param2,param3);
                     _loc7_.move(param2,param3);
                     Prop(_loc7_).facing = PropThumb(param1).facing;
                     Prop(_loc7_).fromTray = true;
                  }
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is EffectThumb)
            {
               if((_loc20_ = param1 as EffectThumb).getType() == EffectThumb.TYPE_ANIME)
               {
                  _loc7_ = new AnimeEffectAsset();
               }
               else if(_loc20_.getType() == EffectThumb.TYPE_PROGRAM)
               {
                  if((_loc21_ = this.getAssetId(param1)) != null)
                  {
                     _loc22_ = _loc21_.assetId;
                  }
                  else
                  {
                     _loc22_ = "";
                  }
                  _loc7_ = new ProgramEffectAsset(_loc22_);
               }
               _loc7_.x = param2 - _loc7_.width / 2;
               _loc7_.y = param3 - _loc7_.height / 2;
               _loc7_.isResize = _loc20_.getResize() == "true" ? true : false;
               if(!_loc7_.isResize)
               {
                  _loc7_.x = AnimeConstants.SCREEN_WIDTH / 2 + AnimeConstants.SCREEN_X;
                  _loc7_.y = AnimeConstants.SCREEN_HEIGHT / 2 + AnimeConstants.SCREEN_Y;
               }
               EffectAsset(_loc7_).fromTray = true;
               EffectAsset(_loc7_).fromSpeech = param5;
               Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
            }
            if(_loc7_ != null)
            {
               _loc7_.scene = this;
               _loc7_.thumb = param1;
               if(param4 != "")
               {
                  _loc7_.defaultColorSetId = param4;
                  _loc7_.defaultColorSet = param1.getColorSetById(param4);
               }
               this.addAsset(_loc7_);
            }
         }
      }
      
      public function playScene() : void
      {
      }
      
      public function stopScene() : void
      {
      }
      
      public function showEffects(param1:Boolean = false) : void
      {
      }
      
      public function hideEffects(param1:Boolean = false, param2:Boolean = false) : void
      {
      }
      
      private function isProgramEffectTypeExist(param1:String) : Boolean
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getExactType() == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function isEffectTypeExist(param1:String) : Boolean
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getType() == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function isVideoTypeExist() : Boolean
      {
         var _loc1_:Prop = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.props.length)
         {
            _loc1_ = this.props.getValueByIndex(_loc2_) as Prop;
            if(_loc1_ is VideoProp)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function generateNewID(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(param1 == null)
         {
            _loc4_ = true;
         }
         else if(param1 == "")
         {
            _loc4_ = true;
         }
         else if(_existIDs.containsKey(param1))
         {
            _loc4_ = true;
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            _loc3_ = _existIDs.length;
            do
            {
               _loc2_ = "SCENE" + _loc3_;
               _loc3_++;
            }
            while(_existIDs.containsKey(_loc2_));
            
         }
         else
         {
            _loc2_ = param1;
         }
         _existIDs.push(_loc2_,_loc2_);
         return _loc2_;
      }
      
      public function replaceBubbleText(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._bubbles.length)
         {
            if(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.text.indexOf(param1) > -1)
            {
               if(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.backupText == "")
               {
                  BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.backupText = BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).text;
               }
               BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).text = UtilString.replace(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.text,param1,param2);
               Console.getConsole().mainStage.callLater(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.reUpdateTextHeight);
               Console.getConsole().mainStage.callLater(Console.getConsole().mainStage.callLater,[BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.reUpdateTextHeight]);
            }
            _loc3_++;
         }
      }
      
      public function unloadAllAssets(param1:Boolean = true) : void
      {
      }
      
      public function loadAllAssets() : void
      {
         var _loc1_:UtilLoadMgr = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Character = null;
         var _loc7_:String = null;
         var _loc8_:AnimeSound = null;
         var _loc9_:String = null;
         var _loc10_:BubbleAsset = null;
         var _loc11_:Prop = null;
         var _loc12_:EffectAsset = null;
         if(this.sceneXML != null)
         {
            this.deSerialize(this.sceneXML,true,true,false);
            this.sceneXML = null;
            return;
         }
         this.console.capScreenLock = true;
         _loc1_ = new UtilLoadMgr();
         _loc1_.setExtraData(new Date());
         _loc1_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadAllAssetsComplete);
         if(this._background != null)
         {
            _loc1_.addEventDispatcher(this._background.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            this._background.imageData = this._background.thumb.imageData;
         }
         _loc2_ = 0;
         while(_loc2_ < this._characters.length)
         {
            _loc6_ = Character(this._characters.getValueByIndex(_loc2_));
            _loc1_.addEventDispatcher(_loc6_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            _loc7_ = Console.getConsole().linkageController.getSpeechSoundIdByScene(this);
            if((_loc8_ = Console.getConsole().speechManager.getValueByKey(_loc7_)) is ProgressiveSound)
            {
               _loc9_ = Console.getConsole().linkageController.getTargetIdOfSpeech(_loc7_);
               _loc6_.demoSpeech = AssetLinkage.getCharIdFromLinkage(_loc9_) == _loc6_.id ? true : false;
            }
            _loc6_.imageData = _loc6_.action.imageData;
            if(_loc6_.prop)
            {
               if(_loc6_.prop.state != null)
               {
                  _loc6_.prop.imageData = _loc6_.prop.state.imageData;
               }
               else
               {
                  _loc6_.prop.imageData = _loc6_.prop.thumb.imageData;
               }
            }
            if(_loc6_.head)
            {
               if(_loc6_.head.state != null)
               {
                  _loc6_.head.imageData = _loc6_.head.state.imageData;
               }
               else
               {
                  _loc6_.head.imageData = _loc6_.head.thumb.imageData;
               }
            }
            if(_loc6_.wear)
            {
               if(_loc6_.wear.state != null)
               {
                  _loc6_.wear.imageData = _loc6_.wear.state.imageData;
               }
               else
               {
                  _loc6_.wear.imageData = _loc6_.wear.thumb.imageData;
               }
            }
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._bubbles.length)
         {
            _loc10_ = BubbleAsset(this._bubbles.getValueByIndex(_loc3_));
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < this._props.length)
         {
            _loc11_ = Prop(this._props.getValueByIndex(_loc4_));
            _loc1_.addEventDispatcher(_loc11_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            if(_loc11_.state != null)
            {
               _loc11_.imageData = _loc11_.state.imageData;
            }
            else
            {
               _loc11_.imageData = _loc11_.thumb.imageData;
            }
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this._effects.length)
         {
            if((_loc12_ = this._effects.getValueByIndex(_loc5_) as EffectAsset) is AnimeEffectAsset)
            {
               _loc1_.addEventDispatcher(_loc12_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
               AnimeEffectAsset(_loc12_).imageData = AnimeEffectAsset(_loc12_).thumb.imageData;
            }
            _loc5_++;
         }
         _loc1_.commit();
      }
      
      private function onLoadAllAssetsComplete(param1:Event) : void
      {
         this.console.capScreenLock = false;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ALL_ASSETS_COMPLETE,this));
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Date = _loc2_.getExtraData() as Date;
         var _loc4_:Date = new Date();
         this.refreshEffectTray(Console.getConsole().effectTray);
      }
      
      public function isCharacterTalkingWithLinkage(param1:Character) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         if(!(param1.isInDefaultTalkAction() || param1.isInDefaultTalkFacial()))
         {
            return false;
         }
         var _loc2_:String = Console.getConsole().linkageController.getSpeechIdOfAsset(param1);
         if(_loc2_ != "")
         {
            _loc3_ = "";
            if((_loc4_ = Console.getConsole().linkageController.isLinkageExist(_loc2_)) != null)
            {
               _loc8_ = _loc4_.concat();
               _loc8_.splice(_loc8_.indexOf(_loc2_),1);
               _loc3_ = _loc8_.join("");
            }
            _loc6_ = (_loc5_ = _loc3_.split(AssetLinkage.LINK))[0];
            _loc7_ = _loc5_[1];
            if(param1.scene.id == _loc6_ && param1.id == _loc7_)
            {
               return true;
            }
         }
         return false;
      }
   }
}

class AssetLocation
{
    
   
   private var _assetId:String;
   
   private var _sceneId:String;
   
   function AssetLocation(param1:String, param2:String)
   {
      super();
      this._assetId = param1;
      this._sceneId = param2;
   }
   
   public function get assetId() : String
   {
      return this._assetId;
   }
   
   public function get sceneId() : String
   {
      return this._sceneId;
   }
}
