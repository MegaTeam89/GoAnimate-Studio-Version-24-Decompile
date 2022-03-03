package anifire.core
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleMgr;
   import anifire.command.*;
   import anifire.component.*;
   import anifire.components.MyProgressBar;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.components.publish.PublishWindow;
   import anifire.components.publish.WatermarkManager;
   import anifire.components.studio.BubbleMsgChooser;
   import anifire.components.studio.BubbleMsgChooserItem;
   import anifire.components.studio.BubbleMsgEvent;
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.ExternalPreviewWindowController;
   import anifire.components.studio.Feedback;
   import anifire.components.studio.MainStage;
   import anifire.components.studio.OverTray;
   import anifire.components.studio.PropertiesWindow;
   import anifire.components.studio.SaveTemplateWindow;
   import anifire.components.studio.ScreenCapTool;
   import anifire.components.studio.ThumbTray;
   import anifire.components.studio.TipWindow;
   import anifire.components.studio.TopButtonBar;
   import anifire.components.studio.ViewStackWindow;
   import anifire.components.studio.noSaveAlertWindow;
   import anifire.constant.AnimeConstants;
   import anifire.constant.LicenseConstants;
   import anifire.constant.ServerConstants;
   import anifire.constant.ThemeConstants;
   import anifire.constant.ThemeEmbedConstant;
   import anifire.core.sound.SoundCollection;
   import anifire.core.sound.SoundEvent;
   import anifire.core.sound.SoundPlaybackManager;
   import anifire.core.sound.SpeechManager;
   import anifire.core.sound.StudioSoundFactory;
   import anifire.core.sound.StudioSoundManager;
   import anifire.core.sound.TTSManager;
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.effect.ZoomEffect;
   import anifire.errors.SerializeError;
   import anifire.event.CoreEvent;
   import anifire.event.EffectEvt;
   import anifire.event.LoadMgrEvent;
   import anifire.events.*;
   import anifire.interfaces.IConsoleImportable;
   import anifire.interfaces.IFlippable;
   import anifire.interfaces.IIterator;
   import anifire.managers.*;
   import anifire.playback.PlayerConstant;
   import anifire.playerComponent.PreviewPlayer;
   import anifire.popups.BusinessPreviewUpgrade;
   import anifire.popups.BusinessPreviewWelcome;
   import anifire.popups.GoPopUp;
   import anifire.popups.RemovingZoomWarning;
   import anifire.scene.controller.SceneEditorController;
   import anifire.scene.model.SceneManager;
   import anifire.scene.view.SceneView;
   import anifire.timeline.ElementInfo;
   import anifire.timeline.SceneElement;
   import anifire.timeline.SceneLengthController;
   import anifire.timeline.SoundContainer;
   import anifire.timeline.SoundTrackArea;
   import anifire.timeline.Timeline;
   import anifire.timeline.TimelineEvent;
   import anifire.tutorial.*;
   import anifire.util.*;
   import com.adobe.images.JPGEncoder;
   import com.jac.ogg.OggEncoder;
   import flash.display.AVM1Movie;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.System;
   import flash.text.StyleSheet;
   import flash.ui.Keyboard;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.ProgressBar;
   import mx.controls.SWFLoader;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.Application;
   import mx.core.DragSource;
   import mx.core.FlexGlobals;
   import mx.core.IFlexDisplayObject;
   import mx.effects.Blur;
   import mx.effects.Fade;
   import mx.effects.Glow;
   import mx.effects.Parallel;
   import mx.effects.easing.Exponential;
   import mx.events.EffectEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.ItemClickEvent;
   import mx.events.ScrollEvent;
   import mx.graphics.codec.PNGEncoder;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.CursorManager;
   import mx.managers.PopUpManager;
   import mx.managers.SystemManager;
   import mx.utils.Base64Encoder;
   import mx.utils.StringUtil;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   import nochump.util.zip.ZipOutput;
   import template.templateApp.classes.Global;
   
   public class Console implements IConsoleImportable, IEventDispatcher
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Console");
      
      private static var _console:Console;
      
      public static const FULL_STUDIO:String = "Full_Studio";
      
      public static const TINY_STUDIO:String = "tiny_studio";
      
      public static const BOX_STUDIO:String = "box_studio";
      
      public static const MESSAGE_STUDIO:String = "message_studio";
       
      
      public var flickrToken:String = null;
      
      public var fbAuthToken:String = null;
      
      private var _thumbTray:ThumbTray;
      
      private var _effectTray:EffectTray;
      
      private var _topButtonBar:TopButtonBar;
      
      private var _mainStage:MainStage;
      
      private var _timeline:Timeline;
      
      private var _tipsLayer:Canvas;
      
      private var _pptPanel:PropertiesWindow;
      
      private var _themeListXML:XML;
      
      private var _purchasedAssetsXML:XMLList;
      
      private var _sounds:SoundCollection;
      
      private var _prevSceneLength:Number;
      
      private var _prevSoundInfo:ElementInfo;
      
      private var _prevAllSoundInfo:Array;
      
      private var _eventDispatcher:UtilEventDispatcher;
      
      private var _changed:Boolean;
      
      private var _ttsEnabled:Boolean;
      
      private var _templateMetaData:MetaData;
      
      private var _metaData:MetaData;
      
      private var _tempMetaData:MetaData;
      
      private var _tempPublished:Boolean = true;
      
      private var _tempPrivateShared:Boolean = false;
      
      private var _movieXML:XML;
      
      private var _originalId:String;
      
      private var _loadProgress:ProgressBar;
      
      private var _isLoaddingCommonTheme:Boolean = false;
      
      private var _isCommonThemeLoadded:Boolean = false;
      
      private var _isLoaddingCommonThemeBg:Boolean = false;
      
      private var _isLoaddingCommonThemeProp:Boolean = false;
      
      private var _isLoaddingCommonThemeChar:Boolean = false;
      
      private var _studioType:String;
      
      private var _initialized:Boolean = false;
      
      private var _newlyAddedAssetIds:String = "";
      
      private var _capScreenLock:Boolean = false;
      
      private var _defaultUpdateAllTimelineImage:Boolean = false;
      
      private var _badTerms:Array = null;
      
      private var _whiteTerms:Array = null;
      
      public var excludedIds:UtilHashArray;
      
      private var _blacklistEnabled:Boolean;
      
      private var _currDragObject:Asset;
      
      private var _soundMute:Boolean = true;
      
      private var _myAnimatedMask:AnimatedMask;
      
      private var _watermarkManager:WatermarkManager;
      
      private var _headable:Boolean;
      
      private var _holdable:Boolean;
      
      private var _placeable:Boolean;
      
      private var _purchaseEnabled:Boolean;
      
      private var _uploadedAssetsEnabled:Boolean;
      
      private var _siteId:String;
      
      private var _initCreation:Boolean = true;
      
      private var _boxMode:Boolean = false;
      
      private var _screenCapTool:ScreenCapTool;
      
      private var _goWalker:TutorialManager;
      
      private var _currentLicensorName:String = "";
      
      private var _guideMode:String = "";
      
      private var _initThemeCode:String = null;
      
      private var _skipSceneRendering:Boolean = false;
      
      private var _externalPreviewPlayerController:ExternalPreviewWindowController;
      
      private var LOCAL_CON:String = "importer_lc";
      
      private var _speechManager:SpeechManager;
      
      private var _movie:MovieData;
      
      private var _popUp:GoPopUp = null;
      
      private const MAX_SCENE_NUMBER:uint = 99999;
      
      private var hoverStyles:String = "a:hover { color: #0000CC; text-decoration: underline; } a { color: #0000CC; text-decoration: none; }";
      
      private var _isCopy:Boolean = false;
      
      private var _groupController:GroupController;
      
      private var _addBlankScene:Boolean = false;
      
      private var _shouldUseExternalPreviewPlayer:Number = -1;
      
      private var _linkageController:LinkageController;
      
      private var _thumbSO:SharedObject;
      
      private var _copyObjects:Array;
      
      private var _extSwfContainer:Canvas;
      
      private var _studioProgress:Canvas;
      
      private var _isStudioReady:Boolean = false;
      
      private var _publishQuality:String = "360p";
      
      private var _screenMode:String = "normal_screen_node";
      
      private var _selectedSceneIndexBeforeCapture:uint = 0;
      
      private var _tempAsset:Asset;
      
      private var _swfLoader:SWFLoader;
      
      private var _inspirationLoader:SWFLoader;
      
      private var _actionshopLoader:SWFLoader;
      
      private var _importer:Application;
      
      private var _importerOpenedBefore:Boolean = false;
      
      private var _saveTempW:SaveTemplateWindow;
      
      private var _currSceneOnlyForTemp:Boolean = false;
      
      private var _uploadType:String = "bg";
      
      private var _assetId:Number = 0;
      
      private var _uploadedAssetXML:XML;
      
      private var storecollection:Array;
      
      private var unlockedAssets:Array = null;
      
      private var _isMovieNew:Boolean = false;
      
      private var _previewData:UtilHashArray;
      
      private var _sci:int;
      
      private var _filmXML:XML;
      
      private var _viewStackWindow:ViewStackWindow = null;
      
      private var _isLoadding:Boolean = false;
      
      private var _isLoadingTemplate:Boolean = false;
      
      private var _insertSceneAtIndex:Number = 0;
      
      private var _selectedTemplateThumb:TemplateThumb;
      
      private var _publishW:PublishWindow;
      
      private var _redirect:Boolean = false;
      
      private var _bubbleThumbGuide:Image;
      
      private var _bubbleSceneGuide:Image;
      
      private var _needGuideBubbles:Boolean = true;
      
      private var _isAutoSave:Boolean = false;
      
      private var _selectedThumbnailIndex:int = 0;
      
      private var _selectedThumbForTempIndex:int = 0;
      
      public function Console(param1:MainStage, param2:TopButtonBar, param3:ThumbTray, param4:EffectTray, param5:Timeline, param6:Canvas, param7:PropertiesWindow, param8:Canvas, param9:ScreenCapTool, param10:TutorialManager = null, param11:String = "tiny_studio")
      {
         var _loc12_:UtilHashArray = null;
         var _loc13_:Number = NaN;
         this._sounds = new SoundCollection();
         this._watermarkManager = new WatermarkManager();
         this._externalPreviewPlayerController = new ExternalPreviewWindowController();
         this._speechManager = new SpeechManager();
         this._swfLoader = new SWFLoader();
         this._inspirationLoader = new SWFLoader();
         this._actionshopLoader = new SWFLoader();
         this.storecollection = new Array();
         super();
         if(param1 != null && param2 != null && param3 != null && param5 != null)
         {
            this._myAnimatedMask = AnimatedMask.getInstance();
            Util.initLog();
            this._mainStage = param1;
            this._topButtonBar = param2;
            this._mainStage.loggedIn = UtilUser.loggedIn;
            this._thumbTray = param3;
            this._timeline = param5;
            this._effectTray = param4;
            this._extSwfContainer = param6;
            this.pptPanel = param7;
            this._tipsLayer = param8;
            this.screenCapTool = param9;
            this.goWalker = param10;
            this._studioType = param11;
            this._timeline.addEventListener(TimelineEvent.SCENE_MOUSE_UP,this.onSceneUpHandler);
            this._timeline.addEventListener(TimelineEvent.SCENE_MOUSE_DOWN,this.onSceneDownHandler);
            this._timeline.addEventListener(TimelineEvent.SCENE_RESIZE_START,this.onSceneResizeStartHandler);
            this._timeline.addEventListener(TimelineEvent.SCENE_RESIZE_COMPLETE,this.onSceneResizeCompleteHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_CLICK,this.onSoundClickHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_MOVE,this.onSoundMoveHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE,this.onSoundResizeHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE_START,this.onSoundResizeStartHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_RESIZE_COMPLETE,this.onSoundResizeCompleteHandler);
            this._timeline.addEventListener(TimelineEvent.SOUND_MOUSE_DOWN,this.onSoundMouseDownHandler);
            this._movie = new MovieData();
            this._movie.selection.addEventListener(Event.CHANGE,this.onSceneSelectionChange);
            this._movie.addEventListener(MovieEvent.SCENE_ADDED,this.onSceneAdded);
            this._movie.addEventListener(MovieEvent.SCENE_REMOVED,this.onSceneRemoved);
            this._movie.addEventListener(MovieEvent.SCENE_MOVED,this.onSceneMoved);
            this._previewData = new UtilHashArray();
            this._metaData = new MetaData();
            this._tempMetaData = new MetaData();
            this._templateMetaData = new MetaData();
            this._tempMetaData.lang = Util.preferLanguageShortCode();
            this._metaData.lang = Util.preferLanguageShortCode();
            this._eventDispatcher = new UtilEventDispatcher();
            _loc12_ = Util.getFlashVar();
            this._ttsEnabled = _loc12_.getValueByKey("tts_enabled") == "1";
            this._purchaseEnabled = _loc12_.getValueByKey("pts") == "1";
            this._uploadedAssetsEnabled = _loc12_.getValueByKey("upl") != "0";
            this._blacklistEnabled = _loc12_.getValueByKey("hb") == "1";
            this._siteId = _loc12_.getValueByKey("siteId");
            if(this._siteId == "" || this._siteId == null)
            {
               this._siteId = Util.getFlashVar().getValueByKey("siteId");
            }
            if(!this._uploadedAssetsEnabled)
            {
               this._thumbTray.disallowUploadedAssets();
            }
            this._thumbTray.initThumbTrayDefaultTab(this.studioType != MESSAGE_STUDIO);
            _loc13_ = 1;
            if(this.studioType == FULL_STUDIO || this.studioType == TINY_STUDIO)
            {
               if(FeatureManager.shouldAutoSaveBeEnabled)
               {
                  this.initAutoSave();
               }
            }
            else if(this.studioType == MESSAGE_STUDIO)
            {
               _loc13_ = 1;
            }
            if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE) == ServerConstants.FLASHVAR_TM_NEW)
            {
               this._guideMode = ServerConstants.FLASHVAR_TM_NEW;
            }
            else if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE) == ServerConstants.FLASHVAR_TM_SEMI)
            {
               this._guideMode = ServerConstants.FLASHVAR_TM_SEMI;
            }
            this.groupController = new GroupController();
            if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_ID) != null)
            {
               this.groupController.currentGroup = new Group(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_ID),Util.getFlashVar().getValueByKey(ServerConstants.PARAM_GROUP_NAME));
            }
            this.linkageController = new LinkageController();
            this.linkageController.eventDispatcher.addEventListener(SoundEvent.UPDATED,this.onUpdateLinkage);
            this.loadThemeList(_loc13_);
            this.addCallBack();
            UtilUser.eventDispatcher.addEventListener(UtilUser.ACCOUNT_UPGRADED,this.onUserAccountUpgraded);
            UtilApp.mainAppName = UtilApp.STUDIO;
            this.screenMode = !!LicenseConstants.isWideScreen() ? AnimeConstants.SCREEN_MODE_WIDE : AnimeConstants.SCREEN_MODE_NORMAL;
            OggEncoder.getInstance();
         }
      }
      
      public static function initializeConsole(param1:MainStage, param2:TopButtonBar, param3:ThumbTray, param4:EffectTray, param5:Timeline, param6:Canvas, param7:PropertiesWindow, param8:Canvas, param9:ScreenCapTool, param10:TutorialManager = null, param11:String = "tiny_studio") : Object
      {
         if(_console == null)
         {
            _console = new Console(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         }
         return _console;
      }
      
      public static function getConsole() : Console
      {
         if(_console != null)
         {
            return _console;
         }
         throw new Error("Console must be intialized first");
      }
      
      public function get screenMode() : String
      {
         return this._screenMode;
      }
      
      public function set screenMode(param1:String) : void
      {
         this._screenMode = param1;
         this.mainStage.sceneEditor.redrawOffStageArea(this._screenMode);
         SceneView(this.mainStage.sceneEditor.view.view).refreshSceneBg(this._screenMode);
      }
      
      public function get templateMetaData() : MetaData
      {
         return this._templateMetaData;
      }
      
      public function get watermarkManager() : WatermarkManager
      {
         return this._watermarkManager;
      }
      
      public function set templateMetaData(param1:MetaData) : void
      {
         this._templateMetaData = param1;
      }
      
      public function set studioProgress(param1:Canvas) : void
      {
         this._studioProgress = param1;
      }
      
      public function addNewlyAddedAssetId(param1:String) : void
      {
         if(this._newlyAddedAssetIds == "")
         {
            this._newlyAddedAssetIds += param1;
         }
         else
         {
            this._newlyAddedAssetIds += "," + param1;
         }
      }
      
      private function set thumbSO(param1:SharedObject) : void
      {
         this._thumbSO = param1;
      }
      
      private function get thumbSO() : SharedObject
      {
         return this._thumbSO;
      }
      
      private function set isCopy(param1:Boolean) : void
      {
         this._isCopy = param1;
      }
      
      private function get isCopy() : Boolean
      {
         return this._isCopy;
      }
      
      public function set goWalker(param1:TutorialManager) : void
      {
         this._goWalker = param1;
      }
      
      public function get goWalker() : TutorialManager
      {
         return this._goWalker;
      }
      
      public function set screenCapTool(param1:ScreenCapTool) : void
      {
         this._screenCapTool = param1;
      }
      
      public function get screenCapTool() : ScreenCapTool
      {
         return this._screenCapTool;
      }
      
      public function get boxMode() : Boolean
      {
         return this._boxMode;
      }
      
      public function set boxMode(param1:Boolean) : void
      {
         this._boxMode = param1;
      }
      
      public function set tipsLayer(param1:Canvas) : void
      {
         this._tipsLayer = param1;
      }
      
      public function get tipsLayer() : Canvas
      {
         return this._tipsLayer;
      }
      
      public function set pptPanel(param1:PropertiesWindow) : void
      {
         this._pptPanel = param1;
      }
      
      public function get pptPanel() : PropertiesWindow
      {
         return this._pptPanel;
      }
      
      public function get stageScale() : Number
      {
         return Console.getConsole().mainStage.zoomContainer.zoomFactor;
      }
      
      public function set capScreenLock(param1:Boolean) : void
      {
         this._capScreenLock = param1;
      }
      
      public function get capScreenLock() : Boolean
      {
         return this._capScreenLock;
      }
      
      public function get newlyAddedAssetIds() : String
      {
         return this._newlyAddedAssetIds;
      }
      
      public function get initCreation() : Boolean
      {
         return this._initCreation;
      }
      
      public function set initCreation(param1:Boolean) : void
      {
         this._initCreation = param1;
      }
      
      public function getViewStackWindow() : ViewStackWindow
      {
         return this._viewStackWindow;
      }
      
      public function getImporter() : Application
      {
         return this._importer;
      }
      
      public function get swfloader() : SWFLoader
      {
         return this._swfLoader;
      }
      
      public function get studioType() : String
      {
         return this._studioType;
      }
      
      public function get themeListXML() : XML
      {
         return this._themeListXML;
      }
      
      public function get myAnimatedMask() : AnimatedMask
      {
         return this._myAnimatedMask;
      }
      
      public function get currDragSource() : DragSource
      {
         return StudioDragManager.dragSource;
      }
      
      public function set currDragSource(param1:DragSource) : void
      {
         StudioDragManager.dragSource = param1;
      }
      
      public function get currDragObject() : Asset
      {
         return this._currDragObject;
      }
      
      public function set currDragObject(param1:Asset) : void
      {
         this._currDragObject = param1;
      }
      
      public function get topButtonBar() : TopButtonBar
      {
         return this._topButtonBar;
      }
      
      public function get thumbTray() : ThumbTray
      {
         return this._thumbTray;
      }
      
      public function get siteId() : String
      {
         return this._siteId;
      }
      
      public function get currentLicensorName() : String
      {
         return this._currentLicensorName;
      }
      
      public function set currentLicensorName(param1:String) : void
      {
         this._currentLicensorName = param1;
      }
      
      private function get externalPreviewPlayerController() : ExternalPreviewWindowController
      {
         return this._externalPreviewPlayerController;
      }
      
      private function set externalPreviewPlayerController(param1:ExternalPreviewWindowController) : void
      {
         this._externalPreviewPlayerController = param1;
      }
      
      public function userHasTTSRight() : Boolean
      {
         return this._ttsEnabled;
      }
      
      public function get mainStage() : MainStage
      {
         return this._mainStage;
      }
      
      public function get effectTray() : EffectTray
      {
         return this._effectTray;
      }
      
      public function get timeline() : Timeline
      {
         return this._timeline;
      }
      
      public function set timeline(param1:Timeline) : void
      {
         this._timeline = param1;
      }
      
      public function get scenes() : Array
      {
         return this._movie.scenes;
      }
      
      public function get currentScene() : AnimeScene
      {
         return this._movie.selection.currentScene;
      }
      
      public function set currentScene(param1:AnimeScene) : void
      {
         this._movie.selection.currentScene = param1;
      }
      
      public function get currentSceneId() : String
      {
         if(this._movie.currentScene != null)
         {
            return this._movie.currentScene.id;
         }
         return null;
      }
      
      public function get sounds() : SoundCollection
      {
         return this._sounds;
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function set changed(param1:Boolean) : void
      {
         this._changed = param1;
         if(param1 && !this._capScreenLock)
         {
            this.doUpdateTimeline(null,true);
            this.updateSceneLength();
         }
      }
      
      public function get metaData() : MetaData
      {
         return this._metaData;
      }
      
      public function get tempMetaData() : MetaData
      {
         return this._tempMetaData;
      }
      
      public function get tempPublished() : Boolean
      {
         return this._tempPublished;
      }
      
      public function set tempPublished(param1:Boolean) : void
      {
         this._tempPublished = param1;
      }
      
      public function get tempPrivateShared() : Boolean
      {
         return this._tempPrivateShared;
      }
      
      public function set tempPrivateShared(param1:Boolean) : void
      {
         this._tempPrivateShared = param1;
      }
      
      public function get uploadType() : String
      {
         return this._uploadType;
      }
      
      public function set uploadType(param1:String) : void
      {
         this._uploadType = param1;
      }
      
      public function set soundMute(param1:Boolean) : void
      {
         this._soundMute = param1;
         var _loc2_:int = 0;
         if(this.currentScene != null)
         {
            this.currentScene.muteSound(param1);
         }
      }
      
      public function get soundMute() : Boolean
      {
         return this._soundMute;
      }
      
      public function set thumbTrayActive(param1:Boolean) : void
      {
         this.thumbTray.active = param1;
      }
      
      public function get isLoaddingCommonTheme() : Boolean
      {
         return this._isLoaddingCommonTheme;
      }
      
      public function set isCommonThemeLoadded(param1:Boolean) : void
      {
         this._isCommonThemeLoadded = param1;
      }
      
      public function get isCommonThemeLoadded() : Boolean
      {
         return this._isCommonThemeLoadded;
      }
      
      public function get isLoaddingCommonThemeBg() : Boolean
      {
         return this._isLoaddingCommonThemeBg;
      }
      
      public function get isLoaddingCommonThemeProp() : Boolean
      {
         return this._isLoaddingCommonThemeProp;
      }
      
      public function get isLoaddingCommonThemeChar() : Boolean
      {
         return this._isLoaddingCommonThemeChar;
      }
      
      public function get publishW() : PublishWindow
      {
         return this._publishW;
      }
      
      public function set publishW(param1:PublishWindow) : void
      {
         this._publishW = param1;
      }
      
      public function get groupController() : GroupController
      {
         return this._groupController;
      }
      
      public function set groupController(param1:GroupController) : void
      {
         this._groupController = param1;
      }
      
      public function get linkageController() : LinkageController
      {
         return this._linkageController;
      }
      
      public function set linkageController(param1:LinkageController) : void
      {
         this._linkageController = param1;
      }
      
      public function setCurrentSceneById(param1:String) : void
      {
         var _loc2_:int = this._movie.getSceneIndex(this._movie.getSceneById(param1));
         this.setCurrentScene(_loc2_);
      }
      
      public function set currentSceneIndex(param1:Number) : void
      {
         this._movie.currentIndex = param1;
      }
      
      public function get currentSceneIndex() : Number
      {
         return this._movie.currentIndex;
      }
      
      public function get movie() : MovieData
      {
         return this._movie;
      }
      
      public function get speechManager() : SpeechManager
      {
         return this._speechManager;
      }
      
      public function get publishQuality() : String
      {
         return this._publishQuality;
      }
      
      public function set publishQuality(param1:String) : void
      {
         this._publishQuality = param1;
      }
      
      public function setCurrentScene(param1:int) : void
      {
         this._movie.currentIndex = param1;
      }
      
      public function setCurrentSceneVisible() : void
      {
      }
      
      public function premiumEnabled() : Boolean
      {
         return this._purchaseEnabled;
      }
      
      private function initAutoSave() : void
      {
         if(UtilUser.isTrialAccount)
         {
            return;
         }
         var _loc1_:Timer = new Timer(AnimeConstants.AUTOSAVE_INTERVAL);
         _loc1_.addEventListener(TimerEvent.TIMER,this.onTimerHandler);
         _loc1_.start();
      }
      
      private function addCallBack() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("showActionShop",this.showActionShop);
            ExternalInterface.addCallback("reloadAllCC",this.reloadAllCC);
            ExternalInterface.addCallback("showBuyGoBuckPopUp",this.showBuyGoBuckPopUp);
            ExternalInterface.addCallback("showTransactionPopUp",this.showTransactionPopUp);
            if(!UtilUser.loggedIn)
            {
               ExternalInterface.addCallback("onUserLogined",this.onUserLogined);
               ExternalInterface.addCallback("onUserLoginCancel",this.onUserLoginCancel);
            }
         }
      }
      
      private function onUserAccountUpgraded(param1:Event) : void
      {
      }
      
      private function onUserWannaSaveWork(param1:Event) : void
      {
         this.showPublishWindow();
      }
      
      private function showTransactionPopUp(param1:Boolean) : void
      {
         UtilUser.showUpdatePopUp(param1);
      }
      
      public function onTestButtonClick() : void
      {
      }
      
      private function onSelectFile(param1:Event) : void
      {
         Alert.show("loaded");
      }
      
      public function invisibleImporter() : void
      {
         this._swfLoader.visible = false;
         this._extSwfContainer.visible = false;
      }
      
      public function showImporterWindow(param1:String, param2:String = null) : void
      {
         var type:String = param1;
         var text:String = param2;
         if(!this._extSwfContainer.contains(this._swfLoader))
         {
            this._swfLoader.percentWidth = 100;
            this._swfLoader.percentHeight = 100;
            this._extSwfContainer.addChild(this._swfLoader);
         }
         if(text != null)
         {
            this._tempAsset = this._movie.currentScene.selectedAsset;
         }
         if(this._importer == null)
         {
            this._swfLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadImporterFail);
            this._swfLoader.addEventListener(Event.COMPLETE,function():void
            {
               var f:Function = null;
               _swfLoader.y = 0;
               _swfLoader.visible = true;
               CursorManager.removeBusyCursor();
               _swfLoader.content.addEventListener(Event.RENDER,f = function():void
               {
                  if(!_importerOpenedBefore)
                  {
                     try
                     {
                        _importer = Application(SystemManager(_swfLoader.content).application);
                        _importer["init"](FlexGlobals.topLevelApplication._console);
                        _swfLoader.content.removeEventListener(Event.RENDER,f);
                        if(_studioType == TINY_STUDIO)
                        {
                           _importer["isFacebook"]();
                        }
                        if(_studioType == MESSAGE_STUDIO)
                        {
                           _importer["isEmessage"]();
                        }
                        if(ThemeManager.instance.currentTheme.id == "business")
                        {
                           _importer["removeHandHeld"]();
                        }
                        _importer["gotoPanel"](type,text);
                        _importerOpenedBefore = true;
                     }
                     catch(err:TypeError)
                     {
                     }
                  }
               });
            });
            CursorManager.setBusyCursor();
            this._swfLoader.source = ServerConstants.SERVER_IMPORTER_PATH;
            this._swfLoader.load();
         }
         else
         {
            if(!this._importerOpenedBefore)
            {
               this._importer = Application(SystemManager(this._swfLoader.content).application);
               this._importer["init"](FlexGlobals.topLevelApplication._console);
               if(this._studioType != FULL_STUDIO)
               {
                  this._importer["isFacebook"]();
               }
               this._importerOpenedBefore = true;
            }
            this._importer["gotoPanel"](type,text);
            this._swfLoader.content.visible = true;
            this._swfLoader.visible = true;
         }
         if(this.currentScene != null)
         {
            this.currentScene.stopScene();
         }
         this._extSwfContainer.visible = true;
      }
      
      private function onLoadImporterFail(param1:IOErrorEvent) : void
      {
         CursorManager.removeBusyCursor();
         this._extSwfContainer.removeChild(this._swfLoader);
         Alert.show(AnimeConstants.MESSAGE_NETWORK_FAIL);
      }
      
      public function showInspirationWindow(param1:Event = null) : void
      {
         var app:Application = null;
         var e:Event = param1;
         if(!this._extSwfContainer.contains(this._inspirationLoader))
         {
            this._inspirationLoader.percentWidth = 100;
            this._inspirationLoader.percentHeight = 100;
            this._extSwfContainer.addChild(this._inspirationLoader);
         }
         if(this._inspirationLoader.content == null)
         {
            this._inspirationLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadInspirationFail);
            this._inspirationLoader.addEventListener(Event.COMPLETE,function():void
            {
               var f:Function = null;
               _inspirationLoader.y = 0;
               _inspirationLoader.visible = true;
               CursorManager.removeBusyCursor();
               _inspirationLoader.content.addEventListener(Event.RENDER,f = function():void
               {
                  try
                  {
                     app = Application(SystemManager(_inspirationLoader.content).application);
                     app["init"](FlexGlobals.topLevelApplication._console);
                     if(e is TutorialEvent)
                     {
                        app["showQuickMenu"](true);
                     }
                     else
                     {
                        app["showQuickMenu"](false);
                        app["showOpenedImage"]();
                     }
                     _inspirationLoader.content.removeEventListener(Event.RENDER,f);
                  }
                  catch(err:TypeError)
                  {
                  }
               });
            });
            CursorManager.setBusyCursor();
            this._inspirationLoader.source = ServerConstants.SERVER_INSPIRATION_PATH;
            this._inspirationLoader.load();
         }
         else
         {
            this._inspirationLoader.visible = true;
            app = Application(SystemManager(this._inspirationLoader.content).application);
            app["showOpenedImage"]();
         }
         this._extSwfContainer.visible = true;
         this._guideMode = ServerConstants.FLASHVAR_TM_FIN;
      }
      
      private function onLoadInspirationFail(param1:IOErrorEvent) : void
      {
         CursorManager.removeBusyCursor();
         this._extSwfContainer.removeChild(this._inspirationLoader);
         this._inspirationLoader = new SWFLoader();
         Alert.show(AnimeConstants.MESSAGE_NETWORK_FAIL);
      }
      
      public function hideInspiration() : void
      {
         this._inspirationLoader.visible = false;
         this._extSwfContainer.visible = false;
      }
      
      private function showActionShop(param1:String) : void
      {
         if(param1)
         {
            this.showActionShopWindow(param1);
         }
      }
      
      public function showActionShopWindow(param1:String, param2:Thumb = null) : void
      {
         var app:Application = null;
         var fn:Function = null;
         var charThumb:CharThumb = null;
         var aid:String = param1;
         var thumb:Thumb = param2;
         this.hideGuideSceneBub();
         if(!this._extSwfContainer.contains(this._actionshopLoader))
         {
            this._actionshopLoader.percentWidth = 100;
            this._actionshopLoader.percentHeight = 100;
            this._extSwfContainer.addChild(this._actionshopLoader);
         }
         if(this._actionshopLoader.content == null)
         {
            this._actionshopLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadActionshopFail);
            this._actionshopLoader.addEventListener(Event.COMPLETE,fn = function():void
            {
               var f:* = undefined;
               _actionshopLoader.visible = true;
               requestLoadStatus(false,true);
               _actionshopLoader.removeEventListener(Event.COMPLETE,fn);
               _actionshopLoader.content.addEventListener(Event.RENDER,f = function():void
               {
                  var _loc1_:* = undefined;
                  try
                  {
                     app = Application(SystemManager(_actionshopLoader.content).application);
                     _loc1_ = thumb as CharThumb;
                     app["init"](aid,true,FlexGlobals.topLevelApplication._console,_loc1_,!!_loc1_ ? _loc1_.ccThemeId : null);
                     _actionshopLoader.content.removeEventListener(Event.RENDER,f);
                  }
                  catch(err:TypeError)
                  {
                  }
               });
            });
            this.requestLoadStatus(true,true);
            this._actionshopLoader.source = ServerConstants.SERVER_ACTIONSHOP_PATH;
            this._actionshopLoader.load();
         }
         else
         {
            this._actionshopLoader.visible = true;
            app = Application(SystemManager(this._actionshopLoader.content).application);
            charThumb = thumb as CharThumb;
            app["init"](aid,true,FlexGlobals.topLevelApplication._console,charThumb,!!charThumb ? charThumb.ccThemeId : null);
         }
         if(this.currentScene != null)
         {
            this.currentScene.stopScene();
         }
         this._extSwfContainer.visible = true;
      }
      
      private function onLoadActionshopFail(param1:IOErrorEvent) : void
      {
         CursorManager.removeBusyCursor();
         this.requestLoadStatus(false,true);
         this._extSwfContainer.removeChild(this._actionshopLoader);
         this._actionshopLoader = new SWFLoader();
         Alert.show(AnimeConstants.MESSAGE_NETWORK_FAIL);
      }
      
      public function hideActionPack() : void
      {
         this._actionshopLoader.visible = false;
         this._extSwfContainer.visible = false;
         if(this.currentScene != null)
         {
            this.currentScene.playScene();
         }
      }
      
      private function onUpdateLinkage(param1:SoundEvent) : void
      {
         this.refreshAllSpeechText();
      }
      
      public function refreshAllSpeechText() : void
      {
         var _loc2_:AnimeScene = null;
         var _loc3_:String = null;
         var _loc4_:AnimeSound = null;
         var _loc5_:String = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._movie.scenes.length)
         {
            _loc2_ = this.getScene(_loc1_);
            _loc3_ = this.linkageController.getSpeechSoundIdByScene(_loc2_);
            _loc4_ = this.speechManager.getValueByKey(_loc3_);
            _loc5_ = "";
            if(_loc4_ != null)
            {
               if(_loc4_.soundThumb.ttsData.type == "mic")
               {
                  _loc5_ = UtilDict.toDisplay("go","Mic Recording");
               }
               else
               {
                  _loc5_ = _loc4_.soundThumb.ttsData.text;
               }
            }
            this.timeline.updateSceneSpeechByIndex(_loc1_,_loc5_,_loc4_);
            _loc1_++;
         }
      }
      
      public function edSaveAssignment(param1:String) : void
      {
         Util.setFlashVar("ed_assignment",param1);
      }
      
      public function onUserLogined(param1:String) : void
      {
         Util.setFlashVar("u_info",param1);
         this.dispatchEvent(new CoreEvent(CoreEvent.USER_LOGIN_COMPLETE,this));
      }
      
      public function onUserLoginCancel() : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.USER_LOGIN_CANCEL,this));
      }
      
      public function closeImporter() : void
      {
         this._importer["close"]();
      }
      
      public function showBubbleMsgWindow(param1:BubbleThumb, param2:BubbleAsset) : void
      {
         var _loc3_:int = 0;
         var _loc8_:SoundThumb = null;
         var _loc10_:BubbleMsgChooserItem = null;
         var _loc11_:SoundThumb = null;
         var _loc12_:String = null;
         var _loc4_:BubbleMsgChooser = PopUpManager.createPopUp(this.mainStage,BubbleMsgChooser,true) as BubbleMsgChooser;
         var _loc5_:Array = PresetMsg.getInstance().getMsgArray(param1.theme.id);
         var _loc6_:UtilHashThumb = ThemeManager.instance.getTheme(param1.theme.id).soundThumbs;
         var _loc7_:UtilHashThumb = new UtilHashThumb();
         _loc3_ = 0;
         while(_loc3_ < _loc6_.length)
         {
            _loc8_ = _loc6_.getValueByIndex(_loc3_) as SoundThumb;
            _loc7_.push(_loc8_.name,_loc8_);
            _loc3_++;
         }
         var _loc9_:Array = new Array();
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc12_ = _loc5_[_loc3_] as String;
            _loc11_ = _loc7_.getValueByKey(_loc12_) as SoundThumb;
            _loc10_ = new BubbleMsgChooserItem(_loc12_,(_loc3_ + 1).toString() + ") " + _loc12_,true,param2,_loc11_ != null,_loc11_);
            _loc9_.push(_loc10_);
            _loc3_++;
         }
         _loc4_.init(_loc9_);
         _loc4_.x = (this.mainStage.stage.width - _loc4_.width) / 2;
         _loc4_.y = this.mainStage.y;
         _loc4_.addEventListener(BubbleMsgEvent.ITEM_CHOOSEN,this.onBubbleMsgChoosen);
      }
      
      public function onBubbleMsgChoosen(param1:BubbleMsgEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onBubbleMsgChoosen);
         var _loc2_:BubbleMsgChooser = param1.target as BubbleMsgChooser;
         _loc2_.closeWindow();
         var _loc3_:BubbleMsgChooserItem = param1.bubbleMsgItem;
         if(_loc3_.isBubble)
         {
            this.changeBubbleMsg(_loc3_.bubbleAsset,_loc3_.msg);
         }
         if(_loc3_.isSound)
         {
            this.currentScene.createAsset(_loc3_.soundThumb);
         }
      }
      
      public function changeBubbleMsg(param1:BubbleAsset, param2:String) : void
      {
         param1.text = param2;
         param1.bubble.backupText = param2;
      }
      
      private function doShowNoSaveAlert(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowNoSaveAlert);
         var _loc2_:noSaveAlertWindow = noSaveAlertWindow(PopUpManager.createPopUp(this.mainStage,noSaveAlertWindow,true));
         _loc2_.x = (this.mainStage.stage.width - _loc2_.width) / 2;
         _loc2_.y = this.mainStage.y;
         this._topButtonBar._btnSave.enabled = false;
         this._topButtonBar._btnSave.styleName = "btnSaveFullDisabled";
         this._topButtonBar._btnSave.toolTip = "";
         this._topButtonBar._btnSave.addEventListener(MouseEvent.MOUSE_OVER,this.showNoSaveTips);
      }
      
      private function showNoSaveTips(param1:Event) : void
      {
         var _loc2_:VBox = new VBox();
         _loc2_.styleName = "vboxNoSave";
         _loc2_.setStyle("paddingTop","12");
         _loc2_.width = 400;
         _loc2_.height = 150;
         _loc2_.x = this._topButtonBar._btnSave.x + this._topButtonBar.x - _loc2_.width + this._topButtonBar._btnSave.width;
         _loc2_.y = this._topButtonBar._btnSave.y + this._topButtonBar.y;
         var _loc3_:TextArea = new TextArea();
         var _loc4_:TextArea = new TextArea();
         var _loc5_:StyleSheet;
         (_loc5_ = new StyleSheet()).parseCSS(this.hoverStyles);
         _loc3_.styleSheet = _loc4_.styleSheet = _loc5_;
         _loc3_.verticalScrollPolicy = _loc4_.verticalScrollPolicy = "off";
         _loc3_.htmlText = UtilDict.toDisplay("go","nstip_title1");
         _loc4_.htmlText = UtilDict.toDisplay("go","nstip_title2");
         _loc3_.percentWidth = _loc4_.percentWidth = 100;
         _loc3_.styleName = _loc4_.styleName = "textNormal";
         _loc3_.selectable = _loc4_.selectable = false;
         _loc3_.editable = _loc4_.editable = false;
         _loc3_.setStyle("textAlign","center");
         _loc4_.setStyle("textAlign","center");
         _loc3_.setStyle("backgroundAlpha","0");
         _loc4_.setStyle("backgroundAlpha","0");
         _loc3_.setStyle("borderStyle","none");
         _loc4_.setStyle("borderStyle","none");
         var _loc6_:Spacer;
         (_loc6_ = new Spacer()).percentHeight = 100;
         var _loc7_:Text;
         (_loc7_ = new Text()).text = UtilDict.toDisplay("go","nstip_title3");
         _loc7_.percentWidth = 100;
         _loc7_.styleName = "textSmall";
         _loc7_.selectable = false;
         _loc7_.setStyle("textAlign","right");
         _loc7_.setStyle("color","#666666");
         _loc2_.addChild(_loc3_);
         _loc2_.addChild(_loc4_);
         _loc2_.addChild(_loc6_);
         _loc2_.addChild(_loc7_);
         _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.removeNoSaveTips);
         this.tipsLayer.addChild(_loc2_);
      }
      
      private function removeNoSaveTips(param1:Event) : void
      {
         var _loc2_:VBox = VBox(param1.currentTarget);
         if(_loc2_ != null && _loc2_.parent != null && _loc2_.parent.contains(_loc2_))
         {
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.removeNoSaveTips);
            _loc2_.parent.removeChild(_loc2_);
         }
      }
      
      public function showSaveTemplateWindow(param1:Boolean = true) : void
      {
         if(this.mainStage.currentScene == null || this._isAutoSave)
         {
            return;
         }
         this._currSceneOnlyForTemp = !param1;
         SoundPlaybackManager.stop();
         this.mainStage.currentScene.selectedAsset = null;
         this._saveTempW = SaveTemplateWindow(PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,SaveTemplateWindow,true));
         PopUpManager.centerPopUp(this._saveTempW);
         this._saveTempW.initSaveTemplateWindow(this.getThumbnailCaptures(),param1);
      }
      
      private function doShowPublishWindow(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowPublishWindow);
         setTimeout(this.showPublishWindow,500);
      }
      
      public function showPublishWindow() : void
      {
         var _loc1_:IFlexDisplayObject = null;
         var _loc2_:Number = NaN;
         if(this.mainStage.currentScene == null || this._isAutoSave)
         {
            return;
         }
         if(UtilUser.isTrialAccount)
         {
            _loc1_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,BusinessPreviewUpgrade,true);
            PopUpManager.centerPopUp(_loc1_);
            return;
         }
         SoundPlaybackManager.stop();
         this.mainStage.currentScene.selectedAsset = null;
         this.genDefaultTags();
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            _loc2_ = Util.roundNum(Console.getConsole().timeline.getTotalTimeInSec());
            if(_loc2_ > FeatureManager.maxMovieDuration)
            {
               UtilPopUp.alert(UtilDict.toDisplay("go","At this time, only videos shorter than 2 minutes can be exported.  Please shorten your video."));
               return;
            }
         }
         this.publishW = PublishWindow(PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,PublishWindow,true));
         this.publishW.initPublishWindow(null,this.movie.published,this.movie.privateShared,this.getThumbnailCaptures(),this.tempMetaData.title,this.tempMetaData.getUgcTagString(),this.tempMetaData.description,this.tempMetaData.lang);
         PopUpManager.centerPopUp(this.publishW);
         if(!UtilUser.loggedIn)
         {
            Util.gaTracking("/gostudio/action/save-with-no-account",Console.getConsole().mainStage.stage);
         }
      }
      
      public function showShareWindow(param1:Event) : void
      {
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showShareWindow);
         this.removeEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showShareWindow);
         if(param1.type == CoreEvent.SAVE_MOVIE_ERROR_OCCUR)
         {
            return;
         }
         CursorManager.setBusyCursor();
         this.requestLoadStatus(true,true);
         if(this._publishW != null)
         {
            this._publishW.setBtnStatus(false);
         }
         var _loc2_:UtilHashArray = Util.getFlashVar();
         var _loc3_:String = decodeURI(_loc2_.getValueByKey(ServerConstants.FLASHVAR_NEXT_URL) as String);
         var _loc4_:RegExp = new RegExp(ServerConstants.FLASHVAR_NEXT_URL_PLACEHOLDER,"g");
         _loc3_ = _loc3_.replace(_loc4_,this.metaData.movieId);
         var _loc5_:String;
         if((_loc5_ = _loc2_.getValueByKey("ed_assignment") as String) != null)
         {
            _loc3_ = _loc3_ + "/" + _loc5_;
         }
         var _loc6_:URLVariables = new URLVariables();
         var _loc7_:URLRequest = null;
         if(Console.getConsole().boxMode)
         {
            if(this.movie.privateShared || this.movie.published)
            {
               _loc3_ = _loc3_.replace(/#/,"&goemail=goemail#");
            }
            _loc3_ = _loc3_.replace(/v=(\d+)/,"v=" + new Date().time.toString());
            (_loc7_ = new URLRequest(_loc3_)).method = URLRequestMethod.GET;
         }
         else
         {
            if(this.movie.privateShared || this.movie.published)
            {
               _loc6_["goemail"] = "goemail";
            }
            _loc6_["movieId"] = this.metaData.movieId;
            (_loc7_ = new URLRequest(_loc3_)).method = URLRequestMethod.POST;
            _loc7_.data = _loc6_;
         }
         ExternalInterface.call("exitStudio",this.movie.privateShared || this.movie.published ? "1" : "0");
         navigateToURL(_loc7_,"_self");
      }
      
      public function updateAssetTime(param1:String, param2:Number, param3:Number, param4:Number = -1, param5:Number = -1) : void
      {
         var _loc6_:Asset;
         if((_loc6_ = this.currentScene.getAssetById(param1)) is BubbleAsset)
         {
            (_loc6_ as BubbleAsset).sttime = param2;
            (_loc6_ as BubbleAsset).edtime = param3;
         }
         else if(_loc6_ is EffectAsset)
         {
            (_loc6_ as EffectAsset).sttime = param2;
            (_loc6_ as EffectAsset).edtime = param3;
            if((_loc6_.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase())
            {
               (_loc6_ as EffectAsset).stzoom = param4;
               (_loc6_ as EffectAsset).edzoom = param5;
            }
         }
         this.onUpdateAssetComplete();
      }
      
      private function onUpdateAssetComplete(param1:Event = null) : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.UPDATE_ASSET_COMPLETE,this));
      }
      
      public function set uploadedAssetXML(param1:XML) : void
      {
         this._uploadedAssetXML = param1;
      }
      
      public function customAssetUploadCompleteHandler(param1:String, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:XML = null;
         var _loc3_:String = param1.substr(0,1);
         if(_loc3_ == "0")
         {
            this._uploadType = param2;
            this._uploadedAssetXML = new XML(param1.substr(1));
            if(this._importer == null || !Boolean(this._importer["oldChar"]))
            {
               if(this._uploadedAssetXML.name() == "effect")
               {
                  _loc5_ = (_loc4_ = this._uploadedAssetXML.@id).split(".")[0];
                  this.addNewlyAddedAssetId(_loc5_);
                  this.getUserAssetById(this._uploadedAssetXML.@id);
               }
               else if(this._uploadedAssetXML.child("subtype") == "video")
               {
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.id);
                  this.buildVideoThumb(this._uploadedAssetXML);
                  UserStuffManager.instance.loadVideo();
               }
               else if(this._uploadedAssetXML.child("id").length() > 0)
               {
                  this._assetId = this._uploadedAssetXML.id;
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.id);
                  this.getUserAssetById(this._uploadedAssetXML.child("id")[0]);
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_TEMPLATE)
               {
                  this.buildTemplateThumb(this._uploadedAssetXML);
               }
               else
               {
                  this.addNewlyAddedAssetId(this._uploadedAssetXML.@id);
                  this.getUserAssetById(this._uploadedAssetXML.@id);
               }
            }
            else
            {
               this.getUserCharById(this._importer["charId"]);
            }
         }
         else
         {
            _loc6_ = "";
            try
            {
               _loc6_ = (_loc7_ = new XML(param1.substr(1))).child("code");
            }
            catch(e:Error)
            {
            }
            if(_loc6_ == ServerConstants.ERROR_CODE_UNSUPPORTED_IMAGE_FORMAT)
            {
               Alert.show("The image format is not supported.");
            }
            else
            {
               Alert.show("Error occur during the upload process. Let\'s try again later.","Checkcode " + _loc3_);
            }
         }
      }
      
      private function buildTemplateThumb(param1:String) : void
      {
         var _loc2_:TemplateThumb = new TemplateThumb();
         _loc2_.id = _loc2_.aid = param1;
         _loc2_.theme = ThemeManager.instance.movieTheme;
         _loc2_.enable = true;
         _loc2_.numScene = !!this._currSceneOnlyForTemp ? 1 : int(this.scenes.length);
         ThemeManager.instance.userTheme.addThumb(_loc2_);
         var _loc3_:BitmapData = Console.getConsole().getThumbnailCaptureBySceneIndex(this.selectedThumbForTempIndex);
         var _loc5_:ByteArray;
         var _loc4_:PNGEncoder;
         (_loc5_ = (_loc4_ = new PNGEncoder()).encode(_loc3_)).position = 0;
         _loc2_.thumbImageData = _loc5_;
         ThemeManager.instance.lastLoaddedTheme.clearAllThumbs();
         ThemeManager.instance.lastLoaddedTheme.addThumb(_loc2_);
         this._thumbTray.loadThumbs(ThemeManager.instance.lastLoaddedTheme,false,this._thumbTray._uiTileTemplateMovie,true);
      }
      
      private function buildVideoThumb(param1:XML) : void
      {
         var _loc5_:ThumbnailCanvas = null;
         this._holdable = false;
         this._headable = false;
         this._placeable = true;
         var _loc2_:VideoPropThumb = new VideoPropThumb();
         _loc2_.id = this._uploadedAssetXML.file;
         _loc2_.name = this._uploadedAssetXML.title;
         _loc2_.theme = ThemeManager.instance.userTheme;
         VideoPropThumb(_loc2_).subType = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
         VideoPropThumb(_loc2_).placeable = true;
         VideoPropThumb(_loc2_).holdable = false;
         VideoPropThumb(_loc2_).headable = false;
         VideoPropThumb(_loc2_).facing = AnimeConstants.FACING_LEFT;
         _loc2_.enable = true;
         _loc2_.tags = this._uploadedAssetXML.tags;
         _loc2_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
         _loc2_.videoHeight = Number(this._uploadedAssetXML.height);
         _loc2_.videoWidth = Number(this._uploadedAssetXML.width);
         ThemeManager.instance.userTheme.addThumb(_loc2_,UtilXmlInfo.convertUploadedAssetXmlToThumbXml(param1));
         var _loc3_:Image = new Image();
         var _loc4_:DisplayObject = VideoPropThumb(_loc2_).loadThumbnail();
         _loc3_.addChild(_loc4_);
         _loc5_ = new ThumbnailCanvas(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT,_loc3_,_loc2_,true,false,this._purchaseEnabled,"",true,0,false,true);
         _loc5_.name = _loc5_.toolTip = _loc2_.name;
         this.thumbTray._uiTileVideoPropUser.addChild(_loc5_);
         if(this._importer != null)
         {
            this._importer["success"]();
            this.currentScene.playScene();
         }
      }
      
      public function getUserCharById(param1:String) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         if(param1 != null && StringUtil.trim(param1).length > 0)
         {
            _loc2_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc2_);
            if(_loc2_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
            {
               delete _loc2_[ServerConstants.PARAM_ASSET_ID];
            }
            _loc2_[ServerConstants.PARAM_ASSET_ID] = param1;
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_CHAR);
            _loc3_.method = URLRequestMethod.POST;
            _loc3_.data = _loc2_;
            (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this.onGetCustomCharComplete);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCustomCharComplete);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCustomCharComplete);
            _loc4_.load(_loc3_);
            return;
         }
         throw new Error("Invalid Id to get the asset");
      }
      
      public function onGetCustomCharComplete(param1:Event) : void
      {
         var _loc2_:URLStream = null;
         var _loc3_:Thumb = null;
         var _loc4_:ZipFile = null;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc7_:CharThumb = null;
         if(param1.type != Event.COMPLETE)
         {
            if(this._importer != null)
            {
               this._importer["error"](null);
            }
         }
         else
         {
            _loc2_ = URLStream(param1.target);
            _loc4_ = new ZipFile(_loc2_);
            _loc5_ = new XML(_loc4_.getInput(_loc4_.getEntry("desc.xml")));
            _loc6_ = this._importer["charId"];
            ThemeManager.instance.userTheme.setThumbNodeFromXML(_loc5_,_loc6_);
            ThemeManager.instance.lastLoaddedTheme.setThumbNodeFromXML(_loc5_,_loc6_);
            if((_loc7_ = ThemeManager.instance.lastLoaddedTheme.getCharThumbById(_loc6_)) != null)
            {
               _loc7_.deSerialize(_loc5_,ThemeManager.instance.lastLoaddedTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            if((_loc7_ = ThemeManager.instance.userTheme.getCharThumbById(_loc6_)) != null)
            {
               _loc7_.deSerialize(_loc5_,ThemeManager.instance.userTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            if(ThemeManager.instance.getTheme("ugc") != null)
            {
               _loc7_ = ThemeManager.instance.getTheme("ugc").getCharThumbById(_loc6_);
            }
            else
            {
               _loc7_ = null;
            }
            if(_loc7_ != null)
            {
               _loc7_.deSerialize(_loc5_,ThemeManager.instance.userTheme);
               _loc7_.initImageData(_loc4_,_loc7_.getFolderPathInCharZip());
            }
            this._importer["success"]();
         }
      }
      
      public function getUserAssetById(param1:String) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLStream = null;
         if(param1 != null && StringUtil.trim(param1).length > 0)
         {
            this._assetId = Number(param1);
            _loc2_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc2_);
            if(_loc2_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
            {
               delete _loc2_[ServerConstants.PARAM_ASSET_ID];
            }
            _loc2_[ServerConstants.PARAM_ASSET_ID] = param1;
            _loc3_ = new URLRequest(ServerConstants.ACTION_GET_ASSET);
            _loc3_.method = URLRequestMethod.POST;
            _loc3_.data = _loc2_;
            (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this.onGetCustomAssetComplete);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCustomAssetComplete);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCustomAssetComplete);
            _loc4_.load(_loc3_);
            return;
         }
         throw new Error("Invalid Id to get the asset");
      }
      
      public function onGetCustomAssetCompleteByte(param1:ByteArray, param2:XML, param3:Boolean, param4:Boolean = true) : SoundThumb
      {
         var sThumb:SoundThumb = null;
         var byte:ByteArray = param1;
         var my:XML = param2;
         var add:Boolean = param3;
         var switchTray:Boolean = param4;
         sThumb = new SoundThumb();
         this._uploadedAssetXML = my;
         sThumb.deSerializeByUserAssetXML(this._uploadedAssetXML,ThemeManager.instance.userTheme);
         sThumb.enable = true;
         sThumb.addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,function():void
         {
            if(thumbTray.userAssetType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               thumbTray.addSoundTileCell(sThumb);
               addNewlyAddedAssetId(_uploadedAssetXML.id);
            }
            if(_importer != null)
            {
               _importer["onLoadAssetCompleteHandler"](null);
            }
            if(switchTray)
            {
               thumbTray.gotoSpecifiedTabInMyGoodies("voiceover");
            }
            if(add)
            {
               _console.createAsset(sThumb);
            }
         });
         sThumb.initSoundByByteArray(byte);
         return sThumb;
      }
      
      private function onGetCustomAssetComplete(param1:Event) : void
      {
         var _loc2_:URLStream = null;
         var _loc3_:ByteArray = null;
         var _loc4_:Thumb = null;
         var _loc5_:XML = null;
         var _loc6_:SoundThumb = null;
         var _loc7_:EffectThumb = null;
         var _loc8_:SuperEffect = null;
         var _loc9_:DisplayObject = null;
         var _loc10_:Image = null;
         var _loc11_:Loader = null;
         var _loc12_:Image = null;
         if(param1.type != Event.COMPLETE)
         {
            if(this._importer != null)
            {
               this._importer["error"]();
            }
         }
         else
         {
            _loc2_ = URLStream(param1.target);
            _loc3_ = new ByteArray();
            _loc2_.readBytes(_loc3_);
            if(param1.type != Event.COMPLETE)
            {
               Alert.show("error message: \n" + _loc3_.toString());
               if(this._importer != null)
               {
                  this._importer["error"](null);
               }
               throw new Error("load asset by id failed.");
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_BG)
            {
               this._placeable = true;
               _loc4_ = new BackgroundThumb();
               _loc4_.id = _loc4_.thumbId = this._uploadedAssetXML.file;
               _loc4_.name = this._uploadedAssetXML.title;
               _loc4_.tags = this._uploadedAssetXML.tags;
               _loc4_.setFileName("bg/" + this._uploadedAssetXML.file);
               _loc4_.theme = ThemeManager.instance.userTheme;
               _loc4_.imageData = _loc4_.thumbImageData = _loc3_;
               _loc4_.enable = true;
               _loc4_.tags = this._uploadedAssetXML.tags;
               _loc4_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
               ThemeManager.instance.userTheme.backgroundThumbs.push(_loc4_.id,_loc4_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
            {
               this._holdable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR ? true : false;
               this._headable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD ? true : false;
               this._placeable = true;
               (_loc4_ = new PropThumb()).id = this._uploadedAssetXML.file;
               _loc4_.name = this._uploadedAssetXML.title;
               _loc4_.theme = ThemeManager.instance.userTheme;
               _loc4_.imageData = _loc3_;
               PropThumb(_loc4_).placeable = true;
               PropThumb(_loc4_).holdable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR ? true : false;
               PropThumb(_loc4_).headable = this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD ? true : false;
               PropThumb(_loc4_).facing = AnimeConstants.FACING_LEFT;
               _loc4_.enable = true;
               _loc4_.tags = this._uploadedAssetXML.tags;
               _loc4_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
               ThemeManager.instance.userTheme.propThumbs.push(_loc4_.id,_loc4_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               this._placeable = true;
               _loc5_ = new XML("<theme>" + this._uploadedAssetXML.toString() + "</theme>");
               if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  ((_loc4_ = new CharThumb()) as CharThumb).deSerialize(this._uploadedAssetXML,ThemeManager.instance.userTheme);
                  (_loc4_ as CharThumb).imageData = _loc3_;
                  (_loc4_ as CharThumb).name = this._uploadedAssetXML.@name;
                  ThemeManager.instance.userTheme.mergeThemeXML(_loc5_);
               }
               else
               {
                  (_loc4_ = new EffectThumb()).imageData = _loc3_;
                  _loc4_.deSerialize(this._uploadedAssetXML,ThemeManager.instance.userTheme);
                  ThemeManager.instance.userTheme.mergeThemeXML(_loc5_);
               }
               if(Boolean(this._importer["oldChar"]))
               {
                  this._importer["success"]();
                  return;
               }
               if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  ThemeManager.instance.getTheme("ugc").charThumbs.push(_loc4_.id,_loc4_);
                  ThemeManager.instance.userTheme.charThumbs.push(_loc4_.id,_loc4_);
               }
               else
               {
                  ThemeManager.instance.userTheme.effectThumbs.push(_loc4_.id,_loc4_);
               }
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               (_loc6_ = new SoundThumb()).deSerializeByUserAssetXML(this._uploadedAssetXML,ThemeManager.instance.userTheme);
               (_loc4_ = _loc6_).enable = true;
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               (_loc4_ as SoundThumb).addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,this.onLoadCustomAssetImageComplete);
               (_loc4_ as SoundThumb).initSoundByByteArray(_loc3_);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               (_loc8_ = (_loc7_ = _loc4_ as EffectThumb).getNewEffect()).addEventListener(EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE,this.onLoadCustomAssetImageComplete);
               _loc9_ = _loc8_.loadThumbnail(_loc7_.imageData as ByteArray);
               (_loc10_ = new Image()).addChild(_loc9_);
               _loc10_.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.doDrag);
            }
            else
            {
               (_loc11_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadCustomAssetImageComplete);
               _loc11_.loadBytes(_loc3_);
               _loc11_.name = "imageLoader";
               (_loc12_ = new Image()).addChild(_loc11_);
               _loc12_.addEventListener(MouseEvent.MOUSE_DOWN,_loc4_.doDrag);
            }
         }
      }
      
      private function onLoadCustomAssetImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:Image = null;
         var _loc4_:Thumb = null;
         var _loc6_:ThumbnailCanvas = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Rectangle = null;
         var _loc13_:DisplayObject = null;
         var _loc14_:Image = null;
         var _loc15_:String = null;
         var _loc16_:DisplayObject = null;
         var _loc17_:BitmapData = null;
         var _loc18_:Bitmap = null;
         var _loc19_:SoundThumb = null;
         var _loc5_:String = "cellUserProp";
         if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
         {
            _loc2_ = param1.target.loader;
            if(!(_loc2_.content is MovieClip) && !(_loc2_.content is AVM1Movie))
            {
               _loc5_ = String(this._assetId);
               this.thumbTray.popMaskImage(_loc2_.content,this._assetId,this._placeable,this._holdable,this._headable);
            }
         }
         if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_FX)
         {
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc2_ = param1.target.loader;
               _loc16_ = _loc2_.content;
               _loc3_ = Image(_loc2_.parent);
               _loc4_ = ThemeManager.instance.userTheme.getCharThumbById(this._uploadedAssetXML.@id);
               CharThumb(_loc4_).facing = AnimeConstants.FACING_LEFT;
               (_loc4_ as CharThumb).deSerialize(this._uploadedAssetXML,ThemeManager.instance.userTheme);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc3_ = (_loc16_ = (param1 as EffectEvt).thumbnail).parent as Image;
               ((_loc4_ = new EffectThumb()) as EffectThumb).deSerialize(this._uploadedAssetXML,ThemeManager.instance.userTheme);
            }
            _loc4_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
            _loc4_.theme = ThemeManager.instance.userTheme;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
               _loc10_ = AnimeConstants.TILE_CHAR_WIDTH - AnimeConstants.TILE_INSETS * 2;
               _loc11_ = AnimeConstants.TILE_CHAR_HEIGHT - AnimeConstants.TILE_INSETS * 2;
               this.thumbTray._uiTileCharUser.addChildAt(_loc6_,0);
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_BUBBLE_WIDTH,AnimeConstants.TILE_BUBBLE_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
               _loc10_ = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
               _loc11_ = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
               this.thumbTray._uiTileEffectUser.addChildAt(_loc6_,0);
            }
            _loc6_.name = _loc5_;
            _loc7_ = _loc16_.width;
            _loc8_ = _loc16_.height;
            _loc9_ = 1;
            if(!(_loc7_ <= _loc10_ && _loc8_ <= _loc11_))
            {
               if(_loc7_ > _loc10_ && _loc8_ <= _loc11_)
               {
                  _loc9_ = _loc10_ / _loc7_;
                  _loc16_.width = _loc10_;
                  _loc16_.height *= _loc9_;
               }
               else if(_loc7_ <= _loc10_ && _loc8_ > _loc11_)
               {
                  _loc9_ = _loc11_ / _loc8_;
                  _loc16_.width *= _loc9_;
                  _loc16_.height = _loc11_;
               }
               else
               {
                  _loc9_ = _loc10_ / _loc7_;
                  if(_loc8_ * _loc9_ > _loc11_)
                  {
                     _loc9_ = _loc11_ / _loc8_;
                     _loc16_.width *= _loc9_;
                     _loc16_.height = _loc11_;
                  }
                  else
                  {
                     _loc16_.width = _loc10_;
                     _loc16_.height *= _loc9_;
                  }
               }
            }
            if(this._uploadType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               _loc12_ = _loc2_.getBounds(_loc2_);
               _loc16_.x = (AnimeConstants.TILE_CHAR_WIDTH - _loc16_.width) / 2;
               _loc16_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc16_.height) / 2;
            }
            else if(this._uploadType == AnimeConstants.ASSET_TYPE_FX)
            {
               _loc12_ = _loc16_.getBounds(_loc16_);
               _loc16_.x = (AnimeConstants.TILE_BUBBLE_WIDTH - _loc16_.width) / 2;
               _loc16_.y = (AnimeConstants.TILE_BUBBLE_HEIGHT - _loc16_.height) / 2;
            }
            _loc16_.x -= _loc12_.left;
            _loc16_.y -= _loc12_.top;
            _loc13_ = DisplayObject(_loc16_);
            UtilPlain.stopFamily(_loc13_);
            (_loc14_ = _loc3_).graphics.beginFill(0,0);
            _loc14_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc14_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc2_ = param1.target.loader;
            _loc3_ = Image(_loc2_.parent);
            _loc17_ = Util.capturePicture(_loc2_,new Rectangle(0,0,_loc2_.width,_loc2_.height));
            (_loc18_ = new Bitmap(_loc17_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc18_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
            _loc3_.removeChild(_loc3_.getChildByName("imageLoader"));
            _loc3_.addChild(_loc18_);
            _loc4_ = new BackgroundThumb();
            _loc4_.id = _loc4_.thumbId = this._uploadedAssetXML.file;
            _loc4_.name = this._uploadedAssetXML.title;
            _loc4_.tags = this._uploadedAssetXML.tags;
            _loc4_.setFileName("bg/" + this._uploadedAssetXML.file);
            _loc4_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
            _loc4_.theme = ThemeManager.instance.userTheme;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            _loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled);
            this.thumbTray._uiTileBgUser.addChildAt(_loc6_,0);
            _loc18_.x = AnimeConstants.TILE_INSETS;
            _loc18_.y = AnimeConstants.TILE_INSETS;
            _loc3_.graphics.beginFill(0,0);
            _loc3_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc3_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HEAD || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || this._uploadType == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
         {
            _loc3_ = Image(_loc2_.parent);
            (_loc4_ = new PropThumb()).id = this._uploadedAssetXML.file;
            _loc4_.name = this._uploadedAssetXML.title;
            _loc4_.tags = this._uploadedAssetXML.tags;
            _loc4_.isPublished = this._uploadedAssetXML.published == "1" ? true : false;
            _loc4_.theme = ThemeManager.instance.userTheme;
            PropThumb(_loc4_).placeable = this._placeable;
            PropThumb(_loc4_).holdable = this._holdable;
            PropThumb(_loc4_).headable = this._headable;
            PropThumb(_loc4_).facing = AnimeConstants.FACING_LEFT;
            _loc4_.enable = true;
            _loc3_.toolTip = _loc4_.name;
            (_loc6_ = new ThumbnailCanvas(AnimeConstants.TILE_PROP_WIDTH,AnimeConstants.TILE_PROP_HEIGHT,_loc3_,_loc4_,true,false,this._purchaseEnabled)).name = _loc5_;
            this.thumbTray._uiTilePropUser.addChildAt(_loc6_,0);
            _loc7_ = _loc2_.content.width;
            _loc8_ = _loc2_.content.height;
            _loc9_ = 1;
            _loc10_ = AnimeConstants.TILE_PROP_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc11_ = AnimeConstants.TILE_PROP_HEIGHT - AnimeConstants.TILE_INSETS * 2;
            if(!(_loc7_ <= _loc10_ && _loc8_ <= _loc11_))
            {
               if(_loc7_ > _loc10_ && _loc8_ <= _loc11_)
               {
                  _loc9_ = _loc10_ / _loc7_;
                  _loc2_.content.width = _loc10_;
                  _loc2_.content.height *= _loc9_;
               }
               else if(_loc7_ <= _loc10_ && _loc8_ > _loc11_)
               {
                  _loc9_ = _loc11_ / _loc8_;
                  _loc2_.content.width *= _loc9_;
                  _loc2_.content.height = _loc11_;
               }
               else
               {
                  _loc9_ = _loc10_ / _loc7_;
                  if(_loc8_ * _loc9_ > _loc11_)
                  {
                     _loc9_ = _loc11_ / _loc8_;
                     _loc2_.content.width *= _loc9_;
                     _loc2_.content.height = _loc11_;
                  }
                  else
                  {
                     _loc2_.content.width = _loc10_;
                     _loc2_.content.height *= _loc9_;
                  }
               }
            }
            _loc12_ = _loc2_.getBounds(_loc2_);
            _loc2_.x = (AnimeConstants.TILE_PROP_WIDTH - _loc2_.content.width) / 2;
            _loc2_.y = (AnimeConstants.TILE_PROP_HEIGHT - _loc2_.content.height) / 2;
            _loc2_.x -= _loc12_.left;
            _loc2_.y -= _loc12_.top;
            if(_loc2_.content is MovieClip)
            {
               _loc13_ = DisplayObject(_loc2_.content);
               UtilPlain.stopFamily(_loc13_);
            }
            (_loc14_ = Image(_loc2_.parent)).graphics.beginFill(0,0);
            _loc14_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
            _loc14_.graphics.endFill();
         }
         else if(this._uploadType == AnimeConstants.ASSET_TYPE_SOUND)
         {
            _loc19_ = (param1 as CoreEvent).getEventCreater() as SoundThumb;
            this.thumbTray.addSoundTileCell(_loc19_,false);
            this.thumbTray.uploadedSoundThumb = _loc19_;
            _loc15_ = _loc19_.subType;
         }
         if(this._importer != null)
         {
            this._importer["success"]();
            if(this._uploadType != AnimeConstants.ASSET_TYPE_UNKNOWN)
            {
               this._thumbTray.showUserGoodies(this._uploadType,_loc15_);
            }
            this._thumbTray.show();
            this.currentScene.playScene();
         }
         else if(_loc19_ != null)
         {
            this.publishW.success(_loc19_);
         }
         this.requestLoadStatus(false,true);
      }
      
      private function playArgSound(param1:TutorialEvent) : void
      {
         var _loc2_:AnimeSound = param1.data as AnimeSound;
         SoundPlaybackManager.playSoundThumb(_loc2_.soundThumb,0,_loc2_.soundContainer);
      }
      
      public function addSoundThumbAtScene(param1:SoundThumb, param2:AnimeScene) : void
      {
         var _loc7_:IFlexDisplayObject = null;
         var _loc3_:int = this.getSceneIndex(param2);
         var _loc4_:Point;
         if((_loc4_ = this.timeline.getEarliestSoundSpace(_loc3_)).x == -999)
         {
            (_loc7_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,GoPopUp,true)).width = 500;
            _loc7_.y = 100;
            _loc7_.x = (_loc7_.stage.width - _loc7_.width) / 2;
            GoPopUp(_loc7_).text = UtilDict.toDisplay("go","timeline_soundexceed");
            return;
         }
         var _loc5_:Number = UtilUnitConvert.xToFrame(_loc4_.x);
         var _loc6_:int = SoundTrackArea.pixelToTrack(_loc4_.y);
         this.addSoundThumbAt(param1,_loc5_,_loc6_);
      }
      
      public function addSoundThumbAt(param1:SoundThumb, param2:Number, param3:int) : void
      {
         var _loc6_:AnimeSound = null;
         var _loc7_:Number = NaN;
         var _loc8_:ICommand = null;
         var _loc9_:UtilLoadMgr = null;
         var _loc10_:Array = null;
         param2 = StudioSoundManager.validateStartFrame(param2);
         param3 = StudioSoundManager.validateTrack(param3);
         if(StudioSoundManager.getSoundAtFrameOnTrack(this.sounds,param2,param3) != null)
         {
            return;
         }
         var _loc4_:AnimeSound;
         if((_loc4_ = StudioSoundManager.getLastSoundBeforeFrameOnTrack(this.sounds,param2,param3)) && _loc4_.endFrame + AnimeConstants.SOUND_FRAME_INTERVAL >= param2)
         {
            return;
         }
         var _loc5_:AnimeSound;
         if((_loc5_ = StudioSoundManager.getFirstSoundAfterFrameOnTrack(this.sounds,param2,param3)) && _loc5_.startFrame - AnimeConstants.SOUND_FRAME_INTERVAL - AnimeConstants.SOUND_FRAME_MINIMUM < param2)
         {
            return;
         }
         if(param1.sound && param1.sound.isReady && param1.lengthFrame != -1)
         {
            _loc6_ = StudioSoundFactory.createSound(param1);
            _loc7_ = param2 + param1.lengthFrame - 1;
            _loc6_.init(param1,param2,_loc7_,null,param3);
            (_loc8_ = new AddSoundCommand(_loc6_)).execute();
            if(this.sounds.length == 1 && !this.goWalker.hasSoundGuideShown)
            {
               SoundPlaybackManager.stop();
               this.goWalker.addEventListener(TutorialEvent.TUTORIAL_DONE,this.playArgSound);
               this.goWalker.startSoundTutorial(this.timeline,_loc6_);
            }
            else
            {
               SoundPlaybackManager.playSoundThumb(param1,0,_loc6_.soundContainer);
            }
         }
         else
         {
            _loc9_ = new UtilLoadMgr();
            (_loc10_ = new Array()).push(param1);
            _loc10_.push(param2);
            _loc10_.push(param3);
            _loc9_.setExtraData(_loc10_);
            _loc9_.addEventDispatcher(param1.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc9_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doAddSoundAtSceneAgain);
            _loc9_.commit();
            param1.initSoundFromNetwork();
         }
      }
      
      private function doAddSoundAtSceneAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:SoundThumb = _loc3_[0] as SoundThumb;
         var _loc5_:Number = _loc3_[1] as Number;
         var _loc6_:int = _loc3_[2] as int;
         this.addSoundThumbAt(_loc4_,_loc5_,_loc6_);
      }
      
      public function addSound(param1:AnimeSound) : void
      {
         var _loc2_:AnimeSound = null;
         var _loc3_:Object = null;
         var _loc4_:SoundEvent = null;
         if(param1)
         {
            _loc2_ = StudioSoundManager.getFirstSoundAfterFrameOnTrack(this.sounds,param1.startFrame,param1.trackNum);
            if(_loc2_)
            {
               param1.endFrame = Math.min(param1.endFrame,_loc2_.startFrame - AnimeConstants.SOUND_FRAME_INTERVAL - 1);
            }
            this._sounds.addSound(param1);
            this.timeline.addSound(param1);
            _loc3_ = new Object();
            _loc3_["id"] = param1.getID();
            _loc4_ = new SoundEvent(SoundEvent.ADDED,this,_loc3_);
            this.dispatchEvent(_loc4_);
         }
      }
      
      public function showSoundMenu(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:AnimeSound;
         (_loc4_ = this.sounds.getSoundById(param1) as AnimeSound).showMenu(param2,param3);
      }
      
      public function getSoundInfoById(param1:String) : ElementInfo
      {
         return this.timeline.getSoundInfoById(param1);
      }
      
      public function removeSound(param1:String) : void
      {
         this.sounds.removeSoundById(param1);
         this.timeline.removeSoundById(param1);
         this.linkageController.deleteLinkageById(param1);
      }
      
      public function removeAllSounds() : void
      {
         this.sounds.removeAll();
         this.timeline.removeAllSounds();
      }
      
      public function stopAllSounds() : void
      {
         SoundPlaybackManager.stop();
      }
      
      public function addStoreCollection(param1:String) : void
      {
         var _loc2_:String = null;
         if(this.storecollection.indexOf(param1) == -1)
         {
            _loc2_ = param1.replace(/\W/g,"_");
            this.storecollection.push(_loc2_);
         }
      }
      
      public function getStoreCollection() : Array
      {
         return this.storecollection;
      }
      
      public function loadAllThemes() : void
      {
         var themeId:String = null;
         var theme:Theme = null;
         var node:XML = null;
         var i:Number = 0;
         while(i < this.themeListXML.child("theme").length())
         {
            node = this.themeListXML.child("theme")[i];
            themeId = String(node.@id);
            if(!UtilLicense.isThemeBlocked(themeId,UtilLicense.getCurrentLicenseId()))
            {
               if(themeId != "common")
               {
                  theme = ThemeManager.instance.getTheme(themeId);
                  if(theme == null)
                  {
                     theme = new Theme();
                     theme.id = themeId;
                     theme.modifyPremiumContent(this._purchasedAssetsXML.(@theme == themeId));
                     ThemeManager.instance.addTheme(themeId,theme);
                  }
                  theme.initThemeByLoadThemeFile(this,themeId);
               }
            }
            i++;
         }
      }
      
      public function loadTheme(param1:String) : void
      {
         var targetTheme:Theme = null;
         var id:String = param1;
         StudioStatusManager.instance.status = "Loading theme...";
         this.requestLoadStatus(true,true);
         var needLoad:Boolean = true;
         Util.gaTracking("/gostudio/themes/loading/" + id,Console.getConsole().mainStage.stage);
         targetTheme = ThemeManager.instance.getTheme(id);
         if(targetTheme == null)
         {
            targetTheme = new Theme();
            targetTheme.id = id;
            targetTheme.modifyPremiumContent(this._purchasedAssetsXML.(@theme == id));
         }
         if(this.isThemeCcRelated(id))
         {
            UserStuffManager.instance.reset();
         }
         this._isLoaddingCommonTheme = false;
         targetTheme.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.LoadThemeComplete);
         targetTheme.initThemeByLoadThemeFile(this,id);
      }
      
      public function loadCommonTheme(param1:Boolean = false) : void
      {
         var commonTheme:Theme = null;
         var setAsCurrentTheme:Boolean = param1;
         Util.gaTracking("/gostudio/themes/loading/common",Console.getConsole().mainStage.stage);
         commonTheme = ThemeManager.instance.getTheme("common");
         if(commonTheme == null)
         {
            commonTheme = new Theme();
            commonTheme.id = "common";
            if(this._purchasedAssetsXML != null)
            {
               commonTheme.modifyPremiumContent(this._purchasedAssetsXML.(@theme == "common"));
            }
         }
         if(setAsCurrentTheme)
         {
            ThemeManager.instance.currentTheme = commonTheme;
         }
         this._isLoaddingCommonTheme = true;
         commonTheme.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.LoadThemeComplete);
         commonTheme.initThemeByLoadThemeFile(this,"common");
      }
      
      private function LoadThemeComplete(param1:CoreEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.LoadThemeComplete);
         StudioStatusManager.instance.status = "Theme loaded.";
         var _loc2_:Theme = param1.getEventCreater() as Theme;
         this.doUpdateThumbTray(_loc2_);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this,_loc2_));
         Util.gaTracking("/gostudio/themes/complete/" + _loc2_.id,Console.getConsole().mainStage.stage);
      }
      
      public function loadThemeBg(param1:String) : void
      {
         var _loc2_:Theme = null;
         _loc2_ = ThemeManager.instance.getTheme(param1);
         if(_loc2_ == null)
         {
         }
         if(_loc2_.isBgZipLoaded())
         {
            Util.gaTracking("/gostudio/CommonTheme/loaded/backgrounds",Console.getConsole().mainStage.stage);
            return;
         }
         Util.gaTracking("/gostudio/CommonTheme/loading/backgrounds",Console.getConsole().mainStage.stage);
         this._isLoaddingCommonThemeBg = false;
         _loc2_.addEventListener(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this.loadThemeBgComplete);
         _loc2_.loadBg();
      }
      
      public function loadCommonThemeBg() : void
      {
         var _loc1_:Theme = null;
         _loc1_ = ThemeManager.instance.getTheme("common");
         if(_loc1_ == null)
         {
         }
         if(_loc1_.isBgZipLoaded())
         {
            this.thumbTray.loadBackgroundThumbs(_loc1_,new UtilLoadMgr());
            return;
         }
         this._isLoaddingCommonThemeBg = true;
         _loc1_.addEventListener(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this.loadThemeBgComplete);
         _loc1_.loadBg();
      }
      
      private function loadThemeBgComplete(param1:CoreEvent) : void
      {
         var _loc2_:Theme = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadThemeBgComplete);
         _loc2_ = param1.getEventCreater() as Theme;
         this.thumbTray.loadBackgroundThumbs(_loc2_,new UtilLoadMgr());
         if(!this.isLoaddingCommonThemeBg && _loc2_.isBgZipLoaded())
         {
            this.loadCommonThemeBg();
         }
         else
         {
            Util.gaTracking("/gostudio/CommonTheme/complete/bg",Console.getConsole().mainStage.stage);
         }
      }
      
      public function loadThemeProp(param1:String) : void
      {
         var _loc2_:Theme = null;
         _loc2_ = ThemeManager.instance.getTheme(param1);
         if(_loc2_ == null)
         {
         }
         if(_loc2_.isPropZipLoaded())
         {
            Util.gaTracking("/gostudio/CommonTheme/loaded/props",Console.getConsole().mainStage.stage);
            return;
         }
         Util.gaTracking("/gostudio/CommonTheme/loading/props",Console.getConsole().mainStage.stage);
         this._isLoaddingCommonThemeProp = false;
         _loc2_.addEventListener(CoreEvent.LOAD_THEME_PROP_COMPLETE,this.loadThemePropComplete);
         _loc2_.loadProp();
      }
      
      public function loadCommonThemeProp() : void
      {
         var _loc1_:Theme = null;
         _loc1_ = ThemeManager.instance.getTheme("common");
         if(_loc1_ == null)
         {
         }
         if(_loc1_.isPropZipLoaded())
         {
            this.thumbTray.loadPropThumbs(_loc1_,new UtilLoadMgr());
            return;
         }
         this._isLoaddingCommonThemeProp = true;
         _loc1_.addEventListener(CoreEvent.LOAD_THEME_PROP_COMPLETE,this.loadThemePropComplete);
         _loc1_.loadProp();
      }
      
      private function loadThemePropComplete(param1:CoreEvent) : void
      {
         var _loc2_:Theme = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadThemePropComplete);
         _loc2_ = param1.getEventCreater() as Theme;
         this.thumbTray.loadPropThumbs(_loc2_,new UtilLoadMgr());
         if(!this.isLoaddingCommonThemeProp)
         {
            this.loadCommonThemeProp();
         }
         else
         {
            Util.gaTracking("/gostudio/CommonTheme/complete/prop",Console.getConsole().mainStage.stage);
         }
      }
      
      private function reloadAllCC(param1:String) : void
      {
         if(this._isStudioReady)
         {
            UserStuffManager.instance.addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.thumbTray.doLoadSingleCcCharThumb);
            UserStuffManager.instance.loadSingleCcChar(param1);
         }
      }
      
      private function doUpdateThumbTray(param1:Theme) : void
      {
         ThemeManager.instance.addTheme(param1.id,param1);
         if(param1.id != "common")
         {
            ThemeManager.instance.currentTheme = param1;
            this._thumbTray.themeId = param1.id;
         }
         else
         {
            this._isCommonThemeLoadded = true;
         }
         this._thumbTray.loadThumbs(param1);
      }
      
      public function requestLoadStatus(param1:Boolean, param2:Boolean = false, param3:Number = 1) : void
      {
         if(StudioStatusManager.instance.setBusy(param1,param3))
         {
            this._topButtonBar.setLoadingStatus(param1);
            this._mainStage.setLoadingStatus(param1,true);
            this._timeline.setLoadingStatus(param1);
            this._thumbTray.setLoadingStatus(param1);
            this.pptPanel.setLoadingStatus(param1);
         }
      }
      
      private function loadThemeList(param1:Number = 0) : void
      {
         this.requestLoadStatus(true,true);
         this.loadProgress = 0;
         var _loc2_:URLRequest = UtilNetwork.getGetThemeListRequest();
         (_loc2_.data as URLVariables)["siteId"] = this._siteId;
         (_loc2_.data as URLVariables)["xclZip"] = param1;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc3_.addEventListener(Event.COMPLETE,this.onLoadThemeListComplete);
         _loc3_.addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadThemeListFailed);
         _loc3_.load(_loc2_);
      }
      
      private function onLoadThemeListFailed(param1:IOErrorEvent) : void
      {
         Alert.show("Error: Load theme list failed!");
      }
      
      private function onLoadThemeListComplete(param1:Event) : void
      {
         var urlLoader:URLLoader = null;
         var zip:ZipFile = null;
         var themeListXML:XML = null;
         var defaultZipEntry:ZipEntry = null;
         var commonZipEntry:ZipEntry = null;
         var BAD_TERMS_XML_NODE_NAME:String = null;
         var GOOD_TERMS_XML_NODE_NAME:String = null;
         var excludeAssetIds:Array = null;
         var aid:String = null;
         var node:XML = null;
         var i:int = 0;
         var j:int = 0;
         var ts:XMLList = null;
         var group:Group = null;
         var event:Event = param1;
         this.requestLoadStatus(false,true);
         if(Util.isDebugMode)
         {
            Alert.show("load theme list complete ");
         }
         try
         {
            urlLoader = event.target as URLLoader;
            zip = new ZipFile(urlLoader.data as ByteArray);
            themeListXML = new XML(zip.getInput(zip.getEntry("themelist.xml")).toString());
            ThemeEmbedConstant.defaultThemeId = themeListXML.child("theme")[0].attribute("id");
            this.currentLicensorName = themeListXML.child("theme")[0].attribute("name");
            defaultZipEntry = zip.getEntry(ThemeEmbedConstant.defaultThemeId + ".zip");
            if(defaultZipEntry != null)
            {
               ThemeEmbedConstant.defaultThemeZip = zip.getInput(defaultZipEntry);
            }
            commonZipEntry = zip.getEntry("common.zip");
            if(commonZipEntry != null)
            {
               ThemeEmbedConstant.commonThemeZip = zip.getInput(commonZipEntry);
            }
            BAD_TERMS_XML_NODE_NAME = "word";
            GOOD_TERMS_XML_NODE_NAME = "whiteword";
            if(themeListXML.child(BAD_TERMS_XML_NODE_NAME).length() > 0 && Util.getFlashVar().getValueByKey("hb") == "1")
            {
               this.setBadTerms(themeListXML.child(BAD_TERMS_XML_NODE_NAME)[0].toString());
               this.setWhiteTerms(themeListXML.child(GOOD_TERMS_XML_NODE_NAME)[0].toString());
            }
            else
            {
               this.setBadTerms("");
               this.setWhiteTerms("");
            }
            excludeAssetIds = String(themeListXML.excludeAssetIDs).split(",");
            this.excludedIds = new UtilHashArray();
            for each(aid in excludeAssetIds)
            {
               aid = StringUtil.trim(aid);
               if(aid != "")
               {
                  this.excludedIds.push(aid,aid);
               }
            }
            if(this._purchaseEnabled)
            {
               this._purchasedAssetsXML = themeListXML.child("premium");
               ts = themeListXML.child("points");
               if(ts.length() > 0)
               {
                  UtilUser.goBuck = themeListXML.child("points")[0].@money;
                  UtilUser.goPoint = themeListXML.child("points")[0].@sharing;
               }
               if(this._purchasedAssetsXML.length() != 0)
               {
                  ThemeManager.instance.userTheme.modifyPremiumContent(this._purchasedAssetsXML);
                  ThemeManager.instance.lastLoaddedTheme.modifyPremiumContent(this._purchasedAssetsXML);
                  ThemeManager.instance.searchedTheme.modifyPremiumContent(this._purchasedAssetsXML);
               }
               else
               {
                  this._purchasedAssetsXML = new XMLList();
               }
            }
            else
            {
               this._purchasedAssetsXML = new XMLList();
            }
            i = 0;
            while(i < themeListXML.child("school").length())
            {
               node = themeListXML.child("school")[i];
               this.groupController.schoolId = node.attribute("id");
               i++;
            }
            j = 0;
            while(j < themeListXML.child("group").length())
            {
               node = themeListXML.child("group")[j];
               group = new Group(node.attribute("id"),node.attribute("name"));
               this.groupController.addGroup(group);
               j++;
            }
            if(themeListXML.hasOwnProperty("category"))
            {
               this.groupController.categoryList = themeListXML.category;
            }
            if(themeListXML.hasOwnProperty("tts"))
            {
               TTSManager.credit = themeListXML.tts.@credit;
            }
            this.doLoadDefaultTheme(themeListXML);
         }
         catch(e:TypeError)
         {
            Alert.show(e.message + " ");
         }
         catch(e:Error)
         {
            Alert.show(e.message + " ");
         }
      }
      
      private function doLoadDefaultTheme(param1:XML) : void
      {
         var targetThemeCode:String = null;
         var themeList:XML = param1;
         this._themeListXML = themeList;
         if(!UtilUser.loggedIn && UtilSite.siteId == UtilSite.CN)
         {
            this._thumbTray.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doShowNoSaveAlert);
         }
         var trayId:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_DEFAULT_TRAYTHEME);
         var xmlList:XMLList = this._themeListXML.theme.(@id == trayId);
         if(trayId != null && xmlList.length() > 0)
         {
            targetThemeCode = trayId;
         }
         else
         {
            targetThemeCode = this._themeListXML.child("theme")[0].attribute("id");
         }
         if(UtilUser.hasPlusFeatures() && this.isEditMode())
         {
            this._thumbTray.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doLoadMovie);
            this._thumbTray.initThemeDropdown(ThumbTray.MOVIE_THEME);
            this._thumbTray._themeSelection.setThemeById(trayId);
            this._thumbTray._themeSelection.setThemeById(ThumbTray.MOVIE_THEME);
            trayId = targetThemeCode = ThumbTray.MOVIE_THEME;
         }
         else
         {
            if(Console.getConsole().isThemeCcRelated(targetThemeCode) && UtilUser.loggedIn)
            {
               UserStuffManager.instance.addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.doLoadMovie);
            }
            else
            {
               this._thumbTray.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doLoadMovie);
            }
            this._thumbTray.initThemeDropdown(targetThemeCode);
         }
         if(UtilLicense.getCurrentLicenseId() == "8")
         {
            this.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.doGetCNUserScores);
         }
         if(trayId != ThumbTray.MOVIE_THEME)
         {
            if(trayId != null && xmlList.length() > 0)
            {
               this._thumbTray.initThemeChosenById(targetThemeCode);
            }
            else
            {
               this.loadTheme(targetThemeCode);
            }
         }
         else
         {
            this.loadCommonTheme(true);
         }
      }
      
      private function doGetCNUserScores(param1:Event) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:URLLoader = null;
         var _loc4_:int = 0;
         if(!this.unlockedAssets)
         {
            _loc2_ = UtilNetwork.getCNUserGameScoreRequest();
            _loc3_ = new URLLoader();
            _loc3_.dataFormat = URLLoaderDataFormat.TEXT;
            _loc3_.addEventListener(Event.COMPLETE,this.onGetCNUserGameScoreComplete);
            this.unlockedAssets = [];
            _loc3_.load(_loc2_);
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < this.unlockedAssets.length)
            {
               this._thumbTray.dispatchEvent(new CoreEvent(CoreEvent.UNLOCK_ASSET,this,this.unlockedAssets[_loc4_]));
               _loc4_++;
            }
         }
      }
      
      private function onGetCNUserGameScoreComplete(param1:Event) : void
      {
         var userScoreXML:XML = null;
         var c:XMLList = null;
         var i:int = 0;
         var e:Event = param1;
         (e.currentTarget as URLLoader).removeEventListener(Event.COMPLETE,arguments.callee);
         userScoreXML = XML((e.currentTarget as URLLoader).data);
         c = userScoreXML.asset.(@e == "1");
         i = 0;
         while(i < c.length())
         {
            this.unlockedAssets.push({
               "id":String(c[i].@id),
               "type":String(c[i].@type)
            });
            i++;
         }
         this.doGetCNUserScores(e);
      }
      
      public function isThemeCcRelated(param1:String) : Boolean
      {
         var list:XMLList = null;
         var themeId:String = param1;
         list = this._themeListXML.child("theme").(attribute("id") == themeId && hasOwnProperty("@cc_theme_id") && attribute("cc_theme_id") != "");
         return list.length() > 0;
      }
      
      public function playScene(param1:Boolean) : void
      {
         if(param1)
         {
            this.currentScene.playScene();
         }
         else
         {
            this.currentScene.stopScene();
         }
      }
      
      public function thumbTrayCommand(param1:String, param2:String) : void
      {
         this.thumbTray["cmd"](param2);
      }
      
      public function deleteTempProp() : void
      {
         ThumbnailCanvas(this.thumbTray._uiTilePropUser.getChildByName(String(this._assetId))).deleteThumbnail(false);
      }
      
      public function changeTempPropName() : void
      {
         var _loc1_:DisplayObject = DisplayObject(this.thumbTray._uiTilePropUser.getChildByName(String(this._assetId)));
         if(_loc1_)
         {
            _loc1_.name = "cellUserProp";
         }
      }
      
      public function doNewAnimation() : void
      {
         Alert.buttonWidth = 100;
         var _loc1_:GoAlert = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
         _loc1_._lblConfirm.text = "";
         _loc1_._txtDelete.text = UtilDict.toDisplay("go","goalert_newanimation");
         _loc1_._btnDelete.label = UtilDict.toDisplay("go","goalert_yes");
         _loc1_._btnDelete.addEventListener(MouseEvent.CLICK,this.alertClickHandler);
         _loc1_._btnCancel.label = UtilDict.toDisplay("go","goalert_no");
         _loc1_._btnCancel.addEventListener(MouseEvent.CLICK,this.alertClickHandler);
         _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
         _loc1_.y = (_loc1_.stage.height - _loc1_.height) / 3;
         _loc1_.hideCloseBtn();
      }
      
      public function isMovieNew() : Boolean
      {
         return this._isMovieNew;
      }
      
      private function onStudioReady(param1:Event = null) : void
      {
         var _loc2_:IFlexDisplayObject = null;
         this._studioProgress.visible = false;
         this._isStudioReady = true;
         StudioStatusManager.instance.status = "Studio is ready to use.";
         this._watermarkManager.loadAllWatermarks();
         if(UtilUser.isTrialAccount)
         {
            _loc2_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,BusinessPreviewWelcome,true);
            PopUpManager.centerPopUp(_loc2_);
         }
      }
      
      public function newAnimation(param1:Boolean = true) : void
      {
         if(this.currentScene != null)
         {
            this.currentScene.removeSound();
         }
         this._isMovieNew = true;
         this.stopAllSounds();
         if(this._movie.scenes.length > 0)
         {
            this.clearScenes();
         }
         if(this.sounds.length > 0)
         {
            this.removeAllSounds();
         }
         var _loc2_:AnimeScene = this.addScene(0);
         CommandStack.getInstance().reset();
         this._metaData = this._tempMetaData = new MetaData();
         if(UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            this.movie.published = this._tempPublished = false;
            this.movie.privateShared = this._tempPrivateShared = false;
         }
         else
         {
            this.movie.published = this._tempPublished = false;
            this.movie.privateShared = this._tempPrivateShared = UtilSite.siteId == UtilSite.GOANIMATE;
         }
         if(this._thumbTray.fullReady())
         {
            if(param1)
            {
               this.addRandomAssetsToScene(ThemeManager.instance.currentTheme,this._movie.currentScene);
            }
         }
         if(this._guideMode == ServerConstants.FLASHVAR_TM_NEW || this._guideMode == ServerConstants.FLASHVAR_TM_SEMI)
         {
            if(!UtilUser.isTrialAccount)
            {
               this.goWalker.addEventListener(TutorialEvent.TUTORIAL_DONE,this.onTutorialDone);
               this._thumbTray.isTutorialOn = true;
               this.goWalker.startTutorial();
               this._needGuideBubbles = false;
            }
         }
         if(this._needGuideBubbles && (this.studioType == TINY_STUDIO || this.studioType == FULL_STUDIO))
         {
            this.addGuideBubbles();
         }
      }
      
      private function onTutorialDone(param1:TutorialEvent) : void
      {
         this._thumbTray.isTutorialOn = false;
      }
      
      public function onOpenBgTab() : void
      {
         if(UtilUser.hasAdminFeatures)
         {
            if(ThemeManager.instance.currentTheme.id == ThemeConstants.BUSINESS_THEME_ID && !this.goWalker.isBasicTutorialRunning() && !this.goWalker.hasTemplateGuideShown)
            {
               this.goWalker.startTemplateTutorial();
            }
         }
      }
      
      public function onShowTemplate() : void
      {
         if(UtilUser.hasAdminFeatures)
         {
            if(!this.goWalker.isBasicTutorialRunning() && !this.goWalker.hasTemplateThumbGuideShown)
            {
               this.goWalker.startTemplateThumbTutorial();
            }
         }
      }
      
      private function testing(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,this.testing);
            _loc2_.loaderInfo.loader.parent.parent.removeChild(_loc2_.loaderInfo.loader.parent);
            this.doAddScene();
         }
      }
      
      public function putData(param1:String, param2:Object) : void
      {
         if(this._previewData == null)
         {
            this._previewData = new UtilHashArray();
         }
         if(!this._previewData.containsKey(param1))
         {
            this._previewData.push(param1,param2,true);
         }
         else
         {
            this._previewData.replaceValueByKey(param1,param2);
         }
      }
      
      private function resetZoomEffect(param1:XML) : void
      {
         var _loc2_:XMLList = param1..effectAsset;
         var _loc3_:int = _loc2_.length() - 1;
         while(_loc3_ >= 0)
         {
            if(_loc2_[_loc3_].effect.@type == "ZOOM")
            {
               delete _loc2_[_loc3_];
            }
            _loc3_--;
         }
      }
      
      private function deSerialize(param1:XML, param2:String, param3:String = null) : void
      {
         var indexArray:Array = null;
         var metaNode:XML = null;
         var myMetaNode:XML = null;
         var myMetaData:MetaData = null;
         var skipEditHead:Boolean = false;
         var i:int = 0;
         var sceneNode:XML = null;
         var sceneId:String = null;
         var scene:AnimeScene = null;
         var movieXML:XML = param1;
         var movieID:String = param2;
         var originalId:String = param3;
         if(movieXML != null)
         {
            if(!this._isLoadingTemplate)
            {
               metaNode = movieXML.child(MetaData.XML_NODE_NAME)[0];
               this._metaData = new MetaData();
               this._metaData.deSerialize(metaNode,movieID,originalId);
               this._tempMetaData.deSerialize(metaNode,movieID,originalId);
               this._metaData.lang = this._tempMetaData.lang = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_LANG) as String;
               this.movie.published = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_IS_PUBLISHED) as String == "0" ? false : true;
               this.movie.privateShared = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_IS_PRIVATESHARED) as String == "0" ? false : true;
               this.movie.copyable = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_COPYABLE) as String == "1" ? true : false;
               if(originalId != null && StringUtil.trim(originalId))
               {
                  this._metaData.title = "";
                  this._tempMetaData.title = "";
                  this.movie.published = false;
                  this.movie.privateShared = UtilSite.siteId == UtilSite.GOANIMATE;
                  this.isCopy = true;
               }
               this.tempPublished = this.movie.published;
               this.tempPrivateShared = this.movie.privateShared;
            }
            else
            {
               myMetaNode = movieXML.child(MetaData.XML_NODE_NAME)[0];
               myMetaData = new MetaData();
               myMetaData.deSerialize(myMetaNode,"","");
               if(myMetaData.mver <= 3 && this.metaData.mver > 3)
               {
                  this.resetZoomEffect(movieXML);
               }
            }
            Console.getConsole().timeline.sceneLengthController.userPreference = SceneLengthController.FULL_MANUAL;
            if(Console.getConsole().studioType == MESSAGE_STUDIO)
            {
               indexArray = UtilXmlInfo.getAndSortXMLattribute(movieXML,"index",AnimeScene.XML_NODE_NAME);
               skipEditHead = true;
               i = 0;
               while(i < indexArray.length)
               {
                  sceneNode = movieXML.child(AnimeScene.XML_NODE_NAME).(@index == indexArray[i] as int)[0];
                  sceneId = sceneNode.@id;
                  scene = this.addScene(0,sceneId);
                  this.capScreenLock = true;
                  scene.deSerialize(sceneNode,true,false,false);
                  this.capScreenLock = false;
                  if(sceneNode.toXMLString().toLowerCase().indexOf(AnimeConstants.MAGIC_KEY) > -1)
                  {
                     skipEditHead = false;
                  }
                  i++;
               }
               this.setCurrentScene(indexArray.length - 1);
               this.currentScene.loadAllAssets();
               this.deserializeSound(movieXML);
               this.stopScene(this.stopScene,6);
               this._initialized = true;
               this.dispatchEvent(new CoreEvent(CoreEvent.PREPARE_MOVIE_COMPLETE,this,skipEditHead));
               Console.getConsole().timeline.sceneLengthController.userPreference = SceneLengthController.FULL_AUTO;
            }
            else
            {
               this._sci = 0;
               try
               {
                  this.thumbSO = SharedObject.getLocal("studioThumbs_" + this.metaData.movieId);
               }
               catch(e:Error)
               {
                  thumbSO = null;
               }
               this.addSceneOnDeserialize();
            }
         }
      }
      
      private function onSceneComplete(param1:Event) : void
      {
         (param1.currentTarget as IEventDispatcher).removeEventListener(param1.type,this.onSceneComplete);
         var _loc2_:AnimeScene = param1.currentTarget as AnimeScene;
         this.mainStage.sceneEditor.addEventListener(SceneViewEvent.VIEW_LOAD_COMPLETE,this.onSceneEditorLoadComplete);
         if(UtilUser.hasAdminFeatures || this._isLoadingTemplate)
         {
            this._movie.addSceneAt(_loc2_,this._insertSceneAtIndex);
            ++this._insertSceneAtIndex;
         }
         else
         {
            this._movie.addSceneAt(_loc2_,this._movie.currentIndex + 1);
         }
         this.updateSceneTransition(this.getSceneIndex(_loc2_),_loc2_);
      }
      
      private function onSceneEditorLoadComplete(param1:Event) : void
      {
         (param1.currentTarget as IEventDispatcher).removeEventListener(param1.type,this.onSceneEditorLoadComplete);
         setTimeout(this.addSceneOnDeserialize,200);
      }
      
      private function loadThumbnailCompleteHandle(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.loadThumbnailCompleteHandle);
         var _loc3_:ExtraDataLoader = ExtraDataLoader(_loc2_.loader);
         var _loc4_:Object = _loc3_.extraData;
         var _loc5_:BitmapData;
         (_loc5_ = new BitmapData(220,141)).draw(_loc3_);
         _loc3_ = null;
         this.timeline.updateSceneImageByBitmapData(_loc4_["_sci"],_loc5_);
      }
      
      private function isSceneGotoBuild(param1:XML) : Boolean
      {
         var _loc2_:Boolean = true;
         if(param1.toXMLString().toLowerCase().indexOf(AnimeConstants.MAGIC_KEY) > -1 && (this.studioType == FULL_STUDIO || this.studioType == TINY_STUDIO) && this.isCopy)
         {
            _loc2_ = false;
         }
         if(Number(param1.@adelay) < 4.8)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function addSceneOnDeserialize() : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:AnimeScene = null;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:ByteArray = null;
         var _loc10_:ExtraDataLoader = null;
         var _loc11_:Object = null;
         var _loc12_:Boolean = false;
         var _loc1_:XML = this._movieXML;
         var _loc2_:Number = _loc1_.scene.length();
         if(this._sci < _loc2_)
         {
            this.requestLoadStatus(true,true);
            _loc3_ = _loc1_.child(AnimeScene.XML_NODE_NAME)[this._sci];
            if(this.isSceneGotoBuild(_loc3_))
            {
               _loc4_ = _loc3_.@id;
               (_loc5_ = this.createScene(_loc4_)).combgId = _loc3_.@combgId;
               try
               {
                  if(_loc5_.combgId)
                  {
                     _loc7_ = _loc5_.combgId.split(".")[0];
                     _loc8_ = _loc5_.combgId.split(".")[1];
                     this.addThumbToMovieTheme(ThemeManager.instance.getTheme(_loc7_).getBackgroundThumbById(_loc8_));
                  }
               }
               catch(e:Error)
               {
               }
               this.capScreenLock = true;
               _loc6_ = true;
               if(!this._isLoadingTemplate)
               {
                  if(this.thumbSO && this.thumbSO.size > 0)
                  {
                     if(_loc9_ = this.thumbSO.data[_loc4_] as ByteArray)
                     {
                        _loc9_.position = 0;
                        _loc10_ = new ExtraDataLoader();
                        (_loc11_ = new Object())["_sci"] = this._sci;
                        _loc10_.extraData = _loc11_;
                        _loc10_.loadBytes(_loc9_);
                        _loc10_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadThumbnailCompleteHandle);
                        _loc6_ = false;
                     }
                  }
               }
               if(_loc2_ > 1)
               {
                  if(_loc6_)
                  {
                     _loc12_ = true;
                     if(this._isLoadingTemplate && this._sci == _loc2_ - 1)
                     {
                        _loc12_ = false;
                     }
                     _loc5_.addEventListener(CoreEvent.DESERIALIZE_SCENE_COMPLETE,this.onSceneComplete);
                     _loc5_.deSerialize(_loc3_,true,true,_loc12_);
                  }
                  else
                  {
                     _loc5_.sceneXML = _loc3_;
                     _loc5_.deserializeSceneLength(_loc3_,true);
                     this._skipSceneRendering = true;
                     this._movie.addSceneAt(_loc5_,this._movie.currentIndex + 1);
                     this.updateSceneTransitionByXML(this._sci,_loc3_);
                     setTimeout(this.addSceneOnDeserialize,200);
                  }
               }
               else
               {
                  _loc5_.addEventListener(CoreEvent.DESERIALIZE_SCENE_COMPLETE,this.onSceneComplete);
                  _loc5_.deSerialize(_loc3_,true,true,false);
               }
               if(!_loc5_.sizingAsset && Console.getConsole().metaData.mver > 3)
               {
                  SceneManager.addDefaultZoomEffect(_loc5_);
               }
            }
            else
            {
               setTimeout(this.addSceneOnDeserialize,200);
            }
         }
         if(this._sci == _loc2_)
         {
            this.capScreenLock = false;
            this.requestLoadStatus(false,true,_loc2_);
            if(!this._isLoadingTemplate)
            {
               this.deserializeLinkage(_loc1_);
            }
            if(!this._isLoadingTemplate && _loc2_ > 0 && this.studioType != MESSAGE_STUDIO)
            {
               this.setCurrentScene(0);
               this.timeline._timelineScrollbar.scrollPosition = 0;
               this.timeline._timelineScrollbar.dispatchEvent(new Event(ScrollEvent.SCROLL));
            }
            if(!this._isLoadingTemplate)
            {
               this.deserializeSound(_loc1_);
            }
            this.refreshAllSpeechText();
            this._initialized = true;
            if(!this._isLoadingTemplate && this.metaData.mver <= 2 && UtilLicense.isEffectChangeTipsShouldBeShown(UtilLicense.getCurrentLicenseId()))
            {
               this.showTip();
            }
            if(!this._isLoadingTemplate && UtilUser.hasPlusFeatures())
            {
               this.thumbTray.initThemeChosenById(ThumbTray.MOVIE_THEME);
            }
            this._isLoadingTemplate = false;
            Console.getConsole().timeline.sceneLengthController.userPreference = SceneLengthController.FULL_AUTO;
         }
         ++this._sci;
      }
      
      private function initTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget);
         _loc2_.init(15790320);
         var _loc3_:Canvas = new Canvas();
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_._title.height = 20;
         _loc3_.graphics.beginFill(15897884);
         _loc3_.graphics.drawRoundRectComplex(0,0,_loc3_.width,_loc3_.height,5,5,0,0);
         _loc3_.graphics.endFill();
         var _loc4_:Label;
         (_loc4_ = new Label()).text = UtilDict.toDisplay("go","gotips_pleaseread");
         _loc4_.setStyle("color",16777215);
         _loc4_.setStyle("fontSize",13);
         _loc4_.x = 5;
         _loc4_.y = 2;
         _loc3_.addChild(_loc4_);
         _loc2_.setTitle(_loc3_);
         var _loc5_:VBox;
         (_loc5_ = new VBox()).percentWidth = 80;
         _loc5_.setStyle("verticalGap",0);
         _loc5_.setStyle("horizontalAlign","center");
         _loc5_.setStyle("horizontalCenter","1");
         _loc5_.setStyle("verticalScrollPolicy","off");
         var _loc6_:StyleSheet;
         (_loc6_ = new StyleSheet()).parseCSS(this.hoverStyles);
         var _loc7_:TextArea;
         (_loc7_ = new TextArea()).styleSheet = _loc6_;
         _loc7_.height = 100;
         _loc7_.selectable = false;
         _loc7_.htmlText = UtilDict.toDisplay("go","gotips_effectupdated");
         _loc7_.setStyle("fontSize",16);
         var _loc8_:TextArea;
         (_loc8_ = new TextArea()).styleSheet = _loc6_;
         _loc8_.selectable = false;
         _loc8_.htmlText = UtilDict.toDisplay("go","gotips_learnmore");
         _loc8_.setStyle("fontSize",16);
         _loc8_.setStyle("textAlign","right");
         _loc7_.verticalScrollPolicy = _loc8_.verticalScrollPolicy = "off";
         _loc7_.percentWidth = _loc8_.percentWidth = 100;
         _loc7_.selectable = _loc8_.selectable = false;
         _loc7_.editable = _loc8_.editable = false;
         _loc7_.setStyle("backgroundAlpha","0");
         _loc8_.setStyle("backgroundAlpha","0");
         _loc7_.setStyle("borderStyle","none");
         _loc8_.setStyle("borderStyle","none");
         _loc5_.addChild(_loc7_);
         _loc5_.addChild(_loc8_);
         _loc2_._content.height = 140;
         _loc2_.setContent(_loc5_);
         var _loc9_:Canvas;
         (_loc9_ = new Canvas()).width = _loc2_.width;
         _loc9_.setStyle("horizontalCenter","1");
         _loc9_.buttonMode = true;
         var _loc10_:Label;
         (_loc10_ = new Label()).text = UtilDict.toDisplay("go","gotips_close");
         _loc10_.buttonMode = true;
         _loc10_.useHandCursor = true;
         _loc10_.mouseChildren = false;
         _loc10_.x = (_loc9_.width - 80) / 2;
         _loc10_.setStyle("fontSize",14);
         _loc10_.addEventListener(MouseEvent.CLICK,this.closeTip);
         _loc9_.addChild(_loc10_);
         _loc2_.setClose(_loc9_);
      }
      
      private function closeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget.parent.parent.parent.parent);
         this.mainStage.removeChild(_loc2_);
      }
      
      private function showTip() : void
      {
         var _loc1_:TipWindow = new TipWindow();
         _loc1_.width = 400;
         _loc1_.height = 200;
         _loc1_.x = (this.mainStage.width - _loc1_.width) / 2;
         _loc1_.y = (this.mainStage.height - _loc1_.height) / 2;
         _loc1_.addEventListener(Event.COMPLETE,this.initTip);
         this.mainStage.addChild(_loc1_);
      }
      
      public function serialize(param1:Boolean = true, param2:Boolean = false, param3:Boolean = false) : XML
      {
         var xml:XML = null;
         var childXml:XML = null;
         var xmlList:XMLList = null;
         var xmlStr:String = null;
         var ex:Error = null;
         var i:int = 0;
         var userLogData:Object = null;
         var published:Boolean = false;
         var privateShared:Boolean = false;
         var duration:Number = NaN;
         var sclen:int = 0;
         var nEx:SerializeError = null;
         var stockdata:Boolean = param1;
         var currSceneOnly:Boolean = param2;
         var isTemplate:Boolean = param3;
         try
         {
            this._previewData.removeAll();
            userLogData = {"phase":"metadata"};
            published = this.movie.published;
            privateShared = this.movie.privateShared;
            duration = Util.roundNum(this.timeline.getTotalTimeInSec());
            if(duration > FeatureManager.maxMovieDuration)
            {
               published = false;
               privateShared = false;
            }
            if(UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.siteId == UtilSite.SKOLETUBE)
            {
               if(published)
               {
                  privateShared = true;
               }
               published = false;
            }
            if(isTemplate)
            {
               published = false;
               privateShared = false;
            }
            childXml = <film/>;
            childXml.@copyable = !!this.movie.copyable ? 1 : 0;
            childXml.@duration = duration;
            childXml.@published = !!published ? 1 : 0;
            childXml.@pshare = !!privateShared ? 1 : 0;
            if(this.screenMode == AnimeConstants.SCREEN_MODE_WIDE)
            {
               childXml.@isWide = 1;
            }
            xml = new XML("<?xml version=\"1.0\" encoding=\"utf-8\"?>" + childXml.toXMLString());
            if(isTemplate)
            {
               childXml = this.templateMetaData.convertToXml();
            }
            else
            {
               childXml = this.metaData.convertToXml();
            }
            xml.appendChild(childXml);
            sclen = this._movie.scenes.length;
            if(!currSceneOnly)
            {
               i = 0;
               while(i < sclen)
               {
                  userLogData.phase = "Scene " + i;
                  childXml = new XML(AnimeScene(this._movie.getSceneAt(i)).serialize(i,stockdata));
                  xml.appendChild(childXml);
                  i++;
               }
            }
            else
            {
               i = this.currentSceneIndex;
               userLogData.phase = "Scene " + i;
               childXml = new XML(AnimeScene(this._movie.getSceneAt(i)).serialize(i,stockdata));
               xml.appendChild(childXml);
            }
            userLogData.phase = "Sound";
            xmlList = new XMLList(this.serializeSound(stockdata));
            xml.appendChild(xmlList);
            userLogData.phase = "Speech Manager";
            xmlList = new XMLList(this.speechManager.serializeSound(stockdata,userLogData));
            xml.appendChild(xmlList);
            userLogData.phase = "Linkage";
            xmlList = new XMLList(this.serializeLinkage());
            xml.appendChild(xmlList);
            return xml;
         }
         catch(ex:Error)
         {
            nEx = new SerializeError("Failed to serialize movie",xml.toXMLString(),ex);
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,nEx));
            return null;
         }
      }
      
      public function serializeLinkage() : String
      {
         return this.linkageController.serialize();
      }
      
      public function deserializeLinkage(param1:XML) : void
      {
         this.linkageController.deserialize(param1);
      }
      
      public function serializeSound(param1:Boolean = true) : String
      {
         var _loc3_:IIterator = null;
         var _loc4_:AnimeSound = null;
         var _loc2_:String = "";
         if(this._sounds)
         {
            _loc3_ = this._sounds.iterator();
            while(_loc3_.hasNext)
            {
               if(_loc4_ = _loc3_.next as AnimeSound)
               {
                  _loc2_ += _loc4_.serialize(param1,false,new Object());
               }
            }
         }
         return _loc2_;
      }
      
      public function deserializeSound(param1:XML) : void
      {
         var _loc2_:Array = null;
         var _loc5_:XML = null;
         var _loc6_:AnimeSound = null;
         var _loc7_:Number = NaN;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc10_:AnimeScene = null;
         var _loc11_:Character = null;
         var _loc12_:Boolean = false;
         var _loc13_:Number = NaN;
         _loc2_ = UtilXmlInfo.getAndSortXMLattribute(param1,"index",AnimeSound.XML_NODE_NAME);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = param1.child(AnimeSound.XML_NODE_NAME)[_loc4_];
            (_loc6_ = new AnimeSound()).deSerialize(_loc5_);
            if(_loc6_.startFrame < (this.timeline.getTotalTimeInSec() + 300) * AnimeConstants.FRAME_PER_SEC)
            {
               if(_loc6_.soundThumb != null)
               {
                  _loc7_ = 1;
                  if(_loc5_.attribute("vol").length() != 0)
                  {
                     _loc7_ = _loc5_.@vol;
                  }
                  if(_loc6_.soundThumb.ttsData && _loc6_.trackNum == 0)
                  {
                     _loc9_ = Console.getConsole().linkageController.getTargetIdOfSpeech(_loc6_.getID());
                     if(_loc10_ = Console.getConsole().getScenebyId(AssetLinkage.getSceneIdFromLinkage(_loc9_)))
                     {
                        if(_loc11_ = _loc10_.getCharacterById(AssetLinkage.getCharIdFromLinkage(_loc9_)))
                        {
                           _loc11_.demoSpeech = true;
                        }
                        if(_loc6_.soundThumb.ttsData.type == "mic")
                        {
                           this.speechManager.micRecordingManager.addSoundBySound(_loc6_,false);
                        }
                        else if(_loc6_.soundThumb.ttsData.type == "file")
                        {
                           this.speechManager.voiceFileManager.addSoundBySound(_loc6_,false);
                        }
                        else
                        {
                           this.speechManager.ttsManager.addSoundBySound(_loc6_,false);
                        }
                     }
                  }
               }
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = param1.child(AnimeSound.XML_NODE_NAME)[_loc4_];
            (_loc6_ = new AnimeSound()).deSerialize(_loc5_);
            if(_loc6_.startFrame < (this.timeline.getTotalTimeInSec() + 300) * AnimeConstants.FRAME_PER_SEC)
            {
               if(_loc6_.soundThumb != null)
               {
                  _loc7_ = 1;
                  if(_loc5_.attribute("vol").length() != 0)
                  {
                     _loc7_ = _loc5_.@vol;
                  }
                  if(!(_loc6_.soundThumb.ttsData && _loc6_.trackNum == 0))
                  {
                     if(_loc5_.attribute("track").length() == 0)
                     {
                        this.addSound(_loc6_);
                        _loc3_ = _loc3_ == 3 ? 0 : int(_loc3_ + 1);
                     }
                     else
                     {
                        _loc12_ = false;
                        _loc13_ = 0;
                        while(_loc13_ < _loc2_.length)
                        {
                           if(_loc4_ != _loc13_)
                           {
                              if((_loc8_ = param1.child(AnimeSound.XML_NODE_NAME)[_loc13_]).@tts != "1" && _loc6_.trackNum == _loc8_.@track)
                              {
                                 if(Number(_loc8_.start) <= _loc6_.endFrame && Number(_loc8_.start) > _loc6_.startFrame)
                                 {
                                    _loc6_.endFrame = Number(_loc8_.start) - 6;
                                 }
                                 if(Number(_loc8_.stop) >= _loc6_.endFrame && Number(_loc8_.start) <= _loc6_.startFrame)
                                 {
                                    _loc12_ = true;
                                 }
                              }
                           }
                           _loc13_++;
                        }
                        if(!_loc12_)
                        {
                           this.addSound(_loc6_);
                        }
                     }
                  }
               }
            }
            _loc4_++;
         }
      }
      
      public function alertSceneXml() : void
      {
         var movieXml:XML = null;
         var sceneXml:XML = null;
         var sceneContentStr:String = null;
         var node:XML = null;
         try
         {
            movieXml = this.serialize();
            sceneXml = movieXml.child("scene")[0] as XML;
            sceneContentStr = "";
            for each(node in sceneXml.children())
            {
               sceneContentStr += node.toXMLString() + "\n";
            }
            Alert.show(sceneContentStr,"Scene XML");
         }
         catch(e:Error)
         {
            Alert.show(sceneContentStr,"Invalid Scene XML");
         }
      }
      
      private function putFontData(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc6_:ByteArray = null;
         var _loc3_:FontManager = FontManager.getFontManager();
         var _loc4_:UtilHashArray = _loc3_.getFonts().clone();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.getFonts().length)
         {
            _loc2_ = _loc3_.getFonts().getKey(_loc5_);
            if(param1.indexOf(_loc2_) > -1)
            {
               (_loc6_ = new ByteArray()).writeBytes(_loc3_.getFonts().getValueByKey(_loc2_) as ByteArray);
               this.putData(_loc3_.nameToFileName(_loc2_) + ".swf",_loc6_);
            }
            _loc5_++;
         }
      }
      
      public function preview(param1:PreviewPlayer = null, param2:Boolean = false) : void
      {
         var _loc3_:UtilHashArray = null;
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:Theme = null;
         var _loc7_:XML = null;
         var _loc8_:Number = NaN;
         try
         {
            this.stopAllSounds();
            this._filmXML = this.serialize();
            this.putFontData(this._filmXML.toXMLString());
            this.putData("watermarkUrl",this._watermarkManager.currentWatermark.url);
            _loc3_ = new UtilHashArray();
            _loc4_ = 0;
            while(_loc4_ < ThemeManager.instance.themes.length)
            {
               _loc3_.push(ThemeManager.instance.themes.getKey(_loc4_),(ThemeManager.instance.themes.getValueByIndex(_loc4_) as Theme).getThemeXML());
               _loc4_++;
            }
            _loc5_ = ThemeManager.instance.userTheme.getThemeXML();
            _loc6_ = ThemeManager.instance.getTheme("ugc");
            _loc7_ = null;
            if(_loc5_ == null || _loc6_ == null || _loc6_.getThemeXML() == null)
            {
               _loc7_ = _loc5_;
            }
            else
            {
               _loc7_ = Theme.merge2ThemeXml(_loc5_,_loc6_.getThemeXML(),"ugc","ugc",false);
            }
            _loc7_ = Theme.merge2ThemeXml(_loc6_ != null ? _loc6_.getThemeXML() : null,ThemeManager.instance.userTheme.getThemeXML(),"ugc","ugc");
            _loc3_.push(ThemeManager.instance.userTheme.id,_loc7_);
            if(this._shouldUseExternalPreviewPlayer == -1)
            {
               if(UtilLicense.isExternalPreviewPlayerShouldBeUsed(UtilLicense.getCurrentLicenseId()) && this.studioType == FULL_STUDIO && (this._guideMode == "" || this._guideMode == ServerConstants.FLASHVAR_TM_FIN))
               {
                  this._shouldUseExternalPreviewPlayer = 1;
               }
               else
               {
                  this._shouldUseExternalPreviewPlayer = 0;
               }
            }
            if(this._shouldUseExternalPreviewPlayer == 1)
            {
               this.externalPreviewPlayerController = new ExternalPreviewWindowController();
               this.externalPreviewPlayerController.removeEventListener(Event.CHANGE,this.showPublishWindow);
               this.externalPreviewPlayerController.removeEventListener(Event.CANCEL,this.doContinueEdit);
               this.externalPreviewPlayerController.addEventListener(Event.CHANGE,this.doShowPublishWindow);
               this.externalPreviewPlayerController.addEventListener(Event.CANCEL,this.doContinueEdit);
               _loc8_ = new Number();
               if(param2 == true)
               {
                  _loc8_ = this._movie.currentIndex;
               }
               else
               {
                  _loc8_ = 0;
               }
               this.externalPreviewPlayerController.initExternalPreviewWindow(this._filmXML,this._previewData,_loc3_,_loc8_);
            }
            else if(param1 == null)
            {
               this._viewStackWindow = ViewStackWindow(PopUpManager.createPopUp(this.mainStage,ViewStackWindow,true));
               this._viewStackWindow.x = (this._viewStackWindow.stage.width - this._viewStackWindow.preview.width) / 2;
               this._viewStackWindow.y = this._mainStage.y;
               this._viewStackWindow.initAndPreviewMovie(this._filmXML,this._previewData,_loc3_,this._tempMetaData.title);
               this._viewStackWindow.addEventListener(Event.CANCEL,this.doContinueEdit,false,0,true);
            }
            else
            {
               param1.initAndPreview(this._filmXML,this._previewData,_loc3_);
               param1.endScreen.isPreviewMode = false;
               param1.playerControl.fullScreenControl.visible = false;
            }
            if(this._movie.currentScene != null)
            {
               this._movie.currentScene.stopScene();
            }
            this.genDefaultTags();
         }
         catch(e:Error)
         {
         }
      }
      
      public function deleteAsset(param1:MouseEvent = null) : void
      {
         var _loc2_:ICommand = null;
         var _loc3_:IIterator = null;
         var _loc4_:Asset = null;
         if(this.isTutorialOn)
         {
            return;
         }
         if(this.currentScene.selectedAsset is ProgramEffectAsset && ProgramEffectAsset(this.currentScene.selectedAsset).effect is ZoomEffect)
         {
            if(Console.getConsole().metaData.mver > 3)
            {
               return;
            }
         }
         if(param1 != null)
         {
            if((param1.currentTarget as Button).parent == this.mainStage._lookInToolBar)
            {
               this.currentScene.selectedAsset = this.currentScene.sizingAsset;
               this.lookOut();
            }
         }
         if(this._movie.currentScene)
         {
            _loc2_ = new RemoveAssetsCommand();
            _loc2_.execute();
            _loc3_ = this._movie.currentScene.selection.iterator();
            while(_loc3_.hasNext)
            {
               if(_loc4_ = _loc3_.next as Asset)
               {
                  _loc4_.deleteAsset(false);
               }
            }
            this.refreshAllSpeechText();
         }
      }
      
      public function showControl() : void
      {
         this.mainStage.sceneEditor.controller.showControl();
      }
      
      public function get sceneController() : SceneEditorController
      {
         return this.mainStage.sceneEditor.controller;
      }
      
      public function addCutEffectonChar(param1:Character) : void
      {
         var _loc2_:EffectThumb = ThemeManager.instance.getTheme("common").effectThumbs.getValueByKey("cut") as EffectThumb;
         this.createAsset(_loc2_,param1.x,param1.y - param1.height / 4,true);
      }
      
      public function createAsset(param1:Object, param2:Number = 0, param3:Number = 0, param4:Boolean = false) : void
      {
         if(this._movie.currentScene != null)
         {
            this._movie.currentScene.createAsset(param1 as Thumb,param2,param3,"",param4);
         }
      }
      
      public function doKeyUp(param1:KeyboardEvent) : void
      {
         if(this.isTutorialOn)
         {
            return;
         }
         if(param1.ctrlKey)
         {
            if(param1.keyCode == Keyboard.Z)
            {
               StudioManager.instance.undo();
            }
            else if(param1.keyCode == Keyboard.Y)
            {
               StudioManager.instance.redo();
            }
            else if(param1.keyCode != Keyboard.P)
            {
               if(param1.keyCode == Keyboard.S)
               {
               }
            }
         }
      }
      
      public function copyAsset() : void
      {
         var _loc1_:IIterator = null;
         var _loc2_:Asset = null;
         try
         {
            this._copyObjects = new Array();
            if(this._movie.currentScene)
            {
               _loc1_ = this._movie.currentScene.selection.iterator();
               while(_loc1_.hasNext)
               {
                  _loc2_ = _loc1_.next as Asset;
                  if(_loc2_ && _loc2_.isCopyable)
                  {
                     this._copyObjects.push(_loc2_.serialize());
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function pasteAsset() : void
      {
         if(this._copyObjects && this._copyObjects.length > 0 && this._movie.currentScene)
         {
            this._movie.currentScene.pasteAssets(this._copyObjects);
         }
      }
      
      public function showOverTray(param1:Boolean = true, param2:Object = null) : void
      {
         var _loc3_:PropertyWindowEvent = null;
         if(this.studioType != MESSAGE_STUDIO && !this._boxMode)
         {
            if(param1)
            {
               OverTray(this.pptPanel.parent.parent.parent).open(param2);
               this.pptPanel._close.addEventListener(MouseEvent.CLICK,this.closeOverTray);
            }
            else
            {
               OverTray(this.pptPanel.parent.parent.parent).close();
               this.pptPanel._close.removeEventListener(MouseEvent.CLICK,this.closeOverTray);
            }
         }
         if(this._boxMode)
         {
            _loc3_ = new PropertyWindowEvent(!!param1 ? PropertyWindowEvent.EVENT_OPEN : PropertyWindowEvent.EVENT_CLOSE);
            _loc3_.view = PropertyWindowEvent.VIEW_PROPERTY_WINDOW;
            FlexGlobals.topLevelApplication.dispatchEvent(_loc3_);
         }
      }
      
      private function closeOverTray(param1:Event) : void
      {
         this.showOverTray(false);
      }
      
      public function get propertiesWindow() : PropertiesWindow
      {
         return this.pptPanel;
      }
      
      private function updateSceneTransition(param1:Number, param2:AnimeScene) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         if(param1 >= 0)
         {
            if(param2.transition)
            {
               SceneElement(Console.getConsole().timeline.sceneContainer.getItemAt(param1)).transDur = param2.transition.duration;
               SceneElement(Console.getConsole().timeline.sceneContainer.getItemAt(param1)).transType = param2.transition.type;
            }
         }
      }
      
      private function updateSceneTransitionByXML(param1:Number, param2:XML) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         if(param1 >= 0 && param2)
         {
            if(_loc5_ = param2.trans[0])
            {
               _loc4_ = (_loc8_ = (_loc7_ = (_loc6_ = _loc5_.fx[0] as XML).@type).split("."))[1];
               _loc3_ = _loc6_.@dur;
               SceneElement(Console.getConsole().timeline.sceneContainer.getItemAt(param1)).transDur = _loc3_;
               SceneElement(Console.getConsole().timeline.sceneContainer.getItemAt(param1)).transType = _loc4_;
            }
         }
      }
      
      public function lookIntoAsset() : void
      {
         this.mainStage.showCameraView();
      }
      
      public function lookOut() : void
      {
         this.mainStage.hideCameraView();
      }
      
      public function slideAsset() : void
      {
      }
      
      public function flipCCLookAtCamera() : void
      {
         var _loc3_:Character = null;
         var _loc1_:AnimeScene = _console.currentScene;
         var _loc2_:Asset = _console.currentScene.selectedAsset;
         if(_loc2_ is Character)
         {
            _loc3_ = Character(_loc2_);
            if(CharThumb(_loc3_.thumb).isCC)
            {
               _loc3_.toggleLookAtCamera();
            }
         }
      }
      
      public function flipAsset() : void
      {
         var _loc1_:Asset = null;
         var _loc2_:ICommand = null;
         if(_console.currentScene)
         {
            _loc1_ = _console.currentScene.selectedAsset;
            if(_loc1_ is IFlippable)
            {
               _loc2_ = new FlipAssetCommand(_loc1_.id);
               _loc2_.execute();
               IFlippable(_loc1_).flipIt();
               this.dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_FLIPPED));
            }
         }
      }
      
      public function editAsset(param1:MouseEvent = null) : void
      {
         if(param1 != null)
         {
            if((param1.currentTarget as Button).parent == this.mainStage._lookInToolBar)
            {
               this.currentScene.selectedAsset = this.currentScene.sizingAsset;
            }
         }
         var _loc2_:AnimeScene = _console.currentScene;
         var _loc3_:Asset = _console.currentScene.selectedAsset;
         if(_loc3_ is EffectAsset)
         {
            (_loc3_ as EffectAsset).showInfoWindow();
         }
      }
      
      public function bringForward() : void
      {
         var _loc4_:ICommand = null;
         if(this.isTutorialOn)
         {
            return;
         }
         var _loc1_:AnimeScene = _console.currentScene;
         var _loc2_:Boolean = _loc1_.bringForward();
         var _loc3_:Asset = _console.currentScene.selectedAsset;
         if(_loc3_ != null && _loc2_)
         {
            (_loc4_ = new BringForwardCommand(_loc3_.id)).execute();
         }
      }
      
      public function sendBackward() : void
      {
         var _loc4_:ICommand = null;
         if(this.isTutorialOn)
         {
            return;
         }
         var _loc1_:AnimeScene = _console.currentScene;
         var _loc2_:Boolean = _loc1_.sendBackward();
         var _loc3_:Asset = _console.currentScene.selectedAsset;
         if(_loc3_ != null && _loc2_)
         {
            (_loc4_ = new SendBackwardCommand(_loc3_.id)).execute();
         }
      }
      
      public function getSceneIndex(param1:AnimeScene) : int
      {
         return this._movie.getSceneIndex(param1);
      }
      
      public function selectScene(param1:Number) : void
      {
         this._movie.currentIndex = param1;
      }
      
      public function getScenebyId(param1:String) : AnimeScene
      {
         return this._movie.getSceneById(param1);
      }
      
      public function getScene(param1:int) : AnimeScene
      {
         if(this._movie.getSceneAt(param1))
         {
            return this._movie.getSceneAt(param1);
         }
         return null;
      }
      
      public function pasteScene(param1:Boolean = true) : void
      {
         var _loc2_:AnimeScene = null;
         var _loc3_:Number = NaN;
         var _loc4_:ICommand = null;
         if(SceneManager.copiedScene)
         {
            this.mainStage.hideCameraView();
            _loc2_ = this.createScene("",SceneManager.copiedScene);
            SceneManager.copiedScene = null;
            _loc3_ = !!param1 ? Number(this._movie.currentIndex + 1) : Number(this._movie.currentIndex);
            (_loc4_ = new AddSceneCommand(this.movie,_loc2_,_loc3_,this.timeline)).execute();
         }
      }
      
      private function onSceneDownHandler(param1:TimelineEvent) : void
      {
         var _loc2_:AnimeScene = this._movie.getSceneAt(param1.index);
         if(!this._movie.selection.isSelected(_loc2_))
         {
            this._movie.selection.currentScene = _loc2_;
         }
      }
      
      private function onSceneUpHandler(param1:TimelineEvent) : void
      {
      }
      
      private function onUpgradeBtnClick(param1:MouseEvent) : void
      {
         this.showUpgradePopup();
      }
      
      public function addNextScene(param1:Boolean = false) : void
      {
         var _loc2_:GoAlert = null;
         this.hideGuideSceneBub();
         this._addBlankScene = param1;
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            if(this._movie.scenes.length >= this.MAX_SCENE_NUMBER)
            {
               _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
               _loc2_.hideCloseBtn();
               _loc2_.alertTitle = UtilDict.toDisplay("go","Oops...");
               _loc2_.alertContent = UtilDict.toDisplay("go","Your BASIC account can only create up to " + this.MAX_SCENE_NUMBER + " scenes. To remove this limit, please upgrade your account to GoPlus!");
               _loc2_.okButton = UtilDict.toDisplay("go","Upgrade Now");
               _loc2_.cancelButton = UtilDict.toDisplay("go","Later");
               _loc2_._btnDelete.addEventListener(MouseEvent.CLICK,this.onUpgradeBtnClick);
               _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
               _loc2_.y = 100;
               return;
            }
         }
         this.myAnimatedMask.addEventListener("EventFinished",this.rdyToAddScene);
         this.playShutterEffect();
      }
      
      private function playShutterEffect() : void
      {
         if(this.myAnimatedMask.isplaying)
         {
            this.myAnimatedMask.stopDrawing();
         }
         this.myAnimatedMask.startDrawing(this.mainStage._addSceneEffectLayer);
      }
      
      private function rdyToAddScene(param1:Event) : void
      {
         this.myAnimatedMask.removeEventListener("EventFinished",this.rdyToAddScene);
         this.myAnimatedMask.stopDrawing();
         this.doAddScene();
      }
      
      private function doAddScene() : void
      {
         if(this.currentScene)
         {
            this.currentScene.selection.clearCollection();
         }
         this.mainStage.hideCameraView();
         var _loc1_:AnimeScene = this.createScene();
         this.mainStage.callLater(this.sceneChangeEffect);
         var _loc2_:ICommand = new AddSceneCommand(this.movie,_loc1_,this.movie.currentIndex + 1,this.timeline);
         _loc2_.execute();
      }
      
      function updateSceneLength() : void
      {
         this.currentScene.doUpdateTimelineLength();
      }
      
      public function clearScenes() : void
      {
         if(this._movie.scenes.length > 0)
         {
            this._movie.removeAllScene();
            this._timeline.removeAllScenes();
            this._timeline.removeAllSounds();
         }
      }
      
      private function addSceneAt(param1:AnimeScene, param2:Number = 1, param3:Boolean = true) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:BitmapData = null;
         var _loc4_:AnimeScene;
         if((_loc4_ = this.getScene(param2)) != null)
         {
            _loc5_ = this.timeline.getSceneImageBitmapByIndex(this.getSceneIndex(_loc4_));
         }
         if(this._movie.currentScene)
         {
            _loc6_ = this.timeline.getSceneImageBitmapByIndex(this._movie.currentIndex);
         }
         else
         {
            _loc6_ = new BitmapData(100,100,false,16777215);
         }
         this.capScreenLock = true;
         this._movie.addSceneAt(param1,param2);
         if(param3)
         {
            if(this._movie.currentIndex == this._movie.scenes.length - 1)
            {
               this.timeline.moveSoundAfterAddScene(this.timeline.getSceneInfoByIndex(this._movie.currentIndex).totalPixel,this.timeline.getSceneInfoByIndex(this._movie.currentIndex - 1).startPixel + this.timeline.getSceneInfoByIndex(this._movie.currentIndex - 1).totalPixel);
            }
            else
            {
               this.timeline.moveSoundAfterAddScene(this.timeline.getSceneInfoByIndex(this._movie.currentIndex).totalPixel,this.timeline.getSceneInfoByIndex(this._movie.currentIndex).startPixel);
            }
         }
         if(this._addBlankScene)
         {
            _loc6_ = new BitmapData(100,100,false,16777215);
         }
         if(_loc6_)
         {
            this.timeline.updateSceneImageByBitmapData(this.getSceneIndex(param1),_loc6_);
         }
         var _loc7_:AnimeScene;
         if(_loc7_ = this.getScene(this._movie.currentIndex + 1))
         {
            _loc7_.doUpdateTimelineLength();
            if(_loc5_)
            {
               this.timeline.updateSceneImageByBitmapData(this.getSceneIndex(_loc7_),_loc5_);
            }
         }
         if(param1.transition)
         {
            this.updateSceneTransition(this.getSceneIndex(param1),param1);
         }
         this.capScreenLock = false;
         if(this._isLoadingTemplate)
         {
            SceneManager.checkSceneNum(this._movie.scenes.length);
         }
      }
      
      private function createScene(param1:String = "", param2:String = "") : AnimeScene
      {
         var _loc3_:AnimeScene = null;
         if(this._movie.currentScene != null && param1 == "")
         {
            if(param2 == "" && !this._addBlankScene)
            {
               _loc3_ = this._movie.currentScene.cloneNext();
            }
         }
         else
         {
            _loc3_ = new AnimeScene(param1);
         }
         if(_loc3_ == null)
         {
            _loc3_ = new AnimeScene();
         }
         _loc3_.console = this;
         if(param2 != "")
         {
            _loc3_.deSerialize(XML(param2),true,true,false);
         }
         if(!_loc3_.sizingAsset && Console.getConsole().metaData.mver > 3)
         {
            SceneManager.addDefaultZoomEffect(_loc3_);
         }
         return _loc3_;
      }
      
      public function addScene(param1:Number = 0, param2:String = "", param3:String = "", param4:Boolean = true) : AnimeScene
      {
         var _loc5_:AnimeScene = this.createScene(param2,param3);
         this._movie.addSceneAt(_loc5_,param1);
         return _loc5_;
      }
      
      public function clearCurrentScene() : void
      {
         var _loc2_:ICommand = null;
         var _loc1_:AnimeScene = this._movie.selection.currentScene;
         if(_loc1_)
         {
            this.mainStage.hideCameraView();
            _loc2_ = new ClearSceneCommand(_loc1_);
            _loc2_.execute();
         }
      }
      
      public function copyCurrentScene() : void
      {
         SceneManager.copyScene(this._movie.selection.currentScene);
      }
      
      public function deleteCurrentScene() : void
      {
         if(this.movie.length == 1)
         {
            this.clearCurrentScene();
         }
         else
         {
            SceneManager.deleteSelectedScene(this._movie,this._timeline);
         }
      }
      
      private function onSceneSelectionChange(param1:Event) : void
      {
         var _loc2_:int = this._movie.currentIndex;
         if(_loc2_ >= 0 && this._movie.selection.length == 1)
         {
            this._mainStage.sceneIndexStr = _loc2_ >= 0 ? "" + (_loc2_ + 1) : "";
            this._mainStage.hideCameraView();
            if(!this._skipSceneRendering)
            {
               this.mainStage.sceneEditor.sceneModel = this._movie.currentScene;
               this.propertiesWindow.assetTransitionPanel.sceneModel = this._movie.currentScene;
               if(this._initialized)
               {
                  this.propertiesWindow.sceneOptionPanel.target = this._movie.currentScene;
               }
               this.showOverTray(false);
            }
            this._skipSceneRendering = false;
            this._timeline.setCurrentSceneByIndex(this._movie.currentIndex);
            this._movie.currentScene.refreshEffectTray(this.effectTray);
            this.soundMute = this.soundMute;
            this.dispatchEvent(new IndexChangedEvent(IndexChangedEvent.CHANGE));
            if(this.isTutorialOn && _loc2_ == 0)
            {
               this.dispatchTutorialEvent(new TutorialEvent(TutorialEvent.SCENE_SELECTED));
            }
         }
      }
      
      private function onSceneAdded(param1:MovieEvent) : void
      {
         var _loc2_:AnimeScene = null;
         if(param1.index >= 0)
         {
            _loc2_ = this._movie.getSceneAt(param1.index);
            this._timeline.addScene(_loc2_.id,Timeline.BITMAP,0,_loc2_,param1.index);
            this.timeline.sceneLengthController.doChangeSceneLength(UtilUnitConvert.frameToPixel(_loc2_.totalFrames),param1.index);
            if(param1.index == this._movie.length - 1)
            {
               this.timeline.moveSoundAfterAddScene(this.timeline.getSceneInfoByIndex(param1.index).totalPixel,this.timeline.getSceneInfoByIndex(param1.index - 1).startPixel + this.timeline.getSceneInfoByIndex(param1.index - 1).totalPixel);
            }
            else
            {
               this.timeline.moveSoundAfterAddScene(this.timeline.getSceneInfoByIndex(param1.index).totalPixel,this.timeline.getSceneInfoByIndex(param1.index).startPixel);
            }
            this._movie.selection.currentScene = _loc2_;
            this.dispatchTutorialEvent(new TutorialEvent(TutorialEvent.SCENE_ADDED,this));
         }
      }
      
      private function onSceneRemoved(param1:MovieEvent) : void
      {
         if(param1.index >= 0)
         {
            this._timeline.removeScene(param1.index);
            if(param1.index == this._movie.length)
            {
               this._movie.currentIndex = param1.index - 1;
            }
            else
            {
               this._movie.currentIndex = param1.index;
            }
         }
      }
      
      private function onSceneMoved(param1:MovieEvent) : void
      {
         if(param1.sourceIndex >= 0 && param1.destIndex >= 0)
         {
            this._timeline.moveScene(param1.sourceIndex,param1.destIndex);
         }
      }
      
      public function moveScene(param1:Number, param2:Number) : void
      {
         var _loc3_:IFlexDisplayObject = null;
         var _loc4_:ICommand = null;
         if(this._timeline.getNumOfSoundStartAtScene(param1) > 0)
         {
            _loc3_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,GoPopUp,true);
            _loc3_.width = 500;
            _loc3_.y = 100;
            _loc3_.x = (_loc3_.stage.width - _loc3_.width) / 2;
            GoPopUp(_loc3_).text = UtilDict.toDisplay("go","Please remove the sound(s) in this scene before moving it.");
         }
         else
         {
            (_loc4_ = new MoveSceneCommand(this._movie,param1,param2)).execute();
         }
      }
      
      public function loadMovieByXML(param1:XML) : void
      {
         this._movieXML = param1;
         var _loc2_:URLRequest = new URLRequest(ServerConstants.ACTION_GET_MOVIE_BY_XML);
         _loc2_.method = URLRequestMethod.POST;
         var _loc3_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc3_);
         _loc3_[ServerConstants.PARAM_MOVIE_XML] = param1;
         _loc2_.data = _loc3_;
         this._isLoadding = true;
         this.loadProgress = 0;
         var _loc4_:URLStream;
         (_loc4_ = new URLStream()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.doLoadMovieComplete);
         _loc4_.load(_loc2_);
      }
      
      public function insertSceneTemplate(param1:TemplateThumb, param2:Number) : void
      {
         this._selectedTemplateThumb = param1;
         if(param1 && !this._isLoadingTemplate)
         {
            this._isLoadingTemplate = true;
            this._insertSceneAtIndex = param2;
            this.playShutterEffect();
            if(param1.templateXml)
            {
               this._movieXML = param1.templateXml;
               this.deserialMovie();
            }
            else
            {
               this.loadMovieById(param1.aid);
            }
         }
      }
      
      private function loadMovieById(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         this._movieXML = null;
         var _loc4_:URLVariables = new URLVariables();
         var _loc5_:URLVariables = new URLVariables();
         var _loc6_:UtilHashArray = Util.getFlashVar();
         if(this._isLoadingTemplate)
         {
            Util.setFlashVar(ServerConstants.PARAM_MOVIE_ID,param1);
         }
         _loc5_[ServerConstants.PARAM_MOVIE_ID] = param1;
         _loc5_[ServerConstants.PARAM_USER_ID] = _loc6_.getValueByKey(ServerConstants.PARAM_USER_ID) as String;
         _loc5_[ServerConstants.PARAM_USER_TOKEN] = _loc6_.getValueByKey(ServerConstants.PARAM_USER_TOKEN) as String;
         if(UtilLicense.isBoxEnvironment())
         {
            _loc5_[ServerConstants.PARAM_BOX_PHP_SESSION_ID] = _loc6_.getValueByKey(ServerConstants.PARAM_FLASHVAR_PHP_SESSION_ID);
         }
         Util.addFlashVarsToURLvar(_loc4_);
         _loc2_ = ServerConstants.ACTION_GET_MOVIE + "?" + _loc5_.toString();
         _loc3_ = new URLRequest(_loc2_);
         if(!this._isLoadingTemplate)
         {
            _loc8_ = String(_loc4_[ServerConstants.PARAM_MOVIE_ID]);
            _loc9_ = String(_loc4_[ServerConstants.PARAM_ORIGINAL_ID]);
            if(_loc8_ != null && StringUtil.trim(_loc8_))
            {
               this.metaData.movieId = _loc8_;
            }
            else if(_loc9_ != null && StringUtil.trim(_loc9_))
            {
               _loc4_[ServerConstants.PARAM_MOVIE_ID] = _loc9_;
               this._originalId = _loc9_;
            }
         }
         _loc4_[ServerConstants.PARAM_IS_EDIT_MODE] = "1";
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc4_;
         var _loc7_:URLLoader;
         (_loc7_ = new URLLoader()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc7_.addEventListener(Event.COMPLETE,this.doLoadMovieComplete);
         _loc7_.dataFormat = URLLoaderDataFormat.BINARY;
         this.requestLoadStatus(true,true);
         _loc7_.load(_loc3_);
      }
      
      public function copyMovieById(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         this._movieXML = null;
         var _loc4_:URLVariables = new URLVariables();
         var _loc5_:UtilHashArray = Util.getFlashVar();
         Util.addFlashVarsToURLvar(_loc4_);
         _loc2_ = ServerConstants.ACTION_GET_MOVIE;
         _loc3_ = new URLRequest(_loc2_);
         _loc4_[ServerConstants.PARAM_MOVIE_ID] = _loc4_[ServerConstants.PARAM_ORIGINAL_ID] = param1;
         this._originalId = param1;
         _loc4_[ServerConstants.PARAM_IS_EDIT_MODE] = "1";
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc4_;
         this.loadProgress = 0;
         var _loc6_:URLLoader;
         (_loc6_ = new URLLoader()).addEventListener(ProgressEvent.PROGRESS,this.showProgress);
         _loc6_.addEventListener(Event.COMPLETE,this.doLoadMovieComplete);
         _loc6_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc6_.load(_loc3_);
      }
      
      private function isEditMode() : Boolean
      {
         return this.getIdToLoad() != "" ? true : false;
      }
      
      private function getIdToLoad() : String
      {
         var _loc1_:String = "";
         var _loc2_:String = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_MOVIE_ID) as String;
         var _loc3_:String = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ORIGINAL_ID) as String;
         var _loc4_:Boolean = false;
         if(_loc2_ != null && StringUtil.trim(_loc2_).length > 0)
         {
            _loc4_ = true;
            _loc1_ = _loc2_;
         }
         else if(_loc3_ != null && StringUtil.trim(_loc3_).length > 0)
         {
            _loc4_ = true;
            _loc1_ = _loc3_;
         }
         return _loc1_;
      }
      
      private function doLoadMovie(param1:Event) : void
      {
         var turnOffLoading:Function = null;
         var event:Event = param1;
         if(event)
         {
            (event.target as IEventDispatcher).removeEventListener(event.type,this.doLoadMovie);
         }
         this.onStudioReady();
         var idToLoad:String = this.getIdToLoad();
         if(idToLoad != "")
         {
            this.requestLoadStatus(true,true);
            turnOffLoading = function(... rest):void
            {
               var _loc3_:ItemClickEvent = null;
               var _loc2_:Console = Console.getConsole();
               _loc2_.requestLoadStatus(false,true);
               if(studioType == MESSAGE_STUDIO)
               {
                  _loc3_ = new ItemClickEvent(ItemClickEvent.ITEM_CLICK);
                  _loc3_.index = 1;
                  thumbTray.onClickThemeButton(_loc3_);
                  thumbTray.VSThumbTray.selectedChild = thumbTray._uiCanvasUser;
               }
            };
            this.addEventListener(CoreEvent.LOAD_MOVIE_COMPLETE,turnOffLoading);
            this.loadMovieById(idToLoad);
         }
         else
         {
            this.trackInitialTheme();
            this.newAnimation();
            this._initialized = true;
            Util.gaTracking("/gostudio/themeCompleted",Console.getConsole().mainStage.stage);
         }
      }
      
      private function trackInitialTheme() : void
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = String(_loc1_.getValueByKey(ServerConstants.FLASHVAR_DEFAULT_TRAYTHEME));
         var _loc3_:String = String(_loc1_.getValueByKey(ServerConstants.FLASHVAR_THEME_ID));
         var _loc4_:String = ThemeManager.instance.currentTheme.id;
         this._initThemeCode = _loc4_;
      }
      
      private function stopScene(param1:Function, param2:Number) : void
      {
         var _loc3_:AnimeScene = null;
         var _loc4_:int = 0;
         if(param2 > 0)
         {
            param2--;
            Console.getConsole().mainStage.callLater(param1,new Array(param1,param2));
         }
         else
         {
            _loc4_ = 1;
            while(_loc4_ < this._movie.scenes.length)
            {
               _loc3_ = Console.getConsole().getScene(_loc4_);
               _loc3_.stopScene();
               _loc4_++;
            }
         }
      }
      
      private function doContinueEdit(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AnimeScene = null;
         if(this._viewStackWindow != null)
         {
            this._viewStackWindow.removeEventListener(Event.CANCEL,this.doContinueEdit);
            this._viewStackWindow.destory();
         }
         PopUpManager.removePopUp(this._viewStackWindow);
         this._viewStackWindow = null;
         this._publishW = null;
         this._saveTempW = null;
         this._previewData.removeAll();
         if(this._movie.currentScene != null)
         {
            this._movie.currentScene.playScene();
         }
         if(this.isTutorialOn)
         {
            this.dispatchTutorialEvent(new TutorialEvent(TutorialEvent.PREVIEW_DONE,this));
            this._guideMode = ServerConstants.FLASHVAR_TM_FIN;
            _loc2_ = 0;
            while(_loc2_ < this._movie.scenes.length)
            {
               _loc3_ = this.getScene(_loc2_);
               _loc3_.meltAllAssets();
               _loc2_++;
            }
         }
      }
      
      public function showSignup() : void
      {
         ExternalInterface.call("startSignupProcess");
      }
      
      public function showLogin() : void
      {
         ExternalInterface.call("startLoginProcess");
      }
      
      public function publishTemplate() : void
      {
         this.prepareSaveTemplateThumbnailScene();
      }
      
      public function publishMovie(param1:PublishWindow, param2:Boolean, param3:Boolean, param4:Boolean = false) : void
      {
         this.movie.published = param2;
         this.movie.privateShared = param3;
         this._metaData = this._tempMetaData;
         this._redirect = param4;
         Console.getConsole().groupController.currentGroup = Console.getConsole().groupController.tempCurrentGroup;
         if(this._redirect)
         {
            this.addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showShareWindow);
            this.addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showShareWindow);
         }
         this.addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showSaveMovieError);
         this.addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showSaveMovieError);
         this.prepareSaveMovieThumbnailScene();
      }
      
      private function showSaveMovieError(param1:CoreEvent) : void
      {
         var _loc2_:GoAlert = null;
         var _loc3_:Error = null;
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc6_:Feedback = null;
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.showSaveMovieError);
         this.removeEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showSaveMovieError);
         if(param1.type == CoreEvent.SAVE_MOVIE_ERROR_OCCUR)
         {
            _loc3_ = param1.getData() as Error;
            this.enableAfterSave();
            if(_loc3_.message == ServerConstants.ERROR_CODE_SAVE_MOVIE_BLOCKED_BY_VIDEO_RECORDING)
            {
               _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
               _loc4_ = UtilDict.toDisplay("go","constant_save_movie_error_due_to_video_record");
               _loc2_.width = 400;
               _loc2_.height = 300;
            }
            else if(_loc3_ is IOError)
            {
               _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
               _loc4_ = UtilDict.toDisplay("go","constant_connecterr");
            }
            else
            {
               if((_loc5_ = XML(_loc3_.message)).code.text() == "ERROR")
               {
                  (_loc6_ = Feedback(PopUpManager.createPopUp(this.mainStage,Feedback,true))).error = _loc3_;
                  _loc6_.x = (_loc6_.stage.width - _loc6_.width) / 2;
                  _loc6_.y = 100;
                  return;
               }
               _loc2_ = GoAlert(PopUpManager.createPopUp(this.mainStage,GoAlert,true));
               _loc4_ = UtilDict.toDisplay("go",_loc5_.message.text());
            }
            _loc2_.showButton(false,true);
            _loc2_._txtDelete.htmlText = _loc4_;
            _loc2_._btnCancel.label = UtilDict.toDisplay("go","ok");
            _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
            _loc2_.y = 100;
         }
      }
      
      public function prepareSaveTemplateThumbnailScene() : void
      {
         var _loc1_:AnimeScene = null;
         this._isAutoSave = false;
         this._selectedSceneIndexBeforeCapture = this._movie.currentIndex;
         _loc1_ = this._movie.getSceneAt(this.selectedThumbForTempIndex);
         if(_loc1_ != this.currentScene)
         {
            this.mainStage.sceneEditor.addEventListener(SceneViewEvent.VIEW_LOAD_COMPLETE,this.onPreparedThumbnailTemplateScene);
            this.currentScene = _loc1_;
         }
         else
         {
            this.saveTemplate();
         }
      }
      
      private function onPreparedThumbnailTemplateScene(param1:Event) : void
      {
         (param1.currentTarget as IEventDispatcher).removeEventListener(param1.type,this.onPreparedThumbnailTemplateScene);
         this.saveTemplate();
         this._movie.currentIndex = this._selectedSceneIndexBeforeCapture;
      }
      
      public function prepareSaveMovieThumbnailScene() : void
      {
         var _loc1_:AnimeScene = null;
         this._isAutoSave = false;
         this._selectedSceneIndexBeforeCapture = this._movie.currentIndex;
         _loc1_ = this._movie.getSceneAt(this.selectedThumbnailIndex);
         if(_loc1_ != this.currentScene)
         {
            this.mainStage.sceneEditor.addEventListener(SceneViewEvent.VIEW_LOAD_COMPLETE,this.onPreparedThumbnailScene);
            this.currentScene = _loc1_;
         }
         else
         {
            this.saveMovie();
         }
      }
      
      private function onPreparedThumbnailScene(param1:Event) : void
      {
         (param1.currentTarget as IEventDispatcher).removeEventListener(param1.type,this.onPreparedThumbnailScene);
         this.saveMovie();
         this._movie.currentIndex = this._selectedSceneIndexBeforeCapture;
      }
      
      private function unloadThumbnailScene(param1:int = 0) : void
      {
      }
      
      public function saveTemplate() : void
      {
         var request:URLRequest = null;
         var variables:URLVariables = null;
         var saveThumbnail:Boolean = false;
         var movieManager:MovieManager = null;
         var encodedThumb:Base64Encoder = null;
         var encodedThumbLarge:Base64Encoder = null;
         var fileName:String = null;
         var fileData:ByteArray = null;
         var zipOut:ZipOutput = null;
         var ze:ZipEntry = null;
         var zipData:ByteArray = null;
         var encodedMovie:Base64Encoder = null;
         var logger:UtilErrorLogger = null;
         var flashVars:UtilHashArray = Util.getFlashVar();
         try
         {
            if(!(this._isAutoSave && this._publishW == null))
            {
               variables = new URLVariables();
               this._filmXML = this.serialize(false,this._currSceneOnlyForTemp,true);
               this.dispatchEvent(new CoreEvent(CoreEvent.SERIALIZE_COMPLETE,this));
               Util.addFlashVarsToURLvar(variables);
               saveThumbnail = true;
               variables[ServerConstants.PARAM_MOVIE_ID] = "";
               variables[ServerConstants.PARAM_SAVE_THUMBNAIL] = !!saveThumbnail ? "1" : "0";
               if(saveThumbnail)
               {
                  encodedThumb = new Base64Encoder();
                  encodedThumbLarge = new Base64Encoder();
                  encodedThumb.encodeBytes(this.getMovieThumbnail(false,this.selectedThumbForTempIndex));
                  encodedThumbLarge.encodeBytes(this.getMovieThumbnail(false,this.selectedThumbForTempIndex,1));
                  variables[ServerConstants.PARAM_THUMBNAIL] = encodedThumb.flush();
                  variables[ServerConstants.PARAM_THUMBNAIL_LARGE] = encodedThumbLarge.flush();
               }
               if(UtilLicense.useZipAsBodyXML())
               {
                  fileName = PlayerConstant.FILM_XML_FILENAME;
                  fileData = new ByteArray();
                  fileData.writeUTFBytes(this._filmXML.toString());
                  zipOut = new ZipOutput();
                  ze = new ZipEntry(fileName);
                  zipOut.putNextEntry(ze);
                  zipOut.write(fileData);
                  zipOut.closeEntry();
                  zipOut.finish();
                  zipData = zipOut.byteArray;
                  encodedMovie = new Base64Encoder();
                  encodedMovie.encodeBytes(zipData);
                  variables[ServerConstants.PARAM_BODY_ZIP] = encodedMovie.flush();
               }
               else
               {
                  variables[ServerConstants.PARAM_BODY] = this._filmXML;
               }
               movieManager = new MovieManager();
               movieManager.addEventListener(Event.COMPLETE,this.doSaveTemplateComplete);
               movieManager.addEventListener(IOErrorEvent.IO_ERROR,this.doSaveTemplateComplete);
               movieManager.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doSaveTemplateComplete);
               movieManager.saveTemplate(variables);
            }
         }
         catch(exception:Error)
         {
            dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,exception));
         }
         finally
         {
            logger = UtilErrorLogger.getInstance();
            logger.flush();
         }
      }
      
      public function saveMovie() : void
      {
         var flashVars:UtilHashArray = null;
         var request:URLRequest = null;
         var variables:URLVariables = null;
         var saveThumbnail:Boolean = false;
         var movieManager:MovieManager = null;
         var encodedThumb:Base64Encoder = null;
         var encodedThumbLarge:Base64Encoder = null;
         var fileName:String = null;
         var fileData:ByteArray = null;
         var zipOut:ZipOutput = null;
         var ze:ZipEntry = null;
         var zipData:ByteArray = null;
         var encodedMovie:Base64Encoder = null;
         var logger:UtilErrorLogger = null;
         flashVars = Util.getFlashVar();
         try
         {
            if(!(this._isAutoSave && this._publishW != null))
            {
               if(!this._isAutoSave)
               {
                  this.requestLoadStatus(true,true);
                  if(this.movie.published)
                  {
                     Util.gaTracking("/gostudio/SaveShare",Console.getConsole().mainStage.stage);
                  }
                  else if(this._redirect)
                  {
                     Util.gaTracking("/gostudio/SaveAndClose",Console.getConsole().mainStage.stage);
                  }
                  else
                  {
                     Util.gaTracking("/gostudio/SaveOnly",Console.getConsole().mainStage.stage);
                  }
                  if(this._redirect)
                  {
                     Util.gaTracking("/gostudio/onExitDiversion",Console.getConsole().mainStage.stage);
                  }
               }
               else
               {
                  this._topButtonBar._btnSave.buttonMode = false;
                  this._topButtonBar._btnSave.enabled = false;
                  this._topButtonBar.currentState = "autoSave";
               }
               if(this._publishW != null)
               {
                  this._publishW.setBtnStatus(false);
               }
               variables = new URLVariables();
               this._filmXML = this.serialize(false);
               if(this._filmXML..serializeError.length() > 0)
               {
                  UtilPopUp.alert("Your video has been saved. However, we detected instablilty in your browser. Please close this window and reload the video maker.");
                  variables["error"] = "1";
               }
               this.dispatchEvent(new CoreEvent(CoreEvent.SERIALIZE_COMPLETE,this));
               if(this._isAutoSave)
               {
                  if(this.metaData.movieId != null && this._filmXML.children().toXMLString() == this._movieXML.children().toXMLString() && this.siteId != String(Global.BEN10))
                  {
                     this.enableAfterSave();
                     this._isAutoSave = false;
                     return;
                  }
                  if(this.metaData.movieId != null)
                  {
                     variables[ServerConstants.PARAM_AUTOSAVE] = 1;
                  }
                  variables[ServerConstants.PARAM_IS_TRIGGER_BY_AUTOSAVE] = 1;
                  Util.gaTracking(AnimeConstants.GA_ACTION__AUTO_SAVE,this.mainStage.stage);
               }
               Util.addFlashVarsToURLvar(variables);
               saveThumbnail = true;
               if(this._isAutoSave)
               {
                  if(this.metaData.movieId != null)
                  {
                     saveThumbnail = false;
                  }
                  else
                  {
                     this.selectedThumbnailIndex = this._movie.currentIndex;
                  }
               }
               variables[ServerConstants.PARAM_SAVE_THUMBNAIL] = !!saveThumbnail ? "1" : "0";
               if(saveThumbnail)
               {
                  encodedThumb = new Base64Encoder();
                  encodedThumbLarge = new Base64Encoder();
                  encodedThumb.encodeBytes(this.getMovieThumbnail(false,this.selectedThumbnailIndex));
                  encodedThumbLarge.encodeBytes(this.getMovieThumbnail(false,this.selectedThumbnailIndex,1));
                  variables[ServerConstants.PARAM_THUMBNAIL] = encodedThumb.flush();
                  variables[ServerConstants.PARAM_THUMBNAIL_LARGE] = encodedThumbLarge.flush();
               }
               variables["publish_quality"] = this.publishQuality;
               if(UtilLicense.useZipAsBodyXML())
               {
                  fileName = PlayerConstant.FILM_XML_FILENAME;
                  fileData = new ByteArray();
                  fileData.writeUTFBytes(this._filmXML.toString());
                  zipOut = new ZipOutput();
                  ze = new ZipEntry(fileName);
                  zipOut.putNextEntry(ze);
                  zipOut.write(fileData);
                  zipOut.closeEntry();
                  zipOut.finish();
                  zipData = zipOut.byteArray;
                  encodedMovie = new Base64Encoder();
                  encodedMovie.encodeBytes(zipData);
                  variables[ServerConstants.PARAM_BODY_ZIP] = encodedMovie.flush();
               }
               else
               {
                  variables[ServerConstants.PARAM_BODY] = this._filmXML;
               }
               delete variables[ServerConstants.PARAM_MOVIE_ID];
               if(this.metaData.movieId != null)
               {
                  variables[ServerConstants.PARAM_MOVIE_ID] = this.metaData.movieId;
               }
               if(this.metaData.movieId == null && this._initThemeCode != null)
               {
                  variables[ServerConstants.PARAM_INITIAL_THEME_CODE] = this._initThemeCode;
               }
               variables[ServerConstants.PARAM_LANG] = this.metaData.lang;
               delete variables[ServerConstants.PARAM_ORIGINAL_ID];
               if(this.metaData.originalId != null && StringUtil.trim(this.metaData.originalId))
               {
                  variables[ServerConstants.PARAM_ORIGINAL_ID] = this.metaData.originalId;
               }
               if(Console.getConsole().studioType == MESSAGE_STUDIO)
               {
                  variables[ServerConstants.PARAM_EMESSAGE] = 1;
               }
               if(Console.getConsole().boxMode)
               {
                  variables[ServerConstants.PARAM_BOX_PHP_SESSION_ID] = flashVars.getValueByKey(ServerConstants.PARAM_FLASHVAR_PHP_SESSION_ID);
               }
               if(this.groupController.isSchoolProject)
               {
                  variables[ServerConstants.PARAM_GROUP_ID] = this.groupController.currentGroup.id;
                  variables[ServerConstants.PARAM_CATEGORY] = this.groupController.category;
               }
               if(UtilSite.siteId == UtilSite.YOUTUBE)
               {
                  variables[ServerConstants.PARAM_YOUTUBE_PUBLISH] = !!this.movie.published ? "publish" : "private";
               }
               if(UtilSite.siteId == UtilSite.SKOLETUBE)
               {
                  variables[ServerConstants.PARAM_GROUP_ID] = !!this.groupController.currentGroup ? this.groupController.currentGroup.id : "0";
                  variables[ServerConstants.PARAM_SKOLETUBE_PUBLISH] = !!this.movie.published ? "publish" : "private";
               }
               movieManager = new MovieManager();
               movieManager.addEventListener(Event.COMPLETE,this.doSaveMovieComplete);
               movieManager.addEventListener(IOErrorEvent.IO_ERROR,this.doSaveMovieComplete);
               movieManager.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doSaveMovieComplete);
               movieManager.saveMovie(variables);
            }
            else
            {
               this._isAutoSave = false;
            }
         }
         catch(exception:Error)
         {
            dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,exception));
         }
         finally
         {
            logger = UtilErrorLogger.getInstance();
            logger.flush();
         }
      }
      
      private function enableAfterSave() : void
      {
         this.requestLoadStatus(false,true);
         if(this._isAutoSave)
         {
            this._topButtonBar._btnSave.enabled = true;
            this._topButtonBar._btnSave.buttonMode = true;
            this._topButtonBar.currentState = "";
         }
         if(!this._isAutoSave)
         {
            if(this._publishW != null)
            {
               this.closePublishWindow();
            }
            if(this._saveTempW != null)
            {
            }
            if(this._viewStackWindow != null && !this._redirect)
            {
               this.doContinueEdit();
            }
         }
      }
      
      private function doSaveTemplateComplete(param1:Event) : void
      {
         var _loc2_:SaveMovieCompleteEvent = null;
         var _loc3_:String = null;
         _loc2_ = null;
         if(param1 is SaveMovieCompleteEvent)
         {
            _loc2_ = param1 as SaveMovieCompleteEvent;
         }
         if(param1.type != Event.COMPLETE)
         {
         }
         this.enableAfterSave();
         if(param1.type == Event.COMPLETE)
         {
            _loc3_ = _loc2_.message;
            this._thumbTray.showUserGoodies(AnimeConstants.ASSET_TYPE_TEMPLATE);
            this._thumbTray.show();
            this.customAssetUploadCompleteHandler(_loc2_.status + _loc3_,AnimeConstants.ASSET_TYPE_TEMPLATE);
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_COMPLETE,this));
         }
         else if(param1.type == IOErrorEvent.IO_ERROR)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,new IOError()));
         }
         else if(!(this._isAutoSave && param1.type == IOErrorEvent.IO_ERROR) && _loc2_)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,new Error(_loc2_.message)));
         }
      }
      
      private function doSaveMovieComplete(param1:Event) : void
      {
         var _event:SaveMovieCompleteEvent = null;
         var currDate:Date = null;
         var localTime:String = null;
         var delaySaveComplete:Boolean = false;
         var i:int = 0;
         var sid:String = null;
         var bm:BitmapData = null;
         var pngEncoder:PNGEncoder = null;
         var barr:ByteArray = null;
         var flushStatus:String = null;
         var event:Event = param1;
         _event = null;
         if(event is SaveMovieCompleteEvent)
         {
            _event = event as SaveMovieCompleteEvent;
         }
         if(event.type == Event.COMPLETE)
         {
            currDate = new Date();
            localTime = UtilUnitConvert.getClockTime(currDate.getHours(),currDate.getMinutes());
            this.topButtonBar._btnSave.toolTip = UtilDict.toDisplay("go","topbtnbar_savenshare") + " (" + UtilDict.toDisplay("go","topbtnbar_lastsaved") + ": " + localTime + ")";
         }
         this.enableAfterSave();
         if(event.type == Event.COMPLETE && _event)
         {
            this.metaData.movieId = _event.message;
            this.tempMetaData.movieId = this.metaData.movieId;
            this._watermarkManager.saveWatermark(this.metaData.movieId);
            FlexGlobals.topLevelApplication.parameters["movieId"] = this.metaData.movieId;
            if(this._isAutoSave)
            {
               this.mainStage.showAutoSaveHints();
            }
            this._movieXML = this._filmXML;
            delaySaveComplete = false;
            try
            {
               this.thumbSO = SharedObject.getLocal("studioThumbs_" + this.metaData.movieId);
            }
            catch(e:Error)
            {
               thumbSO = null;
            }
            if(!UtilSystem.isLion())
            {
            }
            if(this.thumbSO)
            {
               i = 0;
               while(i < this._movie.scenes.length)
               {
                  sid = this.getScene(i).id;
                  bm = Console.getConsole().getThumbnailCaptureBySceneIndex(i);
                  pngEncoder = new PNGEncoder();
                  barr = pngEncoder.encode(bm);
                  barr.position = 0;
                  this.thumbSO.data[sid] = barr;
                  i++;
               }
               try
               {
                  flushStatus = this.thumbSO.flush();
                  if(flushStatus == SharedObjectFlushStatus.PENDING)
                  {
                     this.thumbSO.addEventListener(NetStatusEvent.NET_STATUS,this.soStatusListener);
                     delaySaveComplete = true;
                  }
                  else if(flushStatus == SharedObjectFlushStatus.FLUSHED)
                  {
                  }
               }
               catch(e:Error)
               {
               }
            }
            if(!delaySaveComplete)
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_COMPLETE,this));
            }
         }
         else if(event.type == IOErrorEvent.IO_ERROR)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,new IOError()));
         }
         else if(!(this._isAutoSave && event.type == IOErrorEvent.IO_ERROR) && _event)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this,new Error(_event.message)));
         }
         this._isAutoSave = false;
      }
      
      private function soStatusListener(param1:NetStatusEvent) : void
      {
         if(param1.info.code != "SharedObject.Flush.Success")
         {
            if(param1.info.code == "SharedObject.Flush.Failed")
            {
            }
         }
         this.thumbSO.removeEventListener(NetStatusEvent.NET_STATUS,this.soStatusListener);
         this.dispatchEvent(new CoreEvent(CoreEvent.SAVE_MOVIE_COMPLETE,this));
      }
      
      public function closePublishWindow() : void
      {
         if(this._publishW != null)
         {
            this.publishW = null;
         }
      }
      
      public function closeSaveTempWindow() : void
      {
         if(this._saveTempW != null)
         {
            PopUpManager.removePopUp(this._saveTempW);
            this._saveTempW = null;
         }
      }
      
      private function doNavigateToPlayerPage(param1:Event) : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:URLRequest = null;
         var _loc4_:UtilHashArray = null;
         var _loc5_:String = null;
         var _loc6_:RegExp = null;
         this.removeEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.doNavigateToPlayerPage);
         _loc2_ = new URLVariables();
         _loc4_ = Util.getFlashVar();
         Util.gaTracking("/gostudio/close",Console.getConsole().mainStage.stage);
         if(_loc4_.containsKey(ServerConstants.SERVER_PLAYER_PARAM_USER_ID))
         {
            _loc2_[ServerConstants.SERVER_PLAYER_PARAM_USER_ID] = _loc4_.getValueByKey(ServerConstants.SERVER_PLAYER_PARAM_USER_ID) as String;
         }
         _loc5_ = _loc4_.getValueByKey(ServerConstants.FLASHVAR_NEXT_URL) as String;
         _loc6_ = new RegExp(ServerConstants.FLASHVAR_NEXT_URL_PLACEHOLDER,"g");
         _loc5_ = _loc5_.replace(_loc6_,this.metaData.movieId);
         _loc3_ = new URLRequest(_loc5_ + _loc2_.toString());
         navigateToURL(_loc3_,"_self");
      }
      
      private function doLoadMovieComplete(param1:Event) : void
      {
         var urlLoader:URLLoader = null;
         var bytesLoaded:ByteArray = null;
         var checkCode:int = 0;
         var zip:ZipFile = null;
         var sceneXML:XML = null;
         var bubbleXML:XML = null;
         var _fontManager:FontManager = null;
         var i:int = 0;
         var loadMgr:UtilLoadMgr = null;
         var themeTrees:UtilHashArray = null;
         var curThemeId:String = null;
         var j:int = 0;
         var filename:String = null;
         var curThemeXml:XML = null;
         var th:Theme = null;
         var bytes:ByteArray = null;
         var event:Event = param1;
         urlLoader = event.target as URLLoader;
         bytesLoaded = urlLoader.data as ByteArray;
         checkCode = bytesLoaded.readByte();
         if(checkCode == 0)
         {
            zip = new ZipFile(bytesLoaded);
            this._movieXML = new XML(zip.getInput(zip.getEntry(AnimeConstants.MOVIE_XML_FILENAME)));
            if(this._selectedTemplateThumb)
            {
               this._selectedTemplateThumb.templateXml = this._movieXML;
            }
            if(this._movieXML != null)
            {
               _fontManager = FontManager.getFontManager();
               i = 0;
               while(i < this._movieXML.child(AnimeScene.XML_NODE_NAME).length())
               {
                  sceneXML = this._movieXML.child(AnimeScene.XML_NODE_NAME)[i];
                  j = 0;
                  while(j < sceneXML.child(BubbleAsset.XML_NODE_NAME).length())
                  {
                     bubbleXML = sceneXML.child(BubbleAsset.XML_NODE_NAME)[j];
                     if(!_fontManager.isFontLoaded(bubbleXML.child("bubble")[0].child("text")[0].@font) && bubbleXML.child("bubble")[0].child("text")[0].@embed != "false")
                     {
                        filename = _fontManager.nameToFileName(bubbleXML.child("bubble")[0].child("text")[0].@font) + ".swf";
                        _fontManager.getFonts().push(bubbleXML.child("bubble")[0].child("text")[0].@font,zip.getInput(zip.getEntry(filename)),true);
                     }
                     j++;
                  }
                  i++;
               }
               loadMgr = new UtilLoadMgr();
               themeTrees = this.getThemeTrees(this._movieXML,zip);
               i = 0;
               while(i < themeTrees.length)
               {
                  curThemeId = (themeTrees.getValueByIndex(i) as ThemeTree).getThemeID();
                  if(ThemeManager.instance.getTheme(curThemeId) == null)
                  {
                     th = new Theme();
                     ThemeManager.instance.addTheme(curThemeId,th);
                     th.modifyPremiumContent(this._purchasedAssetsXML.(@theme == curThemeId));
                  }
                  curThemeXml = new XML(zip.getInput(zip.getEntry(curThemeId + ".xml")).toString());
                  loadMgr.addEventDispatcher(ThemeManager.instance.getTheme(curThemeId).eventDispatcher,CoreEvent.LOAD_THEMETREE_COMPLETE);
                  ThemeManager.instance.getTheme(curThemeId).initThemeByThemeTree(themeTrees.getValueByIndex(i) as ThemeTree,curThemeXml,zip,this);
                  i++;
               }
               loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doInitFonts);
               loadMgr.commit();
               this.addEventListener(CoreEvent.LOAD_THEMETREE_COMPLETE,this.onPreparationFinish);
            }
         }
         else
         {
            bytes = new ByteArray();
            bytesLoaded.readBytes(bytes);
            Alert.show("Oops...fail to load video!\nthe return code is: " + checkCode + "\n error message: \n" + bytes.toString());
         }
         this.requestLoadStatus(false,true);
      }
      
      private function onLoadFontsDone(param1:LoadMgrEvent = null) : void
      {
         this.doLoadThemeTreesCompleted(param1 as LoadMgrEvent);
      }
      
      private function doInitFonts(param1:LoadMgrEvent) : void
      {
         var _loc2_:FontManager = null;
         var _loc3_:UtilLoadMgr = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Loader = null;
         var _loc7_:* = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doInitFonts);
         _loc2_ = FontManager.getFontManager();
         if(_loc2_.getFonts().length > 0)
         {
            _loc3_ = new UtilLoadMgr();
            _loc3_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadFontsDone);
            _loc5_ = 0;
            while(_loc5_ < _loc2_.getFonts().length)
            {
               _loc4_ = _loc2_.getFonts().getKey(_loc5_);
               (_loc6_ = new Loader()).name = _loc4_;
               _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontLoaded);
               _loc7_ = _loc2_.nameToFileName(_loc4_) + ".swf";
               _loc3_.addEventDispatcher(_loc6_.contentLoaderInfo,Event.COMPLETE);
               _loc6_.loadBytes(_loc2_.getFonts().getValueByKey(_loc4_));
               _loc5_++;
            }
            _loc3_.commit();
         }
         else
         {
            this.doLoadThemeTreesCompleted(param1 as LoadMgrEvent);
         }
      }
      
      private function onFontLoaded(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:FontManager = null;
         _loc2_ = (param1.target.loader as Loader).name;
         _loc3_ = FontManager.getFontManager();
         _loc3_.setFontAsLoaded(_loc2_,param1.target.bytes as ByteArray);
      }
      
      private function doLoadThemeTreesCompleted(param1:LoadMgrEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThemeTreesCompleted);
         this.dispatchEvent(new Event(CoreEvent.LOAD_THEMETREE_COMPLETE));
      }
      
      private function onPreparationFinish(param1:Event) : void
      {
         var metaNode:XML = null;
         var myMetaData:MetaData = null;
         var list:XMLList = null;
         var popup:IFlexDisplayObject = null;
         var e:Event = param1;
         if(this._isLoadingTemplate)
         {
            metaNode = this._movieXML.child(MetaData.XML_NODE_NAME)[0];
            myMetaData = new MetaData();
            myMetaData.deSerialize(metaNode,"","");
            if(myMetaData.mver <= 3 && this.metaData.mver > 3)
            {
               list = this._movieXML..effectAsset.effect.(@type == "ZOOM");
               if(list.length() > 0)
               {
                  popup = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,RemovingZoomWarning,true);
                  PopUpManager.centerPopUp(popup);
                  popup.addEventListener("okClick",this.deserialMovie);
                  return;
               }
            }
         }
         this.deserialMovie();
      }
      
      private function deserialMovie(param1:Event = null) : void
      {
         var _loc2_:String = null;
         if(this._isLoadingTemplate)
         {
            this.myAnimatedMask.stopDrawing();
         }
         _loc2_ = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ORIGINAL_ID) as String;
         this.deSerialize(this._movieXML,this.metaData.movieId,_loc2_);
         this._isLoadding = false;
         Util.gaTracking("/gostudio/themeCompleted",Console.getConsole().mainStage.stage);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_MOVIE_COMPLETE,this));
      }
      
      public function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc3_:int = 0;
         var _loc4_:XML = null;
         var _loc5_:UtilHashArray = null;
         _loc5_ = new UtilHashArray();
         _loc3_ = 0;
         while(_loc3_ < param1.child(AnimeScene.XML_NODE_NAME).length())
         {
            _loc4_ = param1.child(AnimeScene.XML_NODE_NAME)[_loc3_];
            ThemeTree.mergeThemeTrees(_loc5_,AnimeScene.getThemeTrees(_loc4_,param2,_loc5_));
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.child(AnimeSound.XML_NODE_NAME).length())
         {
            _loc4_ = param1.child(AnimeSound.XML_NODE_NAME)[_loc3_];
            ThemeTree.mergeThemeTrees(_loc5_,AnimeSound.getThemeTrees(_loc4_,param2));
            _loc3_++;
         }
         return _loc5_;
      }
      
      public function genDefaultTags() : void
      {
         var _loc1_:UtilHashArray = null;
         var _loc3_:UtilHashArray = null;
         var _loc4_:AnimeScene = null;
         var _loc5_:Thumb = null;
         var _loc6_:Thumb = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc1_ = new UtilHashArray();
         var _loc2_:UtilHashArray = new UtilHashArray();
         _loc3_ = new UtilHashArray();
         this.tempMetaData.clearHiddenTags();
         _loc7_ = 0;
         while(_loc7_ < this._movie.scenes.length)
         {
            if((_loc4_ = this._movie.getSceneAt(_loc7_)).characters.length > 0)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc4_.characters.length)
               {
                  _loc6_ = Character(_loc4_.characters.getValueByIndex(_loc8_)).thumb as Thumb;
                  if(_loc1_.getValueByKey(_loc6_.theme.id) == null)
                  {
                     _loc1_.push(_loc6_.theme.id,_loc6_.theme.id);
                     if(_loc6_.theme.id != "ugc")
                     {
                        this.tempMetaData.addHiddenTag(_loc6_.theme.id);
                     }
                  }
                  if(_loc3_.getValueByKey(_loc6_.id) == null)
                  {
                     _loc3_.push(_loc6_.id,_loc6_.id);
                     if(!_loc6_.isCC && _loc6_.theme.id != "ugc")
                     {
                        this.tempMetaData.addHiddenTag(_loc6_.id);
                     }
                  }
                  _loc8_++;
               }
            }
            _loc7_++;
         }
      }
      
      public function addRandomAssetsToScene(param1:Theme, param2:AnimeScene) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:BackgroundThumb = null;
         var _loc6_:SoundThumb = null;
         var _loc7_:UtilHashArray = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:int = 0;
         if(param1 == null || param2 == null)
         {
            throw new Error("Both theme and scene could not be null");
         }
         _loc7_ = new UtilHashArray();
         _loc8_ = new UtilHashArray();
         if((_loc5_ = param1.defaultBgThumb) != null && _loc5_.enable)
         {
            _loc7_.push(_loc5_.id,_loc5_);
         }
         _loc9_ = 0;
         while(_loc9_ < param1.soundThumbs.length)
         {
            if((_loc6_ = SoundThumb(param1.soundThumbs.getValueByIndex(_loc9_))).enable && _loc6_.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
            {
               _loc8_.push(_loc6_.id,_loc6_);
            }
            _loc9_++;
         }
         if(_loc7_.length > 0)
         {
            _loc3_ = Math.random();
            _loc4_ = _loc3_ * _loc7_.length;
            _loc5_ = BackgroundThumb(_loc7_.getValueByIndex(_loc4_));
            param2.createAsset(_loc5_);
         }
         if(_loc8_.length > 0)
         {
            _loc3_ = Math.random();
            _loc4_ = _loc3_ * _loc8_.length;
            _loc6_ = SoundThumb(_loc8_.getValueByIndex(_loc4_));
         }
         this._isMovieNew = false;
      }
      
      public function removeGuideBubbles() : void
      {
         this._needGuideBubbles = false;
         if(this._bubbleSceneGuide != null)
         {
            this.hideGuideSceneBub();
         }
         if(this._bubbleThumbGuide != null)
         {
            this.hideGuideThumbBub();
         }
      }
      
      public function showProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = Math.round(param1.bytesLoaded / param1.bytesTotal * 100);
         this.loadProgress = _loc2_;
         if(param1.bytesLoaded >= param1.bytesTotal)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.showProgress);
         }
      }
      
      public function initializeLoadingBar(param1:ProgressBar) : void
      {
         this._loadProgress = param1;
      }
      
      public function set loadProgress(param1:Number) : void
      {
         if(this._loadProgress)
         {
            this._loadProgress.visible = param1 < 100;
            this._loadProgress.setProgress(param1,100);
         }
      }
      
      public function get getLoadProgress() : MyProgressBar
      {
         return this._loadProgress as MyProgressBar;
      }
      
      public function set loadProgressVisible(param1:Boolean) : void
      {
         this._loadProgress.visible = param1;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function getThumbnailCaptures() : UtilHashArray
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:int = 0;
         _loc1_ = new UtilHashArray();
         _loc2_ = 0;
         while(_loc2_ < this.scenes.length)
         {
            _loc1_.push(String(_loc2_),null);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getCcCharCount() : void
      {
         var _loc1_:URLLoader = null;
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         _loc1_ = new URLLoader();
         _loc2_ = new URLRequest(ServerConstants.ACTION_GET_CC_CHAR_COUNT);
         _loc2_.method = URLRequestMethod.POST;
         _loc1_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc3_ = new URLVariables();
         Util.addFlashVarsToURLvar(_loc3_);
         _loc2_.data = _loc3_;
         _loc1_.addEventListener(Event.COMPLETE,this.onGetCcCharCountComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onGetCcCharCountComplete);
         _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onGetCcCharCountComplete);
         _loc1_.load(_loc2_);
      }
      
      private function onGetCcCharCountComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = null;
         var _loc3_:String = null;
         var _loc4_:LoadCcCharCountEvent = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onGetCcCharCountComplete);
         if(param1.type == Event.COMPLETE)
         {
            _loc2_ = param1.target as URLLoader;
            _loc3_ = _loc2_.data as String;
            if(_loc3_.length > 1 && _loc3_.charAt(0) == "0")
            {
               (_loc4_ = new LoadCcCharCountEvent(LoadCcCharCountEvent.CC_CHAR_COUNT_GOT,this)).ccCharCount = Number(_loc3_.substr(1));
               this.dispatchEvent(_loc4_);
            }
         }
      }
      
      public function getThumbnailCaptureBySceneIndex(param1:int) : BitmapData
      {
         return this.timeline.getSceneImageBitmapByIndex(param1);
      }
      
      private function removeGuideBubbleAfterFade(param1:Event) : void
      {
         var _loc2_:Fade = null;
         var _loc3_:Image = null;
         _loc2_ = param1.target as Fade;
         _loc3_ = _loc2_.target as Image;
         try
         {
            this.thumbTray.parent.removeChild(_loc3_);
         }
         catch(e:Error)
         {
         }
         if(_loc3_ == this._bubbleThumbGuide)
         {
            this._bubbleThumbGuide = null;
         }
         if(_loc3_ == this._bubbleSceneGuide)
         {
            this.mainStage.removeChild(_loc3_);
            this._bubbleSceneGuide = null;
         }
      }
      
      private function hideGuideThumbBub(param1:Event = null) : void
      {
         this.thumbTray.removeEventListener(MouseEvent.ROLL_OVER,this.hideGuideThumbBub);
         if(this._bubbleThumbGuide != null)
         {
            this._bubbleThumbGuide.removeEventListener(MouseEvent.CLICK,this.hideGuideThumbBub);
            this.hideGuideBubble(this._bubbleThumbGuide);
         }
      }
      
      public function hideGuideSceneBub(param1:Event = null) : void
      {
         if(this._bubbleSceneGuide != null)
         {
            this._bubbleSceneGuide.removeEventListener(MouseEvent.CLICK,this.hideGuideSceneBub);
            this.hideGuideBubble(this._bubbleSceneGuide);
         }
      }
      
      private function hideGuideBubble(param1:Image) : void
      {
         var _loc2_:Fade = null;
         _loc2_ = new Fade();
         _loc2_.target = param1;
         _loc2_.alphaFrom = 1;
         _loc2_.alphaTo = 0;
         _loc2_.easingFunction = Exponential.easeOut;
         _loc2_.addEventListener(EffectEvent.EFFECT_END,this.removeGuideBubbleAfterFade);
         _loc2_.play();
      }
      
      private function addGuideBubbles() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:XML = null;
         var _loc4_:Bubble = null;
         var _loc5_:Rectangle = null;
         var _loc6_:XML = null;
         var _loc7_:Bubble = null;
         _loc1_ = 106;
         if(this._studioType == TINY_STUDIO)
         {
            if(this._bubbleThumbGuide == null)
            {
               _loc3_ = <bubble x="0" y="0" w="180" h="90" rotate="0" type="ROUNDRECTANGULAR">
													<body rgb="16777215" alpha="0.9" linergb="0" tailx="25" taily="-34"/>
													<text rgb="0" font="TrebuchetMS1" size="35" align="center" bold="false" italic="false">
													  Mouse over here to bring out characters
													</text>
												  </bubble>;
               (_loc4_ = BubbleMgr.getBubbleByXML(_loc3_)).useDeviceFont = true;
               this._bubbleThumbGuide = new Image();
               this._bubbleThumbGuide.addChild(_loc4_);
               _loc5_ = this.thumbTray.getBounds(this.thumbTray);
               this._bubbleThumbGuide.x = 71;
               this._bubbleThumbGuide.y = _loc1_;
               this._bubbleThumbGuide.useHandCursor = true;
               this._bubbleThumbGuide.mouseChildren = false;
               this._bubbleThumbGuide.buttonMode = true;
            }
            this.thumbTray.parent.addChild(this._bubbleThumbGuide);
            this.thumbTray.addEventListener(MouseEvent.ROLL_OVER,this.hideGuideThumbBub);
            this._bubbleThumbGuide.addEventListener(MouseEvent.CLICK,this.hideGuideThumbBub);
         }
         _loc2_ = 361;
         _loc1_ = 381;
         if(this._studioType == FULL_STUDIO)
         {
            _loc2_ = this.mainStage.x + this.mainStage.width - 295;
            _loc1_ = this.mainStage.y + this.mainStage.height - 155;
         }
         if(this._bubbleSceneGuide == null)
         {
            _loc6_ = <bubble x="0" y="0" w="180" h="100" rotate="0" type="ELLIPSE">
						  <body rgb="16777215" alpha="0.9" linergb="0" tailx="164" taily="107"/>
							<text rgb="0" font="TrebuchetMS1" size="25" align="center" bold="false" italic="false" embed="false"></text>
						</bubble>;
            (_loc7_ = BubbleMgr.getBubbleByXML(_loc6_)).useDeviceFont = false;
            _loc7_.text = UtilDict.toDisplay("go","guide_bubble_text");
            this._bubbleSceneGuide = new Image();
            this._bubbleSceneGuide.addChild(_loc7_);
            this._bubbleSceneGuide.x = _loc2_;
            this._bubbleSceneGuide.y = _loc1_;
            this._bubbleSceneGuide.useHandCursor = true;
            this._bubbleSceneGuide.mouseChildren = false;
            this._bubbleSceneGuide.buttonMode = true;
         }
         this.mainStage.addChild(this._bubbleSceneGuide);
         this._bubbleSceneGuide.right = 250;
         this._bubbleSceneGuide.bottom = 150;
         this._bubbleSceneGuide.addEventListener(MouseEvent.CLICK,this.hideGuideSceneBub);
      }
      
      private function sceneChangeEffect() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Glow = null;
         var _loc3_:Blur = null;
         var _loc4_:Parallel = null;
         _loc1_ = 800;
         _loc2_ = new Glow();
         _loc2_.duration = 800;
         _loc2_.blurXFrom = 0;
         _loc2_.blurXTo = 60;
         _loc2_.blurYFrom = 0;
         _loc2_.blurYTo = 60;
         _loc2_.color = 0;
         _loc3_ = new Blur();
         _loc3_.duration = 800;
         _loc3_.blurXFrom = 10;
         _loc3_.blurXTo = 0;
         _loc3_.blurYFrom = 10;
         _loc3_.blurYTo = 0;
         (_loc4_ = new Parallel()).duration = _loc1_;
         _loc4_.targets = [this.mainStage.sceneEditor.view];
         _loc4_.addChild(_loc2_);
         _loc4_.addChild(_loc3_);
         _loc4_.play();
      }
      
      private function onSceneResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:ElementInfo = null;
         _loc2_ = Timeline(param1.currentTarget).getSceneInfoByIndex(param1.index);
         this._prevSceneLength = _loc2_.totalPixel;
         this._prevAllSoundInfo = Timeline(param1.currentTarget).getAllSoundInfo();
      }
      
      private function onSceneResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc2_:ElementInfo = null;
         var _loc3_:AnimeScene = null;
         var _loc4_:int = 0;
         var _loc5_:ICommand = null;
         _loc2_ = Timeline(param1.currentTarget).getSceneInfoByIndex(param1.index);
         if(this._prevSceneLength != _loc2_.totalPixel)
         {
            _loc3_ = this.getScene(param1.index);
            if(_loc3_)
            {
               _loc3_.updateEffectTray(_loc2_.totalPixel,this._prevSceneLength);
               _loc4_ = UtilUnitConvert.pixelToFrame(_loc2_.totalPixel);
               (_loc5_ = new ChangeSceneDurationCommand(_loc3_,_loc4_,AnimeScene.DURATION_MODE_CUSTOM,this.timeline,this._prevAllSoundInfo)).execute();
            }
         }
      }
      
      private function onSoundMouseDownHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.id;
         this._prevSoundInfo = this._timeline.getSoundInfoById(_loc2_);
         this._timeline.addEventListener(TimelineEvent.SOUND_MOUSE_UP,this.onSoundMouseUpHandler);
      }
      
      private function onSoundMouseUpHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:ICommand = null;
         this._timeline.removeEventListener(TimelineEvent.SOUND_MOUSE_UP,this.onSoundMouseUpHandler);
         _loc2_ = param1.id;
         this.updateSoundById(_loc2_);
         _loc3_ = this._timeline.getSoundInfoById(_loc2_);
         if(_loc3_ != null && this._prevSoundInfo != null)
         {
            if(_loc3_.startPixel != this._prevSoundInfo.startPixel || _loc3_.y != this._prevSoundInfo.y)
            {
               (_loc4_ = new ChangeSoundLengthCommand(_loc2_,this._prevSoundInfo)).execute();
            }
         }
      }
      
      private function onSoundResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.id;
         if(_loc2_ != null)
         {
            this._prevSoundInfo = this._timeline.getSoundInfoById(_loc2_);
         }
      }
      
      private function onSoundResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:ICommand = null;
         _loc2_ = param1.id;
         _loc3_ = this._timeline.getSoundInfoById(_loc2_);
         if(this._prevSoundInfo != null)
         {
            if(_loc3_.totalPixel != this._prevSoundInfo.totalPixel)
            {
               (_loc4_ = new ChangeSoundLengthCommand(_loc2_,this._prevSoundInfo)).execute();
            }
         }
         if(_loc3_.totalPixel <= 0)
         {
            this.removeSound(_loc2_);
         }
      }
      
      private function onSoundResizeHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:AnimeSound = null;
         _loc2_ = param1.id;
         _loc3_ = this.getSoundInfoById(_loc2_);
         (_loc4_ = this.sounds.getSoundById(_loc2_) as AnimeSound).startFrame = UtilUnitConvert.xToFrame(_loc3_.startPixel);
         _loc4_.endFrame = UtilUnitConvert.xToFrame(_loc3_.startPixel + _loc3_.totalPixel) - 1;
      }
      
      private function onSoundMoveHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ElementInfo = null;
         var _loc4_:AnimeSound = null;
         _loc2_ = param1.id;
         _loc3_ = this.getSoundInfoById(_loc2_);
         (_loc4_ = this.sounds.getSoundById(_loc2_) as AnimeSound).startFrame = UtilUnitConvert.xToFrame(_loc3_.startPixel);
         _loc4_.endFrame = UtilUnitConvert.xToFrame(_loc3_.startPixel + _loc3_.totalPixel) - 1;
         _loc4_.trackNum = SoundTrackArea.pixelToTrack(_loc3_.y);
      }
      
      public function updateSoundById(param1:String) : void
      {
         var _loc2_:ElementInfo = null;
         var _loc3_:AnimeSound = null;
         _loc2_ = this.getSoundInfoById(param1);
         _loc3_ = this.sounds.getSoundById(param1) as AnimeSound;
         _loc3_.startFrame = UtilUnitConvert.xToFrame(_loc2_.startPixel);
         _loc3_.endFrame = UtilUnitConvert.xToFrame(_loc2_.startPixel + _loc2_.totalPixel) - 1;
         _loc3_.trackNum = SoundTrackArea.pixelToTrack(_loc2_.y);
         _loc3_.inner_volume = _loc2_.inner_volume;
      }
      
      private function onSoundClickHandler(param1:TimelineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:AnimeSound = null;
         var _loc4_:Timeline = null;
         var _loc5_:SoundContainer = null;
         _loc2_ = param1.id;
         _loc3_ = this.sounds.getSoundById(_loc2_) as AnimeSound;
         _loc4_ = Timeline(param1.currentTarget);
         _loc5_ = param1.soundContainer;
         _loc3_.showMenu(_loc4_.stage.mouseX,_loc4_.stage.mouseY,_loc5_);
      }
      
      private function onTimerHandler(param1:TimerEvent) : void
      {
         this.doAutoSave();
      }
      
      private function doAutoSave() : void
      {
         if(this._initialized == true)
         {
            if(UtilUser.loggedIn)
            {
               if(this._publishW == null)
               {
                  this._isAutoSave = true;
                  if(this.metaData.movieId == null)
                  {
                     this.genDefaultTags();
                     this._metaData = this._tempMetaData;
                  }
                  this.addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.showSaveMovieError);
                  this.saveMovie();
               }
            }
            else
            {
               this.mainStage.showAutoSaveHints();
            }
         }
      }
      
      private function alertClickHandler(param1:MouseEvent) : void
      {
         if(Button(param1.currentTarget).id == "_btnDelete")
         {
            if(ServerConstants.APPCODE == "go")
            {
               ExternalInterface.call("newAnimation");
            }
            else
            {
               this.newAnimation();
            }
         }
      }
      
      public function get selectedThumbnailIndex() : int
      {
         return this._selectedThumbnailIndex;
      }
      
      public function set selectedThumbnailIndex(param1:int) : void
      {
         this._selectedThumbnailIndex = param1;
      }
      
      public function get selectedThumbForTempIndex() : int
      {
         return this._selectedThumbForTempIndex;
      }
      
      public function set selectedThumbForTempIndex(param1:int) : void
      {
         this._selectedThumbForTempIndex = param1;
      }
      
      private function getMovieThumbnail(param1:Boolean = false, param2:int = 0, param3:int = 0) : ByteArray
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BitmapData = null;
         var _loc8_:JPGEncoder = null;
         var _loc9_:ByteArray = null;
         var _loc10_:ColorTransform = null;
         var _loc4_:AnimeScene = this._movie.getSceneAt(param2);
         _loc5_ = AnimeConstants.MOVIE_THUMBNAIL_WIDTH;
         _loc6_ = AnimeConstants.MOVIE_THUMBNAIL_HEIGHT;
         if(param3 == 1)
         {
            _loc5_ = AnimeConstants.MOVIE_THUMBNAIL_LARGE_WIDTH;
            _loc6_ = AnimeConstants.MOVIE_THUMBNAIL_LARGE_HEIGHT;
         }
         _loc7_ = this.getCurrentSceneBitmapData(_loc5_,_loc6_);
         if(param1)
         {
            _loc10_ = new ColorTransform(0.5,0.5,0.5);
            _loc7_.colorTransform(new Rectangle(0,0,_loc7_.width,_loc7_.height),_loc10_);
         }
         return (_loc8_ = new JPGEncoder(85)).encode(_loc7_);
      }
      
      private function setBadTerms(param1:String) : void
      {
         this._badTerms = param1.split(",");
      }
      
      public function getBadTerms() : Array
      {
         if(this._badTerms != null)
         {
            return this._badTerms;
         }
         return null;
      }
      
      private function setWhiteTerms(param1:String) : void
      {
         if(param1 != "")
         {
            this._whiteTerms = param1.split(",");
         }
      }
      
      public function getWhiteTerms() : Array
      {
         if(this._whiteTerms != null)
         {
            return this._whiteTerms;
         }
         return null;
      }
      
      public function clearBubbleText(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BubbleAsset = null;
         _loc4_ = this._movie.scenes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = 0;
            while(_loc3_ < this._movie.getSceneAt(_loc2_).bubbles.length)
            {
               if((_loc5_ = BubbleAsset(this._movie.getSceneAt(_loc2_).bubbles.getValueByIndex(_loc3_))).bubble.backupText != "" && param1 == false)
               {
                  _loc5_.bubble.text = _loc5_.bubble.backupText;
               }
               else
               {
                  _loc5_.bubble.backupText = _loc5_.bubble.text;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function replaceBubbleText(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = this._movie.scenes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this._movie.getSceneAt(_loc3_).replaceBubbleText(param1,param2);
            _loc3_++;
         }
      }
      
      private function getCurrentSceneBitmapData(param1:Number, param2:Number) : BitmapData
      {
         var _loc3_:Rectangle = null;
         var _loc4_:BitmapData = null;
         var _loc5_:Matrix = null;
         var _loc6_:Number = NaN;
         var _loc7_:Rectangle = null;
         _loc3_ = new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         if(this.currentScene && this.currentScene.sizingAsset)
         {
            _loc3_ = new Rectangle(this.currentScene.sizingAsset.x,this.currentScene.sizingAsset.y,this.currentScene.sizingAsset.width,this.currentScene.sizingAsset.height);
         }
         _loc3_.inflate(-1,-1);
         _loc4_ = new BitmapData(param1,param2,false,0);
         (_loc5_ = new Matrix()).translate(-_loc3_.x,-_loc3_.y);
         _loc6_ = Math.min(param1 / _loc3_.width,param2 / _loc3_.height);
         _loc5_.scale(_loc6_,_loc6_);
         _loc5_.translate(0,(param2 - _loc6_ * _loc3_.height) / 2);
         _loc3_.inflate(1,1);
         _loc7_ = new Rectangle(0,(param2 - _loc6_ * _loc3_.height) / 2,_loc4_.width,_loc6_ * _loc3_.height);
         _loc4_.draw(this.mainStage.sceneEditor.view.view,_loc5_,null,null,_loc7_);
         return _loc4_;
      }
      
      public function doUpdateTimelineByScene(param1:AnimeScene, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BitmapData = null;
         if(param2 && this.currentScene != param1)
         {
            return;
         }
         if(param1)
         {
            this.timeline.setSceneTarget(this.mainStage.sceneEditor.view,new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
            _loc3_ = this.getSceneIndex(param1);
            _loc4_ = this.getCurrentSceneBitmapData(220,141);
            this.timeline.updateSceneImageByBitmapData(_loc3_,_loc4_);
         }
      }
      
      private function doUpdateTimeline(param1:Event, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(!this._capScreenLock)
         {
            if(this._movie.currentScene != null)
            {
               if(this._defaultUpdateAllTimelineImage)
               {
                  _loc3_ = 0;
                  while(_loc3_ < this._movie.scenes.length)
                  {
                     this.timeline.setSceneTarget(this.mainStage.sceneEditor.view,new Rectangle(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
                     this._movie.getSceneAt(_loc3_).unloadAllAssets();
                     _loc3_++;
                  }
                  if(this._movie.scenes.length > 1)
                  {
                     this._defaultUpdateAllTimelineImage = false;
                  }
               }
               else
               {
                  _loc3_ = this._movie.currentIndex;
                  this.doUpdateTimelineByScene(this.getScene(_loc3_));
               }
            }
         }
      }
      
      public function updateScLnCtrlPerf(param1:String) : void
      {
         this.timeline.sceneLengthController.userPreference = param1;
      }
      
      public function calculateUsedBytes() : String
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         _loc1_ = Number(System.totalMemory / Math.pow(2,20));
         _loc2_ = 2;
         return _loc1_.toFixed(_loc2_).toString();
      }
      
      public function showUpgradePopup() : void
      {
         var _loc1_:IFlexDisplayObject = null;
         _loc1_ = UtilPopUp.upgrade("full_length");
         _loc1_.width = 400;
         _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
         _loc1_.y = 100;
      }
      
      public function showBuyGoBuckPopUp() : void
      {
         if(!this._popUp)
         {
            this._popUp = GoPopUp(PopUpManager.createPopUp(this._mainStage,GoPopUp,true));
            this._popUp.text = UtilDict.toDisplay("go","Hey there, looks like you need more GoBucks!  Want to get some now?");
            this._popUp.addEventListener("okClick",this.redirectToBuyGoBuckPage);
            this._popUp.addEventListener("cancelClick",this.closePopUp);
            this._popUp.okText = UtilDict.toDisplay("go","Yes");
            this._popUp.cancelText = UtilDict.toDisplay("go","No");
            this._popUp.width = 400;
            this._popUp.x = (this._popUp.stage.width - this._popUp.width) / 2;
            this._popUp.y = 150;
         }
      }
      
      public function redirectToBuyGoBuckPage(param1:Event) : void
      {
         this.closePopUp(param1);
         UtilNavigate.toBuyBuckPage();
      }
      
      private function closePopUp(param1:Event) : void
      {
         PopUpManager.removePopUp(Canvas(param1.target));
         this._popUp = null;
      }
      
      public function checkMyCharNumAndShowCharImmediately() : void
      {
         this.thumbTray.registerShouldShowCharTabOnCcLoaded(true);
         this.checkMyCharNum();
      }
      
      public function checkMyCharNum() : void
      {
         this.addEventListener(LoadCcCharCountEvent.CC_CHAR_COUNT_GOT,this.onGotCCCount);
         CursorManager.setBusyCursor();
         this.getCcCharCount();
      }
      
      public function goCreateCC() : void
      {
         UtilNavigate.goCreateCc(ThemeManager.instance.currentTheme.cc_theme_id);
      }
      
      public function onGotCCCount(param1:LoadCcCharCountEvent) : void
      {
         CursorManager.removeBusyCursor();
         if(param1.ccCharCount > 0)
         {
            this.thumbTray.switchTheme(ThumbTray.COMMON_THEME);
            this.thumbTray.loadCcTheme(ThumbTray.THEME_ID_CUSTOM_WORLD);
         }
         else
         {
            this.goCreateCC();
         }
      }
      
      public function dispatchTutorialEvent(param1:TutorialEvent) : void
      {
         if(this.isTutorialOn)
         {
            this.dispatchEvent(param1);
         }
      }
      
      public function freezeCurrentScene(param1:Event) : void
      {
      }
      
      public function get isTutorialOn() : Boolean
      {
         if(this.goWalker != null && this.goWalker.guideMode)
         {
            return true;
         }
         return false;
      }
      
      public function playMovie() : void
      {
         if(this.currentScene.selectedAsset is VideoProp)
         {
            VideoProp(this.currentScene.selectedAsset).playMovie();
         }
      }
      
      public function pauseMovie() : void
      {
         if(this.currentScene.selectedAsset is VideoProp)
         {
            VideoProp(this.currentScene.selectedAsset).pauseMovie();
         }
      }
      
      public function addThumbToMovieTheme(param1:Thumb) : void
      {
         if(param1 && !ThemeManager.instance.movieTheme.isThumbExist(param1) && param1.enable)
         {
            Console.getConsole().thumbTray.addThumbToMovieTray(param1);
            ThemeManager.instance.movieTheme.addThumb(param1);
         }
      }
   }
}
