package anifire.core
{
   import anifire.errors.SerializeError;
   import anifire.util.Util;
   import anifire.util.UtilXmlInfo;
   import mx.utils.StringUtil;
   
   public class MetaData
   {
      
      public static const XML_NODE_NAME:String = "meta";
       
      
      private var _movieId:String = null;
      
      private var _title:String = "";
      
      private var _hidden_tags:Array;
      
      private var _ugc_ags:Array;
      
      private var _description:String = "";
      
      private var _originalId:String = "";
      
      private var _lang:String;
      
      private var _mver:Number = 4;
      
      private var _isTagSet:Boolean = false;
      
      public function MetaData()
      {
         this._hidden_tags = new Array();
         this._ugc_ags = new Array();
         this._lang = Util.preferLanguageShortCode();
         super();
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
      }
      
      public function get movieId() : String
      {
         return this._movieId;
      }
      
      public function set movieId(param1:String) : void
      {
         if(this._movieId == null)
         {
            this._movieId = param1;
         }
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get lang() : String
      {
         return this._lang;
      }
      
      public function set lang(param1:String) : void
      {
         this._lang = param1;
      }
      
      public function get originalId() : String
      {
         return this._originalId;
      }
      
      public function set originalId(param1:String) : void
      {
         this._originalId = param1;
      }
      
      public function set mver(param1:Number) : void
      {
         this._mver = param1;
      }
      
      public function get mver() : Number
      {
         return this._mver;
      }
      
      public function addHiddenTag(param1:String) : void
      {
         if(param1 != null && StringUtil.trim(param1).length > 0)
         {
            this._hidden_tags.push(param1);
         }
      }
      
      private function addUgcTag(param1:String) : void
      {
         if(param1 != null && StringUtil.trim(param1).length > 0)
         {
            this._ugc_ags.push(param1);
         }
      }
      
      public function clearHiddenTags() : void
      {
         this._hidden_tags.splice(0,this._hidden_tags.length);
      }
      
      private function clearUgcTags() : void
      {
         this._ugc_ags.splice(0,this._ugc_ags.length);
      }
      
      public function setUgcTagsByString(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         this.clearUgcTags();
         if(!(param1 == null || StringUtil.trim(param1).length == 0))
         {
            _loc2_ = param1.split(",");
            if(_loc2_ != null && _loc2_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  this.addUgcTag(_loc2_[_loc3_]);
                  _loc3_++;
               }
            }
         }
      }
      
      public function setHiddenTagsByString(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         this.clearHiddenTags();
         if(!(param1 == null || StringUtil.trim(param1).length == 0))
         {
            _loc2_ = param1.split(",");
            if(_loc2_ != null && _loc2_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  this.addHiddenTag(_loc2_[_loc3_]);
                  _loc3_++;
               }
            }
         }
      }
      
      public function getUgcTagString() : String
      {
         var _loc2_:int = 0;
         var _loc1_:* = "";
         if(this._ugc_ags.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this._ugc_ags.length)
            {
               if(_loc2_ > 0)
               {
                  _loc1_ += ",";
               }
               _loc1_ += this._ugc_ags[_loc2_];
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function getHiddenTagString() : String
      {
         var _loc2_:int = 0;
         var _loc1_:* = "";
         if(this._hidden_tags.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this._hidden_tags.length)
            {
               if(_loc2_ > 0)
               {
                  _loc1_ += ",";
               }
               _loc1_ += this._hidden_tags[_loc2_];
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function convertToXml() : XML
      {
         var xml:XML = new XML("<" + XML_NODE_NAME + "/>");
         try
         {
            xml.appendChild(new XML("<title>" + UtilXmlInfo.cdata(this.title) + "</title>"));
            xml.appendChild(new XML("<tag>" + UtilXmlInfo.cdata(this.getUgcTagString()) + "</tag>"));
            xml.appendChild(new XML("<hiddenTag>" + UtilXmlInfo.cdata(this.getHiddenTagString()) + "</hiddenTag>"));
            xml.appendChild(new XML("<desc>" + UtilXmlInfo.cdata(this.description) + "</desc>"));
            xml.appendChild(new XML("<mver>" + UtilXmlInfo.cdata(this.mver.toString()) + "</mver>"));
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize meta");
         }
         return xml;
      }
      
      public function serialize() : String
      {
         return this.convertToXml().toXMLString();
      }
      
      public function deSerialize(param1:XML, param2:String, param3:String) : void
      {
         this.title = param1.child("title")[0].toString();
         this.setUgcTagsByString(param1.child("tag")[0].toString());
         if(param1.child("hiddenTag").length() > 0)
         {
            this.setHiddenTagsByString(param1.child("hiddenTag")[0].toString());
         }
         this.description = param1.child("desc")[0].toString();
         this.originalId = param3;
         this.movieId = param2;
         this.mver = Number(param1.child("mver")[0]) >= 0 ? Number(Number(param1.child("mver")[0])) : Number(0);
      }
   }
}
