package anifire.components.publish
{
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class WatermarkPreview extends Canvas
   {
       
      
      private var _1581931332customLogo:Image;
      
      private var _437188724defaultLogo:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function WatermarkPreview()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___WatermarkPreview_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Button,
                  "id":"defaultLogo",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnLogo",
                        "left":5,
                        "bottom":5,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Image,
                  "id":"customLogo",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "left":5,
                        "bottom":5,
                        "visible":false
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.addEventListener("creationComplete",this.___WatermarkPreview_Canvas1_creationComplete);
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
      }
      
      public function loadDefaultLogo() : void
      {
         this.defaultLogo.visible = true;
         this.customLogo.visible = false;
      }
      
      public function loadCustomLogoByUrl(param1:String) : void
      {
         this.customLogo.source = param1;
         this.customLogo.visible = true;
         this.defaultLogo.visible = false;
      }
      
      public function ___WatermarkPreview_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      [Bindable(event="propertyChange")]
      public function get customLogo() : Image
      {
         return this._1581931332customLogo;
      }
      
      public function set customLogo(param1:Image) : void
      {
         var _loc2_:Object = this._1581931332customLogo;
         if(_loc2_ !== param1)
         {
            this._1581931332customLogo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"customLogo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get defaultLogo() : Button
      {
         return this._437188724defaultLogo;
      }
      
      public function set defaultLogo(param1:Button) : void
      {
         var _loc2_:Object = this._437188724defaultLogo;
         if(_loc2_ !== param1)
         {
            this._437188724defaultLogo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"defaultLogo",_loc2_,param1));
            }
         }
      }
   }
}
