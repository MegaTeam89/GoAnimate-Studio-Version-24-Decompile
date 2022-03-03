package anifire.font
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import mx.binding.BindingManager;
   import mx.containers.Canvas;
   import mx.containers.Tile;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class GoPalette extends Canvas
   {
       
      
      private var _592831722innerShadow:DropShadowFilter;
      
      private var _3560110tile:Tile;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _colors:Array;
      
      private var _selectedColor:uint;
      
      public function GoPalette()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___GoPalette_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Tile,
                  "id":"tile",
                  "stylesFactory":function():void
                  {
                     this.horizontalGap = 4;
                     this.verticalGap = 4;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "direction":"horizontal",
                        "percentWidth":100,
                        "height":20
                     };
                  }
               })]};
            }
         });
         this._colors = [0,16777215,4473924,8947848,13421772,13395456,10066431,16737996,16777062,6636321];
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this._GoPalette_DropShadowFilter1_i();
         this.addEventListener("creationComplete",this.___GoPalette_Canvas1_creationComplete);
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
      
      public function get selectedColor() : uint
      {
         return this._selectedColor;
      }
      
      private function onColorClick(param1:Event) : void
      {
         this._selectedColor = param1.target.name;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function init(param1:Array) : void
      {
         var _loc2_:Canvas = null;
         this.tile.removeAllChildren();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new Canvas();
            _loc2_.graphics.beginFill(param1[_loc3_]);
            _loc2_.graphics.drawRoundRect(1,1,18,18,4,4);
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.CLICK,this.onColorClick);
            _loc2_.width = 18;
            _loc2_.height = 18;
            _loc2_.name = param1[_loc3_];
            _loc2_.filters = [this.innerShadow];
            this.tile.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function _GoPalette_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.inner = true;
         _loc1_.distance = 0.5;
         _loc1_.alpha = 0.5;
         _loc1_.blurX = 1;
         _loc1_.blurY = 1;
         this.innerShadow = _loc1_;
         BindingManager.executeBindings(this,"innerShadow",this.innerShadow);
         return _loc1_;
      }
      
      public function ___GoPalette_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get innerShadow() : DropShadowFilter
      {
         return this._592831722innerShadow;
      }
      
      public function set innerShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._592831722innerShadow;
         if(_loc2_ !== param1)
         {
            this._592831722innerShadow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"innerShadow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get tile() : Tile
      {
         return this._3560110tile;
      }
      
      public function set tile(param1:Tile) : void
      {
         var _loc2_:Object = this._3560110tile;
         if(_loc2_ !== param1)
         {
            this._3560110tile = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tile",_loc2_,param1));
            }
         }
      }
   }
}
