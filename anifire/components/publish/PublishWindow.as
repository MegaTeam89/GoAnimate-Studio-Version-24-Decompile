package anifire.components.publish
{
   import anifire.component.IconTextButton;
   import anifire.components.studio.PreviewWindow;
   import anifire.components.studio.ViewStackWindow;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.core.Group;
   import anifire.core.SoundThumb;
   import anifire.event.CoreEvent;
   import anifire.managers.FeatureManager;
   import anifire.managers.ThemeManager;
   import anifire.timeline.Timeline;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilPopUp;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   import flash.utils.setTimeout;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.Form;
   import mx.containers.FormItem;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.ComboBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   import mx.utils.StringUtil;
   
   use namespace mx_internal;
   
   public class PublishWindow extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _PublishWindow_FormItem1:FormItem;
      
      public var _PublishWindow_FormItem4:FormItem;
      
      public var _PublishWindow_IconTextButton1:IconTextButton;
      
      public var _PublishWindow_Label1:Label;
      
      public var _PublishWindow_Label2:Label;
      
      public var _PublishWindow_Label4:Label;
      
      public var _PublishWindow_Text3:Text;
      
      private var _2122106277_btnClose:Button;
      
      private var _2044384006_btnCloseTop:IconTextButton;
      
      private var _1730701776_btnNext:Button;
      
      private var _2106366127_btnPostToProfile:Button;
      
      private var _1730630288_btnPrev:Button;
      
      private var _1730556742_btnSave:Button;
      
      private var _1114913131_btnSaveNShare:Button;
      
      private var _2108378084_cbCategory:ComboBox;
      
      private var _1393458143_cbGroup:ComboBox;
      
      private var _1952108612_groupAlert:VBox;
      
      private var _1424538864_itemCategory:FormItem;
      
      private var _1988842562_langBox:ComboBox;
      
      private var _1962716122_lblPage:Label;
      
      private var _1958100315_lblWarning:Label;
      
      private var _82141533_mainView:ViewStack;
      
      private var _1384121864_parentalAlert:Canvas;
      
      private var _2121733154_pubForm:VBox;
      
      private var _1237099340_publishForm:PublishPanel;
      
      private var _1061294085_radioDraft:RadioButton;
      
      private var _230640921_radioPrivate:RadioButton;
      
      private var _1113266043_radioPublic:RadioButton;
      
      private var _1126007977_saveProgress:SaveProgress;
      
      private var _1839914382_sharingOption:RadioButtonGroup;
      
      private var _993142004_soundForm:MusicPanel;
      
      private var _1391325653_txtAlert:Text;
      
      private var _143330933_txtDescription:TextArea;
      
      private var _12195225_txtMovieTitle:TextArea;
      
      private var _1479694698_txtTags:TextArea;
      
      private var _1959512361_txtTagsAdd:Text;
      
      private var _1710757388_vbGroup:FormItem;
      
      private var _1884609497_vbLang:FormItem;
      
      private var _1884847620_vbTags:FormItem;
      
      private var _1985600873_vsCaptures:ViewStack;
      
      private var _1759771312button_hbox:HBox;
      
      private var _944171068button_hbox_progress:HBox;
      
      private var _841671574draftBox:HBox;
      
      private var _1876079288privateBox:HBox;
      
      private var _1446891170publicBox:HBox;
      
      private var _169721479savePanel:FormItem;
      
      private var _2012162683spacer1:Spacer;
      
      private var _213424028watermark:WatermarkPreview;
      
      private var _1563553081watermarkBox:VBox;
      
      private var _676548608watermarkPanel:WatermarkChoosingPanel;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private const SAVE_SHARE:String = "Save and Share";
      
      private const SAVE_CLOSE:String = "Save and Close";
      
      private const SAVE_SIGNUP:String = "pubwin_save_signup";
      
      private const TIP_SAVE_SHARE_CLOSE:String = "pubwin_savensharetips";
      
      private const TIP_SAVE_CLOSE:String = "pubwin_savenclosetips";
      
      private const TIP_SAVE:String = "pubwin_saveonlytips";
      
      private var _previewWindow:PreviewWindow;
      
      private var _41509777_published:Boolean = false;
      
      private var _1154689974_pShared:Boolean = false;
      
      private var _40784716_captures:UtilHashArray;
      
      private var _lang_array:Array = null;
      
      private var _temp_is_redirect:Boolean;
      
      mx_internal var _PublishWindow_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function PublishWindow()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___PublishWindow_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":ViewStack,
                     "id":"_mainView",
                     "stylesFactory":function():void
                     {
                        this.paddingBottom = 20;
                        this.paddingLeft = 20;
                        this.paddingRight = 20;
                        this.paddingTop = 20;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":800,
                           "height":520,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VBox,
                              "id":"_pubForm",
                              "stylesFactory":function():void
                              {
                                 this.verticalGap = 0;
                                 this.paddingBottom = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":VBox,
                                       "stylesFactory":function():void
                                       {
                                          this.verticalGap = 0;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {"childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_PublishWindow_Label1",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"publishWindowTitleStyle"};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_PublishWindow_Label2",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"publishWindowSubtitleStyle"};
                                             }
                                          })]};
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
                                          this.paddingLeft = 20;
                                          this.paddingRight = 20;
                                          this.horizontalAlign = "center";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Form,
                                                "stylesFactory":function():void
                                                {
                                                   this.verticalGap = 18;
                                                   this.indicatorGap = 20;
                                                   this.paddingTop = 0;
                                                   this.paddingLeft = 0;
                                                   this.paddingRight = 0;
                                                   this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":FormItem,
                                                      "id":"_PublishWindow_FormItem1",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.labelStyleName = "publishWindowFormItemLabel";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "required":true,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":TextArea,
                                                               "id":"_txtMovieTitle",
                                                               "events":{"change":"___txtMovieTitle_change"},
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.paddingTop = 3;
                                                                  this.paddingLeft = 3;
                                                                  this.fontWeight = "bold";
                                                                  this.fontSize = 16;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "height":30,
                                                                     "width":300,
                                                                     "maxChars":50
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":FormItem,
                                                      "id":"_vbTags",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.labelStyleName = "publishWindowFormItemLabel";
                                                         this.verticalGap = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "required":true,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":TextArea,
                                                               "id":"_txtTags",
                                                               "events":{"change":"___txtTags_change"},
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.paddingTop = 3;
                                                                  this.paddingLeft = 3;
                                                                  this.fontSize = 16;
                                                                  this.fontWeight = "bold";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "height":30,
                                                                     "width":300,
                                                                     "maxChars":50
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Text,
                                                               "id":"_txtTagsAdd",
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.fontSize = 12;
                                                                  this.color = 10066329;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"selectable":false};
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":FormItem,
                                                      "id":"_vbGroup",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.labelStyleName = "publishWindowFormItemLabel";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "required":true,
                                                            "includeInLayout":false,
                                                            "visible":false,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":ComboBox,
                                                               "id":"_cbGroup",
                                                               "events":{"change":"___cbGroup_change"},
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":300,
                                                                     "styleName":"publishWindowComboBoxStyle"
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":FormItem,
                                                      "id":"_PublishWindow_FormItem4",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.labelStyleName = "publishWindowFormItemLabel";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"childDescriptors":[new UIComponentDescriptor({
                                                            "type":TextArea,
                                                            "id":"_txtDescription",
                                                            "events":{"change":"___txtDescription_change"},
                                                            "stylesFactory":function():void
                                                            {
                                                               this.fontSize = 16;
                                                               this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "height":100,
                                                                  "width":300,
                                                                  "maxChars":255
                                                               };
                                                            }
                                                         })]};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":FormItem,
                                                      "id":"_vbLang",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.labelStyleName = "publishWindowFormItemLabel";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"childDescriptors":[new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"_langBox",
                                                            "stylesFactory":function():void
                                                            {
                                                               this.fillColors = ["white","white"];
                                                               this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "width":300,
                                                                  "styleName":"publishWindowComboBoxStyle"
                                                               };
                                                            }
                                                         })]};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":FormItem,
                                                      "id":"savePanel",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.labelStyleName = "publishWindowFormItemLabel";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {"childDescriptors":[new UIComponentDescriptor({
                                                                  "type":HBox,
                                                                  "id":"draftBox",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"publishWindowNormalBoxStyle",
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":RadioButton,
                                                                           "id":"_radioDraft",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "groupName":"_sharingOption",
                                                                                 "styleName":"publishWindowRadioBtnStyle",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":HBox,
                                                                  "id":"privateBox",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"publishWindowNormalBoxStyle",
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":RadioButton,
                                                                           "id":"_radioPrivate",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "groupName":"_sharingOption",
                                                                                 "styleName":"publishWindowRadioBtnStyle",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":HBox,
                                                                  "id":"publicBox",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"publishWindowNormalBoxStyle",
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":RadioButton,
                                                                           "id":"_radioPublic",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "groupName":"_sharingOption",
                                                                                 "styleName":"publishWindowRadioBtnStyle",
                                                                                 "buttonMode":true
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               })]};
                                                            }
                                                         }),new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_parentalAlert",
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "styleName":"parentalAlertBg",
                                                                  "width":300,
                                                                  "percentHeight":100,
                                                                  "includeInLayout":false,
                                                                  "visible":false,
                                                                  "childDescriptors":[new UIComponentDescriptor({
                                                                     "type":Text,
                                                                     "id":"_txtAlert",
                                                                     "stylesFactory":function():void
                                                                     {
                                                                        this.textAlign = "center";
                                                                        this.color = 16777215;
                                                                        this.fontSize = 14;
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "percentWidth":100,
                                                                           "selectable":false
                                                                        };
                                                                     }
                                                                  })]
                                                               };
                                                            }
                                                         }),new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "id":"_groupAlert",
                                                            "stylesFactory":function():void
                                                            {
                                                               this.backgroundColor = 15648455;
                                                               this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "styleName":"parentalAlertBg",
                                                                  "percentWidth":100,
                                                                  "percentHeight":100,
                                                                  "includeInLayout":false,
                                                                  "visible":false,
                                                                  "childDescriptors":[new UIComponentDescriptor({
                                                                     "type":Text,
                                                                     "id":"_PublishWindow_Text3",
                                                                     "stylesFactory":function():void
                                                                     {
                                                                        this.textAlign = "center";
                                                                        this.color = 6954528;
                                                                        this.fontSize = 14;
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "percentWidth":100,
                                                                           "selectable":false
                                                                        };
                                                                     }
                                                                  })]
                                                               };
                                                            }
                                                         })]};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":FormItem,
                                                      "id":"_itemCategory",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.labelStyleName = "publishWindowFormItemLabel";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "required":true,
                                                            "includeInLayout":false,
                                                            "visible":false,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":ComboBox,
                                                               "id":"_cbCategory",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":300,
                                                                     "styleName":"publishWindowComboBoxStyle"
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   })]};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"percentWidth":100};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.verticalGap = 5;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":220,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"childDescriptors":[new UIComponentDescriptor({
                                                               "type":ViewStack,
                                                               "id":"_vsCaptures",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":220,
                                                                     "height":141
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":WatermarkPreview,
                                                               "id":"watermark",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "bottom":2,
                                                                     "left":2,
                                                                     "scaleX":0.4,
                                                                     "scaleY":0.4,
                                                                     "maxWidth":550,
                                                                     "maxHeight":354,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off"
                                                                  };
                                                               }
                                                            })]};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalAlign = "center";
                                                            this.horizontalGap = 0;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_btnPrev",
                                                                  "events":{"click":"___btnPrev_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "styleName":"btnPrevious"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_lblPage",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.textAlign = "center";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"subTitle",
                                                                        "width":81.6
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_btnNext",
                                                                  "events":{"click":"___btnNext_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "styleName":"btnNext"
                                                                     };
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
                                                         "type":VBox,
                                                         "id":"watermarkBox",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalAlign = "center";
                                                            this.backgroundColor = 14540253;
                                                            this.cornerRadius = 5;
                                                            this.borderStyle = "solid";
                                                            this.borderColor = 14540253;
                                                            this.paddingBottom = 10;
                                                            this.paddingTop = 10;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "includeInLayout":false,
                                                               "visible":false,
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_PublishWindow_Label4",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"styleName":"publishWindowFormItemLabel"};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"_PublishWindow_IconTextButton1",
                                                                  "events":{"click":"___PublishWindow_IconTextButton1_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.color = 3964821;
                                                                     this.textRollOverColor = 5284541;
                                                                     this.fontWeight = "bold";
                                                                     this.fontSize = 13;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"buttonMode":true};
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
                                       "type":Spacer,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentHeight":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":HBox,
                                       "id":"button_hbox_progress",
                                       "stylesFactory":function():void
                                       {
                                          this.paddingLeft = 20;
                                          this.paddingRight = 20;
                                          this.verticalAlign = "middle";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "horizontalScrollPolicy":"off",
                                                      "verticalScrollPolicy":"off",
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_lblWarning",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.fontSize = 18;
                                                            this.color = 16320794;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "verticalCenter":0,
                                                               "maxWidth":300,
                                                               "horizontalCenter":0,
                                                               "visible":false
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":SaveProgress,
                                                         "id":"_saveProgress",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "y":5,
                                                               "horizontalCenter":0,
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
                                       "type":HBox,
                                       "id":"button_hbox",
                                       "stylesFactory":function():void
                                       {
                                          this.paddingLeft = 20;
                                          this.paddingRight = 20;
                                          this.verticalAlign = "middle";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnSave",
                                                "events":{"click":"___btnSave_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "styleName":"publishWindowBtnStyle",
                                                      "minWidth":150,
                                                      "height":32,
                                                      "buttonMode":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnClose",
                                                "events":{"click":"___btnClose_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "includeInLayout":false,
                                                      "visible":false,
                                                      "styleName":"publishWindowMajorBtnStyle_grey",
                                                      "minWidth":150,
                                                      "height":32,
                                                      "buttonMode":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"percentWidth":100};
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnPostToProfile",
                                                "events":{"click":"___btnPostToProfile_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "styleName":"publishWindowMajorBtnStyle_blue",
                                                      "minWidth":180,
                                                      "height":32,
                                                      "buttonMode":true,
                                                      "visible":false,
                                                      "includeInLayout":false
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Spacer,
                                                "id":"spacer1",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "visible":false,
                                                      "includeInLayout":false
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_btnSaveNShare",
                                                "events":{"click":"___btnSaveNShare_click"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "styleName":"publishWindowMajorBtnStyle",
                                                      "minWidth":180,
                                                      "height":32,
                                                      "buttonMode":true
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":MusicPanel,
                              "id":"_soundForm",
                              "events":{"saveMovie":"___soundForm_saveMovie"}
                           }),new UIComponentDescriptor({
                              "type":PublishPanel,
                              "id":"_publishForm",
                              "events":{
                                 "saveAsPublic":"___publishForm_saveAsPublic",
                                 "saveAsPrivate":"___publishForm_saveAsPrivate"
                              }
                           }),new UIComponentDescriptor({
                              "type":WatermarkChoosingPanel,
                              "id":"watermarkPanel",
                              "events":{
                                 "cancel":"__watermarkPanel_cancel",
                                 "watermarkUpdated":"__watermarkPanel_watermarkUpdated"
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnCloseTop",
                     "events":{
                        "click":"___btnCloseTop_click",
                        "creationComplete":"___btnCloseTop_creationComplete"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "right":20,
                           "top":20,
                           "styleName":"btnCloseTop",
                           "buttonMode":true,
                           "labelPlacement":"left"
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
         var bindings:Array = this._PublishWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_publish_PublishWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return PublishWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.creationPolicy = "all";
         this._PublishWindow_RadioButtonGroup1_i();
         this.addEventListener("creationComplete",this.___PublishWindow_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         PublishWindow._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_PublishWindow_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function get LANG_ARRAY() : Array
      {
         var _loc1_:Object = null;
         var _loc2_:UtilHashArray = null;
         var _loc3_:int = 0;
         if(this._lang_array == null)
         {
            this._lang_array = new Array();
            _loc2_ = UtilLicense.getCurrentLicensorSupportedShortLangCodes();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = new Object();
               _loc1_.label = _loc2_.getValueByIndex(_loc3_);
               _loc1_.data = _loc2_.getKey(_loc3_);
               this._lang_array.push(_loc1_);
               _loc3_++;
            }
         }
         return this._lang_array;
      }
      
      private function fitBitmapIntoCaptures(param1:BitmapData, param2:int) : void
      {
         var _loc3_:Bitmap = null;
         var _loc4_:Image = null;
         var _loc5_:Canvas = null;
         if(param1 != null)
         {
            _loc3_ = new Bitmap(param1);
            _loc3_.width = 220;
            _loc3_.height = 141;
            (_loc4_ = new Image()).addChild(_loc3_);
            (_loc5_ = new Canvas()).width = this._vsCaptures.width;
            _loc5_.height = this._vsCaptures.height;
            _loc5_.addChild(_loc4_);
            this._vsCaptures.addChildAt(_loc5_,param2);
         }
      }
      
      public function initPublishWindow(param1:PreviewWindow, param2:Boolean, param3:Boolean, param4:UtilHashArray, param5:String = "", param6:String = "", param7:String = "", param8:String = "", param9:String = "", param10:Number = 0) : void
      {
         var _loc11_:BitmapData = null;
         var _loc12_:int = 0;
         var _loc13_:BitmapData = null;
         var _loc14_:Number = NaN;
         this._previewWindow = param1;
         this._published = param2;
         this._pShared = param3;
         this._captures = param4;
         this._txtMovieTitle.text = param5;
         this._txtTags.text = param6;
         this._txtDescription.text = param7;
         if(param4 != null)
         {
            _loc11_ = Console.getConsole().getThumbnailCaptureBySceneIndex(0);
            Console.getConsole().selectedThumbnailIndex = 0;
            this.fitBitmapIntoCaptures(_loc11_,0);
            _loc12_ = 1;
            while(_loc12_ < param4.length)
            {
               _loc13_ = param4.getValueByIndex(_loc12_);
               this.fitBitmapIntoCaptures(_loc13_,_loc12_);
               _loc12_++;
            }
            if(param10 > param4.length - 1)
            {
               param10 = param4.length - 1;
            }
            this._lblPage.text = param10 + 1 + "/" + param4.length;
            if(param10 == 0)
            {
               this.enableButton(this._btnPrev,false);
            }
            if(param10 == param4.length - 1)
            {
               this.enableButton(this._btnNext,false);
            }
            this._vsCaptures.selectedIndex = param10;
         }
         if(param8 == "")
         {
            param8 = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_LANG) as String;
         }
         _loc12_ = 0;
         while(_loc12_ < this.LANG_ARRAY.length)
         {
            if(param8 == this.LANG_ARRAY[_loc12_].data)
            {
               this._langBox.selectedIndex = _loc12_;
            }
            _loc12_++;
         }
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            if((_loc14_ = Util.roundNum(Console.getConsole().timeline.getTotalTimeInSec())) > FeatureManager.maxMovieDuration)
            {
               this.allowDraftOnly();
               UtilPopUp.alert(UtilDict.toDisplay("go","As your movie is longer than 2 mins, you may only save it as a draft. In order to publish it, you have to make it shorter or upgrade your account to GoPlus."));
            }
         }
         this.enableButton(this._btnSaveNShare,true,this._published || this._pShared);
         this.initSavinOption();
      }
      
      private function doModifyMovieName() : void
      {
         Console.getConsole().tempMetaData.title = this._txtMovieTitle.text;
         if(this._previewWindow != null)
         {
            this._previewWindow.movieName = this._txtMovieTitle.text;
         }
      }
      
      private function doModifyTags() : void
      {
         Console.getConsole().tempMetaData.setUgcTagsByString(this._txtTags.text);
      }
      
      private function doModifyDescription() : void
      {
         Console.getConsole().tempMetaData.description = this._txtDescription.text;
      }
      
      private function doModifyGroup() : void
      {
         if(this._cbGroup.selectedItem.data != "-1")
         {
            Console.getConsole().groupController.tempCurrentGroup = new Group(this._cbGroup.selectedItem.data,this._cbGroup.selectedItem.label);
         }
      }
      
      private function validateMovieDetail() : Boolean
      {
         var _loc1_:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         this._lblWarning.visible = false;
         if(_loc1_.containsBadword(this._txtMovieTitle.text))
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._lblWarning.visible = true;
            this._txtMovieTitle.setFocus();
            return false;
         }
         if(StringUtil.trim(this._txtMovieTitle.text) == "")
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BLANK);
            this._lblWarning.visible = true;
            this._txtMovieTitle.setFocus();
            return false;
         }
         if(UtilSite.siteId != UtilSite.ED && UtilSite.siteId != UtilSite.SCHOOLOGY)
         {
            if(_loc1_.containsBadword(this._txtTags.text))
            {
               this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
               this._lblWarning.visible = true;
               this._txtTags.setFocus();
               return false;
            }
            if(StringUtil.trim(this._txtTags.text) == "")
            {
               this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BLANK_TAG);
               this._lblWarning.visible = true;
               this._txtTags.setFocus();
               return false;
            }
         }
         if(_loc1_.containsBadword(this._txtDescription.text))
         {
            this._lblWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._lblWarning.visible = true;
            this._txtDescription.setFocus();
            return false;
         }
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            if(this._cbGroup.selectedItem.data == "-1")
            {
               this._lblWarning.text = UtilDict.toDisplay("go","Please select a group");
               this._lblWarning.visible = true;
               this._cbGroup.setFocus();
               return false;
            }
            if(this._radioPublic.selected && Console.getConsole().groupController.categoryList && this._cbCategory.selectedIndex == 0)
            {
               this._lblWarning.text = UtilDict.toDisplay("go","Please select a category");
               this._lblWarning.visible = true;
               this._cbCategory.setFocus();
               return false;
            }
         }
         return true;
      }
      
      private function doSaveMovie(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false) : void
      {
         var self:IEventDispatcher = null;
         var redirect:Boolean = param1;
         var skipAddSound:Boolean = param2;
         var skipPublishSettings:Boolean = param3;
         if(this.validateMovieDetail() == false)
         {
            return;
         }
         if((Console.getConsole().tempPublished || Console.getConsole().tempPrivateShared) && (Console.getConsole().sounds.length < 1 && Console.getConsole().speechManager.getNumOfSpeech() < 1) && redirect && !skipAddSound)
         {
            if(ThemeManager.instance.getTheme("common"))
            {
               this._mainView.selectedChild = this._soundForm;
               this._soundForm.initSoundList();
               if(UtilUser.loggedIn)
               {
                  return;
               }
            }
         }
         if(skipAddSound)
         {
            this._soundForm.addSelectedSound();
         }
         this._temp_is_redirect = redirect;
         if(UtilUser.loggedIn)
         {
            Console.getConsole().groupController.category = this._cbCategory.selectedLabel;
            if(skipPublishSettings == false)
            {
               this.setTempPrivateShared();
               this.setTempPublished();
            }
            self = this;
            Console.getConsole().addEventListener(CoreEvent.SERIALIZE_COMPLETE,function(param1:CoreEvent):void
            {
               Console.getConsole().removeEventListener(CoreEvent.SERIALIZE_COMPLETE,arguments.callee);
               _saveProgress.dispatchEvent(new CoreEvent(CoreEvent.SERIALIZE_COMPLETE,self));
            });
            this.orderConsoleToSaveMovie();
         }
         else
         {
            Console.getConsole().addEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doOrderConsoleToSaveMovie);
            Console.getConsole().addEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doCancelOrderConsoleToSaveMovie);
            Console.getConsole().showSignup();
         }
         if(redirect == false && (UtilSite.siteId == UtilSite.ED || UtilSite.siteId == UtilSite.SCHOOLOGY))
         {
            this._btnSave.includeInLayout = false;
            this._btnSave.visible = false;
            this._btnClose.includeInLayout = true;
            this._btnClose.visible = true;
            this.enabled = true;
            this._btnSaveNShare.label = UtilDict.toDisplay("go","Turn-in as Assignment") + " >";
            this._btnSaveNShare.enabled = true;
            this._btnCloseTop.visible = true;
         }
      }
      
      private function orderConsoleToSaveMovie() : void
      {
         this.enabled = false;
         Console.getConsole().tempMetaData.lang = this._langBox.selectedItem.data;
         Console.getConsole().metaData.lang = this._langBox.selectedItem.data;
         Console.getConsole().addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.onSaveMovieComplete);
         Console.getConsole().addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.onSaveMovieFail);
         Console.getConsole().publishMovie(this,Console.getConsole().tempPublished,Console.getConsole().tempPrivateShared,this._temp_is_redirect);
      }
      
      private function doCancelOrderConsoleToSaveMovie(param1:Event) : void
      {
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doCancelOrderConsoleToSaveMovie);
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doOrderConsoleToSaveMovie);
      }
      
      private function doOrderConsoleToSaveMovie(param1:Event) : void
      {
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_COMPLETE,this.doCancelOrderConsoleToSaveMovie);
         Console.getConsole().removeEventListener(CoreEvent.USER_LOGIN_CANCEL,this.doOrderConsoleToSaveMovie);
         this.orderConsoleToSaveMovie();
      }
      
      public function hide() : void
      {
         PopUpManager.removePopUp(PublishWindow(this));
         if(Console.getConsole().currentScene != null)
         {
            Console.getConsole().currentScene.playScene();
         }
      }
      
      private function initSavinOption(param1:int = -1) : void
      {
         var _loc2_:UtilHashArray = null;
         var _loc3_:String = null;
         if(UtilSite.siteId == UtilSite.GOANIMATE)
         {
            if(this._published)
            {
               this._sharingOption.selection = this._radioPublic;
            }
            else
            {
               this._sharingOption.selection = !!this._pShared ? this._radioPrivate : this._radioDraft;
            }
         }
         else if(UtilSite.siteId == UtilSite.CN)
         {
            this._radioPrivate.includeInLayout = this._radioPrivate.visible = false;
            this._sharingOption.selection = !!this._published ? this._radioPublic : this._radioDraft;
            this._radioDraft.label = UtilDict.toDisplay("go","pubwin_private");
            if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_PARENT_CONSENT) == "0")
            {
               this.allowDraftOnly();
            }
            else if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_PARENT_CONSENT) == "2")
            {
               this.allowDraftOnly();
               this._parentalAlert.includeInLayout = this._parentalAlert.visible = true;
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_nonactivate");
            }
            else if(Util.roundNum((Console.getConsole().timeline as Timeline).getTotalTimeInSec()) >= 121)
            {
               this.allowDraftOnly();
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_durationalert");
            }
            else if(Util.roundNum((Console.getConsole().timeline as Timeline).getTotalTimeInSec()) >= 25.1 && (Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) != null && Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_CNCONTEST) != "0"))
            {
               this.allowDraftOnly();
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_durationalert25");
            }
            else
            {
               this._txtAlert.text = UtilDict.toDisplay("go","pubwin_moderators");
               this._txtAlert.setStyle("color","0x000000");
               this._parentalAlert.setStyle("backgroundColor","0xBBE0E3");
            }
         }
         else if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            this._vbGroup.includeInLayout = this._vbGroup.visible = true;
            this._vbTags.includeInLayout = this._vbTags.visible = false;
            this._txtTags.text = "school";
            this._radioPublic.label = UtilDict.toDisplay("go","Lesson Gallery");
            this._radioPrivate.label = UtilDict.toDisplay("go","Students only");
            if(this._published)
            {
               this._sharingOption.selection = this._radioPublic;
            }
            else
            {
               this._sharingOption.selection = !!this._pShared ? this._radioPrivate : this._radioDraft;
            }
            this.initGroupComboBox();
            this.initCategory();
         }
         else if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            this._radioPrivate.includeInLayout = this._radioPrivate.visible = false;
            this._sharingOption.selection = !!this._published ? this._radioPublic : this._radioDraft;
            this._radioDraft.label = UtilDict.toDisplay("go","pubwin_private");
            this._radioPublic.label = UtilDict.toDisplay("go","pubwin_public");
            this._btnSave.label = UtilDict.toDisplay("go","Save Project");
            this.savePanel.label = UtilDict.toDisplay("go","Publish to YouTube as:");
            this.savePanel.visible = false;
            this._btnSaveNShare.label = UtilDict.toDisplay("go","Publish to YouTube") + " >";
         }
         else if(UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            this._radioPrivate.includeInLayout = this._radioPrivate.visible = false;
            this._sharingOption.selection = !!this._published ? this._radioPublic : this._radioDraft;
            this._radioDraft.label = UtilDict.toDisplay("go","pubwin_private");
            this._radioPublic.label = UtilDict.toDisplay("go","pubwin_public");
            this._vbGroup.includeInLayout = this._vbGroup.visible = true;
            this._vbLang.visible = false;
            this._btnSave.label = UtilDict.toDisplay("go","Save Project");
            this.savePanel.label = UtilDict.toDisplay("go","Publish to SkoleTube as:");
            this.savePanel.visible = true;
            this._btnSaveNShare.label = UtilDict.toDisplay("go","Publish to SkoleTube") + " >";
            this.initGroupComboBox();
         }
         else if(UtilSite.siteId == UtilSite.ED || UtilSite.siteId == UtilSite.SCHOOLOGY)
         {
            _loc2_ = Util.getFlashVar();
            _loc3_ = _loc2_.getValueByKey(ServerConstants.FLASHVAR_ED_USER_TYPE) as String;
            this._radioPrivate.includeInLayout = this._radioPrivate.visible = false;
            this._sharingOption.selection = !!this._published ? this._radioPublic : this._radioDraft;
            this._radioDraft.label = UtilDict.toDisplay("go","pubwin_private");
            this._radioPublic.label = UtilDict.toDisplay("go","pubwin_public");
            this._btnSave.label = UtilDict.toDisplay("go","Save");
            this._btnSave.styleName = "publishWindowMajorBtnStyle";
            this._btnSaveNShare.label = UtilDict.toDisplay("go","Turn-in as Assignment") + " >";
            this._btnSaveNShare.styleName = "publishWindowMajorBtnStyle_orange";
            this._vbTags.includeInLayout = false;
            this._vbGroup.includeInLayout = false;
            this._vbLang.includeInLayout = false;
            this.savePanel.includeInLayout = false;
            this._vbTags.visible = false;
            this._vbGroup.visible = false;
            this._vbLang.visible = false;
            this.savePanel.visible = false;
            this._mainView.height = 500;
            this._btnPostToProfile.includeInLayout = true;
            this._btnPostToProfile.visible = true;
            this.spacer1.visible = true;
            this.spacer1.includeInLayout = true;
            if(_loc3_ == "TEACHER")
            {
               this._btnSaveNShare.visible = false;
               this._btnSaveNShare.includeInLayout = false;
               this.spacer1.visible = false;
               this.spacer1.includeInLayout = false;
            }
            if(UtilSite.siteId == UtilSite.SCHOOLOGY)
            {
               this._btnSaveNShare.visible = this._btnSaveNShare.includeInLayout = false;
               this._btnPostToProfile.label = UtilDict.toDisplay("go","Post to Updates >");
            }
         }
         this.setTempPublished();
      }
      
      public function setBtnStatus(param1:Boolean) : void
      {
         if(this._mainView.selectedChild == this._pubForm)
         {
            this.enableButton(this._btnSave,param1);
            this.enableButton(this._btnSaveNShare,param1,Console.getConsole().movie.privateShared);
            this._txtMovieTitle.enabled = param1;
            this._txtTags.enabled = param1;
            this._txtDescription.enabled = param1;
            this._langBox.enabled = param1;
            this._radioDraft.enabled = param1;
            this._radioPublic.enabled = param1;
            this._radioPrivate.enabled = param1;
            if(param1)
            {
               this.initSavinOption();
            }
            this._btnPrev.enabled = param1;
            this._btnNext.enabled = param1;
            this._btnCloseTop.visible = param1;
            if(param1)
            {
               this._saveProgress.visible = false;
               this._saveProgress.stopSavingProgress();
            }
            else
            {
               this._saveProgress.visible = true;
               this._saveProgress.startSavingProgress();
            }
         }
         else if(this._mainView.selectedChild == this._soundForm)
         {
            this._soundForm.setBtnStatus(param1);
         }
      }
      
      private function onCancelClickHandler(param1:Event = null) : void
      {
         if(this._previewWindow != null)
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
         else
         {
            this.hide();
         }
      }
      
      private function initClose() : void
      {
         var _loc1_:ColorTransform = new ColorTransform(0.5,0.5,0.5);
         this._btnCloseTop.transform.colorTransform = _loc1_;
      }
      
      private function onClose() : void
      {
         if(this._mainView.selectedChild == this._publishForm)
         {
            Console.getConsole().tempPublished = false;
            Console.getConsole().tempPrivateShared = false;
            this.doSaveMovie();
         }
         else
         {
            this._soundForm.deselectAllSoundTileCell();
            if(this.parent != null && this.parent is ViewStackWindow)
            {
               ViewStackWindow(this.parent).onCancelHandler(null);
            }
            else
            {
               this.close();
               Console.getConsole().closePublishWindow();
            }
         }
      }
      
      private function setTempPublished() : void
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE)
         {
            if(this._radioDraft.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,false);
            }
            else
            {
               this.setTempPrivateShared();
               this.enableButton(this._btnSaveNShare,true,true);
            }
         }
         else if(UtilSite.siteId == UtilSite.CN)
         {
            if(this._radioPublic.selected)
            {
               Console.getConsole().tempPublished = true;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,true);
            }
            else
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,false);
            }
            if(this._txtAlert.text === UtilDict.toDisplay("go","pubwin_moderators"))
            {
               this._parentalAlert.visible = this._parentalAlert.includeInLayout = this._radioPublic.selected;
            }
         }
         else if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            if(this._radioDraft.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
               this.enableButton(this._btnSaveNShare,true,false);
            }
            else
            {
               this.setTempPrivateShared();
               this.enableButton(this._btnSaveNShare,true,true);
            }
            if(!Console.getConsole().groupController.isTeacher)
            {
            }
         }
         else if(UtilSite.siteId != UtilSite.YOUTUBE)
         {
            if(UtilSite.siteId == UtilSite.SKOLETUBE)
            {
               if(this._radioPublic.selected)
               {
                  Console.getConsole().tempPublished = true;
                  Console.getConsole().tempPrivateShared = false;
               }
            }
            else if(UtilSite.siteId == UtilSite.ED || UtilSite.siteId == UtilSite.SCHOOLOGY)
            {
               Console.getConsole().tempPrivateShared = true;
            }
         }
      }
      
      private function setTempPrivateShared() : void
      {
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            if(this._radioPublic.selected)
            {
               Console.getConsole().tempPublished = true;
               Console.getConsole().tempPrivateShared = true;
            }
            else if(this._radioPrivate.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = true;
            }
            else
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
            }
            this._itemCategory.visible = this._itemCategory.includeInLayout = this._radioPublic.selected;
         }
         else if(UtilSite.siteId != UtilSite.YOUTUBE)
         {
            if(UtilSite.siteId == UtilSite.SKOLETUBE)
            {
               if(this._radioPublic.selected)
               {
                  Console.getConsole().tempPublished = true;
                  Console.getConsole().tempPrivateShared = false;
               }
               else
               {
                  Console.getConsole().tempPublished = false;
                  Console.getConsole().tempPrivateShared = true;
               }
            }
            else if(this._radioPublic.selected)
            {
               Console.getConsole().tempPublished = true;
               Console.getConsole().tempPrivateShared = false;
            }
            else if(this._radioPrivate.selected)
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = true;
            }
            else
            {
               Console.getConsole().tempPublished = false;
               Console.getConsole().tempPrivateShared = false;
            }
         }
      }
      
      public function success(param1:SoundThumb) : void
      {
         this._soundForm.success(param1);
      }
      
      private function enableButton(param1:Button, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param1 != null)
         {
            param1.enabled = param2;
            param1.buttonMode = param2;
            if(param1 == this._btnSaveNShare && UtilSite.siteId != UtilSite.YOUTUBE)
            {
               if(UtilSite.siteId == UtilSite.SKOLETUBE)
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_SHARE) + " >";
                  this._btnSaveNShare.toolTip = "Tip: udgiv først på Skoletube når din animationsfilm er helt færdig!";
               }
               else if(param3 && UtilSite.siteId != UtilSite.SCHOOL)
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_SHARE) + " >";
                  this._btnSaveNShare.toolTip = UtilDict.toDisplay("go",this.TIP_SAVE_SHARE_CLOSE);
               }
               else
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_CLOSE) + " >";
                  this._btnSaveNShare.toolTip = UtilDict.toDisplay("go",this.TIP_SAVE_CLOSE);
               }
               if(!UtilUser.loggedIn)
               {
                  this._btnSaveNShare.label = UtilDict.toDisplay("go",this.SAVE_SIGNUP) + " >";
               }
            }
         }
      }
      
      private function prevThumbnail() : void
      {
         if(this._vsCaptures.selectedIndex > 0)
         {
            --this._vsCaptures.selectedIndex;
            Console.getConsole().selectedThumbnailIndex = this._vsCaptures.selectedIndex;
            if(this._vsCaptures.selectedIndex == 0)
            {
               this.enableButton(this._btnPrev,false);
            }
            if(this._btnNext.enabled == false)
            {
               this.enableButton(this._btnNext,true);
            }
         }
      }
      
      private function nextThumbnail() : void
      {
         var _loc1_:BitmapData = null;
         if(this._vsCaptures.selectedIndex < this._captures.length - 1)
         {
            if(this._vsCaptures.selectedIndex + 1 >= this._vsCaptures.numChildren)
            {
               Console.getConsole().requestLoadStatus(true);
               _loc1_ = Console.getConsole().getThumbnailCaptureBySceneIndex(this._vsCaptures.selectedIndex + 1);
               this.fitBitmapIntoCaptures(_loc1_,this._vsCaptures.selectedIndex + 1);
               Console.getConsole().requestLoadStatus(false);
            }
            this._vsCaptures.selectedIndex += 1;
            Console.getConsole().selectedThumbnailIndex = this._vsCaptures.selectedIndex;
            if(this._vsCaptures.selectedIndex == this._captures.length - 1)
            {
               this.enableButton(this._btnNext,false);
            }
            if(this._btnPrev.enabled == false)
            {
               this.enableButton(this._btnPrev,true);
            }
         }
      }
      
      private function initGroupComboBox() : void
      {
         var _loc1_:int = 0;
         var _loc6_:Boolean = false;
         var _loc2_:Array = Console.getConsole().groupController.getGroups();
         var _loc3_:Group = Console.getConsole().groupController.currentGroup;
         if(_loc3_.id != "0")
         {
            _loc6_ = false;
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               if(Group(_loc2_[_loc1_]).id == _loc3_.id)
               {
                  _loc6_ = true;
               }
               _loc1_++;
            }
            if(!_loc6_)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("name");
         var _loc4_:ArrayCollection = new ArrayCollection();
         var _loc5_:Number = 0;
         if(_loc2_.length > 0)
         {
            _loc4_.addItem({
               "label":UtilDict.toDisplay("go","Please select group"),
               "data":"-1"
            });
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               _loc4_.addItem({
                  "label":Group(_loc2_[_loc1_]).name,
                  "data":Group(_loc2_[_loc1_]).id
               });
               if(_loc3_ != null && _loc3_.id == Group(_loc2_[_loc1_]).id)
               {
                  Console.getConsole().groupController.tempCurrentGroup = _loc3_;
                  _loc5_ = _loc1_ + 1;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc4_.addItem({
               "label":UtilDict.toDisplay("go","No existing group"),
               "data":"0"
            });
            Console.getConsole().groupController.tempCurrentGroup = new Group();
            this._vbGroup.required = false;
            if(UtilSite.siteId != UtilSite.SKOLETUBE)
            {
               this._groupAlert.includeInLayout = this._groupAlert.visible = true;
               this.allowDraftOnly();
            }
         }
         this._cbGroup.dataProvider = _loc4_;
         this._cbGroup.selectedIndex = _loc5_;
      }
      
      private function allowDraftOnly() : void
      {
         this._published = false;
         this._pShared = false;
         this._radioPrivate.enabled = false;
         this._radioPublic.enabled = false;
         this._sharingOption.selection = this._radioDraft;
         this.setTempPublished();
      }
      
      private function initCategory() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Array = [{"label":"No category"}];
         var _loc2_:String = Console.getConsole().groupController.category;
         var _loc3_:XMLList = Console.getConsole().groupController.categoryList;
         if(_loc3_)
         {
            _loc1_ = [{"label":"Pick a Category"}];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc1_.push({"label":_loc3_[_loc4_].@name});
               if(_loc2_ == _loc3_[_loc4_].@name)
               {
                  this._cbCategory.selectedIndex = _loc4_ + 1;
               }
               _loc4_++;
            }
         }
         this._cbCategory.dataProvider = _loc1_;
      }
      
      private function onSaveMovieFromMusicPanel() : void
      {
         this.doSaveMovie(true,true);
      }
      
      private function onSaveBtnClick() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            Console.getConsole().tempPublished = false;
            Console.getConsole().tempPrivateShared = false;
            this.doSaveMovie();
         }
         else if(UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            Console.getConsole().tempPublished = false;
            Console.getConsole().tempPrivateShared = false;
            this.doSaveMovie(false,false,true);
         }
         else
         {
            this.doSaveMovie();
         }
      }
      
      private function onCloseBtnClick() : void
      {
         this.doSaveMovie(true);
      }
      
      private function onPostToProfile() : void
      {
         Console.getConsole().edSaveAssignment("post");
         this.doSaveMovie(true);
      }
      
      private function onSaveAndShareBtnClick() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            if(this.validateMovieDetail())
            {
               this._mainView.selectedChild = this._publishForm;
               this._publishForm.handleAccountType();
            }
         }
         else
         {
            if(UtilSite.siteId == UtilSite.ED || UtilSite.siteId == UtilSite.SCHOOLOGY)
            {
               Console.getConsole().edSaveAssignment("submit");
            }
            this.doSaveMovie(true);
         }
      }
      
      private function onSaveMovieComplete(param1:Event) : void
      {
         this._saveProgress.text = UtilDict.toDisplay("go","Project Saved");
         if(UtilSite.siteId != UtilSite.ED && UtilSite.siteId != UtilSite.SCHOOLOGY)
         {
            setTimeout(this.close,2000);
         }
         else
         {
            this.enabled = true;
         }
      }
      
      private function onSaveMovieFail(param1:Event) : void
      {
         this._saveProgress.text = UtilDict.toDisplay("go","Fail to save!");
         setTimeout(this.close,2000);
      }
      
      private function close() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function onSaveAsPublic() : void
      {
         Console.getConsole().tempPublished = true;
         Console.getConsole().tempPrivateShared = false;
         this.doSaveMovie(true,true);
      }
      
      private function onSaveAsPrivate() : void
      {
         Console.getConsole().tempPublished = false;
         Console.getConsole().tempPrivateShared = true;
         this.doSaveMovie(true,true);
      }
      
      private function onCreationComplete() : void
      {
         this.drawBg();
         if(UtilUser.userType == UtilUser.COMM_USER)
         {
            this.watermarkBox.includeInLayout = this.watermarkBox.visible = true;
         }
         if(Console.getConsole().watermarkManager.currentWatermark.url == "default")
         {
            this.watermark.loadDefaultLogo();
         }
         else
         {
            this.watermark.loadCustomLogoByUrl(Console.getConsole().watermarkManager.currentWatermark.url as String);
         }
         this.onSharingOptionChange();
      }
      
      private function drawBg() : void
      {
         var _loc1_:Number = 10;
         this.graphics.beginFill(10066329,0.5);
         this.graphics.drawRoundRectComplex(0,0,this.width,this.height,20,20,20,20);
         this.graphics.beginFill(15658734,1);
         this.graphics.drawRoundRectComplex(_loc1_,_loc1_,this.width - _loc1_ * 2,this.height - _loc1_ * 2,20,20,20,20);
         this.graphics.endFill();
      }
      
      private function onSharingOptionChange() : void
      {
         this.setTempPublished();
         this.setTempPrivateShared();
         this.draftBox.styleName = "publishWindowNormalBoxStyle";
         this.privateBox.styleName = "publishWindowNormalBoxStyle";
         this.publicBox.styleName = "publishWindowNormalBoxStyle";
         this._radioPublic.setStyle("color",10066329);
         this._radioPrivate.setStyle("color",10066329);
         this._radioPublic.setStyle("textRollOverColor",10066329);
         this._radioPrivate.setStyle("textRollOverColor",10066329);
         if(this._sharingOption.selection == this._radioDraft)
         {
            this.draftBox.styleName = "publishWindowDraftBoxStyle";
         }
         else if(this._sharingOption.selection == this._radioPublic)
         {
            this.publicBox.styleName = "publishWindowPublicBoxStyle";
            this._radioPublic.setStyle("color",16777215);
            this._radioPublic.setStyle("textRollOverColor",16777215);
         }
         else
         {
            this.privateBox.styleName = "publishWindowPrivateBoxStyle";
            this._radioPrivate.setStyle("color",16777215);
            this._radioPrivate.setStyle("textRollOverColor",16777215);
         }
      }
      
      private function onWatermarkBtnClick() : void
      {
         this._mainView.selectedChild = this.watermarkPanel;
         this.watermarkPanel.loadAllWatermarks(Console.getConsole().watermarkManager.watermarks);
         this.watermarkPanel.selectedWatermark = Console.getConsole().watermarkManager.currentWatermark;
      }
      
      private function onCancelUpdateWatermark() : void
      {
         this._mainView.selectedChild = this._pubForm;
      }
      
      private function onWatermarkUpdated() : void
      {
         this._mainView.selectedChild = this._pubForm;
         Console.getConsole().watermarkManager.currentWatermark = this.watermarkPanel.selectedWatermark;
         Console.getConsole().watermarkManager.saveWatermark(Console.getConsole().metaData.movieId);
         if(Console.getConsole().watermarkManager.currentWatermark.url == "default")
         {
            this.watermark.loadDefaultLogo();
         }
         else
         {
            this.watermark.loadCustomLogoByUrl(Console.getConsole().watermarkManager.currentWatermark.url as String);
         }
      }
      
      private function _PublishWindow_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.___sharingOption_change);
         _loc1_.initialized(this,"_sharingOption");
         this._sharingOption = _loc1_;
         BindingManager.executeBindings(this,"_sharingOption",this._sharingOption);
         return _loc1_;
      }
      
      public function ___sharingOption_change(param1:Event) : void
      {
         this.onSharingOptionChange();
      }
      
      public function ___PublishWindow_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function ___txtMovieTitle_change(param1:Event) : void
      {
         this.doModifyMovieName();
      }
      
      public function ___txtTags_change(param1:Event) : void
      {
         this.doModifyTags();
      }
      
      public function ___cbGroup_change(param1:ListEvent) : void
      {
         this.doModifyGroup();
      }
      
      public function ___txtDescription_change(param1:Event) : void
      {
         this.doModifyDescription();
      }
      
      public function ___btnPrev_click(param1:MouseEvent) : void
      {
         this.prevThumbnail();
      }
      
      public function ___btnNext_click(param1:MouseEvent) : void
      {
         this.nextThumbnail();
      }
      
      public function ___PublishWindow_IconTextButton1_click(param1:MouseEvent) : void
      {
         this.onWatermarkBtnClick();
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.onSaveBtnClick();
      }
      
      public function ___btnClose_click(param1:MouseEvent) : void
      {
         this.onCloseBtnClick();
      }
      
      public function ___btnPostToProfile_click(param1:MouseEvent) : void
      {
         this.onPostToProfile();
      }
      
      public function ___btnSaveNShare_click(param1:MouseEvent) : void
      {
         this.onSaveAndShareBtnClick();
      }
      
      public function ___soundForm_saveMovie(param1:Event) : void
      {
         this.onSaveMovieFromMusicPanel();
      }
      
      public function ___publishForm_saveAsPublic(param1:Event) : void
      {
         this.onSaveAsPublic();
      }
      
      public function ___publishForm_saveAsPrivate(param1:Event) : void
      {
         this.onSaveAsPrivate();
      }
      
      public function __watermarkPanel_cancel(param1:Event) : void
      {
         this.onCancelUpdateWatermark();
      }
      
      public function __watermarkPanel_watermarkUpdated(param1:Event) : void
      {
         this.onWatermarkUpdated();
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.onClose();
      }
      
      public function ___btnCloseTop_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
      
      private function _PublishWindow_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Save Your Video");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishWindow_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","A good title and description help make your video easier to find");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishWindow_Label2.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_movietitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishWindow_FormItem1.label");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_tags");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vbTags.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Separate with commas, e.g. Comedy, Romance");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtTagsAdd.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Group");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vbGroup.label");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_description");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishWindow_FormItem4.label");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Language");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vbLang.label");
         result[8] = new Binding(this,function():Object
         {
            return LANG_ARRAY;
         },null,"_langBox.dataProvider");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveas");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"savePanel.label");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_draft");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_radioDraft.label");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_private");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_radioPrivate.label");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_public");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_radioPublic.label");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_parent");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtAlert.text");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Create groups of students to enable publishing your animations.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishWindow_Text3.text");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Category");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_itemCategory.label");
         result[16] = new Binding(this,function():String
         {
            var _loc1_:* = _vsCaptures.selectedIndex + 1 + "/" + _captures.length;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_lblPage.text");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Commercial Settings");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishWindow_Label4.text");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Switch watermark") + " >";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PublishWindow_IconTextButton1.label");
         result[19] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_warningtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_lblWarning.text");
         result[20] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveonly");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSave.label");
         result[21] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_saveonlytips");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSave.toolTip");
         result[22] = new Binding(this,function():Boolean
         {
            return UtilUser.loggedIn;
         },null,"_btnSave.visible");
         result[23] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Close Studio");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnClose.label");
         result[24] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Close the Studio");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnClose.toolTip");
         result[25] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Post to Profile >");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnPostToProfile.label");
         return result;
      }
      
      mx_internal function _PublishWindow_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_PublishWindow_StylesInit_done)
         {
            return;
         }
         mx_internal::_PublishWindow_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".publishWindowTitleStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowTitleStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.color = 6710886;
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 20;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowSubtitleStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowSubtitleStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 10066329;
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 14;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowFormItemLabel");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowFormItemLabel",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.color = 6710886;
               this.textAlign = left;
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 16;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowBtnStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowBtnStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 11184810;
               this.textRollOverColor = 11184810;
               this.highlightAlphas = [0,0];
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 16;
               this.fillColors = [3355443,2236962,4473924,3355443];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 3355443;
               this.textSelectedColor = 11184810;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowMajorBtnStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowMajorBtnStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16777215;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 16;
               this.fillColors = [5026021,3643081,8177647,5026021];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 5026021;
               this.textSelectedColor = 16777215;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowRadioBtnStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowRadioBtnStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderColor = 13421772;
               this.color = 8947848;
               this.iconColor = 0;
               this.labelVerticalOffset = 20;
               this.textRollOverColor = 8947848;
               this.highlightAlphas = [0,0];
               this.fontSize = 14;
               this.fillColors = [16777215,16777215,16777215,16777215];
               this.fillAlphas = [1,1,1,1];
               this.textSelectedColor = 8947848;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowComboBoxStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowComboBoxStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderColor = 13421772;
               this.rollOverColor = 10066329;
               this.cornerRadius = 0;
               this.iconColor = 10066329;
               this.textRollOverColor = 16777215;
               this.fontSize = 14;
               this.fillAlphas = [1,1,1,1];
               this.selectionColor = 10066329;
               this.themeColor = 13421772;
               this.backgroundAlpha = 1;
               this.fontWeight = "normal";
               this.color = 10066329;
               this.arrowButtonWidth = 23;
               this.highlightAlphas = [0,0];
               this.fontFamily = "Verdana";
               this.fillColors = [16777215,16777215,16777215,15658734];
               this.textSelectedColor = 16777215;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowWhiteBoxStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowWhiteBoxStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.paddingTop = 5;
               this.borderColor = 13421772;
               this.backgroundColor = 16777215;
               this.borderThickness = 1;
               this.paddingBottom = 5;
               this.paddingLeft = 5;
               this.paddingRight = 5;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowDraftBoxStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowDraftBoxStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.borderColor = 3158064;
               this.backgroundColor = 3158064;
               this.cornerRadius = 3;
               this.paddingLeft = 8;
               this.paddingRight = 8;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowPrivateBoxStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowPrivateBoxStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.borderColor = 14720512;
               this.backgroundColor = 14720512;
               this.cornerRadius = 3;
               this.paddingLeft = 8;
               this.paddingRight = 8;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowPublicBoxStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowPublicBoxStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.borderColor = 3515108;
               this.backgroundColor = 3515108;
               this.cornerRadius = 3;
               this.paddingLeft = 8;
               this.paddingRight = 8;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowNormalBoxStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowNormalBoxStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.borderColor = 15658734;
               this.cornerRadius = 3;
               this.paddingLeft = 8;
               this.paddingRight = 8;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowMajorBtnStyle_blue");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowMajorBtnStyle_blue",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16777215;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 16;
               this.fillColors = [2915065,2907091,2907091,2915065];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 2915065;
               this.textSelectedColor = 16777215;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowMajorBtnStyle_orange");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowMajorBtnStyle_orange",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16777215;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 16;
               this.fillColors = [16744960,16752896,16752896,16744960];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 16744960;
               this.textSelectedColor = 16777215;
            };
         }
         style = styleManager.getStyleDeclaration(".publishWindowMajorBtnStyle_grey");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".publishWindowMajorBtnStyle_grey",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16777215;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 16;
               this.fillColors = [6710886,10066329,10066329,6710886];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 6710886;
               this.textSelectedColor = 16777215;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnClose() : Button
      {
         return this._2122106277_btnClose;
      }
      
      public function set _btnClose(param1:Button) : void
      {
         var _loc2_:Object = this._2122106277_btnClose;
         if(_loc2_ !== param1)
         {
            this._2122106277_btnClose = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnClose",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : IconTextButton
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _btnCloseTop(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnNext() : Button
      {
         return this._1730701776_btnNext;
      }
      
      public function set _btnNext(param1:Button) : void
      {
         var _loc2_:Object = this._1730701776_btnNext;
         if(_loc2_ !== param1)
         {
            this._1730701776_btnNext = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnNext",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPostToProfile() : Button
      {
         return this._2106366127_btnPostToProfile;
      }
      
      public function set _btnPostToProfile(param1:Button) : void
      {
         var _loc2_:Object = this._2106366127_btnPostToProfile;
         if(_loc2_ !== param1)
         {
            this._2106366127_btnPostToProfile = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPostToProfile",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPrev() : Button
      {
         return this._1730630288_btnPrev;
      }
      
      public function set _btnPrev(param1:Button) : void
      {
         var _loc2_:Object = this._1730630288_btnPrev;
         if(_loc2_ !== param1)
         {
            this._1730630288_btnPrev = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPrev",_loc2_,param1));
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
      public function get _btnSaveNShare() : Button
      {
         return this._1114913131_btnSaveNShare;
      }
      
      public function set _btnSaveNShare(param1:Button) : void
      {
         var _loc2_:Object = this._1114913131_btnSaveNShare;
         if(_loc2_ !== param1)
         {
            this._1114913131_btnSaveNShare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSaveNShare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cbCategory() : ComboBox
      {
         return this._2108378084_cbCategory;
      }
      
      public function set _cbCategory(param1:ComboBox) : void
      {
         var _loc2_:Object = this._2108378084_cbCategory;
         if(_loc2_ !== param1)
         {
            this._2108378084_cbCategory = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cbCategory",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cbGroup() : ComboBox
      {
         return this._1393458143_cbGroup;
      }
      
      public function set _cbGroup(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1393458143_cbGroup;
         if(_loc2_ !== param1)
         {
            this._1393458143_cbGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cbGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _groupAlert() : VBox
      {
         return this._1952108612_groupAlert;
      }
      
      public function set _groupAlert(param1:VBox) : void
      {
         var _loc2_:Object = this._1952108612_groupAlert;
         if(_loc2_ !== param1)
         {
            this._1952108612_groupAlert = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_groupAlert",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _itemCategory() : FormItem
      {
         return this._1424538864_itemCategory;
      }
      
      public function set _itemCategory(param1:FormItem) : void
      {
         var _loc2_:Object = this._1424538864_itemCategory;
         if(_loc2_ !== param1)
         {
            this._1424538864_itemCategory = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_itemCategory",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _langBox() : ComboBox
      {
         return this._1988842562_langBox;
      }
      
      public function set _langBox(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1988842562_langBox;
         if(_loc2_ !== param1)
         {
            this._1988842562_langBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_langBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblPage() : Label
      {
         return this._1962716122_lblPage;
      }
      
      public function set _lblPage(param1:Label) : void
      {
         var _loc2_:Object = this._1962716122_lblPage;
         if(_loc2_ !== param1)
         {
            this._1962716122_lblPage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblPage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblWarning() : Label
      {
         return this._1958100315_lblWarning;
      }
      
      public function set _lblWarning(param1:Label) : void
      {
         var _loc2_:Object = this._1958100315_lblWarning;
         if(_loc2_ !== param1)
         {
            this._1958100315_lblWarning = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblWarning",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _mainView() : ViewStack
      {
         return this._82141533_mainView;
      }
      
      public function set _mainView(param1:ViewStack) : void
      {
         var _loc2_:Object = this._82141533_mainView;
         if(_loc2_ !== param1)
         {
            this._82141533_mainView = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mainView",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _parentalAlert() : Canvas
      {
         return this._1384121864_parentalAlert;
      }
      
      public function set _parentalAlert(param1:Canvas) : void
      {
         var _loc2_:Object = this._1384121864_parentalAlert;
         if(_loc2_ !== param1)
         {
            this._1384121864_parentalAlert = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_parentalAlert",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _pubForm() : VBox
      {
         return this._2121733154_pubForm;
      }
      
      public function set _pubForm(param1:VBox) : void
      {
         var _loc2_:Object = this._2121733154_pubForm;
         if(_loc2_ !== param1)
         {
            this._2121733154_pubForm = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pubForm",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _publishForm() : PublishPanel
      {
         return this._1237099340_publishForm;
      }
      
      public function set _publishForm(param1:PublishPanel) : void
      {
         var _loc2_:Object = this._1237099340_publishForm;
         if(_loc2_ !== param1)
         {
            this._1237099340_publishForm = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_publishForm",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioDraft() : RadioButton
      {
         return this._1061294085_radioDraft;
      }
      
      public function set _radioDraft(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1061294085_radioDraft;
         if(_loc2_ !== param1)
         {
            this._1061294085_radioDraft = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioDraft",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPrivate() : RadioButton
      {
         return this._230640921_radioPrivate;
      }
      
      public function set _radioPrivate(param1:RadioButton) : void
      {
         var _loc2_:Object = this._230640921_radioPrivate;
         if(_loc2_ !== param1)
         {
            this._230640921_radioPrivate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPrivate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPublic() : RadioButton
      {
         return this._1113266043_radioPublic;
      }
      
      public function set _radioPublic(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1113266043_radioPublic;
         if(_loc2_ !== param1)
         {
            this._1113266043_radioPublic = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPublic",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _saveProgress() : SaveProgress
      {
         return this._1126007977_saveProgress;
      }
      
      public function set _saveProgress(param1:SaveProgress) : void
      {
         var _loc2_:Object = this._1126007977_saveProgress;
         if(_loc2_ !== param1)
         {
            this._1126007977_saveProgress = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_saveProgress",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sharingOption() : RadioButtonGroup
      {
         return this._1839914382_sharingOption;
      }
      
      public function set _sharingOption(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1839914382_sharingOption;
         if(_loc2_ !== param1)
         {
            this._1839914382_sharingOption = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sharingOption",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _soundForm() : MusicPanel
      {
         return this._993142004_soundForm;
      }
      
      public function set _soundForm(param1:MusicPanel) : void
      {
         var _loc2_:Object = this._993142004_soundForm;
         if(_loc2_ !== param1)
         {
            this._993142004_soundForm = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_soundForm",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtAlert() : Text
      {
         return this._1391325653_txtAlert;
      }
      
      public function set _txtAlert(param1:Text) : void
      {
         var _loc2_:Object = this._1391325653_txtAlert;
         if(_loc2_ !== param1)
         {
            this._1391325653_txtAlert = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtAlert",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtDescription() : TextArea
      {
         return this._143330933_txtDescription;
      }
      
      public function set _txtDescription(param1:TextArea) : void
      {
         var _loc2_:Object = this._143330933_txtDescription;
         if(_loc2_ !== param1)
         {
            this._143330933_txtDescription = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtDescription",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtMovieTitle() : TextArea
      {
         return this._12195225_txtMovieTitle;
      }
      
      public function set _txtMovieTitle(param1:TextArea) : void
      {
         var _loc2_:Object = this._12195225_txtMovieTitle;
         if(_loc2_ !== param1)
         {
            this._12195225_txtMovieTitle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtMovieTitle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTags() : TextArea
      {
         return this._1479694698_txtTags;
      }
      
      public function set _txtTags(param1:TextArea) : void
      {
         var _loc2_:Object = this._1479694698_txtTags;
         if(_loc2_ !== param1)
         {
            this._1479694698_txtTags = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTags",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTagsAdd() : Text
      {
         return this._1959512361_txtTagsAdd;
      }
      
      public function set _txtTagsAdd(param1:Text) : void
      {
         var _loc2_:Object = this._1959512361_txtTagsAdd;
         if(_loc2_ !== param1)
         {
            this._1959512361_txtTagsAdd = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTagsAdd",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vbGroup() : FormItem
      {
         return this._1710757388_vbGroup;
      }
      
      public function set _vbGroup(param1:FormItem) : void
      {
         var _loc2_:Object = this._1710757388_vbGroup;
         if(_loc2_ !== param1)
         {
            this._1710757388_vbGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vbLang() : FormItem
      {
         return this._1884609497_vbLang;
      }
      
      public function set _vbLang(param1:FormItem) : void
      {
         var _loc2_:Object = this._1884609497_vbLang;
         if(_loc2_ !== param1)
         {
            this._1884609497_vbLang = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbLang",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vbTags() : FormItem
      {
         return this._1884847620_vbTags;
      }
      
      public function set _vbTags(param1:FormItem) : void
      {
         var _loc2_:Object = this._1884847620_vbTags;
         if(_loc2_ !== param1)
         {
            this._1884847620_vbTags = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbTags",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vsCaptures() : ViewStack
      {
         return this._1985600873_vsCaptures;
      }
      
      public function set _vsCaptures(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1985600873_vsCaptures;
         if(_loc2_ !== param1)
         {
            this._1985600873_vsCaptures = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsCaptures",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get button_hbox() : HBox
      {
         return this._1759771312button_hbox;
      }
      
      public function set button_hbox(param1:HBox) : void
      {
         var _loc2_:Object = this._1759771312button_hbox;
         if(_loc2_ !== param1)
         {
            this._1759771312button_hbox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"button_hbox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get button_hbox_progress() : HBox
      {
         return this._944171068button_hbox_progress;
      }
      
      public function set button_hbox_progress(param1:HBox) : void
      {
         var _loc2_:Object = this._944171068button_hbox_progress;
         if(_loc2_ !== param1)
         {
            this._944171068button_hbox_progress = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"button_hbox_progress",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get draftBox() : HBox
      {
         return this._841671574draftBox;
      }
      
      public function set draftBox(param1:HBox) : void
      {
         var _loc2_:Object = this._841671574draftBox;
         if(_loc2_ !== param1)
         {
            this._841671574draftBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"draftBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get privateBox() : HBox
      {
         return this._1876079288privateBox;
      }
      
      public function set privateBox(param1:HBox) : void
      {
         var _loc2_:Object = this._1876079288privateBox;
         if(_loc2_ !== param1)
         {
            this._1876079288privateBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"privateBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get publicBox() : HBox
      {
         return this._1446891170publicBox;
      }
      
      public function set publicBox(param1:HBox) : void
      {
         var _loc2_:Object = this._1446891170publicBox;
         if(_loc2_ !== param1)
         {
            this._1446891170publicBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"publicBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get savePanel() : FormItem
      {
         return this._169721479savePanel;
      }
      
      public function set savePanel(param1:FormItem) : void
      {
         var _loc2_:Object = this._169721479savePanel;
         if(_loc2_ !== param1)
         {
            this._169721479savePanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"savePanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get spacer1() : Spacer
      {
         return this._2012162683spacer1;
      }
      
      public function set spacer1(param1:Spacer) : void
      {
         var _loc2_:Object = this._2012162683spacer1;
         if(_loc2_ !== param1)
         {
            this._2012162683spacer1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"spacer1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get watermark() : WatermarkPreview
      {
         return this._213424028watermark;
      }
      
      public function set watermark(param1:WatermarkPreview) : void
      {
         var _loc2_:Object = this._213424028watermark;
         if(_loc2_ !== param1)
         {
            this._213424028watermark = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"watermark",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get watermarkBox() : VBox
      {
         return this._1563553081watermarkBox;
      }
      
      public function set watermarkBox(param1:VBox) : void
      {
         var _loc2_:Object = this._1563553081watermarkBox;
         if(_loc2_ !== param1)
         {
            this._1563553081watermarkBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"watermarkBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get watermarkPanel() : WatermarkChoosingPanel
      {
         return this._676548608watermarkPanel;
      }
      
      public function set watermarkPanel(param1:WatermarkChoosingPanel) : void
      {
         var _loc2_:Object = this._676548608watermarkPanel;
         if(_loc2_ !== param1)
         {
            this._676548608watermarkPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"watermarkPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _published() : Boolean
      {
         return this._41509777_published;
      }
      
      private function set _published(param1:Boolean) : void
      {
         var _loc2_:Object = this._41509777_published;
         if(_loc2_ !== param1)
         {
            this._41509777_published = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_published",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _pShared() : Boolean
      {
         return this._1154689974_pShared;
      }
      
      private function set _pShared(param1:Boolean) : void
      {
         var _loc2_:Object = this._1154689974_pShared;
         if(_loc2_ !== param1)
         {
            this._1154689974_pShared = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pShared",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _captures() : UtilHashArray
      {
         return this._40784716_captures;
      }
      
      private function set _captures(param1:UtilHashArray) : void
      {
         var _loc2_:Object = this._40784716_captures;
         if(_loc2_ !== param1)
         {
            this._40784716_captures = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_captures",_loc2_,param1));
            }
         }
      }
   }
}
