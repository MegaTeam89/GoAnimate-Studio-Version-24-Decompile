package anifire.components.studio
{
   import anifire.util.UtilDict;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class ThemeItemRenderer extends Canvas
   {
       
      
      private var _271600932_iconHolder:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ThemeItemRenderer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_iconHolder",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":30,
                        "height":30,
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
         super.data = param1;
         this._iconHolder.styleName = "iconTheme" + param1.id;
         this._iconHolder.toolTip = UtilDict.toDisplay("store",param1.label);
      }
      
      [Bindable(event="propertyChange")]
      public function get _iconHolder() : Canvas
      {
         return this._271600932_iconHolder;
      }
      
      public function set _iconHolder(param1:Canvas) : void
      {
         var _loc2_:Object = this._271600932_iconHolder;
         if(_loc2_ !== param1)
         {
            this._271600932_iconHolder = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_iconHolder",_loc2_,param1));
            }
         }
      }
   }
}
