package anifire.assets.control
{
   import mx.containers.Canvas;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class AssetMotionToolTip extends Canvas
   {
       
      
      private var _3446lb:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function AssetMotionToolTip()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "stylesFactory":function():void
            {
               this.backgroundColor = 5405190;
               this.backgroundAlpha = 0.8;
               this.borderColor = 5405190;
               this.borderStyle = "solid";
               this.cornerRadius = 3;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":40,
                  "height":15,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Label,
                     "id":"lb",
                     "stylesFactory":function():void
                     {
                        this.color = 16777215;
                        this.fontSize = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "horizontalCenter":0,
                           "verticalCenter":0
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.width = 40;
         this.height = 15;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 5405190;
            this.backgroundAlpha = 0.8;
            this.borderColor = 5405190;
            this.borderStyle = "solid";
            this.cornerRadius = 3;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function setLabelText(param1:String) : void
      {
         this.lb.text = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get lb() : Label
      {
         return this._3446lb;
      }
      
      public function set lb(param1:Label) : void
      {
         var _loc2_:Object = this._3446lb;
         if(_loc2_ !== param1)
         {
            this._3446lb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lb",_loc2_,param1));
            }
         }
      }
   }
}
