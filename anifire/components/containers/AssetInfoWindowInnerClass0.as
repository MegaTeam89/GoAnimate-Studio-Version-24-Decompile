package anifire.components.containers
{
   import anifire.util.UtilDict;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.HBox;
   import mx.controls.Label;
   import mx.controls.LinkButton;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class AssetInfoWindowInnerClass0 extends HBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _AssetInfoWindowInnerClass0_Label1:Label;
      
      private var _2929478_def:LinkButton;
      
      private var _2929484_del:LinkButton;
      
      private var _88844982outerDocument:AssetInfoWindow;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function AssetInfoWindowInnerClass0()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Label,
                  "id":"_AssetInfoWindowInnerClass0_Label1",
                  "stylesFactory":function():void
                  {
                     this.fontSize = 12;
                     this.textAlign = "left";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"width":180};
                  }
               }),new UIComponentDescriptor({
                  "type":LinkButton,
                  "id":"_def",
                  "events":{"click":"___def_click"},
                  "stylesFactory":function():void
                  {
                     this.color = 255;
                     this.fontSize = 11;
                  }
               }),new UIComponentDescriptor({
                  "type":LinkButton,
                  "id":"_del",
                  "events":{"click":"___del_click"},
                  "stylesFactory":function():void
                  {
                     this.color = 255;
                     this.fontSize = 11;
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._AssetInfoWindowInnerClass0_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_AssetInfoWindowInnerClass0WatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return AssetInfoWindowInnerClass0[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         AssetInfoWindowInnerClass0._watcherSetupUtil = param1;
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
      
      public function ___def_click(param1:MouseEvent) : void
      {
         data.defaultFunction(data.id);
      }
      
      public function ___del_click(param1:MouseEvent) : void
      {
         data.deleteFunction(data.id);
      }
      
      private function _AssetInfoWindowInnerClass0_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = data.name;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetInfoWindowInnerClass0_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_default");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_def.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = data.id;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_def.name");
         result[3] = new Binding(this,function():Boolean
         {
            return data.notDefault;
         },null,"_def.visible");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_delete");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_del.label");
         result[5] = new Binding(this,function():Boolean
         {
            return data.notDefault;
         },null,"_del.visible");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _def() : LinkButton
      {
         return this._2929478_def;
      }
      
      public function set _def(param1:LinkButton) : void
      {
         var _loc2_:Object = this._2929478_def;
         if(_loc2_ !== param1)
         {
            this._2929478_def = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_def",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _del() : LinkButton
      {
         return this._2929484_del;
      }
      
      public function set _del(param1:LinkButton) : void
      {
         var _loc2_:Object = this._2929484_del;
         if(_loc2_ !== param1)
         {
            this._2929484_del = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_del",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get outerDocument() : AssetInfoWindow
      {
         return this._88844982outerDocument;
      }
      
      public function set outerDocument(param1:AssetInfoWindow) : void
      {
         var _loc2_:Object = this._88844982outerDocument;
         if(_loc2_ !== param1)
         {
            this._88844982outerDocument = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"outerDocument",_loc2_,param1));
            }
         }
      }
   }
}
