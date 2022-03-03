package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.core.AnimeSound;
   import anifire.event.ExtraDataEvent;
   import anifire.util.UtilDict;
   import anifire.util.UtilString;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundChannel;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.controls.ToolTip;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.CursorManager;
   import mx.managers.ToolTipManager;
   
   use namespace mx_internal;
   
   public class SoundContainer extends Canvas implements ITimelineContainer, IBindingClient
   {
      
      public static const SOUNDCONTAINER_HEIGHT:int = 19;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1729822083arrow_left:Canvas;
      
      private var _2079216026arrow_right:Canvas;
      
      private var _1812817726soundItem:SoundElement;
      
      private var _734000883soundItem_cs:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _soundReady:Boolean = false;
      
      private var _enableFocus:Boolean = true;
      
      private var _id:String;
      
      private var _indicator:ToolTip;
      
      private var _label:String;
      
      private var _stime:Number = 0;
      
      private var _slength:Number = 100;
      
      private var _timelineControl:Timeline = null;
      
      private var _inner_volume:Number = 1;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _orgObjPos:Point;
      
      private var _items:Array;
      
      private var _focus:Boolean = false;
      
      private var _itemsCollect:ArrayCollection;
      
      private var _currItem:ITimelineElement;
      
      private var _controlCreateStatus:Boolean = false;
      
      private var _controlClickStatus:Boolean = false;
      
      private var _controlPrevX:Number = 0;
      
      private var _controlPrevW:Number = 0;
      
      private const MIN_WIDTH:Number = 30;
      
      private const MAX_WIDTH:Number = 90000;
      
      private var _wingLeft:UIComponent;
      
      private var _wingRight:UIComponent;
      
      public var _wingWidth:Number;
      
      public var _wingHeight:Number;
      
      private var _currDraggedControl:UIComponent;
      
      private var _dragObjPoint:Point;
      
      private var _tempSoundInfo:ElementInfo;
      
      private var _timer:Timer;
      
      private var _tempSoundInfo2:ElementInfo;
      
      private var E_Symbol:Class;
      
      private var _977672194ArrowIcon:Class;
      
      private var _animeSound:AnimeSound;
      
      private var _oldX:Number;
      
      private var _oldWidth:Number;
      
      private var _mouseDown:Point;
      
      private var _boundingRect:Rectangle;
      
      private var isResizing:Boolean = false;
      
      private var cursorID:int = -1;
      
      private var isArrowCursor:Boolean = false;
      
      private var onArrow:Boolean = false;
      
      private var dataObj:Array;
      
      private var _loop:uint = 0;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SoundContainer()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "creationComplete":"___SoundContainer_Canvas1_creationComplete",
               "mouseOver":"___SoundContainer_Canvas1_mouseOver",
               "mouseOut":"___SoundContainer_Canvas1_mouseOut"
            },
            "stylesFactory":function():void
            {
               this.backgroundColor = 16777215;
               this.backgroundAlpha = 0;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":400,
                  "height":300,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"soundItem_cs",
                     "events":{
                        "rollOver":"__soundItem_cs_rollOver",
                        "rollOut":"__soundItem_cs_rollOut"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "left":0,
                           "percentHeight":100,
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off",
                           "clipContent":false,
                           "alpha":0.75,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":SoundElement,
                              "id":"soundItem",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":49,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"arrow_left",
                              "events":{
                                 "rollOver":"__arrow_left_rollOver",
                                 "rollOut":"__arrow_left_rollOut",
                                 "mouseDown":"__arrow_left_mouseDown"
                              },
                              "stylesFactory":function():void
                              {
                                 this.backgroundColor = 16711680;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "alpha":0,
                                    "name":"CONTROL_L",
                                    "width":6,
                                    "percentHeight":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"arrow_right",
                              "events":{
                                 "rollOver":"__arrow_right_rollOver",
                                 "rollOut":"__arrow_right_rollOut",
                                 "mouseDown":"__arrow_right_mouseDown"
                              },
                              "stylesFactory":function():void
                              {
                                 this.backgroundColor = 65280;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "alpha":0,
                                    "name":"CONTROL_R",
                                    "width":6,
                                    "percentHeight":100
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._orgObjPos = new Point();
         this._dragObjPoint = new Point();
         this._tempSoundInfo = new ElementInfo(ElementInfo.SCENE,"");
         this._tempSoundInfo2 = new ElementInfo(ElementInfo.SCENE,"");
         this.E_Symbol = SoundContainer_E_Symbol;
         this._977672194ArrowIcon = SoundContainer_ArrowIcon;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SoundContainer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SoundContainerWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SoundContainer[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 400;
         this.height = 300;
         this.blendMode = "layer";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.clipContent = false;
         this.addEventListener("creationComplete",this.___SoundContainer_Canvas1_creationComplete);
         this.addEventListener("mouseOver",this.___SoundContainer_Canvas1_mouseOver);
         this.addEventListener("mouseOut",this.___SoundContainer_Canvas1_mouseOut);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SoundContainer._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 16777215;
            this.backgroundAlpha = 0;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get soundReady() : Boolean
      {
         return this._soundReady;
      }
      
      public function set soundReady(param1:Boolean) : void
      {
         this._soundReady = param1;
      }
      
      public function set tempSoundInfo(param1:ElementInfo) : void
      {
         this._tempSoundInfo = param1;
      }
      
      public function get tempSoundInfo() : ElementInfo
      {
         return this._tempSoundInfo;
      }
      
      public function set tempSoundInfo2(param1:ElementInfo) : void
      {
         this._tempSoundInfo2 = param1;
      }
      
      public function get tempSoundInfo2() : ElementInfo
      {
         return this._tempSoundInfo2;
      }
      
      public function get animeSound() : AnimeSound
      {
         return this._animeSound;
      }
      
      public function set animeSound(param1:AnimeSound) : void
      {
         if(this._animeSound != param1)
         {
            this._animeSound = param1;
         }
         this.soundItem.animeSound = param1;
      }
      
      private function initApp() : void
      {
         this._items = new Array();
         this._itemsCollect = new ArrayCollection(this._items);
         this.soundItem.setSoundContainerReferer(this);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onSoundElementDownHandler);
         this.addEventListener(TimelineEvent.CONTROL_LEFT_MOVE,this.onControlLeftMoveHandler);
         this.addEventListener(TimelineEvent.CONTROL_RIGHT_MOVE,this.onControlRightMoveHandler);
         this.soundItem.updateLabel(this.getLabel());
         this.mouseEnabled = false;
      }
      
      private function timelineChangeHandler(param1:Event) : void
      {
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      override public function get id() : String
      {
         return this._id;
      }
      
      override public function get label() : String
      {
         return this._label;
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      public function get time() : Number
      {
         return this._stime;
      }
      
      public function get length() : Number
      {
         return this._slength;
      }
      
      public function get count() : int
      {
         return this._itemsCollect.length;
      }
      
      override public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
      }
      
      public function set focus(param1:Boolean) : void
      {
         this._focus = param1;
         if(this._focus && this._enableFocus)
         {
            styleName = "containerClicked";
            this.soundItem.focus = true;
         }
         else
         {
            styleName = "containerNormal";
            this.soundItem.focus = false;
         }
      }
      
      public function moveStartTime(param1:Number) : void
      {
         this.stime = this._tempSoundInfo.startPixel + param1;
      }
      
      public function set stime(param1:Number) : void
      {
         this._stime = param1;
         this.setStartTime(this._stime);
      }
      
      public function set inner_volume(param1:Number) : void
      {
         this._inner_volume = param1;
         this.soundItem.inner_volume = param1;
         this.soundItem.redraw();
         this.soundItem.updateLabel(this.getLabel());
      }
      
      public function get inner_volume() : Number
      {
         return this._inner_volume;
      }
      
      public function set slength(param1:Number) : void
      {
         if(param1 < AnimeConstants.SOUND_LENGTH_MINIMUM)
         {
            param1 = AnimeConstants.SOUND_LENGTH_MINIMUM;
         }
         this._slength = param1;
         this.setLength(this._slength);
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      public function get slength() : Number
      {
         return this._slength;
      }
      
      public function enableFocus() : void
      {
         this._enableFocus = true;
      }
      
      public function disableFocus() : void
      {
         this._enableFocus = false;
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
         this.soundItem.setTimelineReferer(param1);
      }
      
      public function setHorizontalView(param1:Number = 0) : void
      {
      }
      
      public function getHorizontalView() : Number
      {
         if(this._timelineControl)
         {
            return -this._timelineControl.scrollPosition;
         }
         return 0;
      }
      
      public function showIndicator() : void
      {
         var _loc1_:Point = this.getSoundGlobalPosition();
         if(this._indicator == null)
         {
            this._indicator = this.createIndicator(_loc1_.x,_loc1_.y);
         }
         this._indicator.x = _loc1_.x;
         this._indicator.y = _loc1_.y - this._indicator.height;
         this._indicator.text = this.getLabel();
      }
      
      public function removeIndicator() : void
      {
         if(this._indicator != null)
         {
            ToolTipManager.destroyToolTip(this._indicator);
            this._indicator = null;
         }
      }
      
      public function addItem(param1:UIComponent) : void
      {
      }
      
      public function addItemAt(param1:UIComponent, param2:int) : void
      {
      }
      
      public function removeItem(param1:Number = -1) : Boolean
      {
         return false;
      }
      
      public function removeAllItems() : void
      {
      }
      
      public function changeProperty(param1:int, param2:String, param3:* = null) : void
      {
      }
      
      public function getCurrItem() : ITimelineElement
      {
         return null;
      }
      
      public function getCurrIndex() : int
      {
         return 0;
      }
      
      public function getItemAt(param1:int) : ITimelineElement
      {
         return null;
      }
      
      private function setStartTime(param1:Number) : void
      {
         this.x = param1;
         this.soundItem.updateLabel(this.getLabel());
      }
      
      private function setLength(param1:Number) : void
      {
         this.width = param1;
         this.soundItem.length = param1;
         this.soundItem.redraw();
         this.soundItem.updateLabel(this.getLabel());
      }
      
      public function getLabel() : String
      {
         this._slength = this.width;
         var _loc1_:Number = UtilUnitConvert.pixelToSec(this._stime);
         var _loc2_:Number = UtilUnitConvert.pixelToSec(this._slength);
         return this.label + " [" + UtilDict.toDisplay("go","timeline_starttime") + ": " + UtilString.secToTimeString(_loc1_) + ", " + UtilDict.toDisplay("go","timeline_duration") + ": " + UtilString.secToTimeString(_loc2_) + ", " + UtilDict.toDisplay("go","timeline_volume") + ": " + Math.round(this.inner_volume * 100) + "%]";
      }
      
      private function getSoundGlobalPosition() : Point
      {
         var _loc1_:Point = null;
         _loc1_ = this.localToGlobal(new Point(this.soundItem_cs.x,this.soundItem_cs.y));
         if(_loc1_.x < 0)
         {
            _loc1_.x = 0;
         }
         return _loc1_;
      }
      
      private function createIndicator(param1:Number, param2:Number) : ToolTip
      {
         var _loc3_:String = this.getLabel();
         var _loc4_:ToolTip;
         (_loc4_ = ToolTipManager.createToolTip(_loc3_,param1,param2) as ToolTip).setStyle("backgroundColor",16763904);
         return _loc4_;
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this._focus && this._enableFocus)
         {
            styleName = "containerOver";
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         if(!this._focus && this._enableFocus)
         {
            styleName = "containerNormal";
         }
      }
      
      private function onSoundElementDownHandler(param1:MouseEvent) : void
      {
         this._timelineControl.bringUp(this);
         this._timelineControl.allSoundsSetFocus(false);
         if(param1.target.name != "CONTROL_L" && param1.target.name != "CONTROL_R")
         {
            this.startDrag(false,new Rectangle(0,0,this.MAX_WIDTH,this._timelineControl.sound_cs.height));
            stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onSoundElementMoveHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP,this.onSoundElementUpHandler);
            this.showIndicator();
            this.alpha = 0.75;
            this._originalX = this.stage.mouseX;
            this._originalY = this.stage.mouseY;
            this._orgObjPos = new Point(this.x,this.y);
            this.dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOUSE_DOWN));
         }
      }
      
      private function nearToOtherSound(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = this._timelineControl.getPrevSoundOnSameTrack(param2,param1);
         if(Math.abs(_loc3_) <= AnimeConstants.SOUND_SNAP_INTERVAL && (Math.abs(this._orgObjPos.x - param1) > 10 || Math.abs(this._orgObjPos.y - param2) > 10))
         {
            return param1 - _loc3_;
         }
         _loc3_ = this._timelineControl.getNextSoundOnSameTrack(param2,param1) - this.width;
         if(Math.abs(_loc3_) <= AnimeConstants.SOUND_SNAP_INTERVAL && (Math.abs(this._orgObjPos.x - param1) > 10 || Math.abs(this._orgObjPos.y - param2) > 10))
         {
            return param1 + _loc3_;
         }
         return -1;
      }
      
      private function onSoundElementMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:ColorTransform = null;
         param1.updateAfterEvent();
         this.y = this.fixedChannelY(param1.stageY);
         this.x = UtilUnitConvert.snapToPixelWithTime(this._orgObjPos.x + param1.stageX - this._originalX);
         if(this.x < 0)
         {
            this.x = 0;
         }
         if(this._timelineControl.checkSoundOverlap())
         {
            _loc2_ = new ColorTransform(1,0,0,1,255,0,0,0);
            this.soundItem._bg.transform.colorTransform = _loc2_;
            this.soundItem._ind.transform.colorTransform = _loc2_;
         }
         else
         {
            _loc2_ = new ColorTransform();
            this.soundItem._bg.transform.colorTransform = _loc2_;
            this.soundItem._ind.transform.colorTransform = _loc2_;
         }
         this._stime = this.x;
         this.showIndicator();
         var _loc3_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOVE,_loc3_,this.id));
         this.soundItem.updateLabel(this.getLabel());
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
         this._dragObjPoint = new Point(this.x,this.y);
         this.invalidateProperties();
         this.invalidateDisplayList();
      }
      
      private function fixedChannelY(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc2_:Number = 4;
         var _loc3_:Number = param1 - (this._timelineControl.y + Timeline.SCENECONTAINER_VISUAL_HEIGHT) - 17;
         if(_loc3_ > 0)
         {
            _loc5_ = this._timelineControl.sound_cs.height - SOUNDCONTAINER_HEIGHT;
            _loc6_ = (_loc6_ = UtilUnitConvert.getTargetPoint(0,_loc5_,_loc3_,_loc2_)) == 0 ? int(_loc2_ - 1) : int(_loc6_ - 1);
            _loc4_ = SoundTrackArea.trackToPixel(_loc6_);
         }
         else
         {
            _loc4_ = 0;
         }
         return _loc4_;
      }
      
      private function onSoundElementUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         this.soundItem._bg.transform.colorTransform = _loc2_;
         this.soundItem._ind.transform.colorTransform = _loc2_;
         this._timelineControl.allSoundsSetFocus(true);
         this.x = UtilUnitConvert.snapToPixelWithTime(this.x);
         this.soundItem.stopDrag();
         this.alpha = 1;
         this.removeIndicator();
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onSoundElementMoveHandler);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onSoundElementUpHandler);
         this.y = this.fixedChannelY(param1.stageY);
         if(this._timelineControl.checkSoundOverlap())
         {
            this.x = this._orgObjPos.x;
            this.y = this._orgObjPos.y;
         }
         this._stime = this.x;
         this.soundItem.updateLabel(this.getLabel());
         var _loc3_:int = this._timelineControl.getSoundIndexById(this.id);
         if(this.stage.mouseX == this._originalX && this.stage.mouseY == this._originalY)
         {
            dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_CLICK,_loc3_,this.id));
         }
         this.dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOUSE_UP,_loc3_,this.id));
      }
      
      private function onControlLeftMoveHandler(param1:TimelineEvent) : void
      {
         this._stime = this.x;
         this.soundItem.updateLabel(this.getLabel());
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE,_loc2_,this.id));
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      private function onControlRightMoveHandler(param1:TimelineEvent) : void
      {
         this.soundItem.updateLabel(this.getLabel());
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE,_loc2_,this.id));
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      private function onSoundResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_START,_loc2_,this.id));
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      private function onSoundResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_COMPLETE,_loc2_,this.id));
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this._mouseDown = new Point(param1.stageX,param1.stageY);
         this.isResizing = true;
         this._currDraggedControl = param1.currentTarget as UIComponent;
         this._oldX = this._stime;
         this._oldWidth = this.slength;
         var _loc2_:Number = this._timelineControl.getPrevSoundOnSameTrack(this.y,this.x);
         var _loc3_:Number = this._timelineControl.getNextSoundOnSameTrack(this.y,this.x);
         var _loc4_:Number;
         if((_loc4_ = this._oldX - _loc2_) < 0)
         {
            _loc4_ = 0;
         }
         var _loc5_:Number = this._oldX + _loc3_;
         this._boundingRect = new Rectangle(_loc4_,this.y,_loc5_ - _loc4_,0);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.showIndicator();
         var _loc6_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_START,_loc6_,this.id));
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:Point = new Point(param1.stageX - this._mouseDown.x,param1.stageY - this._mouseDown.y);
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         if(this._currDraggedControl == this.arrow_right)
         {
            _loc5_ = this._boundingRect.right - this._oldX;
            this.slength = UtilUnitConvert.snapToPixelWithTime(Math.min(this._oldWidth + _loc2_.x,_loc5_));
            dispatchEvent(new TimelineEvent(TimelineEvent.CONTROL_RIGHT_MOVE));
         }
         else
         {
            _loc6_ = this.arrow_right.x;
            if((_loc4_ = _loc2_.x) > this._oldWidth - AnimeConstants.SOUND_LENGTH_MINIMUM)
            {
               _loc4_ = this._oldWidth - AnimeConstants.SOUND_LENGTH_MINIMUM;
            }
            _loc7_ = this._boundingRect.x;
            this.stime = UtilUnitConvert.snapToPixelWithTime(Math.max(this._oldX + _loc4_,_loc7_));
            this.slength = this._oldX + this._oldWidth - this._stime;
            dispatchEvent(new TimelineEvent(TimelineEvent.CONTROL_LEFT_MOVE));
         }
         this.soundItem.redraw();
         this.soundItem.updateLabel(this.getLabel());
         param1.updateAfterEvent();
         this.showIndicator();
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         if(this.isArrowCursor)
         {
            this.isResizing = false;
            if(!this.onArrow)
            {
               CursorManager.removeCursor(this.cursorID);
            }
         }
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.soundItem.updateLabel(this.getLabel());
         this.soundItem.redraw();
         this.removeIndicator();
         this.dispatchEvent(new Event("TIMELINE_CHANGE_COMPLETE"));
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_COMPLETE,_loc2_,this.id));
      }
      
      private function changeArrowCurosr(param1:Boolean) : void
      {
         this.onArrow = param1;
         if(!this.isResizing)
         {
            if(param1)
            {
               this.cursorID = CursorManager.setCursor(this.ArrowIcon,3,-10.5,-6);
               this.isArrowCursor = true;
            }
            else
            {
               CursorManager.removeCursor(this.cursorID);
               this.isArrowCursor = false;
            }
         }
      }
      
      public function startIndicator(param1:Number = 0, param2:SoundChannel = null) : void
      {
         this.dataObj = new Array();
         this.dataObj.push(param1 / 1000 * AnimeConstants.PIXEL_PER_SEC);
         this.dataObj.push(new Date().time);
         this.dataObj.push(param2);
         this._loop = 1;
         this.stopIndicator();
         this._timer = new Timer(40);
         this._timer.addEventListener(TimerEvent.TIMER,this.updateIndicator);
         this._timer.start();
      }
      
      public function stopIndicator() : void
      {
         if(this._timer != null)
         {
            this.updateIndicator();
            this._timer.removeEventListener(TimerEvent.TIMER,this.updateIndicator);
            this._timer.stop();
            this._timer = null;
         }
      }
      
      private function updateIndicator(param1:TimerEvent = null) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Number = this.dataObj[0];
         var _loc3_:Number = this.dataObj[1];
         var _loc4_:SoundChannel;
         if(_loc4_ = this.dataObj[2])
         {
            _loc5_ = _loc4_.position;
            if(this.animeSound && UtilUnitConvert.frameToSec(this.animeSound.totalFrame) <= _loc5_ / 1000)
            {
               _loc4_.stop();
            }
            this.soundItem.updateIndicator(_loc2_,_loc5_ / 1000 * AnimeConstants.PIXEL_PER_SEC - _loc2_);
         }
         else
         {
            _loc6_ = new Date().time - _loc3_;
            this.soundItem.updateIndicator(_loc2_,_loc6_ / 1000 * AnimeConstants.PIXEL_PER_SEC);
         }
      }
      
      public function clearIndicator() : void
      {
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.updateIndicator);
            this._timer.stop();
            this._timer = null;
         }
         this.soundItem.clearIndicator();
      }
      
      public function hasMarker() : Boolean
      {
         return this.soundItem.hasMarker();
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this.soundItem_cs.alpha = 1;
         }
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         this.soundItem_cs.alpha = 0.75;
      }
      
      public function ___SoundContainer_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function ___SoundContainer_Canvas1_mouseOver(param1:MouseEvent) : void
      {
         this.onMouseOverHandler(param1);
      }
      
      public function ___SoundContainer_Canvas1_mouseOut(param1:MouseEvent) : void
      {
         this.onMouseOutHandler(param1);
      }
      
      public function __soundItem_cs_rollOver(param1:MouseEvent) : void
      {
         this.onRollOver(param1);
      }
      
      public function __soundItem_cs_rollOut(param1:MouseEvent) : void
      {
         this.onRollOut(param1);
      }
      
      public function __arrow_left_rollOver(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(true);
      }
      
      public function __arrow_left_rollOut(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(false);
      }
      
      public function __arrow_left_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      public function __arrow_right_rollOver(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(true);
      }
      
      public function __arrow_right_rollOut(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(false);
      }
      
      public function __arrow_right_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      private function _SoundContainer_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return SOUNDCONTAINER_HEIGHT;
         },null,"soundItem.height");
         result[1] = new Binding(this,function():Number
         {
            return this.width - 6;
         },null,"arrow_right.x");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get arrow_left() : Canvas
      {
         return this._1729822083arrow_left;
      }
      
      public function set arrow_left(param1:Canvas) : void
      {
         var _loc2_:Object = this._1729822083arrow_left;
         if(_loc2_ !== param1)
         {
            this._1729822083arrow_left = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"arrow_left",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get arrow_right() : Canvas
      {
         return this._2079216026arrow_right;
      }
      
      public function set arrow_right(param1:Canvas) : void
      {
         var _loc2_:Object = this._2079216026arrow_right;
         if(_loc2_ !== param1)
         {
            this._2079216026arrow_right = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"arrow_right",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get soundItem() : SoundElement
      {
         return this._1812817726soundItem;
      }
      
      public function set soundItem(param1:SoundElement) : void
      {
         var _loc2_:Object = this._1812817726soundItem;
         if(_loc2_ !== param1)
         {
            this._1812817726soundItem = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundItem",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get soundItem_cs() : Canvas
      {
         return this._734000883soundItem_cs;
      }
      
      public function set soundItem_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._734000883soundItem_cs;
         if(_loc2_ !== param1)
         {
            this._734000883soundItem_cs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundItem_cs",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get ArrowIcon() : Class
      {
         return this._977672194ArrowIcon;
      }
      
      private function set ArrowIcon(param1:Class) : void
      {
         var _loc2_:Object = this._977672194ArrowIcon;
         if(_loc2_ !== param1)
         {
            this._977672194ArrowIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ArrowIcon",_loc2_,param1));
            }
         }
      }
   }
}
