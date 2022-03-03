package anifire.components.containers
{
   import anifire.components.studio.MainStage;
   import anifire.constant.LicenseConstants;
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   import anifire.core.ProgramEffectAsset;
   import anifire.effect.ZoomEffect;
   import anifire.events.AssetEvent;
   import anifire.events.SceneOptionEvent;
   import anifire.util.UtilDict;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.Grid;
   import mx.containers.GridItem;
   import mx.containers.GridRow;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.Label;
   import mx.controls.Menu;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class CameraSettingPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _CameraSettingPanel_AssetTiming1:AssetTiming;
      
      public var _CameraSettingPanel_Label1:Label;
      
      public var _CameraSettingPanel_Label10:Label;
      
      public var _CameraSettingPanel_Label11:Label;
      
      public var _CameraSettingPanel_Label12:Label;
      
      public var _CameraSettingPanel_Label13:Label;
      
      public var _CameraSettingPanel_Label14:Label;
      
      public var _CameraSettingPanel_Label2:Label;
      
      public var _CameraSettingPanel_Label3:Label;
      
      public var _CameraSettingPanel_Label4:Label;
      
      public var _CameraSettingPanel_Label5:Label;
      
      public var _CameraSettingPanel_Label6:Label;
      
      public var _CameraSettingPanel_Label7:Label;
      
      public var _CameraSettingPanel_Label8:Label;
      
      public var _CameraSettingPanel_Label9:Label;
      
      private var _1329646016_btnPan:Canvas;
      
      private var _789363156btnZoomIn:Button;
      
      private var _1299539841btnZoomOut:Button;
      
      private var _1920941205cb_guide1:CheckBox;
      
      private var _2025705170endHeightTxt:TextInput;
      
      private var _1370546373endWidthTxt:TextInput;
      
      private var _1607143853endXTxt:TextInput;
      
      private var _1607114062endYTxt:TextInput;
      
      private var _1968833145startHeightTxt:TextInput;
      
      private var _1260018356startWidthTxt:TextInput;
      
      private var _2129195430startXTxt:TextInput;
      
      private var _2129165639startYTxt:TextInput;
      
      private var _2060497896subtitle:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _1827565232_target:ProgramEffectAsset;
      
      private var _cam1:Rectangle;
      
      private var _cam2:Rectangle;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function CameraSettingPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___CameraSettingPanel_Canvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.backgroundColor = 16382457;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":81,
                        "width":260,
                        "height":136,
                        "horizontalScrollPolicy":"off",
                        "styleName":"bgCameraBottom",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___CameraSettingPanel_Button1_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "right":5,
                                 "top":5,
                                 "width":15,
                                 "height":15,
                                 "styleName":"btnSettingCamera",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___CameraSettingPanel_Button2_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":15,
                                 "height":15,
                                 "right":23,
                                 "top":5,
                                 "styleName":"btnDeleteCamera",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "right":38,
                                 "top":16,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Grid,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalGap = 0;
                                       this.verticalGap = 2;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":194,
                                          "height":60,
                                          "horizontalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":GridRow,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalAlign = "center";
                                                this.verticalAlign = "middle";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"childDescriptors":[new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_CameraSettingPanel_Label1",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"styleName":"textTiny"};
                                                         }
                                                      })]};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_CameraSettingPanel_Label2",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"styleName":"textTiny"};
                                                         }
                                                      })]};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":TextInput,
                                                         "id":"endWidthTxt",
                                                         "events":{
                                                            "enter":"__endWidthTxt_enter",
                                                            "focusOut":"__endWidthTxt_focusOut"
                                                         },
                                                         "stylesFactory":function():void
                                                         {
                                                            this.textAlign = "center";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "width":45,
                                                               "styleName":"myTextInput"
                                                            };
                                                         }
                                                      })]};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_CameraSettingPanel_Label3",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"styleName":"textTiny"};
                                                         }
                                                      })]};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":TextInput,
                                                         "id":"endHeightTxt",
                                                         "events":{
                                                            "enter":"__endHeightTxt_enter",
                                                            "focusOut":"__endHeightTxt_focusOut"
                                                         },
                                                         "stylesFactory":function():void
                                                         {
                                                            this.textAlign = "center";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "width":45,
                                                               "styleName":"myTextInput"
                                                            };
                                                         }
                                                      })]};
                                                   }
                                                })]};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":GridRow,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalAlign = "center";
                                                this.verticalAlign = "middle";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"childDescriptors":[new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_CameraSettingPanel_Label4",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"styleName":"textTiny"};
                                                         }
                                                      })]};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_CameraSettingPanel_Label5",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"styleName":"textTiny"};
                                                         }
                                                      })]};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":TextInput,
                                                         "id":"endXTxt",
                                                         "events":{
                                                            "enter":"__endXTxt_enter",
                                                            "focusOut":"__endXTxt_focusOut"
                                                         },
                                                         "stylesFactory":function():void
                                                         {
                                                            this.textAlign = "center";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "width":45,
                                                               "styleName":"myTextInput"
                                                            };
                                                         }
                                                      })]};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_CameraSettingPanel_Label6",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"styleName":"textTiny"};
                                                         }
                                                      })]};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":GridItem,
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":TextInput,
                                                         "id":"endYTxt",
                                                         "events":{
                                                            "enter":"__endYTxt_enter",
                                                            "focusOut":"__endYTxt_focusOut"
                                                         },
                                                         "stylesFactory":function():void
                                                         {
                                                            this.textAlign = "center";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "width":45,
                                                               "styleName":"myTextInput"
                                                            };
                                                         }
                                                      })]};
                                                   }
                                                })]};
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                              this.verticalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "right":16,
                                 "top":62,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"subtitle",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"textTiny"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":AssetTiming,
                                    "id":"_CameraSettingPanel_AssetTiming1",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":165,
                                          "horizontalScrollPolicy":"off",
                                          "verticalCenter":0,
                                          "right":0,
                                          "clipContent":false
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_btnPan",
                           "events":{"click":"___btnPan_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":260,
                                 "height":136,
                                 "styleName":"bgCameraBottomMask",
                                 "buttonMode":true,
                                 "mouseChildren":false,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CameraSettingPanel_Label7",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "verticalCenter":18,
                                          "horizontalCenter":0
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
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":0,
                        "width":260,
                        "height":87,
                        "styleName":"bgCameraTop",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___CameraSettingPanel_Button3_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "right":4,
                                 "top":4,
                                 "width":15,
                                 "height":15,
                                 "styleName":"btnSettingCamera",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnZoomOut",
                           "events":{"click":"__btnZoomOut_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":15,
                                 "height":15,
                                 "right":23,
                                 "top":5,
                                 "styleName":"btnZoomOutCamera",
                                 "visible":false,
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"btnZoomIn",
                           "events":{"click":"__btnZoomIn_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":15,
                                 "height":15,
                                 "right":23,
                                 "top":5,
                                 "styleName":"btnZoomInCamera",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Grid,
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 0;
                              this.verticalGap = 2;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":194,
                                 "height":60,
                                 "right":38,
                                 "top":8,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":GridRow,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalAlign = "center";
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CameraSettingPanel_Label8",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"styleName":"textTiny"};
                                                }
                                             })]};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CameraSettingPanel_Label9",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"styleName":"textTiny"};
                                                }
                                             })]};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"startWidthTxt",
                                                "events":{
                                                   "enter":"__startWidthTxt_enter",
                                                   "focusOut":"__startWidthTxt_focusOut"
                                                },
                                                "stylesFactory":function():void
                                                {
                                                   this.textAlign = "center";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":45,
                                                      "styleName":"myTextInput"
                                                   };
                                                }
                                             })]};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CameraSettingPanel_Label10",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"styleName":"textTiny"};
                                                }
                                             })]};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"startHeightTxt",
                                                "events":{
                                                   "enter":"__startHeightTxt_enter",
                                                   "focusOut":"__startHeightTxt_focusOut"
                                                },
                                                "stylesFactory":function():void
                                                {
                                                   this.textAlign = "center";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":45,
                                                      "styleName":"myTextInput"
                                                   };
                                                }
                                             })]};
                                          }
                                       })]};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":GridRow,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalAlign = "center";
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CameraSettingPanel_Label11",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"styleName":"textTiny"};
                                                }
                                             })]};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CameraSettingPanel_Label12",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"styleName":"textTiny"};
                                                }
                                             })]};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"startXTxt",
                                                "events":{
                                                   "enter":"__startXTxt_enter",
                                                   "focusOut":"__startXTxt_focusOut"
                                                },
                                                "stylesFactory":function():void
                                                {
                                                   this.textAlign = "center";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":45,
                                                      "styleName":"myTextInput"
                                                   };
                                                }
                                             })]};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CameraSettingPanel_Label13",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"styleName":"textTiny"};
                                                }
                                             })]};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":GridItem,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"startYTxt",
                                                "events":{
                                                   "enter":"__startYTxt_enter",
                                                   "focusOut":"__startYTxt_focusOut"
                                                },
                                                "stylesFactory":function():void
                                                {
                                                   this.textAlign = "center";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":45,
                                                      "styleName":"myTextInput"
                                                   };
                                                }
                                             })]};
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":240,
                        "width":260,
                        "horizontalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"_CameraSettingPanel_Label14",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":0,
                                 "y":2
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"cb_guide1",
                           "events":{"change":"__cb_guide1_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":4,
                                 "y":16
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._cam1 = LicenseConstants.getStageRect();
         this._cam2 = LicenseConstants.getStageRect();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._CameraSettingPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_CameraSettingPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return CameraSettingPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___CameraSettingPanel_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         CameraSettingPanel._watcherSetupUtil = param1;
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
            this.backgroundColor = 16382457;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get cam2() : Rectangle
      {
         return this._cam2;
      }
      
      public function set cam2(param1:Rectangle) : void
      {
         this._cam2 = param1;
         this.removeMyEventListener();
         this.endXTxt.text = this.localToDisplayX(this._cam2.x);
         this.endYTxt.text = this.localToDisplayY(this._cam2.y);
         this.endWidthTxt.text = this._cam2.width.toFixed(0) + "px";
         this.endHeightTxt.text = this._cam2.height.toFixed(0) + "px";
         this.addMyEventListener();
      }
      
      public function get cam1() : Rectangle
      {
         return this._cam1;
      }
      
      private function updateCam1Value(param1:SceneOptionEvent) : void
      {
         this.removeEventListener(SceneOptionEvent.ZOOM1_UPDATED,this.updateCam1Value);
         this.cam1 = param1.rect;
         this.addMyEventListener();
      }
      
      private function updateCam2Value(param1:SceneOptionEvent) : void
      {
         this.removeEventListener(SceneOptionEvent.ZOOM2_UPDATED,this.updateCam2Value);
         this.cam2 = param1.rect;
         this.addMyEventListener();
      }
      
      public function set cam1(param1:Rectangle) : void
      {
         this._cam1 = param1;
         this.removeMyEventListener();
         this.startXTxt.text = this.localToDisplayX(this._cam1.x);
         this.startYTxt.text = this.localToDisplayY(this._cam1.y);
         this.startWidthTxt.text = this._cam1.width.toFixed(0) + "px";
         this.startHeightTxt.text = this._cam1.height.toFixed(0) + "px";
         this.addMyEventListener();
      }
      
      private function addMyEventListener() : void
      {
         this._target.addEventListener(AssetEvent.ASSET_MOVED,this.onAssetChanged);
         if(this._target.motionShadow)
         {
            this._target.motionShadow.addEventListener(AssetEvent.ASSET_MOVED,this.onAssetChanged);
         }
      }
      
      private function removeMyEventListener() : void
      {
         this._target.removeEventListener(AssetEvent.ASSET_MOVED,this.onAssetChanged);
         if(this._target.motionShadow)
         {
            this._target.motionShadow.removeEventListener(AssetEvent.ASSET_MOVED,this.onAssetChanged);
         }
      }
      
      public function set target(param1:Object) : void
      {
         if(this._target)
         {
            this.removeMyEventListener();
         }
         this._target = param1 as ProgramEffectAsset;
         this.cb_guide1.selected = false;
         if(this._target.guide_style == 1)
         {
            this.cb_guide1.selected = true;
         }
         this.addMyEventListener();
         this.onAssetChanged();
      }
      
      private function init() : void
      {
         this.addEventListener(SceneOptionEvent.CAM1_CHANGED,this.updateCam1);
         this.addEventListener(SceneOptionEvent.CAM2_CHANGED,this.updateCam2);
      }
      
      private function updateCam1(param1:SceneOptionEvent) : void
      {
         var _loc3_:SceneOptionEvent = null;
         var _loc2_:Rectangle = param1.rect;
         if(this._target)
         {
            this.removeMyEventListener();
            this._target.width = _loc2_.width;
            this._target.height = _loc2_.height;
            this._target.x = _loc2_.x;
            this._target.y = _loc2_.y;
            this.addMyEventListener();
            this.refreshControl();
            _loc3_ = new SceneOptionEvent(SceneOptionEvent.ZOOM1_UPDATED);
            _loc3_.rect = new Rectangle(this._target.x,this._target.y,this._target.width,this._target.height);
            this.dispatchEvent(_loc3_);
         }
      }
      
      private function updateCam2(param1:SceneOptionEvent) : void
      {
         var _loc3_:SceneOptionEvent = null;
         var _loc2_:Rectangle = param1.rect;
         if(this._target.motionShadow)
         {
            this.removeMyEventListener();
            this._target.motionShadow.width = _loc2_.width;
            this._target.motionShadow.height = _loc2_.height;
            this._target.motionShadow.x = _loc2_.x;
            this._target.motionShadow.y = _loc2_.y;
            this.addMyEventListener();
            this.refreshShadowControl();
            _loc3_ = new SceneOptionEvent(SceneOptionEvent.ZOOM2_UPDATED);
            _loc3_.rect = new Rectangle(this._target.motionShadow.x,this._target.motionShadow.y,this._target.motionShadow.width,this._target.motionShadow.height);
            this.dispatchEvent(_loc3_);
         }
      }
      
      private function validateRectangle(param1:Rectangle) : Boolean
      {
         if(param1.size.length > 0 && param1.topLeft.length > 0)
         {
            return true;
         }
         return false;
      }
      
      private function onTextInputChange(param1:Event) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:SceneOptionEvent = null;
         var _loc11_:Rectangle = null;
         var _loc12_:Rectangle = null;
         var _loc13_:Rectangle = null;
         var _loc14_:Rectangle = null;
         var _loc2_:Rectangle = LicenseConstants.getStageRect();
         var _loc3_:Rectangle = this.cam1.clone();
         var _loc4_:Rectangle = this.cam2.clone();
         var _loc10_:TextInput;
         if((_loc10_ = TextInput(param1.currentTarget)).id.indexOf("start") > -1)
         {
            _loc5_ = this.displayToLocalX(UtilUnitConvert.removeUnit(this.startXTxt.text,"px"));
            _loc6_ = this.displayToLocalY(UtilUnitConvert.removeUnit(this.startYTxt.text,"px"));
            if(_loc10_.id.indexOf("Width") > -1)
            {
               _loc8_ = (_loc7_ = UtilUnitConvert.removeUnit(this.startWidthTxt.text,"px")) / LicenseConstants.getScreenRatio();
            }
            else if(_loc10_.id.indexOf("Height") > -1)
            {
               _loc8_ = UtilUnitConvert.removeUnit(this.startHeightTxt.text,"px");
               _loc7_ = LicenseConstants.getScreenRatio() * _loc8_;
            }
            else
            {
               _loc7_ = UtilUnitConvert.removeUnit(this.startWidthTxt.text,"px");
               _loc8_ = UtilUnitConvert.removeUnit(this.startHeightTxt.text,"px");
            }
            _loc11_ = new Rectangle(_loc5_,_loc6_,_loc7_,_loc8_);
            if(this.validateRectangle(_loc11_) && _loc2_.containsRect(_loc11_))
            {
               if(!(_loc12_ = _loc11_).equals(_loc3_))
               {
                  this.removeMyEventListener();
                  (_loc9_ = new SceneOptionEvent(SceneOptionEvent.CAM1_CHANGED)).rect = _loc12_;
                  this.dispatchEvent(_loc9_);
                  this.addEventListener(SceneOptionEvent.ZOOM1_UPDATED,this.updateCam1Value);
               }
               else
               {
                  this.cam1 = _loc3_;
               }
            }
            else
            {
               this.cam1 = _loc3_;
            }
         }
         if(_loc10_.id.indexOf("end") > -1)
         {
            _loc5_ = this.displayToLocalX(UtilUnitConvert.removeUnit(this.endXTxt.text,"px"));
            _loc6_ = this.displayToLocalY(UtilUnitConvert.removeUnit(this.endYTxt.text,"px"));
            if(_loc10_.id.indexOf("Width") > -1)
            {
               _loc8_ = (_loc7_ = UtilUnitConvert.removeUnit(this.endWidthTxt.text,"px")) / LicenseConstants.getScreenRatio();
            }
            else if(_loc10_.id.indexOf("Height") > -1)
            {
               _loc8_ = UtilUnitConvert.removeUnit(this.endHeightTxt.text,"px");
               _loc7_ = LicenseConstants.getScreenRatio() * _loc8_;
            }
            else
            {
               _loc7_ = UtilUnitConvert.removeUnit(this.endWidthTxt.text,"px");
               _loc8_ = UtilUnitConvert.removeUnit(this.endHeightTxt.text,"px");
            }
            _loc13_ = new Rectangle(_loc5_,_loc6_,_loc7_,_loc8_);
            if(this.validateRectangle(_loc13_) && _loc2_.containsRect(_loc13_))
            {
               if(!(_loc14_ = _loc13_).equals(_loc4_))
               {
                  this.removeMyEventListener();
                  (_loc9_ = new SceneOptionEvent(SceneOptionEvent.CAM2_CHANGED)).rect = _loc14_;
                  this.dispatchEvent(_loc9_);
                  this.addEventListener(SceneOptionEvent.ZOOM2_UPDATED,this.updateCam2Value);
               }
               else
               {
                  this.cam2 = _loc4_;
               }
            }
            else
            {
               this.cam2 = _loc4_;
            }
         }
      }
      
      private function onAssetChanged(param1:Event = null) : void
      {
         var _loc2_:ProgramEffectAsset = null;
         var _loc3_:ProgramEffectAsset = null;
         if(this._target is ProgramEffectAsset)
         {
            _loc2_ = ProgramEffectAsset(this._target);
            this.cam1 = new Rectangle(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
            if(_loc2_.motionShadow)
            {
               _loc3_ = ProgramEffectAsset(_loc2_.motionShadow);
               this.cam2 = new Rectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
               this._btnPan.visible = false;
            }
            else
            {
               this.cam2 = new Rectangle(0,0,0,0);
               this._btnPan.visible = true;
            }
         }
      }
      
      private function onPanClick() : void
      {
         this.enablingPanForTarget();
         this._btnPan.visible = false;
      }
      
      private function enablingPanForTarget() : void
      {
         ZoomEffect(this._target.effect).isPan = true;
         this._target.addMotionShadow();
         this.target = this._target;
         this.onAssetChanged();
      }
      
      private function disablingPanForTarget() : void
      {
         ZoomEffect(this._target.effect).isPan = false;
      }
      
      private function onDeletePanClick() : void
      {
         this._btnPan.visible = true;
         this.disablingPanForTarget();
         this._target.removeSlideMotion();
      }
      
      private function refreshControl() : void
      {
         Console.getConsole().sceneController.hideControl();
         Console.getConsole().sceneController.showControl();
      }
      
      private function refreshShadowControl() : void
      {
         Console.getConsole().sceneController.motionControl.refreshShadowControl();
      }
      
      private function onSetZoom2ToFullClick() : void
      {
         var _loc1_:SceneOptionEvent = null;
         this.cam2 = LicenseConstants.getStageRect();
         this.refreshShadowControl();
         _loc1_ = new SceneOptionEvent(SceneOptionEvent.CAM2_CHANGED);
         _loc1_.rect = this.cam2;
         this.dispatchEvent(_loc1_);
      }
      
      private function onSetZoom1ToFullClick() : void
      {
         var _loc1_:SceneOptionEvent = null;
         this.cam1 = LicenseConstants.getStageRect();
         this.refreshControl();
         _loc1_ = new SceneOptionEvent(SceneOptionEvent.CAM1_CHANGED);
         _loc1_.rect = this.cam1;
         this.dispatchEvent(_loc1_);
      }
      
      private function onMatchPreviousClick() : void
      {
         var _loc3_:ProgramEffectAsset = null;
         var _loc4_:Rectangle = null;
         var _loc5_:SceneOptionEvent = null;
         var _loc1_:int = Console.getConsole().currentSceneIndex;
         var _loc2_:AnimeScene = Console.getConsole().getScene(_loc1_ - 1);
         if(_loc2_)
         {
            if(_loc2_.sizingAsset)
            {
               _loc3_ = ProgramEffectAsset(_loc2_.sizingAsset);
               if(_loc3_.motionShadow)
               {
                  _loc4_ = new Rectangle(_loc3_.motionShadow.x,_loc3_.motionShadow.y,_loc3_.motionShadow.width,_loc3_.motionShadow.height);
               }
               else
               {
                  _loc4_ = new Rectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
               }
               if(!_loc4_.equals(this.cam1))
               {
                  this.cam1 = _loc4_;
                  this.refreshControl();
                  (_loc5_ = new SceneOptionEvent(SceneOptionEvent.CAM1_CHANGED)).rect = this.cam1;
                  this.dispatchEvent(_loc5_);
               }
            }
         }
      }
      
      private function onMatchNextClick() : void
      {
         var _loc3_:ProgramEffectAsset = null;
         var _loc4_:Rectangle = null;
         var _loc5_:SceneOptionEvent = null;
         var _loc1_:int = Console.getConsole().currentSceneIndex;
         var _loc2_:AnimeScene = Console.getConsole().getScene(_loc1_ + 1);
         if(_loc2_)
         {
            if(_loc2_.sizingAsset)
            {
               _loc3_ = ProgramEffectAsset(_loc2_.sizingAsset);
               if(!(_loc4_ = new Rectangle(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height)).equals(this.cam2))
               {
                  this.cam2 = _loc4_;
                  this.refreshShadowControl();
                  (_loc5_ = new SceneOptionEvent(SceneOptionEvent.CAM2_CHANGED)).rect = this.cam2;
                  this.dispatchEvent(_loc5_);
               }
            }
         }
      }
      
      private function onMatchStartClick() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:SceneOptionEvent = null;
         _loc1_ = new Rectangle(this.cam2.x,this.cam2.y,this.cam1.width,this.cam1.height);
         if(!_loc1_.equals(this.cam2))
         {
            this.cam2 = _loc1_;
            this.refreshShadowControl();
            _loc2_ = new SceneOptionEvent(SceneOptionEvent.CAM2_CHANGED);
            _loc2_.rect = this.cam2;
            this.dispatchEvent(_loc2_);
         }
      }
      
      private function showMenu1() : void
      {
         var _loc2_:XML = null;
         var _loc3_:Menu = null;
         var _loc1_:* = "";
         var _loc4_:AnimeScene = Console.getConsole().movie.getPrevScene(this._target.scene);
         var _loc5_:* = "";
         if(_loc4_)
         {
            _loc5_ = "<menuItem label=\"" + UtilDict.toDisplay("go","Conform to previous") + "\" value=\"" + "previous" + "\" />";
         }
         _loc1_ = "<root>";
         _loc1_ += "<menuItem label=\"" + UtilDict.toDisplay("go","Set to full stage") + "\" value=\"" + "fullstage1" + "\" />" + _loc5_;
         _loc1_ += "</root>";
         _loc2_ = new XML(_loc1_);
         _loc3_ = Menu.createMenu(this,_loc2_,false);
         _loc3_.labelField = "@label";
         _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         var _loc6_:Number = this.stage.mouseX;
         var _loc7_:Number = this.stage.mouseY;
         _loc3_.show(_loc6_,_loc7_);
      }
      
      private function showMenu2() : void
      {
         var _loc2_:XML = null;
         var _loc3_:Menu = null;
         var _loc1_:* = "";
         var _loc4_:AnimeScene = Console.getConsole().movie.getNextScene(this._target.scene);
         var _loc5_:* = "";
         if(_loc4_)
         {
            _loc5_ = "<menuItem label=\"" + UtilDict.toDisplay("go","Conform to next") + "\" value=\"" + "next" + "\" />";
         }
         _loc1_ = "<root>";
         _loc1_ += "<menuItem label=\"" + UtilDict.toDisplay("go","Match starting size") + "\" value=\"" + "matchstart" + "\" />";
         _loc1_ += "<menuItem label=\"" + UtilDict.toDisplay("go","Set to full stage") + "\" value=\"" + "fullstage2" + "\" />" + _loc5_;
         _loc1_ += "</root>";
         _loc2_ = new XML(_loc1_);
         _loc3_ = Menu.createMenu(this,_loc2_,false);
         _loc3_.labelField = "@label";
         _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         var _loc6_:Number = this.stage.mouseX;
         var _loc7_:Number = this.stage.mouseY;
         _loc3_.show(_loc6_,_loc7_);
      }
      
      private function doMenuClick(param1:MenuEvent) : void
      {
         switch(String(param1.item.@value))
         {
            case "fullstage1":
               this.onSetZoom1ToFullClick();
               break;
            case "fullstage2":
               this.onSetZoom2ToFullClick();
               break;
            case "previous":
               this.onMatchPreviousClick();
               break;
            case "next":
               this.onMatchNextClick();
               break;
            case "matchstart":
               this.onMatchStartClick();
         }
      }
      
      private function onZoomInClick(param1:Event) : void
      {
         this.btnZoomIn.visible = false;
         this.btnZoomOut.visible = true;
         var _loc2_:MainStage = Console.getConsole().mainStage;
         if(_loc2_)
         {
            _loc2_.showCameraView();
         }
      }
      
      private function onZoomOutClick(param1:Event) : void
      {
         this.btnZoomIn.visible = true;
         this.btnZoomOut.visible = false;
         var _loc2_:MainStage = Console.getConsole().mainStage;
         if(_loc2_)
         {
            _loc2_.hideCameraView();
         }
      }
      
      protected function checkbox1_changeHandler(param1:Event) : void
      {
         ProgramEffectAsset(this._target).guide_style = 0;
         if(this.cb_guide1.selected == true)
         {
            ProgramEffectAsset(this._target).guide_style = 1;
         }
      }
      
      private function localToDisplayX(param1:Number) : String
      {
         var _loc2_:Number = param1 - LicenseConstants.getStageRect().x;
         return _loc2_ == 0 ? "0px" : _loc2_ + "px";
      }
      
      private function localToDisplayY(param1:Number) : String
      {
         var _loc2_:Number = param1 - LicenseConstants.getStageRect().y;
         return _loc2_ == 0 ? "0px" : _loc2_ + "px";
      }
      
      private function displayToLocalX(param1:Number) : Number
      {
         return param1 + LicenseConstants.getStageRect().x;
      }
      
      private function displayToLocalY(param1:Number) : Number
      {
         return param1 + LicenseConstants.getStageRect().y;
      }
      
      public function ___CameraSettingPanel_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___CameraSettingPanel_Button1_click(param1:MouseEvent) : void
      {
         this.showMenu2();
      }
      
      public function ___CameraSettingPanel_Button2_click(param1:MouseEvent) : void
      {
         this.onDeletePanClick();
      }
      
      public function __endWidthTxt_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __endWidthTxt_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __endHeightTxt_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __endHeightTxt_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __endXTxt_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __endXTxt_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __endYTxt_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __endYTxt_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function ___btnPan_click(param1:MouseEvent) : void
      {
         this.onPanClick();
      }
      
      public function ___CameraSettingPanel_Button3_click(param1:MouseEvent) : void
      {
         this.showMenu1();
      }
      
      public function __btnZoomOut_click(param1:MouseEvent) : void
      {
         this.onZoomOutClick(param1);
      }
      
      public function __btnZoomIn_click(param1:MouseEvent) : void
      {
         this.onZoomInClick(param1);
      }
      
      public function __startWidthTxt_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __startWidthTxt_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __startHeightTxt_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __startHeightTxt_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __startXTxt_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __startXTxt_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __startYTxt_enter(param1:FlexEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __startYTxt_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputChange(param1);
      }
      
      public function __cb_guide1_change(param1:Event) : void
      {
         this.checkbox1_changeHandler(param1);
      }
      
      private function _CameraSettingPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Size:");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","W");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label2.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","H");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label3.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Position:");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label4.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","X");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label5.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Y");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label6.text");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Timing:");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"subtitle.text");
         result[7] = new Binding(this,function():Object
         {
            return _target;
         },null,"_CameraSettingPanel_AssetTiming1.target");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","+Add Camera Movement");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label7.text");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Size:");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label8.text");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","W");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label9.text");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","H");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label10.text");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Position:");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label11.text");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","X");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label12.text");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Y");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label13.text");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Guides:");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CameraSettingPanel_Label14.text");
         result[16] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Show rule of third guides");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"cb_guide1.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPan() : Canvas
      {
         return this._1329646016_btnPan;
      }
      
      public function set _btnPan(param1:Canvas) : void
      {
         var _loc2_:Object = this._1329646016_btnPan;
         if(_loc2_ !== param1)
         {
            this._1329646016_btnPan = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPan",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnZoomIn() : Button
      {
         return this._789363156btnZoomIn;
      }
      
      public function set btnZoomIn(param1:Button) : void
      {
         var _loc2_:Object = this._789363156btnZoomIn;
         if(_loc2_ !== param1)
         {
            this._789363156btnZoomIn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnZoomIn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnZoomOut() : Button
      {
         return this._1299539841btnZoomOut;
      }
      
      public function set btnZoomOut(param1:Button) : void
      {
         var _loc2_:Object = this._1299539841btnZoomOut;
         if(_loc2_ !== param1)
         {
            this._1299539841btnZoomOut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnZoomOut",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cb_guide1() : CheckBox
      {
         return this._1920941205cb_guide1;
      }
      
      public function set cb_guide1(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1920941205cb_guide1;
         if(_loc2_ !== param1)
         {
            this._1920941205cb_guide1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cb_guide1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endHeightTxt() : TextInput
      {
         return this._2025705170endHeightTxt;
      }
      
      public function set endHeightTxt(param1:TextInput) : void
      {
         var _loc2_:Object = this._2025705170endHeightTxt;
         if(_loc2_ !== param1)
         {
            this._2025705170endHeightTxt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endHeightTxt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endWidthTxt() : TextInput
      {
         return this._1370546373endWidthTxt;
      }
      
      public function set endWidthTxt(param1:TextInput) : void
      {
         var _loc2_:Object = this._1370546373endWidthTxt;
         if(_loc2_ !== param1)
         {
            this._1370546373endWidthTxt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endWidthTxt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endXTxt() : TextInput
      {
         return this._1607143853endXTxt;
      }
      
      public function set endXTxt(param1:TextInput) : void
      {
         var _loc2_:Object = this._1607143853endXTxt;
         if(_loc2_ !== param1)
         {
            this._1607143853endXTxt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endXTxt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endYTxt() : TextInput
      {
         return this._1607114062endYTxt;
      }
      
      public function set endYTxt(param1:TextInput) : void
      {
         var _loc2_:Object = this._1607114062endYTxt;
         if(_loc2_ !== param1)
         {
            this._1607114062endYTxt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endYTxt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get startHeightTxt() : TextInput
      {
         return this._1968833145startHeightTxt;
      }
      
      public function set startHeightTxt(param1:TextInput) : void
      {
         var _loc2_:Object = this._1968833145startHeightTxt;
         if(_loc2_ !== param1)
         {
            this._1968833145startHeightTxt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startHeightTxt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get startWidthTxt() : TextInput
      {
         return this._1260018356startWidthTxt;
      }
      
      public function set startWidthTxt(param1:TextInput) : void
      {
         var _loc2_:Object = this._1260018356startWidthTxt;
         if(_loc2_ !== param1)
         {
            this._1260018356startWidthTxt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startWidthTxt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get startXTxt() : TextInput
      {
         return this._2129195430startXTxt;
      }
      
      public function set startXTxt(param1:TextInput) : void
      {
         var _loc2_:Object = this._2129195430startXTxt;
         if(_loc2_ !== param1)
         {
            this._2129195430startXTxt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startXTxt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get startYTxt() : TextInput
      {
         return this._2129165639startYTxt;
      }
      
      public function set startYTxt(param1:TextInput) : void
      {
         var _loc2_:Object = this._2129165639startYTxt;
         if(_loc2_ !== param1)
         {
            this._2129165639startYTxt = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startYTxt",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get subtitle() : Text
      {
         return this._2060497896subtitle;
      }
      
      public function set subtitle(param1:Text) : void
      {
         var _loc2_:Object = this._2060497896subtitle;
         if(_loc2_ !== param1)
         {
            this._2060497896subtitle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"subtitle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _target() : ProgramEffectAsset
      {
         return this._1827565232_target;
      }
      
      private function set _target(param1:ProgramEffectAsset) : void
      {
         var _loc2_:Object = this._1827565232_target;
         if(_loc2_ !== param1)
         {
            this._1827565232_target = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_target",_loc2_,param1));
            }
         }
      }
   }
}
