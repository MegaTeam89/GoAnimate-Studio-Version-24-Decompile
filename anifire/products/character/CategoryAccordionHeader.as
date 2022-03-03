package anifire.products.character
{
   import anifire.core.Action;
   import anifire.util.UtilHashArray;
   import flexlib.containers.accordionClasses.CanvasButtonAccordionHeader;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class CategoryAccordionHeader extends CanvasButtonAccordionHeader
   {
      
      private static var ArrowRightIcon:Class = CategoryAccordionHeader_ArrowRightIcon;
      
      private static var ArrowDownIcon:Class = CategoryAccordionHeader_ArrowDownIcon;
      
      private static var _images:UtilHashArray = new UtilHashArray();
       
      
      private var _3322hb:HBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _1472470539_label:String;
      
      private var _image:ActionThumbImage;
      
      public function CategoryAccordionHeader()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":CanvasButtonAccordionHeader,
            "events":{"creationComplete":"___CategoryAccordionHeader_CanvasButtonAccordionHeader1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "id":"hb",
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "middle";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":45,
                        "right":20
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.addEventListener("creationComplete",this.___CategoryAccordionHeader_CanvasButtonAccordionHeader1_creationComplete);
      }
      
      public static function getImage(param1:Action) : ActionThumbImage
      {
         var _loc2_:ActionThumbImage = _images.getValueByKey(param1.aid) as ActionThumbImage;
         if(!_loc2_)
         {
            _loc2_ = new ActionThumbImage();
            _loc2_.action = param1;
            _images.push(param1.aid,_loc2_);
         }
         return _loc2_;
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
      
      override public function set label(param1:String) : void
      {
         super.label = param1;
         this._label = param1;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:Action = null;
         var _loc3_:ActionThumbImage = null;
         super.data = param1;
         if(param1 is Canvas)
         {
            _loc2_ = Canvas(param1).data as Action;
            if(_loc2_)
            {
               _loc3_ = getImage(_loc2_);
               if(!_loc3_)
               {
               }
               this._image = _loc3_;
            }
         }
      }
      
      protected function onCreationComplete(param1:FlexEvent) : void
      {
         if(this._image)
         {
            this.hb.addChild(this._image);
         }
         this.setStyle("selectedUpIcon",ArrowDownIcon);
         this.setStyle("selectedOverIcon",ArrowDownIcon);
         this.setStyle("selectedDownIcon",ArrowDownIcon);
         this.setStyle("borderThickness",0);
         this.setStyle("skin",null);
      }
      
      public function ___CategoryAccordionHeader_CanvasButtonAccordionHeader1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get hb() : HBox
      {
         return this._3322hb;
      }
      
      public function set hb(param1:HBox) : void
      {
         var _loc2_:Object = this._3322hb;
         if(_loc2_ !== param1)
         {
            this._3322hb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hb",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _label() : String
      {
         return this._1472470539_label;
      }
      
      private function set _label(param1:String) : void
      {
         var _loc2_:Object = this._1472470539_label;
         if(_loc2_ !== param1)
         {
            this._1472470539_label = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_label",_loc2_,param1));
            }
         }
      }
   }
}
