package anifire.core
{
   import anifire.constant.AnimeConstants;
   import anifire.errors.SerializeError;
   import anifire.event.EffectEvt;
   import anifire.util.Util;
   import anifire.util.UtilUnitConvert;
   
   public class AnimeEffectAsset extends EffectAsset
   {
       
      
      public function AnimeEffectAsset(param1:String = null)
      {
         super(param1);
      }
      
      override public function get x() : Number
      {
         return AnimeConstants.SCREEN_X;
      }
      
      override public function get y() : Number
      {
         return AnimeConstants.SCREEN_Y;
      }
      
      override public function convertToXml() : XML
      {
         var index:uint = 0;
         var xml:XML = new XML("<" + XML_NODE_NAME + "/>");
         try
         {
            index = this.scene.getOverallOrdering(this);
            xml.@id = id;
            xml.@index = index;
            xml.appendChild(this.effect.serialize());
            xml.x = Util.roundNum(this.x);
            xml.y = Util.roundNum(this.y);
            xml.xscale = 1;
            xml.yscale = 1;
            if(this.sttime > -1 && this.edtime > -1)
            {
               if(UtilUnitConvert.secToFrame(this.sttime) <= this.scene.getLength(-1,false) && UtilUnitConvert.secToFrame(this.edtime) <= this.scene.getLength(-1,false))
               {
                  xml.st = UtilUnitConvert.timeToFrame(this.sttime);
                  xml.et = UtilUnitConvert.timeToFrame(this.edtime) - 1;
               }
            }
            xml.file = this.thumb.theme.id + "." + this.effect.id;
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize anime effect: " + this.id);
         }
         return xml;
      }
      
      override public function serialize() : String
      {
         return this.convertToXml().toXMLString();
      }
      
      override protected function loadAssetImageComplete(param1:EffectEvt) : void
      {
         super.loadAssetImageComplete(param1);
         this.x = AnimeConstants.SCREEN_X;
         this.y = AnimeConstants.SCREEN_Y;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:AnimeEffectAsset = null;
         try
         {
            _loc3_ = new AnimeEffectAsset();
            _loc3_.id = this.id;
            _loc3_.x = this.x;
            _loc3_.y = this.y;
            _loc3_.sttime = this.sttime;
            _loc3_.edtime = this.edtime;
            if(_loc3_._myEffectXML == null)
            {
               _loc3_._myEffectXML = this.effect.serialize();
            }
            _loc3_._myEffectXML.@w = this.effect.width;
            _loc3_._myEffectXML.@h = this.effect.height;
            _loc3_.scene = this.scene;
            _loc3_.thumb = this.thumb;
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
   }
}
