package anifire.effect
{
   import anifire.constant.LicenseConstants;
   import anifire.util.Util;
   import anifire.util.UtilDraw;
   import anifire.util.UtilPlain;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class ZoomEffect extends ProgramEffect
   {
      
      private static var iconBlue:Class = ZoomEffect_iconBlue;
      
      private static var iconPurple:Class = ZoomEffect_iconPurple;
       
      
      private const RGB:Number = 13421772;
      
      private const ALPHA:Number = 0.6;
      
      private const LINESIZE:Number = 5;
      
      private var _isCut:Boolean = false;
      
      private var _isPan:Boolean = false;
      
      private var _mver:Number = 0;
      
      private var _isShadow:Boolean = false;
      
      private var _icon:Sprite;
      
      private var _myThumbnailSymbol:Class;
      
      private var _myThumbnailSymbol_cut:Class;
      
      private var _myThumbnailSymbol_pan:Class;
      
      public function ZoomEffect(param1:String = "", param2:Number = 0)
      {
         this._icon = new Sprite();
         this._myThumbnailSymbol = ZoomEffect__myThumbnailSymbol;
         this._myThumbnailSymbol_cut = ZoomEffect__myThumbnailSymbol_cut;
         this._myThumbnailSymbol_pan = ZoomEffect__myThumbnailSymbol_pan;
         super();
         type = EffectMgr.TYPE_ZOOM;
         this._mver = param2;
         if(param1 == EffectMgr.TYPE_CUT)
         {
            this._isCut = true;
         }
         else if(param1 == EffectMgr.TYPE_PAN)
         {
            this._isPan = true;
         }
         if(this._isCut)
         {
            thumbnailSymbol = this._myThumbnailSymbol_cut;
         }
         else if(this._isPan)
         {
            thumbnailSymbol = this._myThumbnailSymbol_pan;
         }
         else
         {
            thumbnailSymbol = this._myThumbnailSymbol;
         }
         this.redraw();
      }
      
      public function get isShadow() : Boolean
      {
         return this._isShadow;
      }
      
      public function set isShadow(param1:Boolean) : void
      {
         this._isShadow = param1;
      }
      
      public function get isCut() : Boolean
      {
         return this._isCut;
      }
      
      public function get isPan() : Boolean
      {
         return this._isPan;
      }
      
      public function set isPan(param1:Boolean) : void
      {
         this._isPan = param1;
         this._isCut = !param1;
      }
      
      override public function serialize() : XML
      {
         return <effect x="{x}" y="{y}" w="{Util.roundNum(width)}" h="{Util.roundNum(height)}" rotate='0' id="{id}" type="{type}" isCut="{this._isCut.toString()}" isPan="{this._isPan.toString()}">
											 </effect>;
      }
      
      protected function drawIcon() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         UtilPlain.removeAllSon(this._icon);
         if(this._mver > 3 && this.width > 80)
         {
            this._icon.buttonMode = true;
            this._icon.mouseChildren = false;
            if(this.isShadow)
            {
               _loc1_ = new iconPurple() as Sprite;
            }
            else
            {
               _loc1_ = new iconBlue() as Sprite;
            }
            _loc2_ = width / LicenseConstants.getScreenRatio();
            _loc3_ = (height - _loc2_) / 2;
            this._icon.addChild(_loc1_);
            this._icon.y = y + _loc3_ + 4;
            this._icon.x = 4;
            if(!content.contains(this._icon))
            {
               content.addChild(this._icon);
            }
         }
      }
      
      override protected function drawBody() : void
      {
         if(super.body != null)
         {
            content.removeChild(super.body);
         }
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "body";
         if(this._mver <= 3)
         {
            _loc1_.graphics.lineStyle(this.LINESIZE,this.ALPHA);
         }
         else if(this.isShadow)
         {
            _loc1_.graphics.lineStyle(1,6110118);
         }
         else
         {
            _loc1_.graphics.lineStyle(1,932450);
         }
         var _loc2_:Number = width / LicenseConstants.getScreenRatio();
         var _loc3_:Number = (height - _loc2_) / 2;
         if(this._mver <= 3)
         {
            UtilDraw.drawDashRect(_loc1_,x,y + _loc3_,width,_loc2_,6,8);
         }
         else
         {
            _loc1_.graphics.drawRect(x,y + _loc3_,width,_loc2_);
            if(this.isShadow)
            {
               _loc1_.graphics.lineStyle(1,10190045);
            }
            else
            {
               _loc1_.graphics.lineStyle(1,6464994);
            }
            _loc1_.graphics.drawRect(x + 1,y + _loc3_ + 1,width - 2,_loc2_ - 2);
         }
         _loc1_.graphics.lineStyle(20,16777215,0);
         _loc1_.graphics.drawRect(x,y,width,height);
         super.body = content.addChild(_loc1_) as Sprite;
      }
      
      override protected function drawLabel() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:TextField = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         super.drawLabel();
         if(super.label != null && this.contains(super.label))
         {
            this.removeChild(super.label);
         }
         if(this.width > 80)
         {
            if(this._mver <= 3)
            {
               _loc1_ = 70;
               if(this._isCut)
               {
                  _loc2_ = returnLabel(EffectMgr.TYPE_CUT,this.width,this.height,false);
               }
               else if(this._isPan)
               {
                  _loc2_ = returnLabel(EffectMgr.TYPE_PAN,this.width,this.height,false);
               }
               else
               {
                  _loc2_ = returnLabel(EffectMgr.TYPE_ZOOM,this.width,this.height,false);
               }
               _loc2_.x = x;
               _loc2_.width = _loc1_;
               boundHeight = height;
               boundWidth = width;
               super.label = addChild(_loc2_) as TextField;
               updateVerticalAlign();
               _loc3_ = LicenseConstants.getScreenRatio();
               _loc4_ = width / _loc3_;
               _loc2_.y = y + (height - _loc4_) / 2 + _loc4_ - _loc2_.height;
            }
         }
      }
      
      override public function redraw() : void
      {
         this.drawBody();
         this.drawLabel();
         this.drawIcon();
      }
   }
}
