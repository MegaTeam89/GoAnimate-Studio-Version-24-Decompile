package anifire.managers
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.components.studio.ThumbTray;
   import anifire.constant.AnimeConstants;
   import anifire.constant.CcLibConstant;
   import anifire.constant.ServerConstants;
   import anifire.core.BackgroundThumb;
   import anifire.core.CharThumb;
   import anifire.core.Console;
   import anifire.core.EffectThumb;
   import anifire.core.PropThumb;
   import anifire.core.TemplateThumb;
   import anifire.core.Thumb;
   import anifire.core.VideoPropThumb;
   import anifire.event.CoreEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilHashThumb;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilURLStream;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import mx.controls.Alert;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class UserStuffManager extends EventDispatcher
   {
      
      private static var _instance:UserStuffManager;
       
      
      private const NUM_PROP_PER_LOAD:int = 4 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 100) / AnimeConstants.TILE_PROP_HEIGHT);
      
      private const NUM_BG_PER_LOAD:int = 2 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 60) / AnimeConstants.TILE_BACKGROUND_HEIGHT);
      
      private const NUM_CHAR_PER_LOAD:int = 3 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 20) / AnimeConstants.TILE_CHAR_HEIGHT);
      
      private const NUM_CC_PER_LOAD:int = this.NUM_CHAR_PER_LOAD;
      
      private const NUM_SOUND_PER_LOAD:int = 30;
      
      private const NUM_EFFECT_PER_LOAD:int = 4 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 100) / AnimeConstants.TILE_PROP_HEIGHT);
      
      private const NUM_VIDEO_PER_LOAD:int = 2 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 60) / AnimeConstants.TILE_BACKGROUND_HEIGHT);
      
      private var _loadingType:String = "prop";
      
      private var _isLoading:Boolean = false;
      
      private var _isLoadingCc:Boolean = false;
      
      private var _nextUserCharPage:int = 0;
      
      private var _nextUserBgPage:int = 0;
      
      private var _nextUserPropPage:int = 0;
      
      private var _nextUserSoundPage:int = 0;
      
      private var _nextUserSoundEffectPage:int = 0;
      
      private var _nextUserSoundMusicPage:int = 0;
      
      private var _nextUserSoundVoicePage:int = 0;
      
      private var _nextUserSoundTTSPage:int = 0;
      
      private var _nextUserEffectPage:int = 0;
      
      private var _nextUserVideoPropPage:int = 0;
      
      private var _nextUserTemplatePage:int = 0;
      
      private var _nextUserCcPage:int = 0;
      
      private var _hasMoreUserBg:Boolean = true;
      
      private var _hasMoreUserProp:Boolean = true;
      
      private var _hasMoreUserVideoProp:Boolean = true;
      
      private var _hasMoreUserChar:Boolean = true;
      
      private var _hasMoreUserEffect:Boolean = true;
      
      private var _hasMoreUserSound:Boolean = true;
      
      private var _hasMoreUserSoundEffect:Boolean = true;
      
      private var _hasMoreUserSoundVoice:Boolean = true;
      
      private var _hasMoreUserSoundMusic:Boolean = true;
      
      private var _hasMoreUserSoundTTS:Boolean = true;
      
      private var _hasMoreUserTemplate:Boolean = true;
      
      private var _hasMoreUserCc:Boolean = true;
      
      private var _zipFile:ZipFile;
      
      private var _xml:XML;
      
      private var lastBGIndex:Number = 0;
      
      private var lastPropIndex:Number = 0;
      
      private var lastCharIndex:Number = 0;
      
      private var lastEffectIndex:Number = 0;
      
      private var lastVideoPropIndex:Number = 0;
      
      private var _byteArrayReturnFromLoadCcChar:UtilHashArray;
      
      public function UserStuffManager(param1:IEventDispatcher = null)
      {
         this._byteArrayReturnFromLoadCcChar = new UtilHashArray();
         super(param1);
      }
      
      public static function get instance() : UserStuffManager
      {
         if(_instance == null)
         {
            _instance = new UserStuffManager();
         }
         return _instance;
      }
      
      public function get hasMoreUserSoundEffect() : Boolean
      {
         return this._hasMoreUserSoundEffect;
      }
      
      public function get hasMoreUserEffect() : Boolean
      {
         return this._hasMoreUserEffect;
      }
      
      public function get hasMoreUserSoundMusic() : Boolean
      {
         return this._hasMoreUserSoundMusic;
      }
      
      public function get hasMoreUserSoundTTS() : Boolean
      {
         return this._hasMoreUserSoundTTS;
      }
      
      public function get hasMoreUserTemplate() : Boolean
      {
         return this._hasMoreUserTemplate;
      }
      
      public function get hasMoreUserSoundVoice() : Boolean
      {
         return this._hasMoreUserSoundVoice;
      }
      
      public function get hasMoreUserBg() : Boolean
      {
         return this._hasMoreUserBg;
      }
      
      public function get hasMoreUserProp() : Boolean
      {
         return this._hasMoreUserProp;
      }
      
      public function get hasMoreUserVideoProp() : Boolean
      {
         return this._hasMoreUserVideoProp;
      }
      
      public function get hasMoreUserChar() : Boolean
      {
         return this._hasMoreUserChar;
      }
      
      public function reset() : void
      {
         ThemeManager.instance.resetUserTheme();
         this._byteArrayReturnFromLoadCcChar = new UtilHashArray();
         this._hasMoreUserCc = true;
         this._nextUserCcPage = 0;
      }
      
      public function loadStuff(param1:String = "prop") : void
      {
         if(this._isLoading)
         {
            return;
         }
         switch(param1)
         {
            case AnimeConstants.ASSET_TYPE_PROP:
               if(this._hasMoreUserProp == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_CHAR:
               if(this._hasMoreUserChar == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_BG:
               if(this._hasMoreUserBg == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_FX:
               if(this._hasMoreUserEffect == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND:
               if(this._hasMoreUserSound == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC:
               if(this._hasMoreUserSoundMusic == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT:
               if(this._hasMoreUserSoundEffect == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER:
               if(this._hasMoreUserSoundVoice == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS:
               if(this._hasMoreUserSoundTTS == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_PROP_VIDEO:
               if(this._hasMoreUserVideoProp == false)
               {
                  return;
               }
               break;
         }
         this._isLoading = true;
         this._loadingType = param1;
         Console.getConsole().loadProgress = 0;
         Console.getConsole().requestLoadStatus(true,true);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         var _loc3_:URLRequest = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
         _loc2_["type"] = this._loadingType;
         if(this._loadingType == AnimeConstants.ASSET_TYPE_CHAR)
         {
            _loc2_["count"] = this.NUM_CHAR_PER_LOAD;
            if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_ADMIN) != "1")
            {
               _loc2_["is_cc"] = "N";
            }
            _loc2_["page"] = this._nextUserCharPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc2_["count"] = this.NUM_BG_PER_LOAD;
            _loc2_["page"] = this._nextUserBgPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc2_["count"] = this.NUM_PROP_PER_LOAD;
            _loc2_["page"] = this._nextUserPropPage;
            _loc2_["subtype"] = "";
            _loc2_["excludesubtype"] = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_CHAR)
         {
            _loc2_["count"] = this.NUM_CHAR_PER_LOAD;
            _loc2_["page"] = this._nextUserCharPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextUserSoundPage;
            _loc2_["include_files"] = 0;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextUserSoundEffectPage;
            _loc2_["include_files"] = 0;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextUserSoundMusicPage;
            _loc2_["include_files"] = 0;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextUserSoundVoicePage;
            _loc2_["include_files"] = 0;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextUserSoundTTSPage;
            _loc2_["include_files"] = 0;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_FX)
         {
            _loc2_["count"] = this.NUM_EFFECT_PER_LOAD;
            _loc2_["page"] = this._nextUserEffectPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            _loc2_["count"] = this.NUM_VIDEO_PER_LOAD;
            _loc2_["page"] = this._nextUserVideoPropPage;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_PROP;
         }
         _loc2_["exclude_ids"] = Console.getConsole().newlyAddedAssetIds;
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:UtilURLStream;
         (_loc4_ = new UtilURLStream()).addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadUserAssetsComplete);
         _loc4_.addEventListener(UtilURLStream.TIME_OUT,this.loadUserThemeTimeOutHandler);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.loadUserThemeIOErrorHandler);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadUserThemeSecurityErrorHandler);
         _loc4_.load(_loc3_);
      }
      
      private function loadUserThemeIOErrorHandler(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeIOErrorHandler);
         this._isLoading = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error: Load my library failed!");
      }
      
      private function loadUserThemeSecurityErrorHandler(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeSecurityErrorHandler);
         this._isLoading = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error: Load my library failed!");
      }
      
      private function loadUserThemeTimeOutHandler(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeTimeOutHandler);
         this._isLoading = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error: Load my library timeout!");
      }
      
      private function onLoadUserAssetsComplete(param1:Event) : void
      {
         var _loc5_:UtilLoadMgr = null;
         var _loc2_:UtilURLStream = UtilURLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         _loc3_.position = 0;
         var _loc4_:int;
         if((_loc4_ = _loc3_.readByte()) == 0)
         {
            if(_loc4_ != 0)
            {
               _loc3_.position = 0;
            }
            this._zipFile = new ZipFile(_loc3_);
            this._xml = new XML(this._zipFile.getInput(this._zipFile.getEntry("desc.xml")));
            this.lastBGIndex = ThemeManager.instance.userTheme.backgroundThumbs.length;
            this.lastPropIndex = ThemeManager.instance.userTheme.propThumbs.length;
            this.lastCharIndex = ThemeManager.instance.userTheme.charThumbs.length;
            this.lastEffectIndex = ThemeManager.instance.userTheme.effectThumbs.length;
            (_loc5_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateImagedata);
            _loc5_.addEventDispatcher(ThemeManager.instance.userTheme.eventDispatcher,CoreEvent.DESERIALIZE_THEME_COMPLETE);
            ThemeManager.instance.userTheme.deSerialize(this._xml);
            _loc5_.addEventDispatcher(ThemeManager.instance.lastLoaddedTheme.eventDispatcher,CoreEvent.DESERIALIZE_THEME_COMPLETE);
            ThemeManager.instance.lastLoaddedTheme.clearAllThumbs();
            ThemeManager.instance.lastLoaddedTheme.deSerialize(this._xml);
            _loc5_.commit();
         }
         else
         {
            if(this._loadingType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
            {
               this.loadVideo();
            }
            this._isLoading = false;
            Console.getConsole().loadProgressVisible = false;
            Console.getConsole().requestLoadStatus(false,true);
            Alert.show("Error: Load my library failed!");
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this));
         }
      }
      
      private function updateImagedata(param1:Event) : void
      {
         var _loc13_:UtilHashThumb = null;
         var _loc14_:UtilHashThumb = null;
         var _loc15_:UtilHashThumb = null;
         var _loc16_:UtilHashThumb = null;
         var _loc17_:UtilHashThumb = null;
         var _loc18_:Thumb = null;
         var _loc19_:ZipEntry = null;
         var _loc24_:ByteArray = null;
         var _loc25_:ZipFile = null;
         var _loc26_:XML = null;
         var _loc27_:ZipEntry = null;
         var _loc28_:ByteArray = null;
         var _loc29_:ZipEntry = null;
         var _loc30_:ZipFile = null;
         var _loc31_:int = 0;
         var _loc32_:ZipEntry = null;
         var _loc2_:XML = this._xml;
         var _loc3_:ZipFile = this._zipFile;
         var _loc4_:Boolean = _loc2_.@moreBg == "1" ? true : false;
         var _loc5_:Boolean = _loc2_.@moreProp == "1" ? true : false;
         var _loc6_:Boolean = _loc2_.@moreVideoProp == "1" ? true : false;
         var _loc7_:Boolean = _loc2_.@moreChar == "1" ? true : false;
         var _loc8_:Boolean = _loc2_.@moreFx == "1" ? true : false;
         var _loc9_:Boolean = _loc2_.@moreVoice == "1" ? true : false;
         var _loc10_:Boolean = _loc2_.@moreEffect == "1" ? true : false;
         var _loc11_:Boolean = _loc2_.@moreMusic == "1" ? true : false;
         var _loc12_:Boolean = _loc2_.@moreTTS == "1" ? true : false;
         _loc13_ = ThemeManager.instance.lastLoaddedTheme.backgroundThumbs;
         _loc14_ = ThemeManager.instance.lastLoaddedTheme.propThumbs;
         _loc15_ = ThemeManager.instance.lastLoaddedTheme.charThumbs;
         _loc16_ = ThemeManager.instance.lastLoaddedTheme.effectThumbs;
         var _loc20_:int = 0;
         while(_loc20_ < _loc13_.length)
         {
            _loc18_ = BackgroundThumb(_loc13_.getValueByIndex(_loc20_));
            if((_loc19_ = _loc3_.getEntry(_loc18_.getFileName())) != null)
            {
               _loc18_.imageData = _loc3_.getInput(_loc19_);
               _loc18_.thumbImageData = _loc3_.getInput(_loc19_);
               BackgroundThumb(ThemeManager.instance.userTheme.backgroundThumbs.getValueByKey(_loc18_.id)).imageData = _loc3_.getInput(_loc19_);
               BackgroundThumb(ThemeManager.instance.userTheme.backgroundThumbs.getValueByKey(_loc18_.id)).thumbImageData = _loc3_.getInput(_loc19_);
            }
            _loc20_++;
         }
         var _loc21_:int = 0;
         while(_loc21_ < _loc14_.length)
         {
            _loc18_ = PropThumb(_loc14_.getValueByIndex(_loc21_));
            if((_loc19_ = _loc3_.getEntry(_loc18_.getFileName())) != null)
            {
               _loc18_.imageData = _loc3_.getInput(_loc19_);
               PropThumb(ThemeManager.instance.userTheme.propThumbs.getValueByKey(_loc18_.id)).imageData = _loc3_.getInput(_loc19_);
            }
            _loc21_++;
         }
         var _loc22_:int = 0;
         while(_loc22_ < _loc15_.length)
         {
            _loc18_ = CharThumb(_loc15_.getValueByIndex(_loc22_));
            if((_loc19_ = _loc3_.getEntry(_loc18_.getFileName())) != null)
            {
               if(!CharThumb(_loc18_).isCC)
               {
                  _loc18_.imageData = _loc3_.getInput(_loc19_);
                  CharThumb(ThemeManager.instance.userTheme.charThumbs.getValueByKey(_loc18_.id)).imageData = _loc3_.getInput(_loc19_);
               }
               else if(_loc18_.getFileName().indexOf("zip") >= 0)
               {
                  _loc24_ = _loc3_.getInput(_loc19_);
                  _loc25_ = new ZipFile(_loc24_);
                  _loc18_.imageData = UtilPlain.convertZipAsImagedataObject(_loc25_);
                  if((_loc27_ = _loc3_.getEntry("char/" + _loc18_.id + "/" + CcLibConstant.NODE_LIBRARY + ".zip")) != null)
                  {
                     _loc28_ = _loc3_.getInput(_loc27_) as ByteArray;
                     _loc30_ = new ZipFile(_loc28_);
                     _loc31_ = 0;
                     while(_loc31_ < _loc30_.size)
                     {
                        _loc29_ = _loc30_.entries[_loc31_];
                        CharThumb(_loc18_).addLibrary(_loc29_.name,_loc30_.getInput(_loc29_));
                        _loc31_++;
                     }
                  }
               }
            }
            else
            {
               _loc32_ = _loc3_.getEntry("char/" + _loc18_.id + "/" + _loc18_.id + ".png");
               _loc18_.imageData = _loc3_.getInput(_loc32_);
               _loc18_.useImageAsThumb = true;
            }
            _loc22_++;
         }
         var _loc23_:int = 0;
         while(_loc23_ < _loc16_.length)
         {
            _loc18_ = EffectThumb(_loc16_.getValueByIndex(_loc23_));
            if((_loc19_ = _loc3_.getEntry(_loc18_.getFileName())) != null)
            {
               _loc18_.imageData = _loc3_.getInput(_loc19_);
               EffectThumb(ThemeManager.instance.userTheme.effectThumbs.getValueByIndex(_loc23_ + this.lastEffectIndex)).imageData = _loc3_.getInput(_loc19_);
            }
            _loc23_++;
         }
         ThemeManager.instance.userTheme.mergeTheme(ThemeManager.instance.lastLoaddedTheme);
         ThemeManager.instance.addTheme(ThemeManager.instance.userTheme.id,ThemeManager.instance.userTheme);
         if(this._loadingType == AnimeConstants.ASSET_TYPE_BG)
         {
            this._hasMoreUserBg = _loc4_;
            ++this._nextUserBgPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_PROP)
         {
            this._hasMoreUserProp = _loc5_;
            ++this._nextUserPropPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            this._hasMoreUserVideoProp = _loc6_;
            ++this._nextUserVideoPropPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_CHAR)
         {
            this._hasMoreUserChar = _loc7_;
            ++this._nextUserCharPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND)
         {
            this._hasMoreUserSoundEffect = _loc10_;
            ++this._nextUserSoundEffectPage;
            this._hasMoreUserSoundMusic = _loc11_;
            ++this._nextUserSoundMusicPage;
            this._hasMoreUserSoundVoice = _loc9_;
            ++this._nextUserSoundVoicePage;
            this._hasMoreUserSoundTTS = _loc12_;
            ++this._nextUserSoundTTSPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
         {
            this._hasMoreUserSoundEffect = _loc10_;
            ++this._nextUserSoundEffectPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
         {
            this._hasMoreUserSoundMusic = _loc11_;
            ++this._nextUserSoundMusicPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            this._hasMoreUserSoundVoice = _loc9_;
            ++this._nextUserSoundVoicePage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
         {
            this._hasMoreUserSoundTTS = _loc12_;
            ++this._nextUserSoundTTSPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_FX)
         {
            this._hasMoreUserEffect = _loc8_;
            ++this._nextUserEffectPage;
         }
         if(this._loadingType != AnimeConstants.ASSET_TYPE_TEMPLATE)
         {
            Console.getConsole().thumbTray.removeLoadingCanvas(this._loadingType);
            Console.getConsole().thumbTray.loadThumbs(ThemeManager.instance.lastLoaddedTheme);
         }
         if(this._loadingType == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            this.loadVideo();
         }
         this._isLoading = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this));
      }
      
      private function loadConvertedVideo(param1:Array) : void
      {
         var _loc3_:URLRequest = null;
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc3_ = new URLRequest(ServerConstants.ACTION_GET_USERVIDEOASSETS);
         _loc2_["count"] = 1000;
         _loc2_["page"] = 0;
         _loc2_["include_ids_only"] = param1.join(",");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         Console.getConsole().loadProgress = 0;
         var _loc4_:UtilURLStream;
         (_loc4_ = new UtilURLStream()).addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.onUpdateUserVideoAssetsComplete);
         _loc4_.addEventListener(UtilURLStream.TIME_OUT,this.loadUserThemeTimeOutHandler);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.loadUserThemeIOErrorHandler);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadUserThemeSecurityErrorHandler);
         _loc4_.load(_loc3_);
      }
      
      private function onUpdateUserVideoAssetsComplete(param1:Event) : void
      {
         var _loc5_:UtilLoadMgr = null;
         var _loc6_:ByteArray = null;
         var _loc2_:UtilURLStream = UtilURLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         _loc3_.position = 0;
         var _loc4_:int;
         if((_loc4_ = _loc3_.readByte()) == 0)
         {
            this._zipFile = new ZipFile(_loc3_);
            this._xml = new XML(this._zipFile.getInput(this._zipFile.getEntry("desc.xml")));
            (_loc5_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateVideoPropImagedata);
            _loc5_.addEventDispatcher(ThemeManager.instance.userTheme.eventDispatcher,CoreEvent.DESERIALIZE_THEME_COMPLETE);
            ThemeManager.instance.userTheme.deSerialize(this._xml);
            _loc5_.addEventDispatcher(ThemeManager.instance.lastLoaddedTheme.eventDispatcher,CoreEvent.DESERIALIZE_THEME_COMPLETE);
            ThemeManager.instance.lastLoaddedTheme.clearAllThumbs();
            ThemeManager.instance.lastLoaddedTheme.deSerialize(this._xml);
            _loc5_.commit();
         }
         else
         {
            _loc6_ = new ByteArray();
            _loc2_.readBytes(_loc6_);
            Alert.show("getUserAssets failed: \n" + _loc6_.toString());
         }
      }
      
      private function updateVideoPropImagedata(param1:Event) : void
      {
         var _loc3_:UtilHashThumb = null;
         var _loc4_:Thumb = null;
         var _loc5_:ZipEntry = null;
         var _loc2_:ZipFile = this._zipFile;
         _loc3_ = ThemeManager.instance.lastLoaddedTheme.propThumbs;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc4_ = PropThumb(_loc3_.getValueByIndex(_loc6_));
            if((_loc5_ = _loc2_.getEntry(_loc4_.getFileName())) != null)
            {
               _loc4_.imageData = _loc2_.getInput(_loc5_);
               PropThumb(ThemeManager.instance.userTheme.propThumbs.getValueByKey(_loc4_.id)).imageData = _loc2_.getInput(_loc5_);
            }
            _loc6_++;
         }
         Console.getConsole().thumbTray.removeLoadingCanvas("video");
         Console.getConsole().thumbTray.loadThumbs(ThemeManager.instance.lastLoaddedTheme,false,Console.getConsole().thumbTray._uiTileVideoPropUser,true);
         var _loc7_:CoreEvent = new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this);
         this.loadVideo();
      }
      
      public function loadVideo() : void
      {
         var _loc4_:ThumbnailCanvas = null;
         var _loc1_:Number = Console.getConsole().thumbTray._uiTileVideoPropUser.numChildren;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            if((_loc4_ = Console.getConsole().thumbTray._uiTileVideoPropUser.getChildAt(_loc3_) as ThumbnailCanvas) != null && _loc4_.thumb is VideoPropThumb)
            {
               if(VideoPropThumb(_loc4_.thumb).videoWidth == 0 && VideoPropThumb(_loc4_.thumb).videoHeight == 0)
               {
                  _loc2_.push(VideoPropThumb(_loc4_.thumb).id);
               }
            }
            _loc3_++;
         }
         if(_loc2_.length > 0)
         {
            setTimeout(this.updateVideoStatus,30000,_loc2_);
         }
      }
      
      private function updateVideoStatus(param1:Array) : void
      {
         this.loadConvertedVideo(param1);
      }
      
      public function loadUserTemplate() : void
      {
         var _loc1_:URLRequest = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         var _loc3_:UtilURLStream = new UtilURLStream();
         _loc3_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc3_.addEventListener(Event.COMPLETE,this.onLoadUserTemplateComplete);
         _loc3_.addEventListener(UtilURLStream.TIME_OUT,this.loadUserThemeTimeOutHandler);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.loadUserThemeIOErrorHandler);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadUserThemeSecurityErrorHandler);
         _loc2_["count"] = this.NUM_BG_PER_LOAD;
         _loc2_["page"] = this._nextUserTemplatePage;
         _loc2_["type"] = "movie";
         _loc1_.method = URLRequestMethod.POST;
         _loc1_.data = _loc2_;
         Console.getConsole().requestLoadStatus(true,true);
         _loc3_.load(_loc1_);
      }
      
      private function onLoadUserTemplateComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadUserTemplateComplete);
         var _loc2_:UtilURLStream = UtilURLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         _loc3_.position = 0;
         var _loc4_:int;
         if((_loc4_ = _loc3_.readByte()) == 0)
         {
            this._zipFile = new ZipFile(_loc3_);
            this._xml = new XML(this._zipFile.getInput(this._zipFile.getEntry("desc.xml")));
            ThemeManager.instance.lastLoaddedTheme.addEventListener(CoreEvent.DESERIALIZE_THEME_COMPLETE,this.updateTemplateImagedata);
            ThemeManager.instance.lastLoaddedTheme.clearAllThumbs();
            ThemeManager.instance.lastLoaddedTheme.deSerialize(this._xml);
         }
         else
         {
            Alert.show("Oops...fail to load user sceme template!");
         }
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
      }
      
      private function updateTemplateImagedata(param1:Event) : void
      {
         var _loc4_:UtilHashThumb = null;
         var _loc5_:ZipEntry = null;
         var _loc7_:int = 0;
         var _loc8_:TemplateThumb = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.updateTemplateImagedata);
         var _loc2_:XML = this._xml;
         var _loc3_:ZipFile = this._zipFile;
         var _loc6_:Boolean = _loc2_.@moreMovie == "1" ? true : false;
         _loc7_ = (_loc4_ = ThemeManager.instance.lastLoaddedTheme.templateThumbs).length - 1;
         while(_loc7_ >= 0)
         {
            _loc8_ = TemplateThumb(_loc4_.getValueByIndex(_loc7_));
            if(ThemeManager.instance.userTheme.templateThumbs.getValueByKey(_loc8_.id))
            {
               _loc4_.removeByKey(_loc8_.id);
            }
            _loc7_--;
         }
         ThemeManager.instance.userTheme.addEventListener(CoreEvent.DESERIALIZE_THEME_COMPLETE,this.updateTemplateImagedataSecond);
         ThemeManager.instance.userTheme.deSerialize(_loc2_);
      }
      
      private function updateTemplateImagedataSecond(param1:Event) : void
      {
         var _loc4_:UtilHashThumb = null;
         var _loc5_:ZipEntry = null;
         var _loc7_:int = 0;
         var _loc8_:TemplateThumb = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.updateTemplateImagedataSecond);
         var _loc2_:XML = this._xml;
         var _loc3_:ZipFile = this._zipFile;
         var _loc6_:Boolean = _loc2_.@moreMovie == "1" ? true : false;
         _loc7_ = (_loc4_ = ThemeManager.instance.lastLoaddedTheme.templateThumbs).length - 1;
         while(_loc7_ >= 0)
         {
            _loc8_ = TemplateThumb(_loc4_.getValueByIndex(_loc7_));
            if((_loc5_ = _loc3_.getEntry(_loc8_.getFileName())) != null)
            {
               _loc8_.imageData = _loc3_.getInput(_loc5_);
               _loc8_.thumbImageData = _loc3_.getInput(_loc5_);
               TemplateThumb(ThemeManager.instance.userTheme.templateThumbs.getValueByKey(_loc8_.id)).imageData = _loc3_.getInput(_loc5_);
               TemplateThumb(ThemeManager.instance.userTheme.templateThumbs.getValueByKey(_loc8_.id)).thumbImageData = _loc3_.getInput(_loc5_);
            }
            _loc7_--;
         }
         ++this._nextUserTemplatePage;
         this._hasMoreUserTemplate = _loc6_;
         Console.getConsole().thumbTray.loadThumbs(ThemeManager.instance.lastLoaddedTheme,false,Console.getConsole().thumbTray._uiTileTemplateMovie);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this));
      }
      
      public function loadCcChar() : void
      {
         var _loc1_:URLVariables = null;
         var _loc2_:URLRequest = null;
         var _loc3_:UtilURLStream = null;
         if(!this._hasMoreUserCc || this._isLoadingCc)
         {
            return;
         }
         this._isLoadingCc = true;
         Console.getConsole().requestLoadStatus(true,true);
         if(this._byteArrayReturnFromLoadCcChar.getValueByKey(ThemeManager.instance.currentTheme.id) == null)
         {
            _loc1_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc1_);
            _loc2_ = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
            _loc1_["type"] = AnimeConstants.ASSET_TYPE_CHAR;
            _loc1_["count"] = this.NUM_CC_PER_LOAD;
            _loc1_["page"] = this._nextUserCcPage++;
            _loc1_["is_cc"] = "Y";
            _loc1_["cc_theme_id"] = ThemeManager.instance.currentTheme.cc_theme_id;
            _loc1_["tray"] = ThemeManager.instance.currentTheme.id;
            _loc2_.method = URLRequestMethod.POST;
            _loc2_.data = _loc1_;
            _loc3_ = new UtilURLStream();
            _loc3_.addEventListener(Event.COMPLETE,this.onLoadCcCharCompleted);
            _loc3_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc3_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadCcTimeOut);
            _loc3_.load(_loc2_);
         }
         else
         {
            this._isLoadingCc = false;
            Console.getConsole().loadProgressVisible = false;
            Console.getConsole().requestLoadStatus(false,true);
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_CC_CHAR_COMPLETE,this));
         }
      }
      
      private function onLoadCcTimeOut(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onLoadCcTimeOut);
         this._isLoadingCc = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error: loading my characters timeout!");
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_CC_CHAR_COMPLETE,this));
      }
      
      private function onLoadCcCharCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCcCharCompleted);
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         this.doPrepareLoadCcCharComplete(_loc3_);
      }
      
      public function loadSingleCcChar(param1:String) : void
      {
         var _loc3_:URLRequest = null;
         Console.getConsole().requestLoadStatus(true,true);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc3_ = new URLRequest(ServerConstants.ACTION_GET_USERASSETS);
         _loc2_["type"] = AnimeConstants.ASSET_TYPE_CHAR;
         _loc2_["count"] = 100;
         _loc2_["page"] = 0;
         _loc2_["is_cc"] = "Y";
         _loc2_["include_ids_only"] = param1;
         _loc2_["cc_theme_id"] = ThemeManager.instance.currentTheme.cc_theme_id;
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:URLLoader;
         (_loc4_ = new URLLoader()).dataFormat = URLLoaderDataFormat.BINARY;
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadSingleCcCharCompleted);
         _loc4_.load(_loc3_);
      }
      
      private function onLoadSingleCcCharCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadSingleCcCharCompleted);
         var _loc2_:URLLoader = param1.target as URLLoader;
         this.doPrepareLoadCcCharComplete(_loc2_.data as ByteArray,true);
      }
      
      private function doPrepareLoadCcCharComplete(param1:ByteArray, param2:Boolean = false) : void
      {
         var _loc4_:UtilLoadMgr = null;
         param1.position = 0;
         var _loc3_:int = param1.readByte();
         if(_loc3_ == 0)
         {
            this._zipFile = new ZipFile(param1);
            this._xml = new XML(this._zipFile.getInput(this._zipFile.getEntry("desc.xml")));
            if(!param2)
            {
               this._hasMoreUserCc = String(this._xml.@moreChar) == "1";
            }
            (_loc4_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateCcCharImagedata);
            _loc4_.addEventDispatcher(ThemeManager.instance.userTheme.eventDispatcher,CoreEvent.DESERIALIZE_THEME_COMPLETE);
            ThemeManager.instance.userTheme.deSerialize(this._xml);
            _loc4_.addEventDispatcher(ThemeManager.instance.lastLoaddedTheme.eventDispatcher,CoreEvent.DESERIALIZE_THEME_COMPLETE);
            ThemeManager.instance.lastLoaddedTheme.clearAllThumbs();
            ThemeManager.instance.lastLoaddedTheme.deSerialize(this._xml);
            _loc4_.commit();
         }
         else
         {
            this._isLoadingCc = false;
            Console.getConsole().loadProgressVisible = false;
            Console.getConsole().requestLoadStatus(false,true);
            Alert.show("Error: loading my characters failed!");
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_CC_CHAR_COMPLETE,this));
         }
      }
      
      private function updateCcCharImagedata(param1:Event) : void
      {
         var _loc4_:ZipEntry = null;
         var _loc5_:UtilHashThumb = null;
         var _loc6_:Thumb = null;
         var _loc10_:ByteArray = null;
         var _loc11_:ZipFile = null;
         var _loc12_:XML = null;
         var _loc13_:ZipEntry = null;
         var _loc14_:ByteArray = null;
         var _loc15_:ZipEntry = null;
         var _loc16_:ZipFile = null;
         var _loc17_:int = 0;
         var _loc18_:ZipEntry = null;
         var _loc2_:ZipFile = this._zipFile;
         var _loc3_:Array = new Array();
         _loc5_ = ThemeManager.instance.lastLoaddedTheme.charThumbs;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = CharThumb(_loc5_.getValueByIndex(_loc7_));
            _loc4_ = _loc2_.getEntry(_loc6_.getFileName());
            _loc3_.push(_loc6_.id);
            if(_loc4_ != null)
            {
               _loc10_ = _loc2_.getInput(_loc4_);
               if(!CharThumb(_loc6_).isCC)
               {
                  _loc6_.imageData = _loc2_.getInput(_loc4_);
                  CharThumb(ThemeManager.instance.userTheme.charThumbs.getValueByKey(_loc6_.id)).imageData = _loc2_.getInput(_loc4_);
               }
               else if(_loc6_.getFileName().indexOf("zip") >= 0)
               {
                  _loc11_ = new ZipFile(_loc10_);
                  _loc6_.imageData = UtilPlain.convertZipAsImagedataObject(_loc11_);
                  if((_loc13_ = _loc2_.getEntry("char/" + _loc6_.id + "/" + CcLibConstant.NODE_LIBRARY + ".zip")) != null)
                  {
                     _loc14_ = _loc2_.getInput(_loc13_) as ByteArray;
                     _loc16_ = new ZipFile(_loc14_);
                     _loc17_ = 0;
                     while(_loc17_ < _loc16_.size)
                     {
                        _loc15_ = _loc16_.entries[_loc17_];
                        CharThumb(_loc6_).addLibrary(_loc15_.name,_loc16_.getInput(_loc15_));
                        _loc17_++;
                     }
                  }
               }
            }
            else
            {
               _loc18_ = _loc2_.getEntry("char/" + _loc6_.id + "/" + _loc6_.id + ".png");
               _loc6_.imageData = _loc2_.getInput(_loc18_);
               CharThumb(ThemeManager.instance.userTheme.charThumbs.getValueByKey(_loc6_.id)).imageData = _loc2_.getInput(_loc18_);
               _loc6_.useImageAsThumb = true;
            }
            CharThumb(_loc6_).tray = ThemeManager.instance.currentTheme.id;
            _loc7_++;
         }
         ThemeManager.instance.userTheme.mergeTheme(ThemeManager.instance.lastLoaddedTheme);
         ThemeManager.instance.addTheme(ThemeManager.instance.userTheme.id,ThemeManager.instance.userTheme);
         this._isLoadingCc = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         var _loc8_:Object;
         (_loc8_ = new Object())["newCharIdArray"] = _loc3_;
         _loc8_["lastLoadedTheme"] = ThemeManager.instance.lastLoaddedTheme;
         var _loc9_:CoreEvent = new CoreEvent(CoreEvent.LOAD_CC_CHAR_COMPLETE,this,_loc8_);
         this.dispatchEvent(_loc9_);
      }
      
      public function updateAsset(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         var _loc5_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc5_);
         _loc5_["assetId"] = param1;
         _loc5_["title"] = param2;
         _loc5_["tags"] = param3;
         _loc5_["isPublished"] = !!param4 ? "1" : "0";
         var _loc6_:URLRequest;
         (_loc6_ = new URLRequest(ServerConstants.ACTION_UPDATE_ASSET)).data = _loc5_;
         _loc6_.method = URLRequestMethod.POST;
         var _loc7_:URLStream;
         (_loc7_ = new URLStream()).addEventListener(Event.COMPLETE,this.onUpdateAssetComplete);
         _loc7_.load(_loc6_);
      }
      
      private function onUpdateAssetComplete(param1:Event = null) : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.UPDATE_ASSET_COMPLETE,this));
      }
   }
}
