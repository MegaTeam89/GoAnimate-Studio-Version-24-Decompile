package anifire.components.containers
{
   import anifire.constant.ServerConstants;
   import anifire.font.FontChooser;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class HyperLinkWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _HyperLinkWindow_Label1:Label;
      
      public var _HyperLinkWindow_Label2:Label;
      
      private var _1370988937_btnCancel:Button;
      
      private var _937875327_btnRemove:Button;
      
      private var _1730556742_btnSave:Button;
      
      private var _1098683047hostURL:Label;
      
      private var _859623201txtURL:TextInput;
      
      private var _1855272044txtURLBox:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _url:String;
      
      private var _host:String = "";
      
      private var _parent:FontChooser;
      
      private var DEFAULT_URL:String;
      
      private var _1679324957txtURLReal:TextInput;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function HyperLinkWindow()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "events":{"creationComplete":"___HyperLinkWindow_TitleWindow1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":495,
                  "height":255,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "stylesFactory":function():void
                     {
                        this.backgroundSize = "100%";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"popupLinkWindow"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentHeight":100,
                           "percentWidth":100,
                           "left":10,
                           "top":10,
                           "right":10,
                           "bottom":30,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":HBox,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Canvas,
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "height":62,
                                             "width":62,
                                             "styleName":"iconLink"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_HyperLinkWindow_Label1",
                                       "stylesFactory":function():void
                                       {
                                          this.fontSize = 24;
                                          this.color = 869988;
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"height":20};
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_HyperLinkWindow_Label2",
                              "stylesFactory":function():void
                              {
                                 this.color = 0;
                                 this.fontSize = 14;
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "top":20,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"hostURL",
                                       "stylesFactory":function():void
                                       {
                                          this.fontSize = 14;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":10,
                                             "y":5,
                                             "height":26
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":TextInput,
                                       "id":"txtURL",
                                       "events":{"change":"__txtURL_change"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":180,
                                             "height":32,
                                             "maxChars":99,
                                             "restrict":"a-z A-Z 0-9 _~\\-/"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":TextInput,
                                       "id":"txtURLBox",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":10,
                                             "width":400,
                                             "height":32,
                                             "maxChars":256,
                                             "visible":false
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnRemove",
                                       "events":{"click":"___btnRemove_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "y":6,
                                             "styleName":"btnLinkRemove",
                                             "buttonMode":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HBox,
                              "stylesFactory":function():void
                              {
                                 this.horizontalAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnSave",
                                       "events":{"click":"___btnSave_click"},
                                       "stylesFactory":function():void
                                       {
                                          this.fontSize = 16;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnOringe",
                                             "width":95,
                                             "height":30,
                                             "buttonMode":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnCancel",
                                       "events":{"click":"___btnCancel_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnBlack",
                                             "width":95,
                                             "height":30,
                                             "buttonMode":true
                                          };
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
         this.DEFAULT_URL = UtilDict.toDisplay("go","hlwin_default");
         this._1679324957txtURLReal = this.txtURL;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._HyperLinkWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_HyperLinkWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return HyperLinkWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.layout = "absolute";
         this.width = 495;
         this.height = 255;
         this.styleName = "popupWindow";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___HyperLinkWindow_TitleWindow1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         HyperLinkWindow._watcherSetupUtil = param1;
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
      
      private function init() : void
      {
         this._host = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER);
         this.txtURL.addEventListener(TextEvent.TEXT_INPUT,function(param1:TextEvent):void
         {
            if(param1.text.indexOf(_host) == 0)
            {
               txtURL.text = param1.text.substr(_host.length);
               param1.preventDefault();
            }
         },true);
         this.txtURL.visible = !(this.txtURLBox.visible = UtilLicense.isBoxEnvironment());
         this.txtURLReal = !!UtilLicense.isBoxEnvironment() ? this.txtURLBox : this.txtURL;
         if(this._url == null)
         {
            this._url = this.DEFAULT_URL;
         }
         this.txtURLReal.text = this._url;
         this.hostURL.text = this._host;
         this.refreshInputStyle();
      }
      
      private function refreshInputStyle() : void
      {
         if(this._url != "" && this._url != null && this._url != this.DEFAULT_URL)
         {
            this._btnRemove.visible = true;
            this.txtURL.setStyle("fontSize","14");
            this.txtURL.setStyle("borderStyle","solid");
            this.txtURL.setStyle("borderColor","0xFF7800");
            this.txtURL.setStyle("borderThickness","4");
         }
         else
         {
            this._btnRemove.visible = false;
            this.txtURL.setStyle("fontSize","14");
            this.txtURL.setStyle("borderStyle","solid");
            this.txtURL.setStyle("borderColor","0x666666");
            this.txtURL.setStyle("borderThickness","4");
         }
      }
      
      public function set fontchooser(param1:FontChooser) : void
      {
         this._parent = param1;
      }
      
      public function set url(param1:String) : void
      {
         if(param1 != "" && param1 != null)
         {
            this._url = param1;
            this.txtURL.text = this._url;
            this.refreshInputStyle();
         }
      }
      
      public function updateURL() : void
      {
         var _loc1_:Boolean = UtilLicense.isBoxEnvironment();
         var _loc2_:TextInput = !!_loc1_ ? this.txtURLBox : this.txtURL;
         if(_loc1_ && this.txtURLBox.text.indexOf(UtilLicense.boxParentSiteBaseURL) < 0)
         {
            Alert.show("You are not allowed to embed external links");
            return;
         }
         if(_loc2_.text != this.DEFAULT_URL)
         {
            this._parent.url = _loc2_.text;
         }
         this.close();
      }
      
      private function close() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function refreshURL() : void
      {
      }
      
      private function reset() : void
      {
         this._url = "";
         this._parent.url = "";
         this.close();
      }
      
      public function ___HyperLinkWindow_TitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function __txtURL_change(param1:Event) : void
      {
         this.refreshURL();
      }
      
      public function ___btnRemove_click(param1:MouseEvent) : void
      {
         this.reset();
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.updateURL();
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function _HyperLinkWindow_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","hlwin_title");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_HyperLinkWindow_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","hlwin_subtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_HyperLinkWindow_Label2.text");
         result[2] = new Binding(this,function():Number
         {
            return hostURL.x + hostURL.width;
         },null,"txtURL.x");
         result[3] = new Binding(this,function():Number
         {
            return txtURLReal.x + txtURLReal.width - _btnRemove.width - 5;
         },null,"_btnRemove.x");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","hlwin_save");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSave.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","hlwin_cancel");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCancel.label");
         return result;
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
      public function get _btnRemove() : Button
      {
         return this._937875327_btnRemove;
      }
      
      public function set _btnRemove(param1:Button) : void
      {
         var _loc2_:Object = this._937875327_btnRemove;
         if(_loc2_ !== param1)
         {
            this._937875327_btnRemove = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRemove",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSave() : Button
      {
         return this._1730556742_btnSave;
      }
      
      public function set _btnSave(param1:Button) : void
      {
         var _loc2_:Object = this._1730556742_btnSave;
         if(_loc2_ !== param1)
         {
            this._1730556742_btnSave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get hostURL() : Label
      {
         return this._1098683047hostURL;
      }
      
      public function set hostURL(param1:Label) : void
      {
         var _loc2_:Object = this._1098683047hostURL;
         if(_loc2_ !== param1)
         {
            this._1098683047hostURL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hostURL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtURL() : TextInput
      {
         return this._859623201txtURL;
      }
      
      public function set txtURL(param1:TextInput) : void
      {
         var _loc2_:Object = this._859623201txtURL;
         if(_loc2_ !== param1)
         {
            this._859623201txtURL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtURL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtURLBox() : TextInput
      {
         return this._1855272044txtURLBox;
      }
      
      public function set txtURLBox(param1:TextInput) : void
      {
         var _loc2_:Object = this._1855272044txtURLBox;
         if(_loc2_ !== param1)
         {
            this._1855272044txtURLBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtURLBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get txtURLReal() : TextInput
      {
         return this._1679324957txtURLReal;
      }
      
      private function set txtURLReal(param1:TextInput) : void
      {
         var _loc2_:Object = this._1679324957txtURLReal;
         if(_loc2_ !== param1)
         {
            this._1679324957txtURLReal = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtURLReal",_loc2_,param1));
            }
         }
      }
   }
}
