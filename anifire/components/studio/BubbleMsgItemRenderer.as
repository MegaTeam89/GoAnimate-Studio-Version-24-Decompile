package anifire.components.studio
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class BubbleMsgItemRenderer extends HBox
   {
       
      
      private var _697995159bubbleImg:Image;
      
      private var _1401521777iconStack:Canvas;
      
      private var _1301516301msgLabel:Label;
      
      private var _1742637108soundImg:Image;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _embed_mxml__________styles_images_bunny_ico_bubble_png_1246886255:Class;
      
      private var _embed_mxml__________styles_images_bunny_ico_bubble_note_png_1158740495:Class;
      
      public function BubbleMsgItemRenderer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "events":{
               "rollOver":"___BubbleMsgItemRenderer_HBox1_rollOver",
               "rollOut":"___BubbleMsgItemRenderer_HBox1_rollOut",
               "creationComplete":"___BubbleMsgItemRenderer_HBox1_creationComplete"
            },
            "stylesFactory":function():void
            {
               this.paddingRight = 5;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Label,
                  "id":"msgLabel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"bubbleMsgWindowListItem",
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"iconStack",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Image,
                           "id":"bubbleImg",
                           "propertiesFactory":function():Object
                           {
                              return {"source":_embed_mxml__________styles_images_bunny_ico_bubble_png_1246886255};
                           }
                        }),new UIComponentDescriptor({
                           "type":Image,
                           "id":"soundImg",
                           "propertiesFactory":function():Object
                           {
                              return {"source":_embed_mxml__________styles_images_bunny_ico_bubble_note_png_1158740495};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._embed_mxml__________styles_images_bunny_ico_bubble_png_1246886255 = BubbleMsgItemRenderer__embed_mxml__________styles_images_bunny_ico_bubble_png_1246886255;
         this._embed_mxml__________styles_images_bunny_ico_bubble_note_png_1158740495 = BubbleMsgItemRenderer__embed_mxml__________styles_images_bunny_ico_bubble_note_png_1158740495;
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("rollOver",this.___BubbleMsgItemRenderer_HBox1_rollOver);
         this.addEventListener("rollOut",this.___BubbleMsgItemRenderer_HBox1_rollOut);
         this.addEventListener("creationComplete",this.___BubbleMsgItemRenderer_HBox1_creationComplete);
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
            this.paddingRight = 5;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function init() : void
      {
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         if(param1 is BubbleMsgChooserItem)
         {
            this.msgLabel.text = (param1 as BubbleMsgChooserItem).displayText;
         }
      }
      
      private function onMouseOver(param1:Event) : void
      {
         var _loc2_:BubbleMsgChooserItem = data as BubbleMsgChooserItem;
         this.iconStack.visible = true;
         if(_loc2_.isSound)
         {
            this.bubbleImg.visible = false;
            this.soundImg.visible = true;
         }
         else if(_loc2_.isBubble)
         {
            this.bubbleImg.visible = true;
            this.soundImg.visible = false;
         }
         this.msgLabel.setStyle("color",this.getStyle("textRollOverColor"));
      }
      
      private function onMouseOut(param1:Event) : void
      {
         this.iconStack.visible = false;
         this.msgLabel.setStyle("color",this.getStyle("color"));
      }
      
      public function ___BubbleMsgItemRenderer_HBox1_rollOver(param1:MouseEvent) : void
      {
         this.onMouseOver(param1);
      }
      
      public function ___BubbleMsgItemRenderer_HBox1_rollOut(param1:MouseEvent) : void
      {
         this.onMouseOut(param1);
      }
      
      public function ___BubbleMsgItemRenderer_HBox1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get bubbleImg() : Image
      {
         return this._697995159bubbleImg;
      }
      
      public function set bubbleImg(param1:Image) : void
      {
         var _loc2_:Object = this._697995159bubbleImg;
         if(_loc2_ !== param1)
         {
            this._697995159bubbleImg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bubbleImg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconStack() : Canvas
      {
         return this._1401521777iconStack;
      }
      
      public function set iconStack(param1:Canvas) : void
      {
         var _loc2_:Object = this._1401521777iconStack;
         if(_loc2_ !== param1)
         {
            this._1401521777iconStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconStack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get msgLabel() : Label
      {
         return this._1301516301msgLabel;
      }
      
      public function set msgLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1301516301msgLabel;
         if(_loc2_ !== param1)
         {
            this._1301516301msgLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"msgLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get soundImg() : Image
      {
         return this._1742637108soundImg;
      }
      
      public function set soundImg(param1:Image) : void
      {
         var _loc2_:Object = this._1742637108soundImg;
         if(_loc2_ !== param1)
         {
            this._1742637108soundImg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundImg",_loc2_,param1));
            }
         }
      }
   }
}
