package anifire.components.studio
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.TitleWindow;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.List;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class BubbleMsgChooser extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _2044384006_btnCloseTop:Button;
      
      private var _1065050336msgArr:ArrayCollection;
      
      private var _1283634532msg_list:List;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var bubbleMsgChooserItems:Array;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function BubbleMsgChooser()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {
                  "width":434,
                  "height":316,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"bubbleMsgWindowBackground",
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "text":"Pick a Happy Bunny Quote",
                                    "styleName":"bubbleMsgWindowTitle",
                                    "x":31,
                                    "y":27
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":List,
                              "id":"msg_list",
                              "events":{"change":"__msg_list_change"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":370,
                                    "height":230,
                                    "styleName":"bubbleMsgWindowList",
                                    "variableRowHeight":true,
                                    "wordWrap":true,
                                    "x":31,
                                    "y":52,
                                    "itemRenderer":_BubbleMsgChooser_ClassFactory1_c()
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_btnCloseTop",
                              "events":{"click":"___btnCloseTop_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "right":22,
                                    "y":14,
                                    "styleName":"btnbubbleMsgWindowClose",
                                    "buttonMode":true
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._BubbleMsgChooser_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_BubbleMsgChooserWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return BubbleMsgChooser[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.layout = "absolute";
         this.width = 434;
         this.height = 316;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.styleName = "bubbleMsgWindow";
         this._BubbleMsgChooser_ArrayCollection1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         BubbleMsgChooser._watcherSetupUtil = param1;
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
      
      public function init(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc3_:BubbleMsgChooserItem = null;
         this.bubbleMsgChooserItems = param1;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = _loc3_.msg;
            this.msgArr.addItem(_loc3_);
            _loc4_++;
         }
      }
      
      private function onListChanged(param1:Event) : void
      {
         var _loc2_:BubbleMsgChooserItem = this.msg_list.selectedItem as BubbleMsgChooserItem;
         var _loc3_:BubbleMsgEvent = new BubbleMsgEvent(BubbleMsgEvent.ITEM_CHOOSEN,this);
         _loc3_.bubbleMsgItem = _loc2_;
         this.dispatchEvent(_loc3_);
      }
      
      public function closeWindow() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function _BubbleMsgChooser_ArrayCollection1_i() : ArrayCollection
      {
         var _loc1_:ArrayCollection = new ArrayCollection();
         _loc1_.initialized(this,"msgArr");
         this.msgArr = _loc1_;
         BindingManager.executeBindings(this,"msgArr",this.msgArr);
         return _loc1_;
      }
      
      private function _BubbleMsgChooser_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = BubbleMsgItemRenderer;
         return _loc1_;
      }
      
      public function __msg_list_change(param1:ListEvent) : void
      {
         this.onListChanged(param1);
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.closeWindow();
      }
      
      private function _BubbleMsgChooser_bindingsSetup() : Array
      {
         var _loc1_:Array = [];
         _loc1_[0] = new Binding(this,null,null,"msg_list.dataProvider","msgArr");
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : Button
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _btnCloseTop(param1:Button) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get msgArr() : ArrayCollection
      {
         return this._1065050336msgArr;
      }
      
      public function set msgArr(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1065050336msgArr;
         if(_loc2_ !== param1)
         {
            this._1065050336msgArr = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"msgArr",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get msg_list() : List
      {
         return this._1283634532msg_list;
      }
      
      public function set msg_list(param1:List) : void
      {
         var _loc2_:Object = this._1283634532msg_list;
         if(_loc2_ !== param1)
         {
            this._1283634532msg_list = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"msg_list",_loc2_,param1));
            }
         }
      }
   }
}
