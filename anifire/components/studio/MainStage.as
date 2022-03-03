package anifire.components.studio
{
   import anifire.assets.control.AssetResizeToolTip;
   import anifire.assets.controller.AssetCollectionController;
   import anifire.assets.controller.AssetControllerFactory;
   import anifire.assets.view.AssetViewCollection;
   import anifire.component.GoAlert;
   import anifire.component.MiniMap;
   import anifire.component.MiniMapEvent;
   import anifire.component.ZoomSliderThumb;
   import anifire.constant.AnimeConstants;
   import anifire.containers.GradientCanvas;
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Background;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.SelectionTool;
   import anifire.display.ZoomContainer;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetView;
   import anifire.managers.StudioStatusManager;
   import anifire.scene.view.AssetSelectionTool;
   import anifire.scene.view.SceneEditor;
   import anifire.scene.view.SceneThumbnailManager;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.HSlider;
   import mx.controls.Label;
   import mx.controls.Menu;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.ToolTip;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.Pause;
   import mx.effects.Sequence;
   import mx.events.FlexEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.events.SliderEvent;
   import mx.formatters.NumberFormatter;
   import mx.managers.PopUpManager;
   import mx.managers.ToolTipManager;
   import mx.states.AddChild;
   import mx.states.RemoveChild;
   import mx.states.SetProperty;
   import mx.states.State;
   
   use namespace mx_internal;
   
   public class MainStage extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _MainStage_AddChild1:AddChild;
      
      public var _MainStage_AddChild2:AddChild;
      
      public var _MainStage_AddChild3:AddChild;
      
      public var _MainStage_AddChild4:AddChild;
      
      public var _MainStage_Button1:Button;
      
      public var _MainStage_Button3:Button;
      
      public var _MainStage_Canvas6:Canvas;
      
      public var _MainStage_Label2:Label;
      
      public var _MainStage_Label3:Label;
      
      public var _MainStage_Label4:Label;
      
      public var _MainStage_RemoveChild1:RemoveChild;
      
      public var _MainStage_RemoveChild2:RemoveChild;
      
      public var _MainStage_SetProperty1:SetProperty;
      
      public var _MainStage_SetProperty2:SetProperty;
      
      public var _MainStage_Text1:Text;
      
      private var _2002216470_addSceneEffectLayer:Canvas;
      
      private var _51913824_bottomControlBar:HBox;
      
      private var _89648856_btnAddScene:Button;
      
      private var _1960351742_btnDelScene:Button;
      
      private var _1034752274_btnSceneMenu:Button;
      
      private var _382268659_btnSceneSet:Button;
      
      private var _766696848_cameraBorder:UIComponent;
      
      private var _550419411_controlLayer:Canvas;
      
      private var _1566867516_dpMovieMenu:XMLList;
      
      private var _246888748_efAutoSave:Sequence;
      
      private var _2046797976_lookInToolBar:HBox;
      
      private var _607259319_maskCanvasScene:Canvas;
      
      private var _240112165_maskCanvasSceneButton:Canvas;
      
      private var _1575126697_microMap:MiniMap;
      
      private var _872235962_miniMap:MiniMap;
      
      private var _347427628_stageArea:Canvas;
      
      private var _1570224285_txtAutoSave:Label;
      
      private var _766521513_uiCanvasAutoSave:Canvas;
      
      private var _599927733_zoomControl:HBox;
      
      private var _435778611_zoomSlider:HSlider;
      
      private var _533588863assetResizeToolTip:AssetResizeToolTip;
      
      private var _11548545buttonBar:AssetButtonBar;
      
      private var _1282133823fadeIn:Fade;
      
      private var _904480549fadeInMap:Fade;
      
      private var _1091436750fadeOut:Fade;
      
      private var _2089711414fadeOutMap:Fade;
      
      private var _355954324panDropShadow:DropShadowFilter;
      
      private var _106440182pause:Pause;
      
      private var _1931449851percentFormatter:NumberFormatter;
      
      private var _685077223sceneEditor:SceneEditor;
      
      private var _1140124837toolBar:GoToolBar;
      
      private var _237378066zoomContainer:ZoomContainer;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _sceneIndexStr:String;
      
      private var _loggedIn:Boolean = true;
      
      private var _selectionTool:SelectionTool;
      
      private var _targetUploadType_in_importer:String;
      
      private var _isCameraMode:Boolean = false;
      
      private const MINI_MAP_FACTOR:Number = 0.2;
      
      private var myToolTip:ToolTip;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function MainStage()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "resize":"___MainStage_Canvas1_resize",
               "creationComplete":"___MainStage_Canvas1_creationComplete"
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":GradientCanvas,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "styleName":"mainStage"
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
                     return {
                        "percentHeight":100,
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":GoToolBar,
                           "id":"toolBar"
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_stageArea",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentHeight":100,
                                 "percentWidth":100,
                                 "verticalScrollPolicy":"off",
                                 "horizontalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":ZoomContainer,
                                    "id":"zoomContainer",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":SceneEditor,
                                    "id":"sceneEditor"
                                 }),new UIComponentDescriptor({
                                    "type":UIComponent,
                                    "id":"_cameraBorder",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "mouseChildren":false,
                                          "mouseEnabled":false,
                                          "percentWidth":100,
                                          "percentHeight":100
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":AssetResizeToolTip,
                                    "id":"assetResizeToolTip",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"visible":false};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":AssetButtonBar,
                                    "id":"buttonBar",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "scaleX":0.8,
                                          "scaleY":0.8,
                                          "isFullVersion":false,
                                          "styleName":"controlButtonBar",
                                          "visible":false
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_uiCanvasAutoSave",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalCenter":0,
                                          "top":2,
                                          "alpha":0,
                                          "styleName":"popupMessage",
                                          "mouseChildren":false,
                                          "mouseEnabled":false,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_txtAutoSave",
                                             "stylesFactory":function():void
                                             {
                                                this.fontWeight = "bold";
                                                this.color = 2631720;
                                                this.textAlign = "center";
                                                this.fontSize = 16;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "horizontalCenter":0,
                                                   "verticalCenter":0
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_controlLayer",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentHeight":100,
                                          "percentWidth":100,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_addSceneEffectLayer",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off",
                                          "mouseChildren":false,
                                          "mouseEnabled":false
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_MainStage_Canvas6",
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundColor = 16777215;
                                       this.backgroundAlpha = 0.5;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "visible":false,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MainStage_Text1"
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_bottomControlBar",
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "styleName":"bottomControlBar",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_lookInToolBar",
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundColor = 3355443;
                                       this.borderColor = 3355443;
                                       this.borderStyle = "solid";
                                       this.cornerRadius = 5;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "visible":false,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_MainStage_Button1",
                                             "events":{"click":"___MainStage_Button1_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"btnZoomOut",
                                                   "focusEnabled":false,
                                                   "buttonMode":true
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalGap = 0;
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnSceneSet",
                                          "events":{
                                             "click":"___btnSceneSet_click",
                                             "mouseOver":"___btnSceneSet_mouseOver",
                                             "mouseOut":"___btnSceneSet_mouseOut"
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnSceneSetting",
                                                "buttonMode":true
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Spacer,
                                          "propertiesFactory":function():Object
                                          {
                                             return {"width":10};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_MainStage_Button3",
                                          "events":{"click":"___MainStage_Button3_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnAddScene",
                                                "buttonMode":true
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnSceneMenu",
                                          "events":{"click":"___btnSceneMenu_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnAddSceneArrow",
                                                "buttonMode":true
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
               }),new UIComponentDescriptor({
                  "type":VBox,
                  "events":{
                     "rollOver":"___MainStage_VBox2_rollOver",
                     "rollOut":"___MainStage_VBox2_rollOut",
                     "mouseUp":"___MainStage_VBox2_mouseUp"
                  },
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "left":0,
                        "bottom":0,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":MiniMap,
                           "id":"_miniMap",
                           "events":{"viewChanged":"___miniMap_viewChanged"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "visible":false,
                                 "includeInLayout":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_zoomControl",
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"topControlBar",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":MiniMap,
                                    "id":"_microMap",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "factor":0.04,
                                          "mouseChildren":false,
                                          "mouseEnabled":false
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HSlider,
                                    "id":"_zoomSlider",
                                    "events":{"change":"___zoomSlider_change"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "minimum":0.5,
                                          "maximum":4,
                                          "snapInterval":0.05,
                                          "value":1,
                                          "liveDragging":true,
                                          "sliderThumbClass":ZoomSliderThumb,
                                          "buttonMode":true,
                                          "dataTipFormatFunction":zoomSliderDataTip,
                                          "styleName":"zoomSlider"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MainStage_Label2",
                                    "stylesFactory":function():void
                                    {
                                       this.paddingTop = 10;
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_maskCanvasSceneButton",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 16777215;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "right":0,
                        "bottom":0,
                        "width":200,
                        "height":200,
                        "alpha":0,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_maskCanvasScene",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 16777215;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "alpha":0,
                        "visible":false
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
         var bindings:Array = this._MainStage_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_MainStageWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return MainStage[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.styleName = "mainStage";
         this.states = [this._MainStage_State1_c(),this._MainStage_State2_c(),this._MainStage_State3_c(),this._MainStage_State4_c()];
         this._MainStage_XMLList1_i();
         this._MainStage_Sequence1_i();
         this._MainStage_Fade3_i();
         this._MainStage_Fade4_i();
         this._MainStage_DropShadowFilter1_i();
         this._MainStage_NumberFormatter1_i();
         this.addEventListener("resize",this.___MainStage_Canvas1_resize);
         this.addEventListener("creationComplete",this.___MainStage_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         MainStage._watcherSetupUtil = param1;
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
      
      [Bindable(event="propertyChange")]
      public function get loggedIn() : Boolean
      {
         return this._loggedIn;
      }
      
      private function set _2020648519loggedIn(param1:Boolean) : void
      {
         this._loggedIn = param1;
      }
      
      private function init() : void
      {
         this._selectionTool = new SelectionTool(this._stageArea);
         this.onResize();
         this._microMap.map = this.sceneEditor;
         this._miniMap.map = this.sceneEditor;
         this.zoomContainer.dsp = this.sceneEditor;
         this.zoomContainer.addEventListener(Event.CHANGE,this.onZoomChange);
         var _loc1_:SceneThumbnailManager = new SceneThumbnailManager(this.sceneEditor.view);
      }
      
      public function updateMicroMap() : void
      {
         this._microMap.show();
      }
      
      private function onZoomChange(param1:Event) : void
      {
         this.sceneEditor.controller.hideControl();
         this._microMap.viewRect = this.zoomContainer.viewRect;
         this._miniMap.viewRect = this.zoomContainer.viewRect;
         this.sceneEditor.selectionTool.borderWidth = AssetSelectionTool.BORDER_WIDTH / this.zoomContainer.zoomFactor;
         this.sceneEditor.controlBox.drawingScale = 1 / this.zoomContainer.zoomFactor;
         this.sceneEditor.controller.alignTool.scaleFactor = 1 / this.zoomContainer.zoomFactor;
      }
      
      public function get isCameraMode() : Boolean
      {
         return this._isCameraMode;
      }
      
      public function get selectionTool() : SelectionTool
      {
         return this._selectionTool;
      }
      
      public function get currentScene() : AnimeScene
      {
         if(Console.getConsole())
         {
            return Console.getConsole().currentScene;
         }
         return null;
      }
      
      private function set _1575404715sceneIndexStr(param1:String) : void
      {
         this._sceneIndexStr = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get sceneIndexStr() : String
      {
         if(this._sceneIndexStr == null)
         {
            this._sceneIndexStr = "";
         }
         return this._sceneIndexStr;
      }
      
      public function setLoadingStatus(param1:Boolean, param2:Boolean) : void
      {
         if(param2)
         {
            this._maskCanvasScene.visible = param1;
         }
         else
         {
            this._maskCanvasSceneButton.visible = param1;
         }
      }
      
      public function showAutoSaveHints() : void
      {
         if(UtilUser.loggedIn)
         {
            this._txtAutoSave.text = UtilDict.toDisplay("go","mainstage_autosavedone");
         }
         else
         {
            this.pause.duration = 5000;
            this._txtAutoSave.text = UtilDict.toDisplay("go","mainstage_remind_to_save");
         }
         this._efAutoSave.play();
      }
      
      public function get updatable() : Boolean
      {
         return this._bottomControlBar.enabled;
      }
      
      public function set updatable(param1:Boolean) : void
      {
         this._bottomControlBar.enabled = this._bottomControlBar.mouseChildren = this._bottomControlBar.mouseEnabled = param1;
      }
      
      private function onLinkClick(param1:String) : void
      {
         var _loc2_:GoAlert = null;
         if(Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            _loc2_ = GoAlert(PopUpManager.createPopUp(this,GoAlert,true));
            _loc2_._lblConfirm.text = "";
            _loc2_._txtDelete.text = "To import your own graphics, please use goanimate.com";
            _loc2_._btnDelete.visible = false;
            _loc2_._btnCancel.label = "OK";
            _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
            _loc2_.y = 100;
            return;
         }
         this._targetUploadType_in_importer = param1;
         Console.getConsole().thumbTray.showUserGoodies(param1);
         this.doShowImporterWindow();
      }
      
      private function doShowImporterWindow() : void
      {
         if(Console.getConsole().thumbTray.assetTheme != ThumbTray.USER_THEME)
         {
            Console.getConsole().thumbTray.assetTheme = ThumbTray.USER_THEME;
         }
         var _loc1_:String = Console.getConsole().thumbTray.uploadType;
         Console.getConsole().showImporterWindow(this._targetUploadType_in_importer);
      }
      
      private function drawCameraBorder(param1:Number) : void
      {
         this._cameraBorder.graphics.clear();
         this._cameraBorder.graphics.lineStyle(5);
         var _loc2_:Rectangle = new Rectangle(0,0,this._stageArea.width,this._stageArea.height);
         if(_loc2_.height / _loc2_.width > param1)
         {
            _loc2_.height = param1 * _loc2_.width;
            _loc2_.y = (this._stageArea.height - _loc2_.height) / 2;
         }
         else
         {
            _loc2_.width = _loc2_.height / param1;
            _loc2_.x = (this._stageArea.width - _loc2_.width) / 2;
         }
         UtilDraw.drawDashRect(this._cameraBorder,_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height,6,8);
      }
      
      private function onResize(param1:Event = null) : void
      {
         this.validateNow();
         var _loc2_:Number = this.width;
         var _loc3_:Number = this.height - this._bottomControlBar.height - this.toolBar.height;
         this._stageArea.width = _loc2_;
         this._stageArea.height = _loc3_;
         this._microMap.viewRect = this.zoomContainer.viewRect;
         this._microMap.show();
         this.hideCameraView();
      }
      
      private function onStageAreaMouseUp(param1:MouseEvent) : void
      {
      }
      
      public function updateButtonBar() : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:IAsset = null;
         var _loc4_:IAssetView = null;
         var _loc5_:AssetCollectionController = null;
         if(this.currentScene == null || Console.getConsole().isTutorialOn)
         {
            return;
         }
         var _loc1_:AssetViewCollection = this.sceneEditor.controller.selection;
         if(_loc1_.length == 1)
         {
            if(_loc4_ = _loc1_.selectedAsset)
            {
               _loc3_ = _loc4_.asset;
               if(_loc3_ && _loc3_ is EffectAsset && Console.getConsole().metaData.mver > 3)
               {
                  return;
               }
               this.buttonBar.target = _loc3_;
            }
         }
         else if(_loc1_.length > 1)
         {
            (_loc5_ = AssetControllerFactory.getCollectionController(_loc1_)).collection = _loc1_;
            this.buttonBar.target = _loc5_;
         }
      }
      
      public function showButtonBar() : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:IAsset = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(this.currentScene == null || Console.getConsole().isTutorialOn)
         {
            return;
         }
         var _loc1_:AssetViewCollection = this.sceneEditor.controller.selection;
         _loc2_ = _loc1_.getBounds(this._stageArea);
         if(_loc1_.length == 1)
         {
            _loc3_ = _loc1_.selectedAsset.asset;
            if(_loc3_ && _loc3_ is EffectAsset && Console.getConsole().metaData.mver > 3)
            {
               return;
            }
         }
         if(_loc2_)
         {
            if(!(_loc3_ && _loc3_ is Background) && !(_loc3_ && _loc3_ is EffectAsset && EffectAsset(_loc3_).isCamera))
            {
               _loc2_.inflate(30,30);
            }
            if(_loc3_ && _loc3_ is EffectAsset && EffectAsset(_loc3_).isCamera)
            {
               _loc2_ = this.sceneEditor.controlBox.getBounds(this._stageArea);
            }
            _loc5_ = this.buttonBar.height;
            _loc6_ = this.buttonBar.width;
            _loc7_ = _loc2_.x;
            if((_loc8_ = _loc2_.y - _loc5_) < 0)
            {
               _loc8_ = 0;
               if(_loc7_ + _loc2_.width + _loc6_ > this._stageArea.width)
               {
                  _loc7_ -= _loc6_;
               }
               else
               {
                  _loc7_ += _loc2_.width;
               }
            }
            if(_loc7_ < 0)
            {
               _loc7_ = 0;
            }
            else if(_loc7_ + _loc6_ > this._stageArea.width)
            {
               _loc7_ = this._stageArea.width - _loc6_;
            }
            this.buttonBar.x = _loc7_;
            this.buttonBar.y = _loc8_;
            this.buttonBar.visible = true;
         }
      }
      
      public function hideButtonBar() : void
      {
         this.buttonBar.visible = false;
      }
      
      private function onZoomSliderChange(param1:SliderEvent) : void
      {
         this.zoomContainer.zoom(HSlider(param1.currentTarget).value);
      }
      
      private function zoomSliderDataTip(param1:Number) : String
      {
         return this.percentFormatter.format(100 * param1) + " %";
      }
      
      private function get sceneCenter() : Point
      {
         return new Point(AnimeConstants.STAGE_WIDTH / 2 + AnimeConstants.STAGE_PADDING,AnimeConstants.STAGE_HEIGHT / 2 + AnimeConstants.STAGE_PADDING);
      }
      
      public function showCameraView() : void
      {
         var _loc1_:Asset = null;
         var _loc2_:Rectangle = null;
         var _loc3_:Number = NaN;
         if(!this._isCameraMode && this.currentScene)
         {
            _loc1_ = this.currentScene.sizingAsset;
            if(_loc1_)
            {
               this.currentScene.hideEffects(true,true);
               this.sceneEditor.view.hideAllEffect();
               _loc2_ = new Rectangle(_loc1_.x + AnimeConstants.STAGE_PADDING,_loc1_.y + AnimeConstants.STAGE_PADDING,_loc1_.width,_loc1_.height);
               _loc3_ = Math.min(this._stageArea.width / _loc2_.width,this._stageArea.height / _loc2_.height);
               this.zoomContainer.zoomTo(_loc3_,_loc2_.x + _loc2_.width / 2,_loc2_.y + _loc2_.height / 2);
               this._lookInToolBar.visible = true;
               this._zoomControl.includeInLayout = this._zoomControl.visible = false;
               this.drawCameraBorder(_loc2_.height / _loc2_.width);
               this.hideMiniMap();
               this._isCameraMode = true;
            }
         }
      }
      
      public function hideCameraView() : void
      {
         if(this._isCameraMode)
         {
            if(this.currentScene)
            {
               this.currentScene.showEffects(true);
            }
            this.sceneEditor.view.showAllEffect();
            this.zoomContainer.zoomTo(1,this.sceneCenter.x,this.sceneCenter.y);
            this._zoomSlider.value = 1;
            this._lookInToolBar.visible = false;
            if(this.currentState != "cn" && this.currentState != "domo")
            {
               this._zoomControl.includeInLayout = this._zoomControl.visible = true;
            }
            this._cameraBorder.graphics.clear();
            this._isCameraMode = false;
         }
      }
      
      private function onMovieMenuItemClick(param1:MenuEvent) : void
      {
         if(param1.index == 0)
         {
            Console.getConsole().addNextScene();
         }
         else if(param1.index == 1)
         {
            Console.getConsole().addNextScene(true);
         }
      }
      
      private function onAddSceneBtnClick() : void
      {
         Console.getConsole().addNextScene();
      }
      
      private function onSceneSettingBtnClick() : void
      {
         Console.getConsole().currentScene.selectedAsset = null;
         Console.getConsole().showOverTray(true,Console.getConsole().currentScene);
      }
      
      public function changeToMessageMode() : void
      {
         this.currentState = "emessage";
      }
      
      private function showMiniMap(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this._microMap.viewRect = this.zoomContainer.viewRect;
            this._miniMap.viewRect = this.zoomContainer.viewRect;
            this._microMap.show();
            this._miniMap.show();
            this._miniMap.visible = this._miniMap.includeInLayout = true;
            this._miniMap.scaleX = this._miniMap.scaleY = 1;
         }
      }
      
      private function hideMiniMap() : void
      {
         this._miniMap.visible = this._miniMap.includeInLayout = false;
         this._miniMap.scaleX = this._miniMap.scaleY = 0.1;
      }
      
      private function onMiniMapViewChange(param1:MiniMapEvent) : void
      {
         this.zoomContainer.panTo(param1.viewPoint.x,param1.viewPoint.y);
      }
      
      private function showSceneMenu(param1:MouseEvent) : void
      {
         var _loc2_:Menu = Menu.createMenu(this,this._dpMovieMenu,false);
         _loc2_.labelField = "@label";
         _loc2_.buttonMode = true;
         _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.onMovieMenuItemClick);
         _loc2_.show(param1.stageX - 130,param1.stageY + 12);
      }
      
      private function showToolTipAbove(param1:MouseEvent, param2:String) : void
      {
         var _loc3_:Point = new Point(param1.currentTarget.x,param1.currentTarget.y);
         _loc3_ = param1.currentTarget.parent.contentToGlobal(_loc3_);
         this.myToolTip = ToolTipManager.createToolTip(param2,_loc3_.x,_loc3_.y,"errorTipAbove") as ToolTip;
         this.myToolTip.maxWidth = 175;
         this.myToolTip.styleName = "errorTip";
         this.myToolTip.height = 75;
         var _loc4_:int = this.myToolTip.height + 5;
         this.myToolTip.y -= _loc4_;
      }
      
      private function killToolTip() : void
      {
         ToolTipManager.destroyToolTip(this.myToolTip);
      }
      
      private function _MainStage_XMLList1_i() : XMLList
      {
         var _loc1_:XMLList = new XMLList("<node></node><node></node>");
         this._dpMovieMenu = _loc1_;
         BindingManager.executeBindings(this,"_dpMovieMenu",this._dpMovieMenu);
         return _loc1_;
      }
      
      private function _MainStage_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = new Sequence();
         _loc1_.children = [this._MainStage_Fade1_i(),this._MainStage_Pause1_i(),this._MainStage_Fade2_i()];
         this._efAutoSave = _loc1_;
         BindingManager.executeBindings(this,"_efAutoSave",this._efAutoSave);
         return _loc1_;
      }
      
      private function _MainStage_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 1500;
         this.fadeIn = _loc1_;
         BindingManager.executeBindings(this,"fadeIn",this.fadeIn);
         return _loc1_;
      }
      
      private function _MainStage_Pause1_i() : Pause
      {
         var _loc1_:Pause = new Pause();
         _loc1_.duration = 1000;
         this.pause = _loc1_;
         BindingManager.executeBindings(this,"pause",this.pause);
         return _loc1_;
      }
      
      private function _MainStage_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.duration = 1500;
         this.fadeOut = _loc1_;
         BindingManager.executeBindings(this,"fadeOut",this.fadeOut);
         return _loc1_;
      }
      
      private function _MainStage_Fade3_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         this.fadeInMap = _loc1_;
         BindingManager.executeBindings(this,"fadeInMap",this.fadeInMap);
         return _loc1_;
      }
      
      private function _MainStage_Fade4_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         this.fadeOutMap = _loc1_;
         BindingManager.executeBindings(this,"fadeOutMap",this.fadeOutMap);
         return _loc1_;
      }
      
      private function _MainStage_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.distance = 3;
         this.panDropShadow = _loc1_;
         BindingManager.executeBindings(this,"panDropShadow",this.panDropShadow);
         return _loc1_;
      }
      
      private function _MainStage_NumberFormatter1_i() : NumberFormatter
      {
         var _loc1_:NumberFormatter = new NumberFormatter();
         _loc1_.precision = 0;
         _loc1_.rounding = "nearest";
         this.percentFormatter = _loc1_;
         BindingManager.executeBindings(this,"percentFormatter",this.percentFormatter);
         return _loc1_;
      }
      
      private function _MainStage_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "simple";
         _loc1_.overrides = [this._MainStage_SetProperty1_i(),this._MainStage_SetProperty2_i()];
         return _loc1_;
      }
      
      private function _MainStage_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "visible";
         _loc1_.value = false;
         this._MainStage_SetProperty1 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_SetProperty1",this._MainStage_SetProperty1);
         return _loc1_;
      }
      
      private function _MainStage_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "includeInLayout";
         _loc1_.value = false;
         this._MainStage_SetProperty2 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_SetProperty2",this._MainStage_SetProperty2);
         return _loc1_;
      }
      
      private function _MainStage_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "cn";
         _loc1_.basedOn = "simple";
         _loc1_.overrides = [this._MainStage_AddChild1_i(),this._MainStage_AddChild2_i(),this._MainStage_AddChild3_i(),this._MainStage_AddChild4_i()];
         return _loc1_;
      }
      
      private function _MainStage_AddChild1_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MainStage_Label3_i);
         this._MainStage_AddChild1 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_AddChild1",this._MainStage_AddChild1);
         return _loc1_;
      }
      
      private function _MainStage_Label3_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.styleName = "textColoring";
         _loc1_.id = "_MainStage_Label3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._MainStage_Label3 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_Label3",this._MainStage_Label3);
         return _loc1_;
      }
      
      private function _MainStage_AddChild2_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MainStage_Label4_i);
         this._MainStage_AddChild2 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_AddChild2",this._MainStage_AddChild2);
         return _loc1_;
      }
      
      private function _MainStage_Label4_i() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.styleName = "textColoring";
         _loc1_.setStyle("textDecoration","underline");
         _loc1_.id = "_MainStage_Label4";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._MainStage_Label4 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_Label4",this._MainStage_Label4);
         return _loc1_;
      }
      
      private function _MainStage_AddChild3_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MainStage_Button5_i);
         this._MainStage_AddChild3 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_AddChild3",this._MainStage_AddChild3);
         return _loc1_;
      }
      
      private function _MainStage_Button5_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.styleName = "btnAddScene";
         _loc1_.buttonMode = true;
         _loc1_.addEventListener("click",this.___btnAddScene_click);
         _loc1_.id = "_btnAddScene";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._btnAddScene = _loc1_;
         BindingManager.executeBindings(this,"_btnAddScene",this._btnAddScene);
         return _loc1_;
      }
      
      public function ___btnAddScene_click(param1:MouseEvent) : void
      {
         Console.getConsole().addNextScene();
      }
      
      private function _MainStage_AddChild4_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MainStage_Button6_i);
         this._MainStage_AddChild4 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_AddChild4",this._MainStage_AddChild4);
         return _loc1_;
      }
      
      private function _MainStage_Button6_i() : Button
      {
         var _loc1_:Button = new Button();
         _loc1_.styleName = "btnDelScene";
         _loc1_.buttonMode = true;
         _loc1_.addEventListener("click",this.___btnDelScene_click);
         _loc1_.id = "_btnDelScene";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._btnDelScene = _loc1_;
         BindingManager.executeBindings(this,"_btnDelScene",this._btnDelScene);
         return _loc1_;
      }
      
      public function ___btnDelScene_click(param1:MouseEvent) : void
      {
         Console.getConsole().deleteCurrentScene();
      }
      
      private function _MainStage_State3_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "domo";
         _loc1_.basedOn = "cn";
         return _loc1_;
      }
      
      private function _MainStage_State4_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "emessage";
         _loc1_.basedOn = "simple";
         _loc1_.overrides = [this._MainStage_RemoveChild1_i(),this._MainStage_RemoveChild2_i()];
         return _loc1_;
      }
      
      private function _MainStage_RemoveChild1_i() : RemoveChild
      {
         var _loc1_:RemoveChild = new RemoveChild();
         this._MainStage_RemoveChild1 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_RemoveChild1",this._MainStage_RemoveChild1);
         return _loc1_;
      }
      
      private function _MainStage_RemoveChild2_i() : RemoveChild
      {
         var _loc1_:RemoveChild = new RemoveChild();
         this._MainStage_RemoveChild2 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_RemoveChild2",this._MainStage_RemoveChild2);
         return _loc1_;
      }
      
      public function ___MainStage_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.onResize(param1);
      }
      
      public function ___MainStage_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___MainStage_Button1_click(param1:MouseEvent) : void
      {
         this.hideCameraView();
      }
      
      public function ___btnSceneSet_click(param1:MouseEvent) : void
      {
         this.onSceneSettingBtnClick();
      }
      
      public function ___btnSceneSet_mouseOver(param1:MouseEvent) : void
      {
         this.showToolTipAbove(param1,UtilDict.toDisplay("go","Change scene duration, add a transition with the previous scene."));
      }
      
      public function ___btnSceneSet_mouseOut(param1:MouseEvent) : void
      {
         this.killToolTip();
      }
      
      public function ___MainStage_Button3_click(param1:MouseEvent) : void
      {
         this.onAddSceneBtnClick();
      }
      
      public function ___btnSceneMenu_click(param1:MouseEvent) : void
      {
         this.showSceneMenu(param1);
      }
      
      public function ___MainStage_VBox2_rollOver(param1:MouseEvent) : void
      {
         this.showMiniMap(param1);
      }
      
      public function ___MainStage_VBox2_rollOut(param1:MouseEvent) : void
      {
         this.hideMiniMap();
      }
      
      public function ___MainStage_VBox2_mouseUp(param1:MouseEvent) : void
      {
         this.onStageAreaMouseUp(param1);
      }
      
      public function ___miniMap_viewChanged(param1:MiniMapEvent) : void
      {
         this.onMiniMapViewChange(param1);
      }
      
      public function ___zoomSlider_change(param1:SliderEvent) : void
      {
         this.onZoomSliderChange(param1);
      }
      
      private function _MainStage_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_autosavedone");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtAutoSave.text");
         result[1] = new Binding(this,function():Boolean
         {
            return UtilSite.isDevelopmentSite;
         },null,"_MainStage_Canvas6.includeInLayout");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = StudioStatusManager.instance.status;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MainStage_Text1.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_lookout");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MainStage_Button1.toolTip");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Scene Settings");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSceneSet.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add Scene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MainStage_Button3.label");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = percentFormatter.format(_zoomSlider.value * 100) + " %";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MainStage_Label2.text");
         result[7] = new Binding(this,null,null,"fadeIn.target","_uiCanvasAutoSave");
         result[8] = new Binding(this,null,null,"pause.target","_uiCanvasAutoSave");
         result[9] = new Binding(this,null,null,"fadeOut.target","_uiCanvasAutoSave");
         result[10] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Add Scene");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            _dpMovieMenu[0]._loc2_::@label = param1;
         },"_dpMovieMenu[0].@ns3::label");
         result[11] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Add Blank Scene");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            _dpMovieMenu[1]._loc2_::@label = param1;
         },"_dpMovieMenu[1].@ns4::label");
         result[12] = new Binding(this,null,null,"_MainStage_SetProperty1.target","_zoomControl");
         result[13] = new Binding(this,null,null,"_MainStage_SetProperty2.target","_zoomControl");
         result[14] = new Binding(this,null,null,"_MainStage_AddChild1.relativeTo","_bottomControlBar");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_displaying");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MainStage_Label3.text");
         result[16] = new Binding(this,null,null,"_MainStage_AddChild2.relativeTo","_bottomControlBar");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_scene") + " " + this.sceneIndexStr;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_MainStage_Label4.text");
         result[18] = new Binding(this,null,null,"_MainStage_AddChild3.relativeTo","_bottomControlBar");
         result[19] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_addscene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnAddScene.toolTip");
         result[20] = new Binding(this,null,null,"_MainStage_AddChild4.relativeTo","_bottomControlBar");
         result[21] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_delscene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnDelScene.toolTip");
         result[22] = new Binding(this,null,null,"_MainStage_RemoveChild1.target","toolBar");
         result[23] = new Binding(this,null,null,"_MainStage_RemoveChild2.target","_bottomControlBar");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _addSceneEffectLayer() : Canvas
      {
         return this._2002216470_addSceneEffectLayer;
      }
      
      public function set _addSceneEffectLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._2002216470_addSceneEffectLayer;
         if(_loc2_ !== param1)
         {
            this._2002216470_addSceneEffectLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_addSceneEffectLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _bottomControlBar() : HBox
      {
         return this._51913824_bottomControlBar;
      }
      
      public function set _bottomControlBar(param1:HBox) : void
      {
         var _loc2_:Object = this._51913824_bottomControlBar;
         if(_loc2_ !== param1)
         {
            this._51913824_bottomControlBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bottomControlBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnAddScene() : Button
      {
         return this._89648856_btnAddScene;
      }
      
      public function set _btnAddScene(param1:Button) : void
      {
         var _loc2_:Object = this._89648856_btnAddScene;
         if(_loc2_ !== param1)
         {
            this._89648856_btnAddScene = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnAddScene",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelScene() : Button
      {
         return this._1960351742_btnDelScene;
      }
      
      public function set _btnDelScene(param1:Button) : void
      {
         var _loc2_:Object = this._1960351742_btnDelScene;
         if(_loc2_ !== param1)
         {
            this._1960351742_btnDelScene = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDelScene",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSceneMenu() : Button
      {
         return this._1034752274_btnSceneMenu;
      }
      
      public function set _btnSceneMenu(param1:Button) : void
      {
         var _loc2_:Object = this._1034752274_btnSceneMenu;
         if(_loc2_ !== param1)
         {
            this._1034752274_btnSceneMenu = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSceneMenu",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSceneSet() : Button
      {
         return this._382268659_btnSceneSet;
      }
      
      public function set _btnSceneSet(param1:Button) : void
      {
         var _loc2_:Object = this._382268659_btnSceneSet;
         if(_loc2_ !== param1)
         {
            this._382268659_btnSceneSet = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSceneSet",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cameraBorder() : UIComponent
      {
         return this._766696848_cameraBorder;
      }
      
      public function set _cameraBorder(param1:UIComponent) : void
      {
         var _loc2_:Object = this._766696848_cameraBorder;
         if(_loc2_ !== param1)
         {
            this._766696848_cameraBorder = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cameraBorder",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _controlLayer() : Canvas
      {
         return this._550419411_controlLayer;
      }
      
      public function set _controlLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._550419411_controlLayer;
         if(_loc2_ !== param1)
         {
            this._550419411_controlLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_controlLayer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _dpMovieMenu() : XMLList
      {
         return this._1566867516_dpMovieMenu;
      }
      
      public function set _dpMovieMenu(param1:XMLList) : void
      {
         var _loc2_:Object = this._1566867516_dpMovieMenu;
         if(_loc2_ !== param1)
         {
            this._1566867516_dpMovieMenu = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_dpMovieMenu",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _efAutoSave() : Sequence
      {
         return this._246888748_efAutoSave;
      }
      
      public function set _efAutoSave(param1:Sequence) : void
      {
         var _loc2_:Object = this._246888748_efAutoSave;
         if(_loc2_ !== param1)
         {
            this._246888748_efAutoSave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_efAutoSave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lookInToolBar() : HBox
      {
         return this._2046797976_lookInToolBar;
      }
      
      public function set _lookInToolBar(param1:HBox) : void
      {
         var _loc2_:Object = this._2046797976_lookInToolBar;
         if(_loc2_ !== param1)
         {
            this._2046797976_lookInToolBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lookInToolBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvasScene() : Canvas
      {
         return this._607259319_maskCanvasScene;
      }
      
      public function set _maskCanvasScene(param1:Canvas) : void
      {
         var _loc2_:Object = this._607259319_maskCanvasScene;
         if(_loc2_ !== param1)
         {
            this._607259319_maskCanvasScene = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvasScene",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvasSceneButton() : Canvas
      {
         return this._240112165_maskCanvasSceneButton;
      }
      
      public function set _maskCanvasSceneButton(param1:Canvas) : void
      {
         var _loc2_:Object = this._240112165_maskCanvasSceneButton;
         if(_loc2_ !== param1)
         {
            this._240112165_maskCanvasSceneButton = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvasSceneButton",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _microMap() : MiniMap
      {
         return this._1575126697_microMap;
      }
      
      public function set _microMap(param1:MiniMap) : void
      {
         var _loc2_:Object = this._1575126697_microMap;
         if(_loc2_ !== param1)
         {
            this._1575126697_microMap = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_microMap",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _miniMap() : MiniMap
      {
         return this._872235962_miniMap;
      }
      
      public function set _miniMap(param1:MiniMap) : void
      {
         var _loc2_:Object = this._872235962_miniMap;
         if(_loc2_ !== param1)
         {
            this._872235962_miniMap = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_miniMap",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _stageArea() : Canvas
      {
         return this._347427628_stageArea;
      }
      
      public function set _stageArea(param1:Canvas) : void
      {
         var _loc2_:Object = this._347427628_stageArea;
         if(_loc2_ !== param1)
         {
            this._347427628_stageArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_stageArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtAutoSave() : Label
      {
         return this._1570224285_txtAutoSave;
      }
      
      public function set _txtAutoSave(param1:Label) : void
      {
         var _loc2_:Object = this._1570224285_txtAutoSave;
         if(_loc2_ !== param1)
         {
            this._1570224285_txtAutoSave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtAutoSave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasAutoSave() : Canvas
      {
         return this._766521513_uiCanvasAutoSave;
      }
      
      public function set _uiCanvasAutoSave(param1:Canvas) : void
      {
         var _loc2_:Object = this._766521513_uiCanvasAutoSave;
         if(_loc2_ !== param1)
         {
            this._766521513_uiCanvasAutoSave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasAutoSave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _zoomControl() : HBox
      {
         return this._599927733_zoomControl;
      }
      
      public function set _zoomControl(param1:HBox) : void
      {
         var _loc2_:Object = this._599927733_zoomControl;
         if(_loc2_ !== param1)
         {
            this._599927733_zoomControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_zoomControl",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _zoomSlider() : HSlider
      {
         return this._435778611_zoomSlider;
      }
      
      public function set _zoomSlider(param1:HSlider) : void
      {
         var _loc2_:Object = this._435778611_zoomSlider;
         if(_loc2_ !== param1)
         {
            this._435778611_zoomSlider = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_zoomSlider",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get assetResizeToolTip() : AssetResizeToolTip
      {
         return this._533588863assetResizeToolTip;
      }
      
      public function set assetResizeToolTip(param1:AssetResizeToolTip) : void
      {
         var _loc2_:Object = this._533588863assetResizeToolTip;
         if(_loc2_ !== param1)
         {
            this._533588863assetResizeToolTip = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"assetResizeToolTip",_loc2_,param1));
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
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeInMap() : Fade
      {
         return this._904480549fadeInMap;
      }
      
      public function set fadeInMap(param1:Fade) : void
      {
         var _loc2_:Object = this._904480549fadeInMap;
         if(_loc2_ !== param1)
         {
            this._904480549fadeInMap = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeInMap",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOut() : Fade
      {
         return this._1091436750fadeOut;
      }
      
      public function set fadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._1091436750fadeOut;
         if(_loc2_ !== param1)
         {
            this._1091436750fadeOut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOut",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOutMap() : Fade
      {
         return this._2089711414fadeOutMap;
      }
      
      public function set fadeOutMap(param1:Fade) : void
      {
         var _loc2_:Object = this._2089711414fadeOutMap;
         if(_loc2_ !== param1)
         {
            this._2089711414fadeOutMap = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOutMap",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get panDropShadow() : DropShadowFilter
      {
         return this._355954324panDropShadow;
      }
      
      public function set panDropShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._355954324panDropShadow;
         if(_loc2_ !== param1)
         {
            this._355954324panDropShadow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"panDropShadow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get pause() : Pause
      {
         return this._106440182pause;
      }
      
      public function set pause(param1:Pause) : void
      {
         var _loc2_:Object = this._106440182pause;
         if(_loc2_ !== param1)
         {
            this._106440182pause = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pause",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get percentFormatter() : NumberFormatter
      {
         return this._1931449851percentFormatter;
      }
      
      public function set percentFormatter(param1:NumberFormatter) : void
      {
         var _loc2_:Object = this._1931449851percentFormatter;
         if(_loc2_ !== param1)
         {
            this._1931449851percentFormatter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"percentFormatter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sceneEditor() : SceneEditor
      {
         return this._685077223sceneEditor;
      }
      
      public function set sceneEditor(param1:SceneEditor) : void
      {
         var _loc2_:Object = this._685077223sceneEditor;
         if(_loc2_ !== param1)
         {
            this._685077223sceneEditor = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneEditor",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get toolBar() : GoToolBar
      {
         return this._1140124837toolBar;
      }
      
      public function set toolBar(param1:GoToolBar) : void
      {
         var _loc2_:Object = this._1140124837toolBar;
         if(_loc2_ !== param1)
         {
            this._1140124837toolBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"toolBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get zoomContainer() : ZoomContainer
      {
         return this._237378066zoomContainer;
      }
      
      public function set zoomContainer(param1:ZoomContainer) : void
      {
         var _loc2_:Object = this._237378066zoomContainer;
         if(_loc2_ !== param1)
         {
            this._237378066zoomContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"zoomContainer",_loc2_,param1));
            }
         }
      }
      
      public function set loggedIn(param1:Boolean) : void
      {
         var _loc2_:Object = this.loggedIn;
         if(_loc2_ !== param1)
         {
            this._2020648519loggedIn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loggedIn",_loc2_,param1));
            }
         }
      }
      
      public function set sceneIndexStr(param1:String) : void
      {
         var _loc2_:Object = this.sceneIndexStr;
         if(_loc2_ !== param1)
         {
            this._1575404715sceneIndexStr = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneIndexStr",_loc2_,param1));
            }
         }
      }
   }
}
