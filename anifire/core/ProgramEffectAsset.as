package anifire.core
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.LicenseConstants;
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.effect.ZoomEffect;
   import anifire.errors.SerializeError;
   import anifire.event.EffectEvt;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IResizable;
   import anifire.managers.ThemeManager;
   import anifire.util.Util;
   import anifire.util.UtilMath;
   import anifire.util.UtilUnitConvert;
   
   public class ProgramEffectAsset extends EffectAsset implements IMovable, IResizable
   {
       
      
      private var _needControl:Boolean = false;
      
      private var ubound_y:Number;
      
      private var lbound_y:Number;
      
      private var _guide_style:int = 0;
      
      public function ProgramEffectAsset(param1:String = "")
      {
         super(param1);
         this.ubound_y = AnimeConstants.SCREEN_Y;
         this.lbound_y = AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT;
         if(LicenseConstants.isWideScreen())
         {
            this.ubound_y = 35;
            this.lbound_y = 190 + 177;
         }
      }
      
      public function get guide_style() : int
      {
         return this._guide_style;
      }
      
      public function set guide_style(param1:int) : void
      {
         if(this._guide_style != param1)
         {
            this._guide_style = param1;
            if(motionShadow)
            {
               ProgramEffectAsset(motionShadow).guide_style = param1;
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.CAMERA_GUIDE_CHANGED));
         }
      }
      
      public function get needControl() : Boolean
      {
         return this._needControl;
      }
      
      public function set needControl(param1:Boolean) : void
      {
         this._needControl = param1;
      }
      
      override public function get minWidth() : Number
      {
         return 32;
      }
      
      override public function get minHeight() : Number
      {
         return 20;
      }
      
      override public function get maxWidth() : Number
      {
         return AnimeConstants.SCREEN_WIDTH;
      }
      
      override public function get maxHeight() : Number
      {
         return AnimeConstants.SCREEN_HEIGHT;
      }
      
      override public function set x(param1:Number) : void
      {
         if(param1 != this.x)
         {
            param1 = UtilMath.boundaryCheck(param1,AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH - this.width);
            super.x = param1;
            if(this.motionData)
            {
               this.motionData.startPoint.x = this.x;
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      override public function set y(param1:Number) : void
      {
         if(param1 != this.y)
         {
            if(LicenseConstants.isWideScreen())
            {
               param1 = UtilMath.boundaryCheck(param1,AnimeConstants.WIDE_SCREEN_Y,AnimeConstants.WIDE_SCREEN_Y + AnimeConstants.WIDE_SCREEN_HEIGHT - this.height);
            }
            else
            {
               param1 = UtilMath.boundaryCheck(param1,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT - this.height);
            }
            super.y = param1;
            if(this.motionData)
            {
               this.motionData.startPoint.y = this.y;
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      override public function move(param1:Number, param2:Number) : void
      {
         if(param1 != this.x || param2 != this.y)
         {
            param1 = UtilMath.boundaryCheck(param1,AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH - this.width);
            if(LicenseConstants.isWideScreen())
            {
               param2 = UtilMath.boundaryCheck(param2,AnimeConstants.WIDE_SCREEN_Y,AnimeConstants.WIDE_SCREEN_Y + AnimeConstants.WIDE_SCREEN_HEIGHT - this.height);
            }
            else
            {
               param2 = UtilMath.boundaryCheck(param2,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT - this.height);
            }
            super.move(param1,param2);
            if(this.motionData)
            {
               this.motionData.startPoint.x = this.x;
               this.motionData.startPoint.y = this.y;
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE,this));
         }
      }
      
      override public function convertToXml() : XML
      {
         var index:uint = 0;
         var xml:XML = new XML("<" + XML_NODE_NAME + "/>");
         try
         {
            index = this.scene.getOverallOrdering(this);
            xml.@id = id;
            xml.@themecode = this.thumb.theme.id;
            xml.@index = index;
            xml.appendChild(this.effect.serialize());
            xml.x = this.serializeMotion("x",motionShadow);
            xml.y = this.serializeMotion("y",motionShadow);
            xml.width = this.serializeMotion("width",motionShadow);
            xml.height = this.serializeMotion("height",motionShadow);
            xml.speech = !!fromSpeech ? "1" : "0";
            if(this.sttime > -1 && this.edtime > -1)
            {
               if(UtilUnitConvert.secToFrame(this.sttime) <= this.scene.getLength(-1,false) && UtilUnitConvert.secToFrame(this.edtime) <= this.scene.getLength(-1,false))
               {
                  xml.st = UtilUnitConvert.timeToFrame(this.sttime);
                  xml.et = UtilUnitConvert.timeToFrame(this.edtime) - 1;
                  if(this.effect.type == EffectMgr.TYPE_ZOOM)
                  {
                     xml.st.@dur = UtilUnitConvert.secToFrame(this.stzoom,false,true);
                     xml.et.@dur = UtilUnitConvert.secToFrame(this.edzoom,false,true);
                  }
               }
            }
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize program effect asset: " + this.id);
         }
         return xml;
      }
      
      override public function serialize() : String
      {
         return this.convertToXml().toXMLString();
      }
      
      public function serializeMotion(param1:String, param2:EffectAsset) : Array
      {
         var tempArray:Array = null;
         var oRatio:Number = NaN;
         var oheight:Number = NaN;
         var oy:Number = NaN;
         var soheight:Number = NaN;
         var soy:Number = NaN;
         var property:String = param1;
         var shadow:EffectAsset = param2;
         try
         {
            tempArray = new Array();
            oRatio = AnimeConstants.SCREEN_WIDTH / AnimeConstants.SCREEN_HEIGHT;
            oheight = this.width / oRatio;
            oy = this.y - (oheight - this.height) / 2;
            switch(property)
            {
               case "x":
                  tempArray.push(Util.roundNum(this.x));
                  break;
               case "y":
                  tempArray.push(Util.roundNum(oy));
                  break;
               case "width":
                  tempArray.push(Util.roundNum(this.width));
                  break;
               case "height":
                  tempArray.push(Util.roundNum(oheight));
            }
            if(shadow != null)
            {
               soheight = shadow.width / oRatio;
               soy = shadow.y - (soheight - shadow.height) / 2;
               switch(property)
               {
                  case "x":
                     tempArray.push(Util.roundNum(shadow.x));
                     break;
                  case "y":
                     tempArray.push(Util.roundNum(soy));
                     break;
                  case "width":
                     tempArray.push(Util.roundNum(shadow.width));
                     break;
                  case "height":
                     tempArray.push(Util.roundNum(soheight));
               }
            }
         }
         catch(e:Error)
         {
            throw new SerializeError("Failed to serialize program effect motion " + this.id,tempArray.toString(),e);
         }
         return tempArray;
      }
      
      override public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         this._myEffectXML = param1.child(EffectMgr.XML_NODE_TAG)[0];
         var _loc5_:String = EffectAsset.getThemeIdFromAssetXml(param1);
         var _loc6_:EffectThumb = ThemeManager.instance.getTheme(_loc5_).getEffectThumbById(EffectMgr.getId(this._myEffectXML));
         this.scene = param2;
         if(param3)
         {
            this.id = param1.@id;
         }
         this._xs = String(param1.x).split(",");
         this._widths = String(param1.width).split(",");
         var _loc7_:Array = new Array();
         var _loc8_:Array = new Array();
         _loc7_ = String(param1.y).split(",");
         _loc8_ = String(param1.height).split(",");
         if(LicenseConstants.isWideScreen())
         {
            this._ys = new Array();
            this._heights = new Array();
            _loc9_ = 0;
            while(_loc9_ < this._widths.length)
            {
               this._heights[_loc9_] = Number(this._widths[_loc9_]) / LicenseConstants.getScreenRatio();
               _loc10_ = Number(_loc8_[_loc9_]) - Number(this._heights[_loc9_]);
               this._ys[_loc9_] = Number(_loc7_[_loc9_]) + _loc10_ / 2;
               _loc9_++;
            }
         }
         else
         {
            this._ys = _loc7_.concat();
            this._heights = _loc8_.concat();
         }
         this.fromSpeech = String(param1.speech) == "1" ? true : false;
         if(param1.child("st").length() > 0 && param1.child("st").length() > 0)
         {
            this.sttime = UtilUnitConvert.frameToTime(param1.st);
            this.edtime = UtilUnitConvert.frameToTime(param1.et,false);
            if(_loc6_.getExactType() == "zoom" && param1.st.@dur > -1 && param1.et.@dur > -1)
            {
               this.stzoom = UtilUnitConvert.frameToDuration(param1.st.@dur);
               this.edzoom = UtilUnitConvert.frameToDuration(param1.et.@dur);
            }
         }
         else
         {
            this.sttime = -1;
            this.edtime = -1;
         }
         if(param4)
         {
            this.thumb = _loc6_;
         }
         else
         {
            super.thumb = _loc6_;
         }
         this.isLoadded = true;
         this.width = this._widths[0];
         this.height = this._heights[0];
         this.x = this._xs[0];
         this.y = this._ys[0];
         this.setMotionProperties();
      }
      
      public function shouldHasMotion() : Boolean
      {
         if(Math.max(this._xs.length,this._ys.length,this._widths.length,this._heights.length) > 1)
         {
            return true;
         }
         return false;
      }
      
      private function setMotionProperties() : void
      {
         if(this.shouldHasMotion())
         {
            addMotionShadow(this._xs,this._ys,this._widths,this._heights);
         }
      }
      
      override public function cloneNext() : Asset
      {
         var _loc1_:EffectAsset = this.clone() as EffectAsset;
         if(_loc1_.motionShadow)
         {
            _loc1_.width = _loc1_.motionShadow.width;
            _loc1_.height = _loc1_.motionShadow.height;
            _loc1_.x = _loc1_.motionShadow.x;
            _loc1_.y = _loc1_.motionShadow.y;
         }
         return _loc1_;
      }
      
      public function fixZoomDur(param1:Number) : void
      {
         if(Console.getConsole().metaData.mver > 3 && this.effect is ZoomEffect)
         {
            ZoomEffect(this.effect).isPan = false;
            this.sttime = 0;
            this.stzoom = param1;
            this.edtime = param1;
            this.edzoom = 0;
            this.removeSlideMotion();
         }
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:ProgramEffectAsset = new ProgramEffectAsset();
         _loc3_.id = this.id;
         _loc3_.effect = this.effect;
         _loc3_.width = this.width;
         _loc3_.height = this.height;
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.sttime = this.sttime;
         _loc3_.edtime = this.edtime;
         _loc3_.stzoom = this.stzoom;
         _loc3_.edzoom = this.edzoom;
         _loc3_.guide_style = this.guide_style;
         if(_loc3_._myEffectXML == null)
         {
            _loc3_._myEffectXML = this.effect.serialize();
         }
         _loc3_._myEffectXML.@w = this.effect.width;
         _loc3_._myEffectXML.@h = this.effect.height;
         _loc3_.scene = this.scene;
         _loc3_.thumb = this.thumb;
         if(this.motionData)
         {
            _loc3_.motionData = this.motionData.clone();
         }
         if(this.motionShadow)
         {
            _loc3_.motionShadow = this.motionShadow.clone() as EffectAsset;
         }
         return _loc3_;
      }
      
      override protected function loadAssetImageComplete(param1:EffectEvt) : void
      {
         super.loadAssetImageComplete(param1);
         var _loc2_:SuperEffect = param1.getEventCreater() as SuperEffect;
         var _loc3_:EffectAsset = this.scene.getEffectAssetById(this.id,-1);
         if(_loc3_ != null && _fromTray && !fromSpeech)
         {
            this.x = _loc3_.x;
            this.y = _loc3_.y;
            this.width = _loc3_.width;
            this.height = _loc3_.height;
            if(_loc3_.motionShadow != null && !isMotionShadow())
            {
               this.x = _loc3_.motionShadow.x;
               this.y = _loc3_.motionShadow.y;
               this.width = _loc3_.motionShadow.width;
               this.height = _loc3_.motionShadow.height;
            }
         }
         updateObjectPosition(this);
      }
   }
}
