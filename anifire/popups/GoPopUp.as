package anifire.popups
{
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class GoPopUp extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1370988937_btnCancel:Button;
      
      private var _1481128871_btnOk:Button;
      
      private var _985212102_content:Text;
      
      private var _1464826535_title:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _autoClose:Boolean = true;
      
      public var ref:String = "";
      
      mx_internal var _GoPopUp_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function GoPopUp()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                     this.verticalAlign = "middle";
                     this.verticalGap = 20;
                     this.backgroundColor = 2829099;
                     this.cornerRadius = 10;
                     this.borderColor = 2829099;
                     this.borderStyle = "solid";
                     this.paddingTop = 20;
                     this.paddingBottom = 20;
                     this.paddingLeft = 20;
                     this.paddingRight = 20;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Text,
                           "id":"_title",
                           "stylesFactory":function():void
                           {
                              this.color = 16777215;
                              this.textAlign = "center";
                              this.fontSize = 18;
                              this.fontWeight = "bold";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"_content",
                           "stylesFactory":function():void
                           {
                              this.color = 16777215;
                              this.textAlign = "center";
                              this.fontSize = 18;
                              this.fontWeight = "bold";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 20;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"_btnOk",
                                 "events":{"click":"___btnOk_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "minWidth":100,
                                       "buttonMode":true,
                                       "styleName":"btnOk"
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"_btnCancel",
                                 "events":{"click":"___btnCancel_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "minWidth":100,
                                       "buttonMode":true,
                                       "styleName":"btnCancel"
                                    };
                                 }
                              })]};
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
         var bindings:Array = this._GoPopUp_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_popups_GoPopUpWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return GoPopUp[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         GoPopUp._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_GoPopUp_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set autoClose(param1:Boolean) : void
      {
         this._autoClose = param1;
      }
      
      private function onOkClick() : void
      {
         if(this._autoClose)
         {
            PopUpManager.removePopUp(this);
         }
         this.dispatchEvent(new Event("okClick"));
      }
      
      private function onCancelClick() : void
      {
         if(this._autoClose)
         {
            PopUpManager.removePopUp(this);
         }
         this.dispatchEvent(new Event("cancelClick"));
      }
      
      public function set text(param1:String) : void
      {
         this._content.text = param1;
      }
      
      public function set title(param1:String) : void
      {
         this._title.text = param1;
         this._title.visible = this._title.includeInLayout = param1 != "";
      }
      
      public function set btnOkVisible(param1:Boolean) : void
      {
         this._btnOk.visible = this._btnOk.includeInLayout = param1;
      }
      
      public function set btnCancelVisible(param1:Boolean) : void
      {
         this._btnCancel.visible = this._btnCancel.includeInLayout = param1;
      }
      
      public function set okText(param1:String) : void
      {
         this._btnOk.label = param1;
      }
      
      public function set cancelText(param1:String) : void
      {
         this._btnCancel.label = param1;
      }
      
      public function ___btnOk_click(param1:MouseEvent) : void
      {
         this.onOkClick();
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.onCancelClick();
      }
      
      private function _GoPopUp_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","OK");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnOk.label");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Cancel");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCancel.label");
         return result;
      }
      
      mx_internal function _GoPopUp_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_GoPopUp_StylesInit_done)
         {
            return;
         }
         mx_internal::_GoPopUp_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".btnOk");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnOk",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.borderColor = 13395456;
               this.color = 16777215;
               this.cornerRadius = 5;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontSize = 20;
               this.fillColors = [16737792,16737792,16737792,16737792];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 16737792;
               this.textSelectedColor = 16777215;
            };
         }
         style = styleManager.getStyleDeclaration(".btnCancel");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnCancel",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.borderColor = 8947848;
               this.color = 16777215;
               this.cornerRadius = 5;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontSize = 20;
               this.fillColors = [8947848,8947848,8947848,8947848];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 8947848;
               this.textSelectedColor = 16777215;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCancel() : Button
      {
         return this._1370988937_btnCancel;
      }
      
      public function set _btnCancel(param1:Button) : void
      {
         var _loc2_:Object = this._1370988937_btnCancel;
         if(_loc2_ !== param1)
         {
            this._1370988937_btnCancel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCancel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnOk() : Button
      {
         return this._1481128871_btnOk;
      }
      
      public function set _btnOk(param1:Button) : void
      {
         var _loc2_:Object = this._1481128871_btnOk;
         if(_loc2_ !== param1)
         {
            this._1481128871_btnOk = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnOk",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _content() : Text
      {
         return this._985212102_content;
      }
      
      public function set _content(param1:Text) : void
      {
         var _loc2_:Object = this._985212102_content;
         if(_loc2_ !== param1)
         {
            this._985212102_content = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_content",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _title() : Text
      {
         return this._1464826535_title;
      }
      
      public function set _title(param1:Text) : void
      {
         var _loc2_:Object = this._1464826535_title;
         if(_loc2_ !== param1)
         {
            this._1464826535_title = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_title",_loc2_,param1));
            }
         }
      }
   }
}
