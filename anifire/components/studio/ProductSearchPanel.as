package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.constant.ProductConstants;
   import anifire.core.PropThumb;
   import anifire.interfaces.IProduct;
   import anifire.products.view.ProductManager;
   import anifire.util.UtilDict;
   import anifire.util.UtilString;
   import anifire.util.UtilUser;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.utils.Proxy;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Accordion;
   import mx.containers.Canvas;
   import mx.containers.Form;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.controls.VRule;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.utils.StringUtil;
   
   use namespace mx_internal;
   
   public class ProductSearchPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _ProductSearchPanel_Form1:Form;
      
      public var _ProductSearchPanel_IconTextButton2:IconTextButton;
      
      public var _ProductSearchPanel_SetProperty1:SetProperty;
      
      private var _1224542155accResults:Accordion;
      
      private var _193269569bgPanel:Canvas;
      
      private var _1309291567bgTileList:ProductThumbPanel;
      
      private var _211157236btnFilter:Canvas;
      
      private var _579312420btnSearch:Button;
      
      private var _496317481btnThemeSelect:IconTextButton;
      
      private var _1282133823fadeIn:Fade;
      
      private var _2119202638handPropPanel:Canvas;
      
      private var _313242882handPropTileList:ProductThumbPanel;
      
      private var _816711803iconHolder:Canvas;
      
      private var _742515615propPanel:Canvas;
      
      private var _72850193propTileList:ProductThumbPanel;
      
      private var _637432609themeSelectPanel:HBox;
      
      private var _94801579themeTileList:ThemeTileList;
      
      private var _881692846txtBgResult:Text;
      
      private var _2096212415txtHandPropResult:Text;
      
      private var _859632177txtKey:TextInput;
      
      private var _1153520624txtPropResult:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _selectedThemeId:String;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function ProductSearchPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Form,
                           "id":"_ProductSearchPanel_Form1",
                           "stylesFactory":function():void
                           {
                              this.paddingBottom = 7;
                              this.paddingLeft = 7;
                              this.paddingRight = 7;
                              this.paddingTop = 7;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "styleName":"navigatorThums",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "childDescriptors":[new UIComponentDescriptor({
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
                                                      "type":TextInput,
                                                      "id":"txtKey",
                                                      "events":{
                                                         "click":"__txtKey_click",
                                                         "focusOut":"__txtKey_focusOut"
                                                      },
                                                      "stylesFactory":function():void
                                                      {
                                                         this.color = 10066329;
                                                         this.textAlign = "left";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"btnFilter",
                                                      "events":{"click":"__btnFilter_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":50,
                                                            "buttonMode":true,
                                                            "includeInLayout":false,
                                                            "visible":false,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":Canvas,
                                                               "id":"iconHolder",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":30,
                                                                     "height":30,
                                                                     "includeInLayout":false,
                                                                     "visible":false
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":IconTextButton,
                                                               "id":"btnThemeSelect",
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.paddingTop = 6;
                                                                  this.paddingLeft = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "maxWidth":50,
                                                                     "verticalCenter":0,
                                                                     "right":0,
                                                                     "styleName":"btnThemeSelect",
                                                                     "toggle":true,
                                                                     "labelPlacement":"left"
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"btnSearch",
                                                      "events":{"click":"__btnSearch_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"btnSearch",
                                                            "buttonMode":true
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
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":HBox,
                                                      "id":"themeSelectPanel",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalAlign = "middle";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":IconTextButton,
                                                               "id":"_ProductSearchPanel_IconTextButton2",
                                                               "events":{"click":"___ProductSearchPanel_IconTextButton2_click"},
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "styleName":"btnImport",
                                                                     "buttonMode":true,
                                                                     "maxWidth":50
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({"type":VRule}),new UIComponentDescriptor({
                                                               "type":ThemeTileList,
                                                               "id":"themeTileList",
                                                               "events":{"itemClick":"__themeTileList_itemClick"}
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
                        }),new UIComponentDescriptor({
                           "type":Accordion,
                           "id":"accResults",
                           "stylesFactory":function():void
                           {
                              this.headerStyleName = "goaccordionHeader";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "styleName":"goAccordion",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"propPanel",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":ProductThumbPanel,
                                             "id":"propTileList",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "columnCount":4,
                                                   "left":7,
                                                   "percentWidth":100
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"txtPropResult",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 10066329;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "verticalCenter":0,
                                                   "horizontalCenter":0,
                                                   "visible":false,
                                                   "maxWidth":200
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"handPropPanel",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":ProductThumbPanel,
                                             "id":"handPropTileList",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "columnCount":4,
                                                   "left":7,
                                                   "percentWidth":100
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"txtHandPropResult",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 10066329;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "verticalCenter":0,
                                                   "horizontalCenter":0,
                                                   "visible":false,
                                                   "maxWidth":200
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"bgPanel",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":ProductThumbPanel,
                                             "id":"bgTileList",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "columnCount":2,
                                                   "left":7,
                                                   "percentWidth":100
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"txtBgResult",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 10066329;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "verticalCenter":0,
                                                   "horizontalCenter":0,
                                                   "visible":false,
                                                   "maxWidth":200
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
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._ProductSearchPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_ProductSearchPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return ProductSearchPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.states = [this._ProductSearchPanel_State1_c()];
         this._ProductSearchPanel_Fade1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         ProductSearchPanel._watcherSetupUtil = param1;
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
      
      public function init(param1:Array) : void
      {
         this.themeTileList.dataProvider = new ArrayCollection(param1);
         this.currentState = "";
         if(UtilUser.hasPlusFeatures())
         {
            this.btnFilter.visible = this.btnFilter.includeInLayout = true;
         }
      }
      
      private function onSearchBtnClick() : void
      {
         this.search(this.keyword);
      }
      
      private function get keyword() : String
      {
         return UtilString.trimBack(StringUtil.trim(this.txtKey.text),"s");
      }
      
      private function filterOtherProp(param1:Object) : Boolean
      {
         var _loc2_:IProduct = param1 as IProduct;
         var _loc3_:RegExp = new RegExp(this.keyword,"i");
         if(_loc2_.enable)
         {
            if(_loc2_ is PropThumb)
            {
               if(PropThumb(_loc2_).holdable || PropThumb(_loc2_).wearable || PropThumb(_loc2_).headable)
               {
                  return false;
               }
               return _loc2_.name.search(_loc3_) > -1 || _loc2_.fileName.search(_loc3_) > -1;
            }
         }
         return false;
      }
      
      private function filterHandProp(param1:Object) : Boolean
      {
         var _loc2_:IProduct = param1 as IProduct;
         var _loc3_:RegExp = new RegExp(this.keyword,"i");
         if(_loc2_.enable)
         {
            if(_loc2_ is PropThumb && PropThumb(_loc2_).holdable)
            {
               return _loc2_.name.search(_loc3_) > -1 || _loc2_.fileName.search(_loc3_) > -1;
            }
         }
         return false;
      }
      
      public function searchProduct(param1:String, param2:String = null) : void
      {
         this.txtKey.text = param1;
         this._selectedThemeId = param2;
         if(this._selectedThemeId)
         {
            this.iconHolder.styleName = "iconTheme" + this._selectedThemeId;
            this.iconHolder.includeInLayout = this.iconHolder.visible = true;
            this.btnThemeSelect.label = "";
         }
         else
         {
            this.themeTileList.selectedItem = null;
            this.iconHolder.includeInLayout = this.iconHolder.visible = false;
            this.btnThemeSelect.label = UtilDict.toDisplay("go","All");
         }
         this.search(param1);
      }
      
      private function search(param1:String) : void
      {
         var _loc2_:ArrayCollection = null;
         var _loc3_:ArrayCollection = null;
         var _loc4_:ArrayCollection = null;
         var _loc5_:ArrayCollection = null;
         if(param1 == null)
         {
            return;
         }
         param1 = StringUtil.trim(param1);
         if(param1 == "" || param1 == UtilDict.toDisplay("go","Enter a keyword here"))
         {
            return;
         }
         _loc2_ = ProductManager.instance.searchProduct(param1,ProductConstants.PRODUCT_TYPE_PROP,this._selectedThemeId);
         _loc2_.filterFunction = this.filterOtherProp;
         _loc2_.refresh();
         this.propTileList.dataProvider = _loc2_;
         this.propPanel.label = UtilDict.toDisplay("go","Other Props") + " (" + String(_loc2_.length) + ")";
         this.txtPropResult.visible = _loc2_.length == 0;
         (_loc4_ = ProductManager.instance.searchProduct(param1,ProductConstants.PRODUCT_TYPE_PROP,this._selectedThemeId)).filterFunction = this.filterHandProp;
         _loc4_.refresh();
         this.handPropTileList.dataProvider = _loc4_;
         this.handPropPanel.label = UtilDict.toDisplay("go","Handheld Props") + " (" + String(_loc4_.length) + ")";
         this.txtHandPropResult.visible = _loc4_.length == 0;
         _loc5_ = ProductManager.instance.searchProduct(param1,ProductConstants.PRODUCT_TYPE_BACKGROUND,this._selectedThemeId);
         this.bgTileList.dataProvider = _loc5_;
         this.bgPanel.label = UtilDict.toDisplay("go","Backgrounds") + " (" + String(_loc5_.length) + ")";
         this.txtBgResult.visible = _loc5_.length == 0;
         this.txtPropResult.text = this.txtHandPropResult.text = this.txtBgResult.text = StringUtil.substitute(UtilDict.toDisplay("go","No result for {0}"),"\'" + param1 + "\'");
         if(_loc2_.length > 0)
         {
            this.accResults.selectedChild = this.propPanel;
         }
         else if(_loc4_.length > 0)
         {
            this.accResults.selectedChild = this.handPropPanel;
         }
         else
         {
            this.accResults.selectedChild = this.bgPanel;
         }
         this.fadeIn.end();
         this.fadeIn.play();
      }
      
      private function onThemeItemClick(param1:ListEvent) : void
      {
         this._selectedThemeId = this.themeTileList.selectedItem.id;
         this.iconHolder.styleName = "iconTheme" + this._selectedThemeId;
         this.iconHolder.includeInLayout = this.iconHolder.visible = true;
         this.btnThemeSelect.label = "";
         this.triggerThemeSelectPanel();
         this.search(this.keyword);
      }
      
      private function onAllBtnClick() : void
      {
         this._selectedThemeId = null;
         this.themeTileList.selectedItem = null;
         this.iconHolder.includeInLayout = this.iconHolder.visible = false;
         this.btnThemeSelect.label = UtilDict.toDisplay("go","All");
         this.triggerThemeSelectPanel();
         this.search(this.keyword);
      }
      
      private function triggerThemeSelectPanel() : void
      {
         if(this.currentState == "themeSelectState")
         {
            this.currentState = "";
            this.btnThemeSelect.selected = false;
         }
         else
         {
            this.currentState = "themeSelectState";
            this.btnThemeSelect.selected = true;
         }
      }
      
      private function onTextInputClick() : void
      {
         if(this.txtKey.text == UtilDict.toDisplay("go","Enter a keyword here"))
         {
            this.txtKey.text = "";
            this.txtKey.setStyle("color","0x000000");
         }
      }
      
      private function onTextInputFocusOut() : void
      {
         if(this.txtKey.text == "")
         {
            this.txtKey.text = UtilDict.toDisplay("go","Enter a keyword here");
            this.txtKey.setStyle("color","0x999999");
         }
      }
      
      private function _ProductSearchPanel_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         this.fadeIn = _loc1_;
         BindingManager.executeBindings(this,"fadeIn",this.fadeIn);
         return _loc1_;
      }
      
      private function _ProductSearchPanel_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "themeSelectState";
         _loc1_.overrides = [this._ProductSearchPanel_SetProperty1_i()];
         return _loc1_;
      }
      
      private function _ProductSearchPanel_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "y";
         _loc1_.value = 0;
         this._ProductSearchPanel_SetProperty1 = _loc1_;
         BindingManager.executeBindings(this,"_ProductSearchPanel_SetProperty1",this._ProductSearchPanel_SetProperty1);
         return _loc1_;
      }
      
      public function __txtKey_click(param1:MouseEvent) : void
      {
         this.onTextInputClick();
      }
      
      public function __txtKey_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputFocusOut();
      }
      
      public function __btnFilter_click(param1:MouseEvent) : void
      {
         this.triggerThemeSelectPanel();
      }
      
      public function __btnSearch_click(param1:MouseEvent) : void
      {
         this.onSearchBtnClick();
      }
      
      public function ___ProductSearchPanel_IconTextButton2_click(param1:MouseEvent) : void
      {
         this.onAllBtnClick();
      }
      
      public function __themeTileList_itemClick(param1:ListEvent) : void
      {
         this.onThemeItemClick(param1);
      }
      
      private function _ProductSearchPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,null,null,"_ProductSearchPanel_Form1.defaultButton","btnSearch");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Enter a keyword here");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"txtKey.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","All");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnThemeSelect.label");
         result[3] = new Binding(this,function():Number
         {
            return -themeSelectPanel.height;
         },null,"themeSelectPanel.y");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","All");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_ProductSearchPanel_IconTextButton2.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Other Props");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"propPanel.label");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Handheld Props");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"handPropPanel.label");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Backgrounds");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"bgPanel.label");
         result[8] = new Binding(this,null,null,"_ProductSearchPanel_SetProperty1.target","themeSelectPanel");
         result[9] = new Binding(this,function():Array
         {
            var _loc1_:* = [propPanel,handPropPanel,bgPanel];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"fadeIn.targets");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get accResults() : Accordion
      {
         return this._1224542155accResults;
      }
      
      public function set accResults(param1:Accordion) : void
      {
         var _loc2_:Object = this._1224542155accResults;
         if(_loc2_ !== param1)
         {
            this._1224542155accResults = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"accResults",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bgPanel() : Canvas
      {
         return this._193269569bgPanel;
      }
      
      public function set bgPanel(param1:Canvas) : void
      {
         var _loc2_:Object = this._193269569bgPanel;
         if(_loc2_ !== param1)
         {
            this._193269569bgPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bgTileList() : ProductThumbPanel
      {
         return this._1309291567bgTileList;
      }
      
      public function set bgTileList(param1:ProductThumbPanel) : void
      {
         var _loc2_:Object = this._1309291567bgTileList;
         if(_loc2_ !== param1)
         {
            this._1309291567bgTileList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgTileList",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnFilter() : Canvas
      {
         return this._211157236btnFilter;
      }
      
      public function set btnFilter(param1:Canvas) : void
      {
         var _loc2_:Object = this._211157236btnFilter;
         if(_loc2_ !== param1)
         {
            this._211157236btnFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSearch() : Button
      {
         return this._579312420btnSearch;
      }
      
      public function set btnSearch(param1:Button) : void
      {
         var _loc2_:Object = this._579312420btnSearch;
         if(_loc2_ !== param1)
         {
            this._579312420btnSearch = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSearch",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnThemeSelect() : IconTextButton
      {
         return this._496317481btnThemeSelect;
      }
      
      public function set btnThemeSelect(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._496317481btnThemeSelect;
         if(_loc2_ !== param1)
         {
            this._496317481btnThemeSelect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnThemeSelect",_loc2_,param1));
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
      public function get handPropPanel() : Canvas
      {
         return this._2119202638handPropPanel;
      }
      
      public function set handPropPanel(param1:Canvas) : void
      {
         var _loc2_:Object = this._2119202638handPropPanel;
         if(_loc2_ !== param1)
         {
            this._2119202638handPropPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"handPropPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get handPropTileList() : ProductThumbPanel
      {
         return this._313242882handPropTileList;
      }
      
      public function set handPropTileList(param1:ProductThumbPanel) : void
      {
         var _loc2_:Object = this._313242882handPropTileList;
         if(_loc2_ !== param1)
         {
            this._313242882handPropTileList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"handPropTileList",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconHolder() : Canvas
      {
         return this._816711803iconHolder;
      }
      
      public function set iconHolder(param1:Canvas) : void
      {
         var _loc2_:Object = this._816711803iconHolder;
         if(_loc2_ !== param1)
         {
            this._816711803iconHolder = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconHolder",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get propPanel() : Canvas
      {
         return this._742515615propPanel;
      }
      
      public function set propPanel(param1:Canvas) : void
      {
         var _loc2_:Object = this._742515615propPanel;
         if(_loc2_ !== param1)
         {
            this._742515615propPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"propPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get propTileList() : ProductThumbPanel
      {
         return this._72850193propTileList;
      }
      
      public function set propTileList(param1:ProductThumbPanel) : void
      {
         var _loc2_:Object = this._72850193propTileList;
         if(_loc2_ !== param1)
         {
            this._72850193propTileList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"propTileList",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeSelectPanel() : HBox
      {
         return this._637432609themeSelectPanel;
      }
      
      public function set themeSelectPanel(param1:HBox) : void
      {
         var _loc2_:Object = this._637432609themeSelectPanel;
         if(_loc2_ !== param1)
         {
            this._637432609themeSelectPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeSelectPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeTileList() : ThemeTileList
      {
         return this._94801579themeTileList;
      }
      
      public function set themeTileList(param1:ThemeTileList) : void
      {
         var _loc2_:Object = this._94801579themeTileList;
         if(_loc2_ !== param1)
         {
            this._94801579themeTileList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeTileList",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtBgResult() : Text
      {
         return this._881692846txtBgResult;
      }
      
      public function set txtBgResult(param1:Text) : void
      {
         var _loc2_:Object = this._881692846txtBgResult;
         if(_loc2_ !== param1)
         {
            this._881692846txtBgResult = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtBgResult",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtHandPropResult() : Text
      {
         return this._2096212415txtHandPropResult;
      }
      
      public function set txtHandPropResult(param1:Text) : void
      {
         var _loc2_:Object = this._2096212415txtHandPropResult;
         if(_loc2_ !== param1)
         {
            this._2096212415txtHandPropResult = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtHandPropResult",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtKey() : TextInput
      {
         return this._859632177txtKey;
      }
      
      public function set txtKey(param1:TextInput) : void
      {
         var _loc2_:Object = this._859632177txtKey;
         if(_loc2_ !== param1)
         {
            this._859632177txtKey = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtKey",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtPropResult() : Text
      {
         return this._1153520624txtPropResult;
      }
      
      public function set txtPropResult(param1:Text) : void
      {
         var _loc2_:Object = this._1153520624txtPropResult;
         if(_loc2_ !== param1)
         {
            this._1153520624txtPropResult = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtPropResult",_loc2_,param1));
            }
         }
      }
   }
}
