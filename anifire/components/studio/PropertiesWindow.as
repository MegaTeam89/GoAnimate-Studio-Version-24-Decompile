package anifire.components.studio
{
   import anifire.assets.panel.AssetViewColorPanel;
   import anifire.assets.panel.PropertyThumbnail;
   import anifire.assets.transition.view.AssetTransitionPanel;
   import anifire.assets.view.AssetViewCollection;
   import anifire.component.TextButton;
   import anifire.components.containers.AssetEffectControl;
   import anifire.components.containers.AssetHyperLink;
   import anifire.components.containers.AssetTiming;
   import anifire.components.containers.CameraSettingPanel;
   import anifire.components.containers.SceneOption;
   import anifire.core.AnimeScene;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.ProgramEffectAsset;
   import anifire.core.Prop;
   import anifire.core.VideoProp;
   import anifire.font.FontChooser;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IColorable;
   import anifire.managers.FeatureManager;
   import anifire.tutorial.TutorialEvent;
   import anifire.util.UtilArray;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TabNavigator;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.INavigatorContent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Blur;
   import mx.effects.Sequence;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   
   use namespace mx_internal;
   
   public class PropertiesWindow extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _PropertiesWindow_AssetEffectControl1:AssetEffectControl;
      
      public var _PropertiesWindow_AssetHyperLink1:AssetHyperLink;
      
      public var _PropertiesWindow_AssetTiming1:AssetTiming;
      
      public var _PropertiesWindow_AssetTiming2:AssetTiming;
      
      public var _PropertiesWindow_Button1:Button;
      
      public var _PropertiesWindow_HRule1:HRule;
      
      public var _PropertiesWindow_HRule2:HRule;
      
      public var _PropertiesWindow_Text1:Text;
      
      public var _PropertiesWindow_Text4:Text;
      
      public var _PropertiesWindow_TextButton1:TextButton;
      
      public var _PropertiesWindow_VBox6:VBox;
      
      private var _94436_bg:VBox;
      
      private var _1480441607_close:Canvas;
      
      private var _1336746749_maskCanvas:Canvas;
      
      private var _713047211_txtWarning:Text;
      
      private var _1569328494actionPanel:CharacterActionPanel;
      
      private var _862566241assetTransitionPanel:AssetTransitionPanel;
      
      private var _1795707688blurEffect:Sequence;
      
      private var _764566744bubblePanel:FontChooser;
      
      private var _11548545buttonBar:AssetButtonBar;
      
      private var _798688601cameraSettingPanel:CameraSettingPanel;
      
      private var _1275269217colorPanel:AssetViewColorPanel;
      
      private var _1646834419effectPanel:VBox;
      
      private var _2079239841navPanel:TabNavigator;
      
      private var _57971299sceneOptionPanel:SceneOption;
      
      private var _1918169430speechBlocked:VBox;
      
      private var _1202262587speechComponent:SpeechComponent;
      
      private var _1758088770speechPanel:VBox;
      
      private var _611009540speechStop:VBox;
      
      private var _2131205345speechVS:ViewStack;
      
      private var _241989645statePanel:PropStatePanel;
      
      private var _2060497896subtitle:Text;
      
      private var _1330532588thumbnail:PropertyThumbnail;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _1827565232_target:Object;
      
      private var _active:Boolean = false;
      
      private var hoverStyles:String = "a:hover { color: #0000CC; text-decoration: underline; } a { color: #0000CC; text-decoration: none; }";
      
      private var _actionXml:XML = null;
      
      private var _lastSelectedIndex_char:int = -1;
      
      private var _lastSelectedIndex_bubble:int = -1;
      
      private var _lastSelectedIndex_all:int = -1;
      
      private var _view:IAssetView;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function PropertiesWindow()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "resize":"___PropertiesWindow_Canvas1_resize",
               "initialize":"___PropertiesWindow_Canvas1_initialize"
            },
            "propertiesFactory":function():Object
            {
               return {
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":VBox,
                     "id":"_bg",
                     "stylesFactory":function():void
                     {
                        this.verticalGap = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"sidePanel",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":HBox,
                              "stylesFactory":function():void
                              {
                                 this.horizontalGap = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":PropertyThumbnail,
                                       "id":"thumbnail"
                                    }),new UIComponentDescriptor({
                                       "type":Spacer,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentWidth":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":AssetButtonBar,
                                       "id":"buttonBar"
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HBox,
                              "stylesFactory":function():void
                              {
                                 this.horizontalGap = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":TabNavigator,
                                       "id":"navPanel",
                                       "events":{"change":"__navPanel_change"},
                                       "stylesFactory":function():void
                                       {
                                          this.tabWidth = 64;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "styleName":"vsSidePanel",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":SceneOption,
                                                "id":"sceneOptionPanel"
                                             }),new UIComponentDescriptor({
                                                "type":CharacterActionPanel,
                                                "id":"actionPanel"
                                             }),new UIComponentDescriptor({
                                                "type":ViewStack,
                                                "id":"speechVS",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "id":"speechPanel",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "label":"Speech",
                                                               "percentWidth":100,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":SpeechComponent,
                                                                  "id":"speechComponent",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"percentWidth":100};
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "id":"speechBlocked",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalGap = 10;
                                                            this.horizontalAlign = "center";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "top":12,
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Text,
                                                                  "id":"_PropertiesWindow_Text1",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.textAlign = "center";
                                                                     this.fontSize = 14;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"percentWidth":100};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_PropertiesWindow_Button1",
                                                                  "events":{"click":"___PropertiesWindow_Button1_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingLeft = 12;
                                                                     this.paddingRight = 12;
                                                                     this.paddingTop = 12;
                                                                     this.paddingBottom = 12;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "styleName":"btnAddVoice"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":TextButton,
                                                                  "id":"_PropertiesWindow_TextButton1",
                                                                  "events":{"click":"___PropertiesWindow_TextButton1_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "buttonMode":true,
                                                                        "txtAlign":"center",
                                                                        "txtSize":10,
                                                                        "textDecoration":"underline",
                                                                        "color":0
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "id":"speechStop",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalGap = 10;
                                                            this.verticalAlign = "middle";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Text,
                                                                  "id":"_txtWarning",
                                                                  "events":{"link":"___txtWarning_link"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.textAlign = "center";
                                                                  },
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
                                             }),new UIComponentDescriptor({
                                                "type":AssetViewColorPanel,
                                                "id":"colorPanel"
                                             }),new UIComponentDescriptor({
                                                "type":PropStatePanel,
                                                "id":"statePanel"
                                             }),new UIComponentDescriptor({
                                                "type":FontChooser,
                                                "id":"bubblePanel"
                                             }),new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"effectPanel",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Text,
                                                         "id":"subtitle",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":AssetTiming,
                                                         "id":"_PropertiesWindow_AssetTiming1",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"_PropertiesWindow_VBox6",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Text,
                                                         "id":"_PropertiesWindow_Text4",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":AssetTiming,
                                                         "id":"_PropertiesWindow_AssetTiming2",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HRule,
                                                         "id":"_PropertiesWindow_HRule1",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":AssetHyperLink,
                                                         "id":"_PropertiesWindow_AssetHyperLink1",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HRule,
                                                         "id":"_PropertiesWindow_HRule2",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"percentWidth":100};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":AssetEffectControl,
                                                         "id":"_PropertiesWindow_AssetEffectControl1"
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":AssetTransitionPanel,
                                                "id":"assetTransitionPanel",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":CameraSettingPanel,
                                                "id":"cameraSettingPanel"
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Spacer,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"width":10};
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_close",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "right":12,
                           "verticalCenter":0
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_maskCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "alpha":0,
                           "visible":false
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
         var bindings:Array = this._PropertiesWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_PropertiesWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return PropertiesWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.creationPolicy = "all";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._PropertiesWindow_Sequence1_i();
         this.addEventListener("resize",this.___PropertiesWindow_Canvas1_resize);
         this.addEventListener("initialize",this.___PropertiesWindow_Canvas1_initialize);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         PropertiesWindow._watcherSetupUtil = param1;
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
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
      }
      
      public function set target(param1:Object) : void
      {
         this.thumbnail.target = param1;
         var _loc2_:Boolean = this.isColorable(param1);
         var _loc3_:Boolean = false;
         this._view = null;
         if(param1 is IAssetView)
         {
            this._view = param1 as IAssetView;
            param1 = IAssetView(param1).asset;
         }
         this._target = param1;
         this.actionPanelVisible = false;
         this.speechPanelVisible = false;
         this.colorPanelVisible = false;
         this.statePanelVisible = false;
         this.bubblePanelVisible = false;
         this.effectPanelVisible = false;
         this.advPanelVisible = false;
         this.sceneOptionVisible = false;
         this.assetTransitionPanelVisible = false;
         this.cameraSettingPanelVisible = false;
         this.navPanel.visible = false;
         if(param1 is ProgramEffectAsset && ProgramEffectAsset(param1).getExactType() == "zoom")
         {
            _loc3_ = true;
         }
         if(this.transitionApplyable(param1))
         {
            this.assetTransitionPanelVisible = true;
            this.navPanel.selectedChild = this.assetTransitionPanel;
         }
         if(_loc2_)
         {
            this.colorPanelVisible = true;
            this.navPanel.selectedChild = this.colorPanel;
         }
         if(!(param1 is Background))
         {
            if(param1 is Prop)
            {
               if(Prop(param1).state)
               {
                  this.statePanelVisible = true;
                  this.navPanel.selectedChild = this.statePanel;
               }
               if(this._lastSelectedIndex_all >= 0 && this.navPanel.getTabAt(this._lastSelectedIndex_all).visible)
               {
                  this.navPanel.selectedIndex = this._lastSelectedIndex_all;
               }
            }
            else if(param1 is Character)
            {
               this.speechVS.label = UtilDict.toDisplay("go","Voice");
               this.actionPanelVisible = true;
               this.speechPanelVisible = true;
               this.navPanel.selectedChild = !!UtilUser.loggedIn ? this.speechVS : this.actionPanel;
               if(this._lastSelectedIndex_all >= 0 && this.navPanel.getTabAt(this._lastSelectedIndex_all).visible)
               {
                  this.navPanel.selectedIndex = this._lastSelectedIndex_all;
               }
               else if(this._lastSelectedIndex_char >= 0 && this.navPanel.getTabAt(this._lastSelectedIndex_char).visible)
               {
                  this.navPanel.selectedIndex = this._lastSelectedIndex_char;
               }
            }
            else if(param1 is BubbleAsset)
            {
               this.bubblePanelVisible = true;
               this.navPanel.selectedChild = this.bubblePanel;
               this.advPanelVisible = true;
               if(this._lastSelectedIndex_all >= 0 && this.navPanel.getTabAt(this._lastSelectedIndex_all).visible)
               {
                  this.navPanel.selectedIndex = this._lastSelectedIndex_all;
               }
               else if(this._lastSelectedIndex_bubble >= 0 && this.navPanel.getTabAt(this._lastSelectedIndex_bubble).visible)
               {
                  this.navPanel.selectedIndex = this._lastSelectedIndex_bubble;
               }
            }
            else if(param1 is EffectAsset && !_loc3_ || Console.getConsole().metaData.mver <= 3 && _loc3_)
            {
               this.effectPanelVisible = true;
               this.navPanel.selectedChild = this.effectPanel;
            }
            else if(param1 is AnimeScene || param1 is EffectAsset)
            {
               this.sceneOptionVisible = true;
               if(this.sceneNarrationApplyable())
               {
                  this.speechVS.label = UtilDict.toDisplay("go","Narration");
                  this.updateSpeechPanel();
                  this.speechPanelVisible = true;
               }
               if(Console.getConsole().metaData.mver > 3)
               {
                  this.cameraSettingPanelVisible = true;
               }
               if(param1 is EffectAsset)
               {
                  this.navPanel.selectedChild = this.cameraSettingPanel;
                  this.onNavChange();
                  this.speechComponent.target = this.sceneOptionPanel.target = EffectAsset(param1).scene;
               }
               else
               {
                  this.navPanel.selectedChild = this.sceneOptionPanel;
               }
            }
            else
            {
               this._target = null;
            }
         }
         if(this.navPanel.selectedChild == this.colorPanel)
         {
            this.colorPanel.target = this._view;
         }
         else if(this.navPanel.selectedChild == this.actionPanel)
         {
            this.actionPanel.target = this._view;
         }
         else if(this.navPanel.selectedChild == this.speechVS)
         {
            this.updateSpeechPanel();
         }
      }
      
      private function sceneNarrationApplyable() : Boolean
      {
         if(UtilSite.isDevelopmentSite)
         {
         }
         if(UtilUser.userType == UtilUser.COMM_USER || UtilUser.userType == UtilUser.ADMIN_USER)
         {
         }
         return true;
      }
      
      private function transitionApplyable(param1:Object) : Boolean
      {
         if(param1 is VideoProp)
         {
            return false;
         }
         return param1 is Prop || param1 is Character || param1 is BubbleAsset;
      }
      
      private function isColorable(param1:Object) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:IAssetView = null;
         var _loc4_:DisplayObject = null;
         if(param1 is IAssetView)
         {
            _loc3_ = param1 as IAssetView;
            if(_loc3_.asset is Asset)
            {
               _loc2_ = Asset(_loc3_.asset).getColorArea();
            }
            if((_loc4_ = _loc3_.assetImage) is IColorable)
            {
               _loc2_ = _loc2_.concat(IColorable(_loc4_).colorableArea);
            }
         }
         if(_loc2_)
         {
            _loc2_ = UtilArray.removeDuplicates(_loc2_,true);
         }
         if(_loc2_ && _loc2_.length > 0)
         {
            return true;
         }
         return false;
      }
      
      private function init() : void
      {
      }
      
      public function showSpeechPanel() : void
      {
         this.navPanel.selectedChild = this.speechVS;
      }
      
      public function show(param1:Object = null) : void
      {
         this.redraw();
         this.refresh(param1);
      }
      
      public function hide() : void
      {
         this.target = null;
      }
      
      public function refresh(param1:Object = null) : void
      {
         var _loc2_:AssetViewCollection = null;
         var _loc3_:IAsset = null;
         var _loc4_:Object = null;
         if(param1)
         {
            this.target = param1;
         }
         else
         {
            _loc2_ = Console.getConsole().mainStage.sceneEditor.controller.selection;
            if((_loc4_ = _loc2_.selectedAsset) is IAssetView)
            {
               _loc3_ = IAssetView(_loc4_).asset;
            }
            if(this._target != _loc3_)
            {
               this.target = _loc2_.selectedAsset;
            }
         }
      }
      
      private function redraw() : void
      {
         var _loc1_:Number = 1;
         this._bg.graphics.clear();
         this._bg.graphics.lineStyle(_loc1_,6052956);
         this._bg.graphics.beginFill(FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".sidePanel").getStyle("bg"));
         this._bg.graphics.drawRoundRectComplex(0,0,this.width,this.height,0,15,0,15);
         this._bg.graphics.endFill();
         this._close.graphics.clear();
         this._close.graphics.lineStyle(0,0);
         this._close.graphics.beginFill(15000804);
         UtilDraw.drawPoly(this._close,4,0,3,10,180);
         this._close.graphics.endFill();
         this._close.buttonMode = true;
         this._close.scaleY = 1.5;
      }
      
      private function updateSpeechPanel() : void
      {
         var _loc3_:Asset = null;
         var _loc4_:Character = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:AnimeSound = null;
         if(!UtilUser.loggedIn)
         {
            this.speechVS.selectedChild = this.speechStop;
            this._txtWarning.htmlText = "<font size=\'16\'>" + UtilDict.toDisplay("go","Please") + " <a href=\'event:signup\'><font color=\'#ff7800\'><b>" + UtilDict.toDisplay("go","Sign Up") + " " + UtilDict.toDisplay("go","or") + " " + UtilDict.toDisplay("go","Login") + "</b></font></a> " + UtilDict.toDisplay("go","to enable the Text-to-Speech function") + "</font>";
            return;
         }
         var _loc1_:String = SpeechComponent.getAssetSpeechId();
         var _loc2_:String = SpeechComponent.getSceneSpeechId();
         if(this._target is Character)
         {
            _loc3_ = Console.getConsole().currentScene.selectedAsset;
            if(_loc3_ is Character)
            {
               _loc4_ = _loc3_ as Character;
               if(_loc1_ == "" && _loc2_ == "")
               {
                  this.speechVS.selectedChild = this.speechPanel;
               }
               else if(_loc1_ != "")
               {
                  _loc7_ = (_loc6_ = (_loc5_ = this.getAssetIdBySpeechId(_loc1_)).split(AssetLinkage.LINK))[0];
                  _loc8_ = _loc6_[1];
                  if(_loc4_.scene.id == _loc7_ && _loc4_.id == _loc8_)
                  {
                     this.speechVS.selectedChild = this.speechPanel;
                     if((_loc9_ = Console.getConsole().speechManager.getValueByKey(_loc1_) as AnimeSound).soundThumb.ttsData.type == "mic")
                     {
                     }
                  }
                  else
                  {
                     this.speechVS.selectedChild = this.speechBlocked;
                  }
               }
               else if(_loc2_ != "")
               {
                  this.speechVS.selectedChild = this.speechBlocked;
               }
            }
         }
         else if(this._target is AnimeScene)
         {
            if(_loc1_ == "" && _loc2_ == "")
            {
               this.speechVS.selectedChild = this.speechPanel;
            }
            else if(_loc1_ != "")
            {
               this.speechVS.selectedChild = this.speechBlocked;
            }
            else if(_loc2_ != "")
            {
               this.speechVS.selectedChild = this.speechPanel;
            }
            else
            {
               this.speechVS.selectedChild = this.speechBlocked;
            }
         }
         this.speechComponent.init();
      }
      
      private function getAssetIdBySpeechId(param1:String) : String
      {
         var _loc4_:Array = null;
         var _loc2_:String = "";
         var _loc3_:Array = Console.getConsole().linkageController.isLinkageExist(param1);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.concat();
            _loc4_.splice(_loc4_.indexOf(param1),1);
            _loc2_ = _loc4_.join("");
         }
         return _loc2_;
      }
      
      private function onNavChange() : void
      {
         if(this.navPanel.selectedChild == this.speechVS)
         {
            this.updateSpeechPanel();
            Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.VOICE_TAB_SELECTED,this));
         }
         else if(this.navPanel.selectedChild == this.colorPanel)
         {
            this.colorPanel.target = this._view;
         }
         else if(this.navPanel.selectedChild == this.actionPanel)
         {
            this.actionPanel.target = this._view;
            Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.ACTION_TAB_SELECTED,this));
         }
         else if(this.navPanel.selectedChild == this.cameraSettingPanel)
         {
            if(Console.getConsole().currentScene.sizingAsset)
            {
               this.cameraSettingPanel.target = Console.getConsole().currentScene.sizingAsset;
            }
         }
         if(this._target is Character)
         {
            this._lastSelectedIndex_char = this.navPanel.selectedIndex;
         }
         else if(this._target is BubbleAsset)
         {
            this._lastSelectedIndex_bubble = this.navPanel.selectedIndex;
         }
         this._lastSelectedIndex_all = this.navPanel.selectedIndex;
      }
      
      private function set actionPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(1).visible = this.navPanel.getTabAt(1).includeInLayout = param1;
      }
      
      private function set colorPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(3).visible = this.navPanel.getTabAt(3).includeInLayout = param1;
      }
      
      private function set speechPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(2).visible = this.navPanel.getTabAt(2).includeInLayout = param1;
      }
      
      private function set statePanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(4).visible = this.navPanel.getTabAt(4).includeInLayout = param1;
      }
      
      private function set bubblePanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(5).visible = this.navPanel.getTabAt(5).includeInLayout = param1;
      }
      
      private function set effectPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(6).visible = this.navPanel.getTabAt(6).includeInLayout = param1;
      }
      
      private function set advPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(7).visible = this.navPanel.getTabAt(7).includeInLayout = param1;
      }
      
      private function set sceneOptionVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(0).visible = this.navPanel.getTabAt(0).includeInLayout = param1;
      }
      
      private function set assetTransitionPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(8).visible = this.navPanel.getTabAt(8).includeInLayout = param1;
      }
      
      private function set cameraSettingPanelVisible(param1:Boolean) : void
      {
         this.navPanel.visible = true;
         this.navPanel.getTabAt(9).width = 76;
         this.navPanel.getTabAt(9).visible = this.navPanel.getTabAt(9).includeInLayout = param1;
      }
      
      private function addScene() : void
      {
         Console.getConsole().mainStage.sceneEditor.controller.preselectAssetId = Console.getConsole().currentScene.selectedAsset.id;
         Console.getConsole().addNextScene();
      }
      
      private function onDeleteHandler() : void
      {
         this.speechComponent.onClickDelete();
         this.updateSpeechPanel();
      }
      
      public function linkHandler(param1:TextEvent) : void
      {
         switch(param1.text)
         {
            case "signup":
               this.showSignup();
               break;
            case "login":
               this.showLogin();
         }
      }
      
      public function showSignup() : void
      {
         Console.getConsole().showSignup();
      }
      
      public function showLogin() : void
      {
         Console.getConsole().showLogin();
      }
      
      public function setLoadingStatus(param1:Boolean) : void
      {
         this._maskCanvas.visible = param1;
      }
      
      private function _PropertiesWindow_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = new Sequence();
         _loc1_.children = [this._PropertiesWindow_Blur1_c(),this._PropertiesWindow_Blur2_c()];
         this.blurEffect = _loc1_;
         BindingManager.executeBindings(this,"blurEffect",this.blurEffect);
         return _loc1_;
      }
      
      private function _PropertiesWindow_Blur1_c() : Blur
      {
         var _loc1_:Blur = new Blur();
         _loc1_.duration = 200;
         _loc1_.blurXFrom = 1;
         _loc1_.blurXTo = 20;
         return _loc1_;
      }
      
      private function _PropertiesWindow_Blur2_c() : Blur
      {
         var _loc1_:Blur = new Blur();
         _loc1_.duration = 200;
         _loc1_.blurXFrom = 20;
         _loc1_.blurXTo = 1;
         return _loc1_;
      }
      
      public function ___PropertiesWindow_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.redraw();
      }
      
      public function ___PropertiesWindow_Canvas1_initialize(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function __navPanel_change(param1:IndexChangedEvent) : void
      {
         this.onNavChange();
      }
      
      public function ___PropertiesWindow_Button1_click(param1:MouseEvent) : void
      {
         this.addScene();
      }
      
      public function ___PropertiesWindow_TextButton1_click(param1:MouseEvent) : void
      {
         this.onDeleteHandler();
      }
      
      public function ___txtWarning_link(param1:TextEvent) : void
      {
         this.linkHandler(param1);
      }
      
      private function _PropertiesWindow_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Object
         {
            return _target;
         },null,"buttonBar.target");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Options");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"sceneOptionPanel.label");
         result[2] = new Binding(this,function():Object
         {
            return _target;
         },null,"sceneOptionPanel.target");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Actions");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"actionPanel.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Voice");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"speechVS.label");
         result[5] = new Binding(this,function():Object
         {
            return _target;
         },null,"speechComponent.target");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","This scene already has either narration or a character talking");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PropertiesWindow_Text1.text");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add Scene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PropertiesWindow_Button1.label");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Overwrite the speech that already exists in this scene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PropertiesWindow_TextButton1.label");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Colors");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"colorPanel.label");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","States");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"statePanel.label");
         result[11] = new Binding(this,function():Object
         {
            return _target;
         },null,"statePanel.target");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Style");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"bubblePanel.label");
         result[13] = new Binding(this,function():Object
         {
            return _target;
         },null,"bubblePanel.target");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Effect");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"effectPanel.label");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_editassetsubtitle");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"subtitle.text");
         result[16] = new Binding(this,function():Object
         {
            return _target;
         },null,"_PropertiesWindow_AssetTiming1.target");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Advanced");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PropertiesWindow_VBox6.label");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Control when your speech bubble appears");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PropertiesWindow_Text4.text");
         result[19] = new Binding(this,function():Object
         {
            return _target;
         },null,"_PropertiesWindow_AssetTiming2.target");
         result[20] = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldBubbleUrlBeEditable;
         },null,"_PropertiesWindow_HRule1.visible");
         result[21] = new Binding(this,function():Object
         {
            return _target;
         },null,"_PropertiesWindow_AssetHyperLink1.target");
         result[22] = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldBubbleUrlBeEditable;
         },null,"_PropertiesWindow_AssetHyperLink1.visible");
         result[23] = new Binding(this,function():Boolean
         {
            return UtilUser.hasAdminFeatures;
         },null,"_PropertiesWindow_HRule2.visible");
         result[24] = new Binding(this,function():Object
         {
            return _target;
         },null,"_PropertiesWindow_AssetEffectControl1.target");
         result[25] = new Binding(this,function():Boolean
         {
            return UtilUser.hasAdminFeatures;
         },null,"_PropertiesWindow_AssetEffectControl1.visible");
         result[26] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Enter/Exit");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"assetTransitionPanel.label");
         result[27] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Composition");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"cameraSettingPanel.label");
         result[28] = new Binding(this,function():Object
         {
            return this;
         },null,"blurEffect.target");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : VBox
      {
         return this._94436_bg;
      }
      
      public function set _bg(param1:VBox) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _close() : Canvas
      {
         return this._1480441607_close;
      }
      
      public function set _close(param1:Canvas) : void
      {
         var _loc2_:Object = this._1480441607_close;
         if(_loc2_ !== param1)
         {
            this._1480441607_close = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_close",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvas() : Canvas
      {
         return this._1336746749_maskCanvas;
      }
      
      public function set _maskCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1336746749_maskCanvas;
         if(_loc2_ !== param1)
         {
            this._1336746749_maskCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtWarning() : Text
      {
         return this._713047211_txtWarning;
      }
      
      public function set _txtWarning(param1:Text) : void
      {
         var _loc2_:Object = this._713047211_txtWarning;
         if(_loc2_ !== param1)
         {
            this._713047211_txtWarning = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtWarning",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get actionPanel() : CharacterActionPanel
      {
         return this._1569328494actionPanel;
      }
      
      public function set actionPanel(param1:CharacterActionPanel) : void
      {
         var _loc2_:Object = this._1569328494actionPanel;
         if(_loc2_ !== param1)
         {
            this._1569328494actionPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actionPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get assetTransitionPanel() : AssetTransitionPanel
      {
         return this._862566241assetTransitionPanel;
      }
      
      public function set assetTransitionPanel(param1:AssetTransitionPanel) : void
      {
         var _loc2_:Object = this._862566241assetTransitionPanel;
         if(_loc2_ !== param1)
         {
            this._862566241assetTransitionPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"assetTransitionPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get blurEffect() : Sequence
      {
         return this._1795707688blurEffect;
      }
      
      public function set blurEffect(param1:Sequence) : void
      {
         var _loc2_:Object = this._1795707688blurEffect;
         if(_loc2_ !== param1)
         {
            this._1795707688blurEffect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blurEffect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bubblePanel() : FontChooser
      {
         return this._764566744bubblePanel;
      }
      
      public function set bubblePanel(param1:FontChooser) : void
      {
         var _loc2_:Object = this._764566744bubblePanel;
         if(_loc2_ !== param1)
         {
            this._764566744bubblePanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bubblePanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buttonBar() : AssetButtonBar
      {
         return this._11548545buttonBar;
      }
      
      public function set buttonBar(param1:AssetButtonBar) : void
      {
         var _loc2_:Object = this._11548545buttonBar;
         if(_loc2_ !== param1)
         {
            this._11548545buttonBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buttonBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cameraSettingPanel() : CameraSettingPanel
      {
         return this._798688601cameraSettingPanel;
      }
      
      public function set cameraSettingPanel(param1:CameraSettingPanel) : void
      {
         var _loc2_:Object = this._798688601cameraSettingPanel;
         if(_loc2_ !== param1)
         {
            this._798688601cameraSettingPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cameraSettingPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get colorPanel() : AssetViewColorPanel
      {
         return this._1275269217colorPanel;
      }
      
      public function set colorPanel(param1:AssetViewColorPanel) : void
      {
         var _loc2_:Object = this._1275269217colorPanel;
         if(_loc2_ !== param1)
         {
            this._1275269217colorPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colorPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get effectPanel() : VBox
      {
         return this._1646834419effectPanel;
      }
      
      public function set effectPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1646834419effectPanel;
         if(_loc2_ !== param1)
         {
            this._1646834419effectPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effectPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get navPanel() : TabNavigator
      {
         return this._2079239841navPanel;
      }
      
      public function set navPanel(param1:TabNavigator) : void
      {
         var _loc2_:Object = this._2079239841navPanel;
         if(_loc2_ !== param1)
         {
            this._2079239841navPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"navPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sceneOptionPanel() : SceneOption
      {
         return this._57971299sceneOptionPanel;
      }
      
      public function set sceneOptionPanel(param1:SceneOption) : void
      {
         var _loc2_:Object = this._57971299sceneOptionPanel;
         if(_loc2_ !== param1)
         {
            this._57971299sceneOptionPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneOptionPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechBlocked() : VBox
      {
         return this._1918169430speechBlocked;
      }
      
      public function set speechBlocked(param1:VBox) : void
      {
         var _loc2_:Object = this._1918169430speechBlocked;
         if(_loc2_ !== param1)
         {
            this._1918169430speechBlocked = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechBlocked",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechComponent() : SpeechComponent
      {
         return this._1202262587speechComponent;
      }
      
      public function set speechComponent(param1:SpeechComponent) : void
      {
         var _loc2_:Object = this._1202262587speechComponent;
         if(_loc2_ !== param1)
         {
            this._1202262587speechComponent = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechComponent",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechPanel() : VBox
      {
         return this._1758088770speechPanel;
      }
      
      public function set speechPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1758088770speechPanel;
         if(_loc2_ !== param1)
         {
            this._1758088770speechPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechStop() : VBox
      {
         return this._611009540speechStop;
      }
      
      public function set speechStop(param1:VBox) : void
      {
         var _loc2_:Object = this._611009540speechStop;
         if(_loc2_ !== param1)
         {
            this._611009540speechStop = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechStop",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechVS() : ViewStack
      {
         return this._2131205345speechVS;
      }
      
      public function set speechVS(param1:ViewStack) : void
      {
         var _loc2_:Object = this._2131205345speechVS;
         if(_loc2_ !== param1)
         {
            this._2131205345speechVS = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechVS",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get statePanel() : PropStatePanel
      {
         return this._241989645statePanel;
      }
      
      public function set statePanel(param1:PropStatePanel) : void
      {
         var _loc2_:Object = this._241989645statePanel;
         if(_loc2_ !== param1)
         {
            this._241989645statePanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statePanel",_loc2_,param1));
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
      public function get thumbnail() : PropertyThumbnail
      {
         return this._1330532588thumbnail;
      }
      
      public function set thumbnail(param1:PropertyThumbnail) : void
      {
         var _loc2_:Object = this._1330532588thumbnail;
         if(_loc2_ !== param1)
         {
            this._1330532588thumbnail = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"thumbnail",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _target() : Object
      {
         return this._1827565232_target;
      }
      
      private function set _target(param1:Object) : void
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
