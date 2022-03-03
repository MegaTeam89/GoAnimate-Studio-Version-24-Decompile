package
{
   import anifire.banner.StudioLoadingScreen;
   import anifire.components.MyProgressBar;
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.MainStage;
   import anifire.components.studio.OverTray;
   import anifire.components.studio.ScreenCapTool;
   import anifire.components.studio.ThumbTray;
   import anifire.components.studio.TopButtonBar;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.timeline.Timeline;
   import anifire.tutorial.TutorialEvent;
   import anifire.tutorial.TutorialManager;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilUser;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.SharedObject;
   import flash.system.Security;
   import flash.utils.getDefinitionByName;
   import flexlib.containers.FlowBox;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.core.Application;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.styles.CSSStyleDeclaration;
   import template.templateApp.classes.Global;
   
   use namespace mx_internal;
   
   public class go_full extends Application implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2; //allowed domains
      
      {
         Security.allowDomain("staging-cdn.org","godevstorage.s3.amazonaws.com","*.amazonaws.com","*.s3.amazonaws.com","*.goanimate.org","*.goanimate.com","goanimate.com","demo.cdn.goanimate.com","demo.goanimate.com","es.goanimate.com","fr.goanimate.com","de.goanimate.com","br.goanimate.com","tooncreator.cartoonnetworkhq.com","prelaunch.tooncreator.cartoonnetworkhq.com","staging.goanimate.org","staging.goanimate.com","cn.goanimate.com","goanimate.cartoonnetworkhq.org","lightspeed.goanimate.com","staging.school.goanimate.org","*.goanimate4schools.com","goanimate4schools.com","lightspeed.goanimate4schools.com","staging-school-cdn.com","lightspeed.youtube.goanimate.com","youtube.goanimate.org","youtube.goanimate.com","demo.youtube.goanimate.com","demo.cdn.youtube.goanimate.com","skoletube.goanimate.org","skoletube.goanimate.com","lightspeed.edplatform.goanimate.com","edplatform.goanimate.com","edplatform.goanimate.org","sandbox.edplatform.goanimate.com","sandbox.edplatform.goanimate.org","sandbox.schoology.goanimate.com","schoology.goanimate4schools.com");
      }
      
      private var _1490827770_effectTray:EffectTray;
      
      private var _2061112671_extSwfContainer:Canvas;
      
      private var _1523657885_goWalker:TutorialManager;
      
      private var _1820782830_loadProgress:MyProgressBar;
      
      private var _1313433399_mainContainer:Canvas;
      
      private var _1751026874_mainStage:MainStage;
      
      private var _619629449_overTray:OverTray;
      
      private var _1149811839_screenCapTool:ScreenCapTool;
      
      private var _739375038_studioProgress:StudioLoadingScreen;
      
      private var _159139667_thumbTray:ThumbTray;
      
      private var _1986132576_timeline:Timeline;
      
      private var _1592971130_tipsLayer:Canvas;
      
      private var _427053173_topButtonBar:TopButtonBar;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var _console:Console;
      
      private var _bFluidLayout:Boolean = true;
      
      private var fb:FlowBox;
      
      private var sam:ScrollableArrowMenu;
      
      mx_internal var _go_full_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function go_full()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Application,
            "events":{
               "preinitialize":"___go_full_Application1_preinitialize",
               "applicationComplete":"___go_full_Application1_applicationComplete",
               "addedToStage":"___go_full_Application1_addedToStage"
            },
            "stylesFactory":function():void
            {
               this.backgroundColor = 16777215;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "creationPolicy":"none",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_mainContainer",
                     "propertiesFactory":function():Object
                     {
                        return {"childDescriptors":[new UIComponentDescriptor({
                           "type":Timeline,
                           "id":"_timeline",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "y":470,
                                 "styleName":"timeLine"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":MainStage,
                           "id":"_mainStage",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":470,
                                 "visible":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ThumbTray,
                           "id":"_thumbTray",
                           "propertiesFactory":function():Object
                           {
                              return {"visible":false};
                           }
                        }),new UIComponentDescriptor({
                           "type":OverTray,
                           "id":"_overTray"
                        }),new UIComponentDescriptor({
                           "type":TopButtonBar,
                           "id":"_topButtonBar",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "right":0,
                                 "y":0,
                                 "visible":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":EffectTray,
                           "id":"_effectTray",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "right":10,
                                 "y":68,
                                 "width":30
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":MyProgressBar,
                           "id":"_loadProgress",
                           "events":{"creationComplete":"___loadProgress_creationComplete"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "labelPlacement":"center",
                                 "enabled":true,
                                 "mode":"manual",
                                 "x":633,
                                 "y":35,
                                 "width":271,
                                 "visible":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ScreenCapTool,
                           "id":"_screenCapTool",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_tipsLayer",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TutorialManager,
                           "id":"_goWalker",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_extSwfContainer",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":0,
                                 "y":0,
                                 "percentHeight":100,
                                 "percentWidth":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___go_full_Button1_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":550,
                                 "y":5,
                                 "visible":false,
                                 "label":"Toggle fullscreen"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":StudioLoadingScreen,
                           "id":"_studioProgress"
                        })]};
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._go_full_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_go_fullWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return go_full[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.layout = "absolute";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.creationPolicy = "none";
         this.addEventListener("preinitialize",this.___go_full_Application1_preinitialize);
         this.addEventListener("applicationComplete",this.___go_full_Application1_applicationComplete);
         this.addEventListener("addedToStage",this.___go_full_Application1_addedToStage);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         go_full._watcherSetupUtil = param1;
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
         };
         mx_internal::_go_full_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function resetFrameRate() : void
      {
         if(this.stage)
         {
            this.stage.frameRate = 24;
         }
      }
      
      private function loadClientLocale() : void //load localization
      {
         Util.loadClientLocale("go",this.onClientLocaleComplete);
      }
      
      private function onClientLocaleComplete(param1:Event) : void
      {
         this.loadClientTheme();
      }
      
      private function loadClientTheme() : void //load theme color
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_THEME_COLOR);
         var _loc3_:String = _loc1_.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE) || "en_US";
         Util.changeClientTheming(_loc2_,_loc3_,"go_full",this.onClientThemeComplete);
      }
      
      private function onClientThemeComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onClientThemeComplete);
         createComponentsFromDescriptors();
      }
      
      private function initialConsole() : void
      {
         Util.gaTracking("/gostudio/initialGoFullConsole",this.stage);
         this._thumbTray.hidable = false;
         this._thumbTray.changeToFullSize();
         UtilNetwork.loadS3crossDomainXml();
         this._console = Console.initializeConsole(this._mainStage,this._topButtonBar,this._thumbTray,this._effectTray,this._timeline,this._extSwfContainer,this._overTray._pw,this._tipsLayer,this._screenCapTool,this._goWalker,Console.FULL_STUDIO) as Console;
         this._goWalker.console = this._console;
         this._console.initializeLoadingBar(this._loadProgress);
         this._console.studioProgress = this._studioProgress;
         this._console.boxMode = UtilLicense.isBoxEnvironment();
         this._mainStage.visible = this._thumbTray.visible = this._topButtonBar.visible = true;
         this.addEventListener(KeyboardEvent.KEY_UP,Console.getConsole().doKeyUp);
         if(Util.getFlashVar().getValueByKey("siteId") == String(Global.BEN10)) //Stuff for Ben 10
         {
            this._bFluidLayout = false;
            this._mainStage.currentState = "cn";
            this._topButtonBar.currentState = "cn";
            this._thumbTray.currentState = "cn";
         }
         else if(Util.getFlashVar().getValueByKey("siteId") == String(Global.DOMO)) //Stuff for domo
         {
            this._bFluidLayout = false;
            this._mainStage.currentState = "domo";
            this._topButtonBar.currentState = "domo";
            this._thumbTray.currentState = "domo";
         }
         else
         {
            this._thumbTray.btnImport.visible = UtilLicense.isUploadRelatedButtonShouldBeShown() && UtilUser.loggedIn; //Allow import if conditions are met
            if(Util.getFlashVar().getValueByKey("siteId") == "11") //Stuff for school
            {
               this._thumbTray.currentState = "school";
            }
         }
         var tm:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE);
         if(tm == ServerConstants.FLASHVAR_TM_NEW || tm == ServerConstants.FLASHVAR_TM_SEMI)
         {
            this._goWalker.addEventListener(TutorialEvent.TUTORIAL_DONE,function():void
            {
               _bFluidLayout = true;
               onStageResize();
            });
            this._bFluidLayout = false;
         }
         this.initStageLayout();
         this.initStageQuality();
      }
      
      private function initStageQuality() : void
      {
         var _loc1_:SharedObject = null;
         this.stage.quality = StageQuality.MEDIUM;
         try //try to get quality; wrapped in try catch to avoid anything bad happening incase of the data not being present
         {
            _loc1_ = SharedObject.getLocal("studioPreferences");
            if(_loc1_.data.stageQuality != null)
            {
               this.stage.quality = _loc1_.data.stageQuality;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function initStageLayout() : void
      {
         this.stage.scaleMode = "noScale";
         this.stage.align = StageAlign.TOP_LEFT;
         this.stage.addEventListener(Event.RESIZE,this.onStageResize);
         this.onStageResize();
         this.stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.fullScreenHandler);
         this._timeline.addEventListener(ResizeEvent.RESIZE,this.onStageResize);
      }
      
      private function onStageResize(param1:Event = null) : void //Sets dimensions on resize
      {
         var _loc2_:Number = stage.stageWidth;
         var _loc3_:Number = stage.stageHeight;
         if(!this._bFluidLayout)
         {
            this._mainContainer.x = (_loc2_ - AnimeConstants.STUDIO_WIDTH_DEFAULT) / 2;
            _loc2_ = AnimeConstants.STUDIO_WIDTH_DEFAULT;
            _loc3_ = AnimeConstants.STUDIO_HEIGHT_DEFAULT;
         }
         else
         {
            this._mainContainer.x = 0;
         }
         if(_loc2_ < AnimeConstants.STUDIO_WIDTH_MIN)
         {
            _loc2_ = AnimeConstants.STUDIO_WIDTH_MIN;
         }
         if(_loc3_ < AnimeConstants.STUDIO_HEIGHT_MIN)
         {
            _loc3_ = AnimeConstants.STUDIO_HEIGHT_MIN;
         }
         this._timeline.width = _loc2_;
         this._timeline.y = _loc3_ - this._timeline.height;
         this._mainStage.height = _loc3_ - this._timeline.height;
         this._mainStage.width = _loc2_ - this._thumbTray.width;
         this._thumbTray.height = _loc3_ - this._timeline.height;
         this._overTray.height = _loc3_ - this._timeline.height;
         this._extSwfContainer.width = _loc2_;
         this._extSwfContainer.height = _loc3_;
         this._loadProgress.x = (_loc2_ + this._thumbTray.width - this._loadProgress.width) / 2;
      }
      
      private function toggleFullScreen() : void
      {
         try
         {
            switch(this.stage.displayState)
            {
               case StageDisplayState.FULL_SCREEN:
                  this.stage.displayState = StageDisplayState.NORMAL;
                  break;
               default:
                  this.stage.displayState = StageDisplayState.FULL_SCREEN;
            }
         }
         catch(err:SecurityError)
         {
         }
      }
      
      private function fullScreenHandler(param1:FullScreenEvent) : void //useless, assuming stub due to autogeneration
      {
         if(!param1.fullScreen)
         {
         }
      }
      
      public function ___go_full_Application1_preinitialize(param1:FlexEvent) : void //preinitialization; does client
      {
         this.loadClientLocale();
      }
      
      public function ___go_full_Application1_applicationComplete(param1:FlexEvent) : void
      {
         this.initialConsole();
      }
      
      public function ___go_full_Application1_addedToStage(param1:Event) : void
      {
         this.resetFrameRate();
      }
      
      public function ___loadProgress_creationComplete(param1:FlexEvent) : void //show load screen progress
      {
         this._loadProgress.label = UtilDict.toDisplay("go","loading");
      }
      
      public function ___go_full_Button1_click(param1:MouseEvent) : void //Full screen button
      {
         this.toggleFullScreen();
      }
      
      private function _go_full_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return AnimeConstants.STUDIO_WIDTH_DEFAULT;
         },null,"_timeline.width");
         result[1] = new Binding(this,function():Object
         {
            return _thumbTray.width;
         },null,"_mainStage.left");
         result[2] = new Binding(this,function():Number
         {
            return AnimeConstants.STUDIO_WIDTH_DEFAULT - _thumbTray.width;
         },null,"_mainStage.width");
         return result;
      }
      
      mx_internal function _go_full_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_go_full_StylesInit_done)
         {
            return;
         }
         mx_internal::_go_full_StylesInit_done = true;
         style = styleManager.getStyleDeclaration("global");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration("global",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.layoutDirection = "ltr";
            };
         }
         styleManager.initProtoChainRoots();
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectTray() : EffectTray
      {
         return this._1490827770_effectTray;
      }
      
      public function set _effectTray(param1:EffectTray) : void
      {
         var _loc2_:Object = this._1490827770_effectTray;
         if(_loc2_ !== param1)
         {
            this._1490827770_effectTray = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectTray",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _extSwfContainer() : Canvas
      {
         return this._2061112671_extSwfContainer;
      }
      
      public function set _extSwfContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._2061112671_extSwfContainer;
         if(_loc2_ !== param1)
         {
            this._2061112671_extSwfContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_extSwfContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _goWalker() : TutorialManager
      {
         return this._1523657885_goWalker;
      }
      
      public function set _goWalker(param1:TutorialManager) : void
      {
         var _loc2_:Object = this._1523657885_goWalker;
         if(_loc2_ !== param1)
         {
            this._1523657885_goWalker = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_goWalker",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _loadProgress() : MyProgressBar
      {
         return this._1820782830_loadProgress;
      }
      
      public function set _loadProgress(param1:MyProgressBar) : void
      {
         var _loc2_:Object = this._1820782830_loadProgress;
         if(_loc2_ !== param1)
         {
            this._1820782830_loadProgress = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_loadProgress",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainContainer() : Canvas
      {
         return this._1313433399_mainContainer;
      }
      
      public function set _mainContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1313433399_mainContainer;
         if(_loc2_ !== param1)
         {
            this._1313433399_mainContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainStage() : MainStage
      {
         return this._1751026874_mainStage;
      }
      
      public function set _mainStage(param1:MainStage) : void
      {
         var _loc2_:Object = this._1751026874_mainStage;
         if(_loc2_ !== param1)
         {
            this._1751026874_mainStage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainStage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _overTray() : OverTray
      {
         return this._619629449_overTray;
      }
      
      public function set _overTray(param1:OverTray) : void
      {
         var _loc2_:Object = this._619629449_overTray;
         if(_loc2_ !== param1)
         {
            this._619629449_overTray = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_overTray",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _screenCapTool() : ScreenCapTool
      {
         return this._1149811839_screenCapTool;
      }
      
      public function set _screenCapTool(param1:ScreenCapTool) : void
      {
         var _loc2_:Object = this._1149811839_screenCapTool;
         if(_loc2_ !== param1)
         {
            this._1149811839_screenCapTool = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_screenCapTool",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _studioProgress() : StudioLoadingScreen
      {
         return this._739375038_studioProgress;
      }
      
      public function set _studioProgress(param1:StudioLoadingScreen) : void
      {
         var _loc2_:Object = this._739375038_studioProgress;
         if(_loc2_ !== param1)
         {
            this._739375038_studioProgress = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_studioProgress",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _thumbTray() : ThumbTray
      {
         return this._159139667_thumbTray;
      }
      
      public function set _thumbTray(param1:ThumbTray) : void
      {
         var _loc2_:Object = this._159139667_thumbTray;
         if(_loc2_ !== param1)
         {
            this._159139667_thumbTray = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_thumbTray",_loc2_,param1)); //react to updates on menu
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _timeline() : Timeline
      {
         return this._1986132576_timeline;
      }
      
      public function set _timeline(param1:Timeline) : void
      {
         var _loc2_:Object = this._1986132576_timeline;
         if(_loc2_ !== param1)
         {
            this._1986132576_timeline = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_timeline",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tipsLayer() : Canvas
      {
         return this._1592971130_tipsLayer;
      }
      
      public function set _tipsLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1592971130_tipsLayer;
         if(_loc2_ !== param1)
         {
            this._1592971130_tipsLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tipsLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _topButtonBar() : TopButtonBar
      {
         return this._427053173_topButtonBar;
      }
      
      public function set _topButtonBar(param1:TopButtonBar) : void
      {
         var _loc2_:Object = this._427053173_topButtonBar;
         if(_loc2_ !== param1)
         {
            this._427053173_topButtonBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_topButtonBar",_loc2_,param1));
            }
         }
      }
   }
}
