package anifire.components.studio
{
   import anifire.banner.GoAdv;
   import anifire.command.ChangeActionCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.constant.ThemeConstants;
   import anifire.core.Action;
   import anifire.core.CharThumb;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IEye;
   import anifire.products.character.ActionPreviewPanel;
   import anifire.util.UtilDict;
   import anifire.util.UtilPopUp;
   import anifire.util.UtilString;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.Spacer;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ItemClickEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class CharacterActionPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _CharacterActionPanel_Label1:Label;
      
      public var _CharacterActionPanel_Label2:Label;
      
      public var _CharacterActionPanel_Label3:Label;
      
      public var _CharacterActionPanel_Label4:Label;
      
      public var _CharacterActionPanel_Label5:Label;
      
      private var _1419525765_rbgVariation:RadioButtonGroup;
      
      private var _1570857836_variation:HBox;
      
      private var _2118535603_variationContainer:HBox;
      
      private var _1569328494actionPanel:VBox;
      
      private var _516127630actionPreviewPanel:ActionPreviewPanel;
      
      private var _1337192018actionSelectPanel:VBox;
      
      private var _1396342996banner:GoAdv;
      
      private var _670468728bannerSpacer:Spacer;
      
      private var _364475383boxFacial:VBox;
      
      private var _1869653775boxHandheld:VBox;
      
      private var _71950923boxHead:VBox;
      
      private var _752492122boxHeadgear:VBox;
      
      private var _62698418btnAction:Button;
      
      private var _203490248btnFacial:Button;
      
      private var _1780808384btnHandHeld:Button;
      
      private var _663646731btnHeadGear:Button;
      
      private var _947794573btnLookAtCamera:Button;
      
      private var _414434916btnRemoveHandHeld:Button;
      
      private var _702726737btnRemoveHeadGear:Button;
      
      private var _1336538514btnRestoreHead:Button;
      
      private var _2097113269btnSlide:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _character:Character;
      
      private var _view:IAssetView;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function CharacterActionPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"actionPanel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "id":"actionSelectPanel",
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_CharacterActionPanel_Label1",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"maxWidth":250};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnAction",
                                       "events":{"click":"__btnAction_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":200,
                                             "labelPlacement":"left",
                                             "styleName":"btnActionMenuSidePanel"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnSlide",
                                       "events":{"click":"__btnSlide_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnSlideChar",
                                             "visible":false,
                                             "focusEnabled":false,
                                             "buttonMode":true,
                                             "toggle":true
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_variation",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "visible":false,
                                       "includeInLayout":false,
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":Label,
                                          "id":"_CharacterActionPanel_Label2",
                                          "stylesFactory":function():void
                                          {
                                             this.fontSize = 10;
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"maxWidth":60};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":HBox,
                                          "id":"_variationContainer"
                                       })]
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":ActionPreviewPanel,
                           "id":"actionPreviewPanel",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HRule,
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"boxFacial",
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":HBox,
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnFacial",
                                       "events":{"click":"__btnFacial_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "labelPlacement":"left",
                                             "width":200,
                                             "label":"Select",
                                             "styleName":"btnActionMenuSidePanel"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnLookAtCamera",
                                       "events":{"click":"__btnLookAtCamera_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "visible":false,
                                             "styleName":"btnLookAtCamera",
                                             "toggle":true,
                                             "focusEnabled":false,
                                             "buttonMode":true
                                          };
                                       }
                                    })]};
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"boxHandheld",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HRule,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_CharacterActionPanel_Label3",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"maxWidth":60};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"btnHandHeld",
                                             "events":{"click":"__btnHandHeld_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "labelPlacement":"left",
                                                   "width":150,
                                                   "styleName":"btnMenuSidePanel"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"btnRemoveHandHeld",
                                             "events":{"click":"__btnRemoveHandHeld_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"btnDeleteSidePanel",
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
                           "type":VBox,
                           "id":"boxHeadgear",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "includeInLayout":false,
                                 "visible":false,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HRule,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Label,
                                          "id":"_CharacterActionPanel_Label4",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"maxWidth":60};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"btnHeadGear",
                                          "events":{"click":"__btnHeadGear_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "labelPlacement":"left",
                                                "width":150,
                                                "styleName":"btnMenuSidePanel"
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"btnRemoveHeadGear",
                                          "events":{"click":"__btnRemoveHeadGear_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnDeleteSidePanel",
                                                "buttonMode":true
                                             };
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"boxHead",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HRule,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Label,
                                          "id":"_CharacterActionPanel_Label5",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"maxWidth":80};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"btnRestoreHead",
                                          "events":{"click":"__btnRestoreHead_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnSidePanel",
                                                "maxWidth":150
                                             };
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Spacer,
                           "id":"bannerSpacer",
                           "propertiesFactory":function():Object
                           {
                              return {"percentHeight":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":GoAdv,
                           "id":"banner",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
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
         var bindings:Array = this._CharacterActionPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_CharacterActionPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return CharacterActionPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._CharacterActionPanel_RadioButtonGroup1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         CharacterActionPanel._watcherSetupUtil = param1;
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
      
      public function set target(param1:Object) : void
      {
         var thumb:CharThumb = null;
         var obj:Object = param1;
         try
         {
            this._view = null;
            if(obj is IAssetView)
            {
               this._view = obj as IAssetView;
               obj = this._view.asset;
            }
            this.actionPanel.visible = true;
            if(obj != this._character)
            {
               if(obj is Character)
               {
                  if(this._character)
                  {
                     this._character.removeEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
                  }
                  this._character = Character(obj);
                  this.updateActionPanel();
                  this._character.addEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
               }
               else
               {
                  this._character = null;
               }
            }
            this.actionSelectPanel.visible = this.actionSelectPanel.includeInLayout = true;
            this.bannerSpacer.includeInLayout = true;
            if(obj is Character)
            {
               thumb = Character(obj).thumb as CharThumb;
               if(thumb)
               {
                  if(thumb.themeId == ThemeConstants.STICKLY_BIZ_THEME_ID || thumb.themeId == ThemeConstants.BIZ_MODEL_THEME_ID)
                  {
                     this.actionPreviewPanel.target = obj;
                     this.actionSelectPanel.visible = this.actionSelectPanel.includeInLayout = false;
                     this.bannerSpacer.includeInLayout = false;
                  }
               }
            }
         }
         catch(e:Error)
         {
            actionPanel.visible = false;
            UtilPopUp.errorAlert("Error: CharacterActionPanel fail.");
         }
      }
      
      private function updateActionPanel() : void
      {
         var _loc1_:CharThumb = null;
         if(this._character)
         {
            if(Action(this._character.action).actionGroup)
            {
               this.btnAction.label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",Action(this._character.action).actionGroup.name));
            }
            else
            {
               this.btnAction.label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",Action(this._character.action).name));
            }
            this.initVariation();
            this.boxFacial.includeInLayout = this.boxFacial.visible = !Console.getConsole().isTutorialOn;
            if(this._character.head && this._character.head.state)
            {
               this.btnFacial.label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",this._character.head.state.name));
            }
            else
            {
               this.btnFacial.label = UtilDict.toDisplay("go","Select Expression");
            }
            if(this._character.prop)
            {
               if(this._character.prop.state)
               {
                  this.btnHandHeld.label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",this._character.prop.state.name));
                  this.btnHandHeld.enabled = true;
               }
               else
               {
                  this.btnHandHeld.label = UtilDict.toDisplay("go","No state");
                  this.btnHandHeld.enabled = false;
               }
               this.boxHandheld.includeInLayout = this.boxHandheld.visible = true;
            }
            else
            {
               this.boxHandheld.includeInLayout = this.boxHandheld.visible = false;
            }
            this.boxHeadgear.includeInLayout = this.boxHeadgear.visible = false;
            _loc1_ = this._character.thumb as CharThumb;
            if(_loc1_ && this._character.wear)
            {
               if(_loc1_.themeId != ThemeConstants.STICKLY_BIZ_THEME_ID && _loc1_.themeId != ThemeConstants.BIZ_MODEL_THEME_ID)
               {
                  if(this._character.wear.state)
                  {
                     this.btnHeadGear.label = UtilString.firstLetterToUpperCase(this._character.wear.state.name);
                     this.btnHeadGear.enabled = true;
                  }
                  else
                  {
                     this.btnHeadGear.label = UtilDict.toDisplay("go","No state");
                     this.btnHeadGear.enabled = false;
                  }
                  this.boxHeadgear.includeInLayout = this.boxHeadgear.visible = true;
               }
            }
            if(this._character.head && this._character.head.thumb.id != this._character.thumb.id + ".head")
            {
               this.boxHead.includeInLayout = this.boxHead.visible = true;
            }
            else
            {
               this.boxHead.includeInLayout = this.boxHead.visible = false;
            }
            this.btnLookAtCamera.visible = false;
            if(this._view && this._view.assetImage is IEye && IEye(this._view.assetImage).lookAtCameraSupported)
            {
               this.btnLookAtCamera.visible = true;
               this.btnLookAtCamera.selected = IEye(this._view.assetImage).lookAtCamera;
            }
            this.btnSlide.selected = this._character.isSliding;
            this.banner.refresh(this._character);
         }
      }
      
      private function onActionMenuClick(param1:MenuEvent) : void
      {
         this.btnAction.label = param1.item.@label;
         Console.getConsole().mainStage.sceneEditor.controller.hideControl();
      }
      
      private function onActionChange(param1:AssetEvent) : void
      {
         if(this._character)
         {
            this.btnSlide.selected = this._character.isSliding;
         }
         this.updateActionPanel();
      }
      
      private function onFacialMenuClick(param1:MenuEvent) : void
      {
         this.btnFacial.label = param1.item.@label;
      }
      
      private function onHandHeldMenuClick(param1:MenuEvent) : void
      {
         this.btnHandHeld.label = param1.item.@label;
      }
      
      private function onHeadGearMenuClick(param1:MenuEvent) : void
      {
         this.btnHeadGear.label = param1.item.@label;
      }
      
      private function showActionMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(this._character)
         {
            _loc2_ = this.btnAction.localToGlobal(new Point(0,this.btnAction.y + this.btnAction.height));
            _loc3_ = this._character.actionMenu;
            _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onActionMenuClick);
            _loc3_.show(_loc2_.x,_loc2_.y);
         }
      }
      
      private function showFacialMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(Console.getConsole().isTutorialOn)
         {
            return;
         }
         if(this._character)
         {
            _loc2_ = this.btnFacial.localToGlobal(new Point(0,this.btnFacial.y + this.btnFacial.height));
            if(this._character.head && this._character.head.thumb.id != this._character.thumb.id + ".head")
            {
               _loc3_ = this._character.headMenu;
            }
            else
            {
               _loc3_ = this._character.facialMenu;
            }
            _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onFacialMenuClick);
            _loc3_.show(_loc2_.x,_loc2_.y);
         }
      }
      
      private function showHandHeldMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(this._character)
         {
            _loc2_ = this.btnHandHeld.localToGlobal(new Point(0,this.btnHandHeld.y + this.btnHandHeld.height));
            _loc3_ = this._character.handHeldMenu;
            if(_loc3_)
            {
               _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onHandHeldMenuClick);
               _loc3_.show(_loc2_.x,_loc2_.y);
            }
         }
      }
      
      private function showHeadGearMenu(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:ScrollableArrowMenu = null;
         if(this._character)
         {
            _loc2_ = this.btnHeadGear.localToGlobal(new Point(0,this.btnHeadGear.y + this.btnHeadGear.height));
            _loc3_ = this._character.headGearMenu;
            if(_loc3_)
            {
               _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.onHeadGearMenuClick);
               _loc3_.show(_loc2_.x,_loc2_.y);
            }
         }
      }
      
      private function removeHandHeld() : void
      {
         if(this._character)
         {
            this._character.removeHandHeld();
            this.boxHandheld.includeInLayout = this.boxHandheld.visible = false;
         }
      }
      
      private function removeHeadGear() : void
      {
         if(this._character)
         {
            this._character.removeHeadGear();
            this.boxHeadgear.includeInLayout = this.boxHeadgear.visible = false;
         }
      }
      
      private function restoreHead() : void
      {
         if(this._character)
         {
            this._character.restoreHead();
            this.boxHead.includeInLayout = this.boxHead.visible = false;
         }
      }
      
      private function onSlideBtnClick() : void
      {
         var _loc1_:ICommand = null;
         if(this._character)
         {
            if(this.btnSlide.selected)
            {
               _loc1_ = new ChangeActionCommand();
               _loc1_.execute();
               this._character.startSlideMotion();
            }
            else
            {
               _loc1_ = new RemoveMotionCommand();
               _loc1_.execute();
               this._character.removeSlideMotion();
            }
         }
      }
      
      private function initVariation() : void
      {
         var _loc1_:RadioButton = null;
         var _loc2_:int = 0;
         if(this._character && this._character.action && Action(this._character.action).actionGroup)
         {
            this._variationContainer.removeAllChildren();
            this._rbgVariation = new RadioButtonGroup();
            this._rbgVariation.addEventListener(ItemClickEvent.ITEM_CLICK,this.onVariationChange);
            _loc2_ = 0;
            while(_loc2_ < Action(this._character.action).actionGroup.actions.length)
            {
               _loc1_ = new RadioButton();
               _loc1_.buttonMode = true;
               _loc1_.group = this._rbgVariation;
               _loc1_.styleName = "btnVariation" + (_loc2_ + 1);
               this._variationContainer.addChild(_loc1_);
               if((_loc2_ + 1).toString() == Action(this._character.action).name)
               {
                  _loc1_.selected = true;
               }
               _loc2_++;
            }
            this._variation.visible = this._variation.includeInLayout = true;
         }
         else
         {
            this._variation.visible = this._variation.includeInLayout = false;
         }
      }
      
      private function onVariationChange(param1:ItemClickEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:Array = Action(this._character.action).actionGroup.actions;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if((param1.index + 1).toString() == Action(_loc2_[_loc3_]).name)
            {
               _loc4_ = Action(_loc2_[_loc3_]).id;
               this._character.onVariationClick(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function _CharacterActionPanel_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("itemClick",this.___rbgVariation_itemClick);
         _loc1_.initialized(this,"_rbgVariation");
         this._rbgVariation = _loc1_;
         BindingManager.executeBindings(this,"_rbgVariation",this._rbgVariation);
         return _loc1_;
      }
      
      public function ___rbgVariation_itemClick(param1:ItemClickEvent) : void
      {
         this.onVariationChange(param1);
      }
      
      public function __btnAction_click(param1:MouseEvent) : void
      {
         this.showActionMenu(param1);
      }
      
      public function __btnSlide_click(param1:MouseEvent) : void
      {
         this.onSlideBtnClick();
      }
      
      public function __btnFacial_click(param1:MouseEvent) : void
      {
         this.showFacialMenu(param1);
      }
      
      public function __btnLookAtCamera_click(param1:MouseEvent) : void
      {
         Console.getConsole().flipCCLookAtCamera();
      }
      
      public function __btnHandHeld_click(param1:MouseEvent) : void
      {
         this.showHandHeldMenu(param1);
      }
      
      public function __btnRemoveHandHeld_click(param1:MouseEvent) : void
      {
         this.removeHandHeld();
      }
      
      public function __btnHeadGear_click(param1:MouseEvent) : void
      {
         this.showHeadGearMenu(param1);
      }
      
      public function __btnRemoveHeadGear_click(param1:MouseEvent) : void
      {
         this.removeHeadGear();
      }
      
      public function __btnRestoreHead_click(param1:MouseEvent) : void
      {
         this.restoreHead();
      }
      
      private function _CharacterActionPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Action");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CharacterActionPanel_Label1.text");
         result[1] = new Binding(this,function():Boolean
         {
            return btnAction.enabled;
         },null,"btnAction.buttonMode");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Slide");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnSlide.toolTip");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Variations");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CharacterActionPanel_Label2.text");
         result[4] = new Binding(this,function():Boolean
         {
            return !actionSelectPanel.visible;
         },null,"actionPreviewPanel.visible");
         result[5] = new Binding(this,function():Boolean
         {
            return !actionSelectPanel.visible;
         },null,"actionPreviewPanel.includeInLayout");
         result[6] = new Binding(this,function():Boolean
         {
            return btnFacial.enabled;
         },null,"btnFacial.buttonMode");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Look at Camera");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnLookAtCamera.toolTip");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Handheld");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CharacterActionPanel_Label3.text");
         result[9] = new Binding(this,function():Boolean
         {
            return btnHandHeld.enabled;
         },null,"btnHandHeld.buttonMode");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Headgear");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CharacterActionPanel_Label4.text");
         result[11] = new Binding(this,function():Boolean
         {
            return btnHeadGear.enabled;
         },null,"btnHeadGear.buttonMode");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Head Prop");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_CharacterActionPanel_Label5.text");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Use default");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnRestoreHead.label");
         result[14] = new Binding(this,function():Boolean
         {
            return btnRestoreHead.enabled;
         },null,"btnRestoreHead.buttonMode");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _rbgVariation() : RadioButtonGroup
      {
         return this._1419525765_rbgVariation;
      }
      
      public function set _rbgVariation(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1419525765_rbgVariation;
         if(_loc2_ !== param1)
         {
            this._1419525765_rbgVariation = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_rbgVariation",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _variation() : HBox
      {
         return this._1570857836_variation;
      }
      
      public function set _variation(param1:HBox) : void
      {
         var _loc2_:Object = this._1570857836_variation;
         if(_loc2_ !== param1)
         {
            this._1570857836_variation = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_variation",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _variationContainer() : HBox
      {
         return this._2118535603_variationContainer;
      }
      
      public function set _variationContainer(param1:HBox) : void
      {
         var _loc2_:Object = this._2118535603_variationContainer;
         if(_loc2_ !== param1)
         {
            this._2118535603_variationContainer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_variationContainer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get actionPanel() : VBox
      {
         return this._1569328494actionPanel;
      }
      
      public function set actionPanel(param1:VBox) : void
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
      public function get actionPreviewPanel() : ActionPreviewPanel
      {
         return this._516127630actionPreviewPanel;
      }
      
      public function set actionPreviewPanel(param1:ActionPreviewPanel) : void
      {
         var _loc2_:Object = this._516127630actionPreviewPanel;
         if(_loc2_ !== param1)
         {
            this._516127630actionPreviewPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actionPreviewPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get actionSelectPanel() : VBox
      {
         return this._1337192018actionSelectPanel;
      }
      
      public function set actionSelectPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1337192018actionSelectPanel;
         if(_loc2_ !== param1)
         {
            this._1337192018actionSelectPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actionSelectPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get banner() : GoAdv
      {
         return this._1396342996banner;
      }
      
      public function set banner(param1:GoAdv) : void
      {
         var _loc2_:Object = this._1396342996banner;
         if(_loc2_ !== param1)
         {
            this._1396342996banner = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"banner",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bannerSpacer() : Spacer
      {
         return this._670468728bannerSpacer;
      }
      
      public function set bannerSpacer(param1:Spacer) : void
      {
         var _loc2_:Object = this._670468728bannerSpacer;
         if(_loc2_ !== param1)
         {
            this._670468728bannerSpacer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bannerSpacer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get boxFacial() : VBox
      {
         return this._364475383boxFacial;
      }
      
      public function set boxFacial(param1:VBox) : void
      {
         var _loc2_:Object = this._364475383boxFacial;
         if(_loc2_ !== param1)
         {
            this._364475383boxFacial = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"boxFacial",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get boxHandheld() : VBox
      {
         return this._1869653775boxHandheld;
      }
      
      public function set boxHandheld(param1:VBox) : void
      {
         var _loc2_:Object = this._1869653775boxHandheld;
         if(_loc2_ !== param1)
         {
            this._1869653775boxHandheld = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"boxHandheld",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get boxHead() : VBox
      {
         return this._71950923boxHead;
      }
      
      public function set boxHead(param1:VBox) : void
      {
         var _loc2_:Object = this._71950923boxHead;
         if(_loc2_ !== param1)
         {
            this._71950923boxHead = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"boxHead",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get boxHeadgear() : VBox
      {
         return this._752492122boxHeadgear;
      }
      
      public function set boxHeadgear(param1:VBox) : void
      {
         var _loc2_:Object = this._752492122boxHeadgear;
         if(_loc2_ !== param1)
         {
            this._752492122boxHeadgear = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"boxHeadgear",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnAction() : Button
      {
         return this._62698418btnAction;
      }
      
      public function set btnAction(param1:Button) : void
      {
         var _loc2_:Object = this._62698418btnAction;
         if(_loc2_ !== param1)
         {
            this._62698418btnAction = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnAction",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnFacial() : Button
      {
         return this._203490248btnFacial;
      }
      
      public function set btnFacial(param1:Button) : void
      {
         var _loc2_:Object = this._203490248btnFacial;
         if(_loc2_ !== param1)
         {
            this._203490248btnFacial = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnFacial",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnHandHeld() : Button
      {
         return this._1780808384btnHandHeld;
      }
      
      public function set btnHandHeld(param1:Button) : void
      {
         var _loc2_:Object = this._1780808384btnHandHeld;
         if(_loc2_ !== param1)
         {
            this._1780808384btnHandHeld = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnHandHeld",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnHeadGear() : Button
      {
         return this._663646731btnHeadGear;
      }
      
      public function set btnHeadGear(param1:Button) : void
      {
         var _loc2_:Object = this._663646731btnHeadGear;
         if(_loc2_ !== param1)
         {
            this._663646731btnHeadGear = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnHeadGear",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnLookAtCamera() : Button
      {
         return this._947794573btnLookAtCamera;
      }
      
      public function set btnLookAtCamera(param1:Button) : void
      {
         var _loc2_:Object = this._947794573btnLookAtCamera;
         if(_loc2_ !== param1)
         {
            this._947794573btnLookAtCamera = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnLookAtCamera",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRemoveHandHeld() : Button
      {
         return this._414434916btnRemoveHandHeld;
      }
      
      public function set btnRemoveHandHeld(param1:Button) : void
      {
         var _loc2_:Object = this._414434916btnRemoveHandHeld;
         if(_loc2_ !== param1)
         {
            this._414434916btnRemoveHandHeld = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRemoveHandHeld",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRemoveHeadGear() : Button
      {
         return this._702726737btnRemoveHeadGear;
      }
      
      public function set btnRemoveHeadGear(param1:Button) : void
      {
         var _loc2_:Object = this._702726737btnRemoveHeadGear;
         if(_loc2_ !== param1)
         {
            this._702726737btnRemoveHeadGear = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRemoveHeadGear",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnRestoreHead() : Button
      {
         return this._1336538514btnRestoreHead;
      }
      
      public function set btnRestoreHead(param1:Button) : void
      {
         var _loc2_:Object = this._1336538514btnRestoreHead;
         if(_loc2_ !== param1)
         {
            this._1336538514btnRestoreHead = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnRestoreHead",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSlide() : Button
      {
         return this._2097113269btnSlide;
      }
      
      public function set btnSlide(param1:Button) : void
      {
         var _loc2_:Object = this._2097113269btnSlide;
         if(_loc2_ !== param1)
         {
            this._2097113269btnSlide = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSlide",_loc2_,param1));
            }
         }
      }
   }
}
