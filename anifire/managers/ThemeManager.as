package anifire.managers
{
   import anifire.components.studio.ThumbTray;
   import anifire.constant.ThemeConstants;
   import anifire.core.Console;
   import anifire.core.Theme;
   import anifire.event.CoreEvent;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
   import anifire.iterators.ArrayIterator;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilLoadMgr;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ThemeManager extends EventDispatcher implements ICollection
   {
      
      private static var _instance:ThemeManager;
       
      
      private var _themes:UtilHashArray;
      
      private var _currentTheme:Theme;
      
      private var _userTheme:Theme;
      
      private var _communityTheme:Theme;
      
      private var _lastLoaddedTheme:Theme;
      
      private var _searchedTheme:Theme;
      
      private var _movieTheme:Theme;
      
      private var _isLoaddingCommonTheme:Boolean = false;
      
      private var _isCommonThemeLoadded:Boolean = false;
      
      private var _isLoaddingCommonThemeBg:Boolean = false;
      
      private var _isLoaddingCommonThemeProp:Boolean = false;
      
      private var _isLoaddingCommonThemeChar:Boolean = false;
      
      public var themeList:Array;
      
      public function ThemeManager(param1:IEventDispatcher = null)
      {
         super(param1);
         this._themes = new UtilHashArray();
         this._userTheme = new Theme();
         this._userTheme.id = "ugc";
         this._communityTheme = new Theme();
         this._communityTheme.id = "ugc";
         this._lastLoaddedTheme = new Theme();
         this._lastLoaddedTheme.id = "ugc";
         this._searchedTheme = new Theme();
         this._searchedTheme.id = "ugc";
         this._movieTheme = new Theme();
         this._movieTheme.id = ThumbTray.MOVIE_THEME;
      }
      
      public static function get instance() : ThemeManager
      {
         if(_instance == null)
         {
            _instance = new ThemeManager();
         }
         return _instance;
      }
      
      public function getThemeLabel(param1:String) : String
      {
         var _loc2_:int = 0;
         if(this.themeList)
         {
            _loc2_ = 0;
            while(_loc2_ < this.themeList.length)
            {
               if(this.themeList[_loc2_].id == param1)
               {
                  return UtilDict.toDisplay("store",this.themeList[_loc2_].label);
               }
               _loc2_++;
            }
         }
         return "";
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         return new ArrayIterator(this._themes.getArray());
      }
      
      public function addTheme(param1:String, param2:Theme) : void
      {
         var _loc3_:Theme = null;
         if(this._themes.getValueByKey(param1) == null)
         {
            this._themes.push(param1,param2);
         }
         else
         {
            _loc3_ = this._themes.getValueByKey(param1) as Theme;
            _loc3_.mergeTheme(param2);
            this._themes.push(param1,_loc3_);
         }
      }
      
      public function getTheme(param1:String) : Theme
      {
         return this._themes.getValueByKey(param1) as Theme;
      }
      
      public function get themes() : UtilHashArray
      {
         return this._themes;
      }
      
      public function get currentTheme() : Theme
      {
         return this._currentTheme;
      }
      
      public function set currentTheme(param1:Theme) : void
      {
         this._currentTheme = param1;
      }
      
      public function get userTheme() : Theme
      {
         return this._userTheme;
      }
      
      public function get communityTheme() : Theme
      {
         return this._communityTheme;
      }
      
      public function get movieTheme() : Theme
      {
         return this._movieTheme;
      }
      
      public function get searchedTheme() : Theme
      {
         return this._searchedTheme;
      }
      
      public function get lastLoaddedTheme() : Theme
      {
         return this._lastLoaddedTheme;
      }
      
      public function resetUserTheme() : void
      {
         this._userTheme = new Theme();
         this._userTheme.id = "ugc";
      }
      
      public function loadTheme(param1:String, param2:Boolean = false) : void
      {
         StudioStatusManager.instance.status = "Loading theme...";
         Console.getConsole().requestLoadStatus(true,true);
         Util.gaTracking("/gostudio/themes/loading/" + param1,Console.getConsole().mainStage.stage);
         var _loc3_:Theme = this.getTheme(param1);
         if(_loc3_ == null)
         {
            _loc3_ = new Theme();
            _loc3_.id = param1;
            this.addTheme(param1,_loc3_);
         }
         if(param2)
         {
            this.currentTheme = _loc3_;
         }
         this._isLoaddingCommonTheme = param1 == ThemeConstants.COMMON_THEME_ID;
         _loc3_.addEventListener(CoreEvent.LOAD_THEME_COMPLETE,this.LoadThemeComplete);
         _loc3_.initThemeByLoadThemeFile(Console.getConsole(),param1);
      }
      
      private function LoadThemeComplete(param1:CoreEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.LoadThemeComplete);
         StudioStatusManager.instance.status = "Theme loaded.";
         var _loc2_:Theme = param1.getEventCreater() as Theme;
         if(_loc2_.id != "common")
         {
            this.currentTheme = _loc2_;
            Console.getConsole().thumbTray.themeId = _loc2_.id;
         }
         else
         {
            this._isCommonThemeLoadded = true;
         }
         Util.gaTracking("/gostudio/themes/complete/" + _loc2_.id,Console.getConsole().mainStage.stage);
         if(UtilLicense.getCurrentLicenseId() == "8")
         {
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,_loc2_));
      }
      
      public function get isLoaddingCommonTheme() : Boolean
      {
         return this._isLoaddingCommonTheme;
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
      
      public function loadThemeBg(param1:String) : void
      {
         var _loc2_:Theme = null;
         _loc2_ = this.getTheme(param1);
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
         _loc1_ = this.getTheme("common");
         if(_loc1_ == null)
         {
         }
         if(_loc1_.isBgZipLoaded())
         {
            Console.getConsole().thumbTray.loadBackgroundThumbs(_loc1_,new UtilLoadMgr());
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
         Console.getConsole().thumbTray.loadBackgroundThumbs(_loc2_,new UtilLoadMgr());
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
         _loc2_ = this.getTheme(param1);
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
         _loc1_ = this.getTheme("common");
         if(_loc1_ == null)
         {
         }
         if(_loc1_.isPropZipLoaded())
         {
            Console.getConsole().thumbTray.loadPropThumbs(_loc1_,new UtilLoadMgr());
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
         Console.getConsole().thumbTray.loadPropThumbs(_loc2_,new UtilLoadMgr());
         if(!this.isLoaddingCommonThemeProp)
         {
            this.loadCommonThemeProp();
         }
         else
         {
            Util.gaTracking("/gostudio/CommonTheme/complete/prop",Console.getConsole().mainStage.stage);
         }
      }
   }
}
