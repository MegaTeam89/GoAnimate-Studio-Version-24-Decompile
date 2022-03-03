package anifire.components.studio
{
   import anifire.core.Prop;
   import anifire.util.UtilDict;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   
   public class PropStatePanel extends Canvas
   {
       
      
      private var _2097344405btnState:Button;
      
      private var _241989645statePanel:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _91184194_prop:Prop;
      
      public function PropStatePanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"statePanel",
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"btnState",
                        "events":{"click":"__btnState_click"},
                        "propertiesFactory":function():Object
                        {
                           return {
                              "labelPlacement":"left",
                              "width":150,
                              "buttonMode":true,
                              "styleName":"btnMenuSidePanel"
                           };
                        }
                     })]};
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
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
      
      public function set target(param1:Object) : void
      {
         if(param1)
         {
            if(param1 is Prop)
            {
               this._prop = Prop(param1);
            }
            else
            {
               this._prop = null;
            }
         }
         else
         {
            this._prop = null;
         }
         this.updateStatePanel();
      }
      
      private function updateStatePanel() : void
      {
         if(this._prop && this._prop.state)
         {
            this.btnState.label = UtilDict.toDisplay("store",Prop(this._prop).state.name);
         }
      }
      
      private function onStateMenuClick(param1:MenuEvent) : void
      {
         this.btnState.label = param1.item.@label;
      }
      
      private function showStateMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(this._prop)
         {
            _loc2_ = this.btnState.localToGlobal(new Point(this.btnState.x,this.btnState.y + this.btnState.height));
            _loc3_ = this._prop.stateMenu;
            _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onStateMenuClick);
            _loc3_.show(_loc2_.x,_loc2_.y);
         }
      }
      
      public function __btnState_click(param1:MouseEvent) : void
      {
         this.showStateMenu(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get btnState() : Button
      {
         return this._2097344405btnState;
      }
      
      public function set btnState(param1:Button) : void
      {
         var _loc2_:Object = this._2097344405btnState;
         if(_loc2_ !== param1)
         {
            this._2097344405btnState = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnState",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get statePanel() : VBox
      {
         return this._241989645statePanel;
      }
      
      public function set statePanel(param1:VBox) : void
      {
         var _loc2_:Object = this._241989645statePanel;
         if(_loc2_ !== param1)
         {
            this._241989645statePanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statePanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _prop() : Prop
      {
         return this._91184194_prop;
      }
      
      private function set _prop(param1:Prop) : void
      {
         var _loc2_:Object = this._91184194_prop;
         if(_loc2_ !== param1)
         {
            this._91184194_prop = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_prop",_loc2_,param1));
            }
         }
      }
   }
}
