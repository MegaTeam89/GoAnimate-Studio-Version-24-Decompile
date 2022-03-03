package anifire.playerComponent.playerEndScreen
{
   import anifire.component.IconTextButton;
   import anifire.component.SharingPanel;
   import anifire.constant.ServerConstants;
   import anifire.event.SharingEvent;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import anifire.util.UtilPlain;
   import anifire.util.UtilSharing;
   import anifire.util.UtilUser;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.filters.DropShadowFilter;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.Security;
   import flash.utils.Proxy;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Box;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.Tile;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Blur;
   import mx.effects.Glow;
   import mx.effects.Parallel;
   import mx.events.DynamicEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.states.SetProperty;
   import mx.states.State;
   
   use namespace mx_internal;
   
   public class PlayerEndScreen extends Canvas implements IBindingClient
   {
      
      public static const TYPE_FACEBOOK:String = "facebook";
      
      public static const TYPE_MYSPACE:String = "myspace";
      
      public static const TYPE_DIGG:String = "digg";
      
      public static const TYPE_DELICIOUS:String = "delicious";
      
      public static const TYPE_REDDIT:String = "reddit";
      
      public static const TYPE_STUMBLEUPON:String = "stumbleupon";
      
      public static const TYPE_FARK:String = "fark";
      
      public static const TYPE_TWITTER:String = "twitter";
      
      public static const MODE_NULL:uint = 0;
      
      public static const MODE_PREVIEW:uint = 1;
      
      public static const MODE_PRIVATE_AND_NON_PSHARE:uint = 2;
      
      public static const MODE_PUBLIC_OR_PSHARE:uint = 3;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _PlayerEndScreen_IconTextButton11:IconTextButton;
      
      public var _PlayerEndScreen_IconTextButton12:IconTextButton;
      
      public var _PlayerEndScreen_Label7:Label;
      
      public var _PlayerEndScreen_SetProperty1:SetProperty;
      
      public var _PlayerEndScreen_SetProperty2:SetProperty;
      
      public var _PlayerEndScreen_SetProperty3:SetProperty;
      
      public var _PlayerEndScreen_SetProperty4:SetProperty;
      
      public var _PlayerEndScreen_SetProperty5:SetProperty;
      
      public var _PlayerEndScreen_Text1:Text;
      
      private var _1269660595_btnCopyShare:Button;
      
      private var _1355558663_btnCreate:IconTextButton;
      
      private var _927354457_btnCreate2:IconTextButton;
      
      private var _1480051251_btnDeliciousShare:Button;
      
      private var _561998435_btnDiggShare:Button;
      
      private var _1730971321_btnEdit:Button;
      
      private var _2120243201_btnEmail:IconTextButton;
      
      private var _2120242372_btnEmbed:IconTextButton;
      
      private var _1041418231_btnEndReminderPri:Button;
      
      private var _1041418317_btnEndReminderPub:Button;
      
      private var _1654898563_btnFacebook:IconTextButton;
      
      private var _1658267108_btnFacebookShare:Button;
      
      private var _347601646_btnFarkShare:Button;
      
      private var _2118509072_btnGigya:Label;
      
      private var _1396665949_btnMySpace:IconTextButton;
      
      private var _883581826_btnMySpaceShare:Button;
      
      private var _1563420960_btnNextMovie:IconTextButton;
      
      private var _1058421316_btnRedditShare:Button;
      
      private var _937789468_btnReplay:IconTextButton;
      
      private var _993297614_btnReplay2:IconTextButton;
      
      private var _382316096_btnStumbleuponShare:Button;
      
      private var _1017546218_btnTwitter:IconTextButton;
      
      private var _976239767_btnTwitterShare:Button;
      
      private var _1208694428_canEndReminder:Canvas;
      
      private var _47353010_canShare:VBox;
      
      private var _34866078_canShareOther:Canvas;
      
      private var _1400642365_editUI:Canvas;
      
      private var _1135317132_endScreen_previewMode:Canvas;
      
      private var _380159833_endingScreen_privateMode:Canvas;
      
      private var _1749280839_endingScreen_publicMode:Canvas;
      
      private var _1213830726_hboxBtn:HBox;
      
      private var _1025953208_hboxBtn2:HBox;
      
      private var _1930826236_lblMsgStep2:Label;
      
      private var _273928730_lblMsgStep2b:Label;
      
      private var _356760679_sharingPanel:SharingPanel;
      
      private var _1721552227_sharingStyle1:Canvas;
      
      private var _348798918_sharingViewStack:ViewStack;
      
      private var _2063858794_sharing_BasicFeature:Canvas;
      
      private var _1829965899_txtEndReminder1:Label;
      
      private var _1829965898_txtEndReminder2:Label;
      
      private var _1829965897_txtEndReminder3:Label;
      
      private var _612233759_txtShareURL:TextInput;
      
      private var _1093743166_vsPlayerEnd:ViewStack;
      
      private var _567556681blank_screen:Canvas;
      
      private var _11548985buttonBox:HBox;
      
      private var _1170704187creditScreen:VBox;
      
      private var _564314170creditText:Text;
      
      private var _1212896764replay_btn:IconTextButton;
      
      private var _1445642921wfLoaderBox:Box;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _selectedCanvas:UIComponent;
      
      private var _mode:uint = 0;
      
      private var _movieId:String;
      
      private var _isPublished:int = -1;
      
      private var _isPshared:int = -1;
      
      private var _isPrivateModeAllowed:Boolean = true;
      
      public var movieDuration:Number = 0;
      
      private var _gigyaConfig:Object = null;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function PlayerEndScreen()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___PlayerEndScreen_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":550,
                  "height":354,
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":ViewStack,
                     "id":"_vsPlayerEnd",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_endingScreen_publicMode",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "styleName":"bgEndScreenSharing",
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":ViewStack,
                                       "id":"_sharingViewStack",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"_sharingStyle1",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_hboxBtn2",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalAlign = "center";
                                                            this.horizontalGap = 25;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "y":75,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnReplay2",
                                                                  "events":{"click":"___btnReplay2_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnReplaySharing",
                                                                        "buttonMode":true,
                                                                        "labelPlacement":"bottom",
                                                                        "scaleX":2,
                                                                        "scaleY":2
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnCreate2",
                                                                  "events":{"click":"___btnCreate2_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnCreate",
                                                                        "buttonMode":true,
                                                                        "labelPlacement":"bottom",
                                                                        "scaleX":2,
                                                                        "scaleY":2
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"_sharing_BasicFeature",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_hboxBtn",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalAlign = "center";
                                                            this.horizontalGap = 25;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "y":245,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnReplay",
                                                                  "events":{"click":"___btnReplay_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnReplaySharing",
                                                                        "buttonMode":true,
                                                                        "labelPlacement":"bottom"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnEmail",
                                                                  "events":{"click":"___btnEmail_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnEmail",
                                                                        "buttonMode":true,
                                                                        "labelPlacement":"bottom"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnEmbed",
                                                                  "events":{"click":"___btnEmbed_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnEmbed",
                                                                        "buttonMode":true,
                                                                        "labelPlacement":"bottom"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnCreate",
                                                                  "events":{"click":"___btnCreate_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnCreate",
                                                                        "buttonMode":true,
                                                                        "labelPlacement":"bottom"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnNextMovie",
                                                                  "events":{"click":"___btnNextMovie_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnNextMovieArrow",
                                                                        "buttonMode":true,
                                                                        "labelPlacement":"bottom"
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "id":"_canShare",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.paddingLeft = 0;
                                                            this.verticalGap = 12;
                                                            this.paddingTop = 15;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "label":"Share",
                                                               "x":140,
                                                               "y":30,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "direction":"vertical",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnFacebook",
                                                                  "events":{"click":"___btnFacebook_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "styleName":"btnFacebook",
                                                                        "labelPlacement":"right"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnTwitter",
                                                                  "events":{"click":"___btnTwitter_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "styleName":"btnTwitter",
                                                                        "labelPlacement":"right"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_btnMySpace",
                                                                  "events":{"click":"___btnMySpace_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "styleName":"btnMySpace",
                                                                        "labelPlacement":"right",
                                                                        "visible":false,
                                                                        "includeInLayout":false
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_btnGigya",
                                                                  "events":{"click":"___btnGigya_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "useHandCursor":true,
                                                                        "mouseChildren":false,
                                                                        "width":270,
                                                                        "styleName":"btnGigya"
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Box,
                                                         "id":"wfLoaderBox",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "x":25,
                                                               "y":20
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "id":"_canShareOther",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "label":"Share(not goanimate.com)",
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingLeft = 20;
                                                                     this.horizontalGap = -10;
                                                                     this.paddingTop = 15;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "width":463,
                                                                        "height":87,
                                                                        "horizontalScrollPolicy":"off",
                                                                        "verticalScrollPolicy":"off",
                                                                        "direction":"horizontal",
                                                                        "x":45,
                                                                        "y":20,
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "id":"_btnFacebookShare",
                                                                           "events":{"click":"___btnFacebookShare_click"},
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "x":35,
                                                                                 "y":43,
                                                                                 "styleName":"btnFacebookS",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "id":"_btnTwitterShare",
                                                                           "events":{"click":"___btnTwitterShare_click"},
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "x":437,
                                                                                 "y":43,
                                                                                 "styleName":"btnTwitterS",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "id":"_btnDeliciousShare",
                                                                           "events":{"click":"___btnDeliciousShare_click"},
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "x":276,
                                                                                 "y":43,
                                                                                 "styleName":"btnDeliciousS",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "id":"_btnMySpaceShare",
                                                                           "events":{"click":"___btnMySpaceShare_click"},
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "x":116,
                                                                                 "y":43,
                                                                                 "styleName":"btnMySpaceS",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "id":"_btnDiggShare",
                                                                           "events":{"click":"___btnDiggShare_click"},
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "x":195,
                                                                                 "y":43,
                                                                                 "styleName":"btnDiggS",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "id":"_btnRedditShare",
                                                                           "events":{"click":"___btnRedditShare_click"},
                                                                           "stylesFactory":function():void
                                                                           {
                                                                              this.paddingLeft = 30;
                                                                           },
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "x":355,
                                                                                 "y":43,
                                                                                 "styleName":"btnRedditS",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "id":"_btnStumbleuponShare",
                                                                           "events":{"click":"___btnStumbleuponShare_click"},
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "x":437,
                                                                                 "y":43,
                                                                                 "styleName":"btnStumbleuponS",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "id":"_btnFarkShare",
                                                                           "events":{"click":"___btnFarkShare_click"},
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "x":375,
                                                                                 "y":43,
                                                                                 "styleName":"btnFarkS",
                                                                                 "buttonMode":true,
                                                                                 "visible":false
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_lblMsgStep2",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.fontSize = 14;
                                                                     this.color = 16777215;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "x":61,
                                                                        "y":152,
                                                                        "text":"1. Click on the above icons",
                                                                        "visible":true
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_lblMsgStep2b",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.fontSize = 14;
                                                                     this.color = 16777215;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "x":61,
                                                                        "y":166,
                                                                        "text":"2. Copy/paste the URL in your browser",
                                                                        "visible":true
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":TextInput,
                                                                  "id":"_txtShareURL",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.fontSize = 14;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "x":60,
                                                                        "y":126,
                                                                        "editable":false,
                                                                        "width":310,
                                                                        "styleName":"commonSharingTextInput",
                                                                        "height":27,
                                                                        "visible":true
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_btnCopyShare",
                                                                  "events":{"click":"___btnCopyShare_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "x":397,
                                                                        "y":124,
                                                                        "label":"Copy",
                                                                        "width":87.2,
                                                                        "height":27,
                                                                        "styleName":"commonSharingButton",
                                                                        "buttonMode":true,
                                                                        "visible":true
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":SharingPanel,
                                                "id":"_sharingPanel",
                                                "events":{"Close":"___sharingPanel_Close"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_endingScreen_privateMode",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "styleName":"bgEndScreenSharing",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_canEndReminder",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":52,
                                             "y":32,
                                             "width":442,
                                             "height":202,
                                             "styleName":"bgPrivateMode",
                                             "horizontalCenter":0,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_txtEndReminder1",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 17;
                                                   this.color = 65793;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":10,
                                                      "horizontalCenter":0
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_txtEndReminder2",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 22;
                                                   this.fontWeight = "bold";
                                                   this.color = 16711422;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":32,
                                                      "horizontalCenter":0
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_txtEndReminder3",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 11;
                                                   this.fontWeight = "bold";
                                                   this.color = 13421772;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":177,
                                                      "horizontalCenter":0
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnEndReminderPub",
                                                "events":{"click":"___btnEndReminderPub_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":72,
                                                      "width":225,
                                                      "height":47,
                                                      "horizontalCenter":0,
                                                      "styleName":"btnTurnPublish"
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnEndReminderPri",
                                                "events":{"click":"___btnEndReminderPri_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":127,
                                                      "width":225,
                                                      "height":47,
                                                      "horizontalCenter":0,
                                                      "styleName":"btnTurnPshare"
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":IconTextButton,
                                       "id":"_PlayerEndScreen_IconTextButton11",
                                       "events":{"click":"___PlayerEndScreen_IconTextButton11_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":45,
                                             "y":236,
                                             "styleName":"btnReplaySharing1",
                                             "buttonMode":true,
                                             "labelPlacement":"bottom"
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_editUI",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "styleName":"bgEndScreenSharing",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":VBox,
                                       "stylesFactory":function():void
                                       {
                                          this.horizontalAlign = "center";
                                          this.verticalAlign = "middle";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":52,
                                             "y":16,
                                             "width":442,
                                             "height":202,
                                             "styleName":"bgPrivateMode",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_PlayerEndScreen_Label7",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 17;
                                                   this.color = 65793;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":10,
                                                      "horizontalCenter":0
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnEdit",
                                                "events":{"click":"___btnEdit_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":127,
                                                      "width":225,
                                                      "height":47,
                                                      "horizontalCenter":0,
                                                      "styleName":"btnTurnPshare"
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":IconTextButton,
                                       "id":"_PlayerEndScreen_IconTextButton12",
                                       "events":{"click":"___PlayerEndScreen_IconTextButton12_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":45,
                                             "y":236,
                                             "styleName":"btnReplaySharing1",
                                             "buttonMode":true,
                                             "labelPlacement":"bottom"
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_endScreen_previewMode",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"blank_screen",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "styleName":"bgEndScreen"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":HBox,
                                       "id":"buttonBox",
                                       "stylesFactory":function():void
                                       {
                                          this.verticalAlign = "middle";
                                          this.horizontalAlign = "center";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "x":0,
                                             "y":20,
                                             "percentWidth":100,
                                             "height":354,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":IconTextButton,
                                                "id":"replay_btn",
                                                "events":{"click":"__replay_btn_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "styleName":"btnEndScreenReplay",
                                                      "labelPlacement":"bottom"
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
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "id":"creditScreen",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"TribeOfNoiseBanner",
                           "percentWidth":100,
                           "percentHeight":100,
                           "visible":false,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"height":90};
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"_PlayerEndScreen_Text1",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 16;
                                 this.fontWeight = "bold";
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "selectable":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"creditText",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 24;
                                 this.textAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "selectable":false
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
         var bindings:Array = this._PlayerEndScreen_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_playerComponent_playerEndScreen_PlayerEndScreenWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return PlayerEndScreen[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 550;
         this.height = 354;
         this.creationPolicy = "all";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.states = [this._PlayerEndScreen_State1_c(),this._PlayerEndScreen_State2_c()];
         this.addEventListener("creationComplete",this.___PlayerEndScreen_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         PlayerEndScreen._watcherSetupUtil = param1;
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
      
      private function get isPublished() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         var _loc3_:URLVariables = null;
         if(this._isPublished == -1)
         {
            _loc1_ = false;
            if(ExternalInterface.available && this._isPrivateModeAllowed)
            {
               _loc2_ = ExternalInterface.call("getMoviePublishStatusHistory",this._movieId);
               if(_loc2_ == "1")
               {
                  _loc1_ = true;
                  this._isPublished = 1;
               }
               else if(_loc2_ == "0")
               {
                  _loc1_ = true;
                  this._isPublished = 0;
               }
            }
            if(!_loc1_)
            {
               _loc3_ = new URLVariables();
               Util.addFlashVarsToURLvar(_loc3_);
               if(UtilPlain.get_isMoviePublished_by_flashVar(_loc3_[ServerConstants.FLASHVAR_IS_PUBLISHED_PLAYER],_loc3_[ServerConstants.FLASHVAR_IS_PSHARED]))
               {
                  this._isPublished = 1;
               }
               else
               {
                  this._isPublished = 0;
               }
            }
         }
         if(this._isPublished == 0)
         {
            return false;
         }
         return true;
      }
      
      private function set isPublished(param1:Boolean) : void
      {
         this._isPublished = !!param1 ? 1 : 0;
      }
      
      private function get isPshared() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         var _loc3_:URLVariables = null;
         if(this._isPshared == -1)
         {
            _loc1_ = false;
            if(ExternalInterface.available)
            {
               _loc2_ = ExternalInterface.call("getMoviePshareStatusHistory",this._movieId);
               if(_loc2_ == "1")
               {
                  _loc1_ = true;
                  this._isPshared = 1;
               }
               else if(_loc2_ == "0")
               {
                  _loc1_ = true;
                  this._isPshared = 0;
               }
            }
            if(!_loc1_)
            {
               _loc3_ = new URLVariables();
               Util.addFlashVarsToURLvar(_loc3_);
               if(UtilPlain.get_isMoviePrivateShare_by_flashVar(_loc3_[ServerConstants.FLASHVAR_IS_PSHARED]))
               {
                  this._isPshared = 1;
               }
               else
               {
                  this._isPshared = 0;
               }
            }
         }
         if(this._isPshared == 0)
         {
            return false;
         }
         return true;
      }
      
      private function set isPshared(param1:Boolean) : void
      {
         this._isPshared = !!param1 ? 1 : 0;
      }
      
      private function get selectedCanvas() : UIComponent
      {
         return this._selectedCanvas;
      }
      
      private function set selectedCanvas(param1:UIComponent) : void
      {
         this._selectedCanvas = param1;
         this._canShare.visible = this._canShareOther.visible = false;
         param1.visible = true;
      }
      
      private function get mode() : uint
      {
         return this._mode;
      }
      
      public function set isPreviewMode(param1:Boolean) : void
      {
         this.resetMode(MODE_PREVIEW);
      }
      
      public function resetUI() : void
      {
         if(this.mode == MODE_NULL)
         {
            if(!this.isPublished && !this.isPshared && this._isPrivateModeAllowed)
            {
               this.resetMode(MODE_PRIVATE_AND_NON_PSHARE);
            }
            else
            {
               this.resetMode(MODE_PUBLIC_OR_PSHARE);
            }
         }
      }
      
      private function resetMode(param1:uint) : void
      {
         var _loc2_:String = null;
         this._mode = param1;
         if(this._mode == MODE_PUBLIC_OR_PSHARE)
         {
            if(this._vsPlayerEnd != null)
            {
               this._vsPlayerEnd.selectedChild = this._endingScreen_publicMode;
            }
         }
         else if(this._mode == MODE_PRIVATE_AND_NON_PSHARE && this._isPrivateModeAllowed)
         {
            if(this._vsPlayerEnd != null)
            {
               if(UtilUser.userType == UtilUser.BASIC_USER && this.movieDuration > 2 * 60)
               {
                  this._vsPlayerEnd.selectedChild = this._editUI;
               }
               else
               {
                  this._vsPlayerEnd.selectedChild = this._endingScreen_privateMode;
                  if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE) == "cn")
                  {
                     currentState = "cn_private";
                     this._canEndReminder.styleName = "";
                     this._txtEndReminder3.text = "";
                     this._btnEndReminderPri.visible = false;
                     this._txtEndReminder2.text = UtilDict.toDisplay("player","player_shareitnogp");
                     this._txtEndReminder1.setStyle("color","#999999");
                     _loc2_ = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_PARENT_CONSENT);
                     if(_loc2_ == "0" || _loc2_ == "2")
                     {
                        if(_loc2_ == "0")
                        {
                           this._txtEndReminder3.text = UtilDict.toDisplay("player","player_parent_consent");
                        }
                        this._txtEndReminder2.text = "";
                        this._btnEndReminderPub.visible = false;
                     }
                  }
                  else if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_CODE) == "domo")
                  {
                     currentState = "domo_private";
                  }
                  else if(UtilLicense.isBoxEnvironment())
                  {
                     this._txtEndReminder2.text = UtilDict.toDisplay("player","player_shareitnogp");
                  }
               }
            }
         }
         else if(this._vsPlayerEnd != null)
         {
            this._vsPlayerEnd.selectedChild = this._endScreen_previewMode;
         }
      }
      
      public function set showReplayButton(param1:Boolean) : void
      {
      }
      
      public function set showNewAnimationButton(param1:Boolean) : void
      {
      }
      
      public function set showShareButton(param1:Boolean) : void
      {
      }
      
      public function set showChangeButton(param1:Boolean) : void
      {
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
      }
      
      private function init() : void
      {
         var variables:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(variables);
         try
         {
            this._sharingPanel.init();
         }
         catch(e:Error)
         {
            this.resetMode(MODE_PREVIEW);
            return;
         }
         this._movieId = variables["movieId"];
         if(variables["appCode"] == "go")
         {
            this.selectedCanvas = this._canShare;
         }
         else
         {
            this.selectedCanvas = this._canShareOther;
            this.showStep2Components();
         }
         if(variables["appCode"] == "go" && variables[ServerConstants.PARAM_ISEMBED_ID] == 0)
         {
            this._isPrivateModeAllowed = true;
         }
         else
         {
            this._isPrivateModeAllowed = false;
         }
         this._sharingViewStack.selectedChild = this._sharing_BasicFeature;
         if(variables["endStyle"] != null)
         {
            if(variables["endStyle"] == "1")
            {
               this._sharingViewStack.selectedChild = this._sharingStyle1;
               this._isPrivateModeAllowed = false;
            }
            else if(variables["endStyle"] == "2")
            {
               this.resetMode(MODE_PREVIEW);
            }
         }
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback("triggerPublishStatusChange",this.triggerPublishStatusChange);
               ExternalInterface.addCallback("triggerPshareStatusChange",this.triggerPshareStatusChange);
            }
            catch(e:SecurityError)
            {
            }
         }
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_RSS_PATH) != null)
         {
            if(Util.getFlashVar().getValueByKey("endOfList") == "true")
            {
               this._btnNextMovie.label = UtilDict.toDisplay("player","More") + " >";
            }
            else
            {
               this._btnNextMovie.label = UtilDict.toDisplay("player","Next Movie") + " >";
            }
            this._btnReplay.visible = false;
            this._btnNextMovie.visible = true;
         }
         else
         {
            this._btnReplay.visible = true;
            this._btnNextMovie.visible = false;
         }
         this._btnEmail.includeInLayout = this._btnEmail.visible;
         this._btnEmbed.includeInLayout = this._btnEmbed.visible;
         this._btnReplay.includeInLayout = this._btnReplay.visible;
         this._btnNextMovie.includeInLayout = this._btnNextMovie.visible;
      }
      
      public function get gigyaConfig() : Object
      {
         var embedCode:String = null;
         var plainHtmlEmbedCode:String = null;
         var getVariable:URLVariables = null;
         var urlVar:URLVariables = null;
         var movieOwnerName:String = null;
         var movieOwnerId:String = null;
         var movieId:String = null;
         var movieLicenseId:String = null;
         var movieTitle:String = null;
         var movieDesc:String = null;
         var userId:String = null;
         var chainMovieIds:String = null;
         var apiServer:String = null;
         var appCode:String = null;
         var movieThumbnailUrl:String = null;
         var smallMovieThumbnailUrl:String = null;
         var fbAppUrl:String = null;
         var client_theme_code:String = null;
         var client_language_code:String = null;
         var isCopyable:Boolean = false;
         var isPublished:Boolean = false;
         var isPrivateShared:Boolean = false;
         var cfg:Object = null;
         if(this._gigyaConfig == null)
         {
            getVariable = new URLVariables();
            urlVar = new URLVariables();
            Util.addFlashVarsToURLvar(urlVar);
            movieOwnerName = urlVar["movieOwner"];
            movieOwnerId = !!urlVar["movieOwnerId"] ? urlVar["movieOwnerId"] : null;
            movieId = !!urlVar["movieId"] ? urlVar["movieId"] : "";
            movieLicenseId = !!urlVar[ServerConstants.FLASHVAR_MOVIE_LICENSE_ID] ? urlVar[ServerConstants.FLASHVAR_MOVIE_LICENSE_ID] : "";
            if(movieId == "")
            {
               movieId = FlexGlobals.topLevelApplication.parameters["movieId"];
            }
            movieTitle = !!urlVar["movieTitle"] ? urlVar["movieTitle"] : "";
            movieDesc = !!urlVar["movieDesc"] ? urlVar["movieDesc"] : "";
            userId = !!urlVar["userId"] ? urlVar["userId"] : "";
            chainMovieIds = !!urlVar[ServerConstants.FLASHVAR_CHAIN_MOVIE_ID] ? urlVar[ServerConstants.FLASHVAR_CHAIN_MOVIE_ID] : "";
            apiServer = urlVar["apiserver"];
            appCode = urlVar["appCode"];
            movieThumbnailUrl = !!urlVar["thumbnailURL"] ? Util.getMovieThumbnailUrl() : "";
            smallMovieThumbnailUrl = movieThumbnailUrl.replace("L.jpg",".jpg");
            fbAppUrl = urlVar["fb_app_url"];
            client_theme_code = urlVar[ServerConstants.FLASHVAR_CLIENT_THEME_CODE];
            client_language_code = urlVar[ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE];
            isCopyable = !!urlVar[ServerConstants.FLASHVAR_IS_COPYABLE] ? (urlVar[ServerConstants.FLASHVAR_IS_COPYABLE] == "1" ? true : false) : false;
            isPublished = true;
            if(!UtilPlain.get_isMoviePublished_by_flashVar(urlVar["isPublished"],urlVar["is_private_shared"]))
            {
               isPublished = false;
            }
            isPrivateShared = !!UtilPlain.get_isMoviePrivateShare_by_flashVar(urlVar["is_private_shared"]) ? true : false;
            if(UtilLicense.isBoxEnvironment())
            {
               embedCode = UtilSharing.buildBoxEmbedTag(movieOwnerName,movieId,movieTitle,movieDesc,userId,apiServer,appCode,movieThumbnailUrl,fbAppUrl,isCopyable,isPublished,isPrivateShared,"gigyaembed",movieOwnerId,movieLicenseId,client_theme_code,client_language_code,chainMovieIds);
            }
            else
            {
               embedCode = UtilSharing.buildEmbedTag(movieOwnerName,movieId,movieTitle,movieDesc,userId,apiServer,appCode,movieThumbnailUrl,fbAppUrl,isCopyable,isPublished,isPrivateShared,"gigyaembed",movieOwnerId,movieLicenseId,client_theme_code,client_language_code,chainMovieIds);
            }
            if(UtilLicense.isBoxEnvironment())
            {
               plainHtmlEmbedCode = UtilSharing.buildBoxPlainHtmlEmbedTag(movieId,movieTitle,smallMovieThumbnailUrl,userId,"gigyaembed",movieOwnerName,movieOwnerId);
            }
            else
            {
               plainHtmlEmbedCode = UtilSharing.buildPlainHtmlEmbedTag(movieId,movieTitle,smallMovieThumbnailUrl,userId,"gigyaembed",movieOwnerName,movieOwnerId);
            }
            if(userId != "")
            {
               getVariable["uid"] = userId;
            }
            cfg = new Object();
            this._gigyaConfig = cfg;
            cfg["width"] = 500;
            cfg["height"] = 180;
            cfg["showCloseButton"] = "true";
            cfg["contentIsLayout"] = "false";
            cfg["advancedTracking"] = "true";
            cfg["partner"] = ServerConstants.GIGYA_ACCOUNT_ID;
            cfg["UIConfig"] = "<config><display showDesktop=\"true\" showEmail=\"false\" useTransitions=\"true\" showBookmark=\"true\" codeBoxHeight=\"auto\" showCodeBox=\"false\" showCloseButton=\"true\" bulletinChecked=\"false\" networksToHide=\"facebook, myspace\" networksWithCodeBox=\"\" networksToShow=\"friendster, orkut, bebo, tagged, hi5, livespaces, piczo, freewebs, livejournal, blackplanet, myyearbook, wordpress, vox, typepad, xanga, multiply, igoogle, netvibes, pageflakes, migente, *\"></display><body corner-roundness=\"8;8;8;8\"><background frame-color=\"Transparent\" gradient-color-begin=\"#353535\" gradient-color-end=\"#606060\"></background><controls size=\"11\" bold=\"true\"><snbuttons type=\"textUnder\" frame-color=\"#6D0000\" background-color=\"#FFFFFF\" over-background-color=\"#FFFFFF\" color=\"#CACACA\" corner-roundness=\"0;8;8;8\" gradient-color-begin=\"#8A8A8A\" gradient-color-end=\"#000000\" font=\"Arial\" size=\"11\" bold=\"false\" over-gradient-color-begin=\"#AAAAAA\" over-gradient-color-end=\"#000000\" over-color=\"#F4F4F4\" down-color=\"#000000\"><more frame-color=\"Transparent\"></more></snbuttons><textboxes frame-color=\"#000000\" color=\"#AAAAAA\" corner-roundness=\"0;0;0;0\" gradient-color-begin=\"#202020\" gradient-color-end=\"#0B0B0B\" font=\"Arial\" bold=\"false\"><codeboxes color=\"#EAEAEA\" frame-color=\"#8A8A8A\" gradient-color-begin=\"#000000\" font=\"Arial\" bold=\"false\"></codeboxes><inputs frame-color=\"#6D0000\"></inputs><dropdowns frame-color=\"#6D0000\" handle-gradient-color-begin=\"#B60000\" handle-gradient-color-end=\"#6D0000\" handle-over-gradient-color-begin=\"#FF0000\" handle-over-gradient-color-end=\"#DA0000\" handle-down-gradient-color-begin=\"#FF0000\" handle-down-gradient-color-end=\"#6D0000\" background-color=\"#6D0000\" gradient-color-begin=\"#000000\" font=\"Arial\" bold=\"false\"></dropdowns></textboxes><buttons frame-color=\"#FF0000\" gradient-color-begin=\"#FF2424\" gradient-color-end=\"#6D0000\" color=\"#F4F4F4\" corner-roundness=\"0;8;8;8\" font=\"Arial\" size=\"10\" bold=\"false\" down-frame-color=\"#000000\" over-gradient-color-begin=\"#DA0000\" down-gradient-color-begin=\"#910000\" over-gradient-color-end=\"#DA0000\" down-gradient-color-end=\"#FF0000\" over-color=\"#F4F4F4\"><post-buttons gradient-color-begin=\"#FF4949\" gradient-color-end=\"#6D0000\"></post-buttons></buttons><listboxes corner-roundness=\"5;5;5;5\"></listboxes><servicemarker gradient-color-begin=\"#DA0000\" gradient-color-end=\"#DA0000\"></servicemarker></controls><texts color=\"#FFFFFF\" font=\"Arial\" size=\"10\"><privacy color=\"#959595\" size=\"11\"></privacy><headers size=\"11\" bold=\"true\"></headers><labels size=\"11\" bold=\"true\"></labels><messages color=\"#D5D5D5\" frame-thickness=\"0\" corner-roundness=\"0;0;0;0\" gradient-color-begin=\"#B60000\" gradient-color-end=\"#000000\" size=\"11\" bold=\"true\"></messages><links color=\"#DFDFDF\" underline=\"false\" size=\"11\" bold=\"true\" over-color=\"#FFFFFF\"></links></texts></body></config>";
            cfg["defaultContent"] = embedCode;
            getVariable["utm_source"] = "gigyabookmark";
            if(UtilLicense.isBoxEnvironment())
            {
               getVariable["utm_campaign"] = UtilLicense.boxCustomerID;
            }
            cfg["defaultBookmarkURL"] = !!UtilLicense.isBoxEnvironment() ? UtilSharing.getBoxMovieUrl(movieId,getVariable) : UtilSharing.getMovieUrl(movieId,getVariable);
            cfg["widgetTitle"] = UtilLicense.getCurrentLicensorDisplayName() + ": " + movieTitle;
            cfg["friendsterContent"] = plainHtmlEmbedCode;
            cfg["bloggerContent"] = plainHtmlEmbedCode;
            cfg["hi5Content"] = plainHtmlEmbedCode;
            cfg["wordpressContent"] = plainHtmlEmbedCode;
            cfg["onPostProfile"] = function(param1:Object):void
            {
            };
            cfg["onLoad"] = function(param1:Object):void
            {
            };
            cfg["onClose"] = function(param1:Object):void
            {
               wfLoaderBox.visible = false;
               MovieClip(Loader(UIComponent(wfLoaderBox.getChildAt(0)).getChildAt(0)).content).INIT();
            };
         }
         return this._gigyaConfig;
      }
      
      private function onBtnReplayClick(param1:Event) : void
      {
         var _loc2_:PlayerEndScreenEvent = new PlayerEndScreenEvent(PlayerEndScreenEvent.BTN_REPLAY_CLICK,this);
         dispatchEvent(_loc2_);
      }
      
      private function onBtnNewAnimationClick(param1:Event) : void
      {
         var _loc2_:PlayerEndScreenEvent = new PlayerEndScreenEvent(PlayerEndScreenEvent.BTN_NEW_ANIMATION_CLICK,this);
         dispatchEvent(_loc2_);
      }
      
      private function onBtnShareClick(param1:Event) : void
      {
         var _loc2_:PlayerEndScreenEvent = new PlayerEndScreenEvent(PlayerEndScreenEvent.BTN_SHARE_CLICK,this);
         dispatchEvent(_loc2_);
      }
      
      private function onBtnChangeClick(param1:Event) : void
      {
         var _loc2_:PlayerEndScreenEvent = new PlayerEndScreenEvent(PlayerEndScreenEvent.BTN_CHANGE_CLICK,this);
         dispatchEvent(_loc2_);
      }
      
      private function onBtnNextMovieClick(param1:Event) : void
      {
         var _loc2_:PlayerEndScreenEvent = new PlayerEndScreenEvent(PlayerEndScreenEvent.BTN_NEXTMOVIE_CLICK,this);
         dispatchEvent(_loc2_);
      }
      
      public function showSharingPanel(param1:String) : void
      {
         if(param1 != SharingPanel.TAB_SHARE && param1 != SharingPanel.TAB_GOEMAIL)
         {
            this._sharingViewStack.selectedChild = this._sharingPanel;
            this._sharingPanel.tab = param1;
         }
         else
         {
            this.showBasicSharingScreen();
         }
      }
      
      private function onClickSharingButtons(param1:Event) : void
      {
         this.closeFull();
         if(param1.target == this._btnEmail)
         {
            Util.gaTracking("/goplayer/email",this.stage);
            this.showSharingPanel(SharingPanel.TAB_EMAIL);
         }
         else if(param1.target == this._btnEmbed)
         {
            this.showSharingPanel(SharingPanel.TAB_EMBED);
         }
         else if(param1.target == this._btnCreate)
         {
            this.showSharingPanel(SharingPanel.TAB_CREATE);
         }
      }
      
      private function showBasicSharingScreen() : void
      {
         this._sharingViewStack.selectedChild = this._sharing_BasicFeature;
      }
      
      private function triggerPublishStatusChange(param1:String, param2:Boolean) : void
      {
         if(this._movieId != param1)
         {
            return;
         }
         this.isPublished = param2;
         if(this.isPublished || this.isPshared)
         {
            this.resetMode(MODE_PUBLIC_OR_PSHARE);
         }
         else
         {
            this.resetMode(MODE_PRIVATE_AND_NON_PSHARE);
         }
      }
      
      private function triggerPshareStatusChange(param1:String, param2:Boolean) : void
      {
         if(this._movieId != param1)
         {
            return;
         }
         this.isPshared = param2;
         if(this.isPublished || this.isPshared)
         {
            this.resetMode(MODE_PUBLIC_OR_PSHARE);
         }
         else
         {
            this.resetMode(MODE_PRIVATE_AND_NON_PSHARE);
         }
      }
      
      private function turnOnPrivateShare() : void
      {
         ExternalInterface.call("updateMoviePshareStatusByPlayer",this._movieId,true);
      }
      
      private function turnOnPublish() : void
      {
         ExternalInterface.call("updateMoviePublishStatusByPlayer",this._movieId,true);
      }
      
      private function goEditMovie() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("checkEditMovie",this._movieId);
         }
      }
      
      private function shareAnimation(param1:String, param2:Boolean = false) : void
      {
         var _loc4_:String = null;
         var _loc10_:URLVariables = null;
         var _loc11_:URLRequest = null;
         var _loc3_:* = "";
         var _loc5_:String = null;
         if(UtilLicense.isBoxEnvironment())
         {
            (_loc10_ = new URLVariables())["utm_source"] = param1;
            _loc10_["utm_campaign"] = UtilLicense.boxCustomerID;
            if(this._sharingPanel.userId != "" && this._sharingPanel.userId != null)
            {
               _loc10_["uid"] = this._sharingPanel.userId;
            }
            _loc4_ = UtilSharing.getBoxMovieUrl(this._movieId,_loc10_);
         }
         else if(this._sharingPanel.userId == "")
         {
            _loc4_ = ServerConstants.MOVIE_PATH + this._movieId + "?utm_source=" + param1;
         }
         else
         {
            _loc4_ = ServerConstants.MOVIE_PATH + this._movieId + "?utm_source=" + param1 + "&uid=" + this._sharingPanel.userId;
         }
         _loc4_ = escape(_loc4_);
         if(param1 == TYPE_FACEBOOK)
         {
            _loc3_ = "http://www.facebook.com/sharer.php?u=" + _loc4_ + "&t=" + escape(this._sharingPanel.movieTitle);
         }
         else if(param1 == TYPE_MYSPACE)
         {
            _loc3_ = "http://www.myspace.com/Modules/PostTo/Pages/?t=" + escape(this._sharingPanel.movieTitle) + "&c=" + escape(this._sharingPanel.embedTag) + "&u=" + _loc4_ + "&l=1";
         }
         else if(param1 == TYPE_DIGG)
         {
            _loc3_ = "http://digg.com/submit?phase=2&url=" + _loc4_ + "&title=" + escape(this._sharingPanel.movieTitle) + "&bodytext=" + escape(this._sharingPanel.movieDesc) + "&topic=videos_animation";
         }
         else if(param1 == TYPE_DELICIOUS)
         {
            _loc3_ = "http://del.icio.us/post?noui&v=4&jump=close&url=" + _loc4_ + "&title=" + escape(this._sharingPanel.movieTitle) + "&partner=GoAnimate";
         }
         else if(param1 == TYPE_REDDIT)
         {
            _loc3_ = "http://reddit.com/submit?url=" + _loc4_ + "&title=" + escape(this._sharingPanel.movieTitle);
         }
         else if(param1 == TYPE_STUMBLEUPON)
         {
            _loc3_ = "http://www.stumbleupon.com/submit?url=" + _loc4_ + "&title=" + escape(this._sharingPanel.movieTitle);
         }
         else if(param1 == TYPE_FARK)
         {
            _loc3_ = "http://cgi.fark.com/cgi/fark/submit.pl?new_url=" + _loc4_ + "&new_comment=" + escape(this._sharingPanel.movieDesc);
         }
         else if(param1 == TYPE_TWITTER)
         {
            if(UtilLicense.isBoxEnvironment())
            {
               _loc3_ = "http://twitter.com/home?status=" + escape("check out this funny movie :-) ") + _loc4_;
            }
            else
            {
               _loc3_ = ServerConstants.HOST_PATH + "/shareAnimation/twitter/" + this._movieId;
            }
         }
         if(this._sharingPanel.isGo)
         {
            try
            {
               Util.gaTracking("/goplayer/share/" + param1,this.stage);
            }
            catch(error:SecurityError)
            {
            }
            _loc11_ = new URLRequest(_loc3_);
            navigateToURL(_loc11_,"_blank");
         }
         else
         {
            this._txtShareURL.text = _loc3_;
            this.showStep2Components();
         }
         if(param2)
         {
            this.showStep2Components();
         }
         var _loc6_:Number = 800;
         var _loc7_:Glow;
         (_loc7_ = new Glow()).duration = 800;
         _loc7_.blurXFrom = 0;
         _loc7_.blurXTo = 60;
         _loc7_.blurYFrom = 0;
         _loc7_.blurYTo = 60;
         _loc7_.color = 16777215;
         var _loc8_:Blur;
         (_loc8_ = new Blur()).duration = 500;
         _loc8_.blurXFrom = 3;
         _loc8_.blurXTo = 0;
         _loc8_.blurYFrom = 3;
         _loc8_.blurYTo = 0;
         var _loc9_:Parallel;
         (_loc9_ = new Parallel()).duration = _loc6_;
         _loc9_.targets = [this._lblMsgStep2,this._lblMsgStep2b,this._txtShareURL,this._btnCopyShare];
         _loc9_.addChild(_loc7_);
         _loc9_.addChild(_loc8_);
         _loc9_.play();
         this.closeFull();
      }
      
      private function closeFull() : void
      {
         if(stage.displayState != StageDisplayState.NORMAL)
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
      }
      
      private function showStep2Components() : void
      {
         if(this._lblMsgStep2 != null)
         {
            this._lblMsgStep2.visible = true;
         }
         if(this._lblMsgStep2b != null)
         {
            this._lblMsgStep2b.visible = true;
         }
         if(this._txtShareURL != null)
         {
            this._txtShareURL.visible = true;
         }
         if(this._btnCopyShare != null)
         {
            this._btnCopyShare.visible = true;
         }
      }
      
      public function showCreditScreen(param1:String) : void
      {
         this.creditScreen.visible = true;
         this.creditText.text = param1;
         var _loc2_:int = 24;
         this.creditText.setStyle("fontSize",_loc2_);
         this.creditText.validateNow();
         while(this.creditText.textHeight > 200)
         {
            _loc2_--;
            this.creditText.setStyle("fontSize",_loc2_);
            this.creditText.validateNow();
         }
         var _loc3_:Timer = new Timer(5000,1);
         _loc3_.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCreditScreenTimerComplete);
         _loc3_.start();
      }
      
      private function onCreditScreenTimerComplete(param1:TimerEvent) : void
      {
         this.creditScreen.visible = false;
         var _loc2_:PlayerEndScreenEvent = new PlayerEndScreenEvent(PlayerEndScreenEvent.CREDIT_SCREEN_TIMES_UP,this);
         dispatchEvent(_loc2_);
      }
      
      public function WFInit() : void
      {
         var wfLoader:Loader = null;
         var gigyaConfig:Object = null;
         UtilSharing.registerObjectToHideWhenGigyaClose(this.wfLoaderBox);
         Security.allowDomain("cdn.gigya.com");
         Security.allowInsecureDomain("cdn.gigya.com");
         if(this.wfLoaderBox.numChildren > 0)
         {
            this.wfLoaderBox.visible = true;
            return;
         }
         wfLoader = new Loader();
         if(this.wfLoaderBox.numChildren == 0)
         {
            gigyaConfig = this.gigyaConfig;
            wfLoader.contentLoaderInfo.sharedEvents.addEventListener("sendConfig",function(param1:Event):void
            {
               var _loc2_:DynamicEvent = new DynamicEvent("onStoreConfig");
               _loc2_.cfg = gigyaConfig;
               wfLoader.contentLoaderInfo.sharedEvents.dispatchEvent(_loc2_);
            });
            wfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
            {
               var _loc2_:UIComponent = new UIComponent();
               wfLoaderBox.addChild(_loc2_);
               _loc2_.addChild(wfLoader);
            });
            wfLoader.load(new URLRequest("http://cdn.gigya.com/wildfire/swf/wildfireInAS3.swf?ModuleID=cfg"));
         }
         else
         {
            MovieClip(Loader(UIComponent(this.wfLoaderBox.getChildAt(0)).getChildAt(0)).content).INIT();
         }
      }
      
      private function _PlayerEndScreen_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "domo_private";
         _loc1_.overrides = [this._PlayerEndScreen_SetProperty1_i(),this._PlayerEndScreen_SetProperty2_i(),this._PlayerEndScreen_SetProperty3_i()];
         return _loc1_;
      }
      
      private function _PlayerEndScreen_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "visible";
         _loc1_.value = false;
         this._PlayerEndScreen_SetProperty1 = _loc1_;
         BindingManager.executeBindings(this,"_PlayerEndScreen_SetProperty1",this._PlayerEndScreen_SetProperty1);
         return _loc1_;
      }
      
      private function _PlayerEndScreen_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "label";
         _loc1_.value = "";
         this._PlayerEndScreen_SetProperty2 = _loc1_;
         BindingManager.executeBindings(this,"_PlayerEndScreen_SetProperty2",this._PlayerEndScreen_SetProperty2);
         return _loc1_;
      }
      
      private function _PlayerEndScreen_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "label";
         _loc1_.value = "";
         this._PlayerEndScreen_SetProperty3 = _loc1_;
         BindingManager.executeBindings(this,"_PlayerEndScreen_SetProperty3",this._PlayerEndScreen_SetProperty3);
         return _loc1_;
      }
      
      private function _PlayerEndScreen_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "cn_private";
         _loc1_.overrides = [this._PlayerEndScreen_SetProperty4_i(),this._PlayerEndScreen_SetProperty5_i()];
         return _loc1_;
      }
      
      private function _PlayerEndScreen_SetProperty4_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "label";
         _loc1_.value = "";
         this._PlayerEndScreen_SetProperty4 = _loc1_;
         BindingManager.executeBindings(this,"_PlayerEndScreen_SetProperty4",this._PlayerEndScreen_SetProperty4);
         return _loc1_;
      }
      
      private function _PlayerEndScreen_SetProperty5_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "label";
         _loc1_.value = "";
         this._PlayerEndScreen_SetProperty5 = _loc1_;
         BindingManager.executeBindings(this,"_PlayerEndScreen_SetProperty5",this._PlayerEndScreen_SetProperty5);
         return _loc1_;
      }
      
      public function ___PlayerEndScreen_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___btnReplay2_click(param1:MouseEvent) : void
      {
         this.onBtnReplayClick(param1);
      }
      
      public function ___btnCreate2_click(param1:MouseEvent) : void
      {
         this.onBtnNewAnimationClick(param1);
      }
      
      public function ___btnReplay_click(param1:MouseEvent) : void
      {
         this.onBtnReplayClick(param1);
      }
      
      public function ___btnEmail_click(param1:MouseEvent) : void
      {
         this.onClickSharingButtons(param1);
      }
      
      public function ___btnEmbed_click(param1:MouseEvent) : void
      {
         this.onClickSharingButtons(param1);
      }
      
      public function ___btnCreate_click(param1:MouseEvent) : void
      {
         this.onClickSharingButtons(param1);
      }
      
      public function ___btnNextMovie_click(param1:MouseEvent) : void
      {
         this.onBtnNextMovieClick(param1);
      }
      
      public function ___btnFacebook_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_FACEBOOK);
      }
      
      public function ___btnTwitter_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_TWITTER);
      }
      
      public function ___btnMySpace_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_MYSPACE);
      }
      
      public function ___btnGigya_click(param1:MouseEvent) : void
      {
         this.WFInit();
      }
      
      public function ___btnFacebookShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_FACEBOOK);
      }
      
      public function ___btnTwitterShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_TWITTER);
      }
      
      public function ___btnDeliciousShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_DELICIOUS);
      }
      
      public function ___btnMySpaceShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_MYSPACE);
      }
      
      public function ___btnDiggShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_DIGG);
      }
      
      public function ___btnRedditShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_REDDIT);
      }
      
      public function ___btnStumbleuponShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_STUMBLEUPON);
      }
      
      public function ___btnFarkShare_click(param1:MouseEvent) : void
      {
         this.shareAnimation(TYPE_FARK);
      }
      
      public function ___btnCopyShare_click(param1:MouseEvent) : void
      {
         this._sharingPanel.copyData(this._txtShareURL);
      }
      
      public function ___sharingPanel_Close(param1:SharingEvent) : void
      {
         this.showBasicSharingScreen();
      }
      
      public function ___btnEndReminderPub_click(param1:MouseEvent) : void
      {
         this.turnOnPublish();
      }
      
      public function ___btnEndReminderPri_click(param1:MouseEvent) : void
      {
         this.turnOnPrivateShare();
      }
      
      public function ___PlayerEndScreen_IconTextButton11_click(param1:MouseEvent) : void
      {
         this.onBtnReplayClick(param1);
      }
      
      public function ___btnEdit_click(param1:MouseEvent) : void
      {
         this.goEditMovie();
      }
      
      public function ___PlayerEndScreen_IconTextButton12_click(param1:MouseEvent) : void
      {
         this.onBtnReplayClick(param1);
      }
      
      public function __replay_btn_click(param1:MouseEvent) : void
      {
         this.onBtnReplayClick(param1);
      }
      
      private function _PlayerEndScreen_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Replay");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnReplay2.label");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Create");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCreate2.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Replay");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnReplay.label");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Email");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnEmail.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Embed");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnEmbed.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Create");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCreate.label");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Next Movie") + " >";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnNextMovie.label");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Share on Facebook");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnFacebook.label");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Share on Twitter");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnTwitter.label");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Share on MySpace");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnMySpace.label");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","player_gigyashare");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnGigya.text");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","player_privated");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtEndReminder1.text");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","player_shareit");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtEndReminder2.text");
         result[13] = new Binding(this,function():Array
         {
            var _loc1_:* = [new DropShadowFilter(5,45,0,0.3)];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"_txtEndReminder2.filters");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","player_privatesharing");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtEndReminder3.text");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Publish as public");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnEndReminderPub.label");
         result[16] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Publish as private");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnEndReminderPri.label");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Replay");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PlayerEndScreen_IconTextButton11.label");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","player_privated");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PlayerEndScreen_Label7.text");
         result[19] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Edit your animation");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnEdit.label");
         result[20] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Replay");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PlayerEndScreen_IconTextButton12.label");
         result[21] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Replay");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"replay_btn.label");
         result[22] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Music licensed under Creative Commons Share Alike") + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PlayerEndScreen_Text1.text");
         result[23] = new Binding(this,null,null,"_PlayerEndScreen_SetProperty1.target","_txtEndReminder1");
         result[24] = new Binding(this,null,null,"_PlayerEndScreen_SetProperty2.target","_btnEndReminderPub");
         result[25] = new Binding(this,null,null,"_PlayerEndScreen_SetProperty3.target","_btnEndReminderPri");
         result[26] = new Binding(this,null,null,"_PlayerEndScreen_SetProperty4.target","_btnEndReminderPub");
         result[27] = new Binding(this,null,null,"_PlayerEndScreen_SetProperty5.target","_btnEndReminderPri");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopyShare() : Button
      {
         return this._1269660595_btnCopyShare;
      }
      
      public function set _btnCopyShare(param1:Button) : void
      {
         var _loc2_:Object = this._1269660595_btnCopyShare;
         if(_loc2_ !== param1)
         {
            this._1269660595_btnCopyShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopyShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCreate() : IconTextButton
      {
         return this._1355558663_btnCreate;
      }
      
      public function set _btnCreate(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1355558663_btnCreate;
         if(_loc2_ !== param1)
         {
            this._1355558663_btnCreate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCreate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCreate2() : IconTextButton
      {
         return this._927354457_btnCreate2;
      }
      
      public function set _btnCreate2(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._927354457_btnCreate2;
         if(_loc2_ !== param1)
         {
            this._927354457_btnCreate2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCreate2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDeliciousShare() : Button
      {
         return this._1480051251_btnDeliciousShare;
      }
      
      public function set _btnDeliciousShare(param1:Button) : void
      {
         var _loc2_:Object = this._1480051251_btnDeliciousShare;
         if(_loc2_ !== param1)
         {
            this._1480051251_btnDeliciousShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDeliciousShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDiggShare() : Button
      {
         return this._561998435_btnDiggShare;
      }
      
      public function set _btnDiggShare(param1:Button) : void
      {
         var _loc2_:Object = this._561998435_btnDiggShare;
         if(_loc2_ !== param1)
         {
            this._561998435_btnDiggShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDiggShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEdit() : Button
      {
         return this._1730971321_btnEdit;
      }
      
      public function set _btnEdit(param1:Button) : void
      {
         var _loc2_:Object = this._1730971321_btnEdit;
         if(_loc2_ !== param1)
         {
            this._1730971321_btnEdit = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEdit",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEmail() : IconTextButton
      {
         return this._2120243201_btnEmail;
      }
      
      public function set _btnEmail(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2120243201_btnEmail;
         if(_loc2_ !== param1)
         {
            this._2120243201_btnEmail = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEmail",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEmbed() : IconTextButton
      {
         return this._2120242372_btnEmbed;
      }
      
      public function set _btnEmbed(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2120242372_btnEmbed;
         if(_loc2_ !== param1)
         {
            this._2120242372_btnEmbed = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEmbed",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEndReminderPri() : Button
      {
         return this._1041418231_btnEndReminderPri;
      }
      
      public function set _btnEndReminderPri(param1:Button) : void
      {
         var _loc2_:Object = this._1041418231_btnEndReminderPri;
         if(_loc2_ !== param1)
         {
            this._1041418231_btnEndReminderPri = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEndReminderPri",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEndReminderPub() : Button
      {
         return this._1041418317_btnEndReminderPub;
      }
      
      public function set _btnEndReminderPub(param1:Button) : void
      {
         var _loc2_:Object = this._1041418317_btnEndReminderPub;
         if(_loc2_ !== param1)
         {
            this._1041418317_btnEndReminderPub = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEndReminderPub",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFacebook() : IconTextButton
      {
         return this._1654898563_btnFacebook;
      }
      
      public function set _btnFacebook(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1654898563_btnFacebook;
         if(_loc2_ !== param1)
         {
            this._1654898563_btnFacebook = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFacebook",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFacebookShare() : Button
      {
         return this._1658267108_btnFacebookShare;
      }
      
      public function set _btnFacebookShare(param1:Button) : void
      {
         var _loc2_:Object = this._1658267108_btnFacebookShare;
         if(_loc2_ !== param1)
         {
            this._1658267108_btnFacebookShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFacebookShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFarkShare() : Button
      {
         return this._347601646_btnFarkShare;
      }
      
      public function set _btnFarkShare(param1:Button) : void
      {
         var _loc2_:Object = this._347601646_btnFarkShare;
         if(_loc2_ !== param1)
         {
            this._347601646_btnFarkShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFarkShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnGigya() : Label
      {
         return this._2118509072_btnGigya;
      }
      
      public function set _btnGigya(param1:Label) : void
      {
         var _loc2_:Object = this._2118509072_btnGigya;
         if(_loc2_ !== param1)
         {
            this._2118509072_btnGigya = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnGigya",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMySpace() : IconTextButton
      {
         return this._1396665949_btnMySpace;
      }
      
      public function set _btnMySpace(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1396665949_btnMySpace;
         if(_loc2_ !== param1)
         {
            this._1396665949_btnMySpace = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMySpace",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMySpaceShare() : Button
      {
         return this._883581826_btnMySpaceShare;
      }
      
      public function set _btnMySpaceShare(param1:Button) : void
      {
         var _loc2_:Object = this._883581826_btnMySpaceShare;
         if(_loc2_ !== param1)
         {
            this._883581826_btnMySpaceShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMySpaceShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnNextMovie() : IconTextButton
      {
         return this._1563420960_btnNextMovie;
      }
      
      public function set _btnNextMovie(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1563420960_btnNextMovie;
         if(_loc2_ !== param1)
         {
            this._1563420960_btnNextMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnNextMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRedditShare() : Button
      {
         return this._1058421316_btnRedditShare;
      }
      
      public function set _btnRedditShare(param1:Button) : void
      {
         var _loc2_:Object = this._1058421316_btnRedditShare;
         if(_loc2_ !== param1)
         {
            this._1058421316_btnRedditShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRedditShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnReplay() : IconTextButton
      {
         return this._937789468_btnReplay;
      }
      
      public function set _btnReplay(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._937789468_btnReplay;
         if(_loc2_ !== param1)
         {
            this._937789468_btnReplay = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnReplay",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnReplay2() : IconTextButton
      {
         return this._993297614_btnReplay2;
      }
      
      public function set _btnReplay2(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._993297614_btnReplay2;
         if(_loc2_ !== param1)
         {
            this._993297614_btnReplay2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnReplay2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnStumbleuponShare() : Button
      {
         return this._382316096_btnStumbleuponShare;
      }
      
      public function set _btnStumbleuponShare(param1:Button) : void
      {
         var _loc2_:Object = this._382316096_btnStumbleuponShare;
         if(_loc2_ !== param1)
         {
            this._382316096_btnStumbleuponShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnStumbleuponShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnTwitter() : IconTextButton
      {
         return this._1017546218_btnTwitter;
      }
      
      public function set _btnTwitter(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1017546218_btnTwitter;
         if(_loc2_ !== param1)
         {
            this._1017546218_btnTwitter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnTwitter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnTwitterShare() : Button
      {
         return this._976239767_btnTwitterShare;
      }
      
      public function set _btnTwitterShare(param1:Button) : void
      {
         var _loc2_:Object = this._976239767_btnTwitterShare;
         if(_loc2_ !== param1)
         {
            this._976239767_btnTwitterShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnTwitterShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEndReminder() : Canvas
      {
         return this._1208694428_canEndReminder;
      }
      
      public function set _canEndReminder(param1:Canvas) : void
      {
         var _loc2_:Object = this._1208694428_canEndReminder;
         if(_loc2_ !== param1)
         {
            this._1208694428_canEndReminder = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEndReminder",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canShare() : VBox
      {
         return this._47353010_canShare;
      }
      
      public function set _canShare(param1:VBox) : void
      {
         var _loc2_:Object = this._47353010_canShare;
         if(_loc2_ !== param1)
         {
            this._47353010_canShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canShareOther() : Canvas
      {
         return this._34866078_canShareOther;
      }
      
      public function set _canShareOther(param1:Canvas) : void
      {
         var _loc2_:Object = this._34866078_canShareOther;
         if(_loc2_ !== param1)
         {
            this._34866078_canShareOther = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canShareOther",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _editUI() : Canvas
      {
         return this._1400642365_editUI;
      }
      
      public function set _editUI(param1:Canvas) : void
      {
         var _loc2_:Object = this._1400642365_editUI;
         if(_loc2_ !== param1)
         {
            this._1400642365_editUI = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_editUI",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _endScreen_previewMode() : Canvas
      {
         return this._1135317132_endScreen_previewMode;
      }
      
      public function set _endScreen_previewMode(param1:Canvas) : void
      {
         var _loc2_:Object = this._1135317132_endScreen_previewMode;
         if(_loc2_ !== param1)
         {
            this._1135317132_endScreen_previewMode = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_endScreen_previewMode",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _endingScreen_privateMode() : Canvas
      {
         return this._380159833_endingScreen_privateMode;
      }
      
      public function set _endingScreen_privateMode(param1:Canvas) : void
      {
         var _loc2_:Object = this._380159833_endingScreen_privateMode;
         if(_loc2_ !== param1)
         {
            this._380159833_endingScreen_privateMode = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_endingScreen_privateMode",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _endingScreen_publicMode() : Canvas
      {
         return this._1749280839_endingScreen_publicMode;
      }
      
      public function set _endingScreen_publicMode(param1:Canvas) : void
      {
         var _loc2_:Object = this._1749280839_endingScreen_publicMode;
         if(_loc2_ !== param1)
         {
            this._1749280839_endingScreen_publicMode = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_endingScreen_publicMode",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _hboxBtn() : HBox
      {
         return this._1213830726_hboxBtn;
      }
      
      public function set _hboxBtn(param1:HBox) : void
      {
         var _loc2_:Object = this._1213830726_hboxBtn;
         if(_loc2_ !== param1)
         {
            this._1213830726_hboxBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hboxBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _hboxBtn2() : HBox
      {
         return this._1025953208_hboxBtn2;
      }
      
      public function set _hboxBtn2(param1:HBox) : void
      {
         var _loc2_:Object = this._1025953208_hboxBtn2;
         if(_loc2_ !== param1)
         {
            this._1025953208_hboxBtn2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hboxBtn2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblMsgStep2() : Label
      {
         return this._1930826236_lblMsgStep2;
      }
      
      public function set _lblMsgStep2(param1:Label) : void
      {
         var _loc2_:Object = this._1930826236_lblMsgStep2;
         if(_loc2_ !== param1)
         {
            this._1930826236_lblMsgStep2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblMsgStep2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblMsgStep2b() : Label
      {
         return this._273928730_lblMsgStep2b;
      }
      
      public function set _lblMsgStep2b(param1:Label) : void
      {
         var _loc2_:Object = this._273928730_lblMsgStep2b;
         if(_loc2_ !== param1)
         {
            this._273928730_lblMsgStep2b = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblMsgStep2b",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sharingPanel() : SharingPanel
      {
         return this._356760679_sharingPanel;
      }
      
      public function set _sharingPanel(param1:SharingPanel) : void
      {
         var _loc2_:Object = this._356760679_sharingPanel;
         if(_loc2_ !== param1)
         {
            this._356760679_sharingPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sharingPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sharingStyle1() : Canvas
      {
         return this._1721552227_sharingStyle1;
      }
      
      public function set _sharingStyle1(param1:Canvas) : void
      {
         var _loc2_:Object = this._1721552227_sharingStyle1;
         if(_loc2_ !== param1)
         {
            this._1721552227_sharingStyle1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sharingStyle1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sharingViewStack() : ViewStack
      {
         return this._348798918_sharingViewStack;
      }
      
      public function set _sharingViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._348798918_sharingViewStack;
         if(_loc2_ !== param1)
         {
            this._348798918_sharingViewStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sharingViewStack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sharing_BasicFeature() : Canvas
      {
         return this._2063858794_sharing_BasicFeature;
      }
      
      public function set _sharing_BasicFeature(param1:Canvas) : void
      {
         var _loc2_:Object = this._2063858794_sharing_BasicFeature;
         if(_loc2_ !== param1)
         {
            this._2063858794_sharing_BasicFeature = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sharing_BasicFeature",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtEndReminder1() : Label
      {
         return this._1829965899_txtEndReminder1;
      }
      
      public function set _txtEndReminder1(param1:Label) : void
      {
         var _loc2_:Object = this._1829965899_txtEndReminder1;
         if(_loc2_ !== param1)
         {
            this._1829965899_txtEndReminder1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtEndReminder1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtEndReminder2() : Label
      {
         return this._1829965898_txtEndReminder2;
      }
      
      public function set _txtEndReminder2(param1:Label) : void
      {
         var _loc2_:Object = this._1829965898_txtEndReminder2;
         if(_loc2_ !== param1)
         {
            this._1829965898_txtEndReminder2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtEndReminder2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtEndReminder3() : Label
      {
         return this._1829965897_txtEndReminder3;
      }
      
      public function set _txtEndReminder3(param1:Label) : void
      {
         var _loc2_:Object = this._1829965897_txtEndReminder3;
         if(_loc2_ !== param1)
         {
            this._1829965897_txtEndReminder3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtEndReminder3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtShareURL() : TextInput
      {
         return this._612233759_txtShareURL;
      }
      
      public function set _txtShareURL(param1:TextInput) : void
      {
         var _loc2_:Object = this._612233759_txtShareURL;
         if(_loc2_ !== param1)
         {
            this._612233759_txtShareURL = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtShareURL",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsPlayerEnd() : ViewStack
      {
         return this._1093743166_vsPlayerEnd;
      }
      
      public function set _vsPlayerEnd(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1093743166_vsPlayerEnd;
         if(_loc2_ !== param1)
         {
            this._1093743166_vsPlayerEnd = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsPlayerEnd",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get blank_screen() : Canvas
      {
         return this._567556681blank_screen;
      }
      
      public function set blank_screen(param1:Canvas) : void
      {
         var _loc2_:Object = this._567556681blank_screen;
         if(_loc2_ !== param1)
         {
            this._567556681blank_screen = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blank_screen",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buttonBox() : HBox
      {
         return this._11548985buttonBox;
      }
      
      public function set buttonBox(param1:HBox) : void
      {
         var _loc2_:Object = this._11548985buttonBox;
         if(_loc2_ !== param1)
         {
            this._11548985buttonBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buttonBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get creditScreen() : VBox
      {
         return this._1170704187creditScreen;
      }
      
      public function set creditScreen(param1:VBox) : void
      {
         var _loc2_:Object = this._1170704187creditScreen;
         if(_loc2_ !== param1)
         {
            this._1170704187creditScreen = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"creditScreen",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get creditText() : Text
      {
         return this._564314170creditText;
      }
      
      public function set creditText(param1:Text) : void
      {
         var _loc2_:Object = this._564314170creditText;
         if(_loc2_ !== param1)
         {
            this._564314170creditText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"creditText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get replay_btn() : IconTextButton
      {
         return this._1212896764replay_btn;
      }
      
      public function set replay_btn(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1212896764replay_btn;
         if(_loc2_ !== param1)
         {
            this._1212896764replay_btn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"replay_btn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wfLoaderBox() : Box
      {
         return this._1445642921wfLoaderBox;
      }
      
      public function set wfLoaderBox(param1:Box) : void
      {
         var _loc2_:Object = this._1445642921wfLoaderBox;
         if(_loc2_ !== param1)
         {
            this._1445642921wfLoaderBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wfLoaderBox",_loc2_,param1));
            }
         }
      }
   }
}
