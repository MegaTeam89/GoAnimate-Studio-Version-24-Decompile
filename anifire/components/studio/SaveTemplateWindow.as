package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.components.publish.PublishWindow;
   import anifire.constant.AnimeConstants;
   import anifire.core.Console;
   import anifire.event.CoreEvent;
   import anifire.managers.FeatureManager;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
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
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.utils.StringUtil;
   
   use namespace mx_internal;
   
   public class SaveTemplateWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _SaveTemplateWindow_Label1:Label;
      
      public var _SaveTemplateWindow_Label10:Label;
      
      public var _SaveTemplateWindow_Label11:Label;
      
      public var _SaveTemplateWindow_Label2:Label;
      
      public var _SaveTemplateWindow_Label3:Label;
      
      public var _SaveTemplateWindow_Label4:Label;
      
      public var _SaveTemplateWindow_Label5:Label;
      
      public var _SaveTemplateWindow_Label7:Label;
      
      private var _2044384006_btnCloseTop:IconTextButton;
      
      private var _1730701776_btnNext:Button;
      
      private var _1730630288_btnPrev:Button;
      
      private var _1730556742_btnSave:Button;
      
      private var _1962716122_lblPage:Label;
      
      private var _1958100315_lblWarning:Label;
      
      private var _91078296_main:ViewStack;
      
      private var _82141533_mainView:ViewStack;
      
      private var _2121733154_pubForm:VBox;
      
      private var _12195225_txtMovieTitle:TextArea;
      
      private var _1479694698_txtTags:TextArea;
      
      private var _1959512361_txtTagsAdd:Text;
      
      private var _1463219121_vbTag:VBox;
      
      private var _344451050_vboxDone:VBox;
      
      private var _1985600873_vsCaptures:ViewStack;
      
      private var _1816075551_vsMoreInfo:ViewStack;
      
      private var _588202945_winDone:Canvas;
      
      private var _587769286_winSave:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _40784716_captures:UtilHashArray;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SaveTemplateWindow()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "stylesFactory":function():void
            {
               this.verticalAlign = "middle";
               this.horizontalAlign = "center";
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":616,
                  "height":320,
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":ViewStack,
                     "id":"_main",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "verticalCenter":0,
                           "horizontalCenter":0,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_winSave",
                              "events":{"creationComplete":"___winSave_creationComplete"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "styleName":"popupWindowWhite",
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":ViewStack,
                                       "id":"_mainView",
                                       "stylesFactory":function():void
                                       {
                                          this.paddingTop = 10;
                                          this.paddingBottom = 15;
                                          this.paddingLeft = 15;
                                          this.paddingRight = 15;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"_pubForm",
                                                "stylesFactory":function():void
                                                {
                                                   this.verticalGap = 5;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "horizontalScrollPolicy":"off",
                                                      "verticalScrollPolicy":"off",
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_SaveTemplateWindow_Label1",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"styleName":"title"};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":VBox,
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.verticalGap = 0;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.verticalAlign = "bottom";
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "id":"_SaveTemplateWindow_Label2",
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {"styleName":"midTitle"};
                                                                              }
                                                                           }),new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "id":"_SaveTemplateWindow_Label3",
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.color = 16730369;
                                                                                 this.fontSize = 12;
                                                                                 this.fontWeight = "normal";
                                                                              }
                                                                           })]};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":TextArea,
                                                                        "id":"_txtMovieTitle",
                                                                        "events":{"change":"___txtMovieTitle_change"},
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.fontWeight = "bold";
                                                                           this.fontSize = 12;
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "height":20,
                                                                              "width":295,
                                                                              "maxChars":50
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"height":5};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":ViewStack,
                                                                        "id":"_vsMoreInfo",
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"childDescriptors":[new UIComponentDescriptor({
                                                                              "type":VBox,
                                                                              "id":"_vbTag",
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.verticalGap = 0;
                                                                                 this.verticalAlign = "top";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "horizontalScrollPolicy":"off",
                                                                                    "verticalScrollPolicy":"off",
                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                       "type":HBox,
                                                                                       "stylesFactory":function():void
                                                                                       {
                                                                                          this.verticalAlign = "bottom";
                                                                                       },
                                                                                       "propertiesFactory":function():Object
                                                                                       {
                                                                                          return {"childDescriptors":[new UIComponentDescriptor({
                                                                                             "type":Label,
                                                                                             "id":"_SaveTemplateWindow_Label4",
                                                                                             "propertiesFactory":function():Object
                                                                                             {
                                                                                                return {"styleName":"midTitle"};
                                                                                             }
                                                                                          }),new UIComponentDescriptor({
                                                                                             "type":Label,
                                                                                             "id":"_SaveTemplateWindow_Label5",
                                                                                             "stylesFactory":function():void
                                                                                             {
                                                                                                this.color = 16730369;
                                                                                                this.fontSize = 12;
                                                                                                this.fontWeight = "normal";
                                                                                             }
                                                                                          })]};
                                                                                       }
                                                                                    }),new UIComponentDescriptor({
                                                                                       "type":TextArea,
                                                                                       "id":"_txtTags",
                                                                                       "events":{"change":"___txtTags_change"},
                                                                                       "stylesFactory":function():void
                                                                                       {
                                                                                          this.fontSize = 12;
                                                                                          this.fontWeight = "bold";
                                                                                       },
                                                                                       "propertiesFactory":function():Object
                                                                                       {
                                                                                          return {
                                                                                             "height":20,
                                                                                             "width":295,
                                                                                             "maxChars":50
                                                                                          };
                                                                                       }
                                                                                    }),new UIComponentDescriptor({
                                                                                       "type":Text,
                                                                                       "id":"_txtTagsAdd",
                                                                                       "stylesFactory":function():void
                                                                                       {
                                                                                          this.fontSize = 11;
                                                                                          this.textAlign = "left";
                                                                                       },
                                                                                       "propertiesFactory":function():Object
                                                                                       {
                                                                                          return {
                                                                                             "width":291,
                                                                                             "styleName":"midTitle",
                                                                                             "selectable":false
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
                                                                           return {"height":5};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":209,
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
                                                                                       "horizontalCenter":0,
                                                                                       "visible":false
                                                                                    };
                                                                                 }
                                                                              })]
                                                                           };
                                                                        }
                                                                     })]};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Canvas,
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "width":30,
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":Canvas,
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "styleName":"verticalSpacer",
                                                                                 "width":2,
                                                                                 "height":200,
                                                                                 "horizontalCenter":0
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":VBox,
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.verticalGap = 0;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_SaveTemplateWindow_Label7",
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"styleName":"midTitle"};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.cornerRadius = 8;
                                                                           this.backgroundColor = 5658198;
                                                                           this.borderThickness = 6;
                                                                           this.borderColor = 5658198;
                                                                           this.borderStyle = "solid";
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":232,
                                                                              "height":153,
                                                                              "horizontalScrollPolicy":"off",
                                                                              "verticalScrollPolicy":"off",
                                                                              "childDescriptors":[new UIComponentDescriptor({
                                                                                 "type":ViewStack,
                                                                                 "id":"_vsCaptures",
                                                                                 "propertiesFactory":function():Object
                                                                                 {
                                                                                    return {
                                                                                       "width":220,
                                                                                       "height":141
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
                                                                     })]};
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HRule,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "height":1
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "stylesFactory":function():void
                                                         {
                                                            this.paddingLeft = 5;
                                                            this.paddingRight = 5;
                                                            this.horizontalGap = 0;
                                                            this.verticalAlign = "middle";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Spacer,
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"percentWidth":100};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_btnSave",
                                                                  "events":{"click":"___btnSave_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnOrange",
                                                                        "width":150,
                                                                        "height":48,
                                                                        "buttonMode":true
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Spacer,
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"percentWidth":100};
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
                                       "type":IconTextButton,
                                       "id":"_btnCloseTop",
                                       "events":{
                                          "click":"___btnCloseTop_click",
                                          "creationComplete":"___btnCloseTop_creationComplete"
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "right":10,
                                             "top":10,
                                             "styleName":"btnCloseTop",
                                             "buttonMode":true,
                                             "labelPlacement":"left"
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_winDone",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "horizontalCenter":0,
                                    "verticalCenter":0,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":VBox,
                                       "id":"_vboxDone",
                                       "stylesFactory":function():void
                                       {
                                          this.verticalAlign = "middle";
                                          this.horizontalAlign = "center";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":346,
                                             "height":122,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function():void
                                                {
                                                   this.color = 932449;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "text":"Template Added!",
                                                      "styleName":"title"
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {"childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_SaveTemplateWindow_Label10",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"midTitle"};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"imgBgIcon",
                                                            "width":22,
                                                            "height":22
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_SaveTemplateWindow_Label11",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"midTitle"};
                                                      }
                                                   })]};
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
         var bindings:Array = this._SaveTemplateWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_SaveTemplateWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SaveTemplateWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.layout = "absolute";
         this.width = 616;
         this.height = 320;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.styleName = "popupWindow";
         this.creationPolicy = "all";
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SaveTemplateWindow._watcherSetupUtil = param1;
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
            this.verticalAlign = "middle";
            this.horizontalAlign = "center";
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function fitBitmapIntoCaptures(param1:BitmapData, param2:int) : void
      {
         var _loc3_:Image = null;
         var _loc5_:Bitmap = null;
         if(param1)
         {
            (_loc5_ = new Bitmap(param1)).width = 220;
            _loc5_.height = 141;
            _loc3_ = new Image();
            _loc3_.addChild(_loc5_);
         }
         var _loc4_:Canvas;
         (_loc4_ = new Canvas()).width = this._vsCaptures.width;
         _loc4_.height = this._vsCaptures.height;
         if(_loc3_)
         {
            _loc4_.addChild(_loc3_);
         }
         if(this._vsCaptures.numChildren > param2 && this._vsCaptures.getChildAt(param2))
         {
            this._vsCaptures.removeChildAt(param2);
         }
         this._vsCaptures.addChildAt(_loc4_,param2);
      }
      
      private function initWindow() : void
      {
         this._mainView.selectedChild = this._pubForm;
         this._winSave.graphics.beginFill(16777215);
         this._winSave.graphics.drawRoundRectComplex(0,0,this._winSave.width,this._winSave.height,12,12,12,12);
         this._winSave.graphics.endFill();
         this._vboxDone.graphics.beginFill(16777215);
         this._vboxDone.graphics.drawRoundRectComplex(0,0,this._vboxDone.width,this._vboxDone.height,12,12,12,12);
         this._vboxDone.graphics.endFill();
      }
      
      public function initSaveTemplateWindow(param1:UtilHashArray, param2:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc5_:BitmapData = null;
         var _loc6_:int = 0;
         var _loc7_:BitmapData = null;
         var _loc8_:Number = NaN;
         var _loc3_:Number = 0;
         this._captures = param1;
         if(param1 != null)
         {
            _loc4_ = 0;
            if(!param2)
            {
               _loc3_ = _loc4_ = Console.getConsole().currentSceneIndex;
               _loc6_ = 0;
               while(_loc6_ < param1.length)
               {
                  _loc7_ = param1.getValueByIndex(_loc6_);
                  this.fitBitmapIntoCaptures(_loc7_,_loc6_);
                  _loc6_++;
               }
            }
            _loc5_ = Console.getConsole().getThumbnailCaptureBySceneIndex(_loc4_);
            Console.getConsole().selectedThumbForTempIndex = _loc4_;
            this.fitBitmapIntoCaptures(_loc5_,_loc4_);
            if(_loc3_ > param1.length - 1)
            {
               _loc3_ = param1.length - 1;
            }
            this._lblPage.text = _loc3_ + 1 + "/" + param1.length;
            if(param2)
            {
               if(_loc3_ == 0)
               {
                  this.enableButton(this._btnPrev,false);
               }
               if(_loc3_ == param1.length - 1)
               {
                  this.enableButton(this._btnNext,false);
               }
            }
            else
            {
               this.enableButton(this._btnPrev,false);
               this.enableButton(this._btnNext,false);
            }
            this._vsCaptures.selectedIndex = _loc3_;
         }
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            if((_loc8_ = Util.roundNum(Console.getConsole().timeline.getTotalTimeInSec())) > FeatureManager.maxMovieDuration)
            {
               UtilPopUp.alert(UtilDict.toDisplay("go","As your movie is longer than 2 mins, you may only save it as a draft. In order to publish it, you have to make it shorter or upgrade your account to GoPlus."));
            }
         }
      }
      
      private function doModifyMovieName() : void
      {
         Console.getConsole().templateMetaData.title = this._txtMovieTitle.text;
      }
      
      private function doModifyTags() : void
      {
         Console.getConsole().templateMetaData.setUgcTagsByString(this._txtTags.text);
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
         return true;
      }
      
      private function doSaveMovie(param1:Boolean = false, param2:Boolean = false) : void
      {
         var redirect:Boolean = param1;
         var skipAddSound:Boolean = param2;
         if(this.validateMovieDetail() == false)
         {
            return;
         }
         var self:IEventDispatcher = this;
         Console.getConsole().addEventListener(CoreEvent.SERIALIZE_COMPLETE,function(param1:CoreEvent):void
         {
            Console.getConsole().removeEventListener(CoreEvent.SERIALIZE_COMPLETE,arguments.callee);
         });
         this.orderConsoleToSaveMovie();
      }
      
      private function orderConsoleToSaveMovie() : void
      {
         this.enabled = false;
         Console.getConsole().addEventListener(CoreEvent.SAVE_MOVIE_COMPLETE,this.onSaveMovieComplete);
         Console.getConsole().addEventListener(CoreEvent.SAVE_MOVIE_ERROR_OCCUR,this.onSaveMovieFail);
         Console.getConsole().publishTemplate();
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
      
      public function setBtnStatus(param1:Boolean) : void
      {
         if(this._mainView.selectedChild == this._pubForm)
         {
            this.enableButton(this._btnSave,param1);
            this._txtMovieTitle.enabled = param1;
            this._txtTags.enabled = param1;
            this._btnPrev.enabled = param1;
            this._btnNext.enabled = param1;
            this._btnCloseTop.visible = param1;
         }
      }
      
      private function initClose() : void
      {
         var _loc1_:ColorTransform = new ColorTransform(0.5,0.5,0.5);
         this._btnCloseTop.transform.colorTransform = _loc1_;
      }
      
      private function onClose() : void
      {
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
      
      private function enableButton(param1:Button, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param1 != null)
         {
            param1.enabled = param2;
            param1.buttonMode = param2;
         }
      }
      
      private function prevThumbnail() : void
      {
         if(this._vsCaptures.selectedIndex > 0)
         {
            --this._vsCaptures.selectedIndex;
            Console.getConsole().selectedThumbForTempIndex = this._vsCaptures.selectedIndex;
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
            Console.getConsole().selectedThumbForTempIndex = this._vsCaptures.selectedIndex;
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
      
      private function onSaveMovieFromMusicPanel() : void
      {
         this.doSaveMovie(true,true);
      }
      
      private function onSaveBtnClick() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.SKOLETUBE)
         {
            Console.getConsole().tempPublished = false;
            Console.getConsole().tempPrivateShared = false;
         }
         this.doSaveMovie();
      }
      
      private function onSaveAndShareBtnClick() : void
      {
         this.doSaveMovie(true);
      }
      
      private function onSaveMovieComplete(param1:Event = null) : void
      {
         this.enabled = true;
         this._main.selectedChild = this._winDone;
         setTimeout(this.close,4000);
      }
      
      private function onSaveMovieFail(param1:Event) : void
      {
         setTimeout(this.close,2000);
      }
      
      private function close() : void
      {
         Console.getConsole().closeSaveTempWindow();
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
      
      public function ___winSave_creationComplete(param1:FlexEvent) : void
      {
         this.initWindow();
      }
      
      public function ___txtMovieTitle_change(param1:Event) : void
      {
         this.doModifyMovieName();
      }
      
      public function ___txtTags_change(param1:Event) : void
      {
         this.doModifyTags();
      }
      
      public function ___btnPrev_click(param1:MouseEvent) : void
      {
         this.prevThumbnail();
      }
      
      public function ___btnNext_click(param1:MouseEvent) : void
      {
         this.nextThumbnail();
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.onSaveBtnClick();
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.onClose();
      }
      
      public function ___btnCloseTop_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
      
      private function _SaveTemplateWindow_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Save a new template");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SaveTemplateWindow_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Title");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SaveTemplateWindow_Label2.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_required");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SaveTemplateWindow_Label3.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Tags");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SaveTemplateWindow_Label4.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_required");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SaveTemplateWindow_Label5.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_tagsub");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtTagsAdd.text");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_warningtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_lblWarning.text");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","pubwin_pickthumb");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SaveTemplateWindow_Label7.text");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = _vsCaptures.selectedIndex + 1 + "/" + _captures.length;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_lblPage.text");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Save");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSave.label");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Close");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCloseTop.label");
         result[11] = new Binding(this,function():Object
         {
            return (_winDone.height - _vboxDone.height) / 2;
         },null,"_vboxDone.top");
         result[12] = new Binding(this,function():Object
         {
            return (_winDone.width - _vboxDone.width) / 2;
         },null,"_vboxDone.left");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Visit this tab");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SaveTemplateWindow_Label10.text");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","in Your Stuff to find it");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SaveTemplateWindow_Label11.text");
         return result;
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
      public function get _main() : ViewStack
      {
         return this._91078296_main;
      }
      
      public function set _main(param1:ViewStack) : void
      {
         var _loc2_:Object = this._91078296_main;
         if(_loc2_ !== param1)
         {
            this._91078296_main = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_main",_loc2_,param1));
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
      public function get _vbTag() : VBox
      {
         return this._1463219121_vbTag;
      }
      
      public function set _vbTag(param1:VBox) : void
      {
         var _loc2_:Object = this._1463219121_vbTag;
         if(_loc2_ !== param1)
         {
            this._1463219121_vbTag = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbTag",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vboxDone() : VBox
      {
         return this._344451050_vboxDone;
      }
      
      public function set _vboxDone(param1:VBox) : void
      {
         var _loc2_:Object = this._344451050_vboxDone;
         if(_loc2_ !== param1)
         {
            this._344451050_vboxDone = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vboxDone",_loc2_,param1));
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
      public function get _vsMoreInfo() : ViewStack
      {
         return this._1816075551_vsMoreInfo;
      }
      
      public function set _vsMoreInfo(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1816075551_vsMoreInfo;
         if(_loc2_ !== param1)
         {
            this._1816075551_vsMoreInfo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vsMoreInfo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _winDone() : Canvas
      {
         return this._588202945_winDone;
      }
      
      public function set _winDone(param1:Canvas) : void
      {
         var _loc2_:Object = this._588202945_winDone;
         if(_loc2_ !== param1)
         {
            this._588202945_winDone = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_winDone",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _winSave() : Canvas
      {
         return this._587769286_winSave;
      }
      
      public function set _winSave(param1:Canvas) : void
      {
         var _loc2_:Object = this._587769286_winSave;
         if(_loc2_ !== param1)
         {
            this._587769286_winSave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_winSave",_loc2_,param1));
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
