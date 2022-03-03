package anifire.assets.control
{
   import flash.filters.GlowFilter;
   import flash.utils.Proxy;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class AssetResizeToolTip extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _3175821glow:GlowFilter;
      
      private var _104h:Label;
      
      private var _119w:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function AssetResizeToolTip()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":50,
                  "height":30,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Label,
                     "id":"w",
                     "stylesFactory":function():void
                     {
                        this.color = 0;
                        this.fontSize = 10;
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"h",
                     "stylesFactory":function():void
                     {
                        this.color = 0;
                        this.fontSize = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {"y":15};
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
         var bindings:Array = this._AssetResizeToolTip_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_assets_control_AssetResizeToolTipWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return AssetResizeToolTip[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 50;
         this.height = 30;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this._AssetResizeToolTip_GlowFilter1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         AssetResizeToolTip._watcherSetupUtil = param1;
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
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this.w.text = "W:" + param1.toFixed(0);
         this.h.text = "H:" + param2.toFixed(0);
      }
      
      private function _AssetResizeToolTip_GlowFilter1_i() : GlowFilter
      {
         var _loc1_:GlowFilter = new GlowFilter();
         _loc1_.blurX = 2;
         _loc1_.blurY = 2;
         _loc1_.color = 16777215;
         _loc1_.strength = 10;
         this.glow = _loc1_;
         BindingManager.executeBindings(this,"glow",this.glow);
         return _loc1_;
      }
      
      private function _AssetResizeToolTip_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Array
         {
            var _loc1_:* = [glow];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"w.filters");
         result[1] = new Binding(this,function():Array
         {
            var _loc1_:* = [glow];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"h.filters");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get glow() : GlowFilter
      {
         return this._3175821glow;
      }
      
      public function set glow(param1:GlowFilter) : void
      {
         var _loc2_:Object = this._3175821glow;
         if(_loc2_ !== param1)
         {
            this._3175821glow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"glow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get h() : Label
      {
         return this._104h;
      }
      
      public function set h(param1:Label) : void
      {
         var _loc2_:Object = this._104h;
         if(_loc2_ !== param1)
         {
            this._104h = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"h",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get w() : Label
      {
         return this._119w;
      }
      
      public function set w(param1:Label) : void
      {
         var _loc2_:Object = this._119w;
         if(_loc2_ !== param1)
         {
            this._119w = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"w",_loc2_,param1));
            }
         }
      }
   }
}
