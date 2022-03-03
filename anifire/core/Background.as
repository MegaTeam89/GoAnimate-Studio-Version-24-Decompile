package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.constant.AnimeConstants;
   import anifire.errors.SerializeError;
   import anifire.event.CoreEvent;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IColorable;
   import anifire.interfaces.IFlippable;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IThumb;
   import anifire.managers.ThemeManager;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilHashSelectedColor;
   import anifire.util.UtilXmlInfo;
   import flash.utils.ByteArray;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Background extends Asset implements IMovable, IColorable, IFlippable
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Background");
      
      public static var XML_NODE_NAME:String = "bg";
       
      
      private var _isFlipped:Boolean = false;
      
      public function Background(param1:String = "")
      {
         super();
         if(param1 == "")
         {
            param1 = "BG" + this.assetCount;
         }
         this.id = param1;
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc7_:ByteArray = null;
         var _loc8_:ThemeTree = null;
         var _loc9_:UtilCrypto = null;
         var _loc3_:UtilHashArray = new UtilHashArray();
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBg(param1["file"].toString());
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc6_:ZipEntry;
         if((_loc6_ = param2.getEntry(_loc4_)) != null)
         {
            _loc7_ = param2.getInput(_loc6_);
            if(_loc5_ != "ugc")
            {
               (_loc9_ = new UtilCrypto()).decrypt(_loc7_);
            }
            (_loc8_ = new ThemeTree(_loc5_)).addBgThumb(UtilXmlInfo.getThumbIdFromFileName(_loc4_),_loc7_);
            _loc3_.push(_loc5_,_loc8_);
         }
         return _loc3_;
      }
      
      override public function toString() : String
      {
         return this.thumb.theme.id + "." + this.thumb.id;
      }
      
      override public function convertToXml() : XML
      {
         var childXml:XML = null;
         var i:int = 0;
         var xml:XML = <bg/>;
         try
         {
            xml.@id = this.id;
            xml.@index = 0;
            if(this._isFlipped)
            {
               xml.@xscale = "-1";
            }
            xml.file = this.thumb.theme.id + "." + this.thumb.id;
            if(defaultColorSetId != "")
            {
               xml.dcsn = defaultColorSetId;
            }
            if(customColor.length > 0)
            {
               i = 0;
               while(i < customColor.length)
               {
                  childXml = <color>{SelectedColor(customColor.getValueByIndex(i)).dstColor}</color>;
                  childXml.@r = customColor.getKey(i);
                  if(SelectedColor(customColor.getValueByIndex(i)).orgColor != uint.MAX_VALUE)
                  {
                     childXml.@oc = "0x" + SelectedColor(customColor.getValueByIndex(i)).orgColor.toString(16);
                  }
                  xml.appendChild(childXml);
                  i++;
               }
            }
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize bg: " + this.id);
         }
         return xml;
      }
      
      override public function serialize() : String
      {
         return this.convertToXml().toXMLString();
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true) : void
      {
         var _loc8_:BackgroundThumb = null;
         var _loc9_:XML = null;
         var _loc10_:int = 0;
         var _loc11_:SelectedColor = null;
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBg(param1.file);
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc6_:String = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
         var _loc7_:Theme;
         if((_loc7_ = ThemeManager.instance.getTheme(_loc5_)) != null)
         {
            if((_loc8_ = _loc7_.getBackgroundThumbById(_loc6_)) != null && _loc8_.imageData != null)
            {
               this.x = AnimeConstants.SCREEN_X;
               this.y = AnimeConstants.SCREEN_Y;
               this.width = AnimeConstants.SCREEN_WIDTH;
               this.height = AnimeConstants.SCREEN_HEIGHT;
               this.scene = param2;
               if(param1.hasOwnProperty("@xscale") && String(param1.@xscale) == "-1")
               {
                  this._isFlipped = true;
                  this.x = AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH;
               }
               if(param3)
               {
                  this.thumb = _loc8_;
               }
               else
               {
                  super.thumb = _loc8_;
               }
               this.isLoadded = true;
               if(param1.dcsn.length() > 0)
               {
                  this.defaultColorSetId = String(param1.dcsn);
                  this.defaultColorSet = Thumb(this.thumb).getColorSetById(this.defaultColorSetId);
               }
               customColor = new UtilHashSelectedColor();
               _loc10_ = 0;
               while(_loc10_ < param1.child("color").length())
               {
                  _loc9_ = param1.child("color")[_loc10_];
                  _loc11_ = new SelectedColor(_loc9_.@r,_loc9_.attribute("oc").length() == 0 ? uint(uint.MAX_VALUE) : uint(_loc9_.@oc),uint(_loc9_));
                  this.addCustomColor(_loc9_.@r,_loc11_);
                  _loc10_++;
               }
               updateColor();
            }
         }
      }
      
      override public function set thumb(param1:IThumb) : void
      {
         super.thumb = param1;
         if(param1.imageData != null)
         {
            this.imageData = param1.imageData;
         }
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:Background = new Background();
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.id = this.id;
         _loc3_.scene = this.scene;
         _loc3_.thumb = this.thumb;
         _loc3_.customColor = this.customColor.clone();
         if(this.isFlipped)
         {
            _loc3_.flipIt();
         }
         return _loc3_;
      }
      
      override protected function loadAssetImage() : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      public function flipIt() : void
      {
         this._isFlipped = !this._isFlipped;
         this.x = !!this._isFlipped ? Number(AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH) : Number(AnimeConstants.SCREEN_X);
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_HFLIPPED,this));
      }
      
      public function get isFlipped() : Boolean
      {
         return this._isFlipped;
      }
   }
}
