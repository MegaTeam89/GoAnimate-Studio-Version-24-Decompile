package anifire.core
{
   import anifire.component.CcActionLoader;
   import anifire.constant.RaceConstants;
   import anifire.event.CoreEvent;
   import anifire.interfaces.IBehavior;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import anifire.util.UtilURLStream;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Behavior extends EventDispatcher implements IBehavior
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Behavior");
       
      
      private var _thumb:Thumb;
      
      private var _id:String;
      
      private var _name:String;
      
      private var _imageData:Object;
      
      private var _totalFrame:int;
      
      private var _aid:String;
      
      private var _isEnable:Boolean;
      
      private var _behaviorZip:ByteArray;
      
      private var _numSwfs:int = 0;
      
      private var _withSpeech:Boolean = false;
      
      public function Behavior(param1:Thumb, param2:String, param3:String, param4:int, param5:String, param6:String)
      {
         super();
         this.thumb = param1;
         this.id = param2;
         this.name = param3;
         this.totalFrame = param4;
         if(param5 == "N")
         {
            this.isEnable = false;
         }
         else
         {
            this.isEnable = true;
         }
         this.aid = param6;
         if(Console.getConsole().excludedIds.containsKey(this.aid))
         {
            this.isEnable = false;
         }
      }
      
      public static function getCharIdFromBehaviourXML(param1:XML) : String
      {
         return UtilXmlInfo.getCharIdFromFileName(param1.toString());
      }
      
      public static function getThemeIdFromBehaviourXML(param1:XML) : String
      {
         return UtilXmlInfo.getThemeIdFromFileName(param1.toString());
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray, param4:Boolean) : UtilHashArray
      {
         var _loc9_:String = null;
         var _loc12_:RegExp = null;
         var _loc13_:ByteArray = null;
         var _loc14_:ThemeTree = null;
         var _loc15_:UtilCrypto = null;
         var _loc5_:UtilHashArray = new UtilHashArray();
         var _loc6_:String = UtilXmlInfo.getZipFileNameOfBehaviour(param1.toString(),param4);
         var _loc7_:String = UtilXmlInfo.getThemeIdFromFileName(_loc6_);
         var _loc8_:String = UtilXmlInfo.getThumbIdFromFileName(_loc6_);
         if(param4)
         {
            _loc9_ = UtilXmlInfo.getCharIdFromFileName(_loc6_);
         }
         else
         {
            _loc9_ = UtilXmlInfo.getPropIdFromFileName(_loc6_);
         }
         var _loc10_:ZipEntry;
         if(!(_loc10_ = param2.getEntry(_loc6_)))
         {
            _loc12_ = /zip/gi;
            _loc10_ = param2.getEntry(_loc6_.replace(_loc12_,"xml"));
         }
         var _loc11_:Boolean = true;
         if(_loc10_ == null)
         {
            _loc11_ = false;
         }
         else if(param3.containsKey(_loc7_) && (param3.getValueByKey(_loc7_) as ThemeTree).isCharBehaviourExist(_loc9_,_loc8_,param4))
         {
            _loc11_ = false;
         }
         if(_loc11_)
         {
            _loc13_ = param2.getInput(_loc10_);
            if(_loc7_ != "ugc")
            {
               (_loc15_ = new UtilCrypto()).decrypt(_loc13_);
            }
            (_loc14_ = new ThemeTree(_loc7_)).addCharBehaviour(_loc9_,_loc8_,_loc13_,param4);
            _loc5_.push(_loc7_,_loc14_);
         }
         return _loc5_;
      }
      
      public function get withSpeech() : Boolean
      {
         return this._withSpeech;
      }
      
      public function set withSpeech(param1:Boolean) : void
      {
         this._withSpeech = param1;
      }
      
      public function get thumb() : Thumb
      {
         return this._thumb;
      }
      
      public function set thumb(param1:Thumb) : void
      {
         this._thumb = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get imageData() : Object
      {
         return this._imageData;
      }
      
      public function get isEnable() : Boolean
      {
         return this._isEnable;
      }
      
      public function set isEnable(param1:Boolean) : void
      {
         this._isEnable = param1;
      }
      
      public function get behaviorZip() : ByteArray
      {
         return this._behaviorZip;
      }
      
      public function set behaviorZip(param1:ByteArray) : void
      {
         this._behaviorZip = param1;
      }
      
      public function set imageData(param1:Object) : void
      {
         this._imageData = param1;
      }
      
      public function get totalFrame() : int
      {
         return this._totalFrame;
      }
      
      public function set totalFrame(param1:int) : void
      {
         this._totalFrame = param1;
      }
      
      public function get aid() : String
      {
         return this._aid;
      }
      
      public function set aid(param1:String) : void
      {
         this._aid = param1;
      }
      
      public function isTalkRelated() : Boolean
      {
         if(this.id != null)
         {
            return this.id.indexOf("talk") > -1;
         }
         return false;
      }
      
      public function getKey() : String
      {
         return this.thumb.getKey() + "." + this.id;
      }
      
      public function loadImageData(param1:String = "char", param2:Boolean = false, param3:String = "") : void
      {
         this.withSpeech = param2;
         Console.getConsole().requestLoadStatus(true);
         var _loc4_:URLRequest = UtilNetwork.getGetThemeAssetRequest(this.thumb.theme.id,this.thumb.id,param1,this.id,-1,param3);
         var _loc5_:UtilURLStream;
         (_loc5_ = new UtilURLStream()).addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         _loc5_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
         _loc5_.load(_loc4_);
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         Console.getConsole().requestLoadStatus(false);
      }
      
      public function loadImageDataByXml(param1:XML, param2:int = 1, param3:Boolean = false) : void
      {
         var _loc4_:CcActionLoader = null;
         if(param1)
         {
            Console.getConsole().requestLoadStatus(true);
            (_loc4_ = new CcActionLoader()).addEventListener(Event.COMPLETE,this.onCcActionLoaded);
            _loc4_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onCcActionFailed);
            _loc4_.loadCcComponents(param1,0,0,null,param2,false,this.id,this.id,param3);
         }
      }
      
      private function onCcActionFailed(param1:IOErrorEvent) : void
      {
         Console.getConsole().requestLoadStatus(false);
      }
      
      private function onCcActionLoaded(param1:Event) : void
      {
         var _loc2_:CcActionLoader = CcActionLoader(param1.target);
         _loc2_.removeEventListener(Event.COMPLETE,this.onCcActionLoaded);
         if(this.imageData == null)
         {
            this.imageData = new Object();
         }
         this.imageData["xml"] = _loc2_.imageData["xml"];
         this.imageData["imageData"] = _loc2_.imageData["imageData"];
         Console.getConsole().requestLoadStatus(false);
         this.thumb.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_STATE_COMPLETE,this));
      }
      
      public function loadImageDataComplete(param1:Event) : void
      {
         var _loc2_:UtilCrypto = null;
         var _loc5_:Boolean = false;
         var _loc6_:ZipFile = null;
         var _loc7_:XML = null;
         var _loc3_:URLStream = URLStream(param1.target);
         Console.getConsole().requestLoadStatus(false);
         var _loc4_:ByteArray = new ByteArray();
         _loc3_.readBytes(_loc4_,0,_loc3_.bytesAvailable);
         if(this.thumb.theme.id != "ugc")
         {
            _loc2_ = new UtilCrypto();
            _loc2_.decrypt(_loc4_);
            this.imageData = new Object();
            _loc5_ = false;
            if(this.thumb is CharThumb)
            {
               switch(this.thumb.raceCode)
               {
                  case RaceConstants.SKINNED_SWF:
                     this.imageData["figure"] = _loc4_;
                     break;
                  default:
                     this.imageData = _loc4_;
               }
               if(CharThumb(this.thumb).getLibraryNum() != 0)
               {
                  this.loadImageDataByXml(CharThumb(this.thumb).xml,3);
                  _loc5_ = true;
               }
            }
            else if(this.thumb is PropThumb)
            {
               switch(this.thumb.raceCode)
               {
                  case RaceConstants.SKINNED_SWF:
                     this.imageData["figure"] = _loc4_;
                     break;
                  default:
                     this.imageData = _loc4_;
               }
               if(PropThumb(this.thumb).raceCode == RaceConstants.SKINNED_SWF)
               {
                  this.loadImageDataByXml(PropThumb(this.thumb).xml,3);
                  _loc5_ = true;
               }
            }
            else
            {
               this.imageData = _loc4_;
            }
            if(!_loc5_)
            {
               this.thumb.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_STATE_COMPLETE,this));
            }
         }
         else if(this.id.indexOf("zip") >= 0)
         {
            _loc6_ = new ZipFile(_loc4_);
            this.imageData = UtilPlain.convertZipAsImagedataObject(_loc6_);
            if(this.isImageDataIncludedLibraries() || this.isThumbLibrariesReady())
            {
               this.thumb.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_STATE_COMPLETE,this));
            }
         }
         else
         {
            _loc7_ = XML(_loc4_);
            this.loadImageDataByXml(_loc7_);
         }
      }
      
      private function isThumbLibrariesReady() : Boolean
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:XML = null;
         var _loc5_:* = null;
         var _loc1_:Boolean = true;
         if(this.thumb is CharThumb)
         {
            if(this.imageData["xml"] != null)
            {
               _loc2_ = this.imageData["xml"];
            }
            else
            {
               _loc2_ = CharThumb(this.thumb).xml;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.library.length())
            {
               _loc5_ = (_loc4_ = _loc2_.library[_loc3_]).@theme_id + "." + _loc4_.@type + "." + _loc4_.@component_id + ".swf";
               if(CharThumb(this.thumb).getLibraryById(_loc5_) == null)
               {
                  _loc1_ = false;
                  break;
               }
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      private function isImageDataIncludedLibraries() : Boolean
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:UtilHashArray = null;
         var _loc5_:XML = null;
         var _loc6_:* = null;
         var _loc1_:Boolean = true;
         if(this.thumb is CharThumb)
         {
            if(!(this.imageData is ByteArray) && this.imageData["xml"] != null)
            {
               _loc2_ = this.imageData["xml"];
               _loc4_ = this.imageData["imageData"] as UtilHashArray;
               _loc3_ = 0;
               while(_loc3_ < _loc2_.library.length())
               {
                  _loc6_ = (_loc5_ = _loc2_.library[_loc3_]).@theme_id + "." + _loc5_.@type + "." + _loc5_.@component_id + ".swf";
                  if(_loc4_.getValueByKey(_loc6_) == null)
                  {
                     _loc1_ = false;
                     break;
                  }
                  _loc3_++;
               }
            }
         }
         return _loc1_;
      }
   }
}
