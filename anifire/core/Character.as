package anifire.core
{
   import anifire.assets.geom.AssetRotation;
   import anifire.assets.motion.ICircularMotion;
   import anifire.color.SelectedColor;
   import anifire.command.AddPropCommand;
   import anifire.command.CcLookAtCameraCommand;
   import anifire.command.ChangeActionCommand;
   import anifire.command.ICommand;
   import anifire.command.RemovePropCommand;
   import anifire.component.ActionSequence;
   import anifire.component.CustomCharacterMaker;
   import anifire.component.GoAlert;
   import anifire.component.SkinnedAssetMaker;
   import anifire.component.SkinnedCharacterMaker;
   import anifire.constant.AnimeConstants;
   import anifire.constant.RaceConstants;
   import anifire.constant.ThemeConstants;
   import anifire.core.sound.ProgressiveSound;
   import anifire.errors.SerializeError;
   import anifire.event.ByteLoaderEvent;
   import anifire.event.CoreEvent;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.events.AssetEvent;
   import anifire.events.CharacterAssetEvent;
   import anifire.interfaces.IBehavior;
   import anifire.interfaces.ICharacter;
   import anifire.interfaces.IColorable;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IEye;
   import anifire.interfaces.IFacial;
   import anifire.interfaces.IFlippable;
   import anifire.interfaces.IHoldable;
   import anifire.interfaces.IMotion;
   import anifire.interfaces.IMouth;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IRotatable;
   import anifire.interfaces.IScalable;
   import anifire.interfaces.ISequentialAction;
   import anifire.interfaces.ISlidable;
   import anifire.interfaces.IThumb;
   import anifire.interfaces.IWearable;
   import anifire.managers.*;
   import anifire.tutorial.*;
   import anifire.util.*;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.collections.Sort;
   import mx.collections.SortField;
   import mx.collections.XMLListCollection;
   import mx.controls.Button;
   import mx.core.ScrollPolicy;
   import mx.events.DragEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Character extends Asset implements ISlidable, IDraggable, IRotatable, IMovable, IScalable, IFlippable, IColorable, IFacial, IHoldable, IWearable, IEye, IMotion, IMouth, ISequentialAction
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Character");
      
      public static const XML_NODE_NAME:String = "char";
      
      private static const MENU_ITEM_TYPE_TAG:String = "itemType";
      
      private static const MENU_ITEM_TYPE_ACTION_TAG:String = "action";
      
      private static const MENU_ITEM_TYPE_FACIAL_TAG:String = "facial";
      
      private static const MENU_ITEM_TYPE_STATE_TAG:String = "state";
      
      private static const MENU_ITEM_TYPE_PROP_TAG:String = "prop";
      
      private static const MENU_ITEM_TYPE_HEAD_TAG:String = "head";
      
      private static const MENU_ITEM_TYPE_WEAR_TAG:String = "wear";
      
      private static const MENU_ITEM_TYPE_COLOR_TAG:String = "color";
      
      private static const MENU_ITEM_TYPE_MOVEMENT_TAG:String = "movement";
      
      private static const SLIDE_FORWARD:String = "slideForward";
      
      private static const SLIDE_BACKWARD:String = "slideBackward";
      
      private static const BLINK:String = "blink";
      
      private static const REMOVE_MOTION:String = "removeMotion";
      
      private static const ADD_CONTROL_POINT:String = "addControlPoint";
      
      private static const REMOVE_CONTROL_POINT:String = "removeControlPoint";
      
      private static const MENU_ITEM_ACTION:String = "actionmenu_action";
      
      private static const MENU_ITEM_MOVEMENT:String = "actionmenu_movement";
      
      private static const MENU_ITEM_SLIDE:String = "actionmenu_slide";
      
      private static const MENU_ITEM_FACIAL:String = "actionmenu_facial";
      
      private static const MENU_ITEM_DEFAULT:String = "actionmenu_default";
      
      private static const MENU_ITEM_PROP:String = "actionmenu_handheld";
      
      private static const MENU_ITEM_HEAD:String = "actionmenu_head";
      
      private static const MENU_ITEM_WEAR:String = "actionmenu_headgear";
      
      private static const MENU_ITEM_PROP_REMOVE:String = "actionmenu_restoreprop";
      
      private static const MENU_ITEM_HEAD_REMOVE:String = "actionmenu_restorehead";
      
      private static const MENU_ITEM_WEAR_REMOVE:String = "actionmenu_restoremask";
      
      private static const MENU_ITEM_MOVEMENT_REMOVE:String = "actionmenu_removeMove";
      
      private static const MENU_ITEM_POINT_ADD:String = "motionmenu_addpoint";
      
      private static const MENU_ITEM_POINT_REMOVE:String = "motionmenu_removepoint";
       
      
      private var _fromTray:Boolean = false;
      
      private var _readyToDrag:Boolean = false;
      
      private var _byMovement:Boolean = false;
      
      private var _byMenu:Boolean = false;
      
      private var _facing:String = "left";
      
      private var _motionDirection:String = "";
      
      private var _actionId:String;
      
      private var _action:IBehavior;
      
      private var _motionId:String;
      
      private var _motion:Motion;
      
      private var _facial:Facial;
      
      private var _motionShadowChar:Character;
      
      private var _shadowParent:Character = null;
      
      private var _ccLoader:ICharacter;
      
      private var _actionMenu:ScrollableArrowMenu;
      
      private var _motionMenu:ScrollableArrowMenu;
      
      private var _motionMenuXML:XML;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _originalRotation:Number = 0;
      
      private var _checkedActionItem:Object;
      
      private var _checkedMotionItem:Object;
      
      private var _prop:Prop;
      
      private var _head:Prop;
      
      private var _wear:Prop;
      
      private var initCameraHandler:Function = null;
      
      private var speechHandler:Function = null;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _lookAtCameraSupported:Boolean = false;
      
      private var _demoSpeech:Boolean = false;
      
      private var _orgLoaderScaleX:Number = 1;
      
      private var _orgLoaderScaleY:Number = 1;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      private var _prevCharPosX:Number = 0;
      
      private var _prevCharPosY:Number = 0;
      
      private var _isBlink:Boolean = false;
      
      private var _colorTrasformOld:ColorTransform;
      
      private var _loadCount:Number = 0;
      
      private var _loadTotal:Number = 0;
      
      private var _backupSceneXML:XML;
      
      private var _controlPoints:Array;
      
      private var _mouseClickPoint:Point;
      
      private var _speechVoice:String;
      
      private var _speakingVolume:Number = 1;
      
      private var _actionSeq:ActionSequence;
      
      private var _motionData:MotionData;
      
      private var _rotation:AssetRotation;
      
      private var _referencePoint:Point;
      
      private var _circularMotion:ICircularMotion;
      
      private var _isShadow:Boolean = false;
      
      private var _hasFacialExpression:Boolean = false;
      
      public function Character(param1:String = "")
      {
         this._controlPoints = new Array();
         this._mouseClickPoint = new Point();
         this._rotation = new AssetRotation();
         this._referencePoint = new Point(-1,-1);
         super();
         if(param1 == "")
         {
            param1 = "AVATOR" + this.assetCount;
         }
         this.id = param1;
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray) : UtilHashArray
      {
         var themeTrees:UtilHashArray = null;
         var curBehaviourXML:XML = null;
         var charBehaviourXML:XML = null;
         var entry:ZipEntry = null;
         var themeID:String = null;
         var charID:String = null;
         var themeXml:XML = null;
         var defaultActionId:String = null;
         var fileName:String = null;
         var shouldExtractEntryToThemeTree:Boolean = false;
         var byteArray:ByteArray = null;
         var newThemeTree:ThemeTree = null;
         var decryptEngine:UtilCrypto = null;
         var assetXML:XML = param1;
         var zipFile:ZipFile = param2;
         var existingThemeTrees:UtilHashArray = param3;
         themeTrees = new UtilHashArray();
         curBehaviourXML = assetXML.child(Action.XML_NODE_NAME)[0];
         if(curBehaviourXML != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Behavior.getThemeTrees(curBehaviourXML,zipFile,existingThemeTrees,true));
            charBehaviourXML = curBehaviourXML;
         }
         curBehaviourXML = assetXML.child(Motion.XML_NODE_NAME)[0];
         if(curBehaviourXML != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Behavior.getThemeTrees(curBehaviourXML,zipFile,existingThemeTrees,true));
            charBehaviourXML = curBehaviourXML;
         }
         themeID = Behavior.getThemeIdFromBehaviourXML(charBehaviourXML);
         charID = Behavior.getCharIdFromBehaviourXML(charBehaviourXML);
         var themeTree:ThemeTree = existingThemeTrees.getValueByKey(themeID) as ThemeTree;
         if(themeTree != null)
         {
            themeXml = themeTree.getThemeXml();
         }
         if(themeXml == null)
         {
            themeXml = new XML(zipFile.getInput(zipFile.getEntry(themeID + ".xml")).toString());
            if(themeTree != null)
            {
               themeTree.addThemeXml(themeXml);
            }
         }
         var charNode:XML = themeXml["char"].(@id == charID)[0];
         defaultActionId = charNode.attribute("default");
         fileName = UtilXmlInfo.generateBehaviourFileName(themeID,charID,charID);
         entry = zipFile.getEntry(fileName);
         shouldExtractEntryToThemeTree = true;
         if(entry == null)
         {
            shouldExtractEntryToThemeTree = false;
         }
         else if(existingThemeTrees.containsKey(themeID) && (existingThemeTrees.getValueByKey(themeID) as ThemeTree).isCharBehaviourExist(charID,defaultActionId,true))
         {
            shouldExtractEntryToThemeTree = false;
         }
         if(shouldExtractEntryToThemeTree)
         {
            byteArray = zipFile.getInput(entry);
            if(themeID != "ugc")
            {
               decryptEngine = new UtilCrypto();
               decryptEngine.decrypt(byteArray);
            }
            newThemeTree = new ThemeTree(themeID);
            newThemeTree.addCharBehaviour(charID,defaultActionId,byteArray,true);
            ThemeTree.mergeThemeTreeToThemeTrees(themeTrees,newThemeTree);
         }
         if(assetXML.child(Prop.XML_NODE_NAME)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Prop.getThemeTrees(assetXML.child(Prop.XML_NODE_NAME)[0] as XML,zipFile,existingThemeTrees));
         }
         if(assetXML.child(Prop.XML_NODE_NAME_HEAD)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Prop.getThemeTrees(assetXML.child(Prop.XML_NODE_NAME_HEAD)[0] as XML,zipFile,existingThemeTrees));
         }
         if(assetXML.child(Prop.XML_NODE_NAME_WEAR)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Prop.getThemeTrees(assetXML.child(Prop.XML_NODE_NAME_WEAR)[0] as XML,zipFile,existingThemeTrees));
         }
         return themeTrees;
      }
      
      public function get actionSequence() : ActionSequence
      {
         return this._actionSeq;
      }
      
      public function set actionSequence(param1:ActionSequence) : void
      {
         this._actionSeq = param1;
      }
      
      public function get speakingVolume() : Number
      {
         return this._speakingVolume;
      }
      
      public function set speakingVolume(param1:Number) : void
      {
         this._speakingVolume = param1;
      }
      
      public function get ccLoader() : ICharacter
      {
         if(!this._ccLoader)
         {
            if(thumb.isCC)
            {
               this._ccLoader = new CustomCharacterMaker();
            }
            else if(thumb.raceCode == RaceConstants.SKINNED_SWF)
            {
               this._ccLoader = new SkinnedCharacterMaker();
            }
         }
         return this._ccLoader;
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         if(this.head)
         {
            this.head.lookAtCamera = param1;
         }
         if(this._lookAtCamera != param1)
         {
            this._lookAtCamera = param1;
            this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,this._lookAtCamera));
            this.dispatchEvent(new AssetEvent(CharacterAssetEvent.EYE_CHANGE,this));
         }
      }
      
      public function toggleLookAtCamera() : void
      {
         var _loc1_:Boolean = this.lookAtCamera;
         this.lookAtCamera = !this.lookAtCamera;
         var _loc2_:ICommand = new CcLookAtCameraCommand(id,_loc1_);
         _loc2_.execute();
      }
      
      public function set demoSpeech(param1:Boolean) : void
      {
         if(this.head)
         {
            this.head.demoSpeech = param1;
         }
         if(this._demoSpeech != param1)
         {
            this._demoSpeech = param1;
            this.dispatchEvent(new AssetEvent(CharacterAssetEvent.MOUTH_CHANGE,this));
         }
      }
      
      public function get demoSpeech() : Boolean
      {
         return this._demoSpeech;
      }
      
      public function get shadowParent() : Character
      {
         return this._shadowParent;
      }
      
      public function get motionShadow() : Character
      {
         return this._motionShadowChar;
      }
      
      public function get shadow() : Object
      {
         return this._motionShadowChar;
      }
      
      public function set motionShadow(param1:Character) : void
      {
         if(this._motionShadowChar)
         {
            this._motionShadowChar.removeEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
         }
         this._motionShadowChar = param1;
         if(this._motionShadowChar)
         {
            this._motionShadowChar.addEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
            this._motionShadowChar._shadowParent = this;
         }
      }
      
      public function set facing(param1:String) : void
      {
         var scChar:SkinnedCharacterMaker = null;
         var facing:String = param1;
         var doFlip:Boolean = false;
         var newface:Number = 0;
         if(facing != this.facing && (this.facing == AnimeConstants.FACING_LEFT || this.facing == AnimeConstants.FACING_RIGHT))
         {
            try
            {
               if(newface < 0)
               {
                  this._facing = this.defaultFacing == AnimeConstants.FACING_LEFT ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
               }
               else
               {
                  this._facing = this.defaultFacing;
               }
            }
            catch(e:Error)
            {
            }
         }
         if(newface == 0)
         {
            this._facing = facing;
         }
         if(doFlip)
         {
            this.exchangeProp();
         }
         if(this.demoSpeech && this.imageObject is SkinnedCharacterMaker)
         {
            scChar = SkinnedCharacterMaker(this.imageObject);
            if(scChar.state == SkinnedAssetMaker.STATE_FINISH_LOAD)
            {
               scChar.addMouthClipToHeadContainer(scChar.updateComponentImageData("mouth",null),scChar);
            }
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_HFLIPPED,this));
      }
      
      public function set motionDirection(param1:String) : void
      {
         this._motionDirection = param1;
      }
      
      public function get motionDirection() : String
      {
         return this._motionDirection;
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      public function get isFlipped() : Boolean
      {
         return this._facing != AnimeConstants.FACING_LEFT;
      }
      
      private function get defaultFacing() : String
      {
         return CharThumb(this.thumb).facing;
      }
      
      public function set actionId(param1:String) : void
      {
         this._actionId = param1;
      }
      
      public function get actionId() : String
      {
         return this._actionId;
      }
      
      override public function set action(param1:IBehavior) : void
      {
         if(this._action != param1)
         {
            this.addTalkHeadForSpeech();
            this._action = Action(param1);
            this.actionId = Action(param1).id;
            this.imageData = Action(param1).imageData;
         }
      }
      
      public function get action() : IBehavior
      {
         return this._action;
      }
      
      public function get motionId() : String
      {
         return this._motionId;
      }
      
      public function set motionId(param1:String) : void
      {
         this._motionId = param1;
      }
      
      public function set motion(param1:Motion) : void
      {
         this._motion = param1;
         if(this._motion == null)
         {
            this.motionId = "";
         }
         else
         {
            this.motionId = this._motion.id;
         }
      }
      
      public function get motion() : Motion
      {
         return this._motion;
      }
      
      public function addProp(param1:Prop) : void
      {
      }
      
      public function get prop() : Prop
      {
         return this._prop;
      }
      
      public function set prop(param1:Prop) : void
      {
         this._prop = param1;
      }
      
      public function get head() : Prop
      {
         return this._head;
      }
      
      public function set head(param1:Prop) : void
      {
         this._head = param1;
      }
      
      public function get wear() : Prop
      {
         return this._wear;
      }
      
      public function set wear(param1:Prop) : void
      {
         this._wear = param1;
      }
      
      function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      public function get isBlink() : Boolean
      {
         return this._isBlink;
      }
      
      public function set isBlink(param1:Boolean) : void
      {
         this._isBlink = param1;
      }
      
      public function set speechVoice(param1:String) : void
      {
         this._speechVoice = param1;
      }
      
      public function get speechVoice() : String
      {
         return this._speechVoice;
      }
      
      private function getShadowIndex(param1:AnimeScene) : int
      {
         return param1.background == null ? 0 : 1;
      }
      
      public function getDataAndKey() : UtilHashArray
      {
         var _loc5_:UtilHashArray = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc1_:UtilHashArray = new UtilHashArray();
         var _loc2_:String = this.thumb.id;
         var _loc3_:String = this.thumb.theme.id + ".char." + _loc2_ + "." + this.action.id;
         _loc1_.push(_loc3_,this.action.imageData,true);
         var _loc4_:int = 0;
         while(_loc4_ < CharThumb(this.thumb).getLibraryNum())
         {
            _loc7_ = CharThumb(this.thumb).getLibraryIdByIndex(_loc4_);
            _loc1_.push(_loc7_,CharThumb(this.thumb).getLibraryById(_loc7_));
            _loc4_++;
         }
         if(this.prop != null)
         {
            if(PropThumb(this.prop.thumb).getStateNum() == 0)
            {
               _loc2_ = this.prop.thumb.id;
               _loc1_.push(this.prop.thumb.theme.id + ".prop." + _loc2_,this.prop.thumb.imageData,true);
            }
            else
            {
               _loc5_ = this.prop.getDataAndKey();
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  _loc1_.push(_loc5_.getKey(_loc6_),_loc5_.getValueByIndex(_loc6_),true);
                  _loc6_++;
               }
            }
         }
         if(this.head != null)
         {
            if(PropThumb(this.head.thumb).getStateNum() == 0)
            {
               _loc2_ = this.head.thumb.id;
               _loc1_.push(this.head.thumb.theme.id + ".prop." + _loc2_,this.head.thumb.imageData,true);
            }
            else
            {
               _loc5_ = this.head.getDataAndKey();
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  _loc1_.push(_loc5_.getKey(_loc6_),_loc5_.getValueByIndex(_loc6_),true);
                  _loc6_++;
               }
            }
         }
         if(this.wear != null)
         {
            if(PropThumb(this.wear.thumb).getStateNum() == 0)
            {
               _loc2_ = this.wear.thumb.id;
               _loc1_.push(this.wear.thumb.theme.id + ".prop." + _loc2_,this.wear.thumb.imageData,true);
            }
            else
            {
               _loc5_ = this.wear.getDataAndKey();
               _loc6_ = 0;
               while(_loc6_ < _loc5_.length)
               {
                  _loc1_.push(_loc5_.getKey(_loc6_),_loc5_.getValueByIndex(_loc6_),true);
                  _loc6_++;
               }
            }
            _loc1_.push(this.wear.thumb.theme.id + ".prop." + this.wear.thumb.id,this.wear.thumb.imageData,true);
         }
         return _loc1_;
      }
      
      public function loadActionAndMotion(param1:CoreEvent) : void
      {
         this.motion = (this.thumb as CharThumb).defaultMotion;
         if(this._fromTray)
         {
            this.action = CharThumb(this.thumb).defaultAction;
         }
         else
         {
            this.action = CharThumb(this.thumb).getActionById(this.actionId);
         }
      }
      
      public function getCharMovieClip() : MovieClip
      {
         return null;
      }
      
      private function getMotionFacing() : int
      {
         var _loc1_:String = this.getFacingDirection();
         var _loc2_:int = _loc1_ == this.defaultFacing ? 1 : -1;
         if(this.motionDirection == AnimeConstants.MOTION_FORWARD)
         {
            return _loc2_;
         }
         return _loc2_ * -1;
      }
      
      private function setMotionFacing(param1:int) : void
      {
         var _loc2_:String = this.facing;
         var _loc3_:int = _loc2_ == this.defaultFacing ? 1 : -1;
         if(_loc3_ != param1)
         {
            this.motionDirection = AnimeConstants.MOTION_BACKWARD;
         }
         else
         {
            this.motionDirection = AnimeConstants.MOTION_FORWARD;
         }
      }
      
      override public function convertToXml() : XML
      {
         var xml:XML = null;
         var childXml:XML = null;
         var motionFacing:int = 0;
         var index:uint = 0;
         var i:int = 0;
         xml = <char/>;
         try
         {
            motionFacing = this.getMotionFacing();
            index = this.scene.getOverallOrdering(this);
            xml.@id = this.id;
            xml.@index = String(index);
            xml.@raceCode = thumb.raceCode;
            if(this.lookAtCamera)
            {
               xml.@faceCamera = "true";
            }
            xml.action = Action(this.action).getKey();
            xml.action.@face = this.serializeMotion("facing",this.motionShadow);
            xml.action.@motionface = motionFacing;
            if(this.actionSequence)
            {
               xml.action.@seq = this.actionSequence.toString();
            }
            if(this.mThumbId)
            {
               xml.mThumb.@id = this.mThumbId;
            }
            if(this.prop)
            {
               childXml = this.prop.convertToXml();
               xml.appendChild(childXml);
            }
            if(this.head)
            {
               childXml = this.head.convertToXml();
               xml.appendChild(childXml);
            }
            if(this.wear)
            {
               childXml = this.wear.convertToXml();
               xml.appendChild(childXml);
            }
            xml.x = this.serializeMotion("x",this.motionShadow);
            xml.y = this.serializeMotion("y",this.motionShadow);
            xml.xscale = this.serializeMotion("xscale",this.motionShadow);
            xml.yscale = this.serializeMotion("yscale",this.motionShadow);
            xml.rotation = this.serializeMotion("rotation",this.motionShadow);
            if(defaultColorSetId != "")
            {
               xml.dcsn = defaultColorSetId;
            }
            if(customColor.length > 0)
            {
               i = 0;
               while(i < customColor.length)
               {
                  childXml = <color>{SelectedColor(customColor.getValueByIndex(i)).dstColor}</color>;
                  childXml.@r = customColor.getKey(i);
                  if(SelectedColor(customColor.getValueByIndex(i)).orgColor != uint.MAX_VALUE)
                  {
                     childXml.@oc = "0x" + SelectedColor(customColor.getValueByIndex(i)).orgColor.toString(16);
                  }
                  xml.appendChild(childXml);
                  i++;
               }
            }
            if(this._motionData)
            {
               childXml = this._motionData.convertToXml();
               xml.appendChild(childXml);
            }
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize char, broken char xml: " + xml.toXMLString());
         }
         return xml;
      }
      
      override public function serialize() : String
      {
         return this.convertToXml().toXMLString();
      }
      
      public function serializeMotion(param1:String, param2:Character) : Array
      {
         var tempArray:Array = null;
         var i:int = 0;
         var property:String = param1;
         var shadow:Character = param2;
         try
         {
            tempArray = new Array();
            switch(property)
            {
               case "x":
                  tempArray.push(Util.roundNum(this.x));
                  break;
               case "y":
                  tempArray.push(Util.roundNum(this.y));
                  break;
               case "xscale":
                  tempArray.push(Util.roundNum(this.scaleX,AnimeConstants.MATH_DOT_NUM + 1));
                  break;
               case "yscale":
                  tempArray.push(Util.roundNum(this.scaleY,AnimeConstants.MATH_DOT_NUM + 1));
                  break;
               case "facing":
                  tempArray.push(this.facing == this.defaultFacing ? 1 : -1);
                  break;
               case "rotation":
                  tempArray.push(Util.roundNum(this.rotation));
            }
            if(this.motionData && this.motionData.path.length > 2)
            {
               i = 0;
               switch(property)
               {
                  case "x":
                     i = 1;
                     while(i < this.motionData.path.length - 1)
                     {
                        tempArray.push(Util.roundNum(Point(this.motionData.path[i]).x));
                        i++;
                     }
                     break;
                  case "y":
                     i = 1;
                     while(i < this.motionData.path.length - 1)
                     {
                        tempArray.push(Util.roundNum(Point(this.motionData.path[i]).y));
                        i++;
                     }
               }
            }
            if(shadow != null)
            {
               switch(property)
               {
                  case "x":
                     tempArray.push(Util.roundNum(shadow.x));
                     break;
                  case "y":
                     tempArray.push(Util.roundNum(shadow.y));
                     break;
                  case "xscale":
                     tempArray.push(Util.roundNum(shadow.scaleX,AnimeConstants.MATH_DOT_NUM + 1));
                     break;
                  case "yscale":
                     tempArray.push(Util.roundNum(shadow.scaleY,AnimeConstants.MATH_DOT_NUM + 1));
                     break;
                  case "facing":
                     tempArray.push(this.motionShadow.facing == this.defaultFacing ? 1 : -1);
                     break;
                  case "rotation":
                     tempArray.push(Util.roundNum(shadow.rotation));
               }
            }
         }
         catch(e:Error)
         {
            throw new SerializeError("Failed to serialize character motion " + this.id,tempArray.toString(),e);
         }
         return tempArray;
      }
      
      public function getActionDefaultTotalFrame() : int
      {
         var _loc1_:CharThumb = null;
         if(this.action != null)
         {
            _loc1_ = this.thumb as CharThumb;
            if(_loc1_ != null && _loc1_.defaultAction != null && this.action.id == _loc1_.defaultAction.id)
            {
               return UtilUnitConvert.pixelToFrame(AnimeConstants.SCENE_LENGTH_DEFAULT);
            }
            return Action(this.action).totalFrame;
         }
         return 1;
      }
      
      private function getMotionConstants(param1:String, param2:String, param3:int) : String
      {
         if(param1 == param2)
         {
            if(param3 == 1)
            {
               return AnimeConstants.MOTION_FORWARD;
            }
            return AnimeConstants.MOTION_BACKWARD;
         }
         if(param3 == -1)
         {
            return AnimeConstants.MOTION_FORWARD;
         }
         return AnimeConstants.MOTION_BACKWARD;
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true) : void
      {
         var _loc10_:int = 0;
         var _loc13_:String = null;
         var _loc14_:AnimeSound = null;
         var _loc15_:XML = null;
         var _loc16_:int = 0;
         var _loc17_:String = null;
         var _loc18_:SelectedColor = null;
         var _loc19_:XML = null;
         var _loc20_:Prop = null;
         var _loc21_:XML = null;
         var _loc22_:XML = null;
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBehaviour(param1.action,true);
         var _loc5_:RegExp = /zip/gi;
         _loc4_ = _loc4_.replace(_loc5_,"xml");
         var _loc6_:String = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
         var _loc7_:String = UtilXmlInfo.getCharIdFromFileName(_loc4_);
         var _loc8_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc9_:CharThumb;
         if((_loc9_ = ThemeManager.instance.getTheme(_loc8_).getCharThumbById(_loc7_)) != null)
         {
            this.scene = param2;
            this.thumb = _loc9_;
            this.actionId = _loc6_;
            this._xs = String(param1.x).split(",");
            this._ys = String(param1.y).split(",");
            this._scaleXs = String(param1.xscale).split(",");
            this._scaleYs = String(param1.yscale).split(",");
            this._rotations = String(param1.rotation).split(",");
            this._facings = String(param1.action.@face).split(",");
            this.lookAtCamera = String(param1.@faceCamera) == "true";
            _loc13_ = Console.getConsole().linkageController.getSpeechSoundIdByScene(this.scene);
            if((_loc14_ = Console.getConsole().speechManager.getValueByKey(_loc13_)) is ProgressiveSound)
            {
               _loc17_ = Console.getConsole().linkageController.getTargetIdOfSpeech(_loc13_);
               this.demoSpeech = AssetLinkage.getCharIdFromLinkage(_loc17_) == this.id ? true : false;
            }
            this.setReferencePoint(this._xs[0],this._ys[0]);
            this.move(this._xs[0],this._ys[0]);
            this.scaleX = this._scaleXs[0];
            this.scaleY = this._scaleYs[0];
            this.rotation = this._rotations[0];
            this.facing = this.getFacingConstants(_loc9_.facing,this._facings[0]);
            if(param3)
            {
               this.action = _loc9_.getActionById(_loc6_);
            }
            else
            {
               this._action = _loc9_.getActionById(_loc6_);
            }
            if(param1.mThumb)
            {
               this.mThumbId = param1.mThumb.@id;
            }
            if(param1.action.hasOwnProperty("@seq"))
            {
               this.actionSequence = new ActionSequence();
               this.actionSequence.init(String(param1.action.@seq).split(","));
            }
            if(param1.dcsn.length() > 0)
            {
               this.defaultColorSetId = String(param1.dcsn);
               this.defaultColorSet = Thumb(this.thumb).getColorSetById(this.defaultColorSetId);
            }
            customColor = new UtilHashSelectedColor();
            _loc16_ = 0;
            while(_loc16_ < param1.child("color").length())
            {
               _loc15_ = param1.child("color")[_loc16_];
               _loc18_ = new SelectedColor(_loc15_.@r,_loc15_.attribute("oc").length() == 0 ? uint(uint.MAX_VALUE) : uint(_loc15_.@oc),uint(_loc15_));
               this.addCustomColor(_loc15_.@r,_loc18_);
               _loc16_++;
            }
            if(this.action != null && this.action.imageData != null)
            {
               this.isLoadded = true;
               _loc10_ = 0;
               while(_loc10_ < param1.prop.length())
               {
                  _loc19_ = param1.prop[_loc10_];
                  (_loc20_ = new Prop()).capScreenLock = this.capScreenLock;
                  _loc20_.deSerialize(_loc19_,this);
                  this.addPropDataAndClip(_loc20_);
                  this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
                  _loc10_++;
               }
            }
         }
         _loc10_ = 0;
         while(_loc10_ < param1.prop.length())
         {
            _loc19_ = param1.prop[_loc10_];
            (_loc20_ = new Prop()).capScreenLock = this.capScreenLock;
            _loc20_.deSerialize(_loc19_,this);
            this.addPropDataAndClip(_loc20_);
            this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            _loc10_++;
         }
         var _loc11_:int = 0;
         while(_loc11_ < param1.head.length())
         {
            _loc21_ = param1.head[_loc11_];
            (_loc20_ = new Prop()).capScreenLock = this.capScreenLock;
            _loc20_.lookAtCamera = this.lookAtCamera;
            _loc20_.demoSpeech = this.demoSpeech;
            _loc20_.deSerialize(_loc21_,this);
            this.addHeadDataAndClip(_loc20_);
            this.head.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            _loc11_++;
         }
         var _loc12_:int = 0;
         while(_loc12_ < param1.wear.length())
         {
            _loc22_ = param1.wear[_loc12_];
            (_loc20_ = new Prop()).capScreenLock = this.capScreenLock;
            _loc20_.deSerialize(_loc22_,this);
            this.addWearDataAndClip(_loc20_);
            this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            _loc12_++;
         }
         this.setMotionProperties(param1);
         if(this._motionData)
         {
            if(param1.hasOwnProperty(MotionData.XML_TAG_NAME))
            {
               this._motionData.convertFromXml(param1.child(MotionData.XML_TAG_NAME)[0]);
            }
            else
            {
               this._motionData.version = "1";
            }
         }
      }
      
      private function setMotionProperties(param1:XML) : void
      {
         if(this.shouldHasMotion())
         {
            this.fillMaskPoint();
            this.setMotionFacing(param1.action.@motionface);
            this.addMotionShadow(this._xs,this._ys,this._scaleXs,this._scaleYs,this._facings,this._rotations);
            this.hideMotionShadow();
         }
      }
      
      private function fillMaskPoint() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(this._xs.length > 1 && this._xs.length == this._ys.length)
         {
            if(this._motionData)
            {
               this._motionData.removeEventListener(Event.CHANGE,this.onMotionChange);
            }
            this._motionData = new MotionData();
            _loc1_ = new Array();
            _loc2_ = 0;
            while(_loc2_ < this._xs.length)
            {
               _loc1_.push(new Point(_xs[_loc2_],_ys[_loc2_]));
               _loc2_++;
            }
            this._motionData.path = _loc1_;
            this._motionData.startRotation = this.rotation;
            this._motionData.addEventListener(Event.CHANGE,this.onMotionChange);
            this.updateFacing();
         }
      }
      
      private function getFacingConstants(param1:String, param2:int) : String
      {
         if(param1 == AnimeConstants.FACING_LEFT)
         {
            return param2 == 1 ? AnimeConstants.FACING_LEFT : AnimeConstants.FACING_RIGHT;
         }
         return param2 == 1 ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
      }
      
      override public function set thumb(param1:IThumb) : void
      {
         var _loc2_:CharThumb = param1 as CharThumb;
         super.thumb = _loc2_;
         if(this._fromTray)
         {
            this.action = _loc2_.defaultAction as Action;
            this.motion = _loc2_.defaultMotion;
            if(this.action is ISequentialAction)
            {
               this.actionSequence = ISequentialAction(this.action).actionSequence.clone();
               this.actionSequence.randomize();
            }
            else
            {
               this.actionSequence = null;
            }
         }
         else
         {
            this.action = _loc2_.getActionById(this.actionId) as Action;
            this.motion = _loc2_.getMotionById(this.motionId);
         }
      }
      
      protected function getOrigin() : Point
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc1_:Point = new Point();
         var _loc2_:DisplayObject = DisplayObject(this.imageObject);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.localToGlobal(new Point());
            _loc4_ = Console.getConsole().mainStage.sceneEditor.view.globalToLocal(_loc3_);
            _loc1_.x = _loc4_.x;
            _loc1_.y = _loc4_.y;
         }
         return _loc1_;
      }
      
      private function isRegardAsMoved(param1:Point, param2:Point) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         if(param2.subtract(param1).length > AnimeConstants.ASSET_MOVE_TOLERANCE)
         {
            return true;
         }
         return false;
      }
      
      public function get lookAtCameraSupported() : Boolean
      {
         return this._lookAtCameraSupported;
      }
      
      private function isCharacterThumbsReady() : Boolean
      {
         var _loc1_:CharThumb = this.thumb as CharThumb;
         if(!_loc1_.isThumbReady(this.actionId))
         {
            return false;
         }
         return true;
      }
      
      public function doMouseUp(param1:MouseEvent) : void
      {
         this.onMouseUp(param1);
      }
      
      function onMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:State = null;
         var _loc4_:int = 0;
         var _loc5_:UtilHashSelectedColor = null;
         var _loc6_:ICommand = null;
         if(Console.getConsole().currDragObject is Prop)
         {
            _loc2_ = Console.getConsole().currDragObject.thumb;
            if(!(PropThumb(_loc2_).headable && this.thumb.isCC))
            {
               if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable || PropThumb(_loc2_).headable || PropThumb(_loc2_).wearable))
               {
                  if(!this.isMotionShadow())
                  {
                     (_loc6_ = new AddPropCommand()).execute();
                  }
                  if(PropThumb(_loc2_).getStateNum() > 0)
                  {
                     _loc3_ = Prop(Console.getConsole().currDragObject).state;
                  }
                  _loc5_ = Prop(Console.getConsole().currDragObject).customColor;
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_.length)
                  {
                     addCustomColor(_loc5_.getKey(_loc4_),_loc5_.getValueByIndex(_loc4_));
                     _loc4_++;
                  }
                  this.autoStateModify(_loc2_ as PropThumb,_loc3_);
                  Console.getConsole().currDragObject.deleteAsset(false);
                  Console.getConsole().currDragObject = null;
                  this.scene.selectedAsset = null;
               }
            }
         }
      }
      
      public function updateFacing(param1:Character = null) : void
      {
         if(this.motionShadow != null || this.isMotionShadow())
         {
            if(this.getFacingDirection(param1) == AnimeConstants.FACING_LEFT)
            {
               this.facing = AnimeConstants.FACING_LEFT;
            }
            else if(this.getFacingDirection(param1) == AnimeConstants.FACING_RIGHT)
            {
               this.facing = AnimeConstants.FACING_RIGHT;
            }
            if(this.motionShadow)
            {
               this.motionShadow.updateFacing(this);
            }
         }
      }
      
      private function getFacingDirection(param1:Character = null) : String
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Number = this.x;
         if(this.motionShadow != null)
         {
            _loc3_ = this.motionShadow.x;
            if(this._motionData && this._motionData.path.length > 1)
            {
               _loc3_ = Point(this._motionData.path[1]).x;
            }
            if(this.motionDirection == AnimeConstants.MOTION_FORWARD)
            {
               if(_loc2_ < _loc3_)
               {
                  return AnimeConstants.FACING_RIGHT;
               }
               if(_loc2_ > _loc3_)
               {
                  return AnimeConstants.FACING_LEFT;
               }
               return AnimeConstants.FACING_UNKNOW;
            }
            if(_loc3_ < _loc2_)
            {
               return AnimeConstants.FACING_RIGHT;
            }
            if(_loc3_ > _loc2_)
            {
               return AnimeConstants.FACING_LEFT;
            }
            return AnimeConstants.FACING_UNKNOW;
         }
         if(this.isMotionShadow() && param1 != null)
         {
            _loc4_ = param1.x;
            if(param1.motionData && param1.motionData.path.length > 1)
            {
               _loc4_ = Point(param1.motionData.path[param1.motionData.path.length - 2]).x;
            }
            if(param1.motionDirection == AnimeConstants.MOTION_FORWARD)
            {
               return _loc2_ < _loc4_ ? AnimeConstants.FACING_LEFT : AnimeConstants.FACING_RIGHT;
            }
            return _loc4_ < _loc2_ ? AnimeConstants.FACING_LEFT : AnimeConstants.FACING_RIGHT;
         }
         return AnimeConstants.FACING_UNKNOW;
      }
      
      public function hasMotion() : Boolean
      {
         if(this.motionShadow == null)
         {
            return false;
         }
         return true;
      }
      
      public function shouldHasMotion() : Boolean
      {
         if(Math.max(this._xs.length,this._ys.length,this._scaleXs.length,this._scaleYs.length,this._rotations.length) > 1)
         {
            return true;
         }
         return false;
      }
      
      public function addPropOnDragDrop(param1:DragEvent) : void
      {
         this.doDragDrop(param1);
      }
      
      function doDragDrop(param1:DragEvent) : void
      {
         var _loc4_:ICommand = null;
         var _loc2_:Object = param1.dragSource.dataForFormat("thumb");
         var _loc3_:String = "";
         if(param1.dragSource.hasFormat("colorSetId"))
         {
            _loc3_ = String(param1.dragSource.dataForFormat("colorSetId"));
         }
         if(PropThumb(_loc2_).id.split(".")[0] == this.thumb.id)
         {
            this.removeHead();
            if(this._motionShadowChar != null)
            {
               this._motionShadowChar.removeHead();
            }
         }
         else if(!(PropThumb(_loc2_).headable && this.thumb.isCC))
         {
            if(!this.isMotionShadow())
            {
               (_loc4_ = new AddPropCommand()).execute();
            }
            this.autoStateModify(_loc2_ as PropThumb,null,_loc3_);
         }
      }
      
      private function prepareAddPropAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:PropThumb = _loc3_[1] as PropThumb;
         var _loc6_:State = _loc3_[2] as State;
         var _loc7_:String = _loc3_[3] as String;
         this.prepareAddProp(_loc5_,_loc6_,_loc7_);
      }
      
      private function prepareAddProp(param1:PropThumb, param2:State = null, param3:String = "") : void
      {
         var _loc4_:Array = null;
         var _loc5_:UtilLoadMgr = new UtilLoadMgr();
         (_loc4_ = new Array()).push(null);
         _loc4_.push(param1);
         _loc4_.push(param2);
         _loc4_.push(param3);
         _loc5_.setExtraData(_loc4_);
         if(param1.states.length == 0)
         {
            if(PropThumb(param1).isThumbReady())
            {
               this.doCheckBeforeAddProp(param1,null,param3);
            }
            else
            {
               _loc5_.addEventDispatcher(param1.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
               _loc5_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.prepareAddPropAgain);
               _loc5_.commit();
               param1.loadImageData();
            }
         }
         else
         {
            if(param2 == null)
            {
               param2 = PropThumb(param1).defaultState;
            }
            if(PropThumb(param1).isStateReady(param2))
            {
               this.doCheckBeforeAddProp(param1,param2,param3);
            }
            else
            {
               _loc5_.addEventDispatcher(param1.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
               _loc5_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.prepareAddPropAgain);
               _loc5_.commit();
               param1.loadState(param2);
            }
         }
      }
      
      private function getAutoState(param1:Thumb, param2:Thumb, param3:String) : State
      {
         var _loc4_:State = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         if(UtilArray.hasMatchingElement(PropThumb(param1).sysTags,PropThumb(param2).sysTags))
         {
            _loc5_ = 0;
            while(_loc5_ < PropThumb(param2).states.length)
            {
               if((_loc6_ = UtilXmlInfo.getSuffixFromStateIdByThumbId(param2.id,State(PropThumb(param2).states[_loc5_]).id)) == param3)
               {
                  _loc4_ = State(PropThumb(param2).states[_loc5_]);
                  break;
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      private function autoStateModify(param1:PropThumb, param2:State = null, param3:String = "") : void
      {
         var _loc6_:State = null;
         var _loc7_:String = null;
         var _loc4_:PropThumb = param1;
         var _loc5_:State = param2;
         if(this.prop != null && PropThumb(this.prop.thumb).states.length > 0 && PropThumb(param1).states.length > 0)
         {
            _loc7_ = UtilXmlInfo.getSuffixFromStateIdByThumbId(this.prop.thumb.id,this.prop.state.id);
            if(this.prop.state != null && this.prop.state.id != "")
            {
               _loc6_ = this.getAutoState(Thumb(this.prop.thumb),param1,_loc7_);
            }
         }
         this.prepareAddProp(_loc4_,!!_loc6_ ? _loc6_ : _loc5_,param3);
      }
      
      private function exchangeProp() : void
      {
      }
      
      private function doCheckBeforeAddProp(param1:Object, param2:State = null, param3:String = "") : void
      {
         var _loc6_:AnimeScene = null;
         var _loc7_:int = 0;
         var _loc8_:Character = null;
         var _loc9_:GoAlert = null;
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < Console.getConsole().scenes.length)
         {
            _loc6_ = Console.getConsole().getScene(_loc5_);
            _loc7_ = 0;
            while(_loc7_ < _loc6_.characters.length)
            {
               if((_loc8_ = Character(_loc6_.characters.getValueByIndex(_loc7_))).thumb.id == this.thumb.id)
               {
                  if(_loc8_.customColor.isIdentical(this.customColor))
                  {
                     _loc4_.push(_loc8_);
                  }
               }
               _loc7_++;
            }
            _loc5_++;
         }
         if(Console.getConsole().studioType == Console.FULL_STUDIO || Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            if(_loc4_.length > 1)
            {
               (_loc9_ = GoAlert(PopUpManager.createPopUp(getSceneCanvas(),GoAlert,true)))._lblConfirm.text = "";
               _loc9_._txtDelete.text = UtilDict.toDisplay("go","goalert_foundsamechar");
               _loc9_._btnDelete.label = UtilDict.toDisplay("go","goalert_addtoall");
               _loc9_._btnDelete.data = new Array(_loc4_,param1,param2,param3);
               _loc9_._btnDelete.addEventListener(MouseEvent.CLICK,this.addProptoAll);
               _loc9_._btnCancel.label = UtilDict.toDisplay("go","goalert_thisoneonly");
               _loc9_._btnCancel.data = new Array(param1,param2,param3);
               _loc9_._btnCancel.addEventListener(MouseEvent.CLICK,this.addProptoOne);
               _loc9_.x = (_loc9_.stage.width - _loc9_.width) / 2;
               _loc9_.y = 100;
            }
            else
            {
               this.addPropByThumb(param1,param2,param3);
            }
         }
         else
         {
            this.addProptoAllByPara(_loc4_,param1,param2,param3);
         }
      }
      
      private function addProptoOne(param1:MouseEvent) : void
      {
         var _loc2_:Object = Button(param1.target).data[0] as Object;
         var _loc3_:State = Button(param1.target).data[1] as State;
         var _loc4_:String = Button(param1.target).data[2] as String;
         this.addPropByThumb(_loc2_,_loc3_,_loc4_);
      }
      
      private function addProptoAllByPara(param1:Array, param2:Object, param3:State, param4:String) : void
      {
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            Character(param1[_loc5_]).addPropByThumb(param2,param3,param4);
            _loc5_++;
         }
      }
      
      private function addProptoAll(param1:MouseEvent) : void
      {
         var _loc2_:Array = Button(param1.target).data[0] as Array;
         var _loc3_:Object = Button(param1.target).data[1] as Object;
         var _loc4_:State = Button(param1.target).data[2] as State;
         var _loc5_:String = Button(param1.target).data[3] as String;
         this.addProptoAllByPara(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      public function updatePropState(param1:Thumb, param2:State) : void
      {
         this.addPropByThumb(param1,param2,"");
      }
      
      private function addPropByThumb(param1:Object, param2:State, param3:String = "") : void
      {
         var newProp:Prop = null;
         var i:int = 0;
         var customColor:UtilHashSelectedColor = null;
         var onAddedPropSoundHandler:Function = null;
         var onAddedHeadSoundHandler:Function = null;
         var onAddedWearSoundHandler:Function = null;
         var thumb:Object = param1;
         var state:State = param2;
         var colorSetId:String = param3;
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.addPropByThumb(thumb,state,colorSetId);
         }
         newProp = new Prop();
         if(thumb is PropThumb)
         {
            if(PropThumb(thumb).holdable == true)
            {
               if(this.imageObject is ICharacter && ICharacter(this.imageObject).ver >= 2)
               {
                  if(PropThumb(thumb).handStyle != "")
                  {
                     newProp.init(PropThumb(thumb),this);
                     this.prop = newProp;
                     if(state != null)
                     {
                        newProp.state = state;
                     }
                     else if(PropThumb(thumb).states.length > 0)
                     {
                        newProp.state = PropThumb(thumb).defaultState;
                     }
                     ICharacter(this.imageObject).CCM.addEventListener(ByteLoaderEvent.LOAD_BYTES_COMPLETE,this.onLoadThumbForCcComplete);
                     ICharacter(this.imageObject).CCM.loadPropThumbAsStyle(newProp.state == null ? newProp.imageData : newProp.state.imageData,PropThumb(thumb).handStyle);
                  }
               }
               else
               {
                  onAddedPropSoundHandler = function(param1:Event):void
                  {
                     if(Console.getConsole().soundMute == false)
                     {
                        newProp.playMusic();
                     }
                     newProp.removeEventListener("SoundAdded",onAddedPropSoundHandler);
                  };
                  newProp.addEventListener("SoundAdded",onAddedPropSoundHandler);
                  newProp.init(PropThumb(thumb),this);
                  if(state != null)
                  {
                     newProp.state = state;
                  }
                  else if(PropThumb(thumb).states.length > 0)
                  {
                     newProp.state = PropThumb(thumb).defaultState;
                  }
                  if(colorSetId != "")
                  {
                     newProp.defaultColorSetId = colorSetId;
                     newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                     customColor = newProp.defaultColorSet;
                     i = 0;
                     while(i < customColor.length)
                     {
                        addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                        i++;
                     }
                  }
                  this.addPropDataAndClip(newProp);
                  this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
               }
               this.dispatchEvent(new CharacterAssetEvent(CharacterAssetEvent.HANDHELD_CHANGE,this));
            }
            else if(PropThumb(thumb).headable == true)
            {
               newProp = new Prop();
               onAddedHeadSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedHeadSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedHeadSoundHandler);
               newProp.init(PropThumb(thumb),this);
               newProp.lookAtCamera = this.lookAtCamera;
               newProp.demoSpeech = this.demoSpeech;
               if(state != null)
               {
                  newProp.state = state;
               }
               else if(PropThumb(thumb).states.length > 0)
               {
                  newProp.state = PropThumb(thumb).defaultState;
               }
               if(colorSetId != "")
               {
                  newProp.defaultColorSetId = colorSetId;
                  newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                  customColor = newProp.defaultColorSet;
                  i = 0;
                  while(i < customColor.length)
                  {
                     addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                     i++;
                  }
               }
               this.addHeadDataAndClip(newProp);
               this.head.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
               this.dispatchEvent(new CharacterAssetEvent(CharacterAssetEvent.FACIAL_CHANGE,this));
            }
            else if(PropThumb(thumb).wearable == true)
            {
               newProp = new Prop();
               onAddedWearSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedWearSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedWearSoundHandler);
               newProp.init(PropThumb(thumb),this);
               if(state != null)
               {
                  newProp.state = state;
               }
               else if(PropThumb(thumb).states.length > 0)
               {
                  newProp.state = PropThumb(thumb).defaultState;
               }
               if(colorSetId != "")
               {
                  newProp.defaultColorSetId = colorSetId;
                  newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                  customColor = newProp.defaultColorSet;
                  i = 0;
                  while(i < customColor.length)
                  {
                     addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                     i++;
                  }
               }
               this.addWearDataAndClip(newProp);
               this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
               this.dispatchEvent(new CharacterAssetEvent(CharacterAssetEvent.WEAR_CHANGE,this));
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.ACTION_CHANGE));
         }
      }
      
      private function onLoadThumbForCcComplete(param1:Event) : void
      {
         var e:Event = param1;
         try
         {
            ICharacter(this.imageObject).insertColor(this.customColor);
            ICharacter(this.imageObject).addLibrary(AnimeConstants.CLASS_GOPROP,"","");
            ICharacter(this.imageObject).reloadSkin();
         }
         catch(e:Error)
         {
         }
      }
      
      function addHeadDataAndClip(param1:Prop) : void
      {
         if(this.head != null)
         {
            this.head.stopMusic(true);
            this.removeHead();
         }
         this.head = param1;
      }
      
      function addWearDataAndClip(param1:Prop) : void
      {
         if(this.wear != null)
         {
            this.wear.stopMusic(true);
            this.removeWear();
         }
         this.wear = param1;
         this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
      }
      
      function addPropDataAndClip(param1:Prop) : void
      {
         if(this.prop != null)
         {
            this.prop.stopMusic(true);
            this.removeProp();
         }
         this.prop = param1;
      }
      
      private function removeHead() : void
      {
         if(this.head == null)
         {
            return;
         }
         this.head = null;
         if(this.wear != null)
         {
            this.refreshProp();
         }
         this.dispatchEvent(new CharacterAssetEvent(CharacterAssetEvent.FACIAL_CHANGE,this));
      }
      
      private function removeWear() : void
      {
         if(this.wear == null)
         {
            return;
         }
         this.wear = null;
      }
      
      public function removeProp() : void
      {
         if(this.prop == null)
         {
            return;
         }
         this.prop = null;
      }
      
      override public function cloneNext() : Asset
      {
         var _loc1_:Character = this.clone() as Character;
         if(_loc1_.motionShadow)
         {
            _loc1_.x = _loc1_.motionShadow.x;
            _loc1_.y = _loc1_.motionShadow.y;
            _loc1_.facing = _loc1_.motionShadow.facing;
            _loc1_.scaleX = _loc1_.motionShadow.scaleX;
            _loc1_.scaleY = _loc1_.motionShadow.scaleY;
            _loc1_.rotation = _loc1_.motionShadow.rotation;
            _loc1_.setReferencePoint(_loc1_.motionShadow.referenceX,_loc1_.motionShadow.referenceY);
            _loc1_.removeSlideMotion();
         }
         if(Action(_loc1_.action).isMotion)
         {
            _loc1_.setAction(!!Action(_loc1_.action).nextActionId ? Action(_loc1_.action).nextActionId : Action(_loc1_.action).defaultActionId,true);
         }
         if(this.scene.isCharacterTalkingWithLinkage(_loc1_))
         {
            _loc1_.restoreActionFromTalk();
         }
         _loc1_.updateColor();
         return _loc1_;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var newProp:Prop = null;
         var onAddedPropSoundHandler:Function = null;
         var onAddedHeadSoundHandler:Function = null;
         var onAddedWearSoundHandler:Function = null;
         var addSceneFlag:Boolean = param1;
         var targetScene:AnimeScene = param2;
         var char:Character = new Character();
         char.id = this.id;
         char.scene = !!targetScene ? targetScene : this.scene;
         char.thumb = this.thumb;
         char.customColor = this.customColor.clone();
         char.defaultColorSet = this.defaultColorSet.clone();
         char.x = this.x;
         char.y = this.y;
         char.width = this.width;
         char.height = this.height;
         char.facing = this.facing;
         char.scaleX = this.scaleX;
         char.scaleY = this.scaleY;
         char.rotation = this.rotation;
         char.actionId = this.actionId;
         char.action = this.action;
         char.motion = this.motion;
         char.lookAtCamera = this.lookAtCamera;
         char.setReferencePoint(this.referenceX,this.referenceY);
         if(this.actionSequence)
         {
            char.actionSequence = this.actionSequence.clone();
         }
         if(this.prop != null)
         {
            newProp = new Prop();
            if(addSceneFlag)
            {
               onAddedPropSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedPropSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedPropSoundHandler);
            }
            newProp.init(PropThumb(this.prop.thumb),char);
            newProp.state = this.prop.state;
            newProp.capScreenLock = this.capScreenLock;
            char.addPropDataAndClip(newProp);
         }
         else
         {
            char.prop = null;
         }
         char._loadCount = 0;
         if(this.head != null)
         {
            newProp = new Prop();
            if(addSceneFlag)
            {
               onAddedHeadSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedHeadSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedHeadSoundHandler);
            }
            newProp.init(PropThumb(this.head.thumb),char);
            newProp.state = this.head.state;
            newProp.capScreenLock = this.capScreenLock;
            ++char._loadTotal;
            char.addHeadDataAndClip(newProp);
            newProp.lookAtCamera = this.lookAtCamera;
            newProp.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,char.refreshProp);
         }
         else
         {
            char.head = null;
         }
         if(this.wear != null)
         {
            newProp = new Prop();
            if(addSceneFlag)
            {
               onAddedWearSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedWearSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedWearSoundHandler);
            }
            newProp.init(PropThumb(this.wear.thumb),char);
            newProp.state = this.wear.state;
            newProp.capScreenLock = this.capScreenLock;
            ++char._loadTotal;
            char.addWearDataAndClip(newProp);
            newProp.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,char.refreshProp);
         }
         else
         {
            char.wear = null;
         }
         char.speechVoice = this.speechVoice;
         if(this.motionData)
         {
            char.motionData = this.motionData.clone();
         }
         if(this.motionShadow)
         {
            char.motionShadow = this.motionShadow.clone() as Character;
         }
         return char;
      }
      
      override public function unloadAssetImage(param1:Boolean) : void
      {
         super.unloadAssetImage(param1);
         if(this.prop)
         {
            this.prop.unloadAssetImage(param1);
         }
         if(this.head)
         {
            this.head.unloadAssetImage(param1);
         }
         if(this.wear)
         {
            this.wear.unloadAssetImage(param1);
         }
      }
      
      private function clipEnterFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = null;
         if(this._actionSeq)
         {
            if(param1.currentTarget is MovieClip)
            {
               _loc2_ = MovieClip(param1.currentTarget);
               if(_loc2_ && this._actionSeq.shouldChangeSubAction(_loc2_.currentFrame))
               {
                  _loc2_.gotoAndPlay(this._actionSeq.getNextSubActionStartFrame(_loc2_.currentFrame));
               }
            }
         }
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:PropThumb = null;
         var _loc9_:State = null;
         var _loc10_:UtilLoadMgr = null;
         var _loc11_:Array = null;
         var _loc12_:* = false;
         var _loc13_:PropThumb = null;
         var _loc14_:Theme = null;
         var _loc15_:XML = null;
         var _loc16_:XML = null;
         var _loc17_:String = null;
         var _loc18_:State = null;
         var _loc19_:String = null;
         var _loc20_:CharThumb = null;
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(Action(this.action).propXML.length > 0)
         {
            _loc2_ = true;
            _loc3_ = Action(this.action).propXML[0];
         }
         else if(CharThumb(this.thumb).propXML.length > 0)
         {
            _loc2_ = true;
            _loc3_ = CharThumb(this.thumb).propXML[0];
         }
         if(_loc2_ && (this._byMenu || this._fromTray || this._byMovement))
         {
            _loc5_ = (_loc4_ = _loc3_.@theme.length() > 0 ? _loc3_.@theme : this.thumb.theme.id) + "." + _loc3_.@id;
            _loc6_ = UtilXmlInfo.getThumbIdFromFileName(_loc5_);
            _loc7_ = _loc5_.split(".").length != 4 ? _loc6_ : UtilXmlInfo.getCharIdFromFileName(_loc5_);
            if(!(_loc8_ = Theme(ThemeManager.instance.getTheme(_loc4_)).getPropThumbById(_loc7_) as PropThumb))
            {
               _loc13_ = new PropThumb();
               _loc15_ = (_loc14_ = ThemeManager.instance.getTheme(_loc4_)).getThemeXML();
               for each(_loc16_ in _loc15_.child(PropThumb.XML_NODE_NAME))
               {
                  if(_loc16_.@aid == _loc3_.@aid)
                  {
                     _loc13_.deSerialize(_loc16_,_loc14_);
                     _loc13_.xml = _loc16_;
                  }
               }
               if(_loc6_ != _loc7_)
               {
                  _loc13_.thumbId = _loc6_;
               }
               Theme(this.thumb.theme).addThumb(_loc13_);
               _loc8_ = Theme(Thumb(this.thumb).theme).getPropThumbById(_loc7_) as PropThumb;
            }
            _loc12_ = this.prop != null;
            if(_loc8_)
            {
               if(_loc6_ != _loc7_)
               {
                  _loc9_ = _loc8_.getStateById(_loc6_);
               }
               if(_loc9_ != null)
               {
                  if(_loc12_)
                  {
                     _loc17_ = UtilXmlInfo.getSuffixFromStateIdByThumbId(_loc8_.id,_loc9_.id);
                     if(_loc18_ = this.getAutoState(_loc8_,this.prop.thumb as Thumb,_loc17_))
                     {
                        this.doAddPropByState(null,PropThumb(this.prop.thumb),_loc18_);
                        _loc1_ = true;
                     }
                  }
                  else
                  {
                     this.doAddPropByState(null,_loc8_,_loc9_);
                     _loc1_ = true;
                  }
               }
               else if(!_loc12_)
               {
                  if(_loc8_.isThumbReady())
                  {
                     this.addPropByThumb(_loc8_,_loc9_);
                  }
                  else
                  {
                     _loc10_ = new UtilLoadMgr();
                     (_loc11_ = new Array()).push(null);
                     _loc11_.push(_loc8_);
                     _loc10_.setExtraData(_loc11_);
                     _loc10_.addEventDispatcher(_loc8_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                     _loc10_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedActionPropAgain);
                     _loc10_.commit();
                     _loc8_.loadImageData();
                  }
                  _loc1_ = true;
               }
            }
         }
         this._byMovement = false;
         this._byMenu = false;
         this._fromTray = false;
         if(this.prop != null && !_loc1_)
         {
            this.addPropByThumb(this.prop.thumb,this.prop.state);
         }
         if(CharThumb(this.thumb).mThumbId)
         {
            _loc19_ = CharThumb(this.thumb).mThumbId;
            if((_loc20_ = Theme(CharThumb(this.thumb).theme).getCharThumbById(_loc19_)) && _loc20_.path)
            {
               CharThumb(this.thumb).propXML = new Vector.<XML>();
            }
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      private function doAddPropByState(param1:Loader, param2:PropThumb, param3:State) : void
      {
         var _loc4_:Array = null;
         var _loc5_:UtilLoadMgr = null;
         if(param2.isStateReady(param3))
         {
            this.addPropByThumb(param2,param3);
         }
         else
         {
            _loc5_ = new UtilLoadMgr();
            (_loc4_ = new Array()).push(param1);
            _loc4_.push(param2);
            _loc4_.push(param3);
            _loc5_.setExtraData(_loc4_);
            _loc5_.addEventDispatcher(param2.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc5_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedActionPropAgain);
            _loc5_.commit();
            param2.loadState(param3);
         }
      }
      
      private function feedActionPropAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:PropThumb = _loc3_[1] as PropThumb;
         var _loc6_:State = _loc3_[2] as State;
         this.addPropByThumb(_loc5_,_loc6_);
      }
      
      public function dropDefaultActionProp() : void
      {
         var _loc1_:XML = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:PropThumb = null;
         if(this.action != null)
         {
            if(Action(this.action).propXML.length > 0)
            {
               _loc1_ = Action(this.action).propXML[0];
               _loc2_ = _loc1_.@theme.length() > 0 ? _loc1_.@theme : this.thumb.theme.id;
               _loc3_ = _loc2_ + "." + Action(this.action).propXML[0].@id;
               _loc4_ = UtilXmlInfo.getThumbIdFromFileName(_loc3_);
               _loc5_ = _loc3_.split(".").length != 4 ? _loc4_ : UtilXmlInfo.getCharIdFromFileName(_loc3_);
               _loc6_ = ThemeManager.instance.getTheme(_loc2_).getPropThumbById(_loc5_) as PropThumb;
               if(this.prop != null && _loc6_ == this.prop.thumb)
               {
                  if(this.prop.stateId == null || _loc4_ == this.prop.stateId)
                  {
                     this.removeProp();
                  }
               }
               else if(this.head != null && _loc6_ == this.head.thumb)
               {
                  if(this.head.stateId == null || _loc4_ == this.head.stateId)
                  {
                     this.removeHead();
                  }
               }
               else if(this.wear != null && _loc6_ == this.wear.thumb)
               {
                  if(this.wear.stateId == null || _loc4_ == this.wear.stateId)
                  {
                     this.removeWear();
                  }
               }
            }
         }
      }
      
      public function isMotionShadow() : Boolean
      {
         return this._isShadow;
      }
      
      public function set isShadow(param1:Boolean) : void
      {
         this._isShadow = param1;
      }
      
      private function getCharToBundleBounds() : Rectangle
      {
         return new Rectangle();
      }
      
      private function refreshProp(... rest) : void
      {
      }
      
      private function refreshControl(... rest) : void
      {
      }
      
      private function getCategoryMenuXml(param1:XML) : XML
      {
         var menuParentNode:XML = null;
         var label:String = null;
         var id:String = null;
         var toggled:String = null;
         var type:String = null;
         var itemType:String = null;
         var xmlc:XMLListCollection = null;
         var node:XML = param1;
         var xmlMenu:XML = <menu></menu>;
         var actionNode:XML = new XML();
         var motionNode:XML = new XML();
         var groupNode:XML = new XML();
         var menuNode:XML = new XML();
         var catNode:XML = new XML();
         var menuParentNode2:XML = new XML();
         var useLowerCase:Boolean = UtilLicense.isActionNameNeedLowerCase();
         var nameSort:Sort = new Sort();
         if(node..action.(@enable != "N").length() > 0 || node..motion.(@enable != "N").length() > 0)
         {
            menuParentNode = <item label="{UtilString.firstLetterToUpperCase(UtilDict.toDisplay("go",node.@name))}"></item>;
            for each(catNode in node.category)
            {
               if(catNode.@enable != "N")
               {
                  menuNode = this.getCategoryMenuXml(catNode);
                  if(menuNode)
                  {
                     menuParentNode.appendChild(menuNode);
                  }
               }
            }
            for each(actionNode in node.action)
            {
               if(actionNode.@enable != "N")
               {
                  label = actionNode.@name;
                  label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                  label = !!useLowerCase ? label.toLocaleLowerCase() : label;
                  id = actionNode.@id;
                  toggled = id == this.action.id ? "true" : "false";
                  itemType = "action";
                  menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                  menuParentNode.appendChild(menuNode);
               }
            }
            for each(groupNode in node.group)
            {
               itemType = XML(groupNode.children()[0]).name().toString();
               if(itemType == "action" && groupNode.action.(@enable != "N").length() > 0)
               {
                  label = groupNode.@name;
                  label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                  label = !!useLowerCase ? label.toLocaleLowerCase() : label;
                  id = groupNode.children().(@name == "1").@id;
                  toggled = "false";
                  for each(actionNode in groupNode.children())
                  {
                     if(actionNode.@id == this.action.id)
                     {
                        toggled = "true";
                     }
                  }
                  menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                  menuParentNode.appendChild(menuNode);
               }
            }
            xmlc = new XMLListCollection(menuParentNode.children());
            nameSort.fields = [new SortField("@label",true)];
            xmlc.sort = nameSort;
            xmlc.refresh();
            menuParentNode.setChildren(xmlc.copy());
            if(node.motion.(@enable != "N").length() > 0 || node.group.motion.(@enable != "N").length() > 0)
            {
               menuParentNode2 = <item label="{UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT)}"></item>;
               menuParentNode.prependChild(menuParentNode2);
               for each(motionNode in node.motion)
               {
                  if(motionNode.@enable == "Y")
                  {
                     label = motionNode.@name;
                     label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                     label = !!useLowerCase ? label.toLocaleLowerCase() : label;
                     id = motionNode.@id;
                     toggled = id == this.action.id ? "true" : "false";
                     itemType = "motion";
                     menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                     menuParentNode2.appendChild(menuNode);
                  }
               }
               for each(groupNode in node.group)
               {
                  itemType = XML(groupNode.children()[0]).name().toString();
                  if(itemType == "motion" && groupNode.motion.(@enable != "N").length() > 0)
                  {
                     label = groupNode.@name;
                     label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                     label = !!useLowerCase ? label.toLocaleLowerCase() : label;
                     id = groupNode.children().(@name == "1").@id;
                     toggled = "false";
                     for each(actionNode in groupNode.children())
                     {
                        if(actionNode.@id == this.action.id)
                        {
                           toggled = "true";
                        }
                     }
                     menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                     menuParentNode2.appendChild(menuNode);
                  }
               }
               xmlc = new XMLListCollection(menuParentNode2.children());
               nameSort = new Sort();
               nameSort.fields = [new SortField("@label",true)];
               xmlc.sort = nameSort;
               xmlc.refresh();
               menuParentNode2.setChildren(xmlc.copy());
            }
         }
         return menuParentNode;
      }
      
      public function get actionMenu() : ScrollableArrowMenu
      {
         var node:XML = null;
         var xmlMenu:XML = null;
         var actionNode:XML = null;
         var motionNode:XML = null;
         var groupNode:XML = null;
         var menuNode:XML = null;
         var menuParentNode:XML = null;
         var menuParentNode2:XML = null;
         var label:String = null;
         var id:String = null;
         var toggled:String = null;
         var type:String = null;
         var itemType:String = null;
         var useLowerCase:Boolean = false;
         var menu:ScrollableArrowMenu = null;
         var xmlChar:XML = CharThumb(this.thumb).xml;
         var xmlc:XMLListCollection = new XMLListCollection(xmlChar.children());
         var nameSort:Sort = new Sort();
         nameSort.fields = [new SortField("@name",true)];
         xmlc.sort = nameSort;
         xmlc.refresh();
         xmlChar.setChildren(xmlc.copy());
         for each(node in xmlChar.category)
         {
            xmlc = new XMLListCollection(node.children());
            xmlc.sort = nameSort;
            xmlc.refresh();
            node.setChildren(xmlc.copy());
         }
         xmlMenu = <menu></menu>;
         actionNode = new XML();
         motionNode = new XML();
         groupNode = new XML();
         menuNode = new XML();
         menuParentNode = new XML();
         menuParentNode2 = new XML();
         useLowerCase = UtilLicense.isActionNameNeedLowerCase();
         if(xmlChar.motion.(@enable != "N").length() > 0)
         {
            menuParentNode = <item label="{UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT)}"></item>;
            for each(node in xmlChar.motion)
            {
               if(node.@enable != "N")
               {
                  label = node.@name;
                  label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                  label = !!useLowerCase ? label.toLocaleLowerCase() : label;
                  id = node.@id;
                  toggled = id == this.action.id ? "true" : "false";
                  itemType = "motion";
                  menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                  menuParentNode.appendChild(menuNode);
               }
            }
            xmlMenu.appendChild(menuParentNode);
         }
         for each(node in xmlChar.category)
         {
            menuParentNode = this.getCategoryMenuXml(node);
            if(menuParentNode)
            {
               xmlMenu.appendChild(menuParentNode);
            }
         }
         if(FeatureManager.shouldActionPackBeShown && !Console.getConsole().isTutorialOn)
         {
            if(CharThumb(this.thumb).ccThemeId == "cc2" || CharThumb(this.thumb).ccThemeId == ThemeConstants.CHIBI_THEME_ID || CharThumb(this.thumb).ccThemeId == ThemeConstants.NINJA_THEME_ID || CharThumb(this.thumb).ccThemeId == ThemeConstants.ANIME_THEME_ID || CharThumb(this.thumb).ccThemeId == ThemeConstants.NINJAANIME_THEME_ID || CharThumb(this.thumb).ccThemeId == ThemeConstants.SPACE_CITIZEN_THEME_ID || CharThumb(this.thumb).ccThemeId == ThemeConstants.BOTDF_THEME_ID || CharThumb(this.thumb).ccThemeId == ThemeConstants.BUSINESS_THEME_ID)
            {
               xmlMenu.appendChild(<item label="{"+ " + UtilString.firstLetterToUpperCase(UtilDict.toDisplay("go","Learn New Actions"))}" itemType='learn'></item>);
            }
         }
         if(xmlMenu.children().length() > 0)
         {
            xmlMenu.appendChild(<item type='separator'></item>);
         }
         for each(node in xmlChar.action)
         {
            if(node.@enable != "N")
            {
               label = node.@name;
               label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
               label = !!useLowerCase ? label.toLocaleLowerCase() : label;
               id = node.@id;
               toggled = id == this.action.id ? "true" : "false";
               itemType = "action";
               menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
               xmlMenu.appendChild(menuNode);
            }
         }
         for each(node in xmlChar.group)
         {
            itemType = XML(node.children()[0]).name().toString();
            if(itemType == "action" && node.action.(@enable != "N").length() > 0)
            {
               label = node.@name;
               label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
               label = !!useLowerCase ? label.toLocaleLowerCase() : label;
               id = node.children().(@name == "1").@id;
               toggled = "false";
               for each(actionNode in node.children())
               {
                  if(actionNode.@id == this.action.id)
                  {
                     toggled = "true";
                  }
               }
               itemType = XML(node.children()[0]).name().toString();
               menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
               xmlMenu.appendChild(menuNode);
            }
         }
         menu = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),xmlMenu,false);
         menu.labelField = "@label";
         menu.addEventListener(MenuEvent.ITEM_CLICK,this.onActionMenuClick);
         menu.verticalScrollPolicy = ScrollPolicy.OFF;
         menu.arrowScrollPolicy = ScrollPolicy.AUTO;
         menu.maxHeight = 300;
         menu.minWidth = 200;
         menu.showRoot = false;
         return menu;
      }
      
      public function onVariationClick(param1:String) : void
      {
         this._byMenu = true;
         this.setAction(param1);
      }
      
      private function onActionMenuClick(param1:MenuEvent) : void
      {
         this._byMenu = true;
         var _loc2_:ICommand = new ChangeActionCommand();
         if(param1.item.@itemType == "action")
         {
            _loc2_.execute();
            this.removeSlideMotion();
            this.setAction(param1.item.@id);
         }
         else if(param1.item.@itemType == "motion")
         {
            _loc2_.execute();
            this.startSlideMotion();
            this.setAction(param1.item.@id);
         }
         else if(param1.item.@itemType == "learn")
         {
            Console.getConsole().showActionShopWindow(Thumb(this.thumb).id,Thumb(this.thumb));
         }
      }
      
      public function get facialMenu() : ScrollableArrowMenu
      {
         var node:XML = null;
         var xmlMenu:XML = null;
         var facialNode:XML = null;
         var menuNode:XML = null;
         var menuParentNode:XML = null;
         var menuParentNode2:XML = null;
         var label:String = null;
         var id:String = null;
         var toggled:String = null;
         var type:String = null;
         var itemType:String = null;
         var useLowerCase:Boolean = false;
         var xmlChar:XML = CharThumb(this.thumb).xml;
         var xmlc:XMLListCollection = new XMLListCollection(xmlChar.children());
         var nameSort:Sort = new Sort();
         nameSort.fields = [new SortField("@name",true)];
         xmlc.sort = nameSort;
         xmlc.refresh();
         xmlChar.setChildren(xmlc.copy());
         for each(node in xmlChar.category)
         {
            xmlc = new XMLListCollection(node.children());
            xmlc.sort = nameSort;
            xmlc.refresh();
            node.setChildren(xmlc.copy());
         }
         xmlMenu = <menu></menu>;
         facialNode = new XML();
         menuNode = new XML();
         menuParentNode = new XML();
         menuParentNode2 = new XML();
         useLowerCase = UtilLicense.isActionNameNeedLowerCase();
         for each(node in xmlChar.category)
         {
            if(node..facial.(@enable != "N").length() > 0)
            {
               menuParentNode = <item label="{UtilString.firstLetterToUpperCase(UtilDict.toDisplay("go",node.@name))}"></item>;
               xmlMenu.appendChild(menuParentNode);
               for each(facialNode in node.facial)
               {
                  if(facialNode.@enable != "N")
                  {
                     label = facialNode.@name;
                     label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                     label = !!useLowerCase ? label.toLocaleLowerCase() : label;
                     id = facialNode.@id;
                     toggled = "false";
                     if(this.head && id == this.head.stateId)
                     {
                        toggled = "true";
                     }
                     itemType = MENU_ITEM_TYPE_FACIAL_TAG;
                     menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                     menuParentNode.appendChild(menuNode);
                  }
               }
               xmlc = new XMLListCollection(menuParentNode.children());
               nameSort.fields = [new SortField("@label",true)];
               xmlc.sort = nameSort;
               xmlc.refresh();
               menuParentNode.setChildren(xmlc.copy());
            }
         }
         for each(node in xmlChar.facial)
         {
            if(node.@enable != "N")
            {
               label = node.@name;
               label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
               label = !!useLowerCase ? label.toLocaleLowerCase() : label;
               id = node.@id;
               toggled = id == this.action.id ? "true" : "false";
               itemType = MENU_ITEM_TYPE_FACIAL_TAG;
               menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
               xmlMenu.appendChild(menuNode);
            }
         }
         label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("go",MENU_ITEM_DEFAULT));
         label = !!useLowerCase ? label.toLocaleLowerCase() : label;
         id = MENU_ITEM_DEFAULT;
         toggled = "false";
         itemType = MENU_ITEM_TYPE_FACIAL_TAG;
         menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
         xmlMenu.appendChild(menuNode);
         var menu:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),xmlMenu,false);
         menu.labelField = "@label";
         menu.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         menu.verticalScrollPolicy = ScrollPolicy.OFF;
         menu.arrowScrollPolicy = ScrollPolicy.AUTO;
         menu.maxHeight = 300;
         menu.minWidth = 200;
         menu.showRoot = false;
         return menu;
      }
      
      public function get handHeldMenu() : ScrollableArrowMenu
      {
         var _loc1_:* = null;
         var _loc2_:ScrollableArrowMenu = null;
         if(this.prop)
         {
            _loc1_ = "";
            _loc1_ = this.prop.buildStateMenu(_loc1_,false);
            if(_loc1_)
            {
               _loc1_ = "<menuRoot>" + _loc1_ + "</menuRoot>";
               _loc2_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),new XML(_loc1_),false);
               _loc2_.labelField = "@label";
               _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
               _loc2_.verticalScrollPolicy = ScrollPolicy.OFF;
               _loc2_.arrowScrollPolicy = ScrollPolicy.AUTO;
               _loc2_.minWidth = 150;
               _loc2_.maxHeight = 300;
               _loc2_.showRoot = false;
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get headGearMenu() : ScrollableArrowMenu
      {
         var _loc1_:* = null;
         var _loc2_:ScrollableArrowMenu = null;
         if(this.wear)
         {
            _loc1_ = "";
            _loc1_ = this.wear.buildStateMenu(_loc1_,false);
            if(_loc1_)
            {
               _loc1_ = "<menuRoot>" + _loc1_ + "</menuRoot>";
               _loc2_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),new XML(_loc1_),false);
               _loc2_.labelField = "@label";
               _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
               _loc2_.verticalScrollPolicy = ScrollPolicy.OFF;
               _loc2_.arrowScrollPolicy = ScrollPolicy.AUTO;
               _loc2_.minWidth = 150;
               _loc2_.maxHeight = 300;
               _loc2_.showRoot = false;
            }
            return _loc2_;
         }
         return null;
      }
      
      public function get headMenu() : ScrollableArrowMenu
      {
         var _loc1_:* = "<menuRoot>";
         if(this.head != null && this.head.thumb.id != this.thumb.id + ".head")
         {
            _loc1_ = this.head.buildStateMenu(_loc1_,false);
         }
         _loc1_ += "</menuRoot>";
         var _loc2_:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),new XML(_loc1_),false);
         _loc2_.labelField = "@label";
         _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         _loc2_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc2_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc2_.minWidth = 150;
         _loc2_.maxHeight = 300;
         _loc2_.showRoot = false;
         return _loc2_;
      }
      
      override public function doChangeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc3_:Number = super.doChangeColor(param1,param2);
         if(_loc3_ > 0)
         {
            if(this.motionShadow != null)
            {
               this.motionShadow.doChangeColor(param1,param2);
            }
         }
         return _loc3_;
      }
      
      public function flipIt() : void
      {
         this.facing = this.facing == AnimeConstants.FACING_LEFT ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
         if(this.motionShadow != null)
         {
            this.motionShadow.facing = this.motionShadow.facing == AnimeConstants.FACING_LEFT ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
            this.motionDirection = this.motionDirection == AnimeConstants.MOTION_BACKWARD ? AnimeConstants.MOTION_FORWARD : AnimeConstants.MOTION_BACKWARD;
         }
         this.refreshControl();
      }
      
      public function onPropChange() : void
      {
         this.dispatchEvent(new CharacterAssetEvent(CharacterAssetEvent.FACIAL_CHANGE,this));
         this.dispatchEvent(new CharacterAssetEvent(CharacterAssetEvent.HANDHELD_CHANGE,this));
      }
      
      private function doActionMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:ICommand = null;
         var _loc7_:String = null;
         var _loc3_:String = param1.item.@itemType;
         var _loc4_:String = param1.item.@direction;
         var _loc5_:String = param1.item.@id;
         var _loc6_:XML;
         if((_loc6_ = XML(param1.item)).attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_PROP_TAG)
         {
            if(_loc6_.attribute("value") == MENU_ITEM_PROP_REMOVE)
            {
               this.removeHandHeld();
            }
            else
            {
               this.prop.doChangeState(param1);
               if(this._motionShadowChar != null)
               {
                  this._motionShadowChar.prop.doChangeState(param1);
               }
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
         else if(_loc6_.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_HEAD_TAG)
         {
            if(_loc6_.attribute("value") == MENU_ITEM_HEAD_REMOVE)
            {
               this.restoreHead();
            }
            else
            {
               this.head.doChangeState(param1);
               if(this._motionShadowChar != null)
               {
                  this._motionShadowChar.head.doChangeState(param1);
               }
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
         else if(_loc6_.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_WEAR_TAG)
         {
            if(_loc6_.attribute("value") == MENU_ITEM_WEAR_REMOVE)
            {
               this.removeHeadGear();
            }
            else
            {
               this.wear.doChangeState(param1);
               if(this._motionShadowChar != null)
               {
                  this._motionShadowChar.wear.doChangeState(param1);
               }
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
         else if(_loc6_.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_FACIAL_TAG)
         {
            if(_loc6_.@id == MENU_ITEM_DEFAULT)
            {
               _loc2_ = new RemovePropCommand();
               _loc2_.execute();
               this.removeHead();
            }
            else
            {
               _loc2_ = new ChangeActionCommand();
               _loc2_.execute();
               _loc7_ = _loc6_.@id;
               this.changeHeadByStateId(_loc7_);
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
         else if(_loc6_.attribute(MENU_ITEM_TYPE_TAG) == UtilString.firstLetterToUpperCase("+ learn New Actions"))
         {
            Console.getConsole().showActionShopWindow(Thumb(this.thumb).id,Thumb(this.thumb));
         }
         Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_ACTION_CHANGED,this));
      }
      
      private function addTalkHeadForSpeech() : void
      {
         var _loc1_:PropThumb = null;
         if(this.head == null && this.thumb.raceCode == RaceConstants.STATIC_SWF)
         {
            if(Console.getConsole().linkageController.getSpeechIdOfAsset(this) != "")
            {
               if(this.action != null && Action(this.action).isTalkRelated())
               {
                  _loc1_ = this.getHeadPropThumb();
                  if(_loc1_ != null && _loc1_.defaultTalkState != null)
                  {
                     this.doAddPropByState(null,_loc1_,_loc1_.defaultTalkState);
                  }
               }
            }
         }
      }
      
      private function getHeadPropThumb() : PropThumb
      {
         var _loc1_:* = this.thumb.id + ".head";
         return Theme(Thumb(this.thumb).theme).getPropThumbById(_loc1_) as PropThumb;
      }
      
      private function changeHeadByStateId(param1:String) : void
      {
         var _loc3_:State = null;
         var _loc2_:PropThumb = this.getHeadPropThumb();
         if(_loc2_.getStateNum() > 0)
         {
            _loc3_ = _loc2_.getStateById(param1);
         }
         this.changeHeadByState(_loc3_);
      }
      
      private function changeHeadByState(param1:State) : void
      {
         var doAddFacialAgain:Function = null;
         var extraData:Object = null;
         var loadMgr:UtilLoadMgr = null;
         var state:State = param1;
         var propThumb:PropThumb = this.getHeadPropThumb();
         if(state.imageData != null)
         {
            this.addPropByThumb(propThumb,state);
         }
         else
         {
            doAddFacialAgain = function(param1:LoadMgrEvent):void
            {
               var _loc3_:Thumb = null;
               var _loc4_:State = null;
               var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
               var _loc5_:Object;
               _loc3_ = (_loc5_ = _loc2_.getExtraData())["thumb"];
               _loc4_ = _loc5_["state"];
               addPropByThumb(_loc3_,_loc4_);
            };
            extraData = new Object();
            extraData["thumb"] = propThumb;
            extraData["state"] = state;
            loadMgr = new UtilLoadMgr();
            loadMgr.setExtraData(extraData);
            loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,doAddFacialAgain);
            loadMgr.addEventDispatcher(propThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            propThumb.loadState(state);
            loadMgr.commit();
         }
      }
      
      public function removeHandHeld() : void
      {
         var _loc1_:ICommand = null;
         if(this.prop)
         {
            _loc1_ = new RemovePropCommand();
            _loc1_.execute();
            this.removeProp();
            if(this._motionShadowChar != null)
            {
               this._motionShadowChar.removeProp();
            }
            this.refreshControl();
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
            this.dispatchEvent(new CharacterAssetEvent(CharacterAssetEvent.HANDHELD_CHANGE,this));
         }
      }
      
      public function removeHeadGear() : void
      {
         var _loc1_:ICommand = new RemovePropCommand();
         _loc1_.execute();
         this.removeWear();
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.removeWear();
         }
         this.refreshControl();
         this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         this.dispatchEvent(new CharacterAssetEvent(CharacterAssetEvent.WEAR_CHANGE,this));
      }
      
      public function restoreHead() : void
      {
         var _loc1_:ICommand = new RemovePropCommand();
         _loc1_.execute();
         this.removeHead();
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.removeHead();
         }
         this.refreshControl();
         this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
      }
      
      public function removeSlideMotion() : void
      {
         if(this.isSliding)
         {
            this.updateTimelineMotion();
            this.motionShadow = null;
            if(this._motionData)
            {
               this._motionData.removeEventListener(Event.CHANGE,this.onMotionChange);
               this._motionData = null;
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      public function setAction(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:CharThumb = CharThumb(this.thumb);
         var _loc4_:Action;
         if((_loc4_ = _loc3_.getActionById(param1)) && this.imageData != null && this.imageData != _loc4_.imageData)
         {
            this._byMovement = param2;
            this.changeAction(_loc4_);
         }
      }
      
      private function changeAction(param1:Action) : void
      {
         var _loc3_:UtilLoadMgr = null;
         var _loc4_:Array = null;
         if(param1 is ISequentialAction)
         {
            this.actionSequence = ISequentialAction(param1).actionSequence.clone();
            this.actionSequence.randomize();
         }
         else
         {
            this.actionSequence = null;
         }
         this.dropDefaultActionProp();
         if(this._motionShadowChar)
         {
            this._motionShadowChar.dropDefaultActionProp();
         }
         var _loc2_:CharThumb = CharThumb(this.thumb);
         if(param1.imageData != null)
         {
            this.updateAction(param1);
         }
         else
         {
            _loc3_ = new UtilLoadMgr();
            (_loc4_ = new Array()).push(param1);
            _loc3_.setExtraData(_loc4_);
            _loc3_.addEventDispatcher(_loc2_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc3_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateActionAgain);
            _loc3_.commit();
            if(_loc2_.theme.id == "ugc" && _loc2_.isSWFCharacter())
            {
               _loc2_.loadActionsAndMotions();
            }
            else
            {
               _loc2_.loadAction(param1);
            }
         }
      }
      
      public function changeActionAsTalk() : Boolean
      {
         var _loc2_:PropThumb = null;
         var _loc1_:Boolean = false;
         if(this.action == CharThumb(this.thumb).defaultAction && this.hasTalkAction())
         {
            this.changeAction(CharThumb(this.thumb).defaultTalkAction);
            _loc1_ = true;
         }
         else if(this.head == null && this.hasTalkFacial())
         {
            _loc2_ = Theme(Thumb(this.thumb).theme).getPropThumbById(this.thumb.id + ".head") as PropThumb;
            this.changeHeadByState(_loc2_.defaultTalkState);
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function reloadAssetImage() : void
      {
         this.loadAssetImage();
         if(this.head)
         {
            this.head.reloadAssetImage();
         }
      }
      
      public function restoreActionFromTalk() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.action == CharThumb(this.thumb).defaultTalkAction)
         {
            this.changeAction(Action(CharThumb(this.thumb).defaultAction));
            _loc1_ = true;
         }
         if(this.head != null && this.head.state.isTalkRelated())
         {
            this.removeHead();
            _loc1_ = true;
         }
         if(!_loc1_)
         {
            if(this.demoSpeech)
            {
               this.demoSpeech = false;
               _loc1_ = true;
               this.loadAssetImage();
               if(this.head)
               {
                  this.head.reloadAssetImage();
               }
            }
         }
         return _loc1_;
      }
      
      public function hasTalkAction() : Boolean
      {
         return CharThumb(this.thumb).defaultTalkAction != null;
      }
      
      public function hasTalkFacial() : Boolean
      {
         var _loc1_:PropThumb = Theme(Thumb(this.thumb).theme).getPropThumbById(this.thumb.id + ".head") as PropThumb;
         if(_loc1_ != null)
         {
            return _loc1_.defaultTalkState != null;
         }
         return false;
      }
      
      public function isInDefaultTalkAction() : Boolean
      {
         return this.action == CharThumb(this.thumb).defaultTalkAction;
      }
      
      public function isInDefaultTalkFacial() : Boolean
      {
         var _loc1_:PropThumb = null;
         if(this.head != null)
         {
            _loc1_ = Theme(Thumb(this.thumb).theme).getPropThumbById(this.thumb.id + ".head") as PropThumb;
            if(_loc1_)
            {
               return this.head.state == _loc1_.defaultTalkState;
            }
         }
         return false;
      }
      
      private function updateActionAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Action = _loc3_[0] as Action;
         this.updateAction(CharThumb(this.thumb).getActionById(_loc4_.id));
      }
      
      private function updateAction(param1:Action) : void
      {
         this.action = param1;
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.action = param1;
         }
         this.updateTimelineMotion();
         this.dispatchEvent(new AssetEvent(AssetEvent.ACTION_CHANGE,this));
         Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_ACTION_CHANGED,this));
      }
      
      public function startSlideMotion() : void
      {
         if(!this.isSliding)
         {
            if(this.motionDirection == "")
            {
               this.motionDirection = AnimeConstants.MOTION_FORWARD;
            }
            if(this.motionShadow == null)
            {
               this._originalX = getSceneCanvas().mouseX;
               this._originalY = getSceneCanvas().mouseY;
               _originalAssetX = this.x;
               _originalAssetY = this.y;
               this.refreshMotionShadow();
               this.snapAsset(this.motionShadow);
               this.refreshMotionShadow();
            }
            if(this._motionData)
            {
               this._motionData.removeEventListener(Event.CHANGE,this.onMotionChange);
               this._motionData = null;
            }
            this._motionData = new MotionData();
            this._motionData.startPoint = new Point(this.x,this.y);
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this._motionData.startRotation = this.rotation;
            this._motionData.addEventListener(Event.CHANGE,this.onMotionChange);
            this.updateFacing();
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      private function onMotionChange(param1:Event) : void
      {
         if(this.motionData)
         {
            if(this.motionData.pathOriented)
            {
               if(this.motionShadow)
               {
                  this.motionShadow.isRotatable = false;
                  this.motionShadow.rotation = this.motionData.endRotation;
                  this.motionShadow.facing = this.facing;
               }
            }
            else
            {
               this.updateFacing();
               if(this.motionShadow)
               {
                  this.motionShadow.isRotatable = true;
               }
            }
         }
      }
      
      public function set motionData(param1:MotionData) : void
      {
         if(param1)
         {
            this.motionDirection = AnimeConstants.MOTION_FORWARD;
            this.motionShadow = null;
            this._originalX = getSceneCanvas().mouseX;
            this._originalY = getSceneCanvas().mouseY;
            _originalAssetX = this.x;
            _originalAssetY = this.y;
            this.refreshMotionShadow();
            this.motionShadow.move(this.x + param1.displacement.x,this.y + param1.displacement.y);
            this.motionShadow.setReferencePoint(this.referenceX + param1.displacement.x,this.referenceY + param1.displacement.y);
            if(this._motionData)
            {
               this._motionData.removeEventListener(Event.CHANGE,this.onMotionChange);
               this._motionData = null;
            }
            this._motionData = new MotionData();
            this._motionData.startPoint = new Point(this.x,this.y);
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this._motionData.startRotation = this.rotation;
            this._motionData.addEventListener(Event.CHANGE,this.onMotionChange);
            this.updateFacing();
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      public function get motionData() : MotionData
      {
         return this._motionData;
      }
      
      override public function set x(param1:Number) : void
      {
         if(param1 != this.x)
         {
            super.x = param1;
            if(this._motionData)
            {
               this._motionData.startPoint = new Point(this.x,this.y);
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      override public function set y(param1:Number) : void
      {
         if(param1 != this.y)
         {
            super.y = param1;
            if(this._motionData)
            {
               this._motionData.startPoint = new Point(this.x,this.y);
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      override public function move(param1:Number, param2:Number) : void
      {
         if(param1 != this.x || param2 != this.y)
         {
            super.move(param1,param2);
            if(this._motionData)
            {
               this._motionData.startPoint = new Point(this.x,this.y);
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      public function get isSliding() : Boolean
      {
         return this.motionShadow != null;
      }
      
      public function get slideEnabled() : Boolean
      {
         return true;
      }
      
      private function snapAsset(param1:Asset) : void
      {
         var _loc2_:int = this.facing == AnimeConstants.FACING_LEFT ? -100 : 100;
         param1.x += _loc2_;
         param1.referenceX += _loc2_;
         if(param1.x < 0)
         {
            param1.x = 0;
         }
      }
      
      private function addMotionShadow(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null, param5:Array = null, param6:Array = null) : void
      {
         var _loc7_:Character = null;
         if(!this.isMotionShadow())
         {
            if(this.motionShadow == null)
            {
               _loc7_ = Character(this.clone());
               if(!(param1 == null && param2 == null && param3 == null && param4 == null && param5 == null && param6 == null))
               {
                  _loc7_.setReferencePoint(param1[param1.length - 1],param2[param2.length - 1]);
                  _loc7_.move(param1[param1.length - 1],param2[param2.length - 1]);
                  _loc7_.rotation = param6[param6.length - 1];
                  _loc7_.facing = this.getFacingConstants(CharThumb(this.thumb).facing,param5[param5.length - 1]);
                  _loc7_.scaleX = param3[param3.length - 1];
                  _loc7_.scaleY = param4[param4.length - 1];
               }
               this.motionShadow = Character(_loc7_.clone());
               this.motionShadow.fromTray = false;
               this.motionShadow.isShadow = true;
               this.motionShadow.removeSlideMotion();
            }
            this.showMotionShadow();
         }
      }
      
      private function onShadowMoved(param1:Event) : void
      {
         if(this.motionShadow && this._motionData)
         {
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      public function refreshMotionShadow() : void
      {
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = this.hasMotion();
         if(_loc1_)
         {
            if(_loc2_)
            {
               this.showMotionShadow();
            }
            else
            {
               this.addMotionShadow();
            }
         }
         else if(!_loc1_ && _loc2_)
         {
            this.removeMotionShadow();
         }
      }
      
      function showMotionShadow() : void
      {
         var _loc1_:Character = this.getMotionShadow();
         if(_loc1_ != null)
         {
            this.updateFacing();
         }
      }
      
      public function hideMotionShadow() : void
      {
      }
      
      function getMotionShadow() : Character
      {
         if(this.motionShadow != null)
         {
            return this.motionShadow;
         }
         return null;
      }
      
      private function updateTimelineMotion() : void
      {
         scene.doUpdateTimelineLength(-1,true);
      }
      
      public function removeMotionShadow() : void
      {
         if(this.motionShadow != null)
         {
            try
            {
               this.motionShadow.removeEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
               this.motionShadow = null;
               this.motionDirection = "";
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function startDragging() : void
      {
      }
      
      override public function restoreColor() : void
      {
         super.restoreColor();
         if(this.prop)
         {
            this.prop.restoreColor();
         }
         if(this.wear)
         {
            this.wear.restoreColor();
         }
         if(this.head)
         {
            this.head.restoreColor();
         }
      }
      
      public function restoreColorById(param1:Array) : void
      {
         var _loc2_:int = 0;
         try
         {
            if(this.thumb.isCC)
            {
               _loc2_ = 0;
               while(_loc2_ < param1.length)
               {
                  CustomCharacterMaker(this.imageObject).CCM.deleteColor(param1[_loc2_]);
                  _loc2_++;
               }
               CustomCharacterMaker(this.imageObject).reloadSkin();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function changeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc4_:uint = 0;
         var _loc5_:SelectedColor = null;
         var _loc3_:Number = super.changeColor(param1,param2);
         try
         {
            if(this.thumb.isCC)
            {
               _loc4_ = uint.MAX_VALUE;
               _loc5_ = new SelectedColor(param1,_loc4_,param2);
               CustomCharacterMaker(this.imageObject).CCM.addColor(param1,_loc5_);
            }
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
      
      public function set isRotatable(param1:Boolean) : void
      {
         if(this._rotation.enabled != param1)
         {
            this._rotation.enabled = param1;
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
         }
      }
      
      public function get isRotatable() : Boolean
      {
         return this._rotation.enabled;
      }
      
      public function get rotation() : Number
      {
         return this._rotation.rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         if(param1 != this.rotation)
         {
            this._rotation.rotation = param1;
            if(this.motionData)
            {
               this.motionData.startRotation = this.rotation;
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_ROTATED,this));
         }
      }
   }
}
