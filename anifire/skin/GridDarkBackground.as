package anifire.skin
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import mx.core.FlexGlobals;
   import mx.skins.ProgrammaticSkin;
   import mx.styles.CSSStyleDeclaration;
   
   public class GridDarkBackground extends ProgrammaticSkin
   {
       
      
      private var backgroundImage:Bitmap;
      
      private var backgroundBitmapData:BitmapData;
      
      private var _fillColors:Array;
      
      public function GridDarkBackground()
      {
         this._fillColors = [15987699,14079702];
         super();
         var _loc1_:CSSStyleDeclaration = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".sceneTimeline");
         var _loc2_:Class = _loc1_.getStyle("bgDark") as Class;
         this._fillColors = _loc1_.getStyle("fillColors") as Array;
         if(!this._fillColors)
         {
            this._fillColors = [15987699,14079702];
         }
         this.backgroundImage = new _loc2_();
         this.backgroundBitmapData = new BitmapData(this.backgroundImage.width,this.backgroundImage.height);
         this.backgroundBitmapData.draw(this.backgroundImage);
      }
      
      override public function get measuredWidth() : Number
      {
         return 0;
      }
      
      override public function get measuredHeight() : Number
      {
         return 0;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:Graphics = graphics;
         _loc3_.clear();
         drawRoundRect(0,0,param1,param2,0,this._fillColors,[1,1],verticalGradientMatrix(0,0,param1,param2));
         _loc3_.lineStyle(1,this._fillColors[1],1,true);
         _loc3_.moveTo(0,53);
         _loc3_.lineTo(param1,53);
         _loc3_.moveTo(0,69);
         _loc3_.lineTo(param1,69);
         _loc3_.endFill();
      }
   }
}
