package anifire.components.studio
{
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Move;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class OverTray extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1491038559_effectMove:Move;
      
      private var _1468764923_panel:Canvas;
      
      private var _94886_pw:PropertiesWindow;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function OverTray()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":310,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_panel",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":-320,
                                    "percentHeight":100,
                                    "width":310,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":PropertiesWindow,
                                       "id":"_pw",
                                       "propertiesFactory":function():Object
                                       {
                                          return {"width":310};
                                       }
                                    })]
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
         var bindings:Array = this._OverTray_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_OverTrayWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return OverTray[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 310;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.cacheAsBitmap = true;
         this._OverTray_Move1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         OverTray._watcherSetupUtil = param1;
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
      
      public function get propertiesWindow() : PropertiesWindow
      {
         return this._pw;
      }
      
      public function open(param1:Object = null) : void
      {
         this._effectMove.stop();
         this._effectMove.xTo = 0;
         this._effectMove.play();
         this._pw.show(param1);
         this._pw.active = true;
      }
      
      public function close(param1:Event = null) : void
      {
         this._effectMove.stop();
         this._effectMove.xTo = -320;
         this._effectMove.play();
         if(this._pw.active)
         {
            this._pw.hide();
            this._pw.active = false;
         }
      }
      
      private function _OverTray_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         _loc1_.duration = 500;
         this._effectMove = _loc1_;
         BindingManager.executeBindings(this,"_effectMove",this._effectMove);
         return _loc1_;
      }
      
      private function _OverTray_bindingsSetup() : Array
      {
         var _loc1_:Array = [];
         _loc1_[0] = new Binding(this,null,null,"_effectMove.target","_panel");
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectMove() : Move
      {
         return this._1491038559_effectMove;
      }
      
      public function set _effectMove(param1:Move) : void
      {
         var _loc2_:Object = this._1491038559_effectMove;
         if(_loc2_ !== param1)
         {
            this._1491038559_effectMove = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectMove",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _panel() : Canvas
      {
         return this._1468764923_panel;
      }
      
      public function set _panel(param1:Canvas) : void
      {
         var _loc2_:Object = this._1468764923_panel;
         if(_loc2_ !== param1)
         {
            this._1468764923_panel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_panel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _pw() : PropertiesWindow
      {
         return this._94886_pw;
      }
      
      public function set _pw(param1:PropertiesWindow) : void
      {
         var _loc2_:Object = this._94886_pw;
         if(_loc2_ !== param1)
         {
            this._94886_pw = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pw",_loc2_,param1));
            }
         }
      }
   }
}
