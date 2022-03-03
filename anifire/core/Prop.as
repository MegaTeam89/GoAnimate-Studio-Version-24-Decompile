package anifire.core
{
   import anifire.assets.geom.AssetRotation;
   import anifire.assets.motion.ICircularMotion;
   import anifire.color.SelectedColor;
   import anifire.command.ChangeActionCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.component.CustomCharacterMaker;
   import anifire.constant.AnimeConstants;
   import anifire.constant.RaceConstants;
   import anifire.errors.SerializeError;
   import anifire.event.CoreEvent;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.events.AssetEvent;
   import anifire.events.CharacterAssetEvent;
   import anifire.interfaces.IColorable;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IEye;
   import anifire.interfaces.IFlippable;
   import anifire.interfaces.IMotion;
   import anifire.interfaces.IMouth;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IRotatable;
   import anifire.interfaces.IScalable;
   import anifire.interfaces.ISlidable;
   import anifire.interfaces.IThumb;
   import anifire.managers.ThemeManager;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilHashSelectedColor;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.containers.Canvas;
   import mx.core.ScrollPolicy;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Prop extends Asset implements ISlidable, IDraggable, IRotatable, IScalable, IMovable, IColorable, IFlippable, IEye, IMouth, IMotion
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Prop");
      
      public static const XML_NODE_NAME:String = "prop";
      
      public static const XML_NODE_NAME_HEAD:String = "head";
      
      public static const XML_NODE_NAME_WEAR:String = "wear";
      
      private static const MENU_ITEM_TYPE_TAG:String = "itemType";
      
      private static const MENU_ITEM_TYPE_STATE_TAG:String = "state";
      
      private static const MENU_ITEM_TYPE_PROP_TAG:String = "prop";
      
      private static const MENU_ITEM_TYPE_HEAD_TAG:String = "head";
      
      private static const MENU_ITEM_TYPE_WEAR_TAG:String = "wear";
      
      private static const MENU_ITEM_TYPE_ACTION_TAG:String = "action";
      
      private static const MENU_ITEM_TYPE_MOVEMENT_TAG:String = "movement";
      
      private static var _existIDs:UtilHashArray = new UtilHashArray();
      
      private static const REMOVE_MOTION:String = "removeMotion";
      
      private static const ADD_CONTROL_POINT:String = "addControlPoint";
      
      private static const REMOVE_CONTROL_POINT:String = "removeControlPoint";
      
      private static const MENU_ITEM_STATES:String = "actionmenu_states";
      
      private static const MENU_ITEM_MOVEMENT:String = "actionmenu_movement";
      
      private static const MENU_ITEM_SLIDE:String = "actionmenu_slide";
      
      private static const MENU_ITEM_MOVEMENT_REMOVE:String = "actionmenu_removeMove";
      
      private static const MENU_ITEM_POINT_ADD:String = "motionmenu_addpoint";
      
      private static const MENU_ITEM_POINT_REMOVE:String = "motionmenu_removepoint";
       
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _stateId:String;
      
      private var _state:State;
      
      private var _checkedStateItem:Object;
      
      private var _originalRotation:Number = 0;
      
      private var _readyToDrag:Boolean = false;
      
      private var _fromTray:Boolean = false;
      
      public var _char:Character = null;
      
      public var _orgLoaderScaleX:Number = 1;
      
      public var _orgLoaderScaleY:Number = 1;
      
      public var _prevCharPosX:Number = 0;
      
      public var _prevCharPosY:Number = 0;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      private var _motionShadowProp:Prop;
      
      private var _motionShadow_facing:String;
      
      private var _motionData:MotionData;
      
      private var _shadowParent:Prop;
      
      private var _facing:String = "left";
      
      private var _facingMenu:ScrollableArrowMenu;
      
      private var _motionMenu:ScrollableArrowMenu;
      
      private var _actionMenu:ScrollableArrowMenu;
      
      private var _actionMenuXML:XML;
      
      private var _backupSceneXML:XML;
      
      private var _controlPoints:Array;
      
      private var _mouseClickPoint:Point;
      
      private var _currControlPointName:String;
      
      private var initCameraHandler:Function = null;
      
      private var speechHandler:Function = null;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _demoSpeech:Boolean = false;
      
      private var _posBeforeChangeState:Point;
      
      private var _rotation:AssetRotation;
      
      private var _circularMotion:ICircularMotion;
      
      public function Prop(param1:String = "")
      {
         var _loc3_:int = 0;
         this._controlPoints = new Array();
         this._mouseClickPoint = new Point();
         this._rotation = new AssetRotation();
         super();
         _logger.debug("Prop initialized");
         var _loc2_:String = "PROP" + Prop._existIDs.length;
         if(param1 == "")
         {
            _loc3_ = Prop._existIDs.length;
            while(Prop._existIDs.containsKey(_loc2_))
            {
               _loc2_ = "PROP" + _loc3_;
               _loc3_++;
            }
         }
         else
         {
            _loc2_ = param1;
         }
         Prop._existIDs.push(_loc2_,_loc2_);
         this.id = _loc2_;
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray) : UtilHashArray
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:ZipEntry = null;
         var _loc9_:ThemeTree = null;
         var _loc10_:Boolean = false;
         var _loc11_:ByteArray = null;
         var _loc12_:RegExp = null;
         var _loc13_:UtilCrypto = null;
         var _loc14_:XML = null;
         var _loc15_:XML = null;
         var _loc4_:UtilHashArray = new UtilHashArray();
         if(param1.child("file")[0].toString().split(".").length <= 3 || param1.child("file")[0].toString().indexOf(".head.") != -1)
         {
            _loc5_ = UtilXmlInfo.getZipFileNameOfProp(param1.child("file")[0].toString());
            _loc6_ = UtilXmlInfo.getThemeIdFromFileName(_loc5_);
            _loc7_ = UtilXmlInfo.getThumbIdFromFileName(_loc5_);
            if(!(_loc8_ = param2.getEntry(_loc5_)))
            {
               _loc12_ = /zip/gi;
               _loc8_ = param2.getEntry(_loc5_.replace(_loc12_,"xml"));
            }
            _loc10_ = true;
            if(_loc8_ == null)
            {
               _loc10_ = false;
            }
            else if(param3.containsKey(_loc6_) && (param3.getValueByKey(_loc6_) as ThemeTree).isPropThumbExist(_loc7_))
            {
               _loc10_ = false;
            }
            if(_loc8_ != null)
            {
               _loc11_ = param2.getInput(_loc8_);
               if(_loc6_ != "ugc")
               {
                  (_loc13_ = new UtilCrypto()).decrypt(_loc11_);
               }
               (_loc9_ = new ThemeTree(_loc6_)).addPropThumbId(_loc7_,_loc11_);
               _loc4_.push(_loc6_,_loc9_);
            }
            else if(param1.@subtype == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
            {
               _loc5_ = VideoPropThumb.renameExtensionToPNG(_loc5_);
               if((_loc8_ = param2.getEntry(_loc5_)) != null)
               {
                  _loc11_ = param2.getInput(_loc8_);
                  (_loc9_ = new ThemeTree(_loc6_)).addPropThumbId(_loc7_,_loc11_);
                  _loc4_.push(_loc6_,_loc9_);
               }
            }
         }
         else if((_loc14_ = param1.child("file")[0]) != null)
         {
            ThemeTree.mergeThemeTrees(_loc4_,Behavior.getThemeTrees(_loc14_,param2,param3,false));
            _loc15_ = _loc14_;
         }
         return _loc4_;
      }
      
      private function get posBeforeChangeState() : Point
      {
         return this._posBeforeChangeState;
      }
      
      private function set posBeforeChangeState(param1:Point) : void
      {
         this._posBeforeChangeState = param1;
      }
      
      public function get lookAtCameraSupported() : Boolean
      {
         return false;
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         this._lookAtCamera = param1;
         if(this.thumb != null && PropThumb(this.thumb).isCC)
         {
            this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,param1));
            this.dispatchEvent(new AssetEvent(CharacterAssetEvent.EYE_CHANGE,this));
         }
      }
      
      public function set demoSpeech(param1:Boolean) : void
      {
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
      
      public function get char() : Character
      {
         return this._char;
      }
      
      public function set char(param1:Character) : void
      {
         this._char = param1;
      }
      
      private function onShadowMoved(param1:Event) : void
      {
         if(this.motionShadow && this._motionData)
         {
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
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
      
      override public function updateOriginalAssetPosition() : void
      {
         _originalAssetX = this.x;
         _originalAssetY = this.y;
      }
      
      override public function getOriginalAssetPosition() : Point
      {
         return new Point(_originalAssetX,_originalAssetY);
      }
      
      override public function updateOriginalAssetScale() : void
      {
         _originalAssetScaleX = this.scaleX;
         _originalAssetScaleY = this.scaleY;
      }
      
      override public function getOriginalAssetScale() : Point
      {
         return new Point(_originalAssetScaleX,_originalAssetScaleY);
      }
      
      override public function set thumb(param1:IThumb) : void
      {
         var _loc2_:PropThumb = param1 as PropThumb;
         super.thumb = param1;
         if(_loc2_ is VideoPropThumb)
         {
            this.imageData = param1.imageData;
         }
         else if(PropThumb(param1).states.length > 0)
         {
            if(this._fromTray)
            {
               this.state = _loc2_.defaultState;
            }
            else
            {
               this.state = _loc2_.getStateById(this.stateId);
            }
         }
         else
         {
            this.imageData = param1.imageData;
         }
      }
      
      private function get defaultFacing() : String
      {
         return PropThumb(this.thumb).facing;
      }
      
      public function set stateId(param1:String) : void
      {
         this._stateId = param1;
      }
      
      public function get stateId() : String
      {
         return this._stateId;
      }
      
      public function set state(param1:State) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            this.stateId = param1.id;
            this.imageData = param1.imageData;
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE,this));
         }
      }
      
      public function get state() : State
      {
         return this._state;
      }
      
      public function get motionShadow() : Prop
      {
         return this._motionShadowProp;
      }
      
      public function get motionData() : MotionData
      {
         return this._motionData;
      }
      
      public function get shadow() : Object
      {
         return this._motionShadowProp;
      }
      
      public function set motionShadow(param1:Prop) : void
      {
         if(this._motionShadowProp)
         {
            this._motionShadowProp.removeEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
         }
         this._motionShadowProp = param1;
         if(this._motionShadowProp)
         {
            this._motionShadowProp.addEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
            this._motionShadowProp._shadowParent = this;
         }
      }
      
      public function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      public function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      public function get isFlipped() : Boolean
      {
         return this._facing != AnimeConstants.FACING_LEFT;
      }
      
      public function set facing(param1:String) : void
      {
         if(this._facing != param1)
         {
            this._facing = param1;
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_HFLIPPED,this));
         }
      }
      
      private function getShadowIndex(param1:AnimeScene) : int
      {
         return param1.background == null ? 0 : 1;
      }
      
      public function getDataAndKey() : UtilHashArray
      {
         var _loc1_:UtilHashArray = new UtilHashArray();
         if(this.state == null)
         {
            this.state = PropThumb(this.thumb).defaultState;
         }
         var _loc2_:String = !!PropThumb(this.thumb).path ? PropThumb(this.thumb).path : this.thumb.id;
         _loc1_.push(this.thumb.theme.id + ".prop." + _loc2_ + "." + this.state.id,this.state.imageData,true);
         return _loc1_;
      }
      
      public function loadState(param1:CoreEvent) : void
      {
         if(this._fromTray)
         {
            this.state = PropThumb(this.thumb).defaultState;
         }
         else
         {
            this.state = PropThumb(this.thumb).getStateById(this.stateId);
         }
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
      
      public function addMotionShadow(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null, param5:Array = null, param6:Array = null) : void
      {
         var _loc7_:int = 0;
         var _loc8_:AnimeScene = null;
         var _loc9_:Prop = null;
         if(!this.isMotionShadow())
         {
            _loc7_ = Console.getConsole().getSceneIndex(scene);
            _loc8_ = Console.getConsole().getScene(_loc7_);
            if(this.motionShadow == null)
            {
               _loc9_ = Prop(this.clone());
               if(!(param1 == null && param2 == null && param3 == null && param4 == null && param5 == null && param6 == null))
               {
                  _loc9_.setReferencePoint(param1[param1.length - 1],param2[param2.length - 1]);
                  _loc9_.move(param1[param1.length - 1],param2[param2.length - 1]);
                  _loc9_.rotation = param6[param6.length - 1];
                  _loc9_.scaleX = param3[param3.length - 1];
                  _loc9_.scaleY = param4[param4.length - 1];
               }
               this._motionShadow_facing = _loc9_.facing;
               this.motionShadow = Prop(_loc9_.clone());
               this.motionShadow.removeSlideMotion();
            }
         }
      }
      
      public function refreshMotionShadow() : void
      {
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = this.hasMotion();
         if(_loc1_)
         {
            if(!_loc2_)
            {
               this.addMotionShadow();
            }
         }
         else if(!_loc1_ && _loc2_)
         {
            this.removeMotionShadow();
         }
      }
      
      private function removeMotionShadow() : void
      {
         if(this.motionShadow != null)
         {
            try
            {
               this.motionShadow.removeEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
               this.motionShadow = null;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      override protected function getSceneCanvas() : Canvas
      {
         if(this.char == null)
         {
            return super.getSceneCanvas();
         }
         return null;
      }
      
      public function get fileId() : String
      {
         var _loc1_:String = null;
         try
         {
            _loc1_ = "";
            if(PropThumb(this.thumb).getStateNum() > 0)
            {
               if(this.state == null)
               {
                  _loc1_ = PropThumb(this.thumb).defaultState.getKey();
               }
               else
               {
                  _loc1_ = this.state.getKey();
               }
            }
            else
            {
               _loc1_ = this.thumb.theme.id + "." + this.thumb.id;
            }
         }
         catch(e:Error)
         {
         }
         return _loc1_;
      }
      
      override public function convertToXml() : XML
      {
         var xml:XML = null;
         var childXml:XML = null;
         var message:String = null;
         var filepath:String = null;
         var index:uint = 0;
         var colorList:XMLList = null;
         var xmlStr:String = "";
         xml = <prop/>;
         var error:Error = new Error();
         try
         {
            if(!this.thumb)
            {
               error.message = "null thumb";
               throw error;
            }
            if(PropThumb(this.thumb).getStateNum() > 0)
            {
               if(this.state == null)
               {
                  if(!PropThumb(this.thumb).defaultState)
                  {
                     error.message = "null defaultState";
                     throw error;
                  }
                  filepath = PropThumb(this.thumb).defaultState.getKey();
               }
               else
               {
                  if(!this.state)
                  {
                     error.message = "null state";
                     throw error;
                  }
                  filepath = this.state.getKey();
               }
            }
            else
            {
               if(!this.thumb.theme)
               {
                  error.message = "null theme";
                  throw error;
               }
               filepath = this.thumb.theme.id + "." + this.thumb.id;
            }
            if(this.char)
            {
               if(this.char.prop)
               {
                  if(this.char.prop.id == this.id)
                  {
                     xml.@id = this.id;
                     if(PropThumb(this.thumb).raceCode != 0)
                     {
                        xml.@raceCode = PropThumb(this.thumb).raceCode;
                     }
                     if(PropThumb(this.thumb).handStyle != "")
                     {
                        xml.@handstyle = PropThumb(this.thumb).handStyle;
                     }
                     xml.file = filepath;
                  }
               }
               if(this.char.head)
               {
                  if(this.char.head.id == this.id)
                  {
                     xml = <head/>;
                     xml.@id = this.id;
                     if(PropThumb(this.thumb).raceCode != 0)
                     {
                        xml.@raceCode = PropThumb(this.thumb).raceCode;
                     }
                     xml.file = filepath;
                  }
               }
               if(this.char.wear)
               {
                  if(this.char.wear.id == this.id)
                  {
                     xml = <wear/>;
                     xml.@id = this.id;
                     if(PropThumb(this.thumb).raceCode != 0)
                     {
                        xml.@raceCode = PropThumb(this.thumb).raceCode;
                     }
                     xml.file = filepath;
                  }
               }
            }
            else
            {
               index = this.scene.getOverallOrdering(this);
               xml.@id = this.id;
               xml.@index = String(index);
               if(PropThumb(this.thumb).isCC)
               {
                  xml.@isCC = "Y";
               }
               if(PropThumb(this.thumb).subType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
               {
                  xml.@subtype = "video";
               }
               xml.file = filepath;
               xml.x = this.serializeMotion("x",this.motionShadow);
               xml.y = this.serializeMotion("y",this.motionShadow);
               xml.xscale = this.serializeMotion("xscale",this.motionShadow);
               xml.yscale = this.serializeMotion("yscale",this.motionShadow);
               xml.face = this.serializeMotion("facing",this.motionShadow);
               xml.rotation = this.serializeMotion("rotation",this.motionShadow);
               if(defaultColorSetId != "")
               {
                  xml.dcsn = defaultColorSetId;
               }
               colorList = this.getColorXmlList();
               if(colorList)
               {
                  xml.appendChild(colorList);
               }
               if(this._motionData)
               {
                  childXml = this._motionData.convertToXml();
                  xml.appendChild(childXml);
               }
            }
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize prop, broken xml: " + xml.toXMLString() + e.message);
         }
         return xml;
      }
      
      override public function setReferencePoint(param1:Number, param2:Number) : void
      {
         super.setReferencePoint(param1,param2);
         if(this._circularMotion)
         {
            this._circularMotion.center = new Point(param1,param2);
         }
      }
      
      override public function serialize() : String
      {
         return this.convertToXml().toXMLString();
      }
      
      public function getColorXmlList() : XMLList
      {
         var xml:XML = null;
         var xmlList:XMLList = null;
         var xmlStr:String = null;
         var i:int = 0;
         try
         {
            xmlStr = "";
            if(customColor.length > 0)
            {
               xmlList = new XMLList();
               i = 0;
               while(i < customColor.length)
               {
                  xml = <color>{SelectedColor(customColor.getValueByIndex(i)).dstColor}</color>;
                  xml.@r = customColor.getKey(i);
                  if(SelectedColor(customColor.getValueByIndex(i)).orgColor != uint.MAX_VALUE)
                  {
                     xml.@oc = "0x" + SelectedColor(customColor.getValueByIndex(i)).orgColor.toString(16);
                  }
                  xmlList += xml;
                  i++;
               }
            }
         }
         catch(e:Error)
         {
            throw new SerializeError("Failed to serialize prop color " + this.id,xmlStr,e);
         }
         return xmlList;
      }
      
      public function serializeColor() : String
      {
         var xmlStr:String = null;
         var i:int = 0;
         return this.getColorXmlList().toXMLString();
      }
      
      public function serializeMotion(param1:String, param2:Prop) : Array
      {
         var tempArray:Array = null;
         var i:int = 0;
         var property:String = param1;
         var shadow:Prop = param2;
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
                     tempArray.push(this._motionShadow_facing == this.defaultFacing ? 1 : -1);
                     break;
                  case "rotation":
                     tempArray.push(Util.roundNum(shadow.rotation));
               }
            }
         }
         catch(e:Error)
         {
            throw new SerializeError("Failed to serialize prop motion " + this.id,tempArray.toString(),e);
         }
         return tempArray;
      }
      
      public function deSerialize(param1:XML, param2:Character, param3:AnimeScene = null, param4:Boolean = true, param5:Boolean = true) : void
      {
         var _loc11_:RegExp = null;
         var _loc12_:PropThumb = null;
         var _loc13_:XML = null;
         var _loc14_:int = 0;
         var _loc15_:SelectedColor = null;
         var _loc6_:String = UtilXmlInfo.getZipFileNameOfProp(param1.child("file")[0].toString());
         var _loc7_:String = UtilXmlInfo.getThumbIdFromFileName(_loc6_);
         var _loc8_:String = _loc6_.split(".").length == 4 ? _loc7_ : UtilXmlInfo.getCharIdFromFileName(_loc6_);
         if(_loc7_.indexOf(".head.") != -1)
         {
            _loc8_ = UtilXmlInfo.getFacialThumbIdFromFileName(_loc7_);
            _loc7_ = UtilXmlInfo.getFacialIdFromFileName(_loc7_);
            _loc11_ = /zip/gi;
            _loc7_ = _loc7_.replace(_loc11_,"xml");
         }
         var _loc9_:String = UtilXmlInfo.getThemeIdFromFileName(_loc6_);
         var _loc10_:Theme;
         if((_loc10_ = ThemeManager.instance.getTheme(_loc9_)) != null)
         {
            _loc12_ = _loc10_.getPropThumbById(_loc8_) as PropThumb;
            if(param4 && !Prop._existIDs.containsKey(param1.attribute("id")))
            {
               this.id = param1.attribute("id");
               Prop._existIDs.push(this.id,this.id);
            }
            if(_loc12_ != null)
            {
               if(param5)
               {
                  this.init(_loc12_,param2);
               }
               else
               {
                  super.thumb = _loc12_;
               }
               if(param2 == null && param3 != null)
               {
                  this.scene = param3;
                  this._xs = String(param1.x).split(",");
                  this._ys = String(param1.y).split(",");
                  this._scaleXs = String(param1.xscale).split(",");
                  this._scaleYs = String(param1.yscale).split(",");
                  this._rotations = String(param1.rotation).split(",");
                  this._facings = String(param1.face).split(",");
                  this.setReferencePoint(this._xs[0],this._ys[0]);
                  this.move(this._xs[0],this._ys[0]);
                  this.scaleX = this._scaleXs[0];
                  this.scaleY = this._scaleYs[0];
                  this.rotation = this._rotations[0];
                  if(this._facings[0] == "1")
                  {
                     this.facing = this.defaultFacing;
                  }
                  else if(this._facings[0] == "-1")
                  {
                     if(this.defaultFacing == AnimeConstants.FACING_LEFT)
                     {
                        this.facing = AnimeConstants.FACING_RIGHT;
                     }
                     else if(this.defaultFacing == AnimeConstants.FACING_RIGHT)
                     {
                        this.facing = AnimeConstants.FACING_LEFT;
                     }
                  }
                  if(this.shouldHasMotion())
                  {
                     this.fillMaskPoint();
                     this.addMotionShadow(this._xs,this._ys,this._scaleXs,this._scaleYs,this._facings,this._rotations);
                     this.hideMotionShadow();
                  }
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
               if(param5)
               {
                  this.state = _loc12_.getStateById(_loc7_);
               }
               else
               {
                  this._state = _loc12_.getStateById(_loc7_);
                  this._stateId = _loc7_;
               }
               if(this.state != null && this.state.imageData != null)
               {
                  this.isLoadded = true;
               }
               if(param1.dcsn.length() > 0)
               {
                  this.defaultColorSetId = String(param1.dcsn);
                  this.defaultColorSet = Thumb(this.thumb).getColorSetById(this.defaultColorSetId);
               }
               customColor = new UtilHashSelectedColor();
               _loc14_ = 0;
               while(_loc14_ < param1.child("color").length())
               {
                  _loc13_ = param1.child("color")[_loc14_];
                  _loc15_ = new SelectedColor(_loc13_.@r,_loc13_.attribute("oc").length() == 0 ? uint(uint.MAX_VALUE) : uint(_loc13_.@oc),uint(_loc13_));
                  this.addCustomColor(_loc13_.@r,_loc15_);
                  _loc14_++;
               }
               if(!this is VideoProp)
               {
                  updateColor();
               }
            }
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
         }
      }
      
      override public function cloneNext() : Asset
      {
         var _loc1_:Prop = this.clone() as Prop;
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
         return _loc1_;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:Prop = new Prop();
         if(this.char == null)
         {
            _loc3_.x = this.x;
            _loc3_.y = this.y;
            _loc3_.scaleX = this.scaleX;
            _loc3_.scaleY = this.scaleY;
            _loc3_.rotation = this.rotation;
            _loc3_.scene = this.scene;
         }
         _loc3_.id = this.id;
         _loc3_.attachedBg = this.attachedBg;
         _loc3_.init(Thumb(this.thumb),this.char);
         _loc3_.facing = this.facing;
         _loc3_.stateId = this.stateId;
         _loc3_.state = this.state;
         _loc3_.lookAtCamera = this.lookAtCamera;
         _loc3_.customColor = this.customColor.clone();
         _loc3_.defaultColorSet = this.defaultColorSet.clone();
         _loc3_.setReferencePoint(this.referenceX,this.referenceY);
         if(this.motionData)
         {
            _loc3_.motionData = this.motionData.clone();
         }
         if(this.motionShadow)
         {
            _loc3_.motionShadow = this.motionShadow.clone() as Prop;
         }
         return _loc3_;
      }
      
      public function clearDisplayElement() : void
      {
      }
      
      public function reloadAssetImage() : void
      {
         this.loadAssetImage();
      }
      
      override protected function loadAssetImage() : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      private function setChange(param1:Boolean) : void
      {
         this.changed = param1;
      }
      
      public function isMotionShadow() : Boolean
      {
         return false;
      }
      
      public function hideMotionShadow() : void
      {
      }
      
      function getMotionShadow() : Prop
      {
         if(this.motionShadow != null)
         {
            return this.motionShadow;
         }
         return null;
      }
      
      protected function getOrigin() : Point
      {
         return new Point();
      }
      
      public function init(param1:Thumb, param2:Character) : void
      {
         this.thumb = param1;
         if(param2 != null)
         {
            this.char = param2;
            this.scene = param2.scene;
         }
      }
      
      private function updateTimelineMotion() : void
      {
         if(this.char == null)
         {
            scene.doUpdateTimelineLength(-1,true);
         }
      }
      
      public function startDragging() : void
      {
         this._originalX = this.getSceneCanvas().mouseX;
         this._originalY = this.getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         this._readyToDrag = true;
         Console.getConsole().currDragObject = this;
      }
      
      public function showActionMenu(param1:Number, param2:Number) : void
      {
         this._actionMenu = this.buildActionMenu();
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         _loc3_ = 105;
         _loc4_ = 25;
         var _loc5_:Canvas;
         var _loc6_:Point = (_loc5_ = Console.getConsole().mainStage._stageArea).localToGlobal(new Point(0,0));
         if(Console.getConsole().stageScale > 1)
         {
            _loc6_ = new Point(0,68);
         }
         var _loc7_:Number = _loc5_.stage.mouseX;
         var _loc8_:Number = _loc5_.stage.mouseY;
         if(_loc7_ + _loc3_ > _loc6_.x + _loc5_.width)
         {
            _loc7_ = _loc6_.x + _loc5_.width - _loc3_;
         }
         if(_loc8_ + _loc4_ > _loc6_.y + _loc5_.height)
         {
            _loc8_ = _loc6_.y + _loc5_.height - _loc4_;
         }
         this._actionMenu.show(param1,param2);
      }
      
      public function buildStateMenu(param1:String, param2:Boolean = true) : String
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:State = null;
         var _loc10_:Boolean = false;
         var _loc3_:PropThumb = PropThumb(this.thumb);
         var _loc4_:Array = _loc3_.states;
         var _loc5_:Array = _loc3_.stateMenuItems;
         if(_loc3_.holdable)
         {
            _loc6_ = MENU_ITEM_TYPE_PROP_TAG;
         }
         else if(_loc3_.headable)
         {
            _loc6_ = MENU_ITEM_TYPE_HEAD_TAG;
         }
         else if(_loc3_.wearable)
         {
            _loc6_ = MENU_ITEM_TYPE_WEAR_TAG;
         }
         else
         {
            _loc6_ = MENU_ITEM_TYPE_STATE_TAG;
         }
         if(_loc5_.length > 0)
         {
            param1 += !!param2 ? "<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_STATES) + "\" toggled=\"false\">" : "";
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               if((_loc8_ = _loc5_[_loc7_]) is State)
               {
                  if((_loc9_ = State(_loc8_)).imageData != null)
                  {
                     if(this.imageData is Object && _loc9_.imageData is Object && _loc9_.imageData == this.imageData)
                     {
                        _loc10_ = true;
                     }
                     else if(this.imageData is ByteArray && _loc9_.imageData is ByteArray && ByteArray(_loc9_.imageData).bytesAvailable == ByteArray(this.imageData).bytesAvailable)
                     {
                        _loc10_ = true;
                     }
                     else
                     {
                        _loc10_ = false;
                     }
                  }
                  else
                  {
                     _loc10_ = false;
                  }
                  param1 += "<menuItem " + "label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("store",_loc9_.name).toLowerCase()) + "\" " + "type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + _loc6_ + "\" " + "stateId=\"" + _loc9_.id + "\" " + "toggled=\"" + _loc10_ + "\"/>";
               }
               _loc7_++;
            }
            param1 += !!param2 ? "</mainMenu>" : "";
         }
         return param1;
      }
      
      private function buildActionMenu() : ScrollableArrowMenu
      {
         var _loc1_:ScrollableArrowMenu = null;
         var _loc2_:* = "<menuRoot>";
         _loc2_ = this.buildStateMenu(_loc2_);
         _loc2_ += "<mainMenu label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT)) + "\" toggled=\"false\">";
         _loc2_ += "<menuItem label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_SLIDE)) + "\" value=\"" + AnimeConstants.MOVEMENT_SLIDE + "\" type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_MOVEMENT_TAG + "\" toggled=\"" + false + "\"/>";
         _loc2_ += "</mainMenu>";
         _loc2_ += "</menuRoot>";
         this._actionMenuXML = new XML(_loc2_);
         _loc1_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),this._actionMenuXML,false);
         _loc1_.labelField = "@label";
         _loc1_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         _loc1_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc1_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc1_.maxHeight = Console.getConsole().mainStage._stageArea.height;
         return _loc1_;
      }
      
      public function get stateMenu() : ScrollableArrowMenu
      {
         var _loc1_:ScrollableArrowMenu = null;
         var _loc2_:String = "";
         _loc2_ = this.buildStateMenu(_loc2_);
         this._actionMenuXML = new XML(_loc2_);
         _loc1_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),this._actionMenuXML,false);
         _loc1_.labelField = "@label";
         _loc1_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         _loc1_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc1_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc1_.maxHeight = 300;
         _loc1_.minWidth = 150;
         return _loc1_;
      }
      
      public function flipIt() : void
      {
         this.facing = this.facing == AnimeConstants.FACING_LEFT ? AnimeConstants.FACING_RIGHT : AnimeConstants.FACING_LEFT;
      }
      
      private function doActionMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:ICommand = null;
         var _loc3_:String = param1.item.@itemType;
         var _loc4_:XML;
         var _loc5_:String = (_loc4_ = XML(param1.item)).attribute(MENU_ITEM_TYPE_TAG);
         switch(_loc5_)
         {
            case MENU_ITEM_TYPE_STATE_TAG:
            case MENU_ITEM_TYPE_PROP_TAG:
            case MENU_ITEM_TYPE_HEAD_TAG:
            case MENU_ITEM_TYPE_WEAR_TAG:
               this.doChangeState(param1);
               break;
            case MENU_ITEM_TYPE_MOVEMENT_TAG:
               this.startSlideMotion();
         }
      }
      
      public function doChangeState(param1:MenuEvent) : void
      {
         var _loc9_:State = null;
         var _loc10_:UtilLoadMgr = null;
         var _loc11_:Array = null;
         var _loc2_:ICommand = new ChangeActionCommand();
         _loc2_.execute();
         var _loc3_:String = param1.item.@label;
         var _loc4_:String = param1.item.@itemType;
         var _loc5_:String = param1.item.@stateId;
         var _loc6_:PropThumb;
         var _loc7_:Array = (_loc6_ = PropThumb(this.thumb)).states;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_];
            if(_loc5_ == _loc9_.id && this.imageData != null && this.imageData != _loc9_.imageData)
            {
               if(this._checkedStateItem != null)
               {
                  this._checkedStateItem.@toggled = "false";
               }
               if(_loc9_.imageData != null)
               {
                  this.updateState(_loc9_);
               }
               else
               {
                  _loc10_ = new UtilLoadMgr();
                  (_loc11_ = new Array()).push(_loc9_);
                  _loc10_.setExtraData(_loc11_);
                  _loc10_.addEventDispatcher(_loc6_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc10_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateStateAgain);
                  _loc10_.commit();
                  _loc6_.loadState(_loc9_);
               }
               this._checkedStateItem = param1.item;
               break;
            }
            _loc8_++;
         }
         param1.item.@toggled = "true";
      }
      
      private function updateStateAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:State = _loc3_[0] as State;
         this.updateState(_loc4_);
      }
      
      private function updateState(param1:State) : void
      {
         try
         {
            this.state = param1;
            if(this._motionShadowProp != null)
            {
               this._motionShadowProp.state = param1;
            }
            if(this.char != null)
            {
               switch(this.char.thumb.raceCode)
               {
                  case RaceConstants.CUSTOM_CHARACTER:
                     this.char.updatePropState(Thumb(this.thumb),this.state);
                     break;
                  case RaceConstants.SKINNED_SWF:
                     this.char.updatePropState(Thumb(this.thumb),this.state);
               }
               this.char.onPropChange();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function startSlideMotion() : void
      {
         if(this.motionShadow == null)
         {
            this._originalX = this.getSceneCanvas().mouseX;
            this._originalY = this.getSceneCanvas().mouseY;
            _originalAssetX = this.x;
            _originalAssetY = this.y;
            this.refreshMotionShadow();
            this.snapAsset(this.motionShadow);
            this.refreshMotionShadow();
            if(this._motionData)
            {
               this._motionData.removeEventListener(Event.CHANGE,this.onMotionChange);
            }
            this._motionData = new MotionData();
            this._motionData.startPoint = new Point(this.x,this.y);
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this._motionData.startRotation = this.rotation;
            this._motionData.addEventListener(Event.CHANGE,this.onMotionChange);
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
               }
            }
            else if(this.motionShadow)
            {
               this.motionShadow.isRotatable = true;
            }
         }
      }
      
      public function set motionData(param1:MotionData) : void
      {
         if(param1)
         {
            this.motionShadow = null;
            this._originalX = this.getSceneCanvas().mouseX;
            this._originalY = this.getSceneCanvas().mouseY;
            _originalAssetX = this.x;
            _originalAssetY = this.y;
            this.refreshMotionShadow();
            this.motionShadow.move(this.x + param1.displacement.x,this.y + param1.displacement.y);
            this.motionShadow.setReferencePoint(this.referenceX + param1.displacement.x,this.referenceY + param1.displacement.y);
            if(this._motionData)
            {
               this._motionData.removeEventListener(Event.CHANGE,this.onMotionChange);
            }
            this._motionData = new MotionData();
            this._motionData.startPoint = new Point(this.x,this.y);
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this._motionData.startRotation = this.rotation;
            this._motionData.addEventListener(Event.CHANGE,this.onMotionChange);
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      public function get slideEnabled() : Boolean
      {
         return true;
      }
      
      private function snapAsset(param1:Asset) : void
      {
         var _loc2_:int = param1.x > AnimeConstants.STAGE_WIDTH / 2 ? -100 : 100;
         param1.x += _loc2_;
         param1.referenceX += _loc2_;
      }
      
      public function removeSlideMotion() : void
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
      
      public function get isSliding() : Boolean
      {
         return this.motionShadow != null;
      }
      
      private function doRemoveMotion() : void
      {
         var _loc1_:ICommand = new RemoveMotionCommand();
         _loc1_.execute();
         this.removeMotion();
         this.updateTimelineMotion();
      }
      
      private function removeMotion() : void
      {
         this.removeMotionShadow();
         this.changed = true;
      }
      
      private function refreshControl(... rest) : void
      {
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
