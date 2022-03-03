package anifire.components.studio
{
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductThumb;
   import anifire.products.view.ProductThumbFactory;
   import anifire.products.view.ProductThumbLibrary;
   import flash.display.DisplayObject;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class ProductItemRenderer extends Canvas
   {
       
      
      private var _1339593059_thumbHolder:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ProductItemRenderer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_thumbHolder"
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
         var _loc2_:IProduct = null;
         var _loc3_:String = null;
         var _loc4_:IProductThumb = null;
         super.data = param1;
         if(param1 is IProduct)
         {
            _loc2_ = param1 as IProduct;
            this._thumbHolder.removeAllChildren();
            _loc3_ = _loc2_.uid;
            if((_loc4_ = ProductThumbLibrary.getThumb(_loc3_)) == null)
            {
               (_loc4_ = ProductThumbFactory.createThumb(_loc2_)).product = _loc2_;
               ProductThumbLibrary.addThumb(_loc3_,_loc4_);
            }
            this._thumbHolder.addChild(DisplayObject(_loc4_));
         }
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
