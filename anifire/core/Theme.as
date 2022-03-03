package anifire.core
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ProductConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.CoreEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.interfaces.IBehavior;
   import anifire.interfaces.ITheme;
   import anifire.interfaces.IThumb;
   import anifire.managers.ThemeManager;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilHashThumb;
   import anifire.util.UtilLicense;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.setTimeout;
   import mx.controls.Alert;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Theme implements ITheme
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Theme");
       
      
      private var _console:Console;
      
      private var _id:String;
      
      private var _cc_theme_id:String;
      
      private var _name:String;
      
      private var _backgroundThumbs:UtilHashThumb;
      
      private var _defaultBgThumb:BackgroundThumb;
      
      private var _defaultPropThumb:PropThumb;
      
      private var _defaultCharThumb:CharThumb;
      
      private var _charThumbs:UtilHashThumb;
      
      private var _bubbleThumbs:UtilHashThumb;
      
      private var _propThumbs:UtilHashThumb;
      
      private var _soundThumbs:UtilHashThumb;
      
      private var _effectThumbs:UtilHashThumb;
      
      private var _templateThumbs:UtilHashThumb;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _isLoadingBg:Boolean = false;
      
      private var _isLoadingProp:Boolean = false;
      
      private var _isPropZipLoaded:Boolean = false;
      
      private var _isBgZipLoaded:Boolean = false;
      
      private var _isLoadingChar:Boolean = false;
      
      private var _isCharZipLoaded:Boolean = false;
      
      private var _themeXML:XML;
      
      private var _purchasedContent:XMLList;
      
      private var _isThemeZipLoaded:Boolean = false;
      
      private var _themeTree:ThemeTree;
      
      private var taskArray:Vector.<XML>;
      
      private var isMovieTheme:Boolean;
      
      private var _themeZip:ZipFile;
      
      public function Theme()
      {
         super();
         this._backgroundThumbs = new UtilHashThumb();
         this._charThumbs = new UtilHashThumb();
         this._bubbleThumbs = new UtilHashThumb();
         this._propThumbs = new UtilHashThumb();
         this._soundThumbs = new UtilHashThumb();
         this._effectThumbs = new UtilHashThumb();
         this._templateThumbs = new UtilHashThumb();
         this._themeXML = null;
         this._eventDispatcher = new EventDispatcher();
         this._purchasedContent = new XMLList();
      }
      
      public static function merge2ThemeXml(param1:XML, param2:XML, param3:String, param4:String, param5:Boolean = false) : XML
      {
         return UtilXmlInfo.merge2ThemeXml(param1,param2,param3,param4,param5);
      }
      
      public function get console() : Console
      {
         return this._console;
      }
      
      public function set console(param1:Console) : void
      {
         this._console = param1;
      }
      
      public function clearAllThumbs() : void
      {
         this._charThumbs.removeAll();
         this._backgroundThumbs.removeAll();
         this._propThumbs.removeAll();
         this._effectThumbs.removeAll();
         this._soundThumbs.removeAll();
         this._bubbleThumbs.removeAll();
         this._templateThumbs.removeAll();
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function getThemeXML() : XML
      {
         return this._themeXML;
      }
      
      private function setThemeXML(param1:XML) : void
      {
         if(this._themeXML == null)
         {
            this._themeXML = param1;
         }
         else
         {
            this.mergeThemeXML(param1);
         }
      }
      
      public function mergeThemeXML(param1:XML) : void
      {
         var _loc2_:int = 0;
         var _loc3_:XML = null;
         if(this._themeXML == null)
         {
            this._themeXML = param1;
            return;
         }
         this._themeXML = merge2ThemeXml(this._themeXML,param1,this.id,this.name,true);
      }
      
      public function set cc_theme_id(param1:String) : void
      {
         this._cc_theme_id = param1;
      }
      
      public function get cc_theme_id() : String
      {
         return this._cc_theme_id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get charThumbs() : UtilHashThumb
      {
         return this._charThumbs;
      }
      
      public function get backgroundThumbs() : UtilHashThumb
      {
         return this._backgroundThumbs;
      }
      
      public function get bubbleThumbs() : UtilHashThumb
      {
         return this._bubbleThumbs;
      }
      
      public function get propThumbs() : UtilHashThumb
      {
         return this._propThumbs;
      }
      
      public function get soundThumbs() : UtilHashThumb
      {
         return this._soundThumbs;
      }
      
      public function get effectThumbs() : UtilHashThumb
      {
         return this._effectThumbs;
      }
      
      public function get templateThumbs() : UtilHashThumb
      {
         return this._templateThumbs;
      }
      
      public function get defaultBgThumb() : BackgroundThumb
      {
         return this._defaultBgThumb;
      }
      
      public function get defaultPropThumb() : PropThumb
      {
         return this._defaultPropThumb;
      }
      
      public function get defaultCharThumb() : CharThumb
      {
         return this._defaultCharThumb;
      }
      
      public function initThemeByLoadThemeFile(param1:Console, param2:String) : void
      {
         if(this.isThemeZipLoaded() || Console.getConsole().studioType == Console.MESSAGE_STUDIO)
         {
            this._eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this));
         }
         else
         {
            this.console = param1;
            this.id = param2;
            this.loadXML();
         }
      }
      
      public function initThemeByThemeTree(param1:ThemeTree, param2:XML, param3:ZipFile, param4:Console) : void
      {
         this.console = param4;
         this.id = param1.getThemeID();
         this._themeZip = param3;
         this._themeTree = param1;
         this.addEventListener(CoreEvent.DESERIALIZE_THEME_COMPLETE,this.initImagedataFromZip);
         this.deSerialize(param2,false);
      }
      
      private function initImagedataFromZip(param1:CoreEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:UtilHashArray = null;
         var _loc6_:String = null;
         var _loc7_:ByteArray = null;
         var _loc9_:* = null;
         var _loc10_:BackgroundThumb = null;
         var _loc11_:PropThumb = null;
         var _loc12_:SoundThumb = null;
         var _loc13_:EffectThumb = null;
         var _loc14_:CharThumb = null;
         var _loc2_:ThemeTree = this._themeTree;
         var _loc3_:ZipFile = this._themeZip;
         var _loc8_:UtilLoadMgr = new UtilLoadMgr();
         _loc5_ = _loc2_.getBgThumbs();
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc6_ = _loc5_.getKey(_loc4_);
            _loc7_ = _loc5_.getValueByIndex(_loc4_);
            if((_loc10_ = this.getBackgroundThumbById(_loc6_)) != null && _loc7_)
            {
               _loc10_.imageData = _loc10_.thumbImageData = _loc7_;
               ThemeManager.instance.movieTheme.addThumb(_loc10_);
            }
            _loc4_++;
         }
         _loc5_ = _loc2_.getPropThumbs();
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if((_loc6_ = _loc5_.getKey(_loc4_)).indexOf(".head.") != -1)
            {
               _loc6_ = UtilXmlInfo.getFacialThumbIdFromFileName(_loc6_);
            }
            if((_loc11_ = this.getPropThumbById(_loc6_) as PropThumb) != null)
            {
               if(_loc11_.getStateNum() > 0)
               {
                  _loc9_ = this.id + ".prop." + _loc6_ + ".";
                  _loc11_.initImageData(_loc3_,_loc9_);
               }
               else
               {
                  _loc7_ = _loc5_.getValueByIndex(_loc4_);
                  _loc11_.imageData = _loc7_;
               }
               ThemeManager.instance.movieTheme.addThumb(_loc11_);
            }
            _loc4_++;
         }
         _loc5_ = _loc2_.getSoundThumbs();
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc6_ = _loc5_.getKey(_loc4_);
            _loc7_ = _loc5_.getValueByIndex(_loc4_);
            _loc8_.addEventDispatcher(this.getSoundThumbById(_loc6_).eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            if((_loc12_ = this.getSoundThumbById(_loc6_)) != null)
            {
               _loc12_.initSoundByByteArray(_loc7_);
            }
            _loc4_++;
         }
         _loc5_ = _loc2_.getEffectThumbs();
         _loc4_ = 0;
         while(_loc4_ < this._effectThumbs.length)
         {
            _loc6_ = _loc5_.getKey(_loc4_);
            _loc7_ = _loc5_.getValueByIndex(_loc4_);
            if((_loc13_ = this.getEffectThumbById(_loc6_)) != null)
            {
               if(_loc13_.getType() == EffectThumb.TYPE_ANIME)
               {
                  _loc13_.imageData = _loc7_;
               }
               ThemeManager.instance.movieTheme.addThumb(_loc13_);
            }
            _loc4_++;
         }
         _loc5_ = _loc2_.getCharThumbs();
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc6_ = _loc5_.getKey(_loc4_);
            _loc14_ = this.getCharThumbById(_loc6_);
            _loc8_.addEventDispatcher(_loc14_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc9_ = this.id + ".char." + _loc6_ + ".";
            if(_loc14_ != null)
            {
               _loc14_.initImageData(_loc3_,_loc9_);
               ThemeManager.instance.movieTheme.addThumb(_loc14_);
            }
            _loc4_++;
         }
         _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doLoadThemeByThemeTreeCompleted);
         _loc8_.commit();
      }
      
      private function doLoadThemeByThemeTreeCompleted(param1:Event) : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEMETREE_COMPLETE,this));
      }
      
      public function addThumb(param1:Thumb, param2:XML = null) : void
      {
         var _loc3_:CharThumb = null;
         var _loc4_:PropThumb = null;
         if(this._themeXML == null)
         {
            this._themeXML = UtilXmlInfo.createThemeXml(this.id,this.name);
         }
         if(param2 != null)
         {
            this._themeXML.appendChild(param2);
         }
         if(param1 is CharThumb)
         {
            _loc3_ = this._charThumbs.getValueByKey(param1.id) as CharThumb;
            if(_loc3_ != null)
            {
               if(_loc3_.isThumbReady() == false)
               {
                  (param1 as CharThumb).mergeThumb(_loc3_);
                  this._charThumbs.push(param1.id,param1);
               }
            }
            else
            {
               this._charThumbs.push(param1.id,param1);
            }
         }
         else if(param1 is BackgroundThumb)
         {
            this._backgroundThumbs.push(param1.id,param1);
         }
         else if(param1 is BubbleThumb)
         {
            this._bubbleThumbs.push(param1.id,param1);
         }
         else if(param1 is VideoPropThumb)
         {
            this._propThumbs.push(param1.id,param1);
         }
         else if(param1 is PropThumb)
         {
            if((_loc4_ = this.propThumbs.getValueByKey(param1.id) as PropThumb) != null)
            {
               if(_loc4_.isThumbReady() == false)
               {
                  (param1 as PropThumb).mergeThumb(_loc4_);
                  this.propThumbs.push(param1.id,param1);
               }
            }
            else
            {
               this._propThumbs.push(param1.id,param1);
            }
         }
         else if(param1 is SoundThumb)
         {
            this._soundThumbs.push(param1.id,param1);
         }
         else if(param1 is EffectThumb)
         {
            this._effectThumbs.push(param1.id,param1);
         }
         else if(param1 is TemplateThumb)
         {
            this._templateThumbs.push(param1.id,param1);
         }
      }
      
      public function isBgZipLoaded() : Boolean
      {
         return this._isBgZipLoaded;
      }
      
      public function isPropZipLoaded() : Boolean
      {
         return this._isPropZipLoaded;
      }
      
      public function isCharZipLoaded() : Boolean
      {
         return this._isCharZipLoaded;
      }
      
      private function isThemeZipLoaded() : Boolean
      {
         var _loc1_:Thumb = null;
         var _loc2_:int = 0;
         if(this._isThemeZipLoaded)
         {
            return true;
         }
         return false;
      }
      
      private function deserializeThumb(param1:XML, param2:Boolean = false) : void
      {
         var _loc3_:CharThumb = null;
         var _loc4_:PropThumb = null;
         var _loc5_:BackgroundThumb = null;
         var _loc6_:BackgroundThumb = null;
         var _loc7_:PropThumb = null;
         var _loc8_:SoundThumb = null;
         var _loc9_:BubbleThumb = null;
         var _loc10_:EffectThumb = null;
         var _loc11_:TemplateThumb = null;
         if(param1.name().localName == CharThumb.XML_NODE_NAME)
         {
            _loc3_ = new CharThumb();
            _loc3_.deSerialize(param1,this);
            if(this.getCharThumbById(param1.@id) == null)
            {
               this.addThumb(_loc3_);
            }
            if(param2)
            {
               ThemeManager.instance.movieTheme.addThumb(_loc3_);
            }
            if(param1.facial.length() > 0)
            {
               (_loc4_ = new PropThumb()).deSerializeFacial(param1,this,_loc3_.raceCode,!!_loc3_.enable ? 2 : 0);
               this.addThumb(_loc4_);
            }
         }
         else if(param1.name().localName == BackgroundThumb.XML_NODE_NAME_CBG)
         {
            _loc5_ = new BackgroundThumb();
            Console.getConsole().addStoreCollection(param1.@name);
            _loc5_.deSerialize(param1,this,true);
            if(this.getBackgroundThumbById(param1.@id) == null)
            {
               this.addThumb(_loc5_);
               if(param1.attribute("default") == "Y")
               {
                  _loc5_.isDefault = true;
                  this._defaultBgThumb = _loc5_;
               }
            }
            if(!param2)
            {
            }
         }
         else if(param1.name().localName == BackgroundThumb.XML_NODE_NAME)
         {
            if(this.getBackgroundThumbById(param1.@id) == null)
            {
               _loc6_ = new BackgroundThumb();
               Console.getConsole().addStoreCollection(param1.@name);
               _loc6_.deSerialize(param1,this);
               this.addThumb(_loc6_);
               if(!param2)
               {
               }
               if(param1.attribute("default") == "Y")
               {
                  _loc6_.isDefault = true;
                  this._defaultBgThumb = _loc6_;
               }
            }
         }
         else if(param1.name().localName == PropThumb.XML_NODE_NAME)
         {
            if(param1.@subtype == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
            {
               _loc7_ = new VideoPropThumb();
            }
            else
            {
               _loc7_ = new PropThumb();
            }
            Console.getConsole().addStoreCollection(param1.@name);
            _loc7_.deSerialize(param1,this);
            _loc7_.xml = param1;
            if(this.getPropThumbById(param1.@id) == null)
            {
               this.addThumb(_loc7_);
               if(param1.attribute("default") == "Y")
               {
                  this._defaultPropThumb = _loc7_;
               }
            }
            if(param2)
            {
               ThemeManager.instance.movieTheme.addThumb(_loc7_);
            }
         }
         else if(param1.name().localName == SoundThumb.XML_NODE_NAME)
         {
            (_loc8_ = new SoundThumb()).deSerialize(param1,this);
            _loc8_.xml = param1;
            if(this.getSoundThumbById(param1.@id) == null)
            {
               this.addThumb(_loc8_);
            }
            if(param2)
            {
               ThemeManager.instance.movieTheme.addThumb(_loc8_);
            }
         }
         else if(param1.name().localName == BubbleThumb.XML_NODE_NAME)
         {
            if(this.getBubbleThumbById(param1.@id) == null)
            {
               (_loc9_ = new BubbleThumb()).deSerialize(param1,this);
               _loc9_.xml = param1;
               this.addThumb(_loc9_);
            }
         }
         else if(param1.name().localName == EffectThumb.XML_NODE_NAME)
         {
            _loc10_ = new EffectThumb();
            Console.getConsole().addStoreCollection(param1.@name);
            _loc10_.deSerialize(param1,this);
            _loc10_.xml = param1;
            if(this.getEffectThumbById(param1.@id) == null)
            {
               this.addThumb(_loc10_);
            }
            if(param2)
            {
               ThemeManager.instance.movieTheme.addThumb(_loc10_);
            }
         }
         else if(param1.name().localName == TemplateThumb.XML_NODE_NAME)
         {
            (_loc11_ = new TemplateThumb()).deSerialize(param1,this);
            _loc11_.xml = param1;
            if(this.getTemplateThumbById(param1.@id) == null)
            {
               this.addThumb(_loc11_);
            }
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.DESERIALIZE_THUMB_COMPLETE,this));
      }
      
      public function deSerialize(param1:XML, param2:Boolean = false) : void
      {
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         this.setThemeXML(param1);
         this.id = param1.@id;
         this.cc_theme_id = param1.@cc_theme_id;
         this.taskArray = new Vector.<XML>();
         this.isMovieTheme = param2;
         _loc3_ = param1.child(CharThumb.XML_NODE_NAME) as XMLList;
         for each(_loc4_ in _loc3_)
         {
            this.taskArray.push(_loc4_);
         }
         _loc3_ = param1.child(BackgroundThumb.XML_NODE_NAME_CBG) as XMLList;
         for each(_loc4_ in _loc3_)
         {
            this.taskArray.push(_loc4_);
         }
         _loc3_ = param1.child(BackgroundThumb.XML_NODE_NAME) as XMLList;
         for each(_loc4_ in _loc3_)
         {
            this.taskArray.push(_loc4_);
         }
         _loc3_ = param1.child(PropThumb.XML_NODE_NAME) as XMLList;
         for each(_loc4_ in _loc3_)
         {
            this.taskArray.push(_loc4_);
         }
         if(!(this.id == "common" && !UtilLicense.isCommonSoundShouldBeShown(ThemeManager.instance.currentTheme.id)))
         {
            _loc3_ = param1.child(SoundThumb.XML_NODE_NAME) as XMLList;
            for each(_loc4_ in _loc3_)
            {
               this.taskArray.push(_loc4_);
            }
         }
         _loc3_ = param1.child(BubbleThumb.XML_NODE_NAME) as XMLList;
         for each(_loc4_ in _loc3_)
         {
            this.taskArray.push(_loc4_);
         }
         _loc3_ = param1.child(EffectThumb.XML_NODE_NAME) as XMLList;
         for each(_loc4_ in _loc3_)
         {
            this.taskArray.push(_loc4_);
         }
         _loc3_ = param1.child(TemplateThumb.XML_NODE_NAME) as XMLList;
         for each(_loc4_ in _loc3_)
         {
            this.taskArray.push(_loc4_);
         }
         _loc3_ = param1.child("presetMsg") as XMLList;
         for each(_loc4_ in _loc3_)
         {
            _loc6_ = _loc4_.@quote;
            PresetMsg.getInstance().insertMsg(this.id,_loc6_);
         }
         this.startPrepare();
      }
      
      private function startPrepare() : void
      {
         Console.getConsole().loadProgress = 0;
         this.doNextPrepare();
      }
      
      private function doNextPrepare(param1:Event = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:UtilLoadMgr = null;
         if(param1)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doNextPrepare);
         }
         var _loc2_:int = 32;
         if(this.taskArray.length > 0)
         {
            _loc3_ = 0;
            (_loc4_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doNextPrepare);
            while(_loc3_ < _loc2_ && this.taskArray.length > 0)
            {
               _loc4_.addEventDispatcher(this.eventDispatcher,CoreEvent.DESERIALIZE_THUMB_COMPLETE);
               setTimeout(this.deserializeThumb,1,this.taskArray.shift(),this.isMovieTheme);
               Console.getConsole().loadProgress = 100 - this.taskArray.length;
               _loc3_++;
            }
            _loc4_.commit();
         }
         else
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.DESERIALIZE_THEME_COMPLETE,this));
         }
      }
      
      public function modifyPremiumContent(param1:XMLList) : void
      {
         if(this._purchasedContent == null)
         {
            this._purchasedContent = param1;
         }
         else
         {
            this._purchasedContent += param1;
         }
      }
      
      public function changePurchase(param1:String, param2:String, param3:Boolean) : void
      {
         var aiid:String = param1;
         var name:String = param2;
         var p:Boolean = param3;
         if(this._purchasedContent == null)
         {
            this._purchasedContent = new XMLList();
         }
         if(p)
         {
            this._purchasedContent += new XML("<premium theme=\"" + this._name + "\" aid=\"" + aiid + "\" expired=\"N\"/>");
         }
         else
         {
            try
            {
               this._purchasedContent.(@aid == aiid)[0].@expired = "Y";
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function assetPurchased(param1:String) : Boolean
      {
         var aiid:String = param1;
         if(Console.getConsole().premiumEnabled())
         {
            if(this._purchasedContent.(@aid == aiid).length() > 0)
            {
               if(this._purchasedContent.(@aid == aiid)[0].@expired == "N")
               {
                  return true;
               }
            }
            return false;
         }
         return true;
      }
      
      public function getThumbNodeFromThemeXML(param1:XML, param2:Thumb) : XML
      {
         var themeXML:XML = param1;
         var thumb:Thumb = param2;
         var nodeName:String = "";
         if(thumb is CharThumb)
         {
            nodeName = CharThumb.XML_NODE_NAME;
         }
         else if(thumb is BackgroundThumb)
         {
            nodeName = BackgroundThumb.XML_NODE_NAME;
         }
         else if(thumb is PropThumb)
         {
            nodeName = PropThumb.XML_NODE_NAME;
         }
         else if(thumb is SoundThumb)
         {
            nodeName = SoundThumb.XML_NODE_NAME;
         }
         else if(thumb is BubbleThumb)
         {
            nodeName = BubbleThumb.XML_NODE_NAME;
         }
         else if(thumb is EffectThumb)
         {
            nodeName = EffectThumb.XML_NODE_NAME;
         }
         return themeXML.child(nodeName).(@id == thumb.id)[0];
      }
      
      public function setThumbNodeFromXML(param1:XML, param2:String) : XML
      {
         var cxml:XML = param1;
         var idd:String = param2;
         if(this._themeXML != null)
         {
            this._themeXML.children().(@id == idd)[0] = cxml;
            return this._themeXML.children().(@id == idd)[0];
         }
         return null;
      }
      
      private function doLoadThumbSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbSecurityError);
         Console.getConsole().requestLoadStatus(false,true);
         Console.getConsole().loadProgressVisible = false;
         Alert.show("Error in loading thumbs",param1.type);
      }
      
      private function doLoadThumbIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbIOError);
         Console.getConsole().requestLoadStatus(false,true);
         Console.getConsole().loadProgressVisible = false;
         Alert.show("Sorry, connection error occurs, please try again later.\n\n" + param1.toString());
      }
      
      private function doLoadThumbTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbTimeOut);
         Console.getConsole().requestLoadStatus(false,true);
         Console.getConsole().loadProgressVisible = false;
         Alert.show("Operation timeout");
      }
      
      private function doLoadXMLComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadXMLComplete);
         var _loc2_:URLLoader = param1.target as URLLoader;
         this.doLoadXMLBytesComplete(_loc2_.data as ByteArray);
      }
      
      public function isStateExists(param1:XML, param2:IBehavior) : Boolean
      {
         var filename:String = null;
         var id:String = null;
         var theme:Theme = null;
         var themeId:String = null;
         var thumbId:String = null;
         var stateId:String = null;
         var nodeXML:XML = null;
         var nodeName:String = null;
         var propFile:String = null;
         var xml:XML = param1;
         var state:IBehavior = param2;
         var result:Boolean = false;
         var sortedIndex:Array = UtilXmlInfo.getAndSortXMLattribute(xml,"index");
         var i:int = 0;
         while(i < sortedIndex.length)
         {
            nodeXML = xml.children().(@index == String(sortedIndex[i]))[0];
            nodeName = nodeXML.name();
            switch(nodeName)
            {
               case Prop.XML_NODE_NAME:
                  propFile = nodeXML.child("file")[0].toString();
                  thumbId = UtilXmlInfo.getPropIdFromFileName(propFile);
                  stateId = UtilXmlInfo.getPropStateIdFromFileName(propFile);
                  if(State(state).thumb.id == thumbId && State(state).id == stateId)
                  {
                     result = true;
                  }
                  break;
            }
            i++;
         }
         return result;
      }
      
      public function doOutputThumbs(param1:XML) : UtilHashArray
      {
         var filename:String = null;
         var id:String = null;
         var theme:Theme = null;
         var themeId:String = null;
         var thumbId:String = null;
         var nodeXML:XML = null;
         var nodeName:String = null;
         var bgThumb:BackgroundThumb = null;
         var propFile:String = null;
         var propThumb:PropThumb = null;
         var charFile:String = null;
         var charThumb:CharThumb = null;
         var fxId:String = null;
         var fxThumb:EffectThumb = null;
         var fxFile:String = null;
         var xml:XML = param1;
         var tempArray:UtilHashArray = new UtilHashArray();
         var sortedIndex:Array = UtilXmlInfo.getAndSortXMLattribute(xml,"index");
         var i:int = 0;
         while(i < sortedIndex.length)
         {
            nodeXML = xml.children().(@index == String(sortedIndex[i]))[0];
            nodeName = nodeXML.name();
            switch(nodeName)
            {
               case Background.XML_NODE_NAME:
                  filename = UtilXmlInfo.getZipFileNameOfBg(nodeXML.file);
                  thumbId = UtilXmlInfo.getThumbIdFromFileName(filename);
                  bgThumb = this.getBackgroundThumbById(thumbId);
                  tempArray.push(bgThumb.id,bgThumb);
                  break;
               case Prop.XML_NODE_NAME:
                  propFile = nodeXML.child("file")[0].toString();
                  thumbId = UtilXmlInfo.getPropIdFromFileName(propFile);
                  propThumb = this.getPropThumbById(thumbId) as PropThumb;
                  tempArray.push(propThumb.id,propThumb);
                  break;
               case Character.XML_NODE_NAME:
                  charFile = UtilXmlInfo.getZipFileNameOfBehaviour(nodeXML.child("action")[0].toString(),true);
                  thumbId = UtilXmlInfo.getCharIdFromFileName(charFile);
                  charThumb = this.getCharThumbById(thumbId);
                  if(charThumb)
                  {
                     tempArray.push(charThumb.id,charThumb);
                  }
                  break;
               case BubbleAsset.XML_NODE_NAME:
                  break;
               case EffectAsset.XML_NODE_NAME:
                  fxId = nodeXML.child("effect")[0].@id.toString();
                  theme = ThemeManager.instance.getTheme("common");
                  if(nodeXML.child("file").length > 0)
                  {
                     fxFile = nodeXML.child("file")[0].toString();
                     thumbId = UtilXmlInfo.getPropIdFromFileName(fxFile);
                     theme = ThemeManager.instance.getTheme(UtilXmlInfo.getThemeIdFromFileName(fxFile));
                  }
                  fxThumb = theme.getEffectThumbById(fxId);
                  tempArray.push(fxThumb.id,fxThumb);
                  break;
            }
            i++;
         }
         return tempArray;
      }
      
      private function doLoadXMLBytesComplete(param1:IDataInput) : void
      {
         var _loc2_:ZipFile = new ZipFile(param1);
         this.addEventListener(CoreEvent.DESERIALIZE_THEME_COMPLETE,this.dispatchThemeLoader);
         this.deSerialize(new XML(_loc2_.getInput(_loc2_.getEntry("theme.xml"))));
      }
      
      private function dispatchThemeLoader(param1:CoreEvent) : void
      {
         this._isThemeZipLoaded = true;
         this._eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this));
      }
      
      private function doLoadThumbBytesComplete(param1:IDataInput) : void
      {
         var _loc2_:ZipFile = this._themeZip = new ZipFile(param1);
         this.addEventListener(CoreEvent.DESERIALIZE_THEME_COMPLETE,this.assignThumbImagedata);
         this.deSerialize(new XML(_loc2_.getInput(_loc2_.getEntry("theme.xml"))));
      }
      
      private function assignThumbImagedata(param1:CoreEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Thumb = null;
         var _loc5_:ZipEntry = null;
         var _loc6_:UtilCrypto = null;
         var _loc8_:ByteArray = null;
         var _loc9_:UtilHashArray = null;
         var _loc10_:Number = NaN;
         var _loc2_:ZipFile = this._themeZip;
         var _loc7_:Boolean = this.id != "ugc" ? true : false;
         _loc3_ = 0;
         while(_loc3_ < this._charThumbs.length)
         {
            _loc4_ = this._charThumbs.getValueByIndex(_loc3_) as Thumb;
            if((_loc5_ = _loc2_.getEntry(_loc4_.getFileName())) != null)
            {
               _loc4_.imageData = _loc2_.getInput(_loc5_);
               if(_loc7_)
               {
                  (_loc6_ = new UtilCrypto()).decrypt(_loc4_.imageData as ByteArray);
               }
            }
            _loc3_++;
         }
         if(this.id != "common")
         {
            if((_loc4_ = this._defaultBgThumb as Thumb) != null)
            {
               if(BackgroundThumb(_loc4_).isComposite)
               {
                  _loc9_ = new UtilHashArray();
                  _loc9_ = this.doOutputThumbs(BackgroundThumb(_loc4_).xml);
                  _loc10_ = 0;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_.length)
                  {
                     if((_loc4_ = _loc9_.getValueByIndex(_loc10_)) is BackgroundThumb)
                     {
                        if((_loc5_ = _loc2_.getEntry("bg/" + _loc4_.id)) != null)
                        {
                           _loc8_ = _loc2_.getInput(_loc5_);
                           if(_loc7_)
                           {
                              (_loc6_ = new UtilCrypto()).decrypt(_loc8_);
                           }
                           _loc4_.thumbImageData = _loc8_;
                           _loc4_.imageData = _loc8_;
                        }
                     }
                     else if(_loc4_ is PropThumb)
                     {
                        if((_loc5_ = _loc2_.getEntry("prop/" + _loc4_.id)) != null)
                        {
                           _loc8_ = _loc2_.getInput(_loc5_);
                           if(_loc7_)
                           {
                              (_loc6_ = new UtilCrypto()).decrypt(_loc8_);
                           }
                           _loc4_.thumbImageData = _loc8_;
                           _loc4_.imageData = _loc8_;
                        }
                     }
                     _loc10_++;
                  }
               }
               else if((_loc5_ = _loc2_.getEntry(_loc4_.getFileName())) != null)
               {
                  _loc8_ = _loc2_.getInput(_loc5_);
                  if(_loc7_)
                  {
                     (_loc6_ = new UtilCrypto()).decrypt(_loc8_);
                  }
                  _loc4_.thumbImageData = _loc8_;
                  _loc4_.imageData = _loc8_;
               }
            }
         }
         if((_loc4_ = this._defaultPropThumb as Thumb) != null)
         {
            if(_loc5_ != null)
            {
               _loc4_.imageData = _loc2_.getInput(_loc5_);
               if(_loc7_)
               {
                  (_loc6_ = new UtilCrypto()).decrypt(_loc4_.imageData as ByteArray);
               }
            }
         }
         _loc3_ = 0;
         while(_loc3_ < this._effectThumbs.length)
         {
            if((_loc4_ = this._effectThumbs.getValueByIndex(_loc3_) as Thumb).getFileName() != null)
            {
               if((_loc5_ = _loc2_.getEntry(_loc4_.getFileName())) != null)
               {
                  _loc4_.imageData = _loc2_.getInput(_loc5_);
                  if(_loc7_)
                  {
                     (_loc6_ = new UtilCrypto()).decrypt(_loc4_.imageData as ByteArray);
                  }
               }
            }
            _loc3_++;
         }
         this._eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this));
      }
      
      private function loadXML() : void
      {
         var _loc1_:URLRequest = UtilNetwork.getGetThemeRequest(this.id,!Console.getConsole().isThemeCcRelated(this.id));
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc2_.addEventListener(Event.COMPLETE,this.doLoadXMLComplete);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.doLoadThumbIOError);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doLoadThumbSecurityError);
         _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc2_.load(_loc1_);
      }
      
      public function loadBg() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingBg)
         {
            if(this.isBgZipLoaded())
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this));
            }
            this._isLoadingBg = true;
            Console.getConsole().requestLoadStatus(true,true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.id,null,ServerConstants.PARAM_BG);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.onLoadBgComplete);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadBgTimeOut);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadBgSecurityError);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadBgIOError);
            _loc2_.load(_loc1_);
         }
      }
      
      private function onLoadBgSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadBgSecurityError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingBg = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading backgrounds",param1.type);
      }
      
      private function onLoadBgIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadBgIOError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingBg = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading backgrounds",param1.type);
      }
      
      private function onLoadBgTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadBgTimeOut);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingBg = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Operation timeout");
      }
      
      private function onLoadBgComplete(param1:Event) : void
      {
         var bgThumb:BackgroundThumb = null;
         var fileBytes:ByteArray = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.onLoadBgComplete);
         this._isLoadingBg = false;
         this._isBgZipLoaded = true;
         Console.getConsole().requestLoadStatus(false,true);
         var stream:URLStream = URLStream(event.target);
         var bytes:ByteArray = new ByteArray();
         stream.readBytes(bytes,0,stream.bytesAvailable);
         var zip:ZipFile = new ZipFile(bytes);
         var decryptEngine:UtilCrypto = new UtilCrypto();
         var i:int = 0;
         while(i < this._backgroundThumbs.length)
         {
            bgThumb = this._backgroundThumbs.getValueByIndex(i) as BackgroundThumb;
            try
            {
               fileBytes = zip.getInput(zip.getEntry(bgThumb.thumbId));
               if(this.id != "ugc" && !bgThumb.isComposite)
               {
                  decryptEngine.decrypt(fileBytes);
               }
               bgThumb.thumbImageData = fileBytes;
               bgThumb.imageData = fileBytes;
            }
            catch(e:Error)
            {
            }
            i++;
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this));
      }
      
      public function loadProp() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingProp)
         {
            if(this.isPropZipLoaded())
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_PROP_COMPLETE,this));
            }
            this._isLoadingProp = true;
            Console.getConsole().requestLoadStatus(true,true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.id,null,ServerConstants.PARAM_PROP);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.onLoadPropComplete);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadPropTimeOut);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadPropSecurityError);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadPropIOError);
            _loc2_.load(_loc1_);
         }
      }
      
      private function onLoadPropSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadPropSecurityError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingProp = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading props",param1.type);
      }
      
      private function onLoadPropIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadPropIOError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingProp = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading props",param1.type);
      }
      
      private function onLoadPropTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadPropTimeOut);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingProp = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Operation timeout");
      }
      
      private function onLoadPropComplete(param1:Event) : void
      {
         var propThumb:PropThumb = null;
         var fileBytes:ByteArray = null;
         var zipEntry:ZipEntry = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.onLoadPropComplete);
         this._isLoadingProp = false;
         this._isPropZipLoaded = true;
         Console.getConsole().requestLoadStatus(false,true);
         var stream:URLStream = URLStream(event.target);
         var bytes:ByteArray = new ByteArray();
         stream.readBytes(bytes,0,stream.bytesAvailable);
         var zip:ZipFile = new ZipFile(bytes);
         var decryptEngine:UtilCrypto = new UtilCrypto();
         var i:int = 0;
         while(i < this._propThumbs.length)
         {
            propThumb = this._propThumbs.getValueByIndex(i) as PropThumb;
            try
            {
               if(propThumb.states.length > 0)
               {
                  zipEntry = zip.getEntry(propThumb.getFileName());
                  fileBytes = zip.getInput(zipEntry);
               }
               else
               {
                  fileBytes = zip.getInput(zip.getEntry(propThumb.id));
               }
               if(this.id != "ugc")
               {
                  decryptEngine.decrypt(fileBytes);
               }
               propThumb.imageData = fileBytes;
            }
            catch(e:Error)
            {
            }
            i++;
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_PROP_COMPLETE,this));
      }
      
      public function loadChar() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingChar)
         {
            if(this.isCharZipLoaded())
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_CHAR_COMPLETE,this));
            }
            this._isLoadingChar = true;
            Console.getConsole().requestLoadStatus(true,true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.id,null,ServerConstants.PARAM_CHAR);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.onLoadCharComplete);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadCharTimeOut);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadCharSecurityError);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadCharIOError);
            _loc2_.load(_loc1_);
         }
      }
      
      private function onLoadCharSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCharSecurityError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingChar = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading chars",param1.type);
      }
      
      private function onLoadCharIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCharIOError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingChar = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading chars",param1.type);
      }
      
      private function onLoadCharTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCharTimeOut);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingChar = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Operation timeout");
      }
      
      private function onLoadCharComplete(param1:Event) : void
      {
         var charThumb:CharThumb = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.onLoadCharComplete);
         this._isLoadingChar = false;
         this._isCharZipLoaded = true;
         Console.getConsole().requestLoadStatus(false,true);
         var stream:URLStream = URLStream(event.target);
         var zip:ZipFile = new ZipFile(stream);
         var i:int = 0;
         while(i < this._charThumbs.length)
         {
            charThumb = this._charThumbs.getValueByIndex(i) as CharThumb;
            try
            {
               charThumb.imageData = zip.getInput(zip.getEntry(charThumb.id));
            }
            catch(e:Error)
            {
            }
            i++;
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_CHAR_COMPLETE,this));
      }
      
      public function isThumbExist(param1:Thumb) : Boolean
      {
         if(param1 is CharThumb && this.getCharThumbById(param1.id))
         {
            return true;
         }
         if(param1 is BackgroundThumb && (this.getBackgroundThumbById(param1.id) || this.isSimpleBackgroundExistInBackgroundThumbs(param1.id)))
         {
            return true;
         }
         if(param1 is SoundThumb && this.getSoundThumbById(param1.id))
         {
            return true;
         }
         if(param1 is BubbleThumb && this.getBubbleThumbById(param1.id))
         {
            return true;
         }
         if(param1 is PropThumb && this.getPropThumbById(param1.id))
         {
            return true;
         }
         if(param1 is EffectThumb && this.getEffectThumbById(param1.id))
         {
            return true;
         }
         return false;
      }
      
      private function isSimpleBackgroundExistInBackgroundThumbs(param1:String) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._backgroundThumbs.length)
         {
            _loc3_ = UtilXmlInfo.getPropIdFromFileName(BackgroundThumb(this._backgroundThumbs.getValueByIndex(_loc2_)).getFileName());
            if(_loc3_ == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getCharThumbById(param1:String) : CharThumb
      {
         return this._charThumbs.getValueByKey(param1) as CharThumb;
      }
      
      public function getBackgroundThumbById(param1:String) : BackgroundThumb
      {
         return this._backgroundThumbs.getValueByKey(param1) as BackgroundThumb;
      }
      
      public function getBubbleThumbById(param1:String) : BubbleThumb
      {
         return this._bubbleThumbs.getValueByKey(param1) as BubbleThumb;
      }
      
      public function getSoundThumbById(param1:String) : SoundThumb
      {
         return this._soundThumbs.getValueByKey(param1) as SoundThumb;
      }
      
      public function getPropThumbById(param1:String) : IThumb
      {
         return this._propThumbs.getValueByKey(param1) as IThumb;
      }
      
      public function getEffectThumbById(param1:String) : EffectThumb
      {
         return EffectThumb(this._effectThumbs.getValueByKey(param1));
      }
      
      public function getTemplateThumbById(param1:String) : TemplateThumb
      {
         return this._templateThumbs.getValueByKey(param1) as TemplateThumb;
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
      
      public function mergeTheme(param1:Theme) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = 0;
            _loc2_ = 0;
            while(_loc2_ < param1.charThumbs.length)
            {
               param1.getCharThumbById(param1.charThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getCharThumbById(param1.charThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.backgroundThumbs.length)
            {
               param1.getBackgroundThumbById(param1.backgroundThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getBackgroundThumbById(param1.backgroundThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.bubbleThumbs.length)
            {
               param1.getBubbleThumbById(param1.bubbleThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getBubbleThumbById(param1.bubbleThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.effectThumbs.length)
            {
               param1.getEffectThumbById(param1.effectThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getEffectThumbById(param1.effectThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.propThumbs.length)
            {
               param1.getPropThumbById(param1.propThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getPropThumbById(param1.propThumbs.getKey(_loc2_)) as Thumb);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.soundThumbs.length)
            {
               param1.getSoundThumbById(param1.soundThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getSoundThumbById(param1.soundThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.templateThumbs.length)
            {
               param1.getTemplateThumbById(param1.templateThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getTemplateThumbById(param1.templateThumbs.getKey(_loc2_)));
               _loc2_++;
            }
         }
      }
      
      public function getProducts(param1:String = null) : Array
      {
         var _loc2_:Array = new Array();
         if(param1)
         {
            switch(param1)
            {
               case ProductConstants.PRODUCT_TYPE_PROP:
                  _loc2_ = _loc2_.concat(this.propThumbs.getArray());
                  break;
               case ProductConstants.PRODUCT_TYPE_BACKGROUND:
                  _loc2_ = _loc2_.concat(this.backgroundThumbs.getArray());
                  break;
               case ProductConstants.PRODUCT_TYPE_CHARACTER:
                  _loc2_ = _loc2_.concat(this.charThumbs.getArray());
                  break;
               case ProductConstants.PRODUCT_TYPE_EFFECT:
                  _loc2_ = _loc2_.concat(this.effectThumbs.getArray());
                  break;
               case ProductConstants.PRODUCT_TYPE_BUBBLE:
                  _loc2_ = _loc2_.concat(this.bubbleThumbs.getArray());
                  break;
               case ProductConstants.PRODUCT_TYPE_SOUND:
                  _loc2_ = _loc2_.concat(this.soundThumbs.getArray());
            }
         }
         else
         {
            _loc2_ = _loc2_.concat(this.propThumbs.getArray());
            _loc2_ = _loc2_.concat(this.backgroundThumbs.getArray());
         }
         return _loc2_;
      }
   }
}
