package anifire.core
{
   import anifire.components.containers.AssetInfoWindow;
   import anifire.constant.AnimeConstants;
   import anifire.effect.AnimeEffect;
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.effect.ZoomEffect;
   import anifire.event.CoreEvent;
   import anifire.event.EffectEvt;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IMotion;
   import anifire.interfaces.IResizable;
   import anifire.interfaces.ISlidable;
   import anifire.interfaces.IThumb;
   import anifire.managers.ThemeManager;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilMath;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilXmlInfo;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class EffectAsset extends Asset implements ISlidable, IDraggable, IResizable, IMotion
   {
      
      private static var _logger:ILogger = Log.getLogger("core.EffectAsset");
      
      public static const XML_NODE_NAME:String = "effectAsset";
      
      public static const MENU_LABEL_SHOW:String = "effecttray_show";
      
      public static const MENU_LABEL_HIDE:String = "effecttray_hide";
      
      public static const MENU_LABEL_DELETE:String = "effecttray_delete";
      
      public static const MENU_LABEL_EDIT:String = "effecttray_edit";
      
      public static const STATUS_SHOW:String = "Show";
      
      public static const STATUS_HIDE:String = "Hide";
      
      private static var _existIDs:UtilHashArray = new UtilHashArray();
       
      
      protected var _fromTray:Boolean = false;
      
      private var _readyToDrag:Boolean = false;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _originalEffectWidth:Number;
      
      private var _originalEffectHeight:Number;
      
      private var _originalAssetXML:XML;
      
      private var _effect:SuperEffect;
      
      private var _editing:Boolean;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      protected var _myEffectXML:XML = null;
      
      private var _status:String = "Show";
      
      private var _sttime:Number = -1;
      
      private var _edtime:Number = -1;
      
      private var _stzoom:Number = 0.5;
      
      private var _edzoom:Number = 0.5;
      
      private var _motionShadow:EffectAsset;
      
      private var _backupSceneXML:XML;
      
      private var _fromSpeech:Boolean = false;
      
      private var _motionData:MotionData;
      
      private var _isShadow:Boolean = false;
      
      public function EffectAsset(param1:String = "")
      {
         var _loc3_:int = 0;
         super();
         if(param1 == null)
         {
            param1 = "";
         }
         var _loc2_:String = param1 != "" ? param1 : "EFFECT" + _existIDs.length;
         if(param1 == "")
         {
            _loc3_ = _existIDs.length + 1;
            while(_existIDs.containsKey(_loc2_))
            {
               _loc2_ = "EFFECT" + _loc3_;
               _loc3_++;
            }
         }
         this.id = _loc2_;
         _existIDs.push(_loc2_,_loc2_);
      }
      
      static function getEffectType(param1:XML) : String
      {
         return EffectMgr.getType(param1.child(EffectMgr.XML_NODE_TAG)[0]);
      }
      
      public static function getThemeIdFromAssetXml(param1:XML) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1.child("file").length() > 0)
         {
            _loc3_ = UtilXmlInfo.getZipFileNameOfEffect(param1.child("file")[0].toString());
            _loc2_ = UtilXmlInfo.getThemeIdFromFileName(_loc3_);
         }
         else
         {
            _loc2_ = param1.@themecode;
            if(_loc2_ == "")
            {
               _loc2_ = "common";
            }
         }
         return _loc2_;
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc4_:String = null;
         var _loc5_:ThemeTree = null;
         var _loc6_:String = null;
         var _loc7_:ZipEntry = null;
         var _loc8_:ByteArray = null;
         var _loc9_:UtilCrypto = null;
         var _loc10_:String = null;
         var _loc3_:UtilHashArray = new UtilHashArray();
         if(param1.child("file").length() > 0)
         {
            _loc6_ = UtilXmlInfo.getZipFileNameOfEffect(param1.child("file")[0].toString());
            _loc4_ = UtilXmlInfo.getThemeIdFromFileName(_loc6_);
            if((_loc7_ = param2.getEntry(_loc6_)) != null)
            {
               _loc8_ = param2.getInput(_loc7_);
               if(_loc4_ != "ugc")
               {
                  (_loc9_ = new UtilCrypto()).decrypt(_loc8_);
               }
               (_loc5_ = new ThemeTree(_loc4_)).addEffectThumbId(UtilXmlInfo.getThumbIdFromFileName(_loc6_),_loc8_);
               _loc3_.push(_loc4_,_loc5_);
            }
         }
         else
         {
            _loc4_ = getThemeIdFromAssetXml(param1);
            _loc10_ = EffectMgr.getId(param1.child(EffectMgr.XML_NODE_TAG)[0]);
            (_loc5_ = new ThemeTree(_loc4_)).addEffectThumbId(_loc10_,null);
            _loc3_.push(_loc4_,_loc5_);
         }
         return _loc3_;
      }
      
      public function get motionData() : MotionData
      {
         return this._motionData;
      }
      
      private function onShadowMoved(param1:Event) : void
      {
         if(this.motionShadow && this._motionData)
         {
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this._motionData.esp = new Point(this.motionShadow.width / 2,this.motionShadow.height / 2);
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      public function getOriginalEffectSize() : Point
      {
         return new Point(this._originalEffectWidth,this._originalEffectHeight);
      }
      
      public function updateOriginalEffectSize() : void
      {
         this._originalEffectWidth = this.effect.width;
         this._originalEffectHeight = this.effect.height;
      }
      
      public function get motionShadow() : EffectAsset
      {
         return this._motionShadow;
      }
      
      public function set motionShadow(param1:EffectAsset) : void
      {
         if(this._motionShadow)
         {
            this._motionShadow.removeEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
         }
         this._motionShadow = param1;
         if(this._motionShadow)
         {
            this._motionShadow.addEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
         }
         if(this._motionShadow != null)
         {
         }
      }
      
      public function set stzoom(param1:Number) : void
      {
         this._stzoom = param1;
      }
      
      public function get stzoom() : Number
      {
         return this._stzoom;
      }
      
      public function set edzoom(param1:Number) : void
      {
         this._edzoom = param1;
      }
      
      public function get edzoom() : Number
      {
         return this._edzoom;
      }
      
      public function set sttime(param1:Number) : void
      {
         this._sttime = param1;
      }
      
      public function get sttime() : Number
      {
         return this._sttime;
      }
      
      public function set edtime(param1:Number) : void
      {
         this._edtime = param1;
      }
      
      public function get edtime() : Number
      {
         return this._edtime;
      }
      
      public function set fromSpeech(param1:Boolean) : void
      {
         this._fromSpeech = param1;
      }
      
      public function get fromSpeech() : Boolean
      {
         return this._fromSpeech;
      }
      
      override public function set id(param1:String) : void
      {
         _existIDs.push(param1,param1);
         super.id = param1;
      }
      
      function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      public function set effect(param1:SuperEffect) : void
      {
         this._effect = param1;
      }
      
      public function get effect() : SuperEffect
      {
         return this._effect;
      }
      
      public function getType() : String
      {
         return (this.thumb as EffectThumb).getType();
      }
      
      public function getExactType() : String
      {
         return (this.thumb as EffectThumb).getExactType();
      }
      
      override public function get width() : Number
      {
         return this._effect != null ? Number(this._effect.width) : Number(275);
      }
      
      override public function get height() : Number
      {
         return this._effect != null ? Number(this._effect.height) : Number(177);
      }
      
      override public function set width(param1:Number) : void
      {
         param1 = UtilMath.boundaryCheck(param1,this.minWidth,this.maxWidth);
         if(this._effect)
         {
            this._effect.width = param1;
         }
         if(this.motionData)
         {
            this.motionData.ssp.x = param1 / 2;
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
      }
      
      override public function set height(param1:Number) : void
      {
         param1 = UtilMath.boundaryCheck(param1,this.minHeight,this.maxHeight);
         if(this._effect)
         {
            this._effect.height = param1;
         }
         if(this.motionData)
         {
            this.motionData.ssp.y = param1 / 2;
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
      }
      
      public function resize(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         if(param1 != this.width || param2 != this.height)
         {
            this.width = param1;
            this.height = param2;
         }
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function set status(param1:String) : void
      {
         if(param1 == STATUS_SHOW || param1 == STATUS_HIDE)
         {
            this._status = param1;
         }
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:EffectAsset = new EffectAsset();
         _loc3_.id = this.id;
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.effect = this.effect;
         _loc3_.scene = this.scene;
         _loc3_.thumb = this.thumb;
         return _loc3_;
      }
      
      public function updateTimeByScene(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 / param2;
         if(this.sttime != -1 && this.edtime != -1)
         {
            this.sttime *= _loc3_;
            this.edtime *= _loc3_;
            this.sttime = Util.roundNum(this.sttime);
            this.edtime = Util.roundNum(this.edtime);
         }
         if(this.stzoom != AnimeConstants.ZOOM_DURATION)
         {
            this.stzoom *= _loc3_;
            this.stzoom = Util.roundNum(this.stzoom);
         }
         if(this.edzoom != AnimeConstants.ZOOM_DURATION)
         {
            this.edzoom *= _loc3_;
            this.edzoom = Util.roundNum(this.edzoom);
         }
      }
      
      protected function updateObjectPosition(param1:Object) : void
      {
      }
      
      private function fillBackground() : void
      {
      }
      
      public function showMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:ScrollableArrowMenu = null;
         var _loc3_:* = "";
         var _loc6_:Boolean = true;
         if(Console.getConsole().stageScale > 1 && (this.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase())
         {
            _loc6_ = false;
         }
         _loc3_ = "<root><menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SHOW) + "\"value=\"" + MENU_LABEL_SHOW + "\"enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_HIDE) + "\"value=\"" + MENU_LABEL_HIDE + "\" enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_EDIT) + "\"value=\"" + MENU_LABEL_EDIT + "\" />" + "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_DELETE) + "\"value=\"" + MENU_LABEL_DELETE + "\"/></root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = ScrollableArrowMenu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         _loc5_.show(param1 - 80,param2);
      }
      
      public function doMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:XML = XML(param1.item);
         if(_loc2_.attribute("value").toString() == MENU_LABEL_SHOW)
         {
            Console.getConsole().mainStage.sceneEditor.view.showEffect(this);
            this.status = STATUS_SHOW;
         }
         else if(_loc2_.attribute("value").toString() == MENU_LABEL_HIDE)
         {
            Console.getConsole().mainStage.sceneEditor.view.hideEffect(this);
            this.status = STATUS_HIDE;
         }
         else if(_loc2_.attribute("value").toString() == MENU_LABEL_DELETE)
         {
            if((this.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase() && Console.getConsole().stageScale != 1)
            {
               Console.getConsole().lookOut();
            }
            this.deleteAsset();
            this.scene.selectedAsset = null;
         }
         else if(_loc2_.attribute("value").toString() == MENU_LABEL_EDIT || param1.currentTarget is Console)
         {
            this.scene.selectedAsset = this;
            Console.getConsole().mainStage.sceneEditor.controller.showControl();
         }
      }
      
      public function showInfoWindow() : void
      {
         var _loc1_:Boolean = this.effect is ZoomEffect && (ZoomEffect(this.effect).isPan || ZoomEffect(this.effect).isCut);
         var _loc2_:AssetInfoWindow = AssetInfoWindow(PopUpManager.createPopUp(Console.getConsole().mainStage,AssetInfoWindow,true));
         _loc2_.mode = _loc2_.LEN_MODE;
         _loc2_.type = !!_loc1_ ? "Cut/Pan" : this.effect.type;
         _loc2_.thumb = thumb;
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
         _loc2_.durscene = this.scene.getLength();
         _loc2_.assetId = this.id;
         if(this.sttime > -1 && this.edtime > -1)
         {
            _loc2_.sttime = this.sttime;
            _loc2_.edtime = this.edtime;
         }
         if((this.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase() && !_loc1_)
         {
            _loc2_.stzoom = this.stzoom;
            _loc2_.edzoom = this.edzoom;
         }
      }
      
      public function stopEffect() : void
      {
      }
      
      public function playEffect() : void
      {
      }
      
      override public function set imageData(param1:Object) : void
      {
         if(super.imageData != param1 || super.imageData == null)
         {
            super.imageData = param1;
            this.loadAssetImage();
         }
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc1_:SuperEffect = null;
         if(this._myEffectXML == null)
         {
            _loc1_ = (this.thumb as EffectThumb).getNewEffect();
         }
         else
         {
            _loc1_ = (this.thumb as EffectThumb).getNewEffect(this._myEffectXML);
         }
         this.effect = _loc1_;
      }
      
      protected function loadAssetImageComplete(param1:EffectEvt) : void
      {
         var _loc4_:Class = null;
         var _loc2_:Loader = param1.getData() as Loader;
         if(this is AnimeEffectAsset && _loc2_.content.loaderInfo.applicationDomain.hasDefinition("theSound"))
         {
            _loc4_ = _loc2_.content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
            this.sound = new _loc4_();
            this.dispatchEvent(new Event("SoundAdded"));
         }
         var _loc3_:SuperEffect = param1.getEventCreater() as SuperEffect;
         _loc3_.name = AnimeConstants.IMAGE_OBJECT_NAME;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      override public function unloadAssetImage(param1:Boolean) : void
      {
         if(this.effect is AnimeEffect)
         {
            AnimeEffect(this.effect).unloadEffectImage(param1);
            this.imageData = null;
         }
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Theme = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         this._myEffectXML = param1.child(EffectMgr.XML_NODE_TAG)[0];
         if(param1.child("file").length() > 0)
         {
            _loc9_ = UtilXmlInfo.getZipFileNameOfEffect(param1.file);
            _loc6_ = UtilXmlInfo.getThemeIdFromFileName(_loc9_);
            _loc10_ = UtilXmlInfo.getThumbIdFromFileName(_loc9_);
         }
         else
         {
            _loc6_ = getThemeIdFromAssetXml(param1);
         }
         _loc7_ = ThemeManager.instance.getTheme(_loc6_);
         _loc5_ = EffectMgr.getId(this._myEffectXML);
         var _loc8_:EffectThumb = _loc7_.getEffectThumbById(_loc5_);
         this.scene = param2;
         this.x = param1.@x;
         this.y = param1.@y;
         if(param1.child("st").length() > 0 && param1.child("et").length() > 0)
         {
            this.sttime = UtilUnitConvert.frameToTime(param1.st);
            this.edtime = UtilUnitConvert.frameToTime(param1.et,false);
            if(param1.child("st").@dur > -1 && param1.child("et").@dur > -1)
            {
               this.stzoom = UtilUnitConvert.frameToDuration(param1.st.@dur);
               this.edzoom = UtilUnitConvert.frameToDuration(param1.et.@dur);
            }
         }
         else
         {
            this.sttime = -1;
            this.edtime = -1;
         }
         if(param4)
         {
            this.thumb = _loc8_;
         }
         else
         {
            super.thumb = _loc8_;
         }
         this.isLoadded = true;
      }
      
      public function checkEffectAssetSize() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = this.effect.width;
         var _loc2_:Number = this.effect.height;
         if(_loc1_ > AnimeConstants.SCREEN_WIDTH)
         {
            _loc3_ = AnimeConstants.SCREEN_WIDTH / _loc1_;
            _loc1_ *= _loc3_;
            _loc2_ *= _loc3_;
         }
         if(_loc2_ > AnimeConstants.SCREEN_HEIGHT)
         {
            _loc3_ = AnimeConstants.SCREEN_HEIGHT / _loc2_;
            _loc1_ *= _loc3_;
            _loc2_ *= _loc3_;
         }
         this.updateObjectPosition(this);
         this.effect.setSize(_loc1_,_loc2_);
         this.width = _loc1_;
         this.height = _loc2_;
      }
      
      public function isMotionShadow() : Boolean
      {
         return this._isShadow;
      }
      
      public function set isShadow(param1:Boolean) : void
      {
         this._isShadow = param1;
         if(this.effect is ZoomEffect)
         {
            ZoomEffect(this.effect).isShadow = true;
         }
      }
      
      public function get isShadow() : Boolean
      {
         return this._isShadow;
      }
      
      private function getShadowIndex(param1:AnimeScene) : int
      {
         return param1.background == null ? 0 : 1;
      }
      
      public function get shadow() : Object
      {
         return this._motionShadow;
      }
      
      public function addMotionShadow(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null) : void
      {
         var _loc5_:EffectAsset = null;
         if(!this.isMotionShadow())
         {
            if(this.motionShadow == null)
            {
               _loc5_ = EffectAsset(this.clone());
               _loc5_.width *= 0.8;
               _loc5_.height *= 0.8;
               _loc5_.x += 10;
               _loc5_.y += 10;
               if(!(param1 == null && param2 == null && param3 == null && param4 == null))
               {
                  _loc5_.width = param3[param3.length - 1];
                  _loc5_.height = param4[param4.length - 1];
                  _loc5_.x = param1[param1.length - 1];
                  _loc5_.y = param2[param2.length - 1];
               }
               this.motionShadow = EffectAsset(_loc5_.clone());
               this.motionShadow.fromTray = false;
               this.motionShadow.isShadow = true;
               this.motionShadow.addEventListener(AssetEvent.ASSET_RESIZED,this.onShadowMoved);
               this.motionShadow.addEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
               if(this.motionShadow is ProgramEffectAsset)
               {
                  ProgramEffectAsset(this.motionShadow).needControl = true;
               }
               this._motionData = new MotionData();
               this._motionData.maxInterPointNum = 0;
               this._motionData.startPoint = new Point(this.x,this.y);
               this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
               this._motionData.ssp = new Point(this.width / 2,this.height / 2);
               this._motionData.esp = new Point(this.motionShadow.width / 2,this.motionShadow.height / 2);
               this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
            }
            this.showMotionShadow();
         }
      }
      
      public function removeMotionShadow() : void
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
      
      public function refreshMotionShadow() : void
      {
         if(this.effect is ZoomEffect)
         {
            if(ZoomEffect(this.effect).isPan)
            {
               this.drawMotionLine();
               if(this.motionShadow == null)
               {
                  if(!this.isMotionShadow())
                  {
                     this.addMotionShadow();
                  }
               }
            }
         }
      }
      
      public function set motionData(param1:MotionData) : void
      {
         if(param1)
         {
            this.motionShadow = null;
            this.refreshMotionShadow();
            if(this.motionShadow)
            {
               this.motionShadow.x = this.x + param1.displacement.x;
               this.motionShadow.y = this.y + param1.displacement.y;
            }
            this._motionData = new MotionData();
            this._motionData.startPoint = new Point(this.x,this.y);
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this._motionData.ssp = new Point(this.width / 2,this.height / 2);
            this._motionData.esp = new Point(this.motionShadow.width / 2,this.motionShadow.height / 2);
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      public function get slideEnabled() : Boolean
      {
         if(this.effect is ZoomEffect && ZoomEffect(this.effect).isPan)
         {
            return true;
         }
         return false;
      }
      
      public function get isSliding() : Boolean
      {
         if(this.effect is ZoomEffect && ZoomEffect(this.effect).isPan)
         {
            return true;
         }
         return false;
      }
      
      public function startSlideMotion() : void
      {
      }
      
      public function removeSlideMotion() : void
      {
         this._motionShadow = null;
         this._motionData = null;
         this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
      }
      
      protected function getOrigin() : Point
      {
         return new Point();
      }
      
      protected function drawMotionLine(param1:Event = null) : void
      {
      }
      
      function clearMotionLine() : void
      {
      }
      
      function showMotionShadow() : void
      {
      }
      
      public function hideMotionShadow() : void
      {
         this.clearMotionLine();
      }
      
      public function get isCamera() : Boolean
      {
         if(this.effect is ZoomEffect)
         {
            return true;
         }
         return false;
      }
      
      override public function serialize() : String
      {
         return "";
      }
      
      override public function set thumb(param1:IThumb) : void
      {
         super.thumb = param1;
         this.imageData = param1.imageData;
      }
      
      public function redraw() : void
      {
         this._effect.redraw();
      }
      
      public function startDragging() : void
      {
         Console.getConsole().currDragObject = this;
      }
   }
}
