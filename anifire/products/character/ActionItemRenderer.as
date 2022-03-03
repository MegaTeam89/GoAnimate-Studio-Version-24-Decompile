package anifire.products.character
{
   import anifire.core.Action;
   import anifire.util.UtilDict;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class ActionItemRenderer extends Canvas
   {
       
      
      private var _1339593059_thumbHolder:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ActionItemRenderer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_thumbHolder",
                  "stylesFactory":function():void
                  {
                     this.backgroundAlpha = 1;
                     this.backgroundColor = 15658734;
                     this.borderColor = 15658734;
                     this.borderStyle = "solid";
                     this.cornerRadius = 4;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":2,
                        "width":40,
                        "height":40,
                        "buttonMode":true
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
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
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:Action = null;
         var _loc3_:ActionThumbImage = null;
         super.data = param1;
         if(param1 is Action)
         {
            _loc2_ = param1 as Action;
            this._thumbHolder.removeAllChildren();
            _loc3_ = ActionThumbImage.getImage(_loc2_);
            if(_loc3_)
            {
               _loc3_.horizontalCenter = 0;
               _loc3_.verticalCenter = 0;
               this._thumbHolder.addChild(_loc3_);
               this._thumbHolder.toolTip = UtilDict.toDisplay("store",_loc2_.name);
            }
         }
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         this._thumbHolder.scaleX = this._thumbHolder.scaleY = 1.2;
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         this._thumbHolder.scaleX = this._thumbHolder.scaleY = 1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _thumbHolder() : Canvas
      {
         return this._1339593059_thumbHolder;
      }
      
      public function set _thumbHolder(param1:Canvas) : void
      {
         var _loc2_:Object = this._1339593059_thumbHolder;
         if(_loc2_ !== param1)
         {
            this._1339593059_thumbHolder = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_thumbHolder",_loc2_,param1));
            }
         }
      }
   }
}
