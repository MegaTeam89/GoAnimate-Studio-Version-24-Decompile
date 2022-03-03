package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.containers.GradientCanvas;
   import anifire.util.UtilString;
   import mx.containers.Canvas;
   import mx.controls.Label;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   public class TimelineRuler extends Canvas
   {
      
      private static var classConstructed:Boolean = classConstruct();
       
      
      private var _108873974ruler:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var bStypePropChanged:Boolean = true;
      
      private var _markerColorData:uint = 0;
      
      public function TimelineRuler()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___TimelineRuler_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "height":17,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":GradientCanvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"timelineToolBar"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"ruler",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":999999,
                           "height":17,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off"
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.height = 17;
         this.styleName = "timelineToolBar";
         this.addEventListener("creationComplete",this.___TimelineRuler_Canvas1_creationComplete);
      }
      
      private static function classConstruct() : Boolean
      {
         var myRectStyles:CSSStyleDeclaration = null;
         if(!FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration("TimelineRuler"))
         {
            myRectStyles = new CSSStyleDeclaration();
            myRectStyles.defaultFactory = function():void
            {
               this.markerColor = 0;
            };
            FlexGlobals.topLevelApplication.styleManager.setStyleDeclaration("TimelineRuler",myRectStyles,true);
         }
         return true;
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
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         if(param1 == "markerColor")
         {
            this.bStypePropChanged = true;
            invalidateDisplayList();
            return;
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         if(this.bStypePropChanged == true)
         {
            this._markerColorData = getStyle("markerColor");
            this.drawMarker();
            this.bStypePropChanged = false;
         }
      }
      
      private function drawMarker() : void
      {
         var _loc2_:Label = null;
         this.ruler.graphics.clear();
         this.ruler.graphics.lineStyle(1,this._markerColorData,1,true);
         var _loc1_:Number = 0.125 * AnimeConstants.PIXEL_PER_SEC;
         var _loc3_:uint = 0;
         while(_loc3_ < 14400)
         {
            if(_loc3_ > 0)
            {
               if(_loc3_ % 4 == 0)
               {
                  this.ruler.graphics.moveTo(_loc3_ * _loc1_,this.height - 7);
                  this.ruler.graphics.lineTo(_loc3_ * _loc1_,this.height - 1);
               }
               else
               {
                  this.ruler.graphics.moveTo(_loc3_ * _loc1_,this.height - 4);
                  this.ruler.graphics.lineTo(_loc3_ * _loc1_,this.height - 1);
               }
            }
            if(_loc3_ % 40 == 0 && _loc3_ > 0)
            {
               _loc2_ = new Label();
               if(_loc3_ / 8 >= 60)
               {
                  _loc2_.text = UtilString.secToTimeString(_loc3_ / 8,false);
               }
               else
               {
                  _loc2_.text = String(_loc3_ / 8) + "s";
               }
               _loc2_.setStyle("fontSize",10);
               _loc2_.setStyle("color",this._markerColorData);
               _loc2_.setStyle("textAlign","center");
               _loc2_.width = 50;
               _loc2_.x = _loc3_ * _loc1_ - 25;
               this.ruler.addChild(_loc2_);
            }
            _loc3_++;
         }
         this.ruler.graphics.endFill();
      }
      
      public function setHorizontalView(param1:Number) : void
      {
         this.ruler.setStyle("left",-param1);
      }
      
      public function ___TimelineRuler_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get ruler() : Canvas
      {
         return this._108873974ruler;
      }
      
      public function set ruler(param1:Canvas) : void
      {
         var _loc2_:Object = this._108873974ruler;
         if(_loc2_ !== param1)
         {
            this._108873974ruler = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ruler",_loc2_,param1));
            }
         }
      }
   }
}
