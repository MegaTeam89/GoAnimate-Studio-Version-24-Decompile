package anifire.playback
{
   import anifire.component.CustomCharacterMaker;
   import anifire.component.SkinnedCharacterMaker;
   import anifire.constant.AnimeConstants;
   import anifire.constant.RaceConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.interfaces.ICharacter;
   import anifire.interfaces.IPlayable;
   import anifire.util.Util;
   import anifire.util.UtilCommonLoader;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilHashBytes;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public class Behaviour implements IPlayable, IEventDispatcher
   {
      
      public static const FACE_POSITIVE:String = "1";
      
      public static const FACE_NEGATIVE:String = "-1";
      
      public static const CHANGE_FACE:String = "0";
      
      private static const CC_NOT_YET_INITIALIZED:String = "0";
      
      private static const CC_INITIALIZING:String = "1";
      
      private static const CC_ALREADY_FINISH_INITIALIZING:String = "2";
       
      
      private var _file:String;
      
      private var _loader:DisplayObjectContainer;
      
      private var _content:MovieClip;
      
      private var _face:String;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _isFirstBehavior:Boolean = false;
      
      private var _firstBehavior:Behaviour = null;
      
      private var _prevBehavior:Behaviour;
      
      private var _nextBehavior:Behaviour;
      
      private var _myChar:Character;
      
      private var _isLoop:Boolean;
      
      private var _localEndFrame:Number = 1;
      
      protected var _currentFrame:Number;
      
      private var _localStartFrame:Number = 0;
      
      private var _totalFrames:Number = 1;
      
      private var _handProp:DisplayObject = null;
      
      private var _headProp:DisplayObject = null;
      
      private var _wearProp:DisplayObject = null;
      
      private var _customHead:Prop = null;
      
      private var _charObj:DisplayObjectContainer;
      
      private var _charObjFlipped:DisplayObjectContainer;
      
      private var _isContentSet:Boolean = false;
      
      private var _isCC:Boolean = false;
      
      private var _assetImageId:Number = 0;
      
      private var _sceneId:String;
      
      private var _raceCode:Number;
      
      private var _charXML:XML;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _loadHead:Boolean = true;
      
      private var _lipSync:Boolean = false;
      
      public function Behaviour()
      {
         this._eventDispatcher = new EventDispatcher();
         super();
      }
      
      public function set sceneId(param1:String) : void
      {
         this._sceneId = param1;
      }
      
      public function get sceneId() : String
      {
         return this._sceneId;
      }
      
      public function get assetImageId() : Number
      {
         return this._assetImageId;
      }
      
      public function get myChar() : Character
      {
         return this._myChar;
      }
      
      public function set myChar(param1:Character) : void
      {
         this._myChar = param1;
      }
      
      public function get isFirstBehavior() : Boolean
      {
         return this._isFirstBehavior;
      }
      
      public function set isFirstBehavior(param1:Boolean) : void
      {
         this._isFirstBehavior = param1;
      }
      
      public function get firstBehavior() : Behaviour
      {
         return this._firstBehavior;
      }
      
      public function set firstBehavior(param1:Behaviour) : void
      {
         this._firstBehavior = param1;
      }
      
      public function set prevBehavior(param1:Behaviour) : void
      {
         this._prevBehavior = param1;
      }
      
      public function get prevBehavior() : Behaviour
      {
         return this._prevBehavior;
      }
      
      public function get nextBehavior() : Behaviour
      {
         return this._nextBehavior;
      }
      
      public function set nextBehavior(param1:Behaviour) : void
      {
         this._nextBehavior = param1;
      }
      
      public function getLocalStartFrame() : Number
      {
         return this._localStartFrame;
      }
      
      protected function setLocalStartFrame(param1:Number) : void
      {
         this._localStartFrame = param1;
      }
      
      public function getLocalEndFrame() : Number
      {
         return this._localEndFrame;
      }
      
      protected function setLocalEndFrame(param1:Number) : void
      {
         this._localEndFrame = param1;
      }
      
      protected function getTotalFrames() : Number
      {
         return this._totalFrames;
      }
      
      private function setTotalFrames(param1:Number) : void
      {
         this._totalFrames = param1;
      }
      
      public function getIsLoop() : Boolean
      {
         return this._isLoop;
      }
      
      private function setIsLoop(param1:Boolean) : void
      {
         this._isLoop = param1;
      }
      
      public function getFile() : String
      {
         return this._file;
      }
      
      protected function setFile(param1:String) : void
      {
         var _loc2_:RegExp = /.zip/gi;
         this._file = param1.replace(_loc2_,".xml");
      }
      
      public function getLoader() : DisplayObjectContainer
      {
         return this._loader;
      }
      
      private function setLoader(param1:DisplayObjectContainer) : void
      {
         this._loader = param1;
         if(param1 != null)
         {
            this._loader.name = AnimeConstants.LOADER_NAME;
         }
      }
      
      public function getEventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      protected function getContent() : MovieClip
      {
         return this._content;
      }
      
      protected function setContent(param1:MovieClip) : void
      {
         this._content = param1;
      }
      
      public function isContentSet() : Boolean
      {
         return this._isContentSet;
      }
      
      public function getFace() : String
      {
         return this._face;
      }
      
      public function setFace(param1:String) : void
      {
         this._face = param1;
      }
      
      public function getLookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      public function setLookAtCamera(param1:Boolean) : void
      {
         var _loc2_:CustomCharacterMaker = null;
         if(this._isCC)
         {
            this._lookAtCamera = param1;
            _loc2_ = CustomCharacterMaker(this.getLoader());
            if(_loc2_)
            {
               _loc2_.lookAtCamera = param1;
            }
         }
      }
      
      public function initRemoteData(param1:PlayerDataStock, param2:int, param3:Number = 0, param4:Number = 0, param5:Boolean = false, param6:Boolean = true) : void
      {
         var xml:XML = null;
         var data:UtilHashBytes = null;
         var skins:UtilHashBytes = null;
         var figure:ByteArray = null;
         var libraryNode:XML = null;
         var i:int = 0;
         var lid:String = null;
         var scMaker:SkinnedCharacterMaker = null;
         var ccMaker:CustomCharacterMaker = null;
         var iDataStock:PlayerDataStock = param1;
         var raceCode:int = param2;
         var startMilliSec:Number = param3;
         var endMilliSec:Number = param4;
         var isSpeech:Boolean = param5;
         var loadHead:Boolean = param6;
         this._isCC = raceCode == RaceConstants.CUSTOM_CHARACTER;
         this._raceCode = raceCode;
         if(!this._isCC)
         {
            switch(raceCode)
            {
               case RaceConstants.STATIC_SWF:
                  this._assetImageId = 0;
                  if(!this.myChar.parentScene.id)
                  {
                  }
                  if(this._assetImageId > 0)
                  {
                     this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
                  }
                  else
                  {
                     this._assetImageId *= -1;
                     UtilCommonLoader(this.getLoader()).shouldPauseOnLoadBytesComplete = true;
                     UtilCommonLoader(this.getLoader()).addEventListener(Event.COMPLETE,this.onInitRemoteDataCompleted);
                     try
                     {
                        UtilCommonLoader(this.getLoader()).loadBytes(iDataStock.getPlayerData(this.getFile()) as ByteArray);
                     }
                     catch(e:Error)
                     {
                     }
                  }
                  break;
               case RaceConstants.SKINNED_SWF:
                  scMaker = SkinnedCharacterMaker(this.getLoader());
                  scMaker.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onInitCCRemoteDataCompleted);
                  scMaker.themeId = UtilXmlInfo.getThemeIdFromFileName(this.getFile());
                  data = new UtilHashBytes();
                  try
                  {
                     data = iDataStock.getPlayerData(this.getFile())["imageData"];
                     figure = iDataStock.getPlayerData(this.getFile())["figure"] as ByteArray;
                  }
                  catch(e:Error)
                  {
                     figure = iDataStock.getPlayerData(this.getFile()) as ByteArray;
                  }
                  scMaker.init(this._charXML,figure,data,isSpeech,true,this.getFile(),this.getFile());
            }
         }
         else
         {
            ccMaker = CustomCharacterMaker(this.getLoader());
            ccMaker.shouldPauseOnLoadBytesComplete = true;
            ccMaker.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onInitCCRemoteDataCompleted);
            data = new UtilHashBytes();
            try
            {
               xml = iDataStock.getPlayerData(this.getFile())["xml"] as XML;
               data = iDataStock.getPlayerData(this.getFile())["imageData"];
            }
            catch(e:Error)
            {
               xml = XML(iDataStock.getPlayerData(this.getFile()));
            }
            ccMaker.sceneId = this._sceneId;
            ccMaker.loadHead = loadHead;
            this._loadHead = loadHead;
            ccMaker.useImageLibrary = true;
            ccMaker.init(xml,startMilliSec,endMilliSec,data,isSpeech,true,this.getFile());
         }
      }
      
      protected function onInitCCRemoteDataCompleted(param1:Event) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitCCRemoteDataCompleted);
         }
         this.setContent(MovieClip(this.getLoader()));
         this._isContentSet = true;
         this._charObj = UtilPlain.getCharacter(this.getContent());
         this._charObjFlipped = UtilPlain.getCharacterFlip(this.getContent());
         if(!this.getIsLoop())
         {
            this._currentFrame = 0;
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      protected function onInitRemoteDataCompleted(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Class = null;
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitRemoteDataCompleted);
         }
         if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_IN_SPEEDY_MODE) == "1")
         {
            _loc2_ = Util.getCharacter(UtilCommonLoader(this.getLoader()).content as MovieClip);
            if(_loc2_ != null)
            {
               _loc2_.filters = [];
            }
         }
         if(UtilCommonLoader(this.getLoader()).content.loaderInfo.applicationDomain.hasDefinition("theSound"))
         {
            _loc3_ = UtilCommonLoader(this.getLoader()).content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
            if(this is Action)
            {
               this.dispatchEvent(new ExtraDataEvent("SoundRdy",this,_loc3_));
            }
            else if(this is Motion)
            {
               this.dispatchEvent(new ExtraDataEvent("MotionSoundRdy",this,_loc3_));
            }
         }
         this.setContent(MovieClip(UtilCommonLoader(this.getLoader()).content));
         this._isContentSet = true;
         this._charObj = UtilPlain.getCharacter(this.getContent());
         this._charObjFlipped = UtilPlain.getCharacterFlip(this.getContent());
         if(this._charObj == null)
         {
            this._charObj = this.getContent();
         }
         if(!this.getIsLoop())
         {
            this._currentFrame = 0;
         }
         this.goToAndPauseReset();
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      public function initBehaviour(param1:XML, param2:String, param3:UtilHashArray, param4:PlayerDataStock) : Boolean
      {
         this.setFile(UtilXmlInfo.getZipFileNameOfBehaviour(param1.toString(),true));
         var _loc5_:String;
         if((_loc5_ = UtilXmlInfo.getThemeIdFromFileName(this.getFile())) != "ugc")
         {
            param4.decryptPlayerData(this.getFile());
         }
         var _loc6_:Array;
         if((_loc6_ = String(param1.attribute("face")).split(","))[0] == FACE_POSITIVE)
         {
            this.setFace(FACE_POSITIVE);
         }
         else
         {
            this.setFace(FACE_NEGATIVE);
         }
         var _loc7_:XML;
         if((_loc7_ = PlayerConstant.getBehaviourXMLfromThemeXML(this.getFile(),param2,param3)) == null)
         {
            return false;
         }
         if(_loc7_.attribute("loop").length() <= 0)
         {
            this.setIsLoop(true);
         }
         else if(_loc7_.attribute("loop")[0].toString() == "Y")
         {
            this.setIsLoop(true);
         }
         else
         {
            this.setIsLoop(false);
         }
         if(_loc7_.attribute("totalframe").length() > 0)
         {
            this.setTotalFrames(Number(_loc7_.attribute("totalframe")[0].toString()));
         }
         else
         {
            this.setTotalFrames(1);
         }
         if(param4.getPlayerData(this.getFile()) == null)
         {
            return false;
         }
         return true;
      }
      
      public function flip(param1:String) : void
      {
         var _loc2_:DisplayObject = this._charObj;
         var _loc3_:DisplayObject = this._charObjFlipped;
         if(param1 == CHANGE_FACE)
         {
            if(UtilPlain.isObjectFlipped(this.getLoader()))
            {
               param1 = FACE_POSITIVE;
            }
            else
            {
               param1 = FACE_NEGATIVE;
            }
         }
         if(param1 == FACE_POSITIVE)
         {
            UtilPlain.flipObj(this.getLoader(),true,false);
            if(_loc3_ != null)
            {
               if(this._handProp != null)
               {
                  this.setProp(this._handProp);
               }
               if(this._headProp != null)
               {
                  this.setHead(this._headProp);
               }
               if(this._customHead != null || this._wearProp != null)
               {
                  this.setWear(this._wearProp,this._customHead);
               }
            }
         }
         else if(param1 == FACE_NEGATIVE)
         {
            UtilPlain.flipObj(this.getLoader(),false,true);
            if(_loc3_ != null)
            {
               if(this._handProp != null)
               {
                  this.setProp(this._handProp);
               }
               if(this._headProp != null)
               {
                  this.setHead(this._headProp);
               }
               if(this._customHead != null || this._wearProp != null)
               {
                  this.setWear(this._wearProp,this._customHead);
               }
            }
         }
      }
      
      protected function pretendToBe(param1:Behaviour) : void
      {
         this.setFile(param1.getFile());
         this.setIsLoop(param1.getIsLoop());
         this.setTotalFrames(param1.getTotalFrames());
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         ++this._currentFrame;
         if(!this.getIsLoop() && this._currentFrame >= this.getTotalFrames())
         {
            this.pause();
         }
      }
      
      protected function initLoader(param1:int, param2:XML = null) : void
      {
         this._charXML = param2;
         if(this.isFirstBehavior)
         {
            switch(param1)
            {
               case RaceConstants.CUSTOM_CHARACTER:
                  this.setLoader(new CustomCharacterMaker());
                  break;
               case RaceConstants.SKINNED_SWF:
                  this.setLoader(new SkinnedCharacterMaker());
                  break;
               case RaceConstants.STATIC_SWF:
                  this.setLoader(new UtilCommonLoader());
            }
         }
         else
         {
            this.setLoader(this.firstBehavior.getLoader());
         }
      }
      
      public function updateStaticProperties() : void
      {
         this.flip(this.getFace());
      }
      
      public function setProp(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = null;
         this._handProp = param1;
         if(!UtilPlain.isObjectFlipped(this.getLoader()))
         {
            _loc3_ = this._charObj;
         }
         else
         {
            _loc3_ = this._charObjFlipped;
            if(_loc3_ == null)
            {
               _loc3_ = this._charObj;
            }
         }
         _loc2_ = UtilPlain.getProp(_loc3_);
         if(_loc2_ != null)
         {
            UtilPlain.removeAllSon(_loc2_);
            _loc2_.addChild(param1);
            param1.x = 0;
            param1.y = 0;
            param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(_loc2_.parent,this.getLoader(),UtilPlain.PROPERTY_SCALEX));
            param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(_loc2_.parent,this.getLoader(),UtilPlain.PROPERTY_SCALEY));
         }
      }
      
      public function removeProp() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = null;
         _loc2_ = this._charObj;
         _loc1_ = UtilPlain.getProp(_loc2_);
         if(_loc1_ != null)
         {
            UtilPlain.removeAllSon(_loc1_);
         }
         _loc2_ = this._charObjFlipped;
         if(_loc2_ != null)
         {
            _loc1_ = UtilPlain.getProp(_loc2_);
            if(_loc1_ != null)
            {
               UtilPlain.removeAllSon(_loc1_);
            }
         }
      }
      
      public function setHead(param1:DisplayObject = null, param2:int = 0) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         this._headProp = param1;
         this.removeHead();
         if(!UtilPlain.isObjectFlipped(this.getLoader()))
         {
            _loc3_ = this._charObj;
         }
         else
         {
            _loc3_ = this._charObjFlipped;
            if(_loc3_ == null)
            {
               _loc3_ = this._charObj;
            }
         }
         this.setHeadForCharObj(param1,_loc3_,param2);
      }
      
      private function setHeadForCharObj(param1:DisplayObject, param2:DisplayObjectContainer, param3:int = 0) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         if((_loc4_ = UtilPlain.getHead(param2)) != null)
         {
            if(param1 != null)
            {
               _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 0;
               _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).visible = false;
               param1.name = AnimeConstants.MOVIECLIP_CUSTOM_HEAD;
               _loc4_.addChild(param1);
               switch(param3)
               {
                  case RaceConstants.STATIC_SWF:
                  case RaceConstants.SKINNED_SWF:
                     param1.x = 0;
                     param1.y = 0;
                     param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(_loc4_,this.getLoader(),UtilPlain.PROPERTY_SCALEX));
                     param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(_loc4_,this.getLoader(),UtilPlain.PROPERTY_SCALEY));
                     break;
                  case RaceConstants.CUSTOM_CHARACTER:
                     CustomCharacterMaker(this.getLoader()).refreshScale();
               }
            }
         }
         if((_loc4_ = UtilPlain.getTail(param2)) != null)
         {
            if(param1 != null)
            {
               _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).alpha = 0;
               _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).visible = false;
            }
         }
      }
      
      public function removeHead() : void
      {
         var _loc1_:DisplayObjectContainer = this._charObj;
         var _loc2_:DisplayObjectContainer = this._charObjFlipped;
         this.removeHeadForCharObj(_loc1_);
         if(_loc2_ != null)
         {
            this.removeHeadForCharObj(_loc2_);
         }
      }
      
      private function removeHeadForCharObj(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         _loc2_ = UtilPlain.getHead(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getChildByName(AnimeConstants.MOVIECLIP_CUSTOM_HEAD);
            if(_loc3_ != null)
            {
               _loc2_.removeChild(_loc3_);
            }
            (_loc4_ = _loc2_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD)).alpha = 1;
            _loc4_.visible = true;
         }
         _loc2_ = UtilPlain.getTail(param1);
         if(_loc2_ != null)
         {
            if((_loc5_ = _loc2_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL)) != null)
            {
               _loc5_.alpha = 1;
               _loc5_.visible = true;
            }
         }
      }
      
      public function setWear(param1:DisplayObject, param2:Prop) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         this._wearProp = param1;
         this._customHead = param2;
         this.removeWear();
         if(!UtilPlain.isObjectFlipped(this.getLoader()))
         {
            _loc3_ = this._charObj;
         }
         else
         {
            _loc3_ = this._charObjFlipped;
            if(_loc3_ == null)
            {
               _loc3_ = this._charObj;
            }
         }
         this.setWearForCharObj(param1,param2,_loc3_);
      }
      
      public function setWearForCharObj(param1:DisplayObject, param2:Prop, param3:DisplayObjectContainer) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:Number = NaN;
         if((_loc4_ = UtilPlain.getHead(param3)) != null)
         {
            param1.name = AnimeConstants.MOVIECLIP_CUSTOM_WEAR;
            _loc4_.addChild(param1);
            param1.x = 0;
            param1.y = 0;
            param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(_loc4_,this.getLoader(),UtilPlain.PROPERTY_SCALEX));
            param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(_loc4_,this.getLoader(),UtilPlain.PROPERTY_SCALEY));
            _loc5_ = UtilPlain.getInstance(_loc4_,"theTop");
            if(_loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha != 0)
            {
               _loc6_ = _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).getBounds(_loc4_).y;
            }
            else
            {
               _loc6_ = param2 != null ? Number(param2.getBundle().getBounds(param2.getBundle()).y) : Number(0);
            }
            if(_loc5_ != null)
            {
               _loc5_.y = _loc6_;
            }
         }
      }
      
      public function removeWear() : void
      {
         var _loc1_:DisplayObjectContainer = this._charObj;
         var _loc2_:DisplayObjectContainer = this._charObjFlipped;
         this.removeWearForCharObj(_loc1_);
         if(_loc2_ != null)
         {
            this.removeWearForCharObj(_loc2_);
         }
      }
      
      private function removeWearForCharObj(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObject = null;
         _loc2_ = UtilPlain.getHead(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getChildByName(AnimeConstants.MOVIECLIP_CUSTOM_WEAR);
            if(_loc3_ != null)
            {
               _loc2_.removeChild(_loc3_);
            }
         }
      }
      
      private function sceneToBehaviuorFrame(param1:Number) : Number
      {
         var _loc2_:Number = param1 + this.getLocalStartFrame() - 1;
         if(!this.getIsLoop() && _loc2_ > this.getTotalFrames())
         {
            _loc2_ = this.getTotalFrames();
         }
         return _loc2_;
      }
      
      public function behaviourToClipFrame(param1:Number) : Number
      {
         return param1;
      }
      
      public function goToAndPause(param1:Number) : void
      {
         if(this.getContent())
         {
            this.getContent().removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this._currentFrame = this.sceneToBehaviuorFrame(param1);
            if(this.firstBehavior)
            {
               this._currentFrame = this.firstBehavior.behaviourToClipFrame(this._currentFrame);
            }
            else
            {
               this._currentFrame = this.behaviourToClipFrame(this._currentFrame);
            }
            PlayerConstant.goToAndStopFamily(this.getLoader(),this._currentFrame);
         }
      }
      
      public function goToAndPauseReset() : void
      {
         if(this.getContent())
         {
            this.getContent().removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this._currentFrame = this.behaviourToClipFrame(1);
            if(this.isFirstBehavior)
            {
               PlayerConstant.goToAndStopFamily(this.getLoader(),this._currentFrame);
            }
         }
      }
      
      public function pause() : void
      {
         if(this.getContent())
         {
            this.getContent().removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            PlayerConstant.stopFamily(this.getLoader());
         }
      }
      
      public function resume() : void
      {
         if(this.getContent())
         {
            this.getContent().addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            if(!this.getIsLoop() && this._currentFrame >= this.getTotalFrames())
            {
               this.pause();
            }
            else
            {
               PlayerConstant.playFamily(this.getLoader());
            }
         }
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         if(this.nextBehavior == null)
         {
            this.pause();
         }
         if(param1)
         {
            this.setLoader(null);
         }
      }
      
      public function speak(param1:Number) : void
      {
         var _loc2_:ICharacter = null;
         var _loc3_:SpeechPitchEvent = null;
         if(this._raceCode == 1 || this._raceCode == 2)
         {
            _loc2_ = ICharacter(this.getLoader());
            if(_loc2_)
            {
               _loc2_.speak(param1);
            }
         }
         else
         {
            this._lipSync = param1 != -1;
            if(this._lipSync && this.getContent())
            {
               _loc3_ = new SpeechPitchEvent(SpeechPitchEvent.PITCH);
               _loc3_.value = param1;
               MovieClip(this.getContent()).dispatchEvent(_loc3_);
            }
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function prepareImage() : void
      {
         var _loc1_:CustomCharacterMaker = null;
         if(this._isCC)
         {
            _loc1_ = CustomCharacterMaker(this.getLoader());
            _loc1_.prepareImage(this._sceneId,this.isFirstBehavior,this._loadHead);
            this.onInitCCRemoteDataCompleted(null);
         }
      }
   }
}
