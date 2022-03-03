package anifire.assets.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.command.RemoveTransitionCommand;
   import anifire.assets.transition.model.AssetTransition;
   import anifire.assets.transition.model.AssetTransitionCollection;
   import anifire.command.ICommand;
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.BubbleAsset;
   import anifire.core.Console;
   import anifire.core.sound.SoundEvent;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.ISceneModel;
   import anifire.scene.view.AbstractSceneView;
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.Label;
   import mx.controls.List;
   import mx.controls.Spacer;
   import mx.core.IFlexModuleFactory;
   import mx.core.INavigatorContent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.CollectionEvent;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class AssetTransitionPanel extends AbstractSceneView implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _AssetTransitionPanel_Button1:Button;
      
      public var _AssetTransitionPanel_Button2:Button;
      
      public var _AssetTransitionPanel_Button3:Button;
      
      public var _AssetTransitionPanel_HBox2:HBox;
      
      public var _AssetTransitionPanel_HBox3:HBox;
      
      public var _AssetTransitionPanel_HBox4:HBox;
      
      public var _AssetTransitionPanel_Label1:Label;
      
      public var _AssetTransitionPanel_Label2:Label;
      
      public var _AssetTransitionPanel_Label3:Label;
      
      public var _AssetTransitionPanel_Label4:Label;
      
      public var _AssetTransitionPanel_VBox4:VBox;
      
      private var _11548545buttonBar:HBox;
      
      private var _1407502692listAfterNarration:TransitionList;
      
      private var _168074853listBeforeNarration:TransitionList;
      
      private var _238069118listWithNarration:TransitionList;
      
      private var _265437237mainPanel:VBox;
      
      private var _1300494787messagePanel:VBox;
      
      private var _502431124settingPanel:TransitionSettingPanel;
      
      private var _1987987025transitionPanel:VBox;
      
      private var _3773vs:ViewStack;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _assetTransitions:AssetTransitionCollection;
      
      private var _selectedTransition:AssetTransition;
      
      private var _command:ICommand;
      
      mx_internal var _AssetTransitionPanel_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function AssetTransitionPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":AbstractSceneView,
            "events":{"creationComplete":"___AssetTransitionPanel_AbstractSceneView1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"transitionPanel",
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":ViewStack,
                           "id":"vs",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "height":160,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":TransitionSettingPanel,
                                    "id":"settingPanel",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
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
                                             "id":"_AssetTransitionPanel_Label1"
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_AssetTransitionPanel_Button1",
                                             "events":{"click":"___AssetTransitionPanel_Button1_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "buttonMode":true,
                                                   "styleName":"btnAddVoice",
                                                   "minWidth":100
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
                           "id":"mainPanel",
                           "stylesFactory":function():void
                           {
                              this.backgroundColor = 4473924;
                              this.paddingBottom = 0;
                              this.paddingLeft = 0;
                              this.paddingRight = 0;
                              this.paddingTop = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"buttonBar",
                                    "stylesFactory":function():void
                                    {
                                       this.paddingRight = 10;
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
                                             "id":"_AssetTransitionPanel_Button2",
                                             "events":{"click":"___AssetTransitionPanel_Button2_click"},
                                             "stylesFactory":function():void
                                             {
                                                this.fontWeight = "bold";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"+",
                                                   "buttonMode":true,
                                                   "styleName":"cbSidePanel",
                                                   "height":18,
                                                   "width":35
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_AssetTransitionPanel_Button3",
                                             "events":{"click":"___AssetTransitionPanel_Button3_click"},
                                             "stylesFactory":function():void
                                             {
                                                this.fontWeight = "bold";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"-",
                                                   "buttonMode":true,
                                                   "styleName":"cbSidePanel",
                                                   "height":18,
                                                   "width":35
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_AssetTransitionPanel_VBox4",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":HBox,
                                             "id":"_AssetTransitionPanel_HBox2",
                                             "stylesFactory":function():void
                                             {
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 10;
                                                this.paddingRight = 10;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":HRule,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.strokeWidth = 1;
                                                         this.strokeColor = 6710886;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_AssetTransitionPanel_Label2",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.color = 6710886;
                                                         this.fontFamily = "Arial";
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":HRule,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.strokeWidth = 1;
                                                         this.strokeColor = 6710886;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":TransitionList,
                                             "id":"listBeforeNarration",
                                             "events":{"itemClick":"__listBeforeNarration_itemClick"}
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "id":"_AssetTransitionPanel_HBox3",
                                             "stylesFactory":function():void
                                             {
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 10;
                                                this.paddingRight = 10;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":HRule,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.strokeWidth = 1;
                                                         this.strokeColor = 6710886;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_AssetTransitionPanel_Label3",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.color = 6710886;
                                                         this.fontFamily = "Arial";
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":HRule,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.strokeWidth = 1;
                                                         this.strokeColor = 6710886;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":TransitionList,
                                             "id":"listWithNarration",
                                             "events":{"itemClick":"__listWithNarration_itemClick"}
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "id":"_AssetTransitionPanel_HBox4",
                                             "stylesFactory":function():void
                                             {
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 10;
                                                this.paddingRight = 10;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":HRule,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.strokeWidth = 1;
                                                         this.strokeColor = 6710886;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_AssetTransitionPanel_Label4",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.color = 6710886;
                                                         this.fontFamily = "Arial";
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":HRule,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.strokeWidth = 1;
                                                         this.strokeColor = 6710886;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":TransitionList,
                                             "id":"listAfterNarration",
                                             "events":{"itemClick":"__listAfterNarration_itemClick"}
                                          })]
                                       };
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
         var bindings:Array = this._AssetTransitionPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_assets_transition_view_AssetTransitionPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return AssetTransitionPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.addEventListener("creationComplete",this.___AssetTransitionPanel_AbstractSceneView1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         AssetTransitionPanel._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_AssetTransitionPanel_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      override protected function addEventListeners(param1:IEventDispatcher) : void
      {
         if(param1 is ISceneModel)
         {
            ISceneModel(param1).selection.addEventListener(Event.CHANGE,this.onAssetSelectionChange);
         }
         if(this._assetTransitions)
         {
            this._assetTransitions.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onTransitionsChange);
         }
         Console.getConsole().linkageController.eventDispatcher.addEventListener(SoundEvent.UPDATED,this.onSoundUpdate);
      }
      
      override protected function removeEventListeners(param1:IEventDispatcher) : void
      {
         if(param1 is ISceneModel)
         {
            ISceneModel(param1).selection.removeEventListener(Event.CHANGE,this.onAssetSelectionChange);
         }
         if(this._assetTransitions)
         {
            this._assetTransitions.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.onTransitionsChange);
         }
         Console.getConsole().linkageController.eventDispatcher.removeEventListener(SoundEvent.UPDATED,this.onSoundUpdate);
      }
      
      override protected function unloadAllAssets() : void
      {
         this.listBeforeNarration.dataProvider = null;
         this.listWithNarration.dataProvider = null;
         this.listAfterNarration.dataProvider = null;
         this._assetTransitions = null;
         this.selectedTransition = null;
      }
      
      override protected function loadAllAssets() : void
      {
         if(this.sceneModel is AnimeScene)
         {
            this._assetTransitions = AnimeScene(this.sceneModel).assetTransitions;
            this.listBeforeNarration.dataProvider = this._assetTransitions.collectionBeforeNarration;
            this.listWithNarration.dataProvider = this._assetTransitions.collectionWithNarration;
            this.listAfterNarration.dataProvider = this._assetTransitions.collectionAfterNarration;
            this.refreshUI();
         }
      }
      
      private function onTransitionsChange(param1:Event) : void
      {
         this.refreshUI();
         this.highlightItem(this._selectedTransition);
      }
      
      private function highlightItem(param1:AssetTransition) : void
      {
         this.listBeforeNarration.selectedItem = null;
         this.listWithNarration.selectedItem = null;
         this.listAfterNarration.selectedItem = null;
         var _loc2_:List = this.getList(param1);
         _loc2_.selectedItem = param1;
         if(_loc2_.selectedIndex != -1)
         {
            _loc2_.scrollToIndex(_loc2_.selectedIndex);
         }
      }
      
      private function refreshUI() : void
      {
         var _loc1_:Boolean = false;
         if(this._assetTransitions)
         {
            _loc1_ = false;
            if(Console.getConsole().speechManager.getSpeech(AnimeScene(this.sceneModel)) != null || this._assetTransitions.collectionWithNarration.length > 0 || this._assetTransitions.collectionAfterNarration.length > 0)
            {
               _loc1_ = true;
            }
            this.listWithNarration.includeInLayout = this.listWithNarration.visible = _loc1_;
            this.listAfterNarration.includeInLayout = this.listAfterNarration.visible = _loc1_;
            this.settingPanel.cbSection.visible = _loc1_;
         }
      }
      
      private function onItemClick(param1:ListEvent) : void
      {
         var _loc3_:AnimeScene = null;
         var _loc2_:AssetTransition = param1.itemRenderer.data as AssetTransition;
         if(_loc2_)
         {
            _loc3_ = this.sceneModel as AnimeScene;
            _loc3_.selectedAsset = _loc3_.getAssetById(_loc2_.assetId);
            Console.getConsole().showControl();
            this.selectedTransition = _loc2_;
         }
      }
      
      private function onRemoveClick() : void
      {
         var _loc2_:IIterator = null;
         var _loc3_:AssetTransition = null;
         var _loc1_:AssetTransition = this._selectedTransition;
         if(_loc1_ && this._assetTransitions)
         {
            this._command = new RemoveTransitionCommand(_loc1_,this._assetTransitions);
            this._command.execute();
            this.selectedTransition = null;
            _loc2_ = this._assetTransitions.iterator();
            while(_loc2_.hasNext)
            {
               _loc3_ = _loc2_.next as AssetTransition;
               if(_loc3_ && _loc3_.assetId == _loc1_.assetId)
               {
                  this.selectedTransition = _loc3_;
                  break;
               }
            }
         }
      }
      
      private function set selectedTransition(param1:AssetTransition) : void
      {
         this._selectedTransition = param1;
         this.highlightItem(param1);
         this.settingPanel.types = this.getTypes(param1);
         this.settingPanel.directions = this.getDirections(param1);
         this.settingPanel.transition = param1;
         this.vs.selectedChild = param1 != null ? this.settingPanel : this.messagePanel;
      }
      
      private function onAddClick() : void
      {
         var _loc1_:Asset = null;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:AssetTransition = null;
         if(this.sceneModel)
         {
            _loc1_ = this.sceneModel.selection.selectedAsset as Asset;
            if(_loc1_ && this._assetTransitions)
            {
               _loc3_ = getQualifiedClassName(_loc1_).split("::");
               if(_loc3_)
               {
                  _loc2_ = _loc3_[1];
               }
               if(_loc4_ = this._assetTransitions.addNew(_loc1_.id,_loc2_))
               {
                  this.selectedTransition = _loc4_;
               }
            }
         }
      }
      
      private function onAssetSelectionChange(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:IIterator = null;
         var _loc4_:AssetTransition = null;
         if(this.sceneModel && this.sceneModel.selection.selectedAsset)
         {
            if(this._selectedTransition && this._selectedTransition.assetId == this.sceneModel.selection.selectedAsset.id)
            {
               return;
            }
            this.selectedTransition = null;
            _loc2_ = new Array();
            _loc3_ = this._assetTransitions.iterator();
            while(_loc3_.hasNext)
            {
               if((_loc4_ = _loc3_.next as AssetTransition) && _loc4_.assetId == this.sceneModel.selection.selectedAsset.id)
               {
                  this.selectedTransition = _loc4_;
                  break;
               }
            }
         }
      }
      
      private function getList(param1:AssetTransition) : List
      {
         if(param1)
         {
            switch(param1.section)
            {
               case AssetTransitionConstants.TIMING_BEFORE_NARRATION:
                  return this.listBeforeNarration;
               case AssetTransitionConstants.TIMING_WITH_NARRATION:
                  return this.listWithNarration;
               case AssetTransitionConstants.TIMING_AFTER_NARRATION:
                  return this.listAfterNarration;
            }
         }
         return this.listBeforeNarration;
      }
      
      private function getDirections(param1:AssetTransition) : Array
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:IIterator = null;
         var _loc6_:AssetTransition = null;
         var _loc2_:Array = AssetTransitionConstants.directions;
         if(param1)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = this._assetTransitions.iterator();
            while(_loc5_.hasNext)
            {
               if((_loc6_ = _loc5_.next as AssetTransition) && _loc6_.assetId == param1.assetId && _loc6_ != param1)
               {
                  if(_loc6_.direction == AssetTransitionConstants.DIRECTION_IN)
                  {
                     _loc3_++;
                  }
                  else
                  {
                     _loc4_++;
                  }
                  break;
               }
            }
            if(_loc3_ == 1)
            {
               _loc2_.splice(0,1);
            }
            else if(_loc4_ == 1)
            {
               _loc2_.splice(1,1);
            }
         }
         return _loc2_;
      }
      
      private function getTypes(param1:AssetTransition) : Array
      {
         var _loc3_:AnimeScene = null;
         var _loc4_:Asset = null;
         var _loc2_:Array = AssetTransitionConstants.types;
         if(param1)
         {
            _loc3_ = this.sceneModel as AnimeScene;
            if((_loc4_ = _loc3_.getAssetById(param1.assetId)) is BubbleAsset)
            {
               _loc2_ = _loc2_.concat(AssetTransitionConstants.textTypes);
            }
         }
         _loc2_ = _loc2_.concat(AssetTransitionConstants.spriteTypes);
         _loc2_.sortOn("label");
         return _loc2_;
      }
      
      protected function onCreationComplete(param1:FlexEvent) : void
      {
      }
      
      private function onSoundUpdate(param1:SoundEvent) : void
      {
         if(this.sceneModel is AnimeScene && param1.sceneId == AnimeScene(this.sceneModel).id)
         {
            this.refreshUI();
         }
      }
      
      public function ___AssetTransitionPanel_AbstractSceneView1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      public function ___AssetTransitionPanel_Button1_click(param1:MouseEvent) : void
      {
         this.onAddClick();
      }
      
      public function ___AssetTransitionPanel_Button2_click(param1:MouseEvent) : void
      {
         this.onAddClick();
      }
      
      public function ___AssetTransitionPanel_Button3_click(param1:MouseEvent) : void
      {
         this.onRemoveClick();
      }
      
      public function __listBeforeNarration_itemClick(param1:ListEvent) : void
      {
         this.onItemClick(param1);
      }
      
      public function __listWithNarration_itemClick(param1:ListEvent) : void
      {
         this.onItemClick(param1);
      }
      
      public function __listAfterNarration_itemClick(param1:ListEvent) : void
      {
         this.onItemClick(param1);
      }
      
      private function _AssetTransitionPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","No Entrance/Exit assigned to this asset");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetTransitionPanel_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = "+ " + UtilDict.toDisplay("go","Add");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetTransitionPanel_Button1.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add motion");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetTransitionPanel_Button2.toolTip");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Remove motion");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetTransitionPanel_Button3.toolTip");
         result[4] = new Binding(this,function():Number
         {
            return this.height - vs.height - 40;
         },null,"_AssetTransitionPanel_VBox4.height");
         result[5] = new Binding(this,function():Boolean
         {
            return listWithNarration.visible;
         },null,"_AssetTransitionPanel_HBox2.visible");
         result[6] = new Binding(this,function():Boolean
         {
            return listWithNarration.includeInLayout;
         },null,"_AssetTransitionPanel_HBox2.includeInLayout");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","before narration");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetTransitionPanel_Label2.text");
         result[8] = new Binding(this,function():Boolean
         {
            return listWithNarration.visible;
         },null,"_AssetTransitionPanel_HBox3.visible");
         result[9] = new Binding(this,function():Boolean
         {
            return listWithNarration.includeInLayout;
         },null,"_AssetTransitionPanel_HBox3.includeInLayout");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","with narration");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetTransitionPanel_Label3.text");
         result[11] = new Binding(this,function():Boolean
         {
            return listAfterNarration.visible;
         },null,"_AssetTransitionPanel_HBox4.visible");
         result[12] = new Binding(this,function():Boolean
         {
            return listAfterNarration.includeInLayout;
         },null,"_AssetTransitionPanel_HBox4.includeInLayout");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","after narration");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetTransitionPanel_Label4.text");
         return result;
      }
      
      mx_internal function _AssetTransitionPanel_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_AssetTransitionPanel_StylesInit_done)
         {
            return;
         }
         mx_internal::_AssetTransitionPanel_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".myListStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".myListStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderColor = 4473924;
               this.backgroundColor = 4473924;
               this.rollOverColor = 932450;
               this.selectionColor = 932450;
               this.themeColor = 4473924;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get buttonBar() : HBox
      {
         return this._11548545buttonBar;
      }
      
      public function set buttonBar(param1:HBox) : void
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
      public function get listAfterNarration() : TransitionList
      {
         return this._1407502692listAfterNarration;
      }
      
      public function set listAfterNarration(param1:TransitionList) : void
      {
         var _loc2_:Object = this._1407502692listAfterNarration;
         if(_loc2_ !== param1)
         {
            this._1407502692listAfterNarration = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"listAfterNarration",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get listBeforeNarration() : TransitionList
      {
         return this._168074853listBeforeNarration;
      }
      
      public function set listBeforeNarration(param1:TransitionList) : void
      {
         var _loc2_:Object = this._168074853listBeforeNarration;
         if(_loc2_ !== param1)
         {
            this._168074853listBeforeNarration = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"listBeforeNarration",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get listWithNarration() : TransitionList
      {
         return this._238069118listWithNarration;
      }
      
      public function set listWithNarration(param1:TransitionList) : void
      {
         var _loc2_:Object = this._238069118listWithNarration;
         if(_loc2_ !== param1)
         {
            this._238069118listWithNarration = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"listWithNarration",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainPanel() : VBox
      {
         return this._265437237mainPanel;
      }
      
      public function set mainPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._265437237mainPanel;
         if(_loc2_ !== param1)
         {
            this._265437237mainPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainPanel",_loc2_,param1));
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
      public function get settingPanel() : TransitionSettingPanel
      {
         return this._502431124settingPanel;
      }
      
      public function set settingPanel(param1:TransitionSettingPanel) : void
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
      public function get transitionPanel() : VBox
      {
         return this._1987987025transitionPanel;
      }
      
      public function set transitionPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1987987025transitionPanel;
         if(_loc2_ !== param1)
         {
            this._1987987025transitionPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"transitionPanel",_loc2_,param1));
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
