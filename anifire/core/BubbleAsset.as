package anifire.core
{
   import anifire.assets.geom.AssetRotation;
   import anifire.assets.motion.ICircularMotion;
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleEvent;
   import anifire.bubble.BubbleMgr;
   import anifire.command.ChangeBubbleCommand;
   import anifire.command.ICommand;
   import anifire.command.MoveBubbleTailCommand;
   import anifire.constant.AnimeConstants;
   import anifire.control.ControlEvent;
   import anifire.errors.SerializeError;
   import anifire.events.AssetEvent;
   import anifire.events.BubbleAssetEvent;
   import anifire.font.FontChooser;
   import anifire.font.FontFamilyComboBox;
   import anifire.interfaces.IBubble;
   import anifire.interfaces.IBubbleTail;
   import anifire.interfaces.IBubbleText;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IMotion;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IResizable;
   import anifire.interfaces.IRotatable;
   import anifire.interfaces.IScalable;
   import anifire.interfaces.ISlidable;
   import anifire.interfaces.IThumb;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import anifire.util.UtilMath;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class BubbleAsset extends Asset implements IDraggable, IRotatable, IMovable, IBubble, IResizable, IBubbleText, IBubbleTail, ISlidable, IMotion, IScalable
   {
      
      private static var _logger:ILogger = Log.getLogger("core.BubbleAsset");
      
      public static const MENU_LABEL_EDIT:String = "effecttray_edit";
      
      public static var XML_NODE_NAME:String = "bubbleAsset";
       
      
      private var _fromTray:Boolean = false;
      
      private var _readyToDrag:Boolean = false;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _originalBubbleWidth:Number;
      
      private var _originalBubbleHeight:Number;
      
      private var _originalTailX:Number;
      
      private var _originalTailY:Number;
      
      private var _originalAssetXML:XML;
      
      private var _bubble:Bubble;
      
      private var _editing:Boolean;
      
      private var _fontChooser:FontChooser;
      
      private var _sttime:Number = -1;
      
      private var _edtime:Number = -1;
      
      private var _fxDuration:Number;
      
      private var _fxName:String;
      
      protected var _myBubbleXML:XML = null;
      
      private var _tailX:Number = 0;
      
      private var _tailY:Number = 0;
      
      private var _motionData:MotionData;
      
      private var _shadowParent:BubbleAsset;
      
      private var _motionShadowBubble:BubbleAsset;
      
      private var _rotation:AssetRotation;
      
      private var _referencePoint:Point;
      
      private var _circularMotion:ICircularMotion;
      
      private var _prevTailX:Number;
      
      private var _prevTailY:Number;
      
      private var _isShadow:Boolean = false;
      
      public function BubbleAsset(param1:String = "")
      {
         this._rotation = new AssetRotation();
         this._referencePoint = new Point(-1,-1);
         super();
         if(param1 == "")
         {
            param1 = "BUBBLE" + this.assetCount;
         }
         this.id = param1;
      }
      
      public static function get promptInputText() : String
      {
         return UtilDict.toDisplay("go","Double-click to input text");
      }
      
      public function get shadow() : Object
      {
         return this._motionShadowBubble;
      }
      
      public function get motionData() : MotionData
      {
         return this._motionData;
      }
      
      public function get motionShadow() : BubbleAsset
      {
         return this._motionShadowBubble;
      }
      
      public function set motionShadow(param1:BubbleAsset) : void
      {
         if(this._motionShadowBubble)
         {
            this._motionShadowBubble.removeEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
         }
         this._motionShadowBubble = param1;
         if(this._motionShadowBubble)
         {
            this._motionShadowBubble.addEventListener(AssetEvent.ASSET_MOVED,this.onShadowMoved);
         }
      }
      
      override public function get minWidth() : Number
      {
         return 20;
      }
      
      override public function get minHeight() : Number
      {
         return 20;
      }
      
      public function get hasTail() : Boolean
      {
         if(this._bubble)
         {
            return this._bubble.isTailEnable();
         }
         return true;
      }
      
      public function set fxDuration(param1:Number) : void
      {
         this._fxDuration = param1;
      }
      
      public function get fxDuration() : Number
      {
         return this._fxDuration;
      }
      
      public function set fxName(param1:String) : void
      {
         this._fxName = param1;
      }
      
      public function get fxName() : String
      {
         return this._fxName;
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
      
      public function get text() : String
      {
         return this._bubble.text;
      }
      
      public function set text(param1:String) : void
      {
         this._bubble.text = param1;
         if(this.motionShadow)
         {
            this.motionShadow.text = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_CHANGE,this));
      }
      
      public function get textFont() : String
      {
         return this._bubble.textFont;
      }
      
      public function set textFont(param1:String) : void
      {
         this._bubble.textFont = param1;
         if(this.motionShadow)
         {
            this.motionShadow.textFont = this.bubble.textFont;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_FONT_CHANGE,this));
      }
      
      public function get textSize() : Number
      {
         return this._bubble.textSize;
      }
      
      public function set textSize(param1:Number) : void
      {
         var _loc2_:Point = new Point(this.globalCenter.x,this.globalCenter.y);
         this._bubble.textSize = param1;
         if(this.motionShadow)
         {
            this.motionShadow.textSize = param1;
         }
         if(!this.isShadow)
         {
            this.scaleX = 1;
            this.scaleY = 1;
            this.move(this.x + _loc2_.x - this.globalCenter.x,this.y + _loc2_.y - this.globalCenter.y);
            this.setReferencePoint(this.globalCenter.x,this.globalCenter.y);
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_SIZE_CHANGE,this));
      }
      
      public function get autoTextResize() : Boolean
      {
         return this._bubble.autoTextResize;
      }
      
      public function set autoTextResize(param1:Boolean) : void
      {
         this._bubble.autoTextResize = param1;
         if(this.motionShadow)
         {
            this.motionShadow.autoTextResize = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.AUTO_TEXT_RESIZE_CHANGE,this));
      }
      
      public function get textAlign() : String
      {
         return this._bubble.textAlign;
      }
      
      public function set textAlign(param1:String) : void
      {
         this._bubble.textAlign = param1;
         if(this.motionShadow)
         {
            this.motionShadow.textAlign = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_ALIGN_CHANGE,this));
      }
      
      public function get textBold() : Boolean
      {
         return this._bubble.textBold;
      }
      
      public function set textBold(param1:Boolean) : void
      {
         this._bubble.textBold = param1;
         if(this.motionShadow)
         {
            this.motionShadow.textBold = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_BOLD_CHANGE,this));
      }
      
      public function get textItalic() : Boolean
      {
         return this._bubble.textItalic;
      }
      
      public function set textItalic(param1:Boolean) : void
      {
         this._bubble.textItalic = param1;
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_STYLE_CHANGE,this));
      }
      
      public function get textEmbed() : Boolean
      {
         return this._bubble.textEmbed;
      }
      
      public function set textEmbed(param1:Boolean) : void
      {
         var _loc2_:Point = null;
         this._bubble.textEmbed = param1;
         if(this.motionShadow)
         {
            this.motionShadow.textEmbed = this.bubble.textEmbed;
         }
         if(!param1)
         {
            _loc2_ = new Point(this.globalCenter.x,this.globalCenter.y);
            this.scaleX = 1;
            this.scaleY = 1;
            if(this.rotation != 0)
            {
               this.rotation = 0;
            }
            this.move(this.x + _loc2_.x - this.globalCenter.x,this.y + _loc2_.y - this.globalCenter.y);
            this.setReferencePoint(this.globalCenter.x,this.globalCenter.y);
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_EMBED_CHANGE,this));
      }
      
      function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      public function get bubble() : Bubble
      {
         return this._bubble;
      }
      
      public function set bubble(param1:Bubble) : void
      {
         this._bubble = param1;
      }
      
      public function resizeBubble(param1:Rectangle) : void
      {
         if(param1 && this._bubble)
         {
            this._bubble.x = param1.x;
            this._bubble.y = param1.y;
            this._bubble.setSize(param1.width,param1.height);
            this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.BUBBLE_RESIZED,this));
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
         }
         if(this.motionShadow)
         {
            this.motionShadow.resizeBubble(param1);
         }
      }
      
      public function get bubbleSize() : Rectangle
      {
         var _loc1_:Rectangle = null;
         if(this._bubble)
         {
            _loc1_ = new Rectangle(this._bubble.x,this._bubble.y,this._bubble.width,this._bubble.height);
         }
         return _loc1_;
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
      
      public function get globalCenter() : Point
      {
         var _loc1_:Point = new Point();
         if(this.bubble)
         {
            _loc1_.offset(this.bubble.x + this.bubble.width / 2,this.bubble.y + this.bubble.height / 2);
         }
         var _loc2_:Matrix = new Matrix();
         _loc2_.scale(this.scaleX,this.scaleY);
         _loc2_.rotate(this.rotation * Math.PI / 180);
         _loc2_.translate(this.x,this.y);
         return _loc2_.transformPoint(_loc1_);
      }
      
      override public function get width() : Number
      {
         return !!this._bubble ? Number(this._bubble.width) : Number(0);
      }
      
      override public function set width(param1:Number) : void
      {
         param1 = UtilMath.boundaryCheck(param1,this.minWidth,this.maxWidth);
         if(this._bubble)
         {
            this._bubble.width = this.width;
         }
         if(this.motionShadow)
         {
            this.motionShadow.width = param1;
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
         this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
      }
      
      override public function get height() : Number
      {
         return !!this._bubble ? Number(this._bubble.height) : Number(0);
      }
      
      override public function set height(param1:Number) : void
      {
         param1 = UtilMath.boundaryCheck(param1,this.minHeight,this.maxHeight);
         if(this._bubble)
         {
            this._bubble.height = this.height;
         }
         if(this.motionShadow)
         {
            this.motionShadow.height = param1;
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED,this));
         this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
      }
      
      public function resize(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         if(param1 != this.width || param2 != this.height)
         {
            this.width = param1;
            this.height = param2;
         }
      }
      
      public function get tailX() : Number
      {
         return !!this._bubble ? Number(this._bubble.tailx) : Number(0);
      }
      
      public function get tailY() : Number
      {
         return !!this._bubble ? Number(this._bubble.taily) : Number(0);
      }
      
      public function get textColor() : uint
      {
         return this._bubble.textRgb;
      }
      
      public function set textColor(param1:uint) : void
      {
         this._bubble.textRgb = param1;
         if(this.motionShadow)
         {
            this.motionShadow.textColor = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_COLOR_CHANGE,this));
      }
      
      public function set tailX(param1:Number) : void
      {
         this._bubble.tailx = param1;
         if(this.motionShadow)
         {
            this.motionShadow.tailX = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TAIL_MOVED,this));
      }
      
      public function set tailY(param1:Number) : void
      {
         this._bubble.taily = param1;
         if(this.motionShadow)
         {
            this.motionShadow.tailY = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TAIL_MOVED,this));
      }
      
      public function getOriginalBubbleSize() : Point
      {
         return new Point(this._originalBubbleWidth,this._originalBubbleHeight);
      }
      
      public function updateOriginalBubbleSize() : void
      {
         this._originalBubbleWidth = this.bubble.width;
         this._originalBubbleHeight = this.bubble.height;
      }
      
      public function getOriginalTailPosition() : Point
      {
         return new Point(this._originalTailX,this._originalTailY);
      }
      
      public function updateOriginalTailPosition() : void
      {
         this._originalTailX = this.bubble.tailx;
         this._originalTailY = this.bubble.taily;
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
      }
      
      override public function cloneNext() : Asset
      {
         var _loc1_:BubbleAsset = this.clone() as BubbleAsset;
         if(_loc1_.motionShadow)
         {
            _loc1_.x = _loc1_.motionShadow.x;
            _loc1_.y = _loc1_.motionShadow.y;
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
         var _loc3_:BubbleAsset = null;
         try
         {
            _loc3_ = new BubbleAsset();
            _loc3_._myBubbleXML = this.bubble.serialize();
            _loc3_.id = this.id;
            _loc3_.setReferencePoint(this.referenceX,this.referenceY);
            _loc3_.move(this.x,this.y);
            _loc3_.scaleX = this.scaleX;
            _loc3_.scaleY = this.scaleY;
            _loc3_.rotation = this.rotation;
            _loc3_.scene = this.scene;
            _loc3_.thumb = this.thumb;
            _loc3_.attachedBg = this.attachedBg;
            if(this.motionData)
            {
               _loc3_.motionData = this.motionData.clone();
            }
            if(this.motionShadow)
            {
               _loc3_.motionShadow = this.motionShadow.clone() as BubbleAsset;
            }
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
      
      override public function get shouldBeCopyToNextScene() : Boolean
      {
         if(this.bubble && this.bubble.isTailEnable())
         {
            return false;
         }
         return true;
      }
      
      private function onStageMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
      }
      
      private function onTextChangedHandler(param1:BubbleEvent) : void
      {
         var _loc2_:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         this.text = _loc2_.filter(this.text);
         this.scene.doUpdateTimelineLength(-1,true);
      }
      
      private function onBubbleTextSizeChange(param1:Event) : void
      {
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.TEXT_SIZE_CHANGE,this));
      }
      
      public function showMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:ScrollableArrowMenu = null;
         var _loc3_:* = "";
         _loc3_ = "<root><menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_EDIT) + "\"/>" + "</root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = ScrollableArrowMenu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         _loc5_.show(param1 - 80,param2);
      }
      
      public function doMenuClick(param1:MenuEvent) : void
      {
         this.scene.selectedAsset = this;
         Console.getConsole().mainStage.sceneEditor.controller.showControl();
      }
      
      public function set bgColor(param1:uint) : void
      {
         this._bubble.fillRgb = param1;
         if(this.motionShadow)
         {
            this.motionShadow.bgColor = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.BG_COLOR_CHANGE,this));
      }
      
      public function get bgColor() : uint
      {
         return this._bubble.fillRgb;
      }
      
      public function set bgAlpha(param1:uint) : void
      {
         this._bubble.fillAlpha = param1;
         if(this.motionShadow)
         {
            this.motionShadow.bgAlpha = param1;
         }
         this.dispatchEvent(new BubbleAssetEvent(BubbleAssetEvent.BG_COLOR_CHANGE,this));
      }
      
      public function get bgAlpha() : uint
      {
         return this._bubble.fillAlpha;
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc1_:XML = XML(this.imageData);
         if(this._myBubbleXML == null)
         {
            this._bubble = BubbleMgr.getBubbleByXML(_loc1_);
         }
         else
         {
            this._bubble = BubbleMgr.getBubbleByXML(XML(this._myBubbleXML));
         }
         this._bubble.promptText = promptInputText;
         this._bubble.addEventListener(BubbleEvent.TEXT_CHANGED,this.onTextChangedHandler);
         this._bubble.addEventListener(BubbleEvent.TEXT_SIZE_CHANGED,this.onBubbleTextSizeChange);
         if(this._fromTray)
         {
            if(this._bubble.text == _loc1_.text.text())
            {
            }
            this._bubble.bubbleText = promptInputText;
         }
         else if(this._bubble.text == "")
         {
         }
         if(this._bubble.text == "")
         {
            this._bubble.bubbleText = promptInputText;
         }
         var _loc2_:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         this.text = _loc2_.filter(this.text);
         this._bubble.useDeviceFont = true;
         this.setReferencePoint(this.globalCenter.x,this.globalCenter.y);
      }
      
      public function setSize(param1:Number) : void
      {
         var _loc2_:Number = this.bubble.width * param1;
         var _loc3_:Number = this.bubble.height * param1;
         _loc2_ = Math.max(_loc2_,this.minWidth);
         _loc3_ = Math.max(_loc3_,this.minHeight);
         var _loc4_:Number;
         if((_loc4_ = this.bubble.height / this.bubble.width) > 1)
         {
            _loc3_ = _loc4_ * _loc2_;
         }
         else
         {
            _loc2_ = _loc3_ / _loc4_;
         }
         param1 = _loc3_ / this.bubble.height;
         this.bubble.x += (this.bubble.width - _loc2_) / 2;
         this.bubble.y += (this.bubble.height - _loc3_) / 2;
         this.bubble.setTail(this.bubble.tailx * param1 + (this.bubble.width - _loc2_) / 2,this.bubble.taily * param1 + (this.bubble.height - _loc3_) / 2);
         this.bubble.setSize(_loc2_,_loc3_);
      }
      
      function doTailMoveStart(param1:Event) : void
      {
         var _loc2_:Bubble = null;
         try
         {
            _loc2_ = Bubble(param1.target.asset);
            this._originalAssetXML = _loc2_.serialize();
            this._prevTailX = _loc2_.tailx;
            this._prevTailY = _loc2_.taily;
         }
         catch(e:Error)
         {
         }
      }
      
      function doTailMove(param1:Event) : void
      {
         if(this._editing)
         {
            this.doEditComplete(param1);
         }
         var _loc2_:Bubble = Bubble(param1.target.asset);
         var _loc3_:Number = param1.target.xTailOffset;
         var _loc4_:Number = param1.target.yTailOffset;
         _loc2_.setTail(this._prevTailX + _loc3_,this._prevTailY + _loc4_);
         this.tailX = this._prevTailX + _loc3_;
         this.tailY = this._prevTailY + _loc4_;
      }
      
      function doTailMoveComplete(param1:Event) : void
      {
         var _loc2_:ICommand = null;
         try
         {
            if(this._originalAssetXML != this._bubble.serialize())
            {
               _loc2_ = new MoveBubbleTailCommand(id,this._originalAssetXML);
               _loc2_.execute();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onCallLaterHandler(param1:ControlEvent) : void
      {
         var _loc2_:XML = null;
         var _loc3_:ICommand = null;
         try
         {
            scene.selectedAsset = this;
            _loc2_ = this.bubble.serialize();
            _loc3_ = new ChangeBubbleCommand(id,_loc2_);
            _loc3_.execute();
         }
         catch(e:Error)
         {
         }
      }
      
      public function get bubbleObject() : Object
      {
         if(this._bubble)
         {
            return this._bubble.bubbleObject;
         }
         return null;
      }
      
      override public function convertToXml() : XML
      {
         var index:uint = 0;
         var xml:XML = <bubbleAsset/>;
         try
         {
            index = this.scene.getOverallOrdering(this);
            xml.@id = this.id;
            xml.@index = String(index);
            xml.x = this.serializeMotion("x",this.motionShadow);
            xml.y = this.serializeMotion("y",this.motionShadow);
            xml.xscale = this.serializeMotion("xscale",this.motionShadow);
            xml.yscale = this.serializeMotion("yscale",this.motionShadow);
            xml.rotation = this.serializeMotion("rotation",this.motionShadow);
            if(this.sttime > -1 && this.edtime > -1)
            {
               if(UtilUnitConvert.secToFrame(this.sttime) <= this.scene.getLength(-1,false) && UtilUnitConvert.secToFrame(this.edtime) <= this.scene.getLength(-1,false))
               {
                  xml.st = UtilUnitConvert.timeToFrame(this.sttime);
                  xml.et = UtilUnitConvert.timeToFrame(this.edtime) - 1;
               }
            }
            if(!this.hasTail)
            {
               this.fxName = "easeNone";
               this.fxDuration = 0;
               xml.fx = this.fxName;
               xml.fxdur = this.fxDuration;
            }
            if(this._motionData)
            {
               xml.appendChild(this._motionData.convertToXml());
            }
            xml.appendChild(this._bubble.serialize());
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize bubble asset: " + this.id);
         }
         return xml;
      }
      
      override public function serialize() : String
      {
         return this.convertToXml().toXMLString();
      }
      
      public function serializeMotion(param1:String, param2:BubbleAsset) : Array
      {
         var tempArray:Array = null;
         var i:int = 0;
         var property:String = param1;
         var shadow:BubbleAsset = param2;
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
               case "refX":
                  tempArray.push(Util.roundNum(this.referenceX));
                  break;
               case "refY":
                  tempArray.push(Util.roundNum(this.referenceY));
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
                     break;
                  case "refX":
                     i = 1;
                     while(i < this.motionData.path.length - 1)
                     {
                        tempArray.push(Util.roundNum(Point(this.motionData.path[i]).x));
                        i++;
                     }
                     break;
                  case "refY":
                     i = 1;
                     while(i < this.motionData.path.length - 1)
                     {
                        tempArray.push(Util.roundNum(Point(this.motionData.path[i]).y));
                        i++;
                     }
               }
            }
            if(shadow)
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
                  case "refX":
                     tempArray.push(Util.roundNum(shadow.referenceX));
                     break;
                  case "refY":
                     tempArray.push(Util.roundNum(shadow.referenceY));
                     break;
                  case "rotation":
                     tempArray.push(Util.roundNum(shadow.rotation));
               }
            }
         }
         catch(e:Error)
         {
            throw new SerializeError("Failed to serialize bubble motion " + this.id,tempArray.toString(),e);
         }
         return tempArray;
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene) : void
      {
         var _loc3_:BubbleThumb = new BubbleThumb();
         _loc3_.imageData = param1.bubble;
         this.scene = param2;
         this._xs = String(param1.x).split(",");
         this._ys = String(param1.y).split(",");
         this.move(this._xs[0],this._ys[0]);
         this.setReferencePoint(this._xs[0],this._ys[0]);
         if(param1.hasOwnProperty("xscale"))
         {
            this._scaleXs = String(param1.xscale).split(",");
            this._scaleYs = String(param1.yscale).split(",");
            this.scaleX = this._scaleXs[0];
            this.scaleY = this._scaleYs[0];
         }
         if(param1.hasOwnProperty("ref"))
         {
            this.setReferencePoint(Number(param1.ref.@x),Number(param1.ref.@y));
         }
         if(param1.hasOwnProperty("rotation"))
         {
            _rotations = String(param1.rotation).split(",");
            this._rotation.rotation = _rotations[0];
         }
         if(param1.child("st").length() > 0 && param1.child("st").length() > 0)
         {
            this.sttime = UtilUnitConvert.frameToTime(param1.st);
            this.edtime = UtilUnitConvert.frameToTime(param1.et,false);
         }
         else
         {
            this.sttime = -1;
            this.edtime = -1;
         }
         _loc3_.colorStyle = param1.bubble.@colorStyle.length() > 0 ? int(param1.bubble.@colorStyle) : 1;
         this.thumb = _loc3_;
         this.isLoadded = true;
         if(this.shouldHasMotion())
         {
            this.addMotionShadow(this._xs,this._ys,this._rotations,this._scaleXs,this._scaleYs);
            this.fillMaskPoint();
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
      
      public function shouldHasMotion() : Boolean
      {
         if(Math.max(this._xs.length,this._ys.length) > 1)
         {
            return true;
         }
         return false;
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
            _loc1_.push(new Point(this.x,this.y));
            _loc2_ = 1;
            while(_loc2_ < this._xs.length - 1)
            {
               _loc1_.push(new Point(Number(_xs[_loc2_]),Number(_ys[_loc2_])));
               _loc2_++;
            }
            _loc1_.push(new Point(this.motionShadow.x,this.motionShadow.y));
            this._motionData.path = _loc1_;
            this._motionData.startRotation = this.rotation;
            this._motionData.addEventListener(Event.CHANGE,this.onMotionChange);
         }
      }
      
      override public function set thumb(param1:IThumb) : void
      {
         super.thumb = param1;
         this.imageData = param1.imageData;
      }
      
      private function doEditBubbleTextComplete(param1:Event = null) : void
      {
         var _loc2_:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         this.bubble.backupText = this.text;
         this.text = _loc2_.filter(this.text);
         if(this.bubble.backupText != this.text)
         {
            this.bubble.redraw();
         }
      }
      
      private function doEditBegin(param1:Event = null) : void
      {
      }
      
      private function doEditComplete(param1:Event = null) : void
      {
         if(UtilLicense.isBubbleI18NPermitted())
         {
            if(this.bubble.textEmbed)
            {
               if(!this.bubble.checkCharacterSupport())
               {
                  this.bubble.textEmbed = false;
                  if(this._fontChooser != null)
                  {
                     this.bubble.textFont = FontFamilyComboBox.listFonts()[0].data;
                  }
               }
               else
               {
                  this.bubble.textEmbed = true;
               }
            }
         }
         this.editComplete(param1);
      }
      
      private function editComplete(param1:Event = null) : void
      {
         this._editing = false;
         this.doEditBubbleTextComplete();
         this._bubble.hideEditMode();
         if(param1 == null)
         {
         }
         this.scene.doUpdateTimelineLength(-1,true);
      }
      
      public function startDragging() : void
      {
         Console.getConsole().currDragObject = this;
      }
      
      public function stopBubble() : void
      {
         this.bubble.stopBubble();
      }
      
      public function playBubble() : void
      {
         this.bubble.playBubble();
      }
      
      public function startSlideMotion() : void
      {
         if(this.motionShadow == null)
         {
            this._originalX = getSceneCanvas().mouseX;
            this._originalY = getSceneCanvas().mouseY;
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
      
      public function set motionData(param1:MotionData) : void
      {
         if(param1)
         {
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
      
      public function removeSlideMotion() : void
      {
         this._motionShadowBubble = null;
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
      
      private function onMotionChange(param1:Event) : void
      {
         var _loc2_:Point = null;
         if(this.motionData)
         {
            if(this.motionData.pathOriented)
            {
               if(this.motionShadow)
               {
                  this.motionShadow.isRotatable = false;
                  this.motionShadow.rotation = this.motionData.endRotation;
                  _loc2_ = this.motionShadow.globalCenter;
                  this.motionShadow.setReferencePoint(_loc2_.x,_loc2_.y);
               }
            }
            else if(this.motionShadow)
            {
               this.motionShadow.isRotatable = true;
            }
         }
      }
      
      private function refreshControl(... rest) : void
      {
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
      
      public function hasMotion() : Boolean
      {
         if(this.motionShadow == null)
         {
            return false;
         }
         return true;
      }
      
      function getMotionShadow() : BubbleAsset
      {
         if(this.motionShadow != null)
         {
            return this.motionShadow;
         }
         return null;
      }
      
      private function onShadowMoved(param1:Event) : void
      {
         if(this.motionShadow && this._motionData)
         {
            this._motionData.endPoint = new Point(this.motionShadow.x,this.motionShadow.y);
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      public function addMotionShadow(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null, param5:Array = null) : void
      {
         var _loc6_:int = 0;
         var _loc7_:AnimeScene = null;
         var _loc8_:BubbleAsset = null;
         if(!this.isShadow)
         {
            _loc6_ = Console.getConsole().getSceneIndex(scene);
            _loc7_ = Console.getConsole().getScene(_loc6_);
            if(this.motionShadow == null)
            {
               _loc8_ = BubbleAsset(this.clone());
               if(!(param1 == null && param2 == null))
               {
                  _loc8_.setReferencePoint(param1[param1.length - 1],param2[param2.length - 1]);
                  _loc8_.move(param1[param1.length - 1],param2[param2.length - 1]);
               }
               if(param3)
               {
                  _loc8_.rotation = param3[param3.length - 1];
               }
               if(param4 && param5)
               {
                  _loc8_.scaleX = param4[1];
                  _loc8_.scaleY = param5[1];
               }
               this.motionShadow = BubbleAsset(_loc8_.clone());
               this.motionShadow.removeSlideMotion();
               this.motionShadow.isShadow = true;
               this.motionShadow.bubble.mouseChildren = false;
            }
         }
      }
      
      private function snapAsset(param1:Asset) : void
      {
         var _loc2_:int = param1.x > AnimeConstants.STAGE_WIDTH / 2 ? -100 : 100;
         param1.x += _loc2_;
         param1.referenceX += _loc2_;
      }
      
      public function get isShadow() : Boolean
      {
         return this._isShadow;
      }
      
      public function set isShadow(param1:Boolean) : void
      {
         this._isShadow = param1;
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
         return this._rotation.enabled && this.textEmbed;
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
