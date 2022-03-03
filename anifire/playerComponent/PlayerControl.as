package anifire.playerComponent
{
   import anifire.component.DoubleStateButton;
   import anifire.playback.PlayerEvent;
   import anifire.util.Util;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.HSlider;
   import mx.controls.Spacer;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.SliderEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class PlayerControl extends HBox
   {
      
      private static const ON_PLAY_BUT_CLICK:String = "onPlayButClicked";
      
      private static const ON_PAUSE_BUT_CLICK:String = "onPauseButClicked";
      
      private static const ON_TIMELINE_DRAG:String = "onTimeLineDrag";
      
      private static const ON_TIMELINE_PRESS:String = "onTimeLinePress";
      
      private static const ON_TIMELINE_RELEASE:String = "onTimeLineRelease";
      
      public static const STATE_PLAY:int = 1;
      
      public static const STATE_PAUSE:int = 2;
      
      public static const STATE_NULL:int = 0;
      
      private static var _logger:ILogger = Log.getLogger("playerComponent.PlayerControl");
       
      
      private var _466502975_timelineContainer:Canvas;
      
      private var _673913090fullScreenControl:FullScreenControl;
      
      private var _572854271playPauseBut:DoubleStateButton;
      
      private var _2077603743timeLine:HSlider;
      
      private var _431284669timerDisplay:TimerDisplay;
      
      private var _1969341667volumeControl:VolumeControl;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _totalFrame:Number = 10;
      
      private var _isTimeLineDragging:Boolean = false;
      
      private var _state:int;
      
      private var _curFrame:Number;
      
      public function PlayerControl()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "events":{"creationComplete":"___PlayerControl_HBox1_creationComplete"},
            "stylesFactory":function():void
            {
               this.backgroundSize = "100%";
               this.paddingLeft = 5;
               this.verticalAlign = "middle";
            },
            "propertiesFactory":function():Object
            {
               return {
                  "height":30,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_timelineContainer",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":HBox,
                              "stylesFactory":function():void
                              {
                                 this.verticalAlign = "middle";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":DoubleStateButton,
                                       "id":"playPauseBut",
                                       "events":{
                                          "But1Click":"__playPauseBut_But1Click",
                                          "But2Click":"__playPauseBut_But2Click"
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "but1StyleName":"btnPlay",
                                             "but2StyleName":"btnPause"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":HSlider,
                                       "id":"timeLine",
                                       "events":{
                                          "change":"__timeLine_change",
                                          "thumbPress":"__timeLine_thumbPress",
                                          "thumbRelease":"__timeLine_thumbRelease"
                                       },
                                       "stylesFactory":function():void
                                       {
                                          this.slideDuration = 0;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "showDataTip":false,
                                             "styleName":"slider",
                                             "buttonMode":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":TimerDisplay,
                     "id":"timerDisplay",
                     "propertiesFactory":function():Object
                     {
                        return {"styleName":"timer"};
                     }
                  }),new UIComponentDescriptor({
                     "type":VolumeControl,
                     "id":"volumeControl",
                     "events":{"volume_change":"__volumeControl_volume_change"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "clipContent":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":FullScreenControl,
                     "id":"fullScreenControl",
                     "events":{
                        "full_screen":"__fullScreenControl_full_screen",
                        "nor_screen":"__fullScreenControl_nor_screen"
                     }
                  }),new UIComponentDescriptor({
                     "type":Spacer,
                     "propertiesFactory":function():Object
                     {
                        return {"width":5};
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.styleName = "playerControlBar";
         this.percentWidth = 100;
         this.height = 30;
         this.addEventListener("creationComplete",this.___PlayerControl_HBox1_creationComplete);
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
            this.backgroundSize = "100%";
            this.paddingLeft = 5;
            this.verticalAlign = "middle";
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function get totalFrame() : Number
      {
         return this._totalFrame;
      }
      
      private function set totalFrame(param1:Number) : void
      {
         this._totalFrame = param1;
      }
      
      public function getCurFrame() : Number
      {
         return this._curFrame;
      }
      
      private function setCurFrame(param1:Number) : void
      {
         this._curFrame = param1;
      }
      
      private function get isTimeLineDragging() : Boolean
      {
         return this._isTimeLineDragging;
      }
      
      private function set isTimeLineDragging(param1:Boolean) : void
      {
         this._isTimeLineDragging = param1;
      }
      
      private function onCreationCompleted() : void
      {
         Util.initLog();
         this.timeLine.liveDragging = true;
         this.enableTimeLine(false);
      }
      
      private function playButClicked(... rest) : void
      {
         this.setState(PlayerControl.STATE_PLAY);
         dispatchEvent(new MouseEvent(PlayerControl.ON_PLAY_BUT_CLICK));
      }
      
      private function pauseButClicked(... rest) : void
      {
         this.setState(PlayerControl.STATE_PAUSE);
         dispatchEvent(new MouseEvent(PlayerControl.ON_PAUSE_BUT_CLICK));
      }
      
      private function setState(param1:int) : void
      {
         if(param1 == PlayerControl.STATE_PLAY)
         {
            this.playPauseBut.setState(DoubleStateButton.STATE_BUT2);
         }
         else if(param1 == PlayerControl.STATE_PAUSE)
         {
            this.playPauseBut.setState(DoubleStateButton.STATE_BUT1);
         }
      }
      
      private function getState() : int
      {
         return this._state;
      }
      
      private function onTimeLineDrag(param1:SliderEvent) : void
      {
         this.timeLine.endEffectsStarted();
         this.timeLine.getThumbAt(0).endEffectsStarted();
         this.setCurFrame(UtilUnitConvert.secToFrame(this.timeLine.value - this.timeLine.minimum));
         this.updateDigitalClock();
         this.dispatchEvent(new Event(PlayerControl.ON_TIMELINE_DRAG));
      }
      
      private function updateDigitalClock() : void
      {
         var _loc1_:Number = NaN;
         if(this.getCurFrame() < this.totalFrame)
         {
            _loc1_ = UtilUnitConvert.frameToSec(this.getCurFrame());
         }
         else
         {
            _loc1_ = UtilUnitConvert.frameToSec(this.getCurFrame(),false);
         }
         this.timerDisplay.setCurTime(_loc1_);
      }
      
      private function updateTimeLinePosition() : void
      {
         var _loc1_:Number = UtilUnitConvert.frameToSec(this.getCurFrame());
         this.timeLine.value = this.getCurFrame() / this.totalFrame * (this.timeLine.maximum - this.timeLine.minimum) + this.timeLine.minimum;
      }
      
      public function timeChangeListener(param1:Number) : void
      {
         if(!this.isTimeLineDragging)
         {
            this.setCurFrame(param1);
            this.updateDigitalClock();
            this.updateTimeLinePosition();
         }
      }
      
      public function scenePreview(param1:Number) : void
      {
         this.timeLine.endEffectsStarted();
         this.timeLine.getThumbAt(0).endEffectsStarted();
         this.setCurFrame(param1);
         this.updateDigitalClock();
         this.updateTimeLinePosition();
         this.dispatchEvent(new Event(PlayerControl.ON_TIMELINE_DRAG));
         this.setState(PlayerControl.STATE_PAUSE);
         var _loc2_:Timer = new Timer(1000,1);
         _loc2_.addEventListener("timer",this.timerHandler);
         _loc2_.start();
      }
      
      public function timerHandler(param1:TimerEvent) : void
      {
         if(this.playPauseBut.enabled == false)
         {
            this.playPauseBut.enabled = true;
         }
         this.playButClicked();
      }
      
      public function playListener() : void
      {
         this.setState(PlayerControl.STATE_PLAY);
      }
      
      public function pauseListener() : void
      {
         this.setState(PlayerControl.STATE_PAUSE);
      }
      
      public function init(param1:Number) : void
      {
         this.totalFrame = param1;
         this.timeLine.maximum = UtilUnitConvert.frameToSec(this.totalFrame);
         this.timeLine.minimum = 0;
         this.timeLine.y -= 3;
         this.timerDisplay.setTotalTime(this.timeLine.maximum);
      }
      
      public function enableTimeLine(param1:Boolean = true) : void
      {
         this.timeLine.enabled = param1;
      }
      
      private function onTimeLinePress(param1:SliderEvent) : void
      {
         this.isTimeLineDragging = true;
         this.dispatchEvent(new Event(PlayerControl.ON_TIMELINE_PRESS));
      }
      
      private function onTimeLineRelease(param1:SliderEvent) : void
      {
         this.isTimeLineDragging = false;
         this.dispatchEvent(new Event(PlayerControl.ON_TIMELINE_RELEASE));
      }
      
      private function onVolumeChange(param1:PlayerEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function onFullScreen(param1:PlayerEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function onNorScreen(param1:PlayerEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      public function ___PlayerControl_HBox1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationCompleted();
      }
      
      public function __playPauseBut_But1Click(param1:Event) : void
      {
         this.playButClicked();
      }
      
      public function __playPauseBut_But2Click(param1:Event) : void
      {
         this.pauseButClicked();
      }
      
      public function __timeLine_change(param1:SliderEvent) : void
      {
         this.onTimeLineDrag(param1);
      }
      
      public function __timeLine_thumbPress(param1:SliderEvent) : void
      {
         this.onTimeLinePress(param1);
      }
      
      public function __timeLine_thumbRelease(param1:SliderEvent) : void
      {
         this.onTimeLineRelease(param1);
      }
      
      public function __volumeControl_volume_change(param1:PlayerEvent) : void
      {
         this.onVolumeChange(param1);
      }
      
      public function __fullScreenControl_full_screen(param1:PlayerEvent) : void
      {
         this.onFullScreen(param1);
      }
      
      public function __fullScreenControl_nor_screen(param1:PlayerEvent) : void
      {
         this.onNorScreen(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _timelineContainer() : Canvas
      {
         return this._466502975_timelineContainer;
      }
      
      public function set _timelineContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._466502975_timelineContainer;
         if(_loc2_ !== param1)
         {
            this._466502975_timelineContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_timelineContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fullScreenControl() : FullScreenControl
      {
         return this._673913090fullScreenControl;
      }
      
      public function set fullScreenControl(param1:FullScreenControl) : void
      {
         var _loc2_:Object = this._673913090fullScreenControl;
         if(_loc2_ !== param1)
         {
            this._673913090fullScreenControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fullScreenControl",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playPauseBut() : DoubleStateButton
      {
         return this._572854271playPauseBut;
      }
      
      public function set playPauseBut(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._572854271playPauseBut;
         if(_loc2_ !== param1)
         {
            this._572854271playPauseBut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playPauseBut",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get timeLine() : HSlider
      {
         return this._2077603743timeLine;
      }
      
      public function set timeLine(param1:HSlider) : void
      {
         var _loc2_:Object = this._2077603743timeLine;
         if(_loc2_ !== param1)
         {
            this._2077603743timeLine = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"timeLine",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get timerDisplay() : TimerDisplay
      {
         return this._431284669timerDisplay;
      }
      
      public function set timerDisplay(param1:TimerDisplay) : void
      {
         var _loc2_:Object = this._431284669timerDisplay;
         if(_loc2_ !== param1)
         {
            this._431284669timerDisplay = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"timerDisplay",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get volumeControl() : VolumeControl
      {
         return this._1969341667volumeControl;
      }
      
      public function set volumeControl(param1:VolumeControl) : void
      {
         var _loc2_:Object = this._1969341667volumeControl;
         if(_loc2_ !== param1)
         {
            this._1969341667volumeControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"volumeControl",_loc2_,param1));
            }
         }
      }
   }
}
