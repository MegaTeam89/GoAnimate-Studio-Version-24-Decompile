package anifire.playerComponent
{
   import anifire.component.MochiAdDisplay;
   import anifire.component.ProgressMonitor;
   import anifire.component.timeFrameSynchronizer;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.debug.PlayerDebugManager;
   import anifire.debug.PlayerDebugPanel;
   import anifire.event.LoadMgrEvent;
   import anifire.playback.PlainPlayer;
   import anifire.playback.PlayerEvent;
   import anifire.playback.SceneBufferManager;
   import anifire.playerComponent.playerEndScreen.PlayerEndScreen;
   import anifire.playerComponent.playerEndScreen.PlayerEndScreenEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilMath;
   import anifire.util.UtilMovieInfoXMLLoader;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilUnitConvert;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.getDefinitionByName;
   import flash.utils.setTimeout;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Box;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.Move;
   import mx.effects.easing.Exponential;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.styles.CSSStyleDeclaration;
   import mx.utils.StringUtil;
   
   use namespace mx_internal;
   
   public class PreviewPlayer extends Canvas implements IBindingClient
   {
      
      private static var _logger:ILogger = Log.getLogger("playerComponent.PlayerControl");
      
      private static const LOADING_ICON_NAME:String = "loading_icon";
      
      private static var PLAYHEAD_STATE_PLAY:int = 1;
      
      private static var PLAYHEAD_STATE_PAUSE:int = 2;
      
      private static var PLAYHEAD_STATE_NULL:int = 0;
      
      private static var PLAYHEAD_STATE_MOVIE_END:int = 3;
      
      public static const NORMAL_SCREEN_MODE:uint = 0;
      
      public static const FULL_SCREEN_MODE:uint = 1;
      
      public static const RECORDING_SCREEN_MODE:uint = 2;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1462422359alertText:Text;
      
      private var _61512610buffering:Canvas;
      
      private var _1707945992contentContainer:Canvas;
      
      private var _1254676919createYourOwn:Label;
      
      private var _566693337curtainBox:Box;
      
      private var _1854636175debugPanel:PlayerDebugPanel;
      
      private var _1593500967endScreen:PlayerEndScreen;
      
      private var _168901560googleAdsAttribution:Text;
      
      private var _336650556loading:Label;
      
      private var _459583688loadingScreen:Canvas;
      
      private var _231891831loadingText:Text;
      
      private var _1645408545mochiContainer:UIComponent;
      
      private var _1994587966moveEffect:Move;
      
      private var _1840541266movieStage:Canvas;
      
      private var _690449604playerControl:PlayerControl;
      
      private var _1131509414progressBar:Canvas;
      
      private var _772093527scaleContainer:Canvas;
      
      private var _176252277screenContainer:Canvas;
      
      private var _1523976162timeFrameSynchronizer:timeFrameSynchronizer;
      
      private var _1274894500txtLicenserDisclaimer:Text;
      
      private var _213424028watermark:PlayerWatermark;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _filmXML:XML;
      
      private var _themeXMLs:UtilHashArray;
      
      private var _imageData:UtilHashArray;
      
      private var _urlRequest:URLRequest;
      
      private var _urlRequestArray:Array;
      
      private var _flashVars:UtilHashArray;
      
      private var previewMode:Boolean = false;
      
      private var firstStart:Boolean = true;
      
      protected var plainPlayer:PlainPlayer;
      
      private var _expectedPlayHeadState:int;
      
      private var _subComponents:Array;
      
      private var _isInited:Boolean = false;
      
      private var movieInfoLoader:UtilMovieInfoXMLLoader;
      
      private var previewSceneFirstStart:Boolean = true;
      
      private var previewSceneNum:Number = 0;
      
      private var _owner:String = "";
      
      private var _ad:MochiAdDisplay;
      
      private var _shouldPauseWhenLoadingMovie:Boolean = false;
      
      private var showingAdsVideo:Boolean = false;
      
      private var params:Object;
      
      private var _1155998129createYourOwnWidth:Number;
      
      private var _1909198402createYourOwnHeight:Number;
      
      private var _420974171_screen_height:Number = 354;
      
      private var is_golite_preview:int;
      
      private var _screenMode:int = -1;
      
      private var _hideControlBarTimeoutId:uint = 0;
      
      private var _isPreview:Boolean = false;
      
      private var _shouldInitSharingPanel:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function PreviewPlayer()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "creationComplete":"___PreviewPlayer_Canvas1_creationComplete",
               "mouseMove":"___PreviewPlayer_Canvas1_mouseMove",
               "resize":"___PreviewPlayer_Canvas1_resize"
            },
            "stylesFactory":function():void
            {
               this.backgroundColor = 0;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"screenContainer",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"scaleContainer",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "verticalCenter":0,
                                 "horizontalCenter":0,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"contentContainer",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":550,
                                          "height":354,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"movieStage",
                                             "stylesFactory":function():void
                                             {
                                                this.backgroundColor = 16777215;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":1000,
                                                   "height":500
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":PlayerWatermark,
                                             "id":"watermark",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "verticalScrollPolicy":"off",
                                                   "horizontalScrollPolicy":"off"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"buffering",
                                             "stylesFactory":function():void
                                             {
                                                this.backgroundColor = 0;
                                                this.backgroundAlpha = 0.5;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "percentHeight":100,
                                                   "visible":false,
                                                   "includeInLayout":false,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"bufferingClock",
                                                            "percentWidth":100,
                                                            "percentHeight":100
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"loadingScreen",
                                             "stylesFactory":function():void
                                             {
                                                this.backgroundColor = 2105376;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":550,
                                                   "height":384,
                                                   "verticalCenter":15,
                                                   "verticalScrollPolicy":"off",
                                                   "horizontalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"progressBar",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "x":170,
                                                            "y":180,
                                                            "width":220,
                                                            "height":10,
                                                            "visible":false
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"createYourOwn",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"createYourOwn",
                                                            "y":280,
                                                            "visible":false
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"loading",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"loading",
                                                            "y":200,
                                                            "visible":false
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Text,
                                                      "id":"txtLicenserDisclaimer",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "x":38,
                                                            "y":214,
                                                            "styleName":"txtLicenserDisclaimer",
                                                            "text":"",
                                                            "width":469
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":UIComponent,
                                             "id":"mochiContainer"
                                          }),new UIComponentDescriptor({
                                             "type":PlayerEndScreen,
                                             "id":"endScreen",
                                             "events":{
                                                "btn_replay_click":"__endScreen_btn_replay_click",
                                                "credit_screen_times_up":"__endScreen_credit_screen_times_up"
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "verticalCenter":0,
                                                   "horizontalCenter":0,
                                                   "visible":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"alertText",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "center";
                                                this.fontSize = 14;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":14.5,
                                                   "y":126,
                                                   "width":521,
                                                   "height":228,
                                                   "enabled":false,
                                                   "mouseEnabled":false,
                                                   "text":""
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":timeFrameSynchronizer,
                                             "id":"timeFrameSynchronizer",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":249,
                                                   "y":0,
                                                   "visible":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":PlayerDebugPanel,
                                             "id":"debugPanel"
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":PlayerControl,
                  "id":"playerControl",
                  "events":{
                     "onPlayButClicked":"__playerControl_onPlayButClicked",
                     "onPauseButClicked":"__playerControl_onPauseButClicked",
                     "onTimeLineDrag":"__playerControl_onTimeLineDrag",
                     "onTimeLinePress":"__playerControl_onTimeLinePress",
                     "onTimeLineRelease":"__playerControl_onTimeLineRelease",
                     "volume_change":"__playerControl_volume_change"
                  },
                  "stylesFactory":function():void
                  {
                     this.cornerRadius = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"bottom":0};
                  }
               }),new UIComponentDescriptor({
                  "type":Box,
                  "id":"curtainBox",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"visible":false};
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"loadingText",
                  "stylesFactory":function():void
                  {
                     this.color = 16777215;
                     this.textAlign = "center";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"loadingText",
                        "text":"loading...",
                        "visible":false,
                        "horizontalCenter":0,
                        "y":350
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"googleAdsAttribution",
                  "stylesFactory":function():void
                  {
                     this.color = 16777215;
                     this.textAlign = "right";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"loadingText",
                        "text":"Ads By Google",
                        "visible":false,
                        "x":300,
                        "y":16
                     };
                  }
               })]};
            }
         });
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_NULL;
         this._subComponents = new Array();
         this._1155998129createYourOwnWidth = FlexGlobals.topLevelApplication.width;
         this._1909198402createYourOwnHeight = FlexGlobals.topLevelApplication.height;
         this.is_golite_preview = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_GOLITE_PREVIEW);
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._PreviewPlayer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_playerComponent_PreviewPlayerWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return PreviewPlayer[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._PreviewPlayer_Move1_i();
         this.addEventListener("creationComplete",this.___PreviewPlayer_Canvas1_creationComplete);
         this.addEventListener("mouseMove",this.___PreviewPlayer_Canvas1_mouseMove);
         this.addEventListener("resize",this.___PreviewPlayer_Canvas1_resize);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         PreviewPlayer._watcherSetupUtil = param1;
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
            this.backgroundColor = 0;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get screen_height() : Number
      {
         return this._screen_height;
      }
      
      public function getParams() : Object
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this.params = {};
         var _loc1_:String = ExternalInterface.call("window.location.search.substring",1);
         if(_loc1_)
         {
            _loc2_ = _loc1_.split("&");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if((_loc4_ = _loc2_[_loc3_].indexOf("=")) != -1)
               {
                  _loc5_ = _loc2_[_loc3_].substring(0,_loc4_);
                  _loc6_ = _loc2_[_loc3_].substring(_loc4_ + 1);
                  this.params[_loc5_] = _loc6_;
               }
               _loc3_++;
            }
         }
         return this.params;
      }
      
      public function getMovieDuration() : Number
      {
         return this.plainPlayer.getDuration();
      }
      
      public function loadScenePreview(param1:Number) : void
      {
         var movieBuffer:Number = NaN;
         var num:Number = param1;
         this.previewSceneNum = num;
         movieBuffer = 2;
         var myTimer:Timer = new Timer(900,1);
         this.playerControl.playPauseBut.enabled = false;
         myTimer.addEventListener("timer",function():void
         {
            playerControl.scenePreview(previewSceneNum + movieBuffer);
            setVolumeInPlainPlayer(0.5);
         });
         myTimer.start();
         this.setVolumeInPlainPlayer(0);
      }
      
      public function turnOnPauseFirstStart(param1:Number) : void
      {
         this.plainPlayer.isScenePreview(param1);
      }
      
      private function curtaining() : void
      {
         var _loc1_:String = Util.getFlashVar().getValueByKey("playcount") as String;
         var _loc2_:String = Util.getFlashVar().getValueByKey("duration") as String;
         if(_loc1_ && Number(_loc2_) > 59)
         {
         }
      }
      
      public function adSenseComplete(param1:Event) : void
      {
         param1.target.removeEventListener("ADS_COMPELTED",this.adSenseComplete);
         this.removeChild(this.curtainBox);
         this.removeChild(this.loadingText);
         this.removeChild(this.googleAdsAttribution);
         this.plainPlayer.adCompleted();
      }
      
      public function adSenseStarted(param1:Event) : void
      {
         param1.target.removeEventListener("ADS_FINISH_LOADING",this.adSenseStarted);
         this.loadingText.text = "Your video is loading, and this ad will close automatically.";
      }
      
      private function get isMochiAdShown() : Boolean
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE);
         var _loc3_:String = _loc1_.getValueByKey(ServerConstants.PARAM_ISEMBED_ID);
         var _loc4_:String = _loc1_.getValueByKey("ad");
         var _loc5_:Boolean = true;
         return false;
      }
      
      private function loadMovieInfoXML() : void
      {
         try
         {
            if(this.plainPlayer != null && this._flashVars != null)
            {
               this.movieInfoLoader = new UtilMovieInfoXMLLoader();
               this.movieInfoLoader.load(UtilNetwork.getGetMovieInfoRequest(this._flashVars.getValueByKey(ServerConstants.PARAM_MOVIE_ID)));
               this.movieInfoLoader.addEventListener(UtilMovieInfoXMLLoader.LOAD_COMPLETE,this.onLoadInfoCompleted);
            }
         }
         catch(ex:Error)
         {
         }
      }
      
      private function onLoadInfoCompleted(param1:Event) : void
      {
         var _loc2_:XML = null;
         this.plainPlayer.movieInfo = this.movieInfoLoader.info;
         if(this.movieInfoLoader.info is XML)
         {
            _loc2_ = this.movieInfoLoader.info as XML;
            if(_loc2_.hasOwnProperty("watermark"))
            {
               if(_loc2_.watermark != "")
               {
                  this.watermark.loadCustomLogoByUrl(_loc2_.watermark);
               }
            }
            else
            {
               this.watermark.loadDefaultLogo();
            }
         }
      }
      
      private function onCreationCompleted(... rest) : void
      {
         var _loc6_:UtilLoadMgr = null;
         Util.initLog();
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_NULL;
         this.addComponents();
         var _loc2_:Number = AnimeConstants.SCREEN_Y + (AnimeConstants.SCREEN_HEIGHT - this._screen_height) / 2;
         this.movieStage.scrollRect = new Rectangle(AnimeConstants.SCREEN_X,_loc2_,AnimeConstants.SCREEN_WIDTH,this._screen_height);
         this.plainPlayer = new PlainPlayer();
         this.debugPanel.plainPlayer = this.plainPlayer;
         this.plainPlayer.addEventListener(PlayerEvent.REAL_START_PLAY,this.doEnableTimelineRelatedStuff,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doRemoveLoadingScreen);
         this.plainPlayer.addEventListener(PlayerEvent.MOVIE_STRUCTURE_READY,this.onMovieStructureReady,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.BUFFER_EXHAUST,this.onBufferExhaust,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.BUFFER_READY,this.onBufferReady,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.onMovieTimeChange,false,0,true);
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_MOVIE_END,this.onMovieEnd,false,0,true);
         if(Util.isVideoRecording())
         {
            (_loc6_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doTellVideoRecordingSoftwareMovieStart);
            _loc6_.addEventDispatcher(this.plainPlayer.eventDispatcher,PlayerEvent.BUFFER_READY_WHEN_MOVIE_START);
            _loc6_.addEventDispatcher(this.plainPlayer.eventDispatcher,PlayerEvent.PLAYHEAD_TIME_CHANGE);
            _loc6_.commit();
         }
         this.loadMovieInfoXML();
         var _loc3_:DisplayObjectContainer = this.plainPlayer.getMovieContainer();
         var _loc4_:UIComponent;
         (_loc4_ = new UIComponent()).addChild(_loc3_);
         this.movieStage.addChild(_loc4_);
         var _loc5_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc5_);
         if(_loc5_["movieOwner"] != "")
         {
            this._owner = _loc5_["movieOwner"];
         }
         if(this.previewMode)
         {
            this.startPreview();
         }
         this._ad = new MochiAdDisplay();
         this.mochiContainer.addChild(this._ad.movieClip);
         this.progressBar.graphics.lineStyle(1,6710886);
         this.progressBar.graphics.beginFill(16777215,0);
         this.progressBar.graphics.drawRect(0,0,220,10);
         this.progressBar.graphics.endFill();
         this.endScreen.addEventListener("btn_nextmovie_click",this.onNextMovieClick);
         this._isInited = true;
         FlexGlobals.topLevelApplication.addEventListener(FullScreenEvent.FULL_SCREEN,this.fullScreenHandler);
         this.screenMode = NORMAL_SCREEN_MODE;
      }
      
      private function initWatermark() : void
      {
         var _loc1_:Object = null;
         if(this._imageData)
         {
            _loc1_ = this._imageData.getValueByKey("watermarkUrl");
            if(_loc1_ is String)
            {
               if(_loc1_ == "default")
               {
                  this.watermark.loadDefaultLogo();
               }
               else if(_loc1_ != "")
               {
                  this.watermark.loadCustomLogoByUrl(_loc1_ as String);
               }
            }
         }
      }
      
      private function onSceneBuffering(param1:ProgressEvent) : void
      {
         if(param1.bytesTotal && param1.bytesTotal != 0)
         {
            this.playerControl.timerDisplay.text = UtilDict.toDisplay("player","buffering") + " " + String(Math.floor(100 * param1.bytesLoaded / param1.bytesTotal)) + "%";
         }
      }
      
      private function fullScreenHandler(param1:FullScreenEvent) : void
      {
         var _loc2_:UtilHashArray = null;
         var _loc3_:String = null;
         try
         {
            if(param1.fullScreen)
            {
               this.screenMode = FULL_SCREEN_MODE;
            }
            else
            {
               _loc2_ = Util.getFlashVar();
               _loc3_ = _loc2_.getValueByKey(ServerConstants.PARAM_ISEMBED_ID);
               if(_loc3_ == "1")
               {
                  this.screenMode = PreviewPlayer.FULL_SCREEN_MODE;
               }
               else
               {
                  this.screenMode = NORMAL_SCREEN_MODE;
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onMovieStructureReady(param1:PlayerEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onMovieStructureReady);
         this.playerControl.init(this.plainPlayer.getDuration());
         this.playerControl.timerDisplay.text = UtilDict.toDisplay("player","player_initializing");
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doEnableTimelineRelatedStuff);
         if(this._shouldPauseWhenLoadingMovie)
         {
            this.doRemoveLoadingScreen();
         }
         this.endScreen.movieDuration = UtilUnitConvert.frameToSec(this.plainPlayer.getDuration());
         this.endScreen.resetUI();
         this.initUI();
      }
      
      private function initUI() : void
      {
      }
      
      private function doEnableTimelineRelatedStuff(param1:Event) : void
      {
         this.plainPlayer.removeEventListener(PlayerEvent.REAL_START_PLAY,this.doEnableTimelineRelatedStuff);
         this.removeEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doEnableTimelineRelatedStuff);
         this.playerControl.enableTimeLine();
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         if(_loc2_[ServerConstants.PARAM_ISSLIDE] == "1")
         {
            this.playerControl.enableTimeLine(false);
            this.playerControl.timeLine.liveDragging = false;
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.BUFFER_READY_WHEN_MOVIE_START));
      }
      
      private function doRemoveLoadingScreen(param1:Event = null) : void
      {
         if(param1)
         {
            IEventDispatcher(param1.target).removeEventListener(param1.type,this.doRemoveLoadingScreen);
         }
         this.plainPlayer.removeEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doRemoveLoadingScreen);
         this.removeEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doRemoveLoadingScreen);
         this.removeEventListener(PlayerEvent.PLAYHEAD_USER_PAUSE,this.doTriggerPauseWhenMovieLoad);
         this.removeEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.doNotTriggerPauseWhenMovieLoad);
         this.loadingScreen.visible = false;
         if(this.contentContainer.contains(this.loadingScreen))
         {
            this.contentContainer.removeChild(this.loadingScreen);
         }
         this.playerControl.timerDisplay.text = "";
         this.dispatchEvent(new Event("info_load_complete"));
      }
      
      private function onMovieTimeChange(param1:PlayerEvent) : void
      {
         this.playerControl.timeChangeListener(this.plainPlayer.currentFrame);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_TIME_CHANGE));
      }
      
      private function doTriggerPauseWhenMovieLoad(param1:Event) : void
      {
         if(this.plainPlayer.loadingState == PlainPlayer.MOVIE_ZIP_LOADED)
         {
            this.doRemoveLoadingScreen();
         }
         this._shouldPauseWhenLoadingMovie = true;
      }
      
      private function doNotTriggerPauseWhenMovieLoad(param1:Event) : void
      {
         this._shouldPauseWhenLoadingMovie = false;
      }
      
      public function initAndPreview(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         this._filmXML = param1;
         this._imageData = param2;
         this._themeXMLs = param3;
         this.previewMode = true;
         if(this._filmXML.@isWide.length() > 0 && this._filmXML.@isWide == "1")
         {
            this.switchToWideScreen();
         }
         else
         {
            this.switchToNormalScreen();
         }
         this.initWatermark();
      }
      
      public function init(param1:URLRequest, param2:Array, param3:UtilHashArray) : void
      {
         this._urlRequest = param1;
         this._urlRequestArray = param2;
         this._flashVars = param3;
         this.loadMovieInfoXML();
      }
      
      private function onTimeLineDrag(... rest) : void
      {
         this.pausePlainPlayer(false,true,true);
         this.timeFrameSynchronizer.stopSyn();
         this.goToAndPausePlainPlayer(false,true,true,this.playerControl.getCurFrame(),true);
      }
      
      private function onTimeLinePress(... rest) : void
      {
         this.timeFrameSynchronizer.stopSyn();
         this.pausePlainPlayer(false,true,true);
      }
      
      private function onTimeLineRelease(... rest) : void
      {
         this.timeFrameSynchronizer.startSyn();
         if(this._expectedPlayHeadState == PreviewPlayer.PLAYHEAD_STATE_PLAY)
         {
            this.resumePlainPlayer(false,true,true);
         }
         else if(this._expectedPlayHeadState == PLAYHEAD_STATE_MOVIE_END)
         {
            this._expectedPlayHeadState = PLAYHEAD_STATE_PAUSE;
         }
      }
      
      private function onPauseButClick() : void
      {
         this.pausePlainPlayer(false,true,true);
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PAUSE;
      }
      
      private function startPreview() : void
      {
         this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doStartTimeFrameSynchronized);
         this.plainPlayer.initAndPreview(this._filmXML,this._themeXMLs,this._imageData);
         this.playerControl.playListener();
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
         this.playerControl.enableTimeLine(true);
         this.playerControl.timeLine.liveDragging = true;
         this.firstStart = false;
      }
      
      private function doStartTimeFrameSynchronized(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doStartTimeFrameSynchronized);
         this.timeFrameSynchronizer.startSyn();
      }
      
      private function doTellVideoRecordingSoftwareMovieStart(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doTellVideoRecordingSoftwareMovieStart);
         navigateToURL(new URLRequest("FSCommand:start"));
      }
      
      public function destroy() : void
      {
         if(!this._isInited)
         {
            return;
         }
         try
         {
            if(this.plainPlayer != null)
            {
               this.plainPlayer.destroy();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function destroyMC() : void
      {
         if(!this._isInited)
         {
            return;
         }
         try
         {
            if(this.plainPlayer != null)
            {
               this.plainPlayer.destroyAllScene();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function startPlay() : void
      {
         var playFunc:Function = null;
         var showBranding:Boolean = true;
         if(this._flashVars && this._flashVars.getValueByKey("pwm") == "0")
         {
            showBranding = false;
         }
         var image:Image = new Image();
         var loadingCSSClassDec:CSSStyleDeclaration = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".myloading");
         var MyImageClass:Class = loadingCSSClassDec.getStyle("mybg") as Class;
         image.source = MyImageClass;
         image.name = LOADING_ICON_NAME;
         if(showBranding)
         {
            this.loadingScreen.addChildAt(image,0);
         }
         this.loading.visible = true;
         if(showBranding)
         {
            this.createYourOwn.visible = true;
         }
         var ptext:Text = new Text();
         ptext.name = "ppText";
         ptext.x = 74;
         ptext.y = 258;
         ptext.width = 407;
         ptext.height = 45;
         ptext.selectable = false;
         ptext.setStyle("textAlign","center");
         ptext.setStyle("fontSize","12");
         ptext.setStyle("color","#555555");
         var domain:String = UtilDict.toDisplay("player","sharing_website_displayname");
         if(this._owner != "" && this._owner != "null" && this._owner != null)
         {
            ptext.text = StringUtil.substitute(UtilDict.toDisplay("player","{0} created this video on {1}"),this._owner,domain);
         }
         else
         {
            ptext.text = StringUtil.substitute(UtilDict.toDisplay("player","This video is created on {0}"),domain);
         }
         if(showBranding)
         {
            this.loadingScreen.addChild(ptext);
         }
         this.progressBar.visible = true;
         this.timeFrameSynchronizer.stopSyn();
         if(this.plainPlayer)
         {
            if(this.is_golite_preview != 1)
            {
               this.plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_TIME_CHANGE,this.doStartTimeFrameSynchronized);
            }
            this.plainPlayer.addEventListener(PlayerEvent.ERROR_LOADING_MOVIE,this.onErrorLoadingMovie,false,0,true);
            this.plainPlayer.addEventListener(PlayerEvent.LOAD_MOVIE_PROGRESS,this.onMovieProgress,false,0,true);
         }
         ProgressMonitor.getInstance().addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         var initFunc:Function = function():void
         {
            if(plainPlayer)
            {
               plainPlayer.initMovie(_urlRequest,_urlRequestArray,_flashVars);
               playerControl.playListener();
               if(showingAdsVideo == false)
               {
                  plainPlayer.adCompleted();
               }
            }
         };
         if(this.movieInfoLoader && this.movieInfoLoader.loading)
         {
            playFunc = function(param1:Event):void
            {
               movieInfoLoader.removeEventListener(UtilMovieInfoXMLLoader.LOAD_COMPLETE,playFunc);
               initFunc();
            };
            this.movieInfoLoader.addEventListener(UtilMovieInfoXMLLoader.LOAD_COMPLETE,playFunc);
         }
         else
         {
            initFunc();
         }
      }
      
      private function onErrorLoadingMovie(param1:PlayerEvent) : void
      {
         var _loc2_:String = param1.getData() as String;
         if(_loc2_ == ServerConstants.ERROR_CODE_MOVIE_NOT_FOUND)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_errnotfound");
         }
         else if(_loc2_ == ServerConstants.ERROR_CODE_MOVIE_DELETED)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_errdeleted");
         }
         else if(_loc2_ == ServerConstants.ERROR_CODE_MOVIE_NOT_SHARE)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_errprivated");
         }
         else if(_loc2_ == ServerConstants.ERROR_CODE_MOVIE_MODERATING)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_errprocess");
         }
         else if(_loc2_ == ServerConstants.ERROR_CODE_NO_ACCESS)
         {
            this.alertText.text = UtilDict.toDisplay("player","player_err_noaccess");
         }
         else
         {
            this.alertText.text = UtilDict.toDisplay("player","player_err_miscellaneous");
         }
         this.alertText.enabled = true;
         if(this.contains(this.loadingScreen))
         {
            this.removeChild(this.loadingScreen);
            currentState = "";
         }
      }
      
      private function onMovieProgress(param1:PlayerEvent) : void
      {
         var _loc2_:ProgressEvent = ProgressEvent(param1.getData());
         var _loc3_:Number = Math.round(_loc2_.bytesLoaded / _loc2_.bytesTotal * 100);
         var _loc4_:PlayerEvent = new PlayerEvent(PlayerEvent.LOAD_MOVIE_PROGRESS);
         this.dispatchEvent(_loc4_);
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         this.progressBar.graphics.beginFill(16742144);
         this.progressBar.graphics.lineStyle(1,16742144);
         var _loc2_:Number = UtilMath.boundaryCheck(param1.bytesLoaded / param1.bytesTotal,0,1);
         this.progressBar.graphics.drawRect(2,2,216 * _loc2_,6);
         this.progressBar.graphics.endFill();
      }
      
      private function onPlayButClick() : void
      {
         if(this._expectedPlayHeadState == PLAYHEAD_STATE_MOVIE_END)
         {
            this.replay();
         }
         else
         {
            this.play();
         }
      }
      
      private function startPlainPlayer() : void
      {
         if(this.previewMode)
         {
            this.startPreview();
         }
         else
         {
            this.startPlay();
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_USER_START_PLAY));
      }
      
      private function pausePlainPlayer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean = true) : void
      {
         if(param3)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_USER_PAUSE));
         }
         if(param2)
         {
            this.plainPlayer.pauseMovie(param4);
         }
         if(param1)
         {
            this.playerControl.pauseListener();
         }
      }
      
      private function resumePlainPlayer(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(param3)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_USER_RESUME));
         }
         if(param2)
         {
            this.plainPlayer.playMovie();
         }
         if(param1)
         {
            this.playerControl.playListener();
         }
      }
      
      private function goToAndPausePlainPlayer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Number, param5:Boolean = false) : void
      {
         if(param3)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_USER_GOTOANDPAUSE));
         }
         if(param2)
         {
            this.plainPlayer.goToAndPauseMovie(param4,param5);
         }
         if(param1)
         {
            this.playerControl.timeChangeListener(param4);
         }
      }
      
      private function setVolumeInPlainPlayer(param1:Number) : void
      {
         this.plainPlayer.setVolume(param1);
      }
      
      public function resume() : void
      {
         this.resumePlainPlayer(true,true,true);
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
      }
      
      public function pause(param1:Boolean = true, param2:Boolean = false) : void
      {
         if(param2)
         {
            this.plainPlayer.onRemoveEnterFrame();
         }
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PAUSE;
         this.pausePlainPlayer(true,true,true,param1);
      }
      
      public function play(param1:Boolean = false) : void
      {
         if(this.previewSceneFirstStart == false)
         {
            this.timeFrameSynchronizer.startSyn();
         }
         this.previewSceneFirstStart = false;
         if(param1)
         {
            this.plainPlayer.onAddEnterFrame();
         }
         if(this.firstStart)
         {
            this.hideEndScreen();
            this.startPlainPlayer();
         }
         else
         {
            this.resumePlainPlayer(true,true,true);
         }
         this.firstStart = false;
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
      }
      
      public function replay() : void
      {
         this.timeFrameSynchronizer.startSyn();
         this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PLAY;
         this.pausePlainPlayer(true,true,true);
         this.plainPlayer.goToAndPauseResetMovie();
         this.goToAndPausePlainPlayer(true,true,true,1);
         this.resumePlainPlayer(true,true,true);
      }
      
      private function showEndScreen(param1:Object = null, param2:Boolean = true) : void
      {
         var _loc3_:Fade = null;
         this.endScreen.visible = true;
         this.playerControl.fullScreenControl.fullBut.enableBut1(false);
         if(param2)
         {
            _loc3_ = new Fade();
            _loc3_.target = this.endScreen;
            _loc3_.alphaFrom = 0;
            _loc3_.alphaTo = 1;
            _loc3_.duration = 1000;
            _loc3_.easingFunction = Exponential.easeIn;
            _loc3_.play();
         }
      }
      
      private function hideEndScreen(... rest) : void
      {
         this.endScreen.visible = false;
         this.playerControl.fullScreenControl.fullBut.enableBut1(true);
      }
      
      public function set subComponents(param1:Array) : void
      {
         this._subComponents = param1;
      }
      
      public function get subComponents() : Array
      {
         return this._subComponents;
      }
      
      private function addComponents() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._subComponents.length)
         {
            this.addChild(this._subComponents[_loc1_]);
            _loc1_++;
         }
      }
      
      private function onVolumeChange(param1:PlayerEvent) : void
      {
         var _loc2_:Number = param1.getData() as Number;
         SoundMixer.soundTransform = new SoundTransform(_loc2_);
      }
      
      private function onBufferExhaust(param1:PlayerEvent) : void
      {
         this.playerControl.timerDisplay.text = UtilDict.toDisplay("player","buffering") + "...";
         SceneBufferManager.instance.addEventListener(ProgressEvent.PROGRESS,this.onSceneBuffering);
         if(!this.loadingScreen.visible)
         {
            this.buffering.visible = this.buffering.includeInLayout = true;
         }
         this.pausePlainPlayer(false,true,false);
      }
      
      private function onBufferReady(param1:PlayerEvent) : void
      {
         this.playerControl.timerDisplay.text = "";
         SceneBufferManager.instance.removeEventListener(ProgressEvent.PROGRESS,this.onSceneBuffering);
         this.buffering.visible = this.buffering.includeInLayout = false;
         if(this._expectedPlayHeadState == PLAYHEAD_STATE_PLAY)
         {
            this.resumePlainPlayer(false,true,false);
         }
      }
      
      private function onMovieEnd(param1:PlayerEvent) : void
      {
         this.pause();
         this._expectedPlayHeadState = PLAYHEAD_STATE_MOVIE_END;
         if(this.plainPlayer.licensedSoundInfo != "")
         {
            this.endScreen.showCreditScreen(this.plainPlayer.licensedSoundInfo);
         }
         else if(Util.isVideoRecording())
         {
            navigateToURL(new URLRequest("FSCommand:stop"));
         }
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_GOTOANDPAUSE,this.hideEndScreen,false,0,true);
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_PAUSE,this.hideEndScreen,false,0,true);
         this.addEventListener(PlayerEvent.PLAYHEAD_USER_RESUME,this.hideEndScreen,false,0,true);
         this.timeFrameSynchronizer.stopSyn();
         if(!Util.isVideoRecording())
         {
            this.showEndScreen();
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAYHEAD_MOVIE_END));
      }
      
      private function onCreditScreenTimesUp(param1:Event) : void
      {
         if(Util.isVideoRecording())
         {
            navigateToURL(new URLRequest("FSCommand:stop"));
         }
      }
      
      private function onReplayButtonClick(param1:Event) : void
      {
         if(this.previewSceneNum > 0)
         {
            this.loadScenePreview(this.previewSceneNum);
            this._expectedPlayHeadState = PreviewPlayer.PLAYHEAD_STATE_PAUSE;
         }
         else if(this.firstStart)
         {
            this.play();
         }
         else
         {
            this.replay();
         }
      }
      
      private function onNextMovieClick(param1:Event) : void
      {
         var _loc2_:PlayerEvent = new PlayerEvent(PlayerEvent.NEXTMOVIE);
         this.dispatchEvent(_loc2_);
      }
      
      public function showSharingPanel(param1:Boolean = true) : void
      {
         if(this.firstStart)
         {
            this.showEndScreen(null,param1);
         }
         else
         {
            this.plainPlayer.endMovie();
         }
      }
      
      public function turnOnLogo(param1:Boolean) : void
      {
         this.watermark.turnOnLogo(param1);
      }
      
      public function setDisclaimer(param1:String) : void
      {
         this.txtLicenserDisclaimer.text = param1;
      }
      
      private function onMouseMove() : void
      {
         if(this._screenMode == FULL_SCREEN_MODE)
         {
            clearTimeout(this._hideControlBarTimeoutId);
            this.playerControl.bottom = 0;
            this._hideControlBarTimeoutId = setTimeout(this.hideControlBar,2000);
         }
      }
      
      private function hideControlBar() : void
      {
         this.playerControl.bottom = -30;
      }
      
      private function onEndScreenReady() : void
      {
      }
      
      private function onEndScreenCreationComplete(param1:Event) : void
      {
      }
      
      private function initEndScreen() : void
      {
      }
      
      public function set isPreviewMode(param1:Boolean) : void
      {
         if(param1 != this._isPreview)
         {
            this._isPreview = param1;
            if(param1)
            {
               this.endScreen.isPreviewMode = true;
            }
         }
      }
      
      public function set shouldInitSharingPanel(param1:Boolean) : void
      {
         if(param1 != this._shouldInitSharingPanel)
         {
            this._shouldInitSharingPanel = param1;
            if(param1)
            {
               this.endScreen._sharingPanel.init();
            }
         }
      }
      
      public function switchToWideScreen() : void
      {
         this._screen_height = AnimeConstants.WIDE_SCREEN_HEIGHT;
         this.contentContainer.height = AnimeConstants.WIDE_SCREEN_HEIGHT;
         var _loc1_:Number = AnimeConstants.SCREEN_Y + (AnimeConstants.SCREEN_HEIGHT - this._screen_height) / 2;
         this.movieStage.scrollRect = new Rectangle(AnimeConstants.SCREEN_X,_loc1_,AnimeConstants.SCREEN_WIDTH,this._screen_height);
         this.resizeScaleContainer();
      }
      
      public function switchToNormalScreen() : void
      {
         this._screen_height = AnimeConstants.SCREEN_HEIGHT;
         this.contentContainer.height = AnimeConstants.SCREEN_HEIGHT;
         this.movieStage.scrollRect = new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this.resizeScaleContainer();
      }
      
      protected function onResize(param1:ResizeEvent) : void
      {
         var _loc2_:Number = this.height;
         if(this._screenMode == NORMAL_SCREEN_MODE)
         {
            _loc2_ = this.height - 30;
         }
         this.screenContainer.height = _loc2_;
         this.resizeScaleContainer();
      }
      
      private function resizeScaleContainer() : void
      {
         var _loc1_:Number = this.width + 1;
         var _loc2_:Number = this.height + 1;
         if(this._screenMode == NORMAL_SCREEN_MODE)
         {
            _loc2_ -= this.playerControl.height;
         }
         var _loc3_:Number = Math.min(_loc1_ / this.contentContainer.width,_loc2_ / this.contentContainer.height);
         this.scaleContainer.scaleX = this.scaleContainer.scaleY = _loc3_;
         if(this._screenMode == RECORDING_SCREEN_MODE && this._screen_height == AnimeConstants.WIDE_SCREEN_HEIGHT)
         {
            this.scaleContainer.scaleX = _loc1_ / this.contentContainer.width;
            this.scaleContainer.scaleY = _loc2_ / this.contentContainer.height;
         }
         if(this.width < 550)
         {
            this.playerControl.scaleX = this.playerControl.scaleY = _loc3_;
         }
         else
         {
            this.playerControl.scaleX = this.playerControl.scaleY = 1;
         }
      }
      
      public function set screenMode(param1:int) : void
      {
         if(param1 != this._screenMode)
         {
            this._screenMode = param1;
            switch(param1)
            {
               case NORMAL_SCREEN_MODE:
                  this.screenContainer.height = this.height - 30;
                  this.resizeScaleContainer();
                  clearTimeout(this._hideControlBarTimeoutId);
                  this.playerControl.bottom = 0;
                  this.playerControl.visible = true;
                  break;
               case FULL_SCREEN_MODE:
                  this.screenContainer.percentHeight = 100;
                  this.resizeScaleContainer();
                  clearTimeout(this._hideControlBarTimeoutId);
                  this.playerControl.bottom = 0;
                  this.playerControl.visible = true;
                  this._hideControlBarTimeoutId = setTimeout(this.hideControlBar,2000);
                  break;
               case RECORDING_SCREEN_MODE:
                  this.screenContainer.percentHeight = 100;
                  this.resizeScaleContainer();
                  this.playerControl.visible = false;
            }
         }
      }
      
      private function _PreviewPlayer_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         _loc1_.duration = 500;
         this.moveEffect = _loc1_;
         BindingManager.executeBindings(this,"moveEffect",this.moveEffect);
         return _loc1_;
      }
      
      public function ___PreviewPlayer_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationCompleted();
         this.curtaining();
      }
      
      public function ___PreviewPlayer_Canvas1_mouseMove(param1:MouseEvent) : void
      {
         this.onMouseMove();
      }
      
      public function ___PreviewPlayer_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.onResize(param1);
      }
      
      public function __endScreen_btn_replay_click(param1:PlayerEndScreenEvent) : void
      {
         this.onReplayButtonClick(param1);
      }
      
      public function __endScreen_credit_screen_times_up(param1:PlayerEndScreenEvent) : void
      {
         this.onCreditScreenTimesUp(param1);
      }
      
      public function __playerControl_onPlayButClicked(param1:Event) : void
      {
         this.onPlayButClick();
      }
      
      public function __playerControl_onPauseButClicked(param1:Event) : void
      {
         this.onPauseButClick();
      }
      
      public function __playerControl_onTimeLineDrag(param1:Event) : void
      {
         this.onTimeLineDrag(param1);
      }
      
      public function __playerControl_onTimeLinePress(param1:Event) : void
      {
         this.onTimeLinePress(param1);
      }
      
      public function __playerControl_onTimeLineRelease(param1:Event) : void
      {
         this.onTimeLineRelease(param1);
      }
      
      public function __playerControl_volume_change(param1:PlayerEvent) : void
      {
         this.onVolumeChange(param1);
      }
      
      private function _PreviewPlayer_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Create Amazing Videos Easily!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"createYourOwn.text");
         result[1] = new Binding(this,function():Number
         {
            return (loadingScreen.width - createYourOwn.width) / 2;
         },null,"createYourOwn.x");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Loading Video...");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"loading.text");
         result[3] = new Binding(this,function():Number
         {
            return (loadingScreen.width - loading.width) / 2;
         },null,"loading.x");
         result[4] = new Binding(this,function():Boolean
         {
            return PlayerDebugManager.debugMode;
         },null,"debugPanel.visible");
         result[5] = new Binding(this,function():Boolean
         {
            return PlayerDebugManager.debugMode;
         },null,"debugPanel.includeInLayout");
         result[6] = new Binding(this,function():Number
         {
            return createYourOwnWidth;
         },null,"curtainBox.width");
         result[7] = new Binding(this,function():Number
         {
            return createYourOwnHeight;
         },null,"curtainBox.height");
         result[8] = new Binding(this,function():Number
         {
            return createYourOwnWidth;
         },null,"loadingText.width");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get alertText() : Text
      {
         return this._1462422359alertText;
      }
      
      public function set alertText(param1:Text) : void
      {
         var _loc2_:Object = this._1462422359alertText;
         if(_loc2_ !== param1)
         {
            this._1462422359alertText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alertText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buffering() : Canvas
      {
         return this._61512610buffering;
      }
      
      public function set buffering(param1:Canvas) : void
      {
         var _loc2_:Object = this._61512610buffering;
         if(_loc2_ !== param1)
         {
            this._61512610buffering = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buffering",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get contentContainer() : Canvas
      {
         return this._1707945992contentContainer;
      }
      
      public function set contentContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1707945992contentContainer;
         if(_loc2_ !== param1)
         {
            this._1707945992contentContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"contentContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get createYourOwn() : Label
      {
         return this._1254676919createYourOwn;
      }
      
      public function set createYourOwn(param1:Label) : void
      {
         var _loc2_:Object = this._1254676919createYourOwn;
         if(_loc2_ !== param1)
         {
            this._1254676919createYourOwn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"createYourOwn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get curtainBox() : Box
      {
         return this._566693337curtainBox;
      }
      
      public function set curtainBox(param1:Box) : void
      {
         var _loc2_:Object = this._566693337curtainBox;
         if(_loc2_ !== param1)
         {
            this._566693337curtainBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"curtainBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get debugPanel() : PlayerDebugPanel
      {
         return this._1854636175debugPanel;
      }
      
      public function set debugPanel(param1:PlayerDebugPanel) : void
      {
         var _loc2_:Object = this._1854636175debugPanel;
         if(_loc2_ !== param1)
         {
            this._1854636175debugPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"debugPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endScreen() : PlayerEndScreen
      {
         return this._1593500967endScreen;
      }
      
      public function set endScreen(param1:PlayerEndScreen) : void
      {
         var _loc2_:Object = this._1593500967endScreen;
         if(_loc2_ !== param1)
         {
            this._1593500967endScreen = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endScreen",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get googleAdsAttribution() : Text
      {
         return this._168901560googleAdsAttribution;
      }
      
      public function set googleAdsAttribution(param1:Text) : void
      {
         var _loc2_:Object = this._168901560googleAdsAttribution;
         if(_loc2_ !== param1)
         {
            this._168901560googleAdsAttribution = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"googleAdsAttribution",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loading() : Label
      {
         return this._336650556loading;
      }
      
      public function set loading(param1:Label) : void
      {
         var _loc2_:Object = this._336650556loading;
         if(_loc2_ !== param1)
         {
            this._336650556loading = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loading",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loadingScreen() : Canvas
      {
         return this._459583688loadingScreen;
      }
      
      public function set loadingScreen(param1:Canvas) : void
      {
         var _loc2_:Object = this._459583688loadingScreen;
         if(_loc2_ !== param1)
         {
            this._459583688loadingScreen = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadingScreen",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get loadingText() : Text
      {
         return this._231891831loadingText;
      }
      
      public function set loadingText(param1:Text) : void
      {
         var _loc2_:Object = this._231891831loadingText;
         if(_loc2_ !== param1)
         {
            this._231891831loadingText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadingText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mochiContainer() : UIComponent
      {
         return this._1645408545mochiContainer;
      }
      
      public function set mochiContainer(param1:UIComponent) : void
      {
         var _loc2_:Object = this._1645408545mochiContainer;
         if(_loc2_ !== param1)
         {
            this._1645408545mochiContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mochiContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get moveEffect() : Move
      {
         return this._1994587966moveEffect;
      }
      
      public function set moveEffect(param1:Move) : void
      {
         var _loc2_:Object = this._1994587966moveEffect;
         if(_loc2_ !== param1)
         {
            this._1994587966moveEffect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"moveEffect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get movieStage() : Canvas
      {
         return this._1840541266movieStage;
      }
      
      public function set movieStage(param1:Canvas) : void
      {
         var _loc2_:Object = this._1840541266movieStage;
         if(_loc2_ !== param1)
         {
            this._1840541266movieStage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieStage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playerControl() : PlayerControl
      {
         return this._690449604playerControl;
      }
      
      public function set playerControl(param1:PlayerControl) : void
      {
         var _loc2_:Object = this._690449604playerControl;
         if(_loc2_ !== param1)
         {
            this._690449604playerControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerControl",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get progressBar() : Canvas
      {
         return this._1131509414progressBar;
      }
      
      public function set progressBar(param1:Canvas) : void
      {
         var _loc2_:Object = this._1131509414progressBar;
         if(_loc2_ !== param1)
         {
            this._1131509414progressBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"progressBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scaleContainer() : Canvas
      {
         return this._772093527scaleContainer;
      }
      
      public function set scaleContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._772093527scaleContainer;
         if(_loc2_ !== param1)
         {
            this._772093527scaleContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scaleContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get screenContainer() : Canvas
      {
         return this._176252277screenContainer;
      }
      
      public function set screenContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._176252277screenContainer;
         if(_loc2_ !== param1)
         {
            this._176252277screenContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"screenContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get timeFrameSynchronizer() : timeFrameSynchronizer
      {
         return this._1523976162timeFrameSynchronizer;
      }
      
      public function set timeFrameSynchronizer(param1:timeFrameSynchronizer) : void
      {
         var _loc2_:Object = this._1523976162timeFrameSynchronizer;
         if(_loc2_ !== param1)
         {
            this._1523976162timeFrameSynchronizer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"timeFrameSynchronizer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtLicenserDisclaimer() : Text
      {
         return this._1274894500txtLicenserDisclaimer;
      }
      
      public function set txtLicenserDisclaimer(param1:Text) : void
      {
         var _loc2_:Object = this._1274894500txtLicenserDisclaimer;
         if(_loc2_ !== param1)
         {
            this._1274894500txtLicenserDisclaimer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtLicenserDisclaimer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get watermark() : PlayerWatermark
      {
         return this._213424028watermark;
      }
      
      public function set watermark(param1:PlayerWatermark) : void
      {
         var _loc2_:Object = this._213424028watermark;
         if(_loc2_ !== param1)
         {
            this._213424028watermark = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"watermark",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get createYourOwnWidth() : Number
      {
         return this._1155998129createYourOwnWidth;
      }
      
      private function set createYourOwnWidth(param1:Number) : void
      {
         var _loc2_:Object = this._1155998129createYourOwnWidth;
         if(_loc2_ !== param1)
         {
            this._1155998129createYourOwnWidth = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"createYourOwnWidth",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get createYourOwnHeight() : Number
      {
         return this._1909198402createYourOwnHeight;
      }
      
      private function set createYourOwnHeight(param1:Number) : void
      {
         var _loc2_:Object = this._1909198402createYourOwnHeight;
         if(_loc2_ !== param1)
         {
            this._1909198402createYourOwnHeight = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"createYourOwnHeight",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _screen_height() : Number
      {
         return this._420974171_screen_height;
      }
      
      private function set _screen_height(param1:Number) : void
      {
         var _loc2_:Object = this._420974171_screen_height;
         if(_loc2_ !== param1)
         {
            this._420974171_screen_height = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_screen_height",_loc2_,param1));
            }
         }
      }
   }
}
