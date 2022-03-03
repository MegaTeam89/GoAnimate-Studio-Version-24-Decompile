package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.AnimeScene;
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.event.ExtraDataEvent;
   import anifire.managers.FeatureManager;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilSite;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilUser;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Proxy;
   import flash.utils.getDefinitionByName;
   import flash.utils.setTimeout;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.events.ScrollEvent;
   import template.templateApp.classes.Global;
   
   use namespace mx_internal;
   
   public class Timeline extends Canvas implements IBindingClient
   {
      
      public static const SCENE:String = "scene";
      
      public static const SOUND:String = "sound";
      
      public static const BBAR:String = "bbar";
      
      public static const BITMAP:String = "bitmap";
      
      public static const BLANK:String = "blank";
      
      public static const SCENECONTAINER_VISUAL_HEIGHT:int = 70;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1336746749_maskCanvas:Canvas;
      
      private var _362247270_timelineScrollbar:TimelineHScrollBar;
      
      private var _1893604106background_bg:BackgroundGrid;
      
      private var _320222918bbar_vb:VBox;
      
      private var _3141bg:Canvas;
      
      private var _1378820961btnTip:Button;
      
      private var _2141670186container_vb:VBox;
      
      private var _108873974ruler:TimelineRuler;
      
      private var _1361347256sb_canvas:Canvas;
      
      private var _775487681scene_vb:VBox;
      
      private var _1956980552shadowFilter:DropShadowFilter;
      
      private var _1870704681soundTrackArea:SoundTrackArea;
      
      private var _1140124837toolBar:TimelineToolBar;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private const MAX_SOUND_TRACK:Number = 4;
      
      private const SCENECONTAINER_HEIGHT:int = 187;
      
      private const BBARCONTAINER_HEIGHT:int = 25;
      
      private const HSCROLLBAR_HEIGHT:int = 22;
      
      private const SCENE_IMAGE_WIDTH:Number = 76.5;
      
      private const SCENE_IMAGE_HEIGHT:Number = 51;
      
      private var _1454985665_verticalGap:Number = 1;
      
      private var _soundElements:Array;
      
      private var _soundContainer:ArrayCollection;
      
      private var _sceneContainer:ITimelineContainer = null;
      
      private var _bbarContainer:ITimelineContainer = null;
      
      private var _targetUI:UIComponent;
      
      private var _totalSceneCount:Number = 0;
      
      private var _currBgStartIndex:Number = 0;
      
      private var _captureRect:Rectangle = null;
      
      private var _totalSoundCount:Number = 0;
      
      private var _soundNameCount:Number = 0;
      
      private var _currSoundIndex:Number = -1;
      
      private var _currSoundStartIndex:Number = 0;
      
      private var _currSoundContainer:SoundContainer = null;
      
      private var _onDragSceneInfo:ElementInfo;
      
      private var _soundTesterArray:UtilHashArray;
      
      private var _soundMoverArray:Array;
      
      private var _soundBlockerArray:UtilHashArray;
      
      private var _sceneLengthController:SceneLengthController;
      
      private var _showWaveform:Boolean = false;
      
      private var numOfCaptureScreen:Number = 0;
      
      private var _isSoundTracksCollapsed:Boolean = false;
      
      private var _scrollPosition:Number;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function Timeline()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "creationComplete":"___Timeline_Canvas1_creationComplete",
               "resize":"___Timeline_Canvas1_resize"
            },
            "stylesFactory":function():void
            {
               this.backgroundColor = 13421772;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "height":182,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":BackgroundGrid,
                     "id":"background_bg",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":148,
                           "left":73,
                           "top":17,
                           "bottom":0,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "stylesFactory":function():void
                     {
                        this.cornerRadius = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "left":0,
                           "right":0,
                           "top":17,
                           "bottom":0,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "styleName":"sceneContainer",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"bg",
                              "events":{"resize":"__bg_resize"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "height":70
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "id":"scene_vb",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "left":71,
                                    "styleName":"sceneContainer",
                                    "percentWidth":100,
                                    "height":150,
                                    "verticalScrollPolicy":"off",
                                    "horizontalScrollPolicy":"off"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "id":"container_vb",
                              "stylesFactory":function():void
                              {
                                 this.verticalGap = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "x":72,
                                    "top":71,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":SoundTrackArea,
                                       "id":"soundTrackArea",
                                       "propertiesFactory":function():Object
                                       {
                                          return {"height":80};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"sb_canvas",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":true,
                                             "percentWidth":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":TimelineHScrollBar,
                                                "id":"_timelineScrollbar",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"percentWidth":100};
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":VBox,
                                       "id":"bbar_vb",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnTip",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"btnTip",
                           "visible":false,
                           "width":20,
                           "height":20,
                           "right":10,
                           "bottom":25,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":TimelineRuler,
                     "id":"ruler",
                     "propertiesFactory":function():Object
                     {
                        return {"x":72};
                     }
                  }),new UIComponentDescriptor({
                     "type":TimelineToolBar,
                     "id":"toolBar"
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_maskCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "alpha":0,
                           "visible":false
                        };
                     }
                  })]
               };
            }
         });
         this._soundElements = new Array();
         this._soundContainer = new ArrayCollection(this._soundElements);
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._Timeline_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_TimelineWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return Timeline[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.height = 182;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._Timeline_DropShadowFilter1_i();
         this.addEventListener("creationComplete",this.___Timeline_Canvas1_creationComplete);
         this.addEventListener("resize",this.___Timeline_Canvas1_resize);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         Timeline._watcherSetupUtil = param1;
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
            this.backgroundColor = 13421772;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get sceneContainer() : ITimelineContainer
      {
         return this._sceneContainer;
      }
      
      public function set sceneContainer(param1:ITimelineContainer) : void
      {
         this._sceneContainer = param1;
      }
      
      public function get sceneLengthController() : SceneLengthController
      {
         return this._sceneLengthController;
      }
      
      public function set sceneLengthController(param1:SceneLengthController) : void
      {
         this._sceneLengthController = param1;
      }
      
      public function get currBgStartIndex() : Number
      {
         return this._currBgStartIndex;
      }
      
      private function showScrollBar(param1:Event) : void
      {
         if(!this.sb_canvas.visible)
         {
            this.sb_canvas.visible = true;
         }
      }
      
      private function hideScrollBar(param1:Event) : void
      {
         if(!this.sb_canvas.visible)
         {
         }
      }
      
      private function initApp() : void
      {
         this._timelineScrollbar.addEventListener("SCROLL_VISIBLE",this.showScrollBar);
         this._timelineScrollbar.addEventListener("SCROLL_INVISIBLE",this.hideScrollBar);
         this._timelineScrollbar.initBgGrid(this.background_bg);
         this._sceneContainer = this.addContainer(SCENE);
         this._timelineScrollbar.addContainerToScrollBar(this._sceneContainer as SceneContainer);
         this._sceneContainer.disableFocus();
         this._sceneContainer.setTimelineReferer(this);
         this._sceneContainer.addEventListener(TimelineEvent.SCENE_MOUSE_DOWN,this.onSceneMouseDownHandler);
         this._sceneContainer.addEventListener(TimelineEvent.SCENE_MOUSE_UP,this.onSceneMouseUpHandler);
         this._sceneContainer.addEventListener(TimelineEvent.SCENE_RESIZE_START,this.onSceneResizeStartHandler);
         this._sceneContainer.addEventListener(TimelineEvent.SCENE_RESIZE_COMPLETE,this.onSceneResizeCompleteHandler);
         this.sceneLengthController = new SceneLengthController();
         this.sceneLengthController.setTimelineReferer(this);
         if(UtilLicense.getCurrentLicenseId() == String(Global.BEN10) || UtilUser.userType == UtilUser.BASIC_USER)
         {
            if(UtilSite.siteId == UtilSite.YOUTUBE)
            {
               this.btnTip.toolTip = UtilDict.toDisplay("go","At this time, only videos shorter than 2 minutes can be exported.  Please shorten your video.");
            }
            else if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) == null || Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) == "0")
            {
               this.btnTip.toolTip = UtilDict.toDisplay("go","timeline_durationalert");
            }
            else
            {
               this.btnTip.toolTip = UtilDict.toDisplay("go","timeline_durationalert25");
            }
         }
      }
      
      public function setSceneTarget(param1:UIComponent, param2:Rectangle = null) : void
      {
         this._captureRect = param2;
         this._targetUI = param1;
      }
      
      public function setCurrentSceneByIndex(param1:int) : void
      {
         var _loc2_:SceneContainer = this._sceneContainer as SceneContainer;
         if(_loc2_ != null)
         {
            _loc2_.setCurrentItemByIndex(param1);
         }
      }
      
      public function setSceneVisible(param1:int) : void
      {
      }
      
      public function addScene(param1:String, param2:String = "bitmap", param3:Number = 0, param4:AnimeScene = null, param5:int = -1) : SceneElement
      {
         if(param3 == -1)
         {
            AnimeConstants.SCENE_LENGTH_DEFAULT;
         }
         var _loc6_:SceneElement;
         (_loc6_ = new SceneElement()).scene = param4;
         _loc6_.id = param1;
         _loc6_.label = String(++this._totalSceneCount);
         _loc6_.width = param3;
         _loc6_.setWaveformVisible(this._showWaveform);
         var _loc7_:int = SceneContainer(this._sceneContainer).length;
         if(param5 >= 0)
         {
            this._sceneContainer.addItemAt(_loc6_,param5);
            this.updateAllScenesLabel();
         }
         else
         {
            this._sceneContainer.addItem(_loc6_);
         }
         this.background_bg.setWidthCollect(this.getAllSceneWidth());
         this.background_bg.redraw();
         Console.getConsole().refreshAllSpeechText();
         setTimeout(this.updateHelpToolTip,1000);
         return _loc6_;
      }
      
      public function moveSoundAfterAddScene(param1:Number, param2:Number) : void
      {
         var _loc3_:SoundContainer = null;
         var _loc4_:int = 0;
         while(_loc4_ < this._soundContainer.length)
         {
            _loc3_ = this._soundContainer.getItemAt(_loc4_) as SoundContainer;
            _loc3_.tempSoundInfo = this.getSoundInfoByIndex(_loc4_);
            if(_loc3_.x >= param2)
            {
               _loc3_.moveStartTime(param1);
               Console.getConsole().updateSoundById(_loc3_.id);
            }
            _loc4_++;
         }
      }
      
      private function updateSoundAfterAddScene(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:SoundContainer = null;
         var _loc6_:int = 0;
         while(_loc6_ < this._soundContainer.length)
         {
            (_loc5_ = this._soundContainer.getItemAt(_loc6_) as SoundContainer).tempSoundInfo = this.getSoundInfoByIndex(_loc6_);
            if(_loc5_.x < param3 && _loc5_.x >= param2)
            {
               _loc5_.moveStartTime(param1);
               Console.getConsole().updateSoundById(_loc5_.id);
            }
            else if(_loc5_.x > param3 && _loc5_.x <= param2 + param1)
            {
               _loc5_.moveStartTime(-param4);
               Console.getConsole().updateSoundById(_loc5_.id);
            }
            _loc6_++;
         }
      }
      
      public function removeScene(param1:int = -1) : void
      {
         var _loc2_:int = 0;
         if(param1 < 0)
         {
            _loc2_ = this._sceneContainer.getCurrIndex();
         }
         else
         {
            _loc2_ = param1;
         }
         var _loc3_:ElementInfo = this.getSceneInfoByIndex(_loc2_);
         this.shortTimeline(_loc3_.totalPixel,_loc3_.startPixel + _loc3_.totalPixel);
         if(this._sceneContainer.removeItem(param1))
         {
            this.updateAllScenesLabel();
            --this._totalSceneCount;
            this.background_bg.setWidthCollect(this.getAllSceneWidth());
            this.background_bg.redraw();
         }
         Console.getConsole().refreshAllSpeechText();
         this.updateHelpToolTip();
      }
      
      public function moveScene(param1:Number, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:ITimelineElement = this._sceneContainer.getItemAt(param1);
         if(_loc3_)
         {
            _loc4_ = this.getSceneInfoByIndex(param1).startPixel;
            _loc5_ = this.getSceneInfoByIndex(param1).totalPixel;
            this._sceneContainer.removeItem(param1);
            if(param1 < param2)
            {
               this._sceneContainer.addItemAt(SceneElement(_loc3_),param2 - 1);
            }
            else
            {
               this._sceneContainer.addItemAt(SceneElement(_loc3_),param2);
            }
            this.updateAllScenesLabel();
            this.background_bg.setWidthCollect(this.getAllSceneWidth());
            this.background_bg.redraw();
            if(param1 < param2)
            {
               this.updateSoundAfterAddScene(this.getSceneInfoByIndex(param2 - 1).totalPixel,this.getSceneInfoByIndex(param2 - 1).startPixel,_loc4_,_loc5_);
            }
            else
            {
               this.updateSoundAfterAddScene(this.getSceneInfoByIndex(param2).totalPixel,this.getSceneInfoByIndex(param2).startPixel,_loc4_,_loc5_);
            }
         }
      }
      
      public function removeAllScenes() : void
      {
         this._totalSceneCount = 0;
         this._sceneContainer.removeAllItems();
         var _loc1_:Number = this._soundContainer.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._soundContainer[_loc2_].setHorizontalView(0);
            _loc2_++;
         }
         this.background_bg.setWidthCollect(this.getAllSceneWidth());
         this.background_bg.redraw();
         Console.getConsole().refreshAllSpeechText();
      }
      
      public function getSceneImageBitmapByIndex(param1:int) : BitmapData
      {
         return SceneElement(this._sceneContainer.getItemAt(param1)).source;
      }
      
      public function updateSceneImage(param1:int = -1) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Boolean = false;
         try
         {
            _loc2_ = this.getCaptureScreen();
            if(param1 < 0)
            {
               param1 = this._sceneContainer.getCurrIndex();
            }
            _loc3_ = false;
            if(this.getSceneImageBitmapByIndex(param1) != null)
            {
               if(this.getSceneImageBitmapByIndex(param1).compare(_loc2_) != 0)
               {
                  _loc3_ = true;
               }
            }
            else
            {
               _loc3_ = true;
            }
            if(_loc3_)
            {
               this._sceneContainer.changeProperty(param1,"source",_loc2_);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateSceneImageByBitmapData(param1:int = -1, param2:BitmapData = null) : void
      {
         var _loc3_:Boolean = false;
         try
         {
            if(param1 < 0)
            {
               param1 = this._sceneContainer.getCurrIndex();
            }
            _loc3_ = false;
            if(this.getSceneImageBitmapByIndex(param1) != null)
            {
               if(this.getSceneImageBitmapByIndex(param1).compare(param2) != 0)
               {
                  _loc3_ = true;
               }
            }
            else
            {
               _loc3_ = true;
            }
            if(_loc3_)
            {
               this._sceneContainer.changeProperty(param1,"source",param2);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateSceneLength(param1:Number = 100, param2:int = -1, param3:Boolean = false) : void
      {
         var _loc4_:ElementInfo = null;
         if(param2 < 0)
         {
            param2 = this._sceneContainer.getCurrIndex();
         }
         if(param3)
         {
            if((_loc4_ = this.getSceneInfoByIndex(param2)).totalPixel > param1)
            {
               this.shortTimeline(_loc4_.totalPixel - param1,_loc4_.startPixel + _loc4_.totalPixel);
            }
            else
            {
               this.moveSoundAfterAddScene(param1 - _loc4_.totalPixel,_loc4_.startPixel + _loc4_.totalPixel);
            }
         }
         this._sceneContainer.changeProperty(param2,"width",param1);
         this.background_bg.setCeilWidth(param2,param1);
      }
      
      public function getSceneWidthByIndex(param1:int = -1) : Number
      {
         return this.background_bg.getCeilWidth(param1);
      }
      
      public function getCurrentSceneWidth() : Number
      {
         return this.getSceneWidthByIndex(this._sceneContainer.getCurrIndex());
      }
      
      public function addSceneMotionTimeByIndex(param1:int = -1) : void
      {
         SceneContainer(this._sceneContainer).addSceneMotionTimeByIndex(param1);
      }
      
      public function removeSceneMotionTimeByIndex(param1:int = -1) : void
      {
         SceneContainer(this._sceneContainer).removeSceneMotionTimeByIndex(param1);
      }
      
      public function getSceneStartTime(param1:int = -1) : Number
      {
         if(param1 < 0)
         {
            param1 = this._sceneContainer.getCurrIndex();
         }
         var _loc2_:SceneElement = SceneElement(this._sceneContainer.getItemAt(param1));
         return Number(_loc2_ == null ? Number(-1) : Number(_loc2_.startTime));
      }
      
      public function getSceneInfoByIndex(param1:int = -1) : ElementInfo
      {
         if(param1 < 0)
         {
            param1 = this._sceneContainer.getCurrIndex();
         }
         var _loc2_:SceneElement = SceneElement(this._sceneContainer.getItemAt(param1));
         var _loc3_:Number = _loc2_ == null ? Number(-1) : Number(_loc2_.startTime);
         var _loc4_:Number = _loc2_ == null ? Number(-1) : Number(_loc2_.actionTime);
         return new ElementInfo(ElementInfo.SCENE,"",_loc3_,_loc4_);
      }
      
      public function getAllSceneInfo() : Array
      {
         var _loc2_:SceneElement = null;
         var _loc4_:ElementInfo = null;
         var _loc1_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._sceneContainer.count)
         {
            _loc2_ = SceneElement(this._sceneContainer.getItemAt(_loc3_));
            _loc4_ = new ElementInfo(ElementInfo.SCENE,_loc2_.id,_loc2_.startTime,_loc2_.totalTime);
            _loc1_.push(_loc4_);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getTotalTimeInPixel() : Number
      {
         var _loc1_:Array = this.getAllSceneInfo();
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ += ElementInfo(_loc1_[_loc3_]).totalPixel;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getTotalTimeInSec() : Number
      {
         return UtilUnitConvert.pixelToSec(this.getTotalTimeInPixel());
      }
      
      public function getAllSceneWidth() : Array
      {
         var _loc2_:ITimelineElement = null;
         var _loc1_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this._sceneContainer.count)
         {
            _loc2_ = this._sceneContainer.getItemAt(_loc3_);
            _loc1_.push(_loc2_.width);
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getSceneIndexById(param1:String) : int
      {
         var _loc2_:SceneContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._sceneContainer.length)
         {
            _loc2_ = this._sceneContainer.getItemAt(_loc3_) as SceneContainer;
            if(_loc2_.id == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getNumOfSoundStartAtScene(param1:Number) : int
      {
         var _loc5_:SoundContainer = null;
         var _loc2_:Number = this.getSceneInfoByIndex(param1).startPixel;
         var _loc3_:Number = _loc2_ + this.getSceneInfoByIndex(param1).totalPixel - 1;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < this._soundContainer.length)
         {
            if((_loc5_ = this._soundContainer.getItemAt(_loc6_) as SoundContainer).x >= _loc2_ && _loc5_.x <= _loc3_)
            {
               _loc4_++;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function getNextSoundOnSameTrack(param1:Number, param2:Number) : Number
      {
         var _loc3_:SoundContainer = null;
         var _loc4_:Number = 99999 + AnimeConstants.SOUND_SNAP_INTERVAL;
         var _loc5_:int = 0;
         while(_loc5_ < this._soundContainer.length)
         {
            _loc3_ = this._soundContainer.getItemAt(_loc5_) as SoundContainer;
            if(_loc3_.y == param1 && _loc3_.x > param2)
            {
               _loc4_ = Math.min(_loc4_,_loc3_.x - param2);
            }
            _loc5_++;
         }
         return _loc4_ - AnimeConstants.SOUND_SNAP_INTERVAL;
      }
      
      public function getPrevSoundOnSameTrack(param1:Number, param2:Number) : Number
      {
         var _loc3_:SoundContainer = null;
         var _loc4_:Number = 99999 + AnimeConstants.SOUND_SNAP_INTERVAL;
         var _loc5_:int = 0;
         while(_loc5_ < this._soundContainer.length)
         {
            _loc3_ = this._soundContainer.getItemAt(_loc5_) as SoundContainer;
            if(_loc3_.y == param1 && _loc3_.x < param2)
            {
               _loc4_ = Math.min(_loc4_,param2 - _loc3_.x - _loc3_.width);
            }
            _loc5_++;
         }
         return _loc4_ - AnimeConstants.SOUND_SNAP_INTERVAL;
      }
      
      private function checkSoundOverlapOnMove(param1:SoundContainer, param2:int = 5) : Number
      {
         var _loc3_:SoundContainer = null;
         var _loc4_:SoundContainer = null;
         var _loc5_:int = 0;
         while(_loc5_ < this._soundContainer.length)
         {
            if((_loc4_ = this._soundContainer.getItemAt(_loc5_) as SoundContainer).y == param1.y && _loc4_.x < param1.x)
            {
               if(_loc3_ == null)
               {
                  _loc3_ = _loc4_;
               }
               else if(_loc4_.x > _loc3_.x)
               {
                  _loc3_ = _loc4_;
               }
            }
            _loc5_++;
         }
         if(_loc3_ != null)
         {
            if(param1.x - param2 <= _loc3_.x + _loc3_.length)
            {
               return _loc5_;
            }
         }
         else if(this.checkSoundOverlap())
         {
            return 0;
         }
         return -1;
      }
      
      private function checkSoundOverlapWithBlocker(param1:SoundContainer, param2:int = 6) : Number
      {
         var _loc3_:SoundContainer = null;
         if(this._soundBlockerArray)
         {
            _loc3_ = this._soundBlockerArray.getValueByKey(String(param1.y)) as SoundContainer;
            if(_loc3_)
            {
               if(param1.x < _loc3_.x + _loc3_.length + param2)
               {
                  return 0;
               }
            }
         }
         return -1;
      }
      
      public function checkSoundOverlapByIndex(param1:Number, param2:int = 5) : Number
      {
         var _loc3_:SoundContainer = null;
         var _loc4_:SoundContainer = null;
         _loc3_ = this._soundContainer.getItemAt(param1) as SoundContainer;
         var _loc5_:int = 0;
         while(_loc5_ < this._soundContainer.length)
         {
            _loc4_ = this._soundContainer.getItemAt(_loc5_) as SoundContainer;
            if(_loc3_.x > _loc4_.x && _loc3_.y == _loc4_.y && _loc4_ != _loc3_)
            {
               if(_loc3_.x - param2 < _loc4_.x + _loc4_.length)
               {
                  return _loc5_;
               }
            }
            _loc5_++;
         }
         return -1;
      }
      
      public function checkSoundOverlap() : Boolean
      {
         var _loc4_:int = 0;
         var _loc1_:SoundContainer = null;
         var _loc2_:SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc1_ = this._soundContainer.getItemAt(_loc3_) as SoundContainer;
            _loc4_ = _loc3_ + 1;
            while(_loc4_ < this._soundContainer.length)
            {
               _loc2_ = this._soundContainer.getItemAt(_loc4_) as SoundContainer;
               if(_loc1_.soundItem._bg.hitTestObject(_loc2_.soundItem._bg))
               {
                  return true;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getSoundIndexById(param1:String) : int
      {
         var _loc2_:SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc3_) as SoundContainer;
            if(_loc2_.id == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function setSoundReadyByID(param1:String) : void
      {
         var _loc2_:int = this.getSoundIndexById(param1);
         var _loc3_:SoundContainer = SoundContainer(this._soundContainer.getItemAt(_loc2_));
         _loc3_.soundReady = true;
      }
      
      public function setSoundInfoById(param1:String, param2:Number, param3:Number, param4:String = null, param5:Number = 0, param6:Number = 1) : void
      {
         var _loc8_:SoundContainer = null;
         var _loc7_:int = this.getSoundIndexById(param1);
         (_loc8_ = SoundContainer(this._soundContainer.getItemAt(_loc7_))).stime = param2;
         _loc8_.slength = param3;
         _loc8_.y = param5;
         _loc8_.inner_volume = param6;
         if(param4 != null)
         {
            _loc8_.label = param4;
         }
         _loc8_.soundItem.updateLabel(_loc8_.getLabel());
      }
      
      public function setSoundVolumeById(param1:String, param2:Number) : void
      {
         var _loc3_:int = this.getSoundIndexById(param1);
         var _loc4_:SoundContainer;
         (_loc4_ = SoundContainer(this._soundContainer.getItemAt(_loc3_))).inner_volume = param2;
      }
      
      public function setAllSoundInfo(param1:Array) : void
      {
         var _loc2_:ElementInfo = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = ElementInfo(param1[_loc3_]);
            this.setSoundInfoById(_loc2_.id,_loc2_.startPixel,_loc2_.totalPixel,null,_loc2_.y,_loc2_.inner_volume);
            _loc3_++;
         }
      }
      
      public function getSoundInfoById(param1:String) : ElementInfo
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc3_) as SoundContainer;
            if(_loc2_.id == param1)
            {
               param1 = _loc2_ == null ? "" : _loc2_.id;
               _loc4_ = _loc2_ == null ? -1 : int(_loc2_.time);
               _loc5_ = _loc2_ == null ? -1 : int(_loc2_.length);
               _loc6_ = _loc2_ == null ? Number(0) : Number(_loc2_.y);
               _loc7_ = _loc2_ == null ? Number(1) : Number(_loc2_.inner_volume);
               return new ElementInfo(ElementInfo.SOUND,param1,_loc4_,_loc5_,_loc6_,_loc7_);
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getSoundInfoByIndex(param1:int = -1) : ElementInfo
      {
         var _loc2_:SoundContainer = null;
         if(param1 < 0)
         {
            param1 = this._currSoundIndex;
         }
         if(param1 >= 0 && param1 < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(param1) as SoundContainer;
         }
         var _loc3_:String = _loc2_ == null ? "" : _loc2_.id;
         var _loc4_:int = _loc2_ == null ? -1 : int(_loc2_.time);
         var _loc5_:int = _loc2_ == null ? -1 : int(_loc2_.length);
         var _loc6_:Number = _loc2_ == null ? Number(0) : Number(_loc2_.y);
         var _loc7_:Number = _loc2_ == null ? Number(1) : Number(_loc2_.inner_volume);
         return new ElementInfo(ElementInfo.SOUND,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      public function getAllSoundInfo() : Array
      {
         var _loc3_:ElementInfo = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this._soundContainer.length)
         {
            _loc3_ = this.getSoundInfoByIndex(_loc2_);
            _loc1_.push(_loc3_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addSound(param1:AnimeSound) : void
      {
         ++this._totalSoundCount;
         ++this._soundNameCount;
         label = param1.getLabel();
         var _loc2_:SoundContainer = this.addContainer(SOUND,-1) as SoundContainer;
         _loc2_.id = param1.getID();
         _loc2_.label = label;
         _loc2_.stime = UtilUnitConvert.frameToX(param1.startFrame);
         _loc2_.y = SoundTrackArea.trackToPixel(param1.trackNum);
         _loc2_.inner_volume = param1.inner_volume;
         _loc2_.slength = UtilUnitConvert.frameToPixel(param1.totalFrame);
         _loc2_.animeSound = param1;
         _loc2_.soundItem.setWaveformVisible(this._showWaveform);
         param1.soundContainer = _loc2_;
         _loc2_.setTimelineReferer(this);
         this.selectSoundContainer(_loc2_);
         this.gotoLastSound();
         this.expandAllSoundTrack();
      }
      
      public function addSoundAtTime(param1:String, param2:String = null, param3:Number = 0, param4:Number = 0, param5:Number = 100, param6:int = -1, param7:Boolean = false, param8:Boolean = false, param9:Number = -1, param10:Number = 1) : SoundContainer
      {
         ++this._totalSoundCount;
         ++this._soundNameCount;
         param2 = param2 == null ? param1 : param2;
         var _loc11_:SoundContainer;
         (_loc11_ = this.addContainer(SOUND,param6) as SoundContainer).soundReady = param7;
         _loc11_.id = param1;
         _loc11_.label = param2;
         _loc11_.stime = param3;
         _loc11_.y = param4;
         _loc11_.inner_volume = param10;
         var _loc12_:Number;
         if((_loc12_ = this.getNextSoundOnSameTrack(param4,param3)) != 99999 && !param8)
         {
            if(param9 == -1 || _loc12_ < UtilUnitConvert.secToPixel(param9 / 1000))
            {
               _loc11_.slength = _loc12_;
            }
            else
            {
               _loc11_.slength = UtilUnitConvert.secToPixel(param9 / 1000);
            }
         }
         else
         {
            _loc11_.slength = param5;
         }
         _loc11_.setTimelineReferer(this);
         this.selectSoundContainer(_loc11_);
         this.gotoLastSound();
         this.expandAllSoundTrack();
         return _loc11_;
      }
      
      public function removeSoundById(param1:String) : void
      {
         var _loc2_:SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc3_) as SoundContainer;
            if(_loc2_.id == param1)
            {
               this.removeSound(_loc3_);
               return;
            }
            _loc3_++;
         }
      }
      
      public function removeSound(param1:int = -1) : void
      {
         if(this._currSoundContainer != null)
         {
            if(param1 < 0 || param1 >= this._soundContainer.length)
            {
               param1 = this._soundContainer.getItemIndex(this._currSoundContainer);
            }
            dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_REMOVED,param1,this._currSoundContainer.id));
            this._timelineScrollbar.removeSoundBar(this._currSoundContainer.name);
            this._soundContainer.removeItemAt(param1);
            this.sound_cs.removeChild(this.sound_cs.getChildAt(param1));
            this._totalSoundCount = this._soundContainer.length;
            if(this._soundContainer.length <= 0)
            {
               this._currSoundContainer = null;
            }
         }
      }
      
      public function removeAllSounds() : void
      {
         this._timelineScrollbar.removeSoundBar(null,true);
         this._totalSoundCount = 0;
         this.sound_cs.removeAllChildren();
         this._soundContainer.removeAll();
         this.sound_cs.setStyle("top",0);
         this.removeBottombar();
         this.updateTimelineSize();
      }
      
      public function allSoundsSetFocus(param1:Boolean) : void
      {
         var _loc2_:SoundContainer = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc3_) as SoundContainer;
            if(param1)
            {
               _loc2_.enableFocus();
            }
            else
            {
               _loc2_.disableFocus();
            }
            _loc3_++;
         }
      }
      
      public function getSceneLocalPosition(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(param1 < 0)
         {
            return 0;
         }
         var _loc2_:Array = SceneContainer(this._sceneContainer).getSceneBounds();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_].x;
            if(param1 < _loc4_)
            {
               return _loc2_[_loc3_ - 1].x;
            }
            _loc3_++;
         }
         return _loc2_[_loc3_ - 1].x;
      }
      
      public function getSceneLocalPositionByIndex(param1:Number) : Number
      {
         var _loc2_:Array = SceneContainer(this._sceneContainer).getSceneBounds();
         return _loc2_[param1].x;
      }
      
      public function getSceneLocalPositionIndex(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         if(param1 < 0)
         {
            return 0;
         }
         var _loc2_:Array = SceneContainer(this._sceneContainer).getSceneBounds();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_].x;
            if(param1 < _loc4_)
            {
               return _loc3_ - 1;
            }
            _loc3_++;
         }
         return _loc3_ - 1;
      }
      
      public function setLoadingStatus(param1:Boolean) : void
      {
         this._maskCanvas.visible = param1;
      }
      
      public function updateSceneSpeechByIndex(param1:int, param2:String, param3:AnimeSound) : void
      {
         SceneContainer(this._sceneContainer).updateSpeechTxtByIndex(param1,param2,param3);
      }
      
      private function addContainer(param1:String, param2:int = -1) : ITimelineContainer
      {
         var _loc3_:ITimelineContainer = null;
         switch(param1)
         {
            case SCENE:
               _loc3_ = new SceneContainer();
               _loc3_.name = SCENE;
               _loc3_.label = "Scene";
               _loc3_.percentWidth = 100;
               _loc3_.scaleX = 1;
               _loc3_.height = this.SCENECONTAINER_HEIGHT;
               this._sceneContainer = _loc3_;
               this.scene_vb.addChild(_loc3_ as DisplayObject);
               break;
            case SOUND:
               _loc3_ = new SoundContainer();
               _loc3_.name = "SOUND_" + this._soundNameCount;
               _loc3_.label = "Sound";
               _loc3_.percentWidth = 100;
               _loc3_.height = SoundContainer.SOUNDCONTAINER_HEIGHT;
               this._soundContainer.addItem(_loc3_);
               this.sound_cs.addChild(_loc3_ as DisplayObject);
               this._timelineScrollbar.addContainerToScrollBar(_loc3_ as SoundContainer);
               _loc3_.addEventListener(TimelineEvent.SOUND_MOUSE_DOWN,this.onSoundDownHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_MOUSE_UP,this.onSoundUpHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_CLICK,this.onSoundClickHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_RESIZE_START,this.onSoundResizeStartHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_RESIZE,this.onSoundResizeHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_RESIZE_COMPLETE,this.onSoundResizeCompleteHandler);
               _loc3_.addEventListener(TimelineEvent.SOUND_MOVE,this.onSoundMoveHandler);
               break;
            case BBAR:
               _loc3_ = new BottomBarContainer();
               _loc3_.name = "BottomBar";
               _loc3_.percentWidth = 100;
               _loc3_.height = this.BBARCONTAINER_HEIGHT;
               this._bbarContainer = _loc3_;
               this.bbar_vb.addChild(_loc3_ as DisplayObject);
               _loc3_.addEventListener(TimelineEvent.NEXT_CLICK,this.onBBarClickHandler);
               _loc3_.addEventListener(TimelineEvent.PREV_CLICK,this.onBBarClickHandler);
               this.updateBottomBarButtons();
         }
         this.updateTimelineSize();
         return _loc3_;
      }
      
      private function scrollHandler(param1:ScrollEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(this.scene_vb.numChildren != 0)
         {
            (this.scene_vb.getChildAt(0) as SceneContainer).setHorizontalView(param1.currentTarget.scrollPosition);
            _loc2_ = this._soundContainer.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._soundContainer[_loc3_].setHorizontalView(param1.currentTarget.scrollPosition);
               _loc3_++;
            }
            this.background_bg.setHorizontalView(param1.currentTarget.scrollPosition);
         }
      }
      
      public function bringUp(param1:SoundContainer) : void
      {
         this.sound_cs.removeChild(param1);
         this.sound_cs.addChild(param1);
         this._soundContainer.removeItemAt(this._soundContainer.getItemIndex(param1));
         this._soundContainer.addItem(param1);
      }
      
      private function removeBottombar() : void
      {
         this.bbar_vb.removeAllChildren();
         this._bbarContainer = null;
      }
      
      private function nextScene() : void
      {
         ++this._currBgStartIndex;
         this.gotoSceneAt(this._currBgStartIndex);
      }
      
      private function prevScene() : void
      {
         --this._currBgStartIndex;
         if(this._currBgStartIndex <= 0)
         {
            this._currBgStartIndex = 0;
         }
         this.gotoSceneAt(this._currBgStartIndex);
      }
      
      private function gotoSceneAt(param1:Number) : void
      {
         var _loc2_:Number = this._soundContainer.length;
         this._sceneContainer.setHorizontalView(this.background_bg.getHorizontalView(param1));
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._soundContainer[_loc3_].setHorizontalView(this.background_bg.getHorizontalView(param1));
            _loc3_++;
         }
         this.background_bg.setHorizontalView(this.background_bg.getHorizontalView(param1));
         this._currBgStartIndex = param1;
      }
      
      private function nextSound() : void
      {
         ++this._currSoundIndex;
         if(this._currSoundIndex >= this._soundContainer.length)
         {
            this._currSoundIndex = this._soundContainer.length - 1;
         }
         this.resetSoundContainerFocus();
         this._currSoundContainer = this._soundContainer.getItemAt(this._currSoundIndex) as SoundContainer;
         this._currSoundContainer.focus = true;
         if(this._currSoundIndex >= this._currSoundStartIndex + this.MAX_SOUND_TRACK - 1)
         {
            ++this._currSoundStartIndex;
            if(this._currSoundStartIndex >= this._soundContainer.length - this.MAX_SOUND_TRACK)
            {
               this._currSoundStartIndex = this._soundContainer.length - this.MAX_SOUND_TRACK;
            }
            this.gotoSoundAt(this._currSoundStartIndex);
         }
      }
      
      private function prevSound() : void
      {
         --this._currSoundIndex;
         if(this._currSoundIndex <= 0)
         {
            this._currSoundIndex = 0;
         }
         this.resetSoundContainerFocus();
         this._currSoundContainer = this._soundContainer.getItemAt(this._currSoundIndex) as SoundContainer;
         this._currSoundContainer.focus = true;
         if(this._currSoundIndex <= this._currSoundStartIndex)
         {
            --this._currSoundStartIndex;
            if(this._currSoundStartIndex <= 0)
            {
               this._currSoundStartIndex = 0;
            }
            this.gotoSoundAt(this._currSoundStartIndex);
         }
      }
      
      private function gotoSoundAt(param1:Number) : void
      {
      }
      
      private function gotoLastSound() : void
      {
         this._currSoundIndex = this._soundContainer.length - 1;
         if(this._soundContainer.length >= this.MAX_SOUND_TRACK)
         {
            this._currSoundStartIndex = this._soundContainer.length - this.MAX_SOUND_TRACK;
            this.gotoSoundAt(this._currSoundStartIndex);
         }
         this.updateBottomBarButtons();
      }
      
      public function updateAllScenesLabel() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._sceneContainer.length)
         {
            this._sceneContainer.changeProperty(_loc1_,"label",_loc1_ + 1);
            _loc1_++;
         }
      }
      
      private function getCaptureScreen() : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         var _loc4_:Matrix = null;
         var _loc5_:Number = NaN;
         var _loc6_:BitmapData = null;
         var _loc1_:Boolean = false;
         if(_loc1_)
         {
            _loc3_ = this.getBitmapData(UIComponent(this._targetUI));
            _loc2_ = new BitmapData(this._captureRect.width,this._captureRect.height);
            if(_loc3_ != null)
            {
               _loc2_.copyPixels(_loc3_,new Rectangle(this._captureRect.x,this._captureRect.y,this._captureRect.width,this._captureRect.height),new Point());
               return _loc2_;
            }
            return null;
         }
         if(this._captureRect == null)
         {
            return null;
         }
         _loc2_ = new BitmapData(this._captureRect.width,this._captureRect.height,false,0);
         if(this._targetUI != null)
         {
            _loc4_ = new Matrix();
            _loc5_ = this.SCENE_IMAGE_WIDTH / this._captureRect.width;
            _loc4_.translate(-this._captureRect.x,-this._captureRect.y);
            _loc2_.draw(UIComponent(this._targetUI),_loc4_);
            _loc6_ = new BitmapData(this.SCENE_IMAGE_WIDTH,this.SCENE_IMAGE_HEIGHT,false,0);
            (_loc4_ = new Matrix()).scale(_loc5_,_loc5_);
            _loc6_.draw(_loc2_,_loc4_,null,null,null,true);
            return _loc6_;
         }
         return null;
      }
      
      private function getBitmapData(param1:UIComponent) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Matrix = null;
         try
         {
            _loc2_ = new BitmapData(param1.width,param1.height,false,0);
            _loc3_ = new Matrix();
            _loc2_.draw(param1,_loc3_);
            return _loc2_;
         }
         catch(exp:Error)
         {
            return null;
         }
      }
      
      private function updateSoundContainerSize() : void
      {
         this.sound_cs.height = 20 * this.MAX_SOUND_TRACK - 2;
      }
      
      private function updateTimelineSize() : void
      {
         var _loc1_:Number = 0;
         if(this._soundContainer.length < this.MAX_SOUND_TRACK + 1)
         {
            this.updateSoundContainerSize();
         }
         _loc1_ = this._sceneContainer.height;
         if(this.sb_canvas.visible)
         {
            _loc1_ += 22;
         }
         _loc1_ += this.sound_cs.height;
         if(this._bbarContainer != null)
         {
            _loc1_ += this._bbarContainer.height + this._verticalGap;
         }
      }
      
      private function resetSoundContainerFocus() : void
      {
         var _loc3_:SoundContainer = null;
         var _loc1_:Number = this._soundContainer.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.sound_cs.getChildAt(_loc2_) as SoundContainer;
            _loc3_.focus = false;
            _loc2_++;
         }
      }
      
      private function selectSoundContainer(param1:SoundContainer) : void
      {
         var _loc2_:Boolean = param1.focus;
         if(!_loc2_)
         {
            this.resetSoundContainerFocus();
            this._currSoundIndex = this._soundContainer.getItemIndex(param1);
            this._currSoundContainer = param1;
         }
      }
      
      private function onSoundDownHandler(param1:TimelineEvent) : void
      {
         var _loc2_:SoundContainer = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         try
         {
            _loc2_ = param1.currentTarget as SoundContainer;
            this.selectSoundContainer(_loc2_);
            _loc3_ = this._currSoundIndex;
            _loc4_ = _loc2_.id;
            dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOUSE_DOWN,_loc3_,_loc4_));
         }
         catch(e:Error)
         {
         }
      }
      
      private function onSoundUpHandler(param1:TimelineEvent) : void
      {
         var _loc2_:SoundContainer = param1.currentTarget as SoundContainer;
         var _loc3_:int = this._currSoundIndex;
         var _loc4_:String = _loc2_.id;
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOUSE_UP,_loc3_,_loc4_));
      }
      
      private function onBBarClickHandler(param1:TimelineEvent) : void
      {
         switch(param1.type)
         {
            case TimelineEvent.PREV_CLICK:
               this.prevSound();
               dispatchEvent(new TimelineEvent(TimelineEvent.PREV_CLICK));
               break;
            case TimelineEvent.NEXT_CLICK:
               this.nextSound();
               dispatchEvent(new TimelineEvent(TimelineEvent.NEXT_CLICK));
         }
         this.updateBottomBarButtons();
      }
      
      private function onSceneMouseDownHandler(param1:TimelineEvent) : void
      {
         var _loc2_:Number = param1.index;
         var _loc3_:ElementInfo = this.getSceneInfoByIndex(_loc2_);
         var _loc4_:TimelineEvent;
         (_loc4_ = new TimelineEvent(TimelineEvent.SCENE_MOUSE_DOWN,_loc2_,_loc3_.id)).shiftKey = param1.shiftKey;
         dispatchEvent(_loc4_);
      }
      
      private function onSceneMouseUpHandler(param1:TimelineEvent) : void
      {
         var _loc2_:Number = this._sceneContainer.getCurrIndex();
         var _loc3_:ElementInfo = this.getSceneInfoByIndex(_loc2_);
         var _loc4_:TimelineEvent;
         (_loc4_ = new TimelineEvent(TimelineEvent.SCENE_MOUSE_UP,_loc2_,_loc3_.id)).shiftKey = param1.shiftKey;
         dispatchEvent(_loc4_);
      }
      
      public function doPatchSceneResizeStart(param1:int) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_START,param1));
      }
      
      public function doPatchSceneResizeComplete(param1:int) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_COMPLETE,param1));
         this.updateHelpToolTip();
      }
      
      private function updateHelpToolTip() : void
      {
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            if(this.getTotalTimeInSec() > FeatureManager.maxMovieDuration)
            {
               this.btnTip.visible = true;
            }
            else
            {
               this.btnTip.visible = false;
            }
         }
      }
      
      private function shortTimeline(param1:Number, param2:Number) : void
      {
         var _loc5_:SoundContainer = null;
         var _loc6_:SoundContainer = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc3_:Number = 0;
         var _loc4_:Number = 6;
         _loc8_ = 0;
         while(_loc8_ < this._soundContainer.length)
         {
            (_loc5_ = this._soundContainer.getItemAt(_loc8_) as SoundContainer).tempSoundInfo = this.getSoundInfoByIndex(_loc8_);
            _loc8_++;
         }
         do
         {
            _loc3_ += _loc4_;
            _loc5_ = null;
            _loc6_ = null;
            _loc7_ = new Array();
            _loc8_ = 0;
            _loc8_ = 0;
            while(_loc8_ < this._soundContainer.length)
            {
               (_loc5_ = this._soundContainer.getItemAt(_loc8_) as SoundContainer).tempSoundInfo2 = this.getSoundInfoByIndex(_loc8_);
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < this._soundContainer.length)
            {
               _loc5_ = this._soundContainer.getItemAt(_loc8_) as SoundContainer;
               _loc10_ = -1;
               if(_loc5_.tempSoundInfo.startPixel >= param2)
               {
                  _loc5_.stime = _loc5_.x - _loc4_;
                  Console.getConsole().updateSoundById(_loc5_.id);
                  _loc7_.push({
                     "action":"move",
                     "container":_loc5_,
                     "para":_loc4_
                  });
                  if((_loc10_ = this.checkSoundOverlapByIndex(_loc8_,2)) != -1)
                  {
                     _loc6_ = this._soundContainer.getItemAt(_loc10_) as SoundContainer;
                     _loc7_.push({
                        "action":"resize",
                        "container":_loc6_,
                        "para":_loc5_.x - _loc6_.x - 6
                     });
                  }
               }
               _loc8_++;
            }
            _loc9_ = true;
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               if(_loc7_[_loc8_].action == "resize")
               {
                  if(_loc7_[_loc8_].para < AnimeConstants.SOUND_LENGTH_MINIMUM)
                  {
                     _loc9_ = false;
                  }
               }
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc7_.length)
            {
               switch(_loc9_)
               {
                  case true:
                     if(_loc7_[_loc8_].action == "resize")
                     {
                        (_loc5_ = _loc7_[_loc8_].container).slength = _loc7_[_loc8_].para;
                        Console.getConsole().updateSoundById(_loc5_.id);
                     }
                     break;
                  case false:
                     if(_loc7_[_loc8_].action == "move")
                     {
                        _loc5_ = _loc7_[_loc8_].container;
                        _loc5_.stime = _loc5_.tempSoundInfo2.startPixel;
                        Console.getConsole().updateSoundById(_loc5_.id);
                     }
                     break;
               }
               _loc8_++;
            }
            if(_loc3_ + _loc4_ > param1)
            {
               _loc9_ = false;
            }
         }
         while(_loc3_ + _loc4_ <= param1 && _loc9_ == true);
         
      }
      
      public function onSceneResize(param1:SceneElement, param2:Number) : void
      {
         var _loc10_:int = 0;
         var _loc11_:ElementInfo = null;
         var _loc12_:Number = NaN;
         var _loc3_:SoundContainer = null;
         param2 = Math.round(param2 / AnimeConstants.SCENE_SNAP_INTERVAL) * AnimeConstants.SCENE_SNAP_INTERVAL;
         var _loc4_:Number = param2 - this._onDragSceneInfo.totalPixel;
         _loc4_ = Math.round(_loc4_ / AnimeConstants.SCENE_SNAP_INTERVAL) * AnimeConstants.SCENE_SNAP_INTERVAL;
         var _loc5_:Number = -1;
         var _loc6_:Array = new Array();
         var _loc7_:int = 0;
         var _loc8_:UtilHashArray = this._soundTesterArray;
         _loc7_ = 0;
         while(_loc7_ < this._soundContainer.length)
         {
            _loc3_ = this._soundContainer.getItemAt(_loc7_) as SoundContainer;
            _loc3_.tempSoundInfo2 = this.getSoundInfoByIndex(_loc7_);
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc8_.length)
         {
            _loc3_ = _loc8_.getValueByIndex(_loc7_) as SoundContainer;
            if(_loc3_.tempSoundInfo.startPixel >= this._onDragSceneInfo.startPixel + this._onDragSceneInfo.totalPixel)
            {
               _loc3_.moveStartTime(_loc4_);
               Console.getConsole().updateSoundById(_loc3_.id);
               _loc6_.push({
                  "action":"move",
                  "container":_loc3_,
                  "para":_loc4_
               });
               _loc3_.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",_loc3_));
            }
            _loc7_++;
         }
         if(_loc4_ < 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc8_.length)
            {
               _loc3_ = _loc8_.getValueByIndex(_loc7_) as SoundContainer;
               if((_loc5_ = this.checkSoundOverlapWithBlocker(_loc3_)) != -1)
               {
                  break;
               }
               _loc7_++;
            }
         }
         var _loc9_:SceneContainer = null;
         if(_loc5_ == -1)
         {
            param1.width = param2;
            (_loc9_ = SceneContainer(this._sceneContainer)).itemList_hb.graphics.clear();
            SceneElement(param1).showIndicator();
            _loc10_ = this._sceneContainer.getCurrIndex();
            _loc11_ = this.getSceneInfoByIndex(_loc10_);
            _loc12_ = param2;
            this.background_bg.setCeilWidth(_loc10_,_loc12_);
            dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE,_loc10_,_loc11_.id));
         }
         else
         {
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               if(_loc6_[_loc7_].action == "move")
               {
                  _loc3_ = _loc6_[_loc7_].container;
                  _loc3_.stime = _loc3_.tempSoundInfo2.startPixel;
                  Console.getConsole().updateSoundById(_loc3_.id);
                  _loc3_.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",_loc3_));
               }
               _loc7_++;
            }
         }
      }
      
      private function onSceneResizeHandler(param1:TimelineEvent) : void
      {
      }
      
      private function onSceneResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:int = this._sceneContainer.getCurrIndex();
         var _loc3_:ElementInfo = this.getSceneInfoByIndex(_loc2_);
         var _loc4_:Number = _loc3_.actionPixel;
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_START,_loc2_));
         this._onDragSceneInfo = _loc3_;
         var _loc5_:SoundContainer = null;
         var _loc6_:int = 0;
         while(_loc6_ < this._soundContainer.length)
         {
            (_loc5_ = this._soundContainer.getItemAt(_loc6_) as SoundContainer).tempSoundInfo = this.getSoundInfoByIndex(_loc6_);
            _loc6_++;
         }
         var _loc7_:Object = this.captureTesterAndMover();
         this._soundTesterArray = _loc7_["checker"];
         this._soundMoverArray = _loc7_["mover"];
         this._soundBlockerArray = _loc7_["blocker"];
         _loc6_ = 0;
         while(_loc6_ < this._soundMoverArray.length)
         {
            (_loc5_ = this._soundMoverArray[_loc6_] as SoundContainer).alpha = 0.5;
            _loc6_++;
         }
      }
      
      private function onSceneResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:SoundContainer = null;
         var _loc2_:int = this._sceneContainer.getCurrIndex();
         var _loc3_:ElementInfo = this.getSceneInfoByIndex(_loc2_);
         var _loc4_:Number = _loc3_.actionPixel;
         this.background_bg.setCeilWidth(_loc2_,_loc4_);
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_COMPLETE,_loc2_));
         if(this._onDragSceneInfo)
         {
            _loc5_ = _loc3_.totalPixel - this._onDragSceneInfo.totalPixel;
            _loc6_ = 0;
            while(_loc6_ < this._soundMoverArray.length)
            {
               (_loc7_ = this._soundMoverArray[_loc6_] as SoundContainer).moveStartTime(_loc5_);
               Console.getConsole().updateSoundById(_loc7_.id);
               _loc7_.alpha = 1;
               _loc7_.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",_loc7_));
               _loc6_++;
            }
            this.background_bg.validateNow();
         }
         this._onDragSceneInfo = null;
         this._soundTesterArray = null;
         this._soundMoverArray = null;
         this._soundBlockerArray = null;
         this.updateHelpToolTip();
      }
      
      private function captureTesterAndMover() : Object
      {
         var _loc2_:SoundContainer = null;
         var _loc7_:SoundContainer = null;
         var _loc8_:SoundContainer = null;
         var _loc1_:int = 0;
         var _loc3_:UtilHashArray = new UtilHashArray();
         var _loc4_:Array = new Array();
         var _loc5_:UtilHashArray = new UtilHashArray();
         var _loc6_:Number = this._onDragSceneInfo.startPixel + this._onDragSceneInfo.totalPixel;
         _loc1_ = 0;
         while(_loc1_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc1_) as SoundContainer;
            if(_loc2_.tempSoundInfo.startPixel >= _loc6_)
            {
               if((_loc7_ = _loc3_.getValueByKey(String(_loc2_.tempSoundInfo.y))) == null || _loc7_.tempSoundInfo.startPixel > _loc2_.tempSoundInfo.startPixel)
               {
                  _loc3_.push(String(_loc2_.tempSoundInfo.y),_loc2_);
               }
            }
            else if((_loc8_ = _loc5_.getValueByKey(String(_loc2_.tempSoundInfo.y))) == null || _loc8_.tempSoundInfo.startPixel < _loc2_.tempSoundInfo.startPixel)
            {
               _loc5_.push(String(_loc2_.tempSoundInfo.y),_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._soundContainer.length)
         {
            _loc2_ = this._soundContainer.getItemAt(_loc1_) as SoundContainer;
            if(_loc2_.tempSoundInfo.startPixel >= _loc6_)
            {
               if(!_loc3_.containsValue(_loc2_))
               {
                  _loc4_.push(_loc2_);
               }
            }
            _loc1_++;
         }
         return {
            "checker":_loc3_,
            "mover":_loc4_,
            "blocker":_loc5_
         };
      }
      
      private function onSoundClickHandler(param1:TimelineEvent) : void
      {
         var _loc2_:SoundContainer = param1.currentTarget as SoundContainer;
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_CLICK,param1.index,param1.id,_loc2_));
      }
      
      private function onSoundMoveHandler(param1:TimelineEvent) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOVE,param1.index,param1.id));
      }
      
      private function onSoundResizeHandler(param1:TimelineEvent) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE,param1.index,param1.id));
      }
      
      private function onSoundResizeStartHandler(param1:TimelineEvent) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_START,param1.index,param1.id));
      }
      
      private function onSoundResizeCompleteHandler(param1:TimelineEvent) : void
      {
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_COMPLETE,param1.index,param1.id));
      }
      
      private function updateBottomBarButtons() : void
      {
         var _loc1_:BottomBarContainer = null;
         if(this._bbarContainer != null)
         {
            _loc1_ = BottomBarContainer(this._bbarContainer);
            if(this._currSoundIndex <= 0)
            {
               _loc1_.toggleButton(0,false);
            }
            else
            {
               _loc1_.toggleButton(0,true);
            }
            if(this._currSoundIndex >= this._soundContainer.length - 1)
            {
               _loc1_.toggleButton(1,false);
            }
            else
            {
               _loc1_.toggleButton(1,true);
            }
         }
      }
      
      private function getSpaceInRow(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc8_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc4_:SoundContainer = null;
         var _loc5_:Number = 0;
         var _loc6_:Array = new Array();
         var _loc7_:int = 0;
         while(_loc7_ < this._soundContainer.length)
         {
            if((_loc4_ = this._soundContainer.getItemAt(_loc7_) as SoundContainer).y == param1)
            {
               _loc6_.push({
                  "time":_loc4_.time,
                  "length":_loc4_.length
               });
               _loc5_++;
            }
            _loc7_++;
         }
         var _loc9_:Number = 0;
         var _loc10_:Number = -1;
         var _loc11_:Array = new Array();
         _loc8_ = param2;
         while(_loc8_ < param3)
         {
            _loc12_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               if(_loc6_[_loc7_].time <= _loc8_ && _loc8_ <= _loc6_[_loc7_].time + _loc6_[_loc7_].length + 5)
               {
                  _loc12_ = true;
               }
               _loc7_++;
            }
            if(!_loc12_)
            {
               if(_loc9_ == 0)
               {
                  _loc10_ = _loc8_;
               }
               _loc9_++;
            }
            else
            {
               if(_loc10_ != -1)
               {
                  _loc11_.push({
                     "x":_loc10_,
                     "width":_loc9_
                  });
               }
               _loc10_ = -1;
               _loc9_ = 0;
            }
            if(_loc8_ == param3 - 1 && !_loc12_ && _loc10_ != -1)
            {
               _loc11_.push({
                  "x":_loc10_,
                  "width":_loc9_
               });
            }
            _loc8_++;
         }
         if(_loc11_.length > 0)
         {
            _loc11_.sortOn("width",Array.NUMERIC | Array.DESCENDING);
            if(_loc11_[0].width >= 21)
            {
               return _loc11_[0].x;
            }
         }
         if(_loc5_ == 0)
         {
            return 0;
         }
         return -1;
      }
      
      public function getEarliestSoundSpace(param1:Number) : Point
      {
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Point = null;
         var _loc9_:Object = null;
         var _loc2_:ElementInfo = this.getSceneInfoByIndex(param1);
         var _loc4_:Number = _loc2_.startPixel;
         var _loc5_:Number = _loc2_.startPixel + _loc2_.actionPixel;
         var _loc6_:Array = new Array();
         _loc3_ = 0;
         while(_loc3_ < this.MAX_SOUND_TRACK)
         {
            _loc7_ = _loc3_ * (SoundContainer.SOUNDCONTAINER_HEIGHT + this._verticalGap);
            _loc6_.push({
               "x":this.getSpaceInRow(_loc7_,_loc4_,_loc5_),
               "y":_loc7_
            });
            _loc3_++;
         }
         _loc6_.sortOn(["x","y"],[Array.NUMERIC]);
         do
         {
            if(_loc6_.length >= 1)
            {
               _loc9_ = _loc6_.shift();
               _loc8_ = new Point(_loc9_.x,_loc9_.y);
            }
            else
            {
               _loc8_ = new Point(-999,0);
            }
         }
         while(_loc8_.x == -1);
         
         return _loc8_;
      }
      
      private function onResize(param1:Event) : void
      {
         this.refreshInterface();
      }
      
      private function refreshInterface() : void
      {
         this.background_bg.width = this.width;
         this.container_vb.scrollRect = new Rectangle(0,0,this.width,200);
      }
      
      public function triggerAllSoundTrackSize() : void
      {
         if(!this._isSoundTracksCollapsed)
         {
            this.collapseAllSoundTrack();
         }
         else
         {
            this.expandAllSoundTrack();
         }
      }
      
      public function triggerAllSoundWaveFormDisplay() : void
      {
         var _loc2_:SoundContainer = null;
         var _loc3_:SceneElement = null;
         this._showWaveform = !this._showWaveform;
         var _loc1_:uint = 0;
         if(this._soundContainer.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._soundContainer.length)
            {
               _loc2_ = this._soundContainer[_loc1_] as SoundContainer;
               if(_loc2_)
               {
                  _loc2_.soundItem.setWaveformVisible(this._showWaveform);
               }
               _loc1_++;
            }
         }
         if(this._sceneContainer.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._sceneContainer.length)
            {
               _loc3_ = this._sceneContainer.getItemAt(_loc1_) as SceneElement;
               if(SceneElement)
               {
                  _loc3_.setWaveformVisible(this._showWaveform);
               }
               _loc1_++;
            }
         }
      }
      
      public function collapseAllSoundTrack() : void
      {
         if(!this._isSoundTracksCollapsed)
         {
            this.height = 103;
            this.soundTrackArea.includeInLayout = this.soundTrackArea.visible = false;
            this.toolBar.collapse();
            this._isSoundTracksCollapsed = true;
         }
      }
      
      public function expandAllSoundTrack() : void
      {
         if(this._isSoundTracksCollapsed)
         {
            this.height = 182;
            this.soundTrackArea.includeInLayout = this.soundTrackArea.visible = true;
            this.toolBar.expand();
            this._isSoundTracksCollapsed = false;
         }
      }
      
      public function scroll(param1:Number) : void
      {
         this._scrollPosition = param1;
         this.ruler.setHorizontalView(param1);
         this.soundTrackArea.scroll(param1);
      }
      
      public function get scrollPosition() : Number
      {
         return this._scrollPosition;
      }
      
      public function get sound_cs() : Canvas
      {
         return this.soundTrackArea.sound_cs;
      }
      
      protected function onMainContainerResize(param1:ResizeEvent) : void
      {
         this.bg.graphics.clear();
         this.bg.graphics.beginFill(13421772);
         this.bg.graphics.drawRect(0,0,this.bg.width,this.bg.height);
         this.bg.graphics.lineStyle(1,7829367,1,true);
         this.bg.graphics.moveTo(0,52);
         this.bg.graphics.lineTo(this.bg.width,52);
      }
      
      private function _Timeline_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.angle = 90;
         _loc1_.color = 6710886;
         _loc1_.distance = 2;
         this.shadowFilter = _loc1_;
         BindingManager.executeBindings(this,"shadowFilter",this.shadowFilter);
         return _loc1_;
      }
      
      public function ___Timeline_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function ___Timeline_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.onResize(param1);
      }
      
      public function __bg_resize(param1:ResizeEvent) : void
      {
         this.onMainContainerResize(param1);
      }
      
      private function _Timeline_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Array
         {
            var _loc1_:* = [shadowFilter];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"bg.filters");
         result[1] = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,this.width,200);
         },null,"container_vb.scrollRect");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","timeline_durationalert");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnTip.toolTip");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvas() : Canvas
      {
         return this._1336746749_maskCanvas;
      }
      
      public function set _maskCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1336746749_maskCanvas;
         if(_loc2_ !== param1)
         {
            this._1336746749_maskCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _timelineScrollbar() : TimelineHScrollBar
      {
         return this._362247270_timelineScrollbar;
      }
      
      public function set _timelineScrollbar(param1:TimelineHScrollBar) : void
      {
         var _loc2_:Object = this._362247270_timelineScrollbar;
         if(_loc2_ !== param1)
         {
            this._362247270_timelineScrollbar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_timelineScrollbar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get background_bg() : BackgroundGrid
      {
         return this._1893604106background_bg;
      }
      
      public function set background_bg(param1:BackgroundGrid) : void
      {
         var _loc2_:Object = this._1893604106background_bg;
         if(_loc2_ !== param1)
         {
            this._1893604106background_bg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"background_bg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bbar_vb() : VBox
      {
         return this._320222918bbar_vb;
      }
      
      public function set bbar_vb(param1:VBox) : void
      {
         var _loc2_:Object = this._320222918bbar_vb;
         if(_loc2_ !== param1)
         {
            this._320222918bbar_vb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bbar_vb",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bg() : Canvas
      {
         return this._3141bg;
      }
      
      public function set bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._3141bg;
         if(_loc2_ !== param1)
         {
            this._3141bg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnTip() : Button
      {
         return this._1378820961btnTip;
      }
      
      public function set btnTip(param1:Button) : void
      {
         var _loc2_:Object = this._1378820961btnTip;
         if(_loc2_ !== param1)
         {
            this._1378820961btnTip = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnTip",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get container_vb() : VBox
      {
         return this._2141670186container_vb;
      }
      
      public function set container_vb(param1:VBox) : void
      {
         var _loc2_:Object = this._2141670186container_vb;
         if(_loc2_ !== param1)
         {
            this._2141670186container_vb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"container_vb",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get ruler() : TimelineRuler
      {
         return this._108873974ruler;
      }
      
      public function set ruler(param1:TimelineRuler) : void
      {
         var _loc2_:Object = this._108873974ruler;
         if(_loc2_ !== param1)
         {
            this._108873974ruler = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ruler",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sb_canvas() : Canvas
      {
         return this._1361347256sb_canvas;
      }
      
      public function set sb_canvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1361347256sb_canvas;
         if(_loc2_ !== param1)
         {
            this._1361347256sb_canvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sb_canvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scene_vb() : VBox
      {
         return this._775487681scene_vb;
      }
      
      public function set scene_vb(param1:VBox) : void
      {
         var _loc2_:Object = this._775487681scene_vb;
         if(_loc2_ !== param1)
         {
            this._775487681scene_vb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scene_vb",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shadowFilter() : DropShadowFilter
      {
         return this._1956980552shadowFilter;
      }
      
      public function set shadowFilter(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._1956980552shadowFilter;
         if(_loc2_ !== param1)
         {
            this._1956980552shadowFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shadowFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get soundTrackArea() : SoundTrackArea
      {
         return this._1870704681soundTrackArea;
      }
      
      public function set soundTrackArea(param1:SoundTrackArea) : void
      {
         var _loc2_:Object = this._1870704681soundTrackArea;
         if(_loc2_ !== param1)
         {
            this._1870704681soundTrackArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundTrackArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get toolBar() : TimelineToolBar
      {
         return this._1140124837toolBar;
      }
      
      public function set toolBar(param1:TimelineToolBar) : void
      {
         var _loc2_:Object = this._1140124837toolBar;
         if(_loc2_ !== param1)
         {
            this._1140124837toolBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"toolBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _verticalGap() : Number
      {
         return this._1454985665_verticalGap;
      }
      
      public function set _verticalGap(param1:Number) : void
      {
         var _loc2_:Object = this._1454985665_verticalGap;
         if(_loc2_ !== param1)
         {
            this._1454985665_verticalGap = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_verticalGap",_loc2_,param1));
            }
         }
      }
   }
}
