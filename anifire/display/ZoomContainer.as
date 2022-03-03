package anifire.display
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   
   public class ZoomContainer extends Canvas
   {
       
      
      private var _1037176500panLayer:Canvas;
      
      private var _1634741566zoomLayer:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ZoomContainer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "creationComplete":"___ZoomContainer_Canvas1_creationComplete",
               "resize":"___ZoomContainer_Canvas1_resize"
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"panLayer",
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"zoomLayer",
                        "propertiesFactory":function():Object
                        {
                           return {
                              "horizontalScrollPolicy":"off",
                              "verticalScrollPolicy":"off"
                           };
                        }
                     })]};
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___ZoomContainer_Canvas1_creationComplete);
         this.addEventListener("resize",this.___ZoomContainer_Canvas1_resize);
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
      
      private function onCreationComplete() : void
      {
         this.panLayer.scrollRect = new Rectangle((this.zoomLayer.width - this.width) / 2,(this.zoomLayer.height - this.height) / 2,this.width,this.height);
      }
      
      private function onResize() : void
      {
         this.panLayer.scrollRect = new Rectangle((this.zoomLayer.width - this.width) / 2,(this.zoomLayer.height - this.height) / 2,this.width,this.height);
      }
      
      public function panTo(param1:Number, param2:Number) : void
      {
         this.pan(param1 * this.zoomLayer.scaleX - this.panLayer.scrollRect.x - this.panLayer.scrollRect.width / 2,param2 * this.zoomLayer.scaleY - this.panLayer.scrollRect.y - this.panLayer.scrollRect.height / 2);
      }
      
      public function pan(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = this.panLayer.scrollRect;
         if(_loc3_.width <= this.zoomLayer.width)
         {
            if(_loc3_.x + param1 <= 0)
            {
               _loc3_.x = 0;
            }
            else if(_loc3_.x + param1 + _loc3_.width >= this.zoomLayer.width)
            {
               _loc3_.x = this.zoomLayer.width - _loc3_.width;
            }
            else
            {
               _loc3_.x += param1;
            }
         }
         else
         {
            _loc3_.x = (this.zoomLayer.width - _loc3_.width) / 2;
         }
         if(_loc3_.height <= this.zoomLayer.height)
         {
            if(_loc3_.y + param2 <= 0)
            {
               _loc3_.y = 0;
            }
            else if(_loc3_.y + param2 + _loc3_.height >= this.zoomLayer.height)
            {
               _loc3_.y = this.zoomLayer.height - _loc3_.height;
            }
            else
            {
               _loc3_.y += param2;
            }
         }
         else
         {
            _loc3_.y = (this.zoomLayer.height - _loc3_.height) / 2;
         }
         this.panLayer.scrollRect = _loc3_;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get viewRect() : Rectangle
      {
         return new Rectangle(this.panLayer.scrollRect.x / this.zoomLayer.scaleX,this.panLayer.scrollRect.y / this.zoomLayer.scaleY,this.panLayer.scrollRect.width / this.zoomLayer.scaleX,this.panLayer.scrollRect.height / this.zoomLayer.scaleY);
      }
      
      public function zoom(param1:Number) : void
      {
         this.zoomTo(param1,this.viewCenter.x,this.viewCenter.y);
      }
      
      public function zoomTo(param1:Number, param2:Number, param3:Number) : void
      {
         if(param1 <= 0)
         {
            param1 = 1;
         }
         this.zoomLayer.scaleX = this.zoomLayer.scaleY = param1;
         this.zoomLayer.validateNow();
         this.panTo(param2,param3);
      }
      
      public function get zoomFactor() : Number
      {
         return this.zoomLayer.scaleX;
      }
      
      public function get viewCenter() : Point
      {
         return new Point((this.panLayer.scrollRect.x + this.panLayer.scrollRect.width / 2) / this.zoomLayer.scaleX,(this.panLayer.scrollRect.y + this.panLayer.scrollRect.height / 2) / this.zoomLayer.scaleX);
      }
      
      public function set dsp(param1:DisplayObject) : void
      {
         this.zoomLayer.removeAllChildren();
         this.zoomLayer.addChild(param1);
         this.zoomLayer.width = param1.width;
         this.zoomLayer.height = param1.height;
         this.zoomLayer.validateNow();
         this.zoomLayer.validateDisplayList();
         this.panLayer.scrollRect = new Rectangle((param1.width - this.width) / 2,(param1.height - this.height) / 2,this.width,this.height);
      }
      
      public function ___ZoomContainer_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___ZoomContainer_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.onResize();
      }
      
      [Bindable(event="propertyChange")]
      public function get panLayer() : Canvas
      {
         return this._1037176500panLayer;
      }
      
      public function set panLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1037176500panLayer;
         if(_loc2_ !== param1)
         {
            this._1037176500panLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"panLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get zoomLayer() : Canvas
      {
         return this._1634741566zoomLayer;
      }
      
      public function set zoomLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1634741566zoomLayer;
         if(_loc2_ !== param1)
         {
            this._1634741566zoomLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"zoomLayer",_loc2_,param1));
            }
         }
      }
   }
}
