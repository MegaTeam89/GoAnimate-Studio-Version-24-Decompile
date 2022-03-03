package flexlib.containers.accordionClasses
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flexlib.controls.CanvasButton;
   import mx.core.Container;
   import mx.core.IDataRenderer;
   import mx.core.IFlexDisplayObject;
   import mx.core.mx_internal;
   import mx.skins.halo.AccordionHeaderSkin;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.ISimpleStyleClient;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class CanvasButtonAccordionHeader extends CanvasButton implements IDataRenderer
   {
      
      mx_internal static var createAccessibilityImplementation:Function;
      
      {
         initializeStyles();
      }
      
      private var focusObj:DisplayObject;
      
      private var focusSkin:IFlexDisplayObject;
      
      private var _data:Object;
      
      public function CanvasButtonAccordionHeader()
      {
         super();
         toggleChanged = false;
         mouseFocusEnabled = false;
         tabEnabled = false;
      }
      
      private static function initializeStyles() : void
      {
         var selector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("CanvasButtonAccordionHeader");
         if(!selector)
         {
            selector = new CSSStyleDeclaration();
         }
         selector.defaultFactory = function():void
         {
            this.fontSize = 10;
            this.fontWeight = "bold";
            this.disabledSkin = AccordionHeaderSkin;
            this.downSkin = AccordionHeaderSkin;
            this.horizontalGap = 2;
            this.overSkin = AccordionHeaderSkin;
            this.paddingLeft = 5;
            this.paddingRight = 5;
            this.selectedDisabledSkin = AccordionHeaderSkin;
            this.selectedDownSkin = AccordionHeaderSkin;
            this.selectedOverSkin = AccordionHeaderSkin;
            this.selectedUpSkin = AccordionHeaderSkin;
            this.skin = AccordionHeaderSkin;
            this.textAlign = "left";
            this.upSkin = AccordionHeaderSkin;
         };
         StyleManager.setStyleDeclaration("CanvasButtonAccordionHeader",selector,false);
      }
      
      override public function get data() : Object
      {
         return this._data;
      }
      
      override public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         invalidateDisplayList();
      }
      
      override protected function initializeAccessibility() : void
      {
         if(CanvasButtonAccordionHeader.createAccessibilityImplementation != null)
         {
            CanvasButtonAccordionHeader.createAccessibilityImplementation(this);
         }
      }
      
      override protected function createChildren() : void
      {
         var _loc2_:Number = NaN;
         super.createChildren();
         var _loc1_:CSSStyleDeclaration = StyleManager.getStyleDeclaration(className);
         if(_loc1_)
         {
            _loc2_ = _loc1_.getStyle("paddingLeft");
            if(!isNaN(_loc2_))
            {
               setStyle("paddingLeft",_loc2_);
            }
            _loc2_ = _loc1_.getStyle("paddingRight");
            if(!isNaN(_loc2_))
            {
               setStyle("paddingRight",_loc2_);
            }
         }
      }
      
      override public function drawFocus(param1:Boolean) : void
      {
         var _loc2_:Class = null;
         var _loc3_:ISimpleStyleClient = null;
         if(param1 && !mx_internal::isEffectStarted)
         {
            if(!this.focusObj)
            {
               _loc2_ = getStyle("focusSkin");
               this.focusObj = new _loc2_();
               _loc3_ = this.focusObj as ISimpleStyleClient;
               if(_loc3_)
               {
                  _loc3_.styleName = this;
               }
               addChild(this.focusObj);
               this.focusSkin = this.focusObj as IFlexDisplayObject;
            }
            if(this.focusSkin)
            {
               this.focusSkin.move(0,0);
               this.focusSkin.setActualSize(unscaledWidth,unscaledHeight);
            }
            this.focusObj.visible = true;
            dispatchEvent(new Event("focusDraw"));
         }
         else if(this.focusObj)
         {
            this.focusObj.visible = false;
         }
      }
      
      override mx_internal function layoutContents(param1:Number, param2:Number, param3:Boolean) : void
      {
         super.layoutContents(param1,param2,param3);
         if(this.focusObj)
         {
            setChildIndex(this.focusObj,numChildren - 1);
         }
      }
      
      override protected function rollOverHandler(param1:MouseEvent) : void
      {
         super.rollOverHandler(param1);
         var _loc2_:Container = Container(parent);
         if(_loc2_.enabled)
         {
            _loc2_.rawChildren.setChildIndex(this,_loc2_.rawChildren.numChildren - 1);
         }
      }
   }
}
