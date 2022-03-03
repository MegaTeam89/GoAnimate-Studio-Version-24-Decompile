package anifire.containers
{
   import mx.containers.Canvas;
   import mx.core.FlexGlobals;
   import mx.styles.CSSStyleDeclaration;
   
   public class GradientCanvas extends Canvas
   {
      
      private static var classConstructed:Boolean = classConstruct();
       
      
      private var bStypePropChanged:Boolean = true;
      
      private var _fillColorsData:Array;
      
      private var _borderColorsData:Array;
      
      private var _borderCanvas:Canvas;
      
      public function GradientCanvas()
      {
         this._borderCanvas = new Canvas();
         super();
         this.addChild(this._borderCanvas);
      }
      
      private static function classConstruct() : Boolean
      {
         var myRectStyles:CSSStyleDeclaration = null;
         if(!FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration("GradientCanvas"))
         {
            myRectStyles = new CSSStyleDeclaration();
            myRectStyles.defaultFactory = function():void
            {
            };
            FlexGlobals.topLevelApplication.styleManager.setStyleDeclaration("GradientCanvas",myRectStyles,true);
         }
         return true;
      }
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         if(param1 == "fillColors" || param1 == "borderColors")
         {
            this.bStypePropChanged = true;
            invalidateDisplayList();
            return;
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         super.updateDisplayList(param1,param2);
         if(this.bStypePropChanged == true)
         {
            this._fillColorsData = getStyle("fillColors");
            this._borderColorsData = getStyle("borderColors");
            _loc3_ = [1,1];
            _loc4_ = getStyle("cornerRadius");
            if(this._fillColorsData)
            {
               graphics.clear();
               drawRoundRect(0,0,param1,param2,_loc4_,this._fillColorsData,_loc3_,verticalGradientMatrix(0,0,param1,param2));
            }
            if(this._borderColorsData)
            {
               this._borderCanvas.graphics.clear();
               this._borderCanvas.graphics.lineStyle(1,this._borderColorsData[0],1,true);
               this._borderCanvas.graphics.lineTo(param1 - 1,0);
               this._borderCanvas.graphics.lineStyle(1,this._borderColorsData[1],1,true);
               this._borderCanvas.graphics.lineTo(param1 - 1,param2 - 1);
               this._borderCanvas.graphics.lineStyle(1,this._borderColorsData[2],1,true);
               this._borderCanvas.graphics.lineTo(0,param2 - 1);
               this._borderCanvas.graphics.lineStyle(1,this._borderColorsData[3],1,true);
               this._borderCanvas.graphics.lineTo(0,0);
            }
         }
      }
   }
}
