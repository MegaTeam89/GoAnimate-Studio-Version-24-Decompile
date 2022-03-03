package anifire.managers
{
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
   import anifire.event.CoreEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.util.Util;
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
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import mx.controls.Alert;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class CommunityStuffManager extends EventDispatcher
   {
      
      private static var _instance:CommunityStuffManager;
       
      
      private const NUM_PROP_PER_LOAD:int = 4 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 100) / AnimeConstants.TILE_PROP_HEIGHT);
      
      private const NUM_BG_PER_LOAD:int = 2 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 60) / AnimeConstants.TILE_BACKGROUND_HEIGHT);
      
      private const NUM_CHAR_PER_LOAD:int = 3 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 20) / AnimeConstants.TILE_CHAR_HEIGHT);
      
      private const NUM_SOUND_PER_LOAD:int = 20;
      
      private const NUM_EFFECT_PER_LOAD:int = 4 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 100) / AnimeConstants.TILE_PROP_HEIGHT);
      
      private const NUM_VIDEO_PER_LOAD:int = 2 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 60) / AnimeConstants.TILE_BACKGROUND_HEIGHT);
      
      private const NUM_SEARCH_PER_LOAD:int = 4 * Math.ceil((ThumbTray.TRAY_MAX_HEIGHT - 100) / AnimeConstants.TILE_PROP_HEIGHT);
      
      private const NUM_TEMPLATE_PER_LOAD:int = 50;
      
      private var _nextCommunityCharPage:int = 0;
      
      private var _nextCommunityBgPage:int = 0;
      
      private var _nextCommunityPropPage:int = 0;
      
      private var _nextCommunitySoundPage:int = 0;
      
      private var _nextCommunitySoundEffectPage:int = 0;
      
      private var _nextCommunitySoundVoicePage:int = 0;
      
      private var _nextCommunitySoundMusicPage:int = 0;
      
      private var _nextCommunitySoundTTSPage:int = 0;
      
      private var _nextCommunityEffectPage:int = 0;
      
      private var _hasMoreCommunityBg:Boolean = true;
      
      private var _hasMoreCommunityProp:Boolean = true;
      
      private var _hasMoreCommunityChar:Boolean = true;
      
      private var _hasMoreCommunityEffect:Boolean = true;
      
      private var _hasMoreCommunitySound:Boolean = true;
      
      private var _hasMoreCommunitySoundEffect:Boolean = true;
      
      private var _hasMoreCommunitySoundVoice:Boolean = true;
      
      private var _hasMoreCommunitySoundMusic:Boolean = true;
      
      private var _hasMoreCommunitySoundTTS:Boolean = true;
      
      private var _loadingType:String = "prop";
      
      private var _isLoading:Boolean = false;
      
      private var _hasMoreSearch:Boolean = true;
      
      private var _currentSearchPage:int = 0;
      
      private var _currentSearchType:String = "prop";
      
      private var _isSearching:Boolean = false;
      
      private var _nextPublicTemplatePage:int = 0;
      
      private var _hasMorePublicTemplate:Boolean = true;
      
      private var _zipFile:ZipFile;
      
      private var _xml:XML;
      
      private var lastBGIndex:Number = 0;
      
      private var lastPropIndex:Number = 0;
      
      private var lastCharIndex:Number = 0;
      
      private var lastEffectIndex:Number = 0;
      
      private var lastVideoPropIndex:Number = 0;
      
      public function CommunityStuffManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : CommunityStuffManager
      {
         if(_instance == null)
         {
            _instance = new CommunityStuffManager();
         }
         return _instance;
      }
      
      public function get hasMoreCommunitySoundVoice() : Boolean
      {
         return this._hasMoreCommunitySoundVoice;
      }
      
      public function get hasMoreCommunitySoundMusic() : Boolean
      {
         return this._hasMoreCommunitySoundMusic;
      }
      
      public function get hasMoreCommunitySoundTTS() : Boolean
      {
         return this._hasMoreCommunitySoundTTS;
      }
      
      public function get hasMoreCommunitySoundEffect() : Boolean
      {
         return this._hasMoreCommunitySoundEffect;
      }
      
      public function get hasMoreCommunityBg() : Boolean
      {
         return this._hasMoreCommunityBg;
      }
      
      public function get hasMoreCommunityProp() : Boolean
      {
         return this._hasMoreCommunityProp;
      }
      
      public function get hasMoreCommunityChar() : Boolean
      {
         return this._hasMoreCommunityChar;
      }
      
      public function get hasMoreCommunityEffect() : Boolean
      {
         return this._hasMoreCommunityEffect;
      }
      
      public function get isSearching() : Boolean
      {
         return this._isSearching;
      }
      
      public function loadStuff(param1:String = "prop") : void
      {
         var _loc3_:URLRequest = null;
         if(this._isLoading)
         {
            return;
         }
         switch(param1)
         {
            case AnimeConstants.ASSET_TYPE_PROP:
               if(this._hasMoreCommunityProp == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_CHAR:
               if(this._hasMoreCommunityChar == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_BG:
               if(this._hasMoreCommunityBg == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_FX:
               if(this._hasMoreCommunityEffect == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND:
               if(this._hasMoreCommunitySound == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC:
               if(this._hasMoreCommunitySoundMusic == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT:
               if(this._hasMoreCommunitySoundEffect == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER:
               if(this._hasMoreCommunitySoundVoice == false)
               {
                  return;
               }
               break;
            case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS:
               if(this._hasMoreCommunitySoundTTS == false)
               {
                  return;
               }
               break;
         }
         this._isLoading = true;
         this._loadingType = param1;
         Console.getConsole().requestLoadStatus(true,true);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc3_ = new URLRequest(ServerConstants.ACTION_GET_COMMUNITYASSETS);
         _loc2_["type"] = this._loadingType;
         if(this._loadingType == AnimeConstants.ASSET_TYPE_CHAR)
         {
            _loc2_["count"] = this.NUM_CHAR_PER_LOAD;
            _loc2_["page"] = this._nextCommunityCharPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc2_["count"] = this.NUM_BG_PER_LOAD;
            _loc2_["page"] = this._nextCommunityBgPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc2_["count"] = this.NUM_PROP_PER_LOAD;
            _loc2_["page"] = this._nextCommunityPropPage;
            _loc2_["subtype"] = "";
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextCommunitySoundPage;
            _loc2_["inclde_files"] = 0;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextCommunitySoundVoicePage;
            _loc2_["inclde_files"] = 0;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextCommunitySoundEffectPage;
            _loc2_["inclde_files"] = 0;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextCommunitySoundMusicPage;
            _loc2_["inclde_files"] = 0;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
         {
            _loc2_["count"] = this.NUM_SOUND_PER_LOAD;
            _loc2_["page"] = this._nextCommunitySoundTTSPage;
            _loc2_["inclde_files"] = 0;
            _loc2_["subtype"] = this._loadingType;
            _loc2_["type"] = AnimeConstants.ASSET_TYPE_SOUND;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_FX)
         {
            _loc2_["count"] = this.NUM_EFFECT_PER_LOAD;
            _loc2_["page"] = this._nextCommunityEffectPage;
         }
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         Console.getConsole().loadProgress = 0;
         var _loc4_:UtilURLStream;
         (_loc4_ = new UtilURLStream()).addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadUserAssetsComplete);
         _loc4_.addEventListener(UtilURLStream.TIME_OUT,this.loadUserThemeTimeOutHandler);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.loadUserThemeIOErrorHandler);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadUserThemeSecurityErrorHandler);
         _loc4_.load(_loc3_);
      }
      
      private function onLoadUserAssetsComplete(param1:Event) : void
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
            if(_loc4_ != 0)
            {
               _loc3_.position = 0;
            }
            this._zipFile = new ZipFile(_loc3_);
            this._xml = new XML(this._zipFile.getInput(this._zipFile.getEntry("desc.xml")));
            this.lastBGIndex = ThemeManager.instance.communityTheme.backgroundThumbs.length;
            this.lastPropIndex = ThemeManager.instance.communityTheme.propThumbs.length;
            this.lastCharIndex = ThemeManager.instance.communityTheme.charThumbs.length;
            this.lastEffectIndex = ThemeManager.instance.communityTheme.effectThumbs.length;
            (_loc5_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateImagedata);
            _loc5_.addEventDispatcher(ThemeManager.instance.communityTheme.eventDispatcher,CoreEvent.DESERIALIZE_THEME_COMPLETE);
            ThemeManager.instance.communityTheme.deSerialize(this._xml);
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
            this._isLoading = false;
            Console.getConsole().loadProgressVisible = false;
            Console.getConsole().requestLoadStatus(false,true);
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_COMMUNITY_ASSET_COMPLETE,this));
         }
      }
      
      private function updateImagedata(param1:Event) : void
      {
         var _loc2_:Thumb = null;
         var _loc3_:ZipEntry = null;
         var _loc4_:UtilHashThumb = null;
         var _loc5_:UtilHashThumb = null;
         var _loc6_:UtilHashThumb = null;
         var _loc7_:UtilHashThumb = null;
         var _loc8_:UtilHashThumb = null;
         var _loc24_:ByteArray = null;
         var _loc25_:ZipFile = null;
         var _loc26_:XML = null;
         var _loc27_:ZipEntry = null;
         var _loc28_:ByteArray = null;
         var _loc29_:ZipEntry = null;
         var _loc30_:ZipFile = null;
         var _loc31_:int = 0;
         var _loc32_:ZipEntry = null;
         _loc4_ = ThemeManager.instance.lastLoaddedTheme.backgroundThumbs;
         _loc5_ = ThemeManager.instance.lastLoaddedTheme.propThumbs;
         _loc6_ = ThemeManager.instance.lastLoaddedTheme.charThumbs;
         _loc7_ = ThemeManager.instance.lastLoaddedTheme.effectThumbs;
         var _loc9_:ZipFile = this._zipFile;
         var _loc10_:XML;
         var _loc11_:Boolean = (_loc10_ = this._xml).@moreBg == "1" ? true : false;
         var _loc12_:Boolean = _loc10_.@moreProp == "1" ? true : false;
         var _loc13_:Boolean = _loc10_.@moreVideoProp == "1" ? true : false;
         var _loc14_:Boolean = _loc10_.@moreChar == "1" ? true : false;
         var _loc15_:Boolean = _loc10_.@moreFx == "1" ? true : false;
         var _loc16_:Boolean = _loc10_.@moreVoice == "1" ? true : false;
         var _loc17_:Boolean = _loc10_.@moreEffect == "1" ? true : false;
         var _loc18_:Boolean = _loc10_.@moreMusic == "1" ? true : false;
         var _loc19_:Boolean = _loc10_.@moreTTS == "1" ? true : false;
         var _loc20_:int = 0;
         while(_loc20_ < _loc4_.length)
         {
            _loc2_ = BackgroundThumb(_loc4_.getValueByIndex(_loc20_));
            _loc3_ = _loc9_.getEntry(_loc2_.getFileName());
            if(_loc3_ != null)
            {
               _loc2_.imageData = _loc9_.getInput(_loc3_);
               _loc2_.thumbImageData = _loc9_.getInput(_loc3_);
               BackgroundThumb(ThemeManager.instance.communityTheme.backgroundThumbs.getValueByIndex(_loc20_ + this.lastBGIndex)).imageData = _loc9_.getInput(_loc3_);
               BackgroundThumb(ThemeManager.instance.communityTheme.backgroundThumbs.getValueByIndex(_loc20_ + this.lastBGIndex)).thumbImageData = _loc9_.getInput(_loc3_);
            }
            _loc20_++;
         }
         var _loc21_:int = 0;
         while(_loc21_ < _loc5_.length)
         {
            _loc2_ = PropThumb(_loc5_.getValueByIndex(_loc21_));
            _loc3_ = _loc9_.getEntry(_loc2_.getFileName());
            if(_loc3_ != null)
            {
               _loc2_.imageData = _loc9_.getInput(_loc3_);
               PropThumb(ThemeManager.instance.communityTheme.propThumbs.getValueByIndex(_loc21_ + this.lastPropIndex)).imageData = _loc9_.getInput(_loc3_);
            }
            _loc21_++;
         }
         var _loc22_:int = 0;
         while(_loc22_ < _loc6_.length)
         {
            _loc2_ = CharThumb(_loc6_.getValueByIndex(_loc22_));
            _loc3_ = _loc9_.getEntry(_loc2_.getFileName());
            if(_loc3_ != null)
            {
               if(!CharThumb(_loc2_).isCC)
               {
                  _loc2_.imageData = _loc9_.getInput(_loc3_);
                  CharThumb(ThemeManager.instance.communityTheme.charThumbs.getValueByIndex(_loc22_ + this.lastCharIndex)).imageData = _loc9_.getInput(_loc3_);
               }
               else if(_loc2_.getFileName().indexOf("zip") >= 0)
               {
                  _loc24_ = _loc9_.getInput(_loc3_);
                  _loc25_ = new ZipFile(_loc24_);
                  _loc2_.imageData = UtilPlain.convertZipAsImagedataObject(_loc25_);
                  if((_loc27_ = _loc9_.getEntry("char/" + _loc2_.id + "/" + CcLibConstant.NODE_LIBRARY + ".zip")) != null)
                  {
                     _loc28_ = _loc9_.getInput(_loc27_) as ByteArray;
                     _loc30_ = new ZipFile(_loc28_);
                     _loc31_ = 0;
                     while(_loc31_ < _loc30_.size)
                     {
                        _loc29_ = _loc30_.entries[_loc31_];
                        CharThumb(_loc2_).addLibrary(_loc29_.name,_loc30_.getInput(_loc29_));
                        _loc31_++;
                     }
                  }
               }
            }
            else
            {
               _loc32_ = _loc9_.getEntry("char/" + _loc2_.id + "/" + _loc2_.id + ".png");
               _loc2_.imageData = _loc9_.getInput(_loc32_);
               _loc2_.useImageAsThumb = true;
            }
            _loc22_++;
         }
         var _loc23_:int = 0;
         while(_loc23_ < _loc7_.length)
         {
            _loc2_ = EffectThumb(_loc7_.getValueByIndex(_loc23_));
            _loc3_ = _loc9_.getEntry(_loc2_.getFileName());
            if(_loc3_ != null)
            {
               _loc2_.imageData = _loc9_.getInput(_loc3_);
               EffectThumb(ThemeManager.instance.communityTheme.effectThumbs.getValueByIndex(_loc23_ + this.lastEffectIndex)).imageData = _loc9_.getInput(_loc3_);
            }
            _loc23_++;
         }
         ThemeManager.instance.communityTheme.mergeTheme(ThemeManager.instance.lastLoaddedTheme);
         ThemeManager.instance.addTheme(ThemeManager.instance.communityTheme.id,ThemeManager.instance.communityTheme);
         if(this._loadingType == AnimeConstants.ASSET_TYPE_BG)
         {
            this._hasMoreCommunityBg = _loc11_;
            ++this._nextCommunityBgPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_PROP)
         {
            this._hasMoreCommunityProp = _loc12_;
            ++this._nextCommunityPropPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_CHAR)
         {
            this._hasMoreCommunityChar = _loc14_;
            ++this._nextCommunityCharPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND)
         {
            this._hasMoreCommunitySoundEffect = _loc17_;
            ++this._nextCommunitySoundEffectPage;
            this._hasMoreCommunitySoundMusic = _loc18_;
            ++this._nextCommunitySoundMusicPage;
            this._hasMoreCommunitySoundVoice = _loc16_;
            ++this._nextCommunitySoundVoicePage;
            this._hasMoreCommunitySoundTTS = _loc19_;
            ++this._nextCommunitySoundTTSPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
         {
            this._hasMoreCommunitySoundEffect = _loc17_;
            ++this._nextCommunitySoundEffectPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
         {
            this._hasMoreCommunitySoundMusic = _loc18_;
            ++this._nextCommunitySoundMusicPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            this._hasMoreCommunitySoundVoice = _loc16_;
            ++this._nextCommunitySoundVoicePage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
         {
            this._hasMoreCommunitySoundTTS = _loc19_;
            ++this._nextCommunitySoundTTSPage;
         }
         else if(this._loadingType == AnimeConstants.ASSET_TYPE_FX)
         {
            this._hasMoreCommunityEffect = _loc15_;
            ++this._nextCommunityEffectPage;
         }
         Console.getConsole().thumbTray.removeLoadingCanvas(this._loadingType);
         Console.getConsole().thumbTray.loadThumbs(ThemeManager.instance.lastLoaddedTheme);
         this._isLoading = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_COMMUNITY_ASSET_COMPLETE,this));
      }
      
      private function loadUserThemeIOErrorHandler(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeIOErrorHandler);
         this._isLoading = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading user theme",param1.type);
      }
      
      private function loadUserThemeSecurityErrorHandler(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeSecurityErrorHandler);
         this._isLoading = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading user theme",param1.type);
      }
      
      private function loadUserThemeTimeOutHandler(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadUserThemeTimeOutHandler);
         this._isLoading = false;
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Operation timeout");
      }
      
      public function searchStuff(param1:String, param2:String = null, param3:Boolean = false) : void
      {
         if(this._isSearching)
         {
            return;
         }
         if(param3)
         {
            this._currentSearchPage = 0;
            this._hasMoreSearch = true;
         }
         if(this._hasMoreSearch == false)
         {
            return;
         }
         if(param2)
         {
            this._currentSearchType = param2;
         }
         this._isSearching = true;
         Console.getConsole().requestLoadStatus(true,true);
         var _loc4_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc4_);
         _loc4_["type"] = this._currentSearchType;
         _loc4_["keywords"] = param1;
         _loc4_["page"] = this._currentSearchPage++;
         _loc4_["count"] = this.NUM_SEARCH_PER_LOAD;
         var _loc5_:URLRequest;
         (_loc5_ = new URLRequest(ServerConstants.ACTION_SEARCH_ASSET)).method = URLRequestMethod.POST;
         _loc5_.data = _loc4_;
         var _loc6_:URLStream;
         (_loc6_ = new URLStream()).addEventListener(Event.COMPLETE,this.onSearchComplete);
         _loc6_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc6_.load(_loc5_);
      }
      
      private function onSearchComplete(param1:Event) : void
      {
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:int = _loc2_.readByte();
         if(_loc3_ == 0)
         {
            this._zipFile = new ZipFile(_loc2_);
            this._xml = new XML(this._zipFile.getInput(this._zipFile.getEntry("desc.xml")));
            this._hasMoreSearch = this._xml.@moreBg == "1" ? true : false;
            Console.getConsole().thumbTray.updateSearchCount(this._xml.@all_asset_count);
            ThemeManager.instance.searchedTheme.clearAllThumbs();
            ThemeManager.instance.searchedTheme.addEventListener(CoreEvent.DESERIALIZE_THEME_COMPLETE,this.updateSearchedImagedata);
            ThemeManager.instance.searchedTheme.deSerialize(this._xml);
         }
         else
         {
            Alert.show("Error: fail to search community library!");
            Console.getConsole().loadProgressVisible = false;
            Console.getConsole().requestLoadStatus(false,true);
            this._isSearching = false;
         }
      }
      
      private function updateSearchedImagedata(param1:Event) : void
      {
         var _loc7_:Thumb = null;
         var _loc8_:ZipEntry = null;
         var _loc2_:ZipFile = this._zipFile;
         var _loc3_:UtilHashThumb = ThemeManager.instance.searchedTheme.backgroundThumbs;
         var _loc4_:UtilHashThumb = ThemeManager.instance.searchedTheme.propThumbs;
         var _loc5_:UtilHashThumb = ThemeManager.instance.searchedTheme.charThumbs;
         var _loc6_:UtilHashThumb = ThemeManager.instance.searchedTheme.effectThumbs;
         var _loc9_:int = 0;
         while(_loc9_ < _loc3_.length)
         {
            _loc7_ = BackgroundThumb(_loc3_.getValueByIndex(_loc9_));
            if((_loc8_ = _loc2_.getEntry(_loc7_.getFileName())) != null)
            {
               _loc7_.imageData = _loc2_.getInput(_loc8_);
               _loc7_.thumbImageData = _loc2_.getInput(_loc8_);
            }
            _loc9_++;
         }
         var _loc10_:int = 0;
         while(_loc10_ < _loc4_.length)
         {
            _loc7_ = PropThumb(_loc4_.getValueByIndex(_loc10_));
            if((_loc8_ = _loc2_.getEntry(_loc7_.getFileName())) != null)
            {
               _loc7_.imageData = _loc2_.getInput(_loc8_);
            }
            _loc10_++;
         }
         var _loc11_:int = 0;
         while(_loc11_ < _loc5_.length)
         {
            _loc7_ = CharThumb(_loc5_.getValueByIndex(_loc11_));
            if((_loc8_ = _loc2_.getEntry(_loc7_.getFileName())) != null)
            {
               _loc7_.imageData = _loc2_.getInput(_loc8_);
            }
            _loc11_++;
         }
         var _loc12_:int = 0;
         while(_loc12_ < _loc6_.length)
         {
            _loc7_ = EffectThumb(_loc6_.getValueByIndex(_loc12_));
            if((_loc8_ = _loc2_.getEntry(_loc7_.getFileName())) != null)
            {
               _loc7_.imageData = _loc2_.getInput(_loc8_);
            }
            _loc12_++;
         }
         ThemeManager.instance.addTheme(ThemeManager.instance.searchedTheme.id,ThemeManager.instance.searchedTheme);
         Console.getConsole().thumbTray.loadThumbs(ThemeManager.instance.searchedTheme);
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         this._isSearching = false;
      }
      
      public function loadPublicTemplate() : void
      {
         var _loc1_:URLRequest = new URLRequest(ServerConstants.ACTION_GET_PUBLICTEMPLATE);
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         var _loc3_:UtilURLStream = new UtilURLStream();
         _loc3_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc3_.addEventListener(Event.COMPLETE,this.onLoadPublicTemplateComplete);
         _loc2_["count"] = this.NUM_TEMPLATE_PER_LOAD;
         _loc2_["page"] = this._nextPublicTemplatePage;
         _loc2_["type"] = "movie";
         _loc1_.method = URLRequestMethod.POST;
         _loc1_.data = _loc2_;
         Console.getConsole().thumbTray.showTrayLoading(true);
         Console.getConsole().requestLoadStatus(true,true);
         _loc3_.load(_loc1_);
      }
      
      private function onLoadPublicTemplateComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadPublicTemplateComplete);
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
            Alert.show("Oops...fail to load public sceme template!");
         }
         Console.getConsole().loadProgressVisible = false;
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
            if(ThemeManager.instance.currentTheme.templateThumbs.getValueByKey(_loc8_.id))
            {
               _loc4_.removeByKey(_loc8_.id);
            }
            _loc7_--;
         }
         ThemeManager.instance.communityTheme.addEventListener(CoreEvent.DESERIALIZE_THEME_COMPLETE,this.updateTemplateImagedataSecond);
         ThemeManager.instance.communityTheme.deSerialize(_loc2_);
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
               TemplateThumb(ThemeManager.instance.communityTheme.templateThumbs.getValueByKey(_loc8_.id)).imageData = _loc3_.getInput(_loc5_);
               TemplateThumb(ThemeManager.instance.communityTheme.templateThumbs.getValueByKey(_loc8_.id)).thumbImageData = _loc3_.getInput(_loc5_);
            }
            _loc7_--;
         }
         ++this._nextPublicTemplatePage;
         this._hasMorePublicTemplate = _loc6_;
         Console.getConsole().thumbTray.loadThumbs(ThemeManager.instance.lastLoaddedTheme,false,Console.getConsole().thumbTray._uiTileTemplateThemes);
         Console.getConsole().thumbTray.showTrayLoading(false);
         Console.getConsole().loadProgressVisible = false;
         Console.getConsole().requestLoadStatus(false,true);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_USER_ASSET_COMPLETE,this));
      }
      
      public function updateTemplate(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc4_);
         _loc4_["movieId"] = param1;
         _loc4_["title"] = param2;
         _loc4_["tags"] = param3;
         var _loc5_:URLRequest;
         (_loc5_ = new URLRequest(ServerConstants.ACTION_UPDATE_TEMPLATE_INFO)).data = _loc4_;
         _loc5_.method = URLRequestMethod.POST;
         var _loc6_:URLStream;
         (_loc6_ = new URLStream()).addEventListener(Event.COMPLETE,this.onUpdateTemplateComplete);
         _loc6_.load(_loc5_);
      }
      
      private function onUpdateTemplateComplete(param1:Event = null) : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.UPDATE_ASSET_COMPLETE,this));
      }
   }
}
