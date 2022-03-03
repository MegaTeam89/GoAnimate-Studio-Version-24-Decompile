package anifire.playback
{
   import anifire.assets.AssetImageLibrary;
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.AssetTransitionNode;
   import anifire.assets.transition.NarrationNode;
   import anifire.cc.view.CcImageLibrary;
   import anifire.component.ProcessRegulator;
   import anifire.constant.AnimeConstants;
   import anifire.effect.EffectMgr;
   import anifire.event.LoadMgrEvent;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IPlayable;
   import anifire.interfaces.IPlayback;
   import anifire.interfaces.IRegulatedProcess;
   import anifire.iterators.TreeNode;
   import anifire.playback.scene.transitions.AnimateTransition;
   import anifire.playback.scene.transitions.FadeOutInTransition;
   import anifire.playback.scene.transitions.FlashEffTransition;
   import anifire.playback.scene.transitions.FlashTransition;
   import anifire.playerEffect.AnimeEffectAsset;
   import anifire.playerEffect.BumpyrideEffectAsset;
   import anifire.playerEffect.DRAlertEffectAsset;
   import anifire.playerEffect.EarthquakeEffectAsset;
   import anifire.playerEffect.EffectAsset;
   import anifire.playerEffect.FadingEffectAsset;
   import anifire.playerEffect.FireSpringEffectAsset;
   import anifire.playerEffect.FireworkEffectAsset;
   import anifire.playerEffect.GrayScaleEffectAsset;
   import anifire.playerEffect.HoveringEffectAsset;
   import anifire.playerEffect.ProgramEffectAsset;
   import anifire.playerEffect.SepiaEffectAsset;
   import anifire.playerEffect.UpsideDownEffectAsset;
   import anifire.playerEffect.ZoomEffectAsset;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilUnitConvert;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.system.System;
   
   public class AnimeScene extends EventDispatcher implements IPlayable, IRegulatedProcess
   {
      
      public static const STATE_ACTION:int = 2;
      
      public static const STATE_MOTION:int = 3;
      
      public static const STATE_NULL:int = 0;
      
      public static const STATE_BUFFER_INITIALIZING:int = 1;
      
      public static const XML_TAG:String = "scene";
       
      
      private var _visibleAssets:Array;
      
      private var _characters:UtilHashArray;
      
      private var _bubbles:UtilHashArray;
      
      private var _bgs:UtilHashArray;
      
      private var _segments:UtilHashArray;
      
      private var _props:UtilHashArray;
      
      private var _effects:UtilHashArray;
      
      private var _transitions:UtilHashArray;
      
      private var _effectsByType:UtilHashArray;
      
      private var _actionDuration:Number;
      
      private var _motionDuration:Number;
      
      private var _duration:Number;
      
      private var _parentAnime:Anime;
      
      private var _startFrame:Number;
      
      private var _endFrame:Number;
      
      private var _sceneContainer:DisplayObjectContainer;
      
      private var _sceneMasterContainer:DisplayObjectContainer;
      
      private var _nextScene:AnimeScene;
      
      private var _prevScene:AnimeScene;
      
      private var _state:int;
      
      private var _zOrder:int;
      
      private var _bufferProgress:Number = 0;
      
      private var _isRemoteDataIniting:Boolean = false;
      
      private var _movieId:String;
      
      private var _id:String;
      
      private var _isPreview:Boolean = false;
      
      private var _endSceneCapture:BitmapData;
      
      private var _sizingAssetRect:Rectangle;
      
      private var _narration:AnimeSound;
      
      private var _mver:Number = 0;
      
      private var _xml:XML;
      
      private var _assetRegulator:ProcessRegulator;
      
      private var _dataStock:PlayerDataStock;
      
      private var _readyToPlay:Boolean = false;
      
      private var extraData:Object;
      
      public function AnimeScene()
      {
         this._visibleAssets = new Array();
         this._characters = new UtilHashArray();
         this._bubbles = new UtilHashArray();
         this._bgs = new UtilHashArray();
         this._segments = new UtilHashArray();
         this._props = new UtilHashArray();
         this._effects = new UtilHashArray();
         this._transitions = new UtilHashArray();
         this._effectsByType = new UtilHashArray();
         this._assetRegulator = new ProcessRegulator();
         super();
      }
      
      public static function compareSceneXmlZorder(param1:XML, param2:XML) : int
      {
         var _loc3_:String = "index";
         var _loc4_:Number = Number(param1.attribute(_loc3_));
         var _loc5_:Number = Number(param2.attribute(_loc3_));
         if(_loc4_ < _loc5_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return 1;
         }
         return 0;
      }
      
      public function set narration(param1:AnimeSound) : void
      {
         this._narration = param1;
      }
      
      public function get sizingAssetRect() : Rectangle
      {
         return this._sizingAssetRect;
      }
      
      public function set sizingAssetRect(param1:Rectangle) : void
      {
         this._sizingAssetRect = param1;
      }
      
      public function get endSceneCapture() : BitmapData
      {
         return this._endSceneCapture;
      }
      
      public function set endSceneCapture(param1:BitmapData) : void
      {
         this._endSceneCapture = param1;
      }
      
      public function get movieId() : String
      {
         return this._movieId;
      }
      
      public function set movieId(param1:String) : void
      {
         this._movieId = param1;
      }
      
      public function get movieInfo() : Object
      {
         return this.parentAnime.movieInfo;
      }
      
      private function getMotionDuration() : Number
      {
         return this._motionDuration;
      }
      
      private function setMotionDuration(param1:Number) : void
      {
         this._motionDuration = 0;
      }
      
      public function get totalFrame() : Number
      {
         return this._actionDuration;
      }
      
      private function getActionDuration() : Number
      {
         return this._actionDuration;
      }
      
      private function setActionDuration(param1:Number) : void
      {
         this._actionDuration = param1;
      }
      
      public function getDuration() : Number
      {
         return this._duration;
      }
      
      private function setDuration(param1:Number) : void
      {
         this._duration = param1;
      }
      
      public function get durationInSecond() : Number
      {
         return UtilUnitConvert.frameToSec(this._duration);
      }
      
      private function get parentAnime() : Anime
      {
         return this._parentAnime;
      }
      
      private function set parentAnime(param1:Anime) : void
      {
         this._parentAnime = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function getStartFrame() : Number
      {
         return this._startFrame;
      }
      
      private function setStartFrame(param1:Number) : void
      {
         this._startFrame = param1;
      }
      
      public function getEndFrame() : Number
      {
         return this._endFrame;
      }
      
      private function setEndFrame(param1:Number) : void
      {
         this._endFrame = param1;
      }
      
      public function getLastActionFrame() : Number
      {
         return this.getStartFrame() + this.getActionDuration();
      }
      
      private function getZorder() : int
      {
         return this._zOrder;
      }
      
      private function setZorder(param1:int) : void
      {
         this._zOrder = param1;
      }
      
      private function refreshSceneContainer(... rest) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Asset = null;
         UtilPlain.removeAllSon(this.getSceneContainer());
         this.reArrangeVisibleAsset();
         _loc3_ = this.getNumVisibleAsset();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.getVisibleAssetByIndex(_loc2_);
            this.getSceneContainer().addChild(_loc4_.assetView);
            _loc2_++;
         }
      }
      
      public function getSceneContainer() : DisplayObjectContainer
      {
         return this._sceneContainer;
      }
      
      private function setSceneContainer(param1:DisplayObjectContainer) : void
      {
         this._sceneContainer = param1;
      }
      
      public function getSceneMasterContainer() : DisplayObjectContainer
      {
         return this._sceneMasterContainer;
      }
      
      private function setSceneMasterContainer(param1:DisplayObjectContainer) : void
      {
         this._sceneMasterContainer = param1;
      }
      
      private function addVisibleAsset(param1:Asset) : void
      {
         this._visibleAssets.push(param1);
      }
      
      private function getVisibleAssetByIndex(param1:int) : Asset
      {
         return this._visibleAssets[param1] as Asset;
      }
      
      private function reArrangeVisibleAsset() : void
      {
         Asset.reArrangeZorder(this._visibleAssets);
      }
      
      private function getNumVisibleAsset() : int
      {
         return this._visibleAssets.length;
      }
      
      private function getAssetById(param1:String) : Asset
      {
         var _loc2_:Asset = null;
         _loc2_ = this.getPropById(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         _loc2_ = this.getCharByID(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         _loc2_ = this.getBubByID(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         _loc2_ = this.getBgByID(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return _loc2_;
      }
      
      private function addChar(param1:Character) : void
      {
         this._characters.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      public function getCharByIndex(param1:int) : Character
      {
         return this._characters.getValueByIndex(param1);
      }
      
      public function getCharByID(param1:String) : Character
      {
         return this._characters.getValueByKey(param1);
      }
      
      public function getNumChar() : int
      {
         return this._characters.length;
      }
      
      private function isCharExist(param1:String) : Boolean
      {
         return this._characters.containsKey(param1);
      }
      
      private function addBubble(param1:BubbleAsset) : void
      {
         this._bubbles.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      private function getBubByIndex(param1:int) : BubbleAsset
      {
         return this._bubbles.getValueByIndex(param1);
      }
      
      private function getBubByID(param1:String) : BubbleAsset
      {
         return this._bubbles.getValueByKey(param1);
      }
      
      public function getNumBub() : int
      {
         return this._bubbles.length;
      }
      
      private function isBubExist(param1:String) : Boolean
      {
         return this._bubbles.containsKey(param1);
      }
      
      public function getBgByIndex(param1:int) : Background
      {
         return this._bgs.getValueByIndex(param1);
      }
      
      public function getBgByID(param1:String) : Background
      {
         return this._bgs.getValueByKey(param1);
      }
      
      private function addBg(param1:Background) : void
      {
         this._bgs.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      private function isBgExist(param1:String) : Boolean
      {
         return this._bgs.containsKey(param1);
      }
      
      public function getNumBg() : int
      {
         return this._bgs.length;
      }
      
      public function addTransition(param1:GoTransition) : void
      {
         this._transitions.push(param1.id,param1);
      }
      
      public function getTransitionNum() : Number
      {
         return this._transitions.length;
      }
      
      public function hasTransition() : Boolean
      {
         return this._transitions.length > 0;
      }
      
      public function getTransitionFrameNum() : Number
      {
         if(this.hasTransition())
         {
            return GoTransition(this._transitions.getValueByIndex(0)).dur;
         }
         return 0;
      }
      
      public function getSegmentByIndex(param1:int) : Segment
      {
         return this._segments.getValueByIndex(param1);
      }
      
      public function getSegmentByID(param1:String) : Segment
      {
         return this._segments.getValueByKey(param1);
      }
      
      private function addSegment(param1:Segment) : void
      {
         this._segments.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      private function isSegmentExist(param1:String) : Boolean
      {
         return this._segments.containsKey(param1);
      }
      
      public function getNumSegment() : int
      {
         return this._segments.length;
      }
      
      private function addProp(param1:Prop) : void
      {
         this._props.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      public function getPropByIndex(param1:int) : Prop
      {
         return this._props.getValueByIndex(param1);
      }
      
      public function getPropById(param1:String) : Prop
      {
         return this._props.getValueByKey(param1);
      }
      
      private function isPropExist(param1:String) : Boolean
      {
         return this._props.containsKey(param1);
      }
      
      public function getNumProp() : int
      {
         return this._props.length;
      }
      
      private function addEffect(param1:EffectAsset) : void
      {
         var _loc3_:UtilHashArray = null;
         this._effects.push(param1.id,param1);
         if(!(param1 is ProgramEffectAsset))
         {
            this.addVisibleAsset(param1);
         }
         var _loc2_:String = param1.getType();
         if(!this._effectsByType.containsKey(_loc2_))
         {
            this._effectsByType.push(_loc2_,new UtilHashArray());
         }
         _loc3_ = this._effectsByType.getValueByKey(_loc2_) as UtilHashArray;
         _loc3_.push(param1.id,param1);
      }
      
      public function getEffectById(param1:String) : EffectAsset
      {
         return this._effects.getValueByKey(param1);
      }
      
      public function getEffectByIndex(param1:int) : EffectAsset
      {
         return this._effects.getValueByIndex(param1);
      }
      
      private function getEffectsByType(param1:String) : UtilHashArray
      {
         return this._effectsByType.getValueByKey(param1);
      }
      
      private function isEffectExist(param1:String) : Boolean
      {
         return this._effects.containsKey(param1);
      }
      
      public function getNumEffect() : int
      {
         return this._effects.length;
      }
      
      public function getBufferProgress() : Number
      {
         return this._bufferProgress;
      }
      
      private function setBufferProgress(param1:Number) : void
      {
         this._bufferProgress = param1;
      }
      
      private function getState() : int
      {
         return this._state;
      }
      
      public function setState(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.getNumChar();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getCharByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumBg();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getBgByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumBub();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getBubByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumProp();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getPropByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumEffect();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getEffectByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumSegment();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getSegmentByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this._transitions.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            GoTransition(this._transitions.getValueByIndex(_loc3_)).prevScene = this.prevScene;
            GoTransition(this._transitions.getValueByIndex(_loc3_)).propagateSceneState(param1);
            _loc3_++;
         }
         this._state = param1;
      }
      
      public function init(param1:XML, param2:Anime, param3:UtilHashArray, param4:PlayerDataStock, param5:Number, param6:String, param7:Boolean) : void
      {
         var _loc8_:int = 0;
         var _loc9_:Background = null;
         var _loc10_:XML = null;
         var _loc11_:Segment = null;
         var _loc12_:XML = null;
         var _loc13_:Character = null;
         var _loc14_:XML = null;
         var _loc15_:BubbleAsset = null;
         var _loc16_:XML = null;
         var _loc17_:Prop = null;
         var _loc18_:XML = null;
         var _loc19_:XML = null;
         var _loc20_:Sprite = null;
         var _loc21_:String = null;
         var _loc22_:EffectAsset = null;
         var _loc23_:Boolean = false;
         var _loc24_:ZoomEffectAsset = null;
         var _loc25_:EarthquakeEffectAsset = null;
         var _loc26_:HoveringEffectAsset = null;
         var _loc27_:BumpyrideEffectAsset = null;
         var _loc28_:UpsideDownEffectAsset = null;
         var _loc29_:Sprite = null;
         var _loc30_:FireworkEffectAsset = null;
         var _loc31_:FireSpringEffectAsset = null;
         var _loc32_:AnimeEffectAsset = null;
         var _loc33_:GrayScaleEffectAsset = null;
         var _loc34_:DRAlertEffectAsset = null;
         var _loc35_:SepiaEffectAsset = null;
         var _loc36_:FadingEffectAsset = null;
         var _loc37_:GoTransition = null;
         var _loc38_:XML = null;
         var _loc39_:String = null;
         var _loc40_:Sprite = null;
         this._dataStock = param4;
         this._mver = param5;
         this.id = param1.attribute("id").toString();
         this.setZorder(param1.attribute("index"));
         this.setActionDuration(param1.attribute("adelay"));
         this.setMotionDuration(param1.attribute("mdelay"));
         this.parentAnime = param2;
         this.setSceneMasterContainer(new Sprite());
         this.setSceneContainer(new Sprite());
         this.getSceneMasterContainer().addChild(this.getSceneContainer());
         this.movieId = param6;
         this._isPreview = param7;
         for each(_loc10_ in param1.child(Background.XML_TAG))
         {
            if((_loc9_ = new Background()).init(_loc10_,this,param4))
            {
               this.addBg(_loc9_);
            }
         }
         for each(_loc12_ in param1.child(Segment.XML_TAG))
         {
            if((_loc11_ = new Segment()).init(_loc12_,this,param4))
            {
               this.addSegment(_loc11_);
            }
         }
         for each(_loc14_ in param1.child(Character.XML_TAG))
         {
            if((_loc13_ = new Character()).init(_loc14_,this,param3,param4))
            {
               this.addChar(_loc13_);
            }
         }
         for each(_loc16_ in param1.child(BubbleAsset.XML_TAG))
         {
            if((_loc15_ = new BubbleAsset()).init(_loc16_,this,param5,param7))
            {
               this.addBubble(_loc15_);
            }
         }
         for each(_loc18_ in param1.child(Prop.XML_TAG))
         {
            if((_loc17_ = new Prop()).init(_loc18_,this,param4))
            {
               this.addProp(_loc17_);
            }
         }
         for each(_loc19_ in param1.child(EffectAsset.XML_TAG))
         {
            _loc21_ = EffectAsset.getEffectType(_loc19_);
            if(param5 <= 2)
            {
               continue;
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
               case EffectMgr.TYPE_EARTHQUAKE:
               case EffectMgr.TYPE_HOVERING:
               case EffectMgr.TYPE_BUMPYRIDE:
               case EffectMgr.TYPE_UPSIDEDOWN:
                  _loc20_ = new Sprite();
                  _loc29_ = new Sprite();
                  UtilPlain.switchParent(this.getSceneMasterContainer(),_loc20_);
                  _loc29_.addChild(_loc20_);
                  this.getSceneMasterContainer().addChild(_loc29_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
                  (_loc22_ = new ZoomEffectAsset()).init(_loc19_,this,_loc20_,param5);
                  this.sizingAssetRect = _loc24_.targetRect;
                  break;
               case EffectMgr.TYPE_EARTHQUAKE:
                  (_loc22_ = new EarthquakeEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_HOVERING:
                  (_loc22_ = new HoveringEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_BUMPYRIDE:
                  (_loc22_ = new BumpyrideEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_UPSIDEDOWN:
                  (_loc22_ = new UpsideDownEffectAsset()).init(_loc19_,this,_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
               case EffectMgr.TYPE_EARTHQUAKE:
               case EffectMgr.TYPE_HOVERING:
               case EffectMgr.TYPE_BUMPYRIDE:
               case EffectMgr.TYPE_UPSIDEDOWN:
                  this.addEffect(_loc22_);
                  break;
            }
         }
         for each(_loc19_ in param1.child(EffectAsset.XML_TAG))
         {
            _loc21_ = EffectAsset.getEffectType(_loc19_);
            _loc23_ = false;
            _loc20_ = new Sprite();
            switch(_loc21_)
            {
               case EffectMgr.TYPE_FIREWORK:
               case EffectMgr.TYPE_FIRESPRING:
               case EffectMgr.TYPE_ANIME:
                  _loc29_ = new Sprite();
                  UtilPlain.switchParent(this.getSceneMasterContainer(),_loc20_);
                  _loc29_.addChild(_loc20_);
                  this.getSceneMasterContainer().addChild(_loc29_);
            }
            if(_loc21_ == EffectMgr.TYPE_FIREWORK)
            {
               (_loc22_ = new FireworkEffectAsset()).init(_loc19_,this,_loc20_);
               _loc23_ = true;
            }
            else if(_loc21_ == EffectMgr.TYPE_FIRESPRING)
            {
               (_loc22_ = new FireSpringEffectAsset()).init(_loc19_,this,_loc20_);
               _loc23_ = true;
            }
            else if(_loc21_ == EffectMgr.TYPE_ANIME)
            {
               _loc23_ = (_loc22_ = new AnimeEffectAsset()).init(_loc19_,this,param4,_loc20_);
            }
            if(_loc23_)
            {
               this.addEffect(_loc22_);
            }
         }
         for each(_loc19_ in param1.child(EffectAsset.XML_TAG))
         {
            _loc21_ = EffectAsset.getEffectType(_loc19_);
            if(param5 > 2)
            {
               continue;
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
               case EffectMgr.TYPE_EARTHQUAKE:
               case EffectMgr.TYPE_HOVERING:
               case EffectMgr.TYPE_BUMPYRIDE:
               case EffectMgr.TYPE_UPSIDEDOWN:
                  _loc20_ = new Sprite();
                  _loc29_ = new Sprite();
                  UtilPlain.switchParent(this.getSceneMasterContainer(),_loc20_);
                  _loc29_.addChild(_loc20_);
                  this.getSceneMasterContainer().addChild(_loc29_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
                  (_loc22_ = new ZoomEffectAsset()).init(_loc19_,this,_loc20_,param5);
                  break;
               case EffectMgr.TYPE_EARTHQUAKE:
                  (_loc22_ = new EarthquakeEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_HOVERING:
                  (_loc22_ = new HoveringEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_BUMPYRIDE:
                  (_loc22_ = new BumpyrideEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_UPSIDEDOWN:
                  (_loc22_ = new UpsideDownEffectAsset()).init(_loc19_,this,_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
               case EffectMgr.TYPE_EARTHQUAKE:
               case EffectMgr.TYPE_HOVERING:
               case EffectMgr.TYPE_BUMPYRIDE:
               case EffectMgr.TYPE_UPSIDEDOWN:
                  this.addEffect(_loc22_);
                  break;
            }
         }
         for each(_loc19_ in param1.child(EffectAsset.XML_TAG))
         {
            _loc21_ = EffectAsset.getEffectType(_loc19_);
            switch(_loc21_)
            {
               case EffectMgr.TYPE_GRAYSCALE:
               case EffectMgr.TYPE_DRALERT:
               case EffectMgr.TYPE_SEPIA:
               case EffectMgr.TYPE_FADING:
                  _loc20_ = new Sprite();
                  _loc29_ = new Sprite();
                  UtilPlain.switchParent(this.getSceneMasterContainer(),_loc20_);
                  _loc29_.addChild(_loc20_);
                  this.getSceneMasterContainer().addChild(_loc29_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_GRAYSCALE:
                  (_loc22_ = new GrayScaleEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_DRALERT:
                  (_loc22_ = new DRAlertEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_SEPIA:
                  (_loc22_ = new SepiaEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_FADING:
                  (_loc22_ = new FadingEffectAsset()).init(_loc19_,this,_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_GRAYSCALE:
               case EffectMgr.TYPE_DRALERT:
               case EffectMgr.TYPE_SEPIA:
               case EffectMgr.TYPE_FADING:
                  this.addEffect(_loc22_);
                  break;
            }
         }
         if(this.getZorder() != 0)
         {
            for each(_loc38_ in param1.child(GoTransition.XML_TAG))
            {
               _loc39_ = String(_loc38_.fx.@type).split(".")[0];
               switch(_loc39_)
               {
                  case "anifire":
                     _loc37_ = new FadeOutInTransition();
                     break;
                  case "animated":
                     _loc37_ = new AnimateTransition();
                     break;
                  case "fl":
                     _loc37_ = new FlashTransition();
                     break;
                  case "flashEff":
                     _loc37_ = new FlashEffTransition();
               }
               if(_loc29_)
               {
                  _loc40_ = _loc29_;
               }
               else
               {
                  _loc40_ = this.getSceneContainer() as Sprite;
               }
               if(_loc37_.init(_loc38_,this,_loc40_))
               {
                  _loc40_.x = _loc37_.initPos.x;
                  _loc40_.y = _loc37_.initPos.y;
                  this.addTransition(_loc37_);
               }
            }
         }
         this._xml = param1;
         this.setDuration(this.getActionDuration() + this.getMotionDuration());
         this.setState(AnimeScene.STATE_NULL);
      }
      
      private function initAssetTransitions(param1:XML) : void
      {
         var _loc2_:TreeNode = null;
         var _loc3_:NarrationNode = null;
         var _loc4_:IIterator = null;
         var _loc5_:AssetTransitionNode = null;
         var _loc6_:Asset = null;
         if(this._narration)
         {
            _loc3_ = new NarrationNode();
            _loc3_.init(0,this._narration.getEndFrame() - this._narration.getStartFrame() + 1);
         }
         if(param1.hasOwnProperty(AssetTransitionConstants.TAG_NAME_TRANSITION_LIST))
         {
            _loc2_ = AssetTransitionNode.getTreeFromXml(param1.child(AssetTransitionConstants.TAG_NAME_TRANSITION_LIST)[0],_loc3_);
            _loc4_ = _loc2_.iterator();
            while(_loc4_.hasNext)
            {
               if(_loc5_ = _loc4_.next as AssetTransitionNode)
               {
                  if(_loc6_ = this.getAssetById(_loc5_.assetId))
                  {
                     _loc6_.addTransition(_loc5_);
                  }
               }
            }
         }
      }
      
      public function initRemoteData(param1:PlayerDataStock) : void
      {
         var _loc2_:UtilLoadMgr = null;
         var _loc3_:int = 0;
         var _loc4_:EffectAsset = null;
         if(this.getBufferProgress() >= 100)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
            return;
         }
         if(this.getState() != AnimeScene.STATE_BUFFER_INITIALIZING)
         {
            _loc2_ = new UtilLoadMgr();
            _loc2_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onInitRemoteDataCompleted,false,0,true);
            _loc3_ = 0;
            _loc3_ = 0;
            while(_loc3_ < this.getNumEffect())
            {
               _loc4_ = this.getEffectByIndex(_loc3_);
               _loc2_.addEventDispatcher(_loc4_.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc4_.initRemoteData(param1);
               _loc3_++;
            }
            this.setState(AnimeScene.STATE_BUFFER_INITIALIZING);
            _loc2_.commit();
         }
      }
      
      public function startProcess(param1:Boolean = false, param2:Number = 0) : void
      {
         this.buildScene(this._dataStock);
      }
      
      public function buildScene(param1:PlayerDataStock) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Background = null;
         var _loc4_:Segment = null;
         var _loc5_:Character = null;
         var _loc6_:Prop = null;
         var _loc7_:BubbleAsset = null;
         if(this._readyToPlay)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
            return;
         }
         if(this.getState() != AnimeScene.STATE_BUFFER_INITIALIZING)
         {
            this.setState(AnimeScene.STATE_BUFFER_INITIALIZING);
            this._assetRegulator.reset();
            this._assetRegulator.addEventListener(Event.COMPLETE,this.onInitCcRemoteDataCompleted);
            _loc2_ = 0;
            _loc2_ = 0;
            while(_loc2_ < this.getNumBg())
            {
               _loc3_ = this.getBgByIndex(_loc2_);
               this._assetRegulator.addProcess(_loc3_,PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.getNumSegment())
            {
               _loc4_ = this.getSegmentByIndex(_loc2_);
               this._assetRegulator.addProcess(_loc4_,PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.getNumChar())
            {
               _loc5_ = this.getCharByIndex(_loc2_);
               this._assetRegulator.addProcess(_loc5_,PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.getNumProp())
            {
               _loc6_ = this.getPropByIndex(_loc2_);
               this._assetRegulator.addProcess(_loc6_,PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.getNumBub())
            {
               _loc7_ = this.getBubByIndex(_loc2_);
               this._assetRegulator.addProcess(_loc7_,PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc2_++;
            }
            this._assetRegulator.startProcess(!SceneBufferManager.highSpeedMode);
         }
      }
      
      public function get readyToPlay() : Boolean
      {
         return this._readyToPlay;
      }
      
      private function onInitRemoteDataCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitRemoteDataCompleted);
         this.setBufferProgress(100);
         this.refreshSceneContainer();
         this.setState(AnimeScene.STATE_NULL);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      private function onInitCcRemoteDataCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitCcRemoteDataCompleted);
         this._readyToPlay = true;
         this.setBufferProgress(100);
         this.setState(AnimeScene.STATE_NULL);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      public function prepareImage() : void
      {
         var i:Number = NaN;
         var prop:Prop = null;
         var bg:Background = null;
         var char:Character = null;
         var effect:EffectAsset = null;
         try
         {
            AssetImageLibrary.instance.updateTimeStamp();
            CcImageLibrary.library.updateTimeStamp();
            i = 0;
            i = 0;
            while(i < this.getNumProp())
            {
               prop = this.getPropByIndex(i);
               if(!prop.isFirstProp)
               {
                  prop.prepareImage();
               }
               i++;
            }
            i = 0;
            while(i < this.getNumProp())
            {
               prop = this.getPropByIndex(i);
               if(prop.isFirstProp)
               {
                  prop.prepareImage();
               }
               i++;
            }
            i = 0;
            while(i < this.getNumBg())
            {
               bg = this.getBgByIndex(i);
               if(!bg.isFirstBg)
               {
                  bg.prepareImage();
               }
               i++;
            }
            i = 0;
            while(i < this.getNumBg())
            {
               bg = this.getBgByIndex(i);
               if(bg.isFirstBg)
               {
                  bg.prepareImage();
               }
               i++;
            }
            i = 0;
            while(i < this.getNumChar())
            {
               char = this.getCharByIndex(i);
               if(char.charInPrevScene && !char.action.isFirstBehavior)
               {
                  char.prepareImage();
               }
               i++;
            }
            i = 0;
            while(i < this.getNumChar())
            {
               char = this.getCharByIndex(i);
               if(char.charInPrevScene && char.action.isFirstBehavior)
               {
                  char.prepareImage();
               }
               i++;
            }
            i = 0;
            while(i < this.getNumChar())
            {
               char = this.getCharByIndex(i);
               if(!char.charInPrevScene)
               {
                  char.prepareImage();
               }
               i++;
            }
            i = 0;
            while(i < this.getNumEffect())
            {
               effect = this.getEffectByIndex(i);
               effect.prepareImage();
               i++;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function get nextScene() : AnimeScene
      {
         return this._nextScene;
      }
      
      public function get prevScene() : AnimeScene
      {
         return this._prevScene;
      }
      
      public function initDependency(param1:AnimeScene, param2:AnimeScene, param3:Number, param4:DownloadManager, param5:UtilHashArray) : void
      {
         var _loc6_:int = 0;
         var _loc10_:UtilHashArray = null;
         var _loc14_:Character = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:BubbleAsset = null;
         var _loc18_:Segment = null;
         var _loc19_:Background = null;
         var _loc20_:Background = null;
         var _loc21_:Number = NaN;
         var _loc22_:GoTransition = null;
         var _loc23_:Prop = null;
         var _loc24_:EffectAsset = null;
         var _loc25_:ZoomEffectAsset = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:ZoomEffectAsset = null;
         var _loc30_:UtilHashArray = null;
         var _loc31_:EarthquakeEffectAsset = null;
         var _loc32_:BumpyrideEffectAsset = null;
         var _loc33_:HoveringEffectAsset = null;
         var _loc34_:DRAlertEffectAsset = null;
         var _loc35_:GrayScaleEffectAsset = null;
         var _loc36_:SepiaEffectAsset = null;
         var _loc37_:FadingEffectAsset = null;
         var _loc38_:UpsideDownEffectAsset = null;
         var _loc39_:FireworkEffectAsset = null;
         var _loc40_:FireSpringEffectAsset = null;
         var _loc41_:AnimeEffectAsset = null;
         this._prevScene = param2;
         this._nextScene = param1;
         this.setStartFrame(param3);
         this.setEndFrame(this.getStartFrame() + this.getDuration());
         Character.connectCharacters(this._characters,param1 != null ? param1._characters : null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumChar())
         {
            _loc14_ = this.getCharByIndex(_loc6_);
            _loc15_ = param2 != null ? Number(param2.getActionDuration()) : Number(0);
            _loc16_ = param2 != null ? Number(param2.getMotionDuration()) : Number(0);
            _loc14_.initDependency(this.getActionDuration(),this.getMotionDuration(),_loc15_,_loc16_,param5);
            _loc6_++;
         }
         BubbleAsset.connectBubblesBetweenScenes(this._bubbles,param1 != null ? param1._bubbles : null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumBub())
         {
            (_loc17_ = this.getBubByIndex(_loc6_)).initDependency();
            _loc6_++;
         }
         Segment.connectSegment(this._segments,param1 != null ? param1._segments : null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumSegment())
         {
            (_loc18_ = this.getSegmentByIndex(_loc6_)).initDependency();
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < this.getNumBg())
         {
            _loc19_ = this.getBgByIndex(_loc6_);
            _loc21_ = 0;
            if(this._prevScene != null)
            {
               _loc20_ = !!this._prevScene.isBgExist(_loc19_.id) ? this._prevScene.getBgByID(_loc19_.id) : null;
               _loc21_ = this._prevScene.getDuration();
            }
            else
            {
               _loc20_ = null;
            }
            _loc19_.initDependency(_loc20_,_loc21_);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < this._transitions.length)
         {
            (_loc22_ = this._transitions.getValueByIndex(_loc6_)).initDependency(param2,this);
            _loc6_++;
         }
         Prop.connectPropsBetweenScenes(this._props,param1 != null ? param1._props : null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumProp())
         {
            (_loc23_ = this.getPropByIndex(_loc6_) as Prop).initDependency(param4,param5);
            _loc6_++;
         }
         var _loc7_:ZoomEffectAsset = null;
         var _loc8_:ZoomEffectAsset = null;
         var _loc9_:ZoomEffectAsset = null;
         _loc10_ = this.getEffectsByType(EffectMgr.TYPE_ZOOM);
         var _loc11_:int = 0;
         if(_loc10_ != null && _loc10_.length > 0)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc10_.length)
            {
               if(((_loc9_ = _loc10_.getValueByIndex(_loc11_) as ZoomEffectAsset).id as String).indexOf("dummy") == -1)
               {
                  _loc7_ = _loc9_;
               }
               _loc11_++;
            }
         }
         if(param2 != null)
         {
            if((_loc10_ = param2.getEffectsByType(EffectMgr.TYPE_ZOOM)) != null && _loc10_.length > 0)
            {
               _loc11_ = 0;
               while(_loc11_ < _loc10_.length)
               {
                  if(((_loc9_ = _loc10_.getValueByIndex(_loc11_) as ZoomEffectAsset).id as String).indexOf("dummy") == -1)
                  {
                     _loc8_ = _loc9_;
                  }
                  _loc11_++;
               }
            }
         }
         var _loc12_:Sprite = new Sprite();
         var _loc13_:ZoomEffectAsset = new ZoomEffectAsset();
         if(ZoomEffectAsset.isDummyZoomNeededForCurrentZoom(_loc7_,this._mver))
         {
            (_loc13_ = new ZoomEffectAsset()).initDummyZoom(this,_loc7_.effectee,null,_loc7_,_loc13_.MODE_EXT);
            this.addEffect(_loc13_);
         }
         AnimeEffectAsset.connectEffectsBetweenScenes(this.getEffectsByType(EffectMgr.TYPE_ANIME),param1 != null ? param1.getEffectsByType(EffectMgr.TYPE_ANIME) : null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumEffect())
         {
            if((_loc24_ = this.getEffectByIndex(_loc6_)).getType() == EffectMgr.TYPE_ZOOM)
            {
               if((_loc25_ = _loc24_ as ZoomEffectAsset).mode == _loc25_.MODE_NOR)
               {
                  if(_loc25_.sttime == 0 && _loc25_.edtime == 0)
                  {
                     _loc26_ = this.getStartFrame();
                     _loc28_ = UtilUnitConvert.secToFrame(AnimeConstants.ZOOM_DURATION);
                     if(this.getDuration() < _loc28_)
                     {
                        _loc28_ = this.getDuration() - 1;
                     }
                     _loc27_ = _loc26_ + _loc28_;
                     if(_loc25_.pan)
                     {
                        _loc28_ = this.getDuration() - 1;
                        _loc27_ = _loc26_ + _loc28_;
                     }
                  }
                  else
                  {
                     _loc26_ = _loc25_.sttime + this.getStartFrame() - 1;
                     _loc28_ = UtilUnitConvert.secToFrame(_loc25_.stzoom);
                     if(_loc26_ + _loc28_ > this.getDuration() + this.getStartFrame())
                     {
                        _loc28_ = this.getDuration() + this.getStartFrame() - _loc26_ - 1;
                     }
                     if(_loc25_.pan && this._mver <= 3)
                     {
                        _loc28_ = _loc25_.edtime - _loc25_.sttime - 1;
                     }
                     _loc27_ = _loc26_ + _loc28_;
                  }
               }
               else if(_loc25_.mode == _loc25_.MODE_EXT)
               {
                  if(_loc25_.refZoom.sttime == 0 && _loc25_.refZoom.edtime == 0)
                  {
                     _loc28_ = UtilUnitConvert.secToFrame(AnimeConstants.ZOOM_DURATION);
                     _loc26_ = this.getDuration() + this.getStartFrame() - _loc28_;
                  }
                  else
                  {
                     _loc26_ = _loc25_.refZoom.edtime + this.getStartFrame();
                     _loc28_ = UtilUnitConvert.secToFrame(_loc25_.edzoom);
                     if(_loc26_ + _loc28_ > this.getDuration() + this.getStartFrame())
                     {
                        _loc28_ = this.getDuration() + this.getStartFrame() - _loc26_;
                     }
                  }
                  _loc27_ = _loc26_ + _loc28_;
               }
               else if(_loc25_.mode == _loc25_.MODE_PRE)
               {
               }
               if(param2 != null)
               {
                  if((_loc30_ = param2.getEffectsByType(_loc25_.getType())) != null && _loc30_.length > 0)
                  {
                     _loc11_ = 0;
                     while(_loc11_ < _loc30_.length)
                     {
                        if(((_loc9_ = _loc30_.getValueByIndex(_loc11_) as ZoomEffectAsset).id as String).indexOf("dummy") == -1)
                        {
                           _loc29_ = _loc9_;
                        }
                        _loc11_++;
                     }
                  }
               }
               _loc25_.initDependency(_loc26_,_loc27_,_loc29_);
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_EARTHQUAKE)
            {
               (_loc31_ = _loc24_ as EarthquakeEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_BUMPYRIDE)
            {
               (_loc32_ = _loc24_ as BumpyrideEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_HOVERING)
            {
               (_loc33_ = _loc24_ as HoveringEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_DRALERT)
            {
               (_loc34_ = _loc24_ as DRAlertEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_GRAYSCALE)
            {
               (_loc35_ = _loc24_ as GrayScaleEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_SEPIA)
            {
               (_loc36_ = _loc24_ as SepiaEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_FADING)
            {
               (_loc37_ = _loc24_ as FadingEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_UPSIDEDOWN)
            {
               (_loc38_ = _loc24_ as UpsideDownEffectAsset).initDependency(this.getStartFrame(),this.getEndFrame());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_FIREWORK)
            {
               (_loc39_ = _loc24_ as FireworkEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_FIRESPRING)
            {
               (_loc40_ = _loc24_ as FireSpringEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc24_.getType() == EffectMgr.TYPE_ANIME)
            {
               (_loc41_ = _loc24_ as AnimeEffectAsset).initDependency(this.getStartFrame(),this.getEndFrame());
            }
            _loc6_++;
         }
         this.reArrangeVisibleAsset();
         this.initAssetTransitions(this._xml);
      }
      
      public function setVolume(param1:Number) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.getNumProp())
         {
            this.getPropByIndex(_loc2_).setVolume(param1);
            _loc2_++;
         }
      }
      
      public function restoreEffects() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = this._effects.getArray();
         _loc2_ = this.getNumEffect();
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_[_loc1_] is ZoomEffectAsset)
            {
               ZoomEffectAsset(_loc3_[_loc1_]).restore();
            }
            else if(_loc3_[_loc1_] is GrayScaleEffectAsset)
            {
               GrayScaleEffectAsset(_loc3_[_loc1_]).restore();
            }
            _loc1_++;
         }
         System.gc();
      }
      
      public function play(param1:Number, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc10_:IPlayback = null;
         var _loc4_:Array = this._characters.getArray();
         var _loc5_:Array = this._bubbles.getArray();
         var _loc6_:Array = this._bgs.getArray();
         var _loc7_:Array = this._props.getArray();
         var _loc8_:Array = this._effects.getArray();
         var _loc9_:Number = this.movieToSceneFrame(param1);
         if(param1 < this.getLastActionFrame() || this._nextScene == null)
         {
            if(this.getState() != AnimeScene.STATE_ACTION)
            {
               this.setState(AnimeScene.STATE_ACTION);
            }
            if(!param2)
            {
               _loc3_ = 0;
               while(_loc3_ < this.getNumBub())
               {
                  if(_loc10_ = _loc5_[_loc3_] as IPlayback)
                  {
                     _loc10_.playFrame(_loc9_,this._actionDuration);
                  }
                  _loc3_++;
               }
            }
            _loc3_ = 0;
            while(_loc3_ < this.getNumChar())
            {
               if(_loc10_ = _loc4_[_loc3_] as IPlayback)
               {
                  _loc10_.playFrame(_loc9_,this._actionDuration);
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.getNumProp())
            {
               if(_loc10_ = _loc7_[_loc3_] as IPlayback)
               {
                  _loc10_.playFrame(_loc9_,this._actionDuration);
               }
               _loc3_++;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < this.getNumEffect())
         {
            _loc8_[_loc3_].play(param1);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._transitions.length)
         {
            GoTransition(this._transitions.getValueByIndex(_loc3_)).play(this._startFrame,this._endFrame,param1);
            _loc3_++;
         }
      }
      
      public function movieToSceneFrame(param1:Number) : Number
      {
         return param1 - this.getStartFrame() + 1;
      }
      
      public function goToAndPause(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         var _loc3_:Number = this.movieToSceneFrame(param1);
         this.play(param1);
         if(this.getState() == AnimeScene.STATE_ACTION)
         {
            _loc4_ = 1;
         }
         if(this.getState() == AnimeScene.STATE_MOTION)
         {
            _loc4_ = this.getActionDuration();
         }
         else
         {
            _loc4_ = 1;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumChar())
         {
            this.getCharByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumBg())
         {
            this.getBgByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumBub())
         {
            this.getBubByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumProp())
         {
            this.getPropByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._transitions.length)
         {
            if(this._transitions.getValueByIndex(_loc2_) is FlashTransition)
            {
               FlashTransition(this._transitions.getValueByIndex(_loc2_)).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            }
            else
            {
               GoTransition(this._transitions.getValueByIndex(_loc2_)).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            }
            _loc2_++;
         }
      }
      
      public function goToAndPauseReset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = this.getStartFrame();
         this.play(_loc2_,true);
         _loc1_ = 0;
         while(_loc1_ < this.getNumChar())
         {
            this.getCharByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBg())
         {
            this.getBgByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBub())
         {
            this.getBubByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumProp())
         {
            this.getPropByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         this.setState(STATE_NULL);
      }
      
      public function pause() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.getNumChar())
         {
            this.getCharByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBg())
         {
            this.getBgByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBub())
         {
            this.getBubByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumProp())
         {
            this.getPropByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._transitions.length)
         {
            if(this._transitions.getValueByIndex(_loc1_) is FlashTransition)
            {
               FlashTransition(this._transitions.getValueByIndex(_loc1_)).pause();
            }
            else
            {
               GoTransition(this._transitions.getValueByIndex(_loc1_)).pause();
            }
            _loc1_++;
         }
      }
      
      public function resume() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.getNumChar())
         {
            this.getCharByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBg())
         {
            this.getBgByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBub())
         {
            this.getBubByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumProp())
         {
            this.getPropByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._transitions.length)
         {
            GoTransition(this._transitions.getValueByIndex(_loc1_)).resume();
            _loc1_++;
         }
      }
      
      public function startPlay() : void
      {
         this.setState(AnimeScene.STATE_NULL);
         PlayerConstant.goToAndStopFamilyAt1(this.getSceneContainer());
         PlayerConstant.playFamily(this.getSceneContainer());
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         this.setState(AnimeScene.STATE_NULL);
         _loc2_ = 0;
         while(_loc2_ < this.getNumChar())
         {
            this.getCharByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumBg())
         {
            this.getBgByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumBub())
         {
            this.getBubByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumProp())
         {
            this.getPropByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc2_).destroy();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._transitions.length)
         {
            GoTransition(this._transitions.getValueByIndex(_loc2_)).destroy();
            _loc2_++;
         }
      }
      
      public function set setExtraData(param1:Object) : void
      {
         this.extraData = param1;
      }
      
      public function get getExtraData() : Object
      {
         return this.extraData;
      }
   }
}
