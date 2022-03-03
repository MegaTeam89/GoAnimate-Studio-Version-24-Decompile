package anifire.components.studio
{
   import anifire.command.CommandStack;
   import anifire.component.IconTextButton;
   import anifire.core.Console;
   import anifire.managers.StudioManager;
   import anifire.util.UtilDict;
   import anifire.util.UtilSite;
   import anifire.util.UtilSystem;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.controls.Menu;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.states.SetProperty;
   import mx.states.State;
   
   use namespace mx_internal;
   
   public class GoToolBar extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _GoToolBar_Button1:Button;
      
      public var _GoToolBar_Button2:Button;
      
      public var _GoToolBar_Button3:Button;
      
      public var _GoToolBar_SetProperty1:SetProperty;
      
      public var _GoToolBar_SetProperty2:SetProperty;
      
      public var _GoToolBar_SetProperty3:SetProperty;
      
      public var _GoToolBar_SetProperty4:SetProperty;
      
      private var _1731020110_btnCopy:IconTextButton;
      
      private var _1452717514_btnHistoryMenu:IconTextButton;
      
      private var _2110424330_btnPaste:IconTextButton;
      
      private var _1730583237_btnRedo:IconTextButton;
      
      private var _1730485215_btnUndo:IconTextButton;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function GoToolBar()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___GoToolBar_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "middle";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"topControlBar",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":IconTextButton,
                           "id":"_btnCopy",
                           "events":{"mouseUp":"___btnCopy_mouseUp"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnCopy",
                                 "maxWidth":90,
                                 "buttonMode":true,
                                 "labelPlacement":"right"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":IconTextButton,
                           "id":"_btnPaste",
                           "events":{"mouseUp":"___btnPaste_mouseUp"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnPaste",
                                 "maxWidth":90,
                                 "buttonMode":true,
                                 "labelPlacement":"right"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":IconTextButton,
                           "id":"_btnUndo",
                           "events":{"click":"___btnUndo_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnUndo",
                                 "maxWidth":90,
                                 "buttonMode":true,
                                 "labelPlacement":"right",
                                 "enabled":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":IconTextButton,
                           "id":"_btnRedo",
                           "events":{"click":"___btnRedo_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnRedo",
                                 "maxWidth":90,
                                 "buttonMode":true,
                                 "labelPlacement":"right",
                                 "enabled":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":IconTextButton,
                           "id":"_btnHistoryMenu",
                           "events":{"click":"___btnHistoryMenu_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "buttonMode":true,
                                 "styleName":"btnMore"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_GoToolBar_Button1",
                           "events":{"click":"___GoToolBar_Button1_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "label":"get scene xml",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_GoToolBar_Button2",
                           "events":{"click":"___GoToolBar_Button2_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "label":"show Log",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_GoToolBar_Button3",
                           "events":{"click":"___GoToolBar_Button3_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "label":"test",
                                 "styleName":"btnTestStyle",
                                 "buttonMode":true
                              };
                           }
                        })]
                     };
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
         var bindings:Array = this._GoToolBar_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_GoToolBarWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return GoToolBar[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.states = [this._GoToolBar_State1_c(),this._GoToolBar_State2_c(),this._GoToolBar_State3_c()];
         this.addEventListener("creationComplete",this.___GoToolBar_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         GoToolBar._watcherSetupUtil = param1;
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
      
      private function onCreationComplete() : void
      {
         CommandStack.getInstance().addEventListener(Event.CHANGE,this.onCommandStackChange);
         if(UtilSystem.isMac)
         {
            this._btnCopy.toolTip = UtilDict.toDisplay("go","(Command + C)");
            this._btnPaste.toolTip = UtilDict.toDisplay("go","(Command + V)");
            this._btnUndo.toolTip = UtilDict.toDisplay("go","(Command + Z)");
            this._btnRedo.toolTip = UtilDict.toDisplay("go","(Command + Y)");
         }
      }
      
      private function onCommandStackChange(param1:Event) : void
      {
         this._btnUndo.enabled = CommandStack.getInstance().index > 0;
         this._btnRedo.enabled = CommandStack.getInstance().index < CommandStack.getInstance().size;
      }
      
      private function showHistoryMenu(param1:MouseEvent) : void
      {
         var _loc2_:Array = CommandStack.getInstance().stack;
         _loc2_.reverse();
         var _loc3_:Menu = Menu.createMenu(null,_loc2_,true);
         _loc3_.labelField = "_type";
         _loc3_.show(param1.stageX - 20,param1.stageY + 12);
      }
      
      private function showLog() : void
      {
         PopUpManager.createPopUp(this,LogWindow,true);
      }
      
      private function _GoToolBar_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "simple";
         return _loc1_;
      }
      
      private function _GoToolBar_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "cn";
         _loc1_.basedOn = "simple";
         _loc1_.overrides = [this._GoToolBar_SetProperty1_i(),this._GoToolBar_SetProperty2_i(),this._GoToolBar_SetProperty3_i(),this._GoToolBar_SetProperty4_i()];
         return _loc1_;
      }
      
      private function _GoToolBar_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         this._GoToolBar_SetProperty1 = _loc1_;
         BindingManager.executeBindings(this,"_GoToolBar_SetProperty1",this._GoToolBar_SetProperty1);
         return _loc1_;
      }
      
      private function _GoToolBar_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         this._GoToolBar_SetProperty2 = _loc1_;
         BindingManager.executeBindings(this,"_GoToolBar_SetProperty2",this._GoToolBar_SetProperty2);
         return _loc1_;
      }
      
      private function _GoToolBar_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         this._GoToolBar_SetProperty3 = _loc1_;
         BindingManager.executeBindings(this,"_GoToolBar_SetProperty3",this._GoToolBar_SetProperty3);
         return _loc1_;
      }
      
      private function _GoToolBar_SetProperty4_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         this._GoToolBar_SetProperty4 = _loc1_;
         BindingManager.executeBindings(this,"_GoToolBar_SetProperty4",this._GoToolBar_SetProperty4);
         return _loc1_;
      }
      
      private function _GoToolBar_State3_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "domo";
         _loc1_.basedOn = "cn";
         return _loc1_;
      }
      
      public function ___GoToolBar_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___btnCopy_mouseUp(param1:MouseEvent) : void
      {
         Console.getConsole().copyAsset();
      }
      
      public function ___btnPaste_mouseUp(param1:MouseEvent) : void
      {
         Console.getConsole().pasteAsset();
      }
      
      public function ___btnUndo_click(param1:MouseEvent) : void
      {
         StudioManager.instance.undo();
      }
      
      public function ___btnRedo_click(param1:MouseEvent) : void
      {
         StudioManager.instance.redo();
      }
      
      public function ___btnHistoryMenu_click(param1:MouseEvent) : void
      {
         this.showHistoryMenu(param1);
      }
      
      public function ___GoToolBar_Button1_click(param1:MouseEvent) : void
      {
         Console.getConsole().alertSceneXml();
      }
      
      public function ___GoToolBar_Button2_click(param1:MouseEvent) : void
      {
         this.showLog();
      }
      
      public function ___GoToolBar_Button3_click(param1:MouseEvent) : void
      {
         Console.getConsole().onTestButtonClick();
      }
      
      private function _GoToolBar_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","(Ctrl + C)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCopy.toolTip");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Copy");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCopy.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","(Ctrl + V)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnPaste.toolTip");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Paste");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnPaste.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","(Ctrl + Z)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnUndo.toolTip");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Undo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnUndo.label");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","(Ctrl + Y)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnRedo.toolTip");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Redo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnRedo.label");
         result[8] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_btnHistoryMenu.visible");
         result[9] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_btnHistoryMenu.includeInLayout");
         result[10] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_GoToolBar_Button1.visible");
         result[11] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_GoToolBar_Button1.includeInLayout");
         result[12] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_GoToolBar_Button2.visible");
         result[13] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_GoToolBar_Button2.includeInLayout");
         result[14] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_GoToolBar_Button3.visible");
         result[15] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_GoToolBar_Button3.includeInLayout");
         result[16] = new Binding(this,null,null,"_GoToolBar_SetProperty1.target","_btnCopy");
         result[17] = new Binding(this,null,null,"_GoToolBar_SetProperty2.target","_btnPaste");
         result[18] = new Binding(this,null,null,"_GoToolBar_SetProperty3.target","_btnUndo");
         result[19] = new Binding(this,null,null,"_GoToolBar_SetProperty4.target","_btnRedo");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopy() : IconTextButton
      {
         return this._1731020110_btnCopy;
      }
      
      public function set _btnCopy(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1731020110_btnCopy;
         if(_loc2_ !== param1)
         {
            this._1731020110_btnCopy = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopy",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnHistoryMenu() : IconTextButton
      {
         return this._1452717514_btnHistoryMenu;
      }
      
      public function set _btnHistoryMenu(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1452717514_btnHistoryMenu;
         if(_loc2_ !== param1)
         {
            this._1452717514_btnHistoryMenu = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnHistoryMenu",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPaste() : IconTextButton
      {
         return this._2110424330_btnPaste;
      }
      
      public function set _btnPaste(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2110424330_btnPaste;
         if(_loc2_ !== param1)
         {
            this._2110424330_btnPaste = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPaste",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRedo() : IconTextButton
      {
         return this._1730583237_btnRedo;
      }
      
      public function set _btnRedo(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1730583237_btnRedo;
         if(_loc2_ !== param1)
         {
            this._1730583237_btnRedo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRedo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnUndo() : IconTextButton
      {
         return this._1730485215_btnUndo;
      }
      
      public function set _btnUndo(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1730485215_btnUndo;
         if(_loc2_ !== param1)
         {
            this._1730485215_btnUndo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnUndo",_loc2_,param1));
            }
         }
      }
   }
}
