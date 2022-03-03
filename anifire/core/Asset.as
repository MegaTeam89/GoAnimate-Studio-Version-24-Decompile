package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.command.ICommand;
   import anifire.command.RemoveAssetCommand;
   import anifire.components.studio.AssetToolTip;
   import anifire.constant.CcLibConstant;
   import anifire.control.Control;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IBehavior;
   import anifire.interfaces.IThumb;
   import anifire.interfaces.IXmlConvertable;
   import anifire.util.UtilArray;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashSelectedColor;
   import anifire.util.UtilMath;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import mx.containers.Canvas;
   import mx.controls.TextArea;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class Asset extends EventDispatcher implements IAsset, IXmlConvertable
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Asset");
      
      private static var _assetCount:int = 0;
       
      
      protected var _originalAssetX:Number;
      
      protected var _originalAssetY:Number;
      
      protected var _originalAssetFacing:String;
      
      protected var _originalAssetScaleX:Number;
      
      protected var _originalAssetScaleY:Number;
      
      private var _sizeToolTip:AssetToolTip = null;
      
      private var _capScreenLock:Boolean = false;
      
      private var _mThumbId:String;
      
      private var _id:String;
      
      private var _sound:Sound;
      
      private var _soundChannel:SoundChannel;
      
      private var _imageData:Object;
      
      private var _thumb:IThumb;
      
      private var _scene:AnimeScene;
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      private var _scaleX:Number = 1;
      
      private var _scaleY:Number = 1;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      protected var _xs:Array;
      
      protected var _ys:Array;
      
      protected var _scaleXs:Array;
      
      protected var _scaleYs:Array;
      
      protected var _widths:Array;
      
      protected var _heights:Array;
      
      protected var _rotations:Array;
      
      protected var _facings:Array;
      
      private var _changed:Boolean;
      
      private var _isLoadded:Boolean;
      
      private var _resize:Boolean;
      
      private var _isMovingByKey:Boolean = false;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _soundPos:Number = 0;
      
      private var _customColor:UtilHashSelectedColor;
      
      private var _defaultColorSet:UtilHashSelectedColor;
      
      private var _defaultColorSetId:String = "";
      
      private var _motionDistTip:TextArea;
      
      private var _type:String = "";
      
      private var _attachedBg:Boolean;
      
      private var _referencePoint:Point;
      
      private var _isMusicPlaying:Boolean = false;
      
      public function Asset()
      {
         this._eventDispatcher = new EventDispatcher();
         this._motionDistTip = new TextArea();
         this._referencePoint = new Point(-1,-1);
         super();
         ++_assetCount;
         this.customColor = new UtilHashSelectedColor();
         this.defaultColorSet = new UtilHashSelectedColor();
      }
      
      public function get mThumbId() : String
      {
         return this._mThumbId;
      }
      
      public function set mThumbId(param1:String) : void
      {
         this._mThumbId = param1;
      }
      
      public function get capScreenLock() : Boolean
      {
         return this._capScreenLock;
      }
      
      public function set capScreenLock(param1:Boolean) : void
      {
         this._capScreenLock = param1;
      }
      
      public function get sizeToolTip() : AssetToolTip
      {
         return AssetToolTip.getInstance();
      }
      
      public function setToolTipContent(param1:Number, param2:Number) : void
      {
         this.sizeToolTip.setToolTipContent(param1,param2,1 / Console.getConsole().stageScale);
      }
      
      public function get attachedBg() : Boolean
      {
         return this._attachedBg;
      }
      
      public function set attachedBg(param1:Boolean) : void
      {
         this._attachedBg = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function get minWidth() : Number
      {
         return 3;
      }
      
      public function get minHeight() : Number
      {
         return 3;
      }
      
      public function get maxWidth() : Number
      {
         return 999999;
      }
      
      public function get maxHeight() : Number
      {
         return 999999;
      }
      
      public function updateOriginalAssetPosition() : void
      {
         this._originalAssetX = this.x;
         this._originalAssetY = this.y;
      }
      
      public function getOriginalAssetPosition() : Point
      {
         return new Point(this._originalAssetX,this._originalAssetY);
      }
      
      public function updateOriginalAssetScale() : void
      {
         this._originalAssetScaleX = this._scaleX;
         this._originalAssetScaleY = this._scaleY;
      }
      
      public function getOriginalAssetScale() : Point
      {
         return new Point(this._originalAssetScaleX,this._originalAssetScaleY);
      }
      
      public function get soundPos() : Number
      {
         return this._soundPos;
      }
      
      public function set soundPos(param1:Number) : void
      {
         this._soundPos = param1;
      }
      
      public function set action(param1:IBehavior) : void
      {
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
         var _loc2_:RegExp = /\d/;
         var _loc3_:int = int(param1.substr(param1.search(_loc2_)));
         _assetCount = _loc3_ > _assetCount ? int(_loc3_) : int(_assetCount);
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      public function set sound(param1:Sound) : void
      {
         this._sound = param1;
      }
      
      public function freeze(param1:Boolean = true) : void
      {
      }
      
      public function melt() : void
      {
      }
      
      public function get soundChannel() : SoundChannel
      {
         return this._soundChannel;
      }
      
      public function get isMusicPlaying() : Boolean
      {
         return this._isMusicPlaying;
      }
      
      public function muteSound(param1:Boolean) : void
      {
         if(this.soundChannel != null)
         {
            if(param1)
            {
               this.soundChannel.soundTransform = new SoundTransform(0);
            }
            else
            {
               this.soundChannel.soundTransform = new SoundTransform(1);
            }
         }
      }
      
      public function playMusic(param1:Number = 0, param2:int = 0, param3:SoundTransform = null) : void
      {
      }
      
      private function re_playMusic(param1:TimerEvent) : void
      {
      }
      
      private function repeatMusic(param1:Event) : void
      {
      }
      
      public function stopMusic(param1:Boolean, param2:Boolean = false) : void
      {
      }
      
      public function get imageObject() : DisplayObject
      {
         return null;
      }
      
      public function get movieObject() : DisplayObject
      {
         return null;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function set eventDispatcher(param1:EventDispatcher) : void
      {
         this._eventDispatcher = param1;
      }
      
      public function get control() : Control
      {
         return null;
      }
      
      public function get imageData() : Object
      {
         return this._imageData;
      }
      
      public function set imageData(param1:Object) : void
      {
         if(this._imageData != param1 || this._imageData == null)
         {
            this._imageData = param1;
            if(param1 != null)
            {
               this.loadAssetImage();
            }
         }
      }
      
      public function get thumb() : IThumb
      {
         return this._thumb;
      }
      
      public function set thumb(param1:IThumb) : void
      {
         this._thumb = param1;
      }
      
      public function get scene() : AnimeScene
      {
         return this._scene;
      }
      
      public function set scene(param1:AnimeScene) : void
      {
         this._scene = param1;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         if(param1 != this.x || param2 != this.y)
         {
            this._x = param1;
            this._y = param2;
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED,this));
         }
      }
      
      public function set x(param1:Number) : void
      {
         if(param1 != this.x)
         {
            this._x = param1;
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED,this));
         }
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         if(param1 != this.y)
         {
            this._y = param1;
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED,this));
         }
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(param1:Number) : void
      {
         param1 = UtilMath.boundaryCheck(param1,this.minWidth,this.maxWidth);
         this._width = param1;
         if(this.imageObject && this.imageObject.width > 0)
         {
            this._scaleX = param1 / this.imageObject.width;
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(param1:Number) : void
      {
         param1 = UtilMath.boundaryCheck(param1,this.minHeight,this.maxHeight);
         this._height = param1;
         if(this.imageObject && this.imageObject.height > 0)
         {
            this._scaleY = param1 / this.imageObject.height;
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(this.imageObject && this.imageObject.width > 0 && this.imageObject.width * param1 < this.minWidth)
         {
            this._scaleX = this.minWidth / this.imageObject.width;
         }
         else
         {
            this._scaleX = param1;
         }
         if(this.imageObject && this.imageObject.width > 0)
         {
            this._width = this._scaleX * this.imageObject.width;
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(this.imageObject && this.imageObject.height > 0 && this.imageObject.height * param1 < this.minHeight)
         {
            this._scaleY = this.minHeight / this.imageObject.height;
         }
         else
         {
            this._scaleY = param1;
         }
         if(this.imageObject && this.imageObject.height > 0)
         {
            this._height = this._scaleY * this.imageObject.height;
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function set changed(param1:Boolean) : void
      {
         this._changed = param1;
         if(this.scene)
         {
            this.scene.changed = param1;
         }
      }
      
      public function get isLoadded() : Boolean
      {
         return this._isLoadded;
      }
      
      public function set isLoadded(param1:Boolean) : void
      {
         this._isLoadded = param1;
      }
      
      public function get controlVisible() : Boolean
      {
         return false;
      }
      
      public function set isResize(param1:Boolean) : void
      {
         this._resize = param1;
      }
      
      public function get isResize() : Boolean
      {
         return this._resize;
      }
      
      public function getKey() : String
      {
         return this.thumb.theme.id + "." + this.thumb.id + "." + this.id;
      }
      
      public function serialize() : String
      {
         return null;
      }
      
      protected function initListeners() : void
      {
      }
      
      public function deleteAsset(param1:Boolean = true) : void
      {
         var command:ICommand = null;
         var sound:AnimeSound = null;
         var charId:String = null;
         var undoable:Boolean = param1;
         var soundId:String = Console.getConsole().linkageController.deleteLinkage(this);
         if(undoable)
         {
            if(soundId != "")
            {
               sound = Console.getConsole().speechManager.ttsManager.sounds.getValueByKey(soundId) as AnimeSound;
               charId = this.scene.id + AssetLinkage.LINK + this.id;
               command = new RemoveAssetCommand(sound,charId);
            }
            else
            {
               command = new RemoveAssetCommand();
            }
            command.execute();
         }
         this.stopMusic(true);
         if(this.imageObject is Loader)
         {
            Loader(this.imageObject).unloadAndStop();
         }
         try
         {
         }
         catch(e:ArgumentError)
         {
         }
         if(this is ProgramEffectAsset && ProgramEffectAsset(this).motionShadow != null)
         {
         }
         this._scene.removeAsset(this);
         this.changed = true;
         if(soundId != "")
         {
            Console.getConsole().speechManager.removeSoundById(soundId);
         }
      }
      
      function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         return null;
      }
      
      public function cloneNext() : Asset
      {
         return this.clone();
      }
      
      protected function getSceneCanvas() : Canvas
      {
         return Console.getConsole().mainStage.sceneEditor;
      }
      
      public function unloadAssetImage(param1:Boolean) : void
      {
         this.imageData = null;
      }
      
      protected function loadAssetImage() : void
      {
      }
      
      protected function get assetCount() : int
      {
         return _assetCount;
      }
      
      public function set defaultColorSetId(param1:String) : void
      {
         this._defaultColorSetId = param1;
      }
      
      public function get defaultColorSetId() : String
      {
         return this._defaultColorSetId;
      }
      
      public function set defaultColorSet(param1:UtilHashSelectedColor) : void
      {
         this._defaultColorSet = param1;
      }
      
      public function get defaultColorSet() : UtilHashSelectedColor
      {
         return this._defaultColorSet;
      }
      
      protected function addCustomColor(param1:String, param2:SelectedColor) : void
      {
         this._customColor.push(param1,param2);
      }
      
      public function set customColor(param1:UtilHashSelectedColor) : void
      {
         this._customColor = param1;
      }
      
      public function get customColor() : UtilHashSelectedColor
      {
         return this._customColor;
      }
      
      private function removeCCUsedColor(param1:Array) : Array
      {
         var _loc2_:Array = null;
         return param1.filter(this.isNotInsideCC);
      }
      
      private function isNotInsideCC(param1:Object, param2:int, param3:Array) : Boolean
      {
         if(CcLibConstant.ALL_COLOR_CODE_USED.indexOf(param1 as String) > -1)
         {
            return false;
         }
         return true;
      }
      
      public function get colorableArea() : Array
      {
         return new Array();
      }
      
      public function getColorArea() : Array
      {
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         _loc1_ = UtilPlain.getColorItem(this.movieObject);
         if(_loc1_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc1_.length)
            {
               _loc8_ = (_loc7_ = DisplayObject(_loc1_[_loc6_]).name.split("_"))[1];
               _loc2_.push(_loc8_);
               _loc6_++;
            }
            _loc3_ = UtilArray.removeDuplicates(_loc2_,true);
         }
         var _loc5_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < this.thumb.colorParts.length)
         {
            _loc5_.push(this.thumb.colorParts.getKey(_loc6_));
            _loc6_++;
         }
         _loc4_ = _loc3_.concat(_loc5_);
         _loc4_ = this.removeCCUsedColor(_loc4_);
         return UtilArray.removeDuplicates(_loc4_,true);
      }
      
      public function isColorable() : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc1_:Boolean = false;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         _loc2_ = UtilPlain.getColorItem(this.movieObject);
         if(_loc2_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc6_ = (_loc5_ = DisplayObject(_loc2_[_loc4_]).name.split("_"))[1];
               _loc3_.push(_loc6_);
               _loc4_++;
            }
         }
         if(this is Character && Character(this).thumb.raceCode > 0)
         {
            _loc3_ = this.removeCCUsedColor(_loc3_);
         }
         else if(this.thumb.colorParts.length > 0)
         {
            _loc1_ = true;
         }
         if(_loc3_.length > 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function doChangeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc3_:Number = 0;
         return Number(this.changeColor(param1,param2));
      }
      
      public function changeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc4_:uint = 0;
         var _loc5_:SelectedColor = null;
         var _loc3_:uint = UtilColor.setAssetPartColor(this.movieObject,param1,param2);
         if(param2 == uint.MAX_VALUE)
         {
            this.customColor.removeByKey(param1);
         }
         else
         {
            _loc4_ = this.thumb.colorParts.getValueByKey(param1) == null ? uint(uint.MAX_VALUE) : uint(this.thumb.colorParts.getValueByKey(param1));
            _loc5_ = new SelectedColor(param1,_loc4_,param2);
            this.addCustomColor(param1,_loc5_);
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.COLOR_CHANGE,this));
         return _loc3_;
      }
      
      public function updateColor() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SelectedColor = null;
         if(this.customColor.length == 0)
         {
            if(!this.thumb.isCC && this.imageObject != null)
            {
               UtilColor.resetAssetPartsColor(this.movieObject);
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.customColor.length)
            {
               _loc2_ = SelectedColor(this.customColor.getValueByIndex(_loc1_));
               this.changeColor(_loc2_.areaName,_loc2_.dstColor);
               _loc1_++;
            }
         }
      }
      
      public function restoreColor() : void
      {
         if(this.defaultColorSet != null && this.defaultColorSet.length > 0)
         {
            this.customColor = this.defaultColorSet.clone();
            this.updateColor();
         }
         else
         {
            this.customColor.removeAll();
            UtilColor.resetAssetPartsColor(this.movieObject);
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.COLOR_CHANGE,this));
      }
      
      public function getBounds(param1:DisplayObject) : Rectangle
      {
         return new Rectangle();
      }
      
      public function get isCopyable() : Boolean
      {
         return true;
      }
      
      public function get shouldBeCopyToNextScene() : Boolean
      {
         if(this.thumb is Thumb)
         {
            return Thumb(this.thumb).shouldBeCopyToNextScene;
         }
         return false;
      }
      
      public function convertToXml() : XML
      {
         return new XML();
      }
      
      public function convertFromXml(param1:XML) : Boolean
      {
         return false;
      }
      
      public function set referenceX(param1:Number) : void
      {
         if(param1 != this.referenceX)
         {
            this._referencePoint.x = param1;
            this.dispatchEvent(new AssetEvent(AssetEvent.REFERENCE_POINT_CHANGED,this));
         }
      }
      
      public function set referenceY(param1:Number) : void
      {
         if(param1 != this.referenceY)
         {
            this._referencePoint.y = param1;
            this.dispatchEvent(new AssetEvent(AssetEvent.REFERENCE_POINT_CHANGED,this));
         }
      }
      
      public function setReferencePoint(param1:Number, param2:Number) : void
      {
         if(param1 != this.referenceX || param2 != this.referenceY)
         {
            this._referencePoint.x = param1;
            this._referencePoint.y = param2;
            this.dispatchEvent(new AssetEvent(AssetEvent.REFERENCE_POINT_CHANGED,this));
         }
      }
      
      public function get referenceX() : Number
      {
         return this._referencePoint.x;
      }
      
      public function get referenceY() : Number
      {
         return this._referencePoint.y;
      }
   }
}
