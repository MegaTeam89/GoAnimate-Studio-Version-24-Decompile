package anifire.playback
{
   import anifire.component.ProgressMonitor;
   import anifire.component.ThemeLoader;
   import anifire.constant.CcLibConstant;
   import anifire.constant.ServerConstants;
   import anifire.event.LoadMgrEvent;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import br.com.stimuli.loading.BulkLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class PlayerDataStock extends EventDispatcher
   {
       
      
      public var embedCredit:Class;
      
      private var _playerDataArray:Object;
      
      private var _playerDataIsDecryptedArray:Object;
      
      private var _filmXmlArray:Array;
      
      private var _themeXMLs:UtilHashArray;
      
      private var urlRequestArray:Array;
      
      private var bulkLoader:BulkLoader;
      
      private var _licensedSoundInfo:String = "";
      
      private var _themeListXmlArray:Array;
      
      private var _fontListXmlArray:Array;
      
      public function PlayerDataStock()
      {
         this.embedCredit = PlayerDataStock_embedCredit;
         this._filmXmlArray = new Array();
         this._themeListXmlArray = new Array();
         this._fontListXmlArray = new Array();
         super();
         this._playerDataArray = new Object();
         this._playerDataIsDecryptedArray = new Object();
         this._themeXMLs = new UtilHashArray();
      }
      
      public function getFilmXmlArray() : Array
      {
         return this._filmXmlArray;
      }
      
      private function addFilmXML(param1:XML) : void
      {
         this._filmXmlArray.push(param1);
      }
      
      public function getThemeXMLs() : UtilHashArray
      {
         return this._themeXMLs;
      }
      
      private function addPlayerData(param1:String, param2:Object, param3:Boolean = false) : void
      {
         this._playerDataArray[param1] = param2;
         this._playerDataIsDecryptedArray[param1] = param3;
      }
      
      public function initByHashArray(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         var _loc4_:int = 0;
         this.addFilmXML(param1.copy());
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            this.addPlayerData(param3.getKey(_loc4_),param3.getValueByIndex(_loc4_),true);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            this.addThemeXML(XML(param2.getValueByIndex(_loc4_)).copy());
            _loc4_++;
         }
      }
      
      private function addThemeXML(param1:XML) : void
      {
         var _loc3_:XML = null;
         var _loc2_:String = UtilXmlInfo.getThemeIdFromThemeXML(param1);
         if(!this._themeXMLs.containsKey(_loc2_))
         {
            this._themeXMLs.push(_loc2_,param1);
         }
         else
         {
            _loc3_ = UtilXmlInfo.merge2ThemeXml(this._themeXMLs.getValueByKey(_loc2_) as XML,param1,_loc2_,"",false);
            this._themeXMLs.push(_loc2_,_loc3_);
         }
      }
      
      public function initByLoadMovieZip(param1:Array) : void
      {
         var urlRequest:URLRequest = null;
         var urlRequestArray:Array = param1;
         try
         {
            this.urlRequestArray = urlRequestArray;
            this.bulkLoader = new BulkLoader(new Date().toString() + Math.random().toString());
            for each(urlRequest in urlRequestArray)
            {
               this.bulkLoader.add(urlRequest,{"type":BulkLoader.TYPE_BINARY});
            }
            this.bulkLoader.addEventListener(BulkLoader.ERROR,this.onLoadMovieZipCompleted);
            this.bulkLoader.addEventListener(BulkLoader.COMPLETE,this.onLoadMovieZipCompleted);
            this.bulkLoader.addEventListener(BulkLoader.PROGRESS,this.onLoadMovieProgress);
            ProgressMonitor.getInstance().reset();
            ProgressMonitor.getInstance().addProgressEventDispatcher(this.bulkLoader);
            this.bulkLoader.start();
         }
         catch(e:TypeError)
         {
         }
         catch(e:Error)
         {
         }
      }
      
      public function destroy() : void
      {
         if(this.bulkLoader != null)
         {
            this.bulkLoader.removeAll();
         }
      }
      
      private function onLoadMovieProgress(param1:Event) : void
      {
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_PROGRESS,param1));
      }
      
      private function onLoadMovieZipCompleted(param1:Event) : void
      {
         var _loc8_:Event = null;
         var _loc10_:URLRequest = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:ByteArray = null;
         var _loc14_:ByteArray = null;
         var _loc15_:ZipFile = null;
         var _loc16_:int = 0;
         var _loc17_:ZipEntry = null;
         var _loc18_:ByteArray = null;
         var _loc19_:int = 0;
         var _loc20_:ZipEntry = null;
         var _loc21_:ZipFile = null;
         var _loc22_:ByteArray = null;
         var _loc23_:Object = null;
         var _loc24_:XML = null;
         var _loc25_:int = 0;
         var _loc26_:XML = null;
         var _loc27_:XML = null;
         var _loc2_:Boolean = false;
         var _loc3_:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_VIDEO_RECORD_MODE) as String;
         if(_loc3_ == "1")
         {
            if((_loc11_ = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CHAIN_MOVIE_ID)) != null && _loc11_ != "")
            {
               _loc12_ = _loc11_.split(",");
               if(_loc12_[_loc12_.length - 1] == ServerConstants.END_CREDIT_MOVIE_ID)
               {
                  _loc2_ = true;
               }
            }
         }
         var _loc4_:BulkLoader = param1.target as BulkLoader;
         var _loc5_:int = 0;
         var _loc6_:String = "";
         var _loc7_:String = "";
         var _loc9_:int = 1;
         if(param1.type != BulkLoader.COMPLETE)
         {
            _loc6_ += "Error loading file by url. The type of event returned is: " + param1.toString() + ".";
            _loc8_ = new PlayerEvent(PlayerEvent.ERROR_LOADING_MOVIE,"");
            this.dispatchEvent(_loc8_);
            return;
         }
         for each(_loc10_ in this.urlRequestArray)
         {
            _loc5_ = (_loc13_ = _loc4_.getBinary(_loc10_,true)).readByte();
            _loc14_ = new ByteArray();
            _loc13_.readBytes(_loc14_);
            if(_loc5_ != 0)
            {
               _loc6_ += "Downloading file completed with non-zero returnCode: " + _loc5_ + ". " + _loc14_.toString();
               try
               {
                  _loc7_ = (_loc26_ = new XML(_loc14_.toString())).child("code");
               }
               catch(e:Error)
               {
               }
            }
            if(_loc6_ != "")
            {
               _loc8_ = new PlayerEvent(PlayerEvent.ERROR_LOADING_MOVIE,_loc7_);
               this.dispatchEvent(_loc8_);
               return;
            }
            _loc15_ = new ZipFile(_loc14_);
            _loc16_ = 0;
            while(_loc16_ < _loc15_.size)
            {
               if((_loc17_ = _loc15_.entries[_loc16_]).name == PlayerConstant.FILM_XML_FILENAME)
               {
                  if(_loc3_ == "1")
                  {
                     _loc27_ = new XML(_loc15_.getInput(_loc17_).toString());
                     _loc25_ = 0;
                     while(_loc25_ < _loc27_.child("sound").length())
                     {
                        if((_loc24_ = _loc27_.child("sound")[_loc25_]).hasOwnProperty("info"))
                        {
                           this._licensedSoundInfo += _loc24_.info.title + " - Author: " + _loc24_.info.author + "\n";
                        }
                        _loc25_++;
                     }
                  }
                  this.addFilmXML(new XML(_loc15_.getInput(_loc17_).toString()));
                  if(this._licensedSoundInfo != "" && (_loc9_ == this.urlRequestArray.length - 1 && _loc2_ == true || _loc9_ == this.urlRequestArray.length && _loc2_ == false))
                  {
                     this.addCreditScreen();
                  }
               }
               else if(_loc17_.name.indexOf("ugc.char") > -1 && _loc17_.name.substr(_loc17_.name.length - 3,3).toLowerCase() == "xml")
               {
                  _loc23_ = _loc15_.getInput(_loc17_);
                  this.addPlayerData(_loc17_.name,_loc23_);
               }
               else if(_loc17_.name.indexOf("ugc.prop") > -1 && _loc17_.name.substr(_loc17_.name.length - 3,3).toLowerCase() == "xml")
               {
                  _loc23_ = _loc15_.getInput(_loc17_);
                  this.addPlayerData(_loc17_.name,_loc23_);
               }
               else if(_loc17_.name == "themelist.xml")
               {
                  _loc23_ = _loc15_.getInput(_loc17_);
                  this._themeListXmlArray.push(new XML(_loc23_.toString()));
               }
               else if(_loc17_.name == "fontlist.xml")
               {
                  _loc23_ = _loc15_.getInput(_loc17_);
                  this._fontListXmlArray.push(new XML(_loc23_.toString()));
               }
               else if(_loc17_.name.substr(_loc17_.name.length - 3,3).toLowerCase() == "xml")
               {
                  if(_loc17_.name == "ugc.xml")
                  {
                     _loc23_ = _loc15_.getInput(_loc17_);
                     this.addThemeXML(new XML(_loc23_.toString()));
                  }
               }
               else if(_loc17_.name.indexOf(CcLibConstant.NODE_LIBRARY) > -1 && _loc17_.name.substr(_loc17_.name.length - 3,3).toLowerCase() == "zip")
               {
                  _loc18_ = _loc15_.getInput(_loc17_);
                  _loc21_ = new ZipFile(_loc18_);
                  _loc19_ = 0;
                  while(_loc19_ < _loc21_.size)
                  {
                     if((_loc20_ = _loc21_.entries[_loc19_]).name.substr(_loc20_.name.length - 3,3).toLowerCase() == "swf")
                     {
                        _loc22_ = _loc21_.getInput(_loc20_);
                        this.addPlayerData(_loc20_.name,_loc22_);
                     }
                     _loc19_++;
                  }
               }
               else if(_loc17_.name.substr(_loc17_.name.length - 3,3).toLowerCase() == "zip")
               {
                  _loc18_ = _loc15_.getInput(_loc17_);
                  _loc21_ = new ZipFile(_loc18_);
                  this.addPlayerData(_loc17_.name,UtilPlain.convertZipAsImagedataObject(_loc21_));
               }
               else
               {
                  _loc18_ = _loc15_.getInput(_loc17_);
                  this.addPlayerData(_loc17_.name,_loc18_);
               }
               _loc16_++;
            }
            _loc9_++;
         }
         this.loadAllThemeXmls();
      }
      
      private function loadMovieXml() : void
      {
         var _loc1_:URLRequest = new URLRequest("https://s3.amazonaws.com/schoolcloudfront/xml/movie/movie/33/0P0PDv0XN3zE/1269236357.gz.xml");
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.dataFormat = URLLoaderDataFormat.TEXT;
         _loc2_.addEventListener(Event.COMPLETE,this.onLoadMovieXmlComplete);
         _loc2_.load(_loc1_);
      }
      
      private function onLoadMovieXmlComplete(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onLoadMovieXmlComplete);
         if(param1.target is URLLoader)
         {
            this.addFilmXML(new XML(URLLoader(param1.target).data));
         }
         this.loadAllThemeXmls();
      }
      
      private function loadAllThemeXmls() : void
      {
         var _loc1_:UtilLoadMgr = null;
         var _loc2_:ThemeLoader = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:XML = null;
         if(this._themeListXmlArray && this._themeListXmlArray.length > 0)
         {
            _loc1_ = new UtilLoadMgr();
            _loc1_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onAllThemeXmlLoaded);
            _loc3_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < this._themeListXmlArray.length)
            {
               if(this._themeListXmlArray[_loc5_])
               {
                  for each(_loc6_ in this._themeListXmlArray[_loc5_].theme)
                  {
                     _loc4_ = _loc6_.toString();
                     if(_loc6_.toString() != "ugc" && _loc3_.indexOf(_loc4_) == -1)
                     {
                        _loc2_ = ThemeLoader.getThemeLoader(_loc4_);
                        _loc2_.addEventListener(Event.COMPLETE,this.onThemeXmlLoaded);
                        _loc1_.addEventDispatcher(_loc2_,Event.COMPLETE);
                        _loc2_.load(_loc4_);
                        _loc3_.push(_loc4_);
                     }
                  }
               }
               _loc5_++;
            }
            _loc1_.commit();
         }
         else
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_COMPLETE));
         }
      }
      
      private function onThemeXmlLoaded(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onThemeXmlLoaded);
         this.addThemeXML(ThemeLoader(param1.target).xml);
      }
      
      private function onAllThemeXmlLoaded(param1:Event) : void
      {
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_COMPLETE));
      }
      
      private function addCreditScreen() : void
      {
         var _loc1_:XML = new XML(<film copyable="0" duration="1" published="0" pshare="1">
				  <meta>
				    <title>credit screen</title>
				    <tag>credit screen</tag>
				    <hiddenTag/>
				    <desc></desc>
				    <mver>3</mver>
				  </meta>
				  <scene id="SCENE0" adelay="60" lock="Y" index="0">
				    <bg id="BG7" index="0">
				      <file>ugc.credit.png</file>
				    </bg>
				    <bubbleAsset id="BUBBLE8" index="1">
				      <x>234</x>
				      <y>85</y>
				      <bubble x="-119.1" y="32.3" w="418.3" h="25.7" rotate="0" type="BLANK">
				        <body rgb="16777215" alpha="1" linergb="0" tailx="180" taily="110"/>
				        <text rgb="13421772" font="Arial" size="16" align="center" bold="true" italic="false" embed="false">Music licensed under Creative Commons Share Alike:</text>
				        <url/>
				      </bubble>
				    </bubbleAsset>
				  </scene>
				</film>);
         var _loc2_:XML = <bubbleAsset id="BUBBLE9" index="2">
			      <x>233.5</x>
			      <y>123</y>
			      <bubble x="-152.3" y="27.1" w="484.8" h="40" rotate="0" type="BLANK">
			        <body rgb="16777215" alpha="1" linergb="0" tailx="180" taily="110"/>
			        <text rgb="13421772" font="Arial" size="18" align="center" bold="false" italic="false" embed="false"></text>
			        <url/>
			      </bubble>
			    </bubbleAsset>;
         _loc2_.bubble.text = this._licensedSoundInfo;
         var _loc3_:Array = this._licensedSoundInfo.split("\n");
         _loc2_.bubble.@h = 30 * _loc3_.length;
         _loc1_.scene.appendChild(_loc2_);
         var _loc4_:ByteArray = new this.embedCredit();
         this.addPlayerData("ugc.bg.credit.png",_loc4_);
         this.addFilmXML(_loc1_);
      }
      
      private function onInitPlayerDataStockDone(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitPlayerDataStockDone);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.LOAD_MOVIE_COMPLETE));
      }
      
      public function getPlayerData(param1:String) : Object
      {
         return this._playerDataArray[param1] as Object;
      }
      
      public function decryptPlayerData(param1:String) : void
      {
         var _loc2_:UtilCrypto = null;
         if(!this._playerDataIsDecryptedArray[param1])
         {
            _loc2_ = new UtilCrypto();
            _loc2_.decrypt(this._playerDataArray[param1] as ByteArray);
            this._playerDataIsDecryptedArray[param1] = true;
         }
      }
   }
}
