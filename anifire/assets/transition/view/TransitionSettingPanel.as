package anifire.assets.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.command.ChangeDelayCommand;
   import anifire.assets.transition.command.ChangeDestinationCommand;
   import anifire.assets.transition.command.ChangeDirectionCommand;
   import anifire.assets.transition.command.ChangeDurationCommand;
   import anifire.assets.transition.command.ChangeSectionCommand;
   import anifire.assets.transition.command.ChangeSoundModeCommand;
   import anifire.assets.transition.command.ChangeTimingCommand;
   import anifire.assets.transition.command.ChangeTypeCommand;
   import anifire.assets.transition.interfaces.IDestination;
   import anifire.assets.transition.model.AssetTransition;
   import anifire.command.ICommand;
   import anifire.components.studio.ComboBoxTooltipItemRenderer;
   import anifire.components.studio.TimeStepper;
   import anifire.controls.GoToggleButtonBar;
   import anifire.util.UtilDict;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.Form;
   import mx.containers.FormItem;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.ComboBox;
   import mx.controls.Label;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ItemClickEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class TransitionSettingPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _TransitionSettingPanel_FormItem1:FormItem;
      
      public var _TransitionSettingPanel_FormItem2:FormItem;
      
      public var _TransitionSettingPanel_FormItem3:FormItem;
      
      public var _TransitionSettingPanel_Label1:Label;
      
      private var _2097214483btnSound:GoToggleButtonBar;
      
      private var _1021099567cbDestination:DestinationComboBox;
      
      private var _1453364704cbDirection:ComboBox;
      
      private var _212717178cbSection:ComboBox;
      
      private var _25748873cbTiming:ComboBox;
      
      private var _1367553991cbType:ComboBox;
      
      private var _139615182delayStepper:TimeStepper;
      
      private var _45858147durationStepper:TimeStepper;
      
      private var _1300494787messagePanel:VBox;
      
      private var _383827442optionDelay:HBox;
      
      private var _86504745optionDuration:FormItem;
      
      private var _369667686optionSound:FormItem;
      
      private var _502431124settingPanel:Form;
      
      private var _3773vs:ViewStack;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _transition:AssetTransition;
      
      private var _command:ICommand;
      
      mx_internal var _TransitionSettingPanel_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function TransitionSettingPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___TransitionSettingPanel_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"vs",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "height":160,
                        "creationPolicy":"all",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "id":"messagePanel",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TransitionSettingPanel_Label1"
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Form,
                           "id":"settingPanel",
                           "stylesFactory":function():void
                           {
                              this.labelWidth = 58;
                              this.paddingBottom = 0;
                              this.paddingLeft = 0;
                              this.paddingRight = 0;
                              this.paddingTop = 0;
                              this.indicatorGap = 3;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_TransitionSettingPanel_FormItem1",
                                    "stylesFactory":function():void
                                    {
                                       this.labelStyleName = "transitionFormItemLabel";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":HBox,
                                          "stylesFactory":function():void
                                          {
                                             this.verticalAlign = "middle";
                                             this.horizontalGap = 5;
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {"childDescriptors":[new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"cbDirection",
                                                "events":{"change":"__cbDirection_change"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "height":25,
                                                      "width":70,
                                                      "styleName":"cbSidePanel",
                                                      "buttonMode":true
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"cbSection",
                                                "events":{"change":"__cbSection_change"},
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "height":25,
                                                      "width":120,
                                                      "styleName":"cbSidePanel",
                                                      "buttonMode":true
                                                   };
                                                }
                                             })]};
                                          }
                                       })]};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_TransitionSettingPanel_FormItem2",
                                    "stylesFactory":function():void
                                    {
                                       this.labelStyleName = "transitionFormItemLabel";
                                       this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "direction":"horizontal",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.verticalAlign = "middle";
                                                this.horizontalGap = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"childDescriptors":[new UIComponentDescriptor({
                                                   "type":ComboBox,
                                                   "id":"cbTiming",
                                                   "events":{"change":"__cbTiming_change"},
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "height":25,
                                                         "styleName":"cbSidePanel",
                                                         "width":135,
                                                         "buttonMode":true
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":HBox,
                                                   "id":"optionDelay",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.verticalAlign = "middle";
                                                      this.horizontalGap = 0;
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"childDescriptors":[new UIComponentDescriptor({
                                                         "type":Label,
                                                         "stylesFactory":function():void
                                                         {
                                                            this.paddingLeft = 0;
                                                            this.paddingRight = 0;
                                                            this.textAlign = "center";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "text":"+",
                                                               "width":12
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":TimeStepper,
                                                         "id":"delayStepper",
                                                         "events":{"change":"__delayStepper_change"},
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "stepSize":0.25,
                                                               "minimum":0,
                                                               "maximum":10
                                                            };
                                                         }
                                                      })]};
                                                   }
                                                })]};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_TransitionSettingPanel_FormItem3",
                                    "stylesFactory":function():void
                                    {
                                       this.labelStyleName = "transitionFormItemLabel";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "direction":"horizontal",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":ComboBox,
                                             "id":"cbType",
                                             "events":{"change":"__cbType_change"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":25,
                                                   "rowCount":11,
                                                   "width":135,
                                                   "styleName":"cbSidePanel",
                                                   "buttonMode":true,
                                                   "itemRenderer":_TransitionSettingPanel_ClassFactory1_c()
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":DestinationComboBox,
                                             "id":"cbDestination",
                                             "events":{"change":"__cbDestination_change"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":25,
                                                   "rowCount":8,
                                                   "styleName":"cbSidePanel",
                                                   "width":50,
                                                   "buttonMode":true
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"optionDuration",
                                    "stylesFactory":function():void
                                    {
                                       this.labelStyleName = "transitionFormItemLabel";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "direction":"horizontal",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":TimeStepper,
                                             "id":"durationStepper",
                                             "events":{"change":"__durationStepper_change"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "stepSize":0.25,
                                                   "minimum":0.25,
                                                   "maximum":10
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"optionSound",
                                    "stylesFactory":function():void
                                    {
                                       this.labelStyleName = "transitionFormItemLabel";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":GoToggleButtonBar,
                                          "id":"btnSound",
                                          "events":{"itemClick":"__btnSound_itemClick"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"transitionToggleButtonBar",
                                                "selectedButtonColor":"0x2A6994",
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
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._TransitionSettingPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_assets_transition_view_TransitionSettingPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return TransitionSettingPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.addEventListener("creationComplete",this.___TransitionSettingPanel_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         TransitionSettingPanel._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_TransitionSettingPanel_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onCreationComplete() : void
      {
         this.cbType.dataProvider = AssetTransitionConstants.types;
         this.cbDirection.dataProvider = AssetTransitionConstants.directions;
         this.cbTiming.dataProvider = AssetTransitionConstants.timings;
         this.cbSection.dataProvider = AssetTransitionConstants.sections;
         this.cbDestination.dataProvider = AssetTransitionConstants.destinations;
         this.btnSound.dataProvider = AssetTransitionConstants.soundModes;
      }
      
      private function get timings() : Array
      {
         var _loc1_:Array = AssetTransitionConstants.timings;
         if(this._transition)
         {
            if(this._transition.delay == 0)
            {
               _loc1_.push({
                  "id":"addDelay",
                  "label":"+ " + UtilDict.toDisplay("go","Add delay")
               });
            }
            else
            {
               _loc1_.push({
                  "id":"removeDelay",
                  "label":"- " + UtilDict.toDisplay("go","Remove delay")
               });
            }
         }
         return _loc1_;
      }
      
      public function set transition(param1:AssetTransition) : void
      {
         if(this._transition)
         {
            this._transition.removeEventListener(Event.CHANGE,this.onTransitionChange);
         }
         this._transition = param1;
         this.refreshUI();
         if(this._transition)
         {
            this._transition.addEventListener(Event.CHANGE,this.onTransitionChange);
         }
      }
      
      private function onTransitionChange(param1:Event) : void
      {
         this.refreshUI();
      }
      
      public function set types(param1:Array) : void
      {
         if(param1)
         {
            this.cbType.dataProvider = param1;
         }
      }
      
      public function set directions(param1:Array) : void
      {
         if(param1)
         {
            this.cbDirection.dataProvider = param1;
         }
      }
      
      private function refreshUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:ArrayCollection = null;
         var _loc3_:ArrayCollection = null;
         var _loc4_:ArrayCollection = null;
         if(this._transition)
         {
            _loc1_ = 0;
            _loc2_ = this.cbType.dataProvider as ArrayCollection;
            _loc1_ = 0;
            while(_loc1_ < _loc2_.length)
            {
               if(_loc2_[_loc1_].id == this._transition.type)
               {
                  this.cbType.selectedIndex = _loc1_;
                  break;
               }
               _loc1_++;
            }
            _loc3_ = this.cbDirection.dataProvider as ArrayCollection;
            _loc1_ = 0;
            while(_loc1_ < _loc3_.length)
            {
               if(_loc3_[_loc1_].id == this._transition.direction)
               {
                  this.cbDirection.selectedIndex = _loc1_;
                  break;
               }
               _loc1_++;
            }
            _loc4_ = this.btnSound.dataProvider as ArrayCollection;
            _loc1_ = 0;
            while(_loc1_ < _loc4_.length)
            {
               if(_loc4_[_loc1_].id == this._transition.soundMode)
               {
                  this.btnSound.selectedIndex = _loc1_;
                  break;
               }
               _loc1_++;
            }
            this.cbTiming.dataProvider = this.timings;
            _loc1_ = 0;
            while(_loc1_ < AssetTransitionConstants.timings.length)
            {
               if(AssetTransitionConstants.timings[_loc1_].id == this._transition.timing)
               {
                  this.cbTiming.selectedIndex = _loc1_;
                  break;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < AssetTransitionConstants.sections.length)
            {
               if(AssetTransitionConstants.sections[_loc1_].id == this._transition.section)
               {
                  this.cbSection.selectedIndex = _loc1_;
                  break;
               }
               _loc1_++;
            }
            this.optionDuration.visible = this.optionDuration.includeInLayout = true;
            if(this._transition.type == AssetTransitionConstants.TYPE_APPEAR || this._transition.type == AssetTransitionConstants.TYPE_HANDSLIDE)
            {
               this.optionDuration.visible = this.optionDuration.includeInLayout = false;
            }
            this.durationStepper.value = UtilUnitConvert.frameToDuration(this._transition.duration);
            this.optionDelay.visible = this._transition.delay > 0;
            this.delayStepper.value = UtilUnitConvert.frameToDuration(this._transition.delay);
            if(this._transition.setting is IDestination)
            {
               this.cbDestination.reverse = this._transition.direction == AssetTransitionConstants.DIRECTION_IN;
               _loc1_ = 0;
               while(_loc1_ < AssetTransitionConstants.destinations.length)
               {
                  if(AssetTransitionConstants.destinations[_loc1_].id == IDestination(this._transition.setting).destination)
                  {
                     this.cbDestination.selectedIndex = _loc1_;
                     break;
                  }
                  _loc1_++;
               }
               this.cbDestination.visible = this.cbDestination.includeInLayout = true;
            }
            else
            {
               this.cbDestination.visible = this.cbDestination.includeInLayout = false;
            }
            this.vs.selectedChild = this.settingPanel;
         }
         else
         {
            this.vs.selectedChild = this.messagePanel;
         }
      }
      
      private function onTypeChange(param1:ListEvent) : void
      {
         if(this._transition)
         {
            this._command = new ChangeTypeCommand(this._transition,this.cbType.selectedItem.id);
            this._command.execute();
         }
      }
      
      private function onDirectionChange(param1:ListEvent) : void
      {
         if(this._transition)
         {
            this._command = new ChangeDirectionCommand(this._transition,this.cbDirection.selectedItem.id);
            this._command.execute();
         }
      }
      
      private function onSectionChange(param1:ListEvent) : void
      {
         if(this._transition)
         {
            this._command = new ChangeSectionCommand(this._transition,this.cbSection.selectedItem.id);
            this._command.execute();
         }
      }
      
      private function onSoundChange(param1:ItemClickEvent) : void
      {
         if(this._transition)
         {
            this._command = new ChangeSoundModeCommand(this._transition,param1.item.id);
            this._command.execute();
         }
      }
      
      private function onTimingChange(param1:ListEvent) : void
      {
         if(this._transition)
         {
            if(this.cbTiming.selectedItem.id == "addDelay")
            {
               this._command = new ChangeDelayCommand(this._transition,12);
               this._command.execute();
            }
            else if(this.cbTiming.selectedItem.id == "removeDelay")
            {
               this._command = new ChangeDelayCommand(this._transition,0);
               this._command.execute();
            }
            else
            {
               this._command = new ChangeTimingCommand(this._transition,this.cbTiming.selectedItem.id);
               this._command.execute();
            }
         }
      }
      
      private function onDurationChange(param1:Event) : void
      {
         if(this._transition)
         {
            this._command = new ChangeDurationCommand(this._transition,UtilUnitConvert.durationToFrame(this.durationStepper.value));
            this._command.execute();
         }
      }
      
      private function onDelayChange(param1:Event) : void
      {
         if(this._transition)
         {
            this._command = new ChangeDelayCommand(this._transition,UtilUnitConvert.durationToFrame(this.delayStepper.value));
            this._command.execute();
         }
      }
      
      private function onDestinationChange(param1:ListEvent) : void
      {
         if(this._transition)
         {
            this._command = new ChangeDestinationCommand(this._transition,this.cbDestination.selectedItem.id);
            this._command.execute();
         }
      }
      
      public function ___TransitionSettingPanel_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      public function __cbDirection_change(param1:ListEvent) : void
      {
         this.onDirectionChange(param1);
      }
      
      public function __cbSection_change(param1:ListEvent) : void
      {
         this.onSectionChange(param1);
      }
      
      public function __cbTiming_change(param1:ListEvent) : void
      {
         this.onTimingChange(param1);
      }
      
      public function __delayStepper_change(param1:Event) : void
      {
         this.onDelayChange(param1);
      }
      
      private function _TransitionSettingPanel_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = ComboBoxTooltipItemRenderer;
         return _loc1_;
      }
      
      public function __cbType_change(param1:ListEvent) : void
      {
         this.onTypeChange(param1);
      }
      
      public function __cbDestination_change(param1:ListEvent) : void
      {
         this.onDestinationChange(param1);
      }
      
      public function __durationStepper_change(param1:Event) : void
      {
         this.onDurationChange(param1);
      }
      
      public function __btnSound_itemClick(param1:ItemClickEvent) : void
      {
         this.onSoundChange(param1);
      }
      
      private function _TransitionSettingPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","No motion assigned to this asset");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TransitionSettingPanel_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Motion");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TransitionSettingPanel_FormItem1.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","When");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TransitionSettingPanel_FormItem2.label");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Style");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TransitionSettingPanel_FormItem3.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Speed");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"optionDuration.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Sound");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"optionSound.label");
         return result;
      }
      
      mx_internal function _TransitionSettingPanel_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_TransitionSettingPanel_StylesInit_done)
         {
            return;
         }
         mx_internal::_TransitionSettingPanel_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".transitionToggleButtonBar");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".transitionToggleButtonBar",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.selectedButtonTextStyleName = "transitionToggleButtonBarSelectedButtonStyle";
               this.buttonStyleName = "transitionToggleButtonBarButtonStyle";
            };
         }
         style = styleManager.getStyleDeclaration(".transitionToggleButtonBarButtonStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".transitionToggleButtonBarButtonStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.borderColor = 12566463;
               this.color = 2500134;
               this.rollOverColor = 15000804;
               this.textRollOverColor = 16552448;
               this.highlightAlphas = [0,0];
               this.fillColors = [16777215,14342874,16777215,15395562];
               this.disabledColor = 9211020;
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 15000804;
               this.textSelectedColor = 2500134;
            };
         }
         style = styleManager.getStyleDeclaration(".transitionToggleButtonBarSelectedButtonStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".transitionToggleButtonBarSelectedButtonStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16777215;
            };
         }
         style = styleManager.getStyleDeclaration(".transitionFormItemLabel");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".transitionFormItemLabel",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.textAlign = left;
            };
         }
         style = styleManager.getStyleDeclaration(".transitionComboBox");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".transitionComboBox",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderColor = 14342874;
               this.color = 8092539;
               this.highlightAlphas = [0,0];
               this.fillColors = [15395562,15395562,15395562,15395562];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 14342874;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSound() : GoToggleButtonBar
      {
         return this._2097214483btnSound;
      }
      
      public function set btnSound(param1:GoToggleButtonBar) : void
      {
         var _loc2_:Object = this._2097214483btnSound;
         if(_loc2_ !== param1)
         {
            this._2097214483btnSound = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSound",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbDestination() : DestinationComboBox
      {
         return this._1021099567cbDestination;
      }
      
      public function set cbDestination(param1:DestinationComboBox) : void
      {
         var _loc2_:Object = this._1021099567cbDestination;
         if(_loc2_ !== param1)
         {
            this._1021099567cbDestination = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbDestination",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbDirection() : ComboBox
      {
         return this._1453364704cbDirection;
      }
      
      public function set cbDirection(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1453364704cbDirection;
         if(_loc2_ !== param1)
         {
            this._1453364704cbDirection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbDirection",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbSection() : ComboBox
      {
         return this._212717178cbSection;
      }
      
      public function set cbSection(param1:ComboBox) : void
      {
         var _loc2_:Object = this._212717178cbSection;
         if(_loc2_ !== param1)
         {
            this._212717178cbSection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbSection",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbTiming() : ComboBox
      {
         return this._25748873cbTiming;
      }
      
      public function set cbTiming(param1:ComboBox) : void
      {
         var _loc2_:Object = this._25748873cbTiming;
         if(_loc2_ !== param1)
         {
            this._25748873cbTiming = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbTiming",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbType() : ComboBox
      {
         return this._1367553991cbType;
      }
      
      public function set cbType(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1367553991cbType;
         if(_loc2_ !== param1)
         {
            this._1367553991cbType = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbType",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get delayStepper() : TimeStepper
      {
         return this._139615182delayStepper;
      }
      
      public function set delayStepper(param1:TimeStepper) : void
      {
         var _loc2_:Object = this._139615182delayStepper;
         if(_loc2_ !== param1)
         {
            this._139615182delayStepper = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"delayStepper",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get durationStepper() : TimeStepper
      {
         return this._45858147durationStepper;
      }
      
      public function set durationStepper(param1:TimeStepper) : void
      {
         var _loc2_:Object = this._45858147durationStepper;
         if(_loc2_ !== param1)
         {
            this._45858147durationStepper = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"durationStepper",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get messagePanel() : VBox
      {
         return this._1300494787messagePanel;
      }
      
      public function set messagePanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1300494787messagePanel;
         if(_loc2_ !== param1)
         {
            this._1300494787messagePanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"messagePanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get optionDelay() : HBox
      {
         return this._383827442optionDelay;
      }
      
      public function set optionDelay(param1:HBox) : void
      {
         var _loc2_:Object = this._383827442optionDelay;
         if(_loc2_ !== param1)
         {
            this._383827442optionDelay = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"optionDelay",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get optionDuration() : FormItem
      {
         return this._86504745optionDuration;
      }
      
      public function set optionDuration(param1:FormItem) : void
      {
         var _loc2_:Object = this._86504745optionDuration;
         if(_loc2_ !== param1)
         {
            this._86504745optionDuration = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"optionDuration",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get optionSound() : FormItem
      {
         return this._369667686optionSound;
      }
      
      public function set optionSound(param1:FormItem) : void
      {
         var _loc2_:Object = this._369667686optionSound;
         if(_loc2_ !== param1)
         {
            this._369667686optionSound = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"optionSound",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get settingPanel() : Form
      {
         return this._502431124settingPanel;
      }
      
      public function set settingPanel(param1:Form) : void
      {
         var _loc2_:Object = this._502431124settingPanel;
         if(_loc2_ !== param1)
         {
            this._502431124settingPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"settingPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get vs() : ViewStack
      {
         return this._3773vs;
      }
      
      public function set vs(param1:ViewStack) : void
      {
         var _loc2_:Object = this._3773vs;
         if(_loc2_ !== param1)
         {
            this._3773vs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vs",_loc2_,param1));
            }
         }
      }
   }
}
