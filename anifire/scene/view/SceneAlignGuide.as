package anifire.scene.view
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.LicenseConstants;
   import anifire.geom.AlignmentEdge;
   import anifire.geom.AlignmentTool;
   import anifire.util.UtilMath;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import mx.containers.Canvas;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class SceneAlignGuide extends Canvas
   {
       
      
      private var _1262384555gridLayer:Canvas;
      
      private var _1055665116textLayer:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _textField:TextField;
      
      private var _alignTool:AlignmentTool;
      
      public function SceneAlignGuide()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___SceneAlignGuide_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"gridLayer",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"textLayer"
               })]};
            }
         });
         this._textField = new TextField();
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___SceneAlignGuide_Canvas1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      protected function onCreationComplete(param1:FlexEvent) : void
      {
      }
      
      private function drawGrid() : void
      {
         var _loc1_:Point = new Point(AnimeConstants.STAGE_PADDING + AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH / 2,AnimeConstants.STAGE_PADDING + (!!LicenseConstants.isWideScreen() ? AnimeConstants.WIDE_SCREEN_Y + AnimeConstants.WIDE_SCREEN_HEIGHT / 2 : AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT / 2));
         this.gridLayer.graphics.lineStyle(1,11979662,0.8,true);
         var _loc2_:Number = 20;
         var _loc3_:uint = 0;
         while(_loc3_ < 100)
         {
            this.gridLayer.graphics.moveTo(_loc1_.x + (_loc3_ - 50) * _loc2_,0);
            this.gridLayer.graphics.lineTo(_loc1_.x + (_loc3_ - 50) * _loc2_,1000);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < 100)
         {
            this.gridLayer.graphics.moveTo(0,_loc1_.y + (_loc4_ - 50) * _loc2_);
            this.gridLayer.graphics.lineTo(2000,_loc1_.y + (_loc4_ - 50) * _loc2_);
            _loc4_++;
         }
      }
      
      public function redrawAlignGuide(param1:AlignmentTool, param2:Array, param3:Rectangle) : void
      {
         var _loc4_:Rectangle = null;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:AlignmentEdge = null;
         var _loc8_:AlignmentEdge = null;
         var _loc9_:Point = null;
         this._alignTool = param1;
         this.gridLayer.graphics.clear();
         this.gridLayer.graphics.lineStyle(param1.scaleFactor,5405190,0.5,true);
         if(_loc7_ = param1.edgeWithSameVerticalEdge)
         {
            _loc5_ = new Point(param1.snappedPosition.x,param3.top);
            _loc6_ = new Point(param1.snappedPosition.x,param3.bottom);
            _loc4_ = _loc7_.rect;
            _loc5_.y = Math.min(_loc5_.y,_loc4_.top);
            _loc6_.y = Math.max(_loc6_.y,_loc4_.bottom);
            if(_loc7_.id == "camera" || _loc7_.id == "ruleOfThirds")
            {
               this.gridLayer.graphics.lineStyle(param1.scaleFactor,3698594,0.5,true);
            }
            else if(_loc7_.id == "oldPosition")
            {
               this.gridLayer.graphics.lineStyle(param1.scaleFactor,11184810,0.5,true);
            }
            else
            {
               this.gridLayer.graphics.lineStyle(param1.scaleFactor,5405190,0.5,true);
            }
            this.gridLayer.graphics.moveTo(AnimeConstants.STAGE_PADDING + _loc5_.x,AnimeConstants.STAGE_PADDING + _loc5_.y);
            this.gridLayer.graphics.lineTo(AnimeConstants.STAGE_PADDING + _loc6_.x,AnimeConstants.STAGE_PADDING + _loc6_.y);
         }
         if(_loc8_ = param1.edgeWithSameHorizontalEdge)
         {
            _loc5_ = new Point(param3.left,param1.snappedPosition.y);
            _loc6_ = new Point(param3.right,param1.snappedPosition.y);
            _loc4_ = _loc8_.rect;
            _loc5_.x = Math.min(_loc5_.x,_loc4_.left);
            _loc6_.x = Math.max(_loc6_.x,_loc4_.right);
            if(_loc8_.id == "camera" || _loc8_.id == "ruleOfThirds")
            {
               this.gridLayer.graphics.lineStyle(param1.scaleFactor,3698594,0.5,true);
            }
            else if(_loc8_.id == "oldPosition")
            {
               this.gridLayer.graphics.lineStyle(param1.scaleFactor,11184810,0.5,true);
            }
            else
            {
               this.gridLayer.graphics.lineStyle(param1.scaleFactor,5405190,0.5,true);
            }
            this.gridLayer.graphics.moveTo(AnimeConstants.STAGE_PADDING + _loc5_.x,AnimeConstants.STAGE_PADDING + _loc5_.y);
            this.gridLayer.graphics.lineTo(AnimeConstants.STAGE_PADDING + _loc6_.x,AnimeConstants.STAGE_PADDING + _loc6_.y);
         }
         this.gridLayer.graphics.lineStyle(param1.scaleFactor,3698594,0.5,true);
         if(_loc7_ && _loc7_.id == "ruleOfThirds")
         {
            if(_loc7_.rect.width >= 80 * param1.scaleFactor)
            {
               this.drawRuleOfThirds(_loc7_.rect);
            }
         }
         else if(_loc8_ && _loc8_.id == "ruleOfThirds")
         {
            if(_loc8_.rect.width >= 80 * param1.scaleFactor)
            {
               this.drawRuleOfThirds(_loc8_.rect);
            }
         }
         if(_loc7_ && _loc7_.id == "camera")
         {
            if(_loc7_.rect.width >= 80 * param1.scaleFactor)
            {
               _loc9_ = UtilMath.getCenter(_loc7_.rect);
               this.drawCross(_loc9_.x,_loc9_.y);
            }
         }
         else if(_loc8_ && _loc8_.id == "camera")
         {
            if(_loc8_.rect.width >= 80 * param1.scaleFactor)
            {
               _loc9_ = UtilMath.getCenter(_loc8_.rect);
               this.drawCross(_loc9_.x,_loc9_.y);
            }
         }
      }
      
      private function drawRuleOfThirds(param1:Rectangle) : void
      {
         this.drawCross(param1.x + param1.width / 3,param1.y + param1.height / 3);
         this.drawCross(param1.x + param1.width / 3,param1.y + 2 * param1.height / 3);
         this.drawCross(param1.x + 2 * param1.width / 3,param1.y + param1.height / 3);
         this.drawCross(param1.x + 2 * param1.width / 3,param1.y + 2 * param1.height / 3);
      }
      
      private function drawCross(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = 15 * this._alignTool.scaleFactor;
         this.gridLayer.graphics.moveTo(AnimeConstants.STAGE_PADDING + param1,AnimeConstants.STAGE_PADDING + param2 - _loc3_);
         this.gridLayer.graphics.lineTo(AnimeConstants.STAGE_PADDING + param1,AnimeConstants.STAGE_PADDING + param2 + _loc3_);
         this.gridLayer.graphics.moveTo(AnimeConstants.STAGE_PADDING + param1 - _loc3_,AnimeConstants.STAGE_PADDING + param2);
         this.gridLayer.graphics.lineTo(AnimeConstants.STAGE_PADDING + param1 + _loc3_,AnimeConstants.STAGE_PADDING + param2);
      }
      
      public function redrawSpacingGuide(param1:AlignmentTool) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Rectangle = null;
         var _loc4_:uint = 0;
         this.textLayer.removeAllChildren();
         this.gridLayer.graphics.lineStyle(param1.scaleFactor,5405190,0.5,true);
         if(param1.rectsWithEqualHorizontalSpacing.length > 1)
         {
            _loc4_ = 1;
            while(_loc4_ < param1.rectsWithEqualHorizontalSpacing.length)
            {
               _loc2_ = param1.rectsWithEqualHorizontalSpacing[_loc4_ - 1] as Rectangle;
               _loc3_ = param1.rectsWithEqualHorizontalSpacing[_loc4_] as Rectangle;
               this.drawHorizontalSpacingMarking(_loc2_,_loc3_);
               _loc4_++;
            }
         }
         if(param1.rectsWithEqualVerticalSpacing.length > 1)
         {
            _loc4_ = 1;
            while(_loc4_ < param1.rectsWithEqualVerticalSpacing.length)
            {
               _loc2_ = param1.rectsWithEqualVerticalSpacing[_loc4_ - 1] as Rectangle;
               _loc3_ = param1.rectsWithEqualVerticalSpacing[_loc4_] as Rectangle;
               this.drawVerticalSpacingMarking(_loc2_,_loc3_);
               _loc4_++;
            }
         }
      }
      
      private function drawHorizontalSpacingMarking(param1:Rectangle, param2:Rectangle) : void
      {
         var _loc3_:Number = Math.max(param1.top,param2.top);
         var _loc4_:Number = Math.min(param1.bottom,param2.bottom);
         var _loc5_:Number = Math.min(_loc3_,_loc4_) + Math.abs(_loc3_ - _loc4_) / 2;
         var _loc6_:Number = Math.min(param1.right,param2.right);
         var _loc7_:Number = Math.max(param1.left,param2.left);
         this.drawHorizontalArrow(AnimeConstants.STAGE_PADDING + _loc6_,AnimeConstants.STAGE_PADDING + _loc5_,AnimeConstants.STAGE_PADDING + _loc7_,AnimeConstants.STAGE_PADDING + _loc5_);
      }
      
      private function drawVerticalSpacingMarking(param1:Rectangle, param2:Rectangle) : void
      {
         var _loc3_:Number = Math.min(param1.right,param2.right);
         var _loc4_:Number = Math.max(param1.left,param2.left);
         var _loc5_:Number = Math.min(_loc3_,_loc4_) + Math.abs(_loc3_ - _loc4_) / 2;
         var _loc6_:Number = Math.min(param1.bottom,param2.bottom);
         var _loc7_:Number = Math.max(param1.top,param2.top);
         this.drawVerticalArrow(AnimeConstants.STAGE_PADDING + _loc5_,AnimeConstants.STAGE_PADDING + _loc6_,AnimeConstants.STAGE_PADDING + _loc5_,AnimeConstants.STAGE_PADDING + _loc7_);
      }
      
      private function drawHorizontalArrow(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = 5 * this._alignTool.scaleFactor;
         if(param3 - param1 < _loc5_ * 2)
         {
            this.gridLayer.graphics.moveTo(param1,param2 - _loc5_ * 2);
            this.gridLayer.graphics.lineTo(param1,param2 + _loc5_ * 2);
            this.gridLayer.graphics.moveTo(param1 - _loc5_,param2 - _loc5_ / 2);
            this.gridLayer.graphics.lineTo(param1,param2);
            this.gridLayer.graphics.lineTo(param1 - _loc5_,param2 + _loc5_ / 2);
            this.gridLayer.graphics.moveTo(param3,param4 - _loc5_ * 2);
            this.gridLayer.graphics.lineTo(param3,param4 + _loc5_ * 2);
            this.gridLayer.graphics.moveTo(param3 + _loc5_,param4 - _loc5_ / 2);
            this.gridLayer.graphics.lineTo(param3,param4);
            this.gridLayer.graphics.lineTo(param3 + _loc5_,param4 + _loc5_ / 2);
            return;
         }
         this.gridLayer.graphics.moveTo(param1,param2 - _loc5_ * 2);
         this.gridLayer.graphics.lineTo(param1,param2 + _loc5_ * 2);
         this.gridLayer.graphics.moveTo(param1 + _loc5_,param2 - _loc5_ / 2);
         this.gridLayer.graphics.lineTo(param1,param2);
         this.gridLayer.graphics.lineTo(param1 + _loc5_,param2 + _loc5_ / 2);
         this.gridLayer.graphics.moveTo(param1,param2);
         this.gridLayer.graphics.lineTo(param3,param4);
         this.gridLayer.graphics.moveTo(param3,param4 - _loc5_ * 2);
         this.gridLayer.graphics.lineTo(param3,param4 + _loc5_ * 2);
         this.gridLayer.graphics.moveTo(param3 - _loc5_,param4 - _loc5_ / 2);
         this.gridLayer.graphics.lineTo(param3,param4);
         this.gridLayer.graphics.lineTo(param3 - _loc5_,param4 + _loc5_ / 2);
         var _loc6_:Label;
         (_loc6_ = new Label()).text = String(int(param3 - param1));
         _loc6_.x = (param3 + param1) / 2 - 8;
         _loc6_.y = param2 - 15;
         _loc6_.alpha = 0.5;
         _loc6_.setStyle("fontSize","10");
         _loc6_.setStyle("color","0x527a06");
         this.textLayer.addChild(_loc6_);
      }
      
      private function drawVerticalArrow(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = 6 * this._alignTool.scaleFactor;
         if(param4 - param2 < _loc5_ * 2)
         {
            this.gridLayer.graphics.moveTo(param1 - _loc5_ * 2,param2);
            this.gridLayer.graphics.lineTo(param1 + _loc5_ * 2,param2);
            this.gridLayer.graphics.moveTo(param1 - _loc5_ / 2,param2 - _loc5_);
            this.gridLayer.graphics.lineTo(param1,param2);
            this.gridLayer.graphics.lineTo(param1 + _loc5_ / 2,param2 - _loc5_);
            this.gridLayer.graphics.moveTo(param3 - _loc5_ * 2,param4);
            this.gridLayer.graphics.lineTo(param3 + _loc5_ * 2,param4);
            this.gridLayer.graphics.moveTo(param3 - _loc5_ / 2,param4 + _loc5_);
            this.gridLayer.graphics.lineTo(param3,param4);
            this.gridLayer.graphics.lineTo(param3 + _loc5_ / 2,param4 + _loc5_);
            return;
         }
         this.gridLayer.graphics.moveTo(param1 - _loc5_ * 2,param2);
         this.gridLayer.graphics.lineTo(param1 + _loc5_ * 2,param2);
         this.gridLayer.graphics.moveTo(param1 - _loc5_ / 2,param2 + _loc5_);
         this.gridLayer.graphics.lineTo(param1,param2);
         this.gridLayer.graphics.lineTo(param1 + _loc5_ / 2,param2 + _loc5_);
         this.gridLayer.graphics.moveTo(param1,param2);
         this.gridLayer.graphics.lineTo(param3,param4);
         this.gridLayer.graphics.moveTo(param3 - _loc5_ * 2,param4);
         this.gridLayer.graphics.lineTo(param3 + _loc5_ * 2,param4);
         this.gridLayer.graphics.moveTo(param3 - _loc5_ / 2,param4 - _loc5_);
         this.gridLayer.graphics.lineTo(param3,param4);
         this.gridLayer.graphics.lineTo(param3 + _loc5_ / 2,param4 - _loc5_);
         var _loc6_:Label;
         (_loc6_ = new Label()).text = String(int(param4 - param2));
         _loc6_.x = param1 + 3;
         _loc6_.y = (param2 + param4) / 2 - 8;
         _loc6_.alpha = 0.5;
         _loc6_.setStyle("fontSize","10");
         _loc6_.setStyle("color","0x527a06");
         this.textLayer.addChild(_loc6_);
      }
      
      public function ___SceneAlignGuide_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get gridLayer() : Canvas
      {
         return this._1262384555gridLayer;
      }
      
      public function set gridLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1262384555gridLayer;
         if(_loc2_ !== param1)
         {
            this._1262384555gridLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gridLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get textLayer() : Canvas
      {
         return this._1055665116textLayer;
      }
      
      public function set textLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1055665116textLayer;
         if(_loc2_ !== param1)
         {
            this._1055665116textLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"textLayer",_loc2_,param1));
            }
         }
      }
   }
}
