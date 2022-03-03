package anifire.components.publish
{
   import anifire.core.Console;
   import anifire.util.UtilDict;
   import anifire.util.UtilUser;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ItemClickEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class PublishPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _PublishPanel_Button1:Button;
      
      public var _PublishPanel_Button2:Button;
      
      public var _PublishPanel_Image1:Image;
      
      public var _PublishPanel_Label1:Label;
      
      public var _PublishPanel_Label2:Label;
      
      public var _PublishPanel_Text1:Text;
      
      public var _PublishPanel_Text2:Text;
      
      private var _733950927avail_msg:Label;
      
      private var _1277642207avail_msg2:Label;
      
      private var _209514614export_msg:Label;
      
      private var _2094981508export_msg2:Label;
      
      private var _1133195053hdButtonContainer:Image;
      
      private var _769308225hdButtonContainer2:Image;
      
      private var _218603625more_msg:Label;
      
      private var _1813222267more_msg2:Label;
      
      private var _1940075317publish_radio:RadioButtonGroup;
      
      private var _1622953723radio_button1:RadioButton;
      
      private var _1622953724radio_button2:RadioButton;
      
      private var _1622953725radio_button3:RadioButton;
      
      private var _516315221setting_box1:Canvas;
      
      private var _516315222setting_box2:Canvas;
      
      private var _516315223setting_box3:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _3327403logo:Class;
      
      private var _1420849998hdButton:Class;
      
      private var _1553472534hdButtonDisabled:Class;
      
      private var publish_quality:String = "360p";
      
      mx_internal var _PublishPanel_StylesInit_done:Boolean = false;
      
      private var _embed_css__anifire_icon_img_radio_button_png__192883901_450073487:Class;
      
      private var _embed_css__anifire_icon_img_radio_button_selected_png_802915117_932499235:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function PublishPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "stylesFactory":function():void
            {
               this.themeColor = 40447;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 5;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_PublishPanel_Label1",
                                 "stylesFactory":function():void
                                 {
                                    this.paddingTop = 5;
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"styleName":"publishWindowTitleStyle"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Image,
                                 "id":"_PublishPanel_Image1"
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.verticalGap = 5;
                              this.horizontalAlign = "center";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentHeight":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_PublishPanel_Text1",
                                    "stylesFactory":function():void
                                    {
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"publishWindowSubtitleStyle"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_PublishPanel_Text2",
                                    "stylesFactory":function():void
                                    {
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"publishWindowSubtitleStyle"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"height":30};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"setting_box1",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":234,
                                          "width":500,
                                          "height":45,
                                          "styleName":"publishWindowWhiteBoxStyle",
                                          "horizontalCenter":0,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_PublishPanel_Label2",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 131586;
                                                this.fontSize = 15;
                                                this.fontFamily = "Arial";
                                                this.fontWeight = "normal";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":68,
                                                   "y":11
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":RadioButton,
                                             "id":"radio_button1",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"radio_button",
                                                   "x":28,
                                                   "y":14,
                                                   "groupName":"publish_radio",
                                                   "selected":true,
                                                   "value":"360p"
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"setting_box2",
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundColor = 13421772;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":278,
                                          "width":500,
                                          "height":45,
                                          "styleName":"publishWindowWhiteBoxStyle",
                                          "horizontalCenter":0,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"export_msg",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 8947848;
                                                this.fontSize = 15;
                                                this.fontFamily = "Arial";
                                                this.fontWeight = "normal";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":68,
                                                   "y":5
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"avail_msg",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 1927073;
                                                this.fontSize = 11;
                                                this.fontFamily = "Arial";
                                                this.fontWeight = "normal";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":69,
                                                   "y":23
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"more_msg",
                                             "events":{"click":"__more_msg_click"},
                                             "stylesFactory":function():void
                                             {
                                                this.color = 1927073;
                                                this.fontSize = 11;
                                                this.fontFamily = "Arial";
                                                this.fontWeight = "normal";
                                                this.textDecoration = "underline";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":215,
                                                   "y":23,
                                                   "useHandCursor":true,
                                                   "buttonMode":true,
                                                   "mouseChildren":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":RadioButton,
                                             "id":"radio_button2",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"radio_button",
                                                   "x":28,
                                                   "y":14,
                                                   "groupName":"publish_radio",
                                                   "enabled":false,
                                                   "value":"720p"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Image,
                                             "id":"hdButtonContainer",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "right":20,
                                                   "verticalCenter":0
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"setting_box3",
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundColor = 13421772;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":323,
                                          "width":500,
                                          "height":45,
                                          "styleName":"publishWindowWhiteBoxStyle",
                                          "horizontalCenter":0,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"export_msg2",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 8947848;
                                                this.fontSize = 15;
                                                this.fontFamily = "Arial";
                                                this.fontWeight = "normal";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":68,
                                                   "y":5
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"avail_msg2",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 1927073;
                                                this.fontSize = 11;
                                                this.fontFamily = "Arial";
                                                this.fontWeight = "normal";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":69,
                                                   "y":23
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"more_msg2",
                                             "events":{"click":"__more_msg2_click"},
                                             "stylesFactory":function():void
                                             {
                                                this.color = 1927073;
                                                this.fontSize = 11;
                                                this.fontFamily = "Arial";
                                                this.fontWeight = "normal";
                                                this.textDecoration = "underline";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "x":235,
                                                   "y":23,
                                                   "useHandCursor":true,
                                                   "buttonMode":true,
                                                   "mouseChildren":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":RadioButton,
                                             "id":"radio_button3",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"radio_button",
                                                   "x":28,
                                                   "y":14,
                                                   "groupName":"publish_radio",
                                                   "enabled":false,
                                                   "value":"1080p"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Image,
                                             "id":"hdButtonContainer2",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "right":20,
                                                   "verticalCenter":0
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentHeight":100};
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
                                          "id":"_PublishPanel_Button1",
                                          "events":{"click":"___PublishPanel_Button1_click"},
                                          "stylesFactory":function():void
                                          {
                                             this.fillColors = [15084653,13508703,15875968,15084653];
                                             this.color = 16777215;
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"publishWindowBtnStyle",
                                                "height":32,
                                                "minWidth":150,
                                                "buttonMode":true
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_PublishPanel_Button2",
                                          "events":{"click":"___PublishPanel_Button2_click"},
                                          "stylesFactory":function():void
                                          {
                                             this.color = 16777215;
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"publishWindowBtnStyle",
                                                "height":32,
                                                "minWidth":150,
                                                "buttonMode":true
                                             };
                                          }
                                       })]};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"height":50};
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._3327403logo = PublishPanel_logo;
         this._1420849998hdButton = PublishPanel_hdButton;
         this._1553472534hdButtonDisabled = PublishPanel_hdButtonDisabled;
         this._embed_css__anifire_icon_img_radio_button_png__192883901_450073487 = _class_embed_css__anifire_icon_img_radio_button_png__192883901_450073487;
         this._embed_css__anifire_icon_img_radio_button_selected_png_802915117_932499235 = _class_embed_css__anifire_icon_img_radio_button_selected_png_802915117_932499235;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._PublishPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_publish_PublishPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return PublishPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._PublishPanel_RadioButtonGroup1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         PublishPanel._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.themeColor = 40447;
         };
         mx_internal::_PublishPanel_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function handleAccountType() : void
      {
         if(UtilUser.hasPlusFeatures())
         {
            this.radio_button2.enabled = true;
            this.setting_box2.setStyle("backgroundColor",16777215);
            this.export_msg.setStyle("color",0);
            this.export_msg.y += 5;
            this.avail_msg.visible = false;
            this.more_msg.visible = false;
            this.hdButtonContainer.source = this.hdButton;
         }
         if(UtilUser.hasCommFeatures())
         {
            this.radio_button3.enabled = true;
            this.setting_box3.setStyle("backgroundColor",16777215);
            this.export_msg2.setStyle("color",0);
            this.export_msg2.y += 5;
            this.avail_msg2.visible = false;
            this.more_msg2.visible = false;
            this.hdButtonContainer2.source = this.hdButton;
         }
      }
      
      private function handleQualityChange(param1:ItemClickEvent) : void
      {
         this.publish_quality = param1.currentTarget.selectedValue.toString();
      }
      
      private function onPublicBtnClick() : void
      {
         Console.getConsole().publishQuality = this.publish_quality;
         this.dispatchEvent(new Event("saveAsPublic"));
      }
      
      private function onPrivateBtnClick() : void
      {
         Console.getConsole().publishQuality = this.publish_quality;
         this.dispatchEvent(new Event("saveAsPrivate"));
      }
      
      private function onLearnMoreClick() : void
      {
         navigateToURL(new URLRequest("/plusfeatures?ui=iframe&app=youtube&hook=publish_panel.site"),"_blank");
      }
      
      private function _PublishPanel_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("itemClick",this.__publish_radio_itemClick);
         _loc1_.initialized(this,"publish_radio");
         this.publish_radio = _loc1_;
         BindingManager.executeBindings(this,"publish_radio",this.publish_radio);
         return _loc1_;
      }
      
      public function __publish_radio_itemClick(param1:ItemClickEvent) : void
      {
         this.handleQualityChange(param1);
      }
      
      public function __more_msg_click(param1:MouseEvent) : void
      {
         this.onLearnMoreClick();
      }
      
      public function __more_msg2_click(param1:MouseEvent) : void
      {
         this.onLearnMoreClick();
      }
      
      public function ___PublishPanel_Button1_click(param1:MouseEvent) : void
      {
         this.onPublicBtnClick();
      }
      
      public function ___PublishPanel_Button2_click(param1:MouseEvent) : void
      {
         this.onPrivateBtnClick();
      }
      
      private function _PublishPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Publish your animation to");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishPanel_Label1.text");
         result[1] = new Binding(this,function():Object
         {
            return logo;
         },null,"_PublishPanel_Image1.source");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Your project is ready!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishPanel_Text1.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","It is time to publish it to your YouTube channel and get those views coming!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishPanel_Text2.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Export your video in standard resolution (360p)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishPanel_Label2.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Export your video in HD (720p)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"export_msg.text");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Available to GoPlus members.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"avail_msg.text");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Learn more");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"more_msg.text");
         result[8] = new Binding(this,function():Object
         {
            return hdButtonDisabled;
         },null,"hdButtonContainer.source");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Export your video in HD (1080p)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"export_msg2.text");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Available to GoPremium members.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"avail_msg2.text");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Learn more");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"more_msg2.text");
         result[12] = new Binding(this,function():Object
         {
            return hdButtonDisabled;
         },null,"hdButtonContainer2.source");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Publish as Public");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishPanel_Button1.label");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Publish as Private");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishPanel_Button2.label");
         return result;
      }
      
      mx_internal function _PublishPanel_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_PublishPanel_StylesInit_done)
         {
            return;
         }
         mx_internal::_PublishPanel_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".radio_button");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".radio_button",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.disabledIcon = _embed_css__anifire_icon_img_radio_button_png__192883901_450073487;
               this.selectedOverIcon = _embed_css__anifire_icon_img_radio_button_selected_png_802915117_932499235;
               this.selectedUpIcon = _embed_css__anifire_icon_img_radio_button_selected_png_802915117_932499235;
               this.upIcon = _embed_css__anifire_icon_img_radio_button_png__192883901_450073487;
               this.selectedDownIcon = _embed_css__anifire_icon_img_radio_button_selected_png_802915117_932499235;
               this.overIcon = _embed_css__anifire_icon_img_radio_button_png__192883901_450073487;
               this.downIcon = _embed_css__anifire_icon_img_radio_button_png__192883901_450073487;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get avail_msg() : Label
      {
         return this._733950927avail_msg;
      }
      
      public function set avail_msg(param1:Label) : void
      {
         var _loc2_:Object = this._733950927avail_msg;
         if(_loc2_ !== param1)
         {
            this._733950927avail_msg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"avail_msg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get avail_msg2() : Label
      {
         return this._1277642207avail_msg2;
      }
      
      public function set avail_msg2(param1:Label) : void
      {
         var _loc2_:Object = this._1277642207avail_msg2;
         if(_loc2_ !== param1)
         {
            this._1277642207avail_msg2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"avail_msg2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get export_msg() : Label
      {
         return this._209514614export_msg;
      }
      
      public function set export_msg(param1:Label) : void
      {
         var _loc2_:Object = this._209514614export_msg;
         if(_loc2_ !== param1)
         {
            this._209514614export_msg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"export_msg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get export_msg2() : Label
      {
         return this._2094981508export_msg2;
      }
      
      public function set export_msg2(param1:Label) : void
      {
         var _loc2_:Object = this._2094981508export_msg2;
         if(_loc2_ !== param1)
         {
            this._2094981508export_msg2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"export_msg2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get hdButtonContainer() : Image
      {
         return this._1133195053hdButtonContainer;
      }
      
      public function set hdButtonContainer(param1:Image) : void
      {
         var _loc2_:Object = this._1133195053hdButtonContainer;
         if(_loc2_ !== param1)
         {
            this._1133195053hdButtonContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hdButtonContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get hdButtonContainer2() : Image
      {
         return this._769308225hdButtonContainer2;
      }
      
      public function set hdButtonContainer2(param1:Image) : void
      {
         var _loc2_:Object = this._769308225hdButtonContainer2;
         if(_loc2_ !== param1)
         {
            this._769308225hdButtonContainer2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hdButtonContainer2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get more_msg() : Label
      {
         return this._218603625more_msg;
      }
      
      public function set more_msg(param1:Label) : void
      {
         var _loc2_:Object = this._218603625more_msg;
         if(_loc2_ !== param1)
         {
            this._218603625more_msg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"more_msg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get more_msg2() : Label
      {
         return this._1813222267more_msg2;
      }
      
      public function set more_msg2(param1:Label) : void
      {
         var _loc2_:Object = this._1813222267more_msg2;
         if(_loc2_ !== param1)
         {
            this._1813222267more_msg2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"more_msg2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get publish_radio() : RadioButtonGroup
      {
         return this._1940075317publish_radio;
      }
      
      public function set publish_radio(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1940075317publish_radio;
         if(_loc2_ !== param1)
         {
            this._1940075317publish_radio = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"publish_radio",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get radio_button1() : RadioButton
      {
         return this._1622953723radio_button1;
      }
      
      public function set radio_button1(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1622953723radio_button1;
         if(_loc2_ !== param1)
         {
            this._1622953723radio_button1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"radio_button1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get radio_button2() : RadioButton
      {
         return this._1622953724radio_button2;
      }
      
      public function set radio_button2(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1622953724radio_button2;
         if(_loc2_ !== param1)
         {
            this._1622953724radio_button2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"radio_button2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get radio_button3() : RadioButton
      {
         return this._1622953725radio_button3;
      }
      
      public function set radio_button3(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1622953725radio_button3;
         if(_loc2_ !== param1)
         {
            this._1622953725radio_button3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"radio_button3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get setting_box1() : Canvas
      {
         return this._516315221setting_box1;
      }
      
      public function set setting_box1(param1:Canvas) : void
      {
         var _loc2_:Object = this._516315221setting_box1;
         if(_loc2_ !== param1)
         {
            this._516315221setting_box1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"setting_box1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get setting_box2() : Canvas
      {
         return this._516315222setting_box2;
      }
      
      public function set setting_box2(param1:Canvas) : void
      {
         var _loc2_:Object = this._516315222setting_box2;
         if(_loc2_ !== param1)
         {
            this._516315222setting_box2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"setting_box2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get setting_box3() : Canvas
      {
         return this._516315223setting_box3;
      }
      
      public function set setting_box3(param1:Canvas) : void
      {
         var _loc2_:Object = this._516315223setting_box3;
         if(_loc2_ !== param1)
         {
            this._516315223setting_box3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"setting_box3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get logo() : Class
      {
         return this._3327403logo;
      }
      
      private function set logo(param1:Class) : void
      {
         var _loc2_:Object = this._3327403logo;
         if(_loc2_ !== param1)
         {
            this._3327403logo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get hdButton() : Class
      {
         return this._1420849998hdButton;
      }
      
      private function set hdButton(param1:Class) : void
      {
         var _loc2_:Object = this._1420849998hdButton;
         if(_loc2_ !== param1)
         {
            this._1420849998hdButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hdButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get hdButtonDisabled() : Class
      {
         return this._1553472534hdButtonDisabled;
      }
      
      private function set hdButtonDisabled(param1:Class) : void
      {
         var _loc2_:Object = this._1553472534hdButtonDisabled;
         if(_loc2_ !== param1)
         {
            this._1553472534hdButtonDisabled = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hdButtonDisabled",_loc2_,param1));
            }
         }
      }
   }
}
