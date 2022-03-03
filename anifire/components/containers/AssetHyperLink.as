package anifire.components.containers
{
   import anifire.component.IconTextButton;
   import anifire.core.BubbleAsset;
   import anifire.util.UtilDict;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ValidationResultEvent;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class AssetHyperLink extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _538666691UrlValidator:HyperLinkValidator;
      
      public var _AssetHyperLink_SetProperty1:SetProperty;
      
      public var _AssetHyperLink_SetProperty2:SetProperty;
      
      public var _AssetHyperLink_SetProperty3:SetProperty;
      
      public var _AssetHyperLink_SetProperty4:SetProperty;
      
      public var _AssetHyperLink_Text2:Text;
      
      private var _937875327_btnRemove:Button;
      
      private var _205984886btnLink:IconTextButton;
      
      private var _611758404checkNewWin:CheckBox;
      
      private var _66491520mainContent:VBox;
      
      private var _110371416title:Text;
      
      private var _859623201txtURL:TextInput;
      
      private var _1080905391validateIcon:Button;
      
      private var _1198930449validateMessage:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var DEFAULT_URL:String;
      
      private var _bubbleAsset:BubbleAsset;
      
      private var _allowExternalLink:Boolean = false;
      
      mx_internal var _AssetHyperLink_StylesInit_done:Boolean = false;
      
      private var _embed_css_image_tick_png__1247982544_530417174:Class;
      
      private var _embed_css_image_cross_png_1485527203_1057591361:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function AssetHyperLink()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___AssetHyperLink_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":290,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"btnLink",
                     "events":{"click":"__btnLink_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "labelPlacement":"right",
                           "styleName":"btnBubbleLink",
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "id":"mainContent",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Text,
                              "id":"title",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":TextInput,
                                       "id":"txtURL",
                                       "events":{
                                          "focusIn":"__txtURL_focusIn",
                                          "focusOut":"__txtURL_focusOut",
                                          "textInput":"__txtURL_textInput",
                                          "change":"__txtURL_change"
                                       },
                                       "stylesFactory":function():void
                                       {
                                          this.color = 0;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentWidth":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnRemove",
                                       "events":{"click":"___btnRemove_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnLinkRemove",
                                             "right":4,
                                             "top":4,
                                             "buttonMode":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":CheckBox,
                                          "id":"checkNewWin",
                                          "events":{"click":"__checkNewWin_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {"buttonMode":true};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Text,
                                          "id":"_AssetHyperLink_Text2",
                                          "stylesFactory":function():void
                                          {
                                             this.fontSize = 12;
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "x":25,
                                                "y":2
                                             };
                                          }
                                       })]};
                                    }
                                 })]};
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"validateIcon"
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"validateMessage",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":25,
                                          "y":2
                                       };
                                    }
                                 })]};
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this.DEFAULT_URL = UtilDict.toDisplay("go","hlwin_default");
         this._embed_css_image_tick_png__1247982544_530417174 = _class_embed_css_image_tick_png__1247982544_530417174;
         this._embed_css_image_cross_png_1485527203_1057591361 = _class_embed_css_image_cross_png_1485527203_1057591361;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._AssetHyperLink_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_AssetHyperLinkWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return AssetHyperLink[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.width = 290;
         this.states = [this._AssetHyperLink_State1_c()];
         this._AssetHyperLink_HyperLinkValidator1_i();
         this.addEventListener("creationComplete",this.___AssetHyperLink_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         AssetHyperLink._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_AssetHyperLink_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onCreationComplete() : void
      {
         if(UtilUser.hasProFeatures)
         {
            this._allowExternalLink = true;
            this.DEFAULT_URL = "http://";
            this.title.text = UtilDict.toDisplay("go","Add a link to any website");
         }
         else
         {
            this.DEFAULT_URL = UtilSite.domainName;
            this.txtURL.maxChars = 99;
            this.title.text = UtilDict.toDisplay("go","Add a link to a GoAnimate page");
         }
      }
      
      public function set target(param1:Object) : void
      {
         var _loc2_:String = null;
         if(param1 is BubbleAsset)
         {
            this._bubbleAsset = param1 as BubbleAsset;
            _loc2_ = this._bubbleAsset.bubble.textURL;
            if(_loc2_ && _loc2_ != "")
            {
               this.currentState = "expand";
               if(_loc2_.indexOf("http") != 0)
               {
                  _loc2_ = UtilSite.domainName + _loc2_;
               }
               this.txtURL.text = _loc2_;
               if(this._bubbleAsset.bubble.islinkNewWin)
               {
                  this.checkNewWin.selected = true;
               }
               else
               {
                  this.checkNewWin.selected = false;
               }
            }
            else
            {
               this.currentState = "";
               this.txtURL.text = this.DEFAULT_URL;
            }
            this.validateMessage.text = "";
            this.validateIcon.visible = false;
         }
      }
      
      private function saveURL() : void
      {
         var _loc1_:String = this.txtURL.text;
         var _loc2_:ValidationResultEvent = this.UrlValidator.validate(_loc1_);
         if(_loc2_.results)
         {
            return;
         }
         if(_loc1_ == this.DEFAULT_URL)
         {
            _loc1_ = "";
         }
         if(_loc1_.length > 0 && _loc1_.indexOf("http") != 0)
         {
            _loc1_ = "http://" + _loc1_;
         }
         var _loc3_:RegExp = /(http:\/\/)?(\w*\.)?goanimate\.\w*\//;
         if(_loc1_.search(_loc3_) == 0)
         {
            _loc1_ = _loc1_.replace(_loc3_,"");
         }
         if(!this._allowExternalLink)
         {
            if(_loc1_.indexOf("http") == 0)
            {
               _loc1_ = _loc1_.substr(4);
            }
         }
         if(this._bubbleAsset)
         {
            this._bubbleAsset.bubble.textURL = _loc1_;
            this._bubbleAsset.bubble.islinkNewWin = this.checkNewWin.selected;
         }
      }
      
      private function reset() : void
      {
         if(this._bubbleAsset)
         {
            this._bubbleAsset.bubble.textURL = "";
         }
         this.txtURL.text = this.DEFAULT_URL;
         this.currentState = "";
         this.validateMessage.text = "";
         this.validateIcon.visible = false;
      }
      
      private function onUrlChange(param1:Event) : void
      {
         this.UrlValidator.validate(this.txtURL.text);
      }
      
      private function onUrlInput(param1:TextEvent) : void
      {
      }
      
      private function onUrlFocusIn(param1:Event) : void
      {
         if(!this._allowExternalLink)
         {
            this.txtURL.setSelection(0,this.txtURL.length);
         }
      }
      
      private function onUrlFocusOut(param1:Event) : void
      {
         this.saveURL();
      }
      
      private function onUrlInvalid(param1:ValidationResultEvent) : void
      {
         this.validateMessage.text = param1.message;
         this.validateMessage.styleName = "invalidMessageStyle";
         this.validateIcon.styleName = "invalidMessageStyle";
         this.validateIcon.visible = true;
      }
      
      private function onUrlValid(param1:ValidationResultEvent) : void
      {
         this.validateMessage.text = UtilDict.toDisplay("go","Your link looks all good!");
         this.validateMessage.styleName = "validMessageStyle";
         this.validateIcon.styleName = "validMessageStyle";
         this.validateIcon.visible = true;
      }
      
      private function onClickNewWin() : void
      {
         this.saveURL();
      }
      
      private function _AssetHyperLink_HyperLinkValidator1_i() : HyperLinkValidator
      {
         var _loc1_:HyperLinkValidator = new HyperLinkValidator();
         _loc1_.addEventListener("invalid",this.__UrlValidator_invalid);
         _loc1_.addEventListener("valid",this.__UrlValidator_valid);
         _loc1_.initialized(this,"UrlValidator");
         this.UrlValidator = _loc1_;
         BindingManager.executeBindings(this,"UrlValidator",this.UrlValidator);
         return _loc1_;
      }
      
      public function __UrlValidator_invalid(param1:ValidationResultEvent) : void
      {
         this.onUrlInvalid(param1);
      }
      
      public function __UrlValidator_valid(param1:ValidationResultEvent) : void
      {
         this.onUrlValid(param1);
      }
      
      private function _AssetHyperLink_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "expand";
         _loc1_.overrides = [this._AssetHyperLink_SetProperty1_i(),this._AssetHyperLink_SetProperty2_i(),this._AssetHyperLink_SetProperty3_i(),this._AssetHyperLink_SetProperty4_i()];
         return _loc1_;
      }
      
      private function _AssetHyperLink_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "visible";
         _loc1_.value = true;
         this._AssetHyperLink_SetProperty1 = _loc1_;
         BindingManager.executeBindings(this,"_AssetHyperLink_SetProperty1",this._AssetHyperLink_SetProperty1);
         return _loc1_;
      }
      
      private function _AssetHyperLink_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "includeInLayout";
         _loc1_.value = true;
         this._AssetHyperLink_SetProperty2 = _loc1_;
         BindingManager.executeBindings(this,"_AssetHyperLink_SetProperty2",this._AssetHyperLink_SetProperty2);
         return _loc1_;
      }
      
      private function _AssetHyperLink_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "visible";
         _loc1_.value = false;
         this._AssetHyperLink_SetProperty3 = _loc1_;
         BindingManager.executeBindings(this,"_AssetHyperLink_SetProperty3",this._AssetHyperLink_SetProperty3);
         return _loc1_;
      }
      
      private function _AssetHyperLink_SetProperty4_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "includeInLayout";
         _loc1_.value = false;
         this._AssetHyperLink_SetProperty4 = _loc1_;
         BindingManager.executeBindings(this,"_AssetHyperLink_SetProperty4",this._AssetHyperLink_SetProperty4);
         return _loc1_;
      }
      
      public function ___AssetHyperLink_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function __btnLink_click(param1:MouseEvent) : void
      {
         this.currentState = "expand";
      }
      
      public function __txtURL_focusIn(param1:FocusEvent) : void
      {
         this.onUrlFocusIn(param1);
      }
      
      public function __txtURL_focusOut(param1:FocusEvent) : void
      {
         this.onUrlFocusOut(param1);
      }
      
      public function __txtURL_textInput(param1:TextEvent) : void
      {
         this.onUrlInput(param1);
      }
      
      public function __txtURL_change(param1:Event) : void
      {
         this.onUrlChange(param1);
      }
      
      public function ___btnRemove_click(param1:MouseEvent) : void
      {
         this.reset();
      }
      
      public function __checkNewWin_click(param1:MouseEvent) : void
      {
         this.onClickNewWin();
      }
      
      private function _AssetHyperLink_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add link");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnLink.label");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","hlwin_subtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"title.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","open link in a new window");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetHyperLink_Text2.text");
         result[3] = new Binding(this,null,null,"_AssetHyperLink_SetProperty1.target","mainContent");
         result[4] = new Binding(this,null,null,"_AssetHyperLink_SetProperty2.target","mainContent");
         result[5] = new Binding(this,null,null,"_AssetHyperLink_SetProperty3.target","btnLink");
         result[6] = new Binding(this,null,null,"_AssetHyperLink_SetProperty4.target","btnLink");
         return result;
      }
      
      mx_internal function _AssetHyperLink_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_AssetHyperLink_StylesInit_done)
         {
            return;
         }
         mx_internal::_AssetHyperLink_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".validMessageStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".validMessageStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.upSkin = _embed_css_image_tick_png__1247982544_530417174;
               this.downSkin = _embed_css_image_tick_png__1247982544_530417174;
               this.overSkin = _embed_css_image_tick_png__1247982544_530417174;
               this.color = 32768;
               this.disabledSkin = _embed_css_image_tick_png__1247982544_530417174;
            };
         }
         style = styleManager.getStyleDeclaration(".invalidMessageStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".invalidMessageStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.upSkin = _embed_css_image_cross_png_1485527203_1057591361;
               this.downSkin = _embed_css_image_cross_png_1485527203_1057591361;
               this.overSkin = _embed_css_image_cross_png_1485527203_1057591361;
               this.color = 16711680;
               this.disabledSkin = _embed_css_image_cross_png_1485527203_1057591361;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get UrlValidator() : HyperLinkValidator
      {
         return this._538666691UrlValidator;
      }
      
      public function set UrlValidator(param1:HyperLinkValidator) : void
      {
         var _loc2_:Object = this._538666691UrlValidator;
         if(_loc2_ !== param1)
         {
            this._538666691UrlValidator = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"UrlValidator",_loc2_,param1));
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
      public function get btnLink() : IconTextButton
      {
         return this._205984886btnLink;
      }
      
      public function set btnLink(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._205984886btnLink;
         if(_loc2_ !== param1)
         {
            this._205984886btnLink = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnLink",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get checkNewWin() : CheckBox
      {
         return this._611758404checkNewWin;
      }
      
      public function set checkNewWin(param1:CheckBox) : void
      {
         var _loc2_:Object = this._611758404checkNewWin;
         if(_loc2_ !== param1)
         {
            this._611758404checkNewWin = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"checkNewWin",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainContent() : VBox
      {
         return this._66491520mainContent;
      }
      
      public function set mainContent(param1:VBox) : void
      {
         var _loc2_:Object = this._66491520mainContent;
         if(_loc2_ !== param1)
         {
            this._66491520mainContent = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainContent",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get title() : Text
      {
         return this._110371416title;
      }
      
      public function set title(param1:Text) : void
      {
         var _loc2_:Object = this._110371416title;
         if(_loc2_ !== param1)
         {
            this._110371416title = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"title",_loc2_,param1));
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
      public function get validateIcon() : Button
      {
         return this._1080905391validateIcon;
      }
      
      public function set validateIcon(param1:Button) : void
      {
         var _loc2_:Object = this._1080905391validateIcon;
         if(_loc2_ !== param1)
         {
            this._1080905391validateIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"validateIcon",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get validateMessage() : Text
      {
         return this._1198930449validateMessage;
      }
      
      public function set validateMessage(param1:Text) : void
      {
         var _loc2_:Object = this._1198930449validateMessage;
         if(_loc2_ !== param1)
         {
            this._1198930449validateMessage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"validateMessage",_loc2_,param1));
            }
         }
      }
   }
}
