package anifire.components.studio
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ThemeConstants;
   import anifire.containers.GradientCanvas;
   import anifire.events.ThemeChosenEvent;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   import caurina.transitions.Tweener;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BevelFilter;
   import flash.filters.DropShadowFilter;
   import flash.utils.Proxy;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
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
   import mx.controls.Spacer;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class ThemeSelection extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _837788416_assetTypeBox:VBox;
      
      private var _1113309525_btnBackground:Button;
      
      private var _1381505911_btnBubble:Button;
      
      private var _1731027309_btnChar:Button;
      
      private var _1730987476_btnDrop:Button;
      
      private var _1309349490_btnEffect:Button;
      
      private var _1730629984_btnProp:Button;
      
      private var _2107234958_btnSound:Button;
      
      private var _2104659746_btnVideo:Button;
      
      private var _297949182_iconsel:Canvas;
      
      private var _91082302_menu:VBox;
      
      private var _1588530801_subBackground:Canvas;
      
      private var _1934207341_subBubble:Canvas;
      
      private var _489180279_subChar:Canvas;
      
      private var _2006363762_subEffect:Canvas;
      
      private var _489577604_subProp:Canvas;
      
      private var _2000276466_subSound:Canvas;
      
      private var _1997701254_subVideo:Canvas;
      
      private var _490429024_submenu:Canvas;
      
      private var _1008523141_themeId:Label;
      
      private var _2106153838bevelFilter:BevelFilter;
      
      private var _1956980552shadowFilter:DropShadowFilter;
      
      private var _2093988956subPanel:HBox;
      
      private var _16849199themeBox1:GradientCanvas;
      
      private var _16849200themeBox2:GradientCanvas;
      
      private var _16849201themeBox3:GradientCanvas;
      
      private var _16849202themeBox4:GradientCanvas;
      
      private var _532178537themeMenu1:VBox;
      
      private var _532178538themeMenu2:VBox;
      
      private var _532178539themeMenu3:VBox;
      
      private var _532178540themeMenu4:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _typeOutOfTheme:UtilHashArray;
      
      private var _typeIntoTheme:UtilHashArray;
      
      private var _currentThemeId:String;
      
      private var _themeList:Object;
      
      private var _timer:Timer;
      
      private var _initialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function ThemeSelection()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "creationComplete":"___ThemeSelection_Canvas1_creationComplete",
               "rollOut":"___ThemeSelection_Canvas1_rollOut",
               "rollOver":"___ThemeSelection_Canvas1_rollOver"
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"_menu",
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":3,
                        "width":187,
                        "horizontalScrollPolicy":"off",
                        "percentHeight":20,
                        "styleName":"themeDropDownList"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":HBox,
                  "id":"subPanel",
                  "stylesFactory":function():void
                  {
                     this.paddingTop = 0;
                     this.paddingBottom = 0;
                     this.horizontalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":190,
                        "styleName":"themeDropDownList",
                        "visible":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":GradientCanvas,
                           "id":"themeBox1",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"themeBoxStyle",
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"themeMenu1",
                                    "stylesFactory":function():void
                                    {
                                       this.paddingBottom = 10;
                                       this.paddingLeft = 10;
                                       this.paddingRight = 10;
                                       this.paddingTop = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"visible":false};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":GradientCanvas,
                           "id":"themeBox2",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"themeBoxStyle",
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"themeMenu2",
                                    "stylesFactory":function():void
                                    {
                                       this.paddingBottom = 10;
                                       this.paddingLeft = 10;
                                       this.paddingRight = 10;
                                       this.paddingTop = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"visible":false};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":GradientCanvas,
                           "id":"themeBox3",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"themeBoxStyle",
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"themeMenu3",
                                    "stylesFactory":function():void
                                    {
                                       this.paddingBottom = 10;
                                       this.paddingLeft = 10;
                                       this.paddingRight = 10;
                                       this.paddingTop = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"visible":false};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":GradientCanvas,
                           "id":"themeBox4",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"themeBoxStyle",
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"themeMenu4",
                                    "stylesFactory":function():void
                                    {
                                       this.paddingBottom = 10;
                                       this.paddingLeft = 10;
                                       this.paddingRight = 10;
                                       this.paddingTop = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"visible":false};
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"_btnDrop",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnThemeDropDown",
                        "buttonMode":true
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "id":"_themeId",
                  "stylesFactory":function():void
                  {
                     this.fontSize = 13;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"btnThemeDropDown",
                        "x":38,
                        "y":9,
                        "maxWidth":140
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_iconsel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "x":10,
                        "y":6,
                        "width":23,
                        "height":23
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_submenu",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":0,
                        "styleName":"themeDropDownList",
                        "scaleX":0.9,
                        "scaleY":0.9,
                        "visible":false,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "id":"_assetTypeBox",
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Canvas,
                                 "id":"_subChar",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":50,
                                       "height":35,
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnChar",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"btnCharSubMenu"};
                                          }
                                       })]
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Canvas,
                                 "id":"_subBubble",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":50,
                                       "height":35,
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnBubble",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"btnBubbleMenu"};
                                          }
                                       })]
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Canvas,
                                 "id":"_subBackground",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":50,
                                       "height":35,
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnBackground",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"btnBackgroundSubMenu"};
                                          }
                                       })]
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Canvas,
                                 "id":"_subProp",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":50,
                                       "height":35,
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnProp",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"btnPropSubMenu"};
                                          }
                                       })]
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Canvas,
                                 "id":"_subSound",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":50,
                                       "height":35,
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnSound",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"btnSoundSubMenu"};
                                          }
                                       })]
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Canvas,
                                 "id":"_subEffect",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":50,
                                       "height":35,
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnEffect",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"btnEffectSubMenu"};
                                          }
                                       })]
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Canvas,
                                 "id":"_subVideo",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":50,
                                       "height":35,
                                       "verticalScrollPolicy":"off",
                                       "horizontalScrollPolicy":"off",
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnVideo",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"btnVideoSubMenu"};
                                          }
                                       })]
                                    };
                                 }
                              })]};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._themeList = {};
         this._timer = new Timer(500,1);
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._ThemeSelection_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_ThemeSelectionWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return ThemeSelection[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.verticalScrollPolicy = "off";
         this._ThemeSelection_BevelFilter1_i();
         this._ThemeSelection_DropShadowFilter1_i();
         this.addEventListener("creationComplete",this.___ThemeSelection_Canvas1_creationComplete);
         this.addEventListener("rollOut",this.___ThemeSelection_Canvas1_rollOut);
         this.addEventListener("rollOver",this.___ThemeSelection_Canvas1_rollOver);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         ThemeSelection._watcherSetupUtil = param1;
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
      
      public function get currentThemeId() : String
      {
         return this._currentThemeId;
      }
      
      private function init() : void
      {
         this._menu.y = -1000;
         this._submenu.y = -1000;
         this._themeId.text = "";
         this._iconsel.removeAllChildren();
         this._typeOutOfTheme = new UtilHashArray();
         this._typeIntoTheme = new UtilHashArray();
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            this._typeOutOfTheme.push("User",[0,1,5,6]);
            this._typeOutOfTheme.push("Comm",[1,4,5]);
         }
         else if(UtilUser.userType == UtilUser.PLUS_USER)
         {
            this._typeOutOfTheme.push("User",[1,5]);
            this._typeOutOfTheme.push("Comm",[1,4,5]);
         }
         else
         {
            this._typeOutOfTheme.push("User",[1]);
            this._typeOutOfTheme.push("Comm",[1,4]);
         }
         if(UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            this._typeOutOfTheme = new UtilHashArray();
            this._typeOutOfTheme.push("User",[1,5,6]);
         }
         this._typeIntoTheme.push("6","User");
         this._btnDrop.addEventListener(MouseEvent.MOUSE_OVER,this.onDropButtonClick);
      }
      
      public function setThemeById(param1:String) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         if(this._themeList[param1] != null)
         {
            this._themeId.text = this._themeList[param1].text;
            this._iconsel.styleName = this._themeList[param1].iconStyle;
            this._currentThemeId = param1;
            if(!this._initialized)
            {
               switch(param1)
               {
                  case ThemeConstants.USER_THEME_ID:
                  case ThemeConstants.COMMUNITY_THEME_ID:
                  case ThumbTray.MOVIE_THEME:
                  case "search":
                  case "more":
                     return;
                  default:
                     _loc2_ = this.getContainerByThemeId(param1);
                     if(_loc2_)
                     {
                        this._menu.addChildAt(_loc2_,0);
                     }
                     this._initialized = true;
               }
            }
         }
      }
      
      public function buildMenu(param1:UtilHashArray, param2:int = 0, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc11_:Canvas = null;
         var _loc12_:Label = null;
         var _loc13_:Canvas = null;
         var _loc14_:Canvas = null;
         var _loc15_:Spacer = null;
         var _loc16_:HRule = null;
         var _loc17_:DisplayObjectContainer = null;
         var _loc5_:Array = new Array();
         var _loc6_:UtilHashArray = new UtilHashArray();
         var _loc7_:Number = param1.length;
         this._themeId.text = param1.getValueByIndex(param2);
         this._iconsel.styleName = "iconTheme" + param1.getKey(param2);
         this._currentThemeId = param1.getKey(param2);
         if(!param3 && !param4)
         {
            this._typeOutOfTheme.push("ben10",[2]);
            this._typeOutOfTheme.push("chowder",[2]);
         }
         _loc6_.push("HRule",UtilDict.toDisplay("go","HRule"));
         param1.insert(param1.length,_loc6_);
         if(UtilUser.hasPlusFeatures())
         {
            _loc6_.push(ThumbTray.MOVIE_THEME,UtilDict.toDisplay("go","In this Video"));
            param1.insert(param1.length,_loc6_);
            this._typeOutOfTheme.push(ThumbTray.MOVIE_THEME,[1,4,6]);
         }
         if(param3)
         {
            _loc6_.push(ThemeConstants.USER_THEME_ID,UtilDict.toDisplay("go","My Library"));
            param1.insert(param1.length,_loc6_);
         }
         if(param4)
         {
            if(UtilSite.siteId == UtilSite.SKOLETUBE)
            {
               _loc6_.push(ThemeConstants.COMMUNITY_THEME_ID,"Skoletubes samling");
            }
            else
            {
               _loc6_.push(ThemeConstants.COMMUNITY_THEME_ID,UtilDict.toDisplay("go","Community Library"));
            }
            param1.insert(param1.length,_loc6_);
         }
         _loc6_.push("search",UtilDict.toDisplay("go","Search Props & Bgs"));
         param1.insert(param1.length,_loc6_);
         if(_loc7_ > 1 && !UtilUser.isTrialAccount)
         {
            _loc6_.push("HRule2",UtilDict.toDisplay("go","HRule"));
            param1.insert(param1.length,_loc6_);
            _loc6_.push("more",UtilDict.toDisplay("go","More Assets..."));
            param1.insert(param1.length,_loc6_);
         }
         var _loc8_:String = "";
         var _loc9_:int = 0;
         while(_loc9_ < param1.length)
         {
            if((_loc8_ = param1.getKey(_loc9_)) == "HRule" || _loc8_ == "HRule2")
            {
               (_loc15_ = new Spacer()).height = 5;
               _loc5_.push(_loc15_);
               (_loc16_ = new HRule()).percentWidth = 100;
               _loc16_.styleName = "themeHRuleStyle";
               _loc5_.push(_loc16_);
               (_loc15_ = new Spacer()).height = 5;
               _loc5_.push(_loc15_);
            }
            else
            {
               _loc11_ = new Canvas();
               _loc12_ = new Label();
               _loc13_ = new Canvas();
               _loc14_ = new Canvas();
               _loc11_.data = {
                  "id":_loc8_,
                  "name":UtilDict.toDisplay("store",param1.getValueByIndex(_loc9_))
               };
               _loc13_.width = _loc13_.height = 23;
               _loc13_.x = 10;
               _loc13_.y = 2;
               _loc13_.styleName = "iconTheme" + _loc8_;
               if(_loc8_ == "more")
               {
                  _loc13_.y = 4;
               }
               if(this._themeList[_loc11_.data.id] == null)
               {
                  this._themeList[_loc11_.data.id] = {
                     "text":_loc11_.data.name,
                     "iconStyle":_loc13_.styleName
                  };
               }
               _loc11_.data.icon = _loc13_.styleName;
               _loc11_.data.icon = _loc13_.styleName;
               _loc12_.mouseChildren = false;
               _loc12_.text = UtilDict.toDisplay("store",param1.getValueByIndex(_loc9_));
               _loc12_.setStyle("fontSize","14");
               _loc12_.setStyle("paddingTop","3");
               _loc12_.x = 36;
               _loc12_.y = 2;
               _loc12_.height = 28;
               _loc12_.percentWidth = 80;
               _loc11_.percentWidth = 100;
               _loc11_.horizontalScrollPolicy = "off";
               _loc11_.height = 28;
               _loc11_.width = 167;
               _loc11_.addChild(_loc14_);
               _loc11_.addChild(_loc13_);
               _loc11_.addChild(_loc12_);
               _loc11_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverTheme);
               _loc11_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutTheme);
               if(_loc8_ != "more")
               {
                  _loc11_.addEventListener(MouseEvent.CLICK,this.onMouseClickTheme);
                  _loc11_.buttonMode = true;
               }
               _loc5_.push(_loc11_);
               _loc14_.name = "bg";
               _loc14_.clipContent = true;
               _loc14_.percentHeight = _loc14_.percentWidth = 100;
               _loc14_.graphics.beginFill(FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".themeDropDownList").getStyle("highlightColor"),1);
               _loc14_.graphics.drawRect(0,0,187,28);
               _loc14_.graphics.endFill();
               _loc14_.visible = false;
            }
            _loc9_++;
         }
         var _loc10_:int = 0;
         while(_loc10_ < _loc5_.length)
         {
            _loc8_ = "";
            if(_loc5_[_loc10_] is Canvas)
            {
               _loc8_ = Canvas(_loc5_[_loc10_]).data.id;
            }
            if(_loc8_ != "")
            {
               if(_loc17_ = this.getContainerByThemeId(_loc8_))
               {
                  _loc17_.visible = true;
                  _loc17_.addChild(_loc5_[_loc10_]);
               }
               else
               {
                  this._menu.addChild(_loc5_[_loc10_]);
               }
            }
            else
            {
               this._menu.addChild(_loc5_[_loc10_]);
            }
            _loc10_++;
         }
      }
      
      private function getContainerByThemeId(param1:String) : DisplayObjectContainer
      {
         switch(param1)
         {
            case ThemeConstants.USER_THEME_ID:
            case ThemeConstants.COMMUNITY_THEME_ID:
            case ThumbTray.MOVIE_THEME:
            case "search":
            case "HRule":
            case "HRule2":
            case "more":
               return this._menu;
            case ThemeConstants.BUSINESS_THEME_ID:
            case ThemeConstants.STICKLY_BIZ_THEME_ID:
            case ThemeConstants.BIZ_MODEL_THEME_ID:
               return this.themeMenu2;
            case ThemeConstants.BOTDF_THEME_ID:
            case ThemeConstants.CHIBI_THEME_ID:
            case ThemeConstants.LIL_PEEPZ_THEME_ID:
            case ThemeConstants.LIL_PETZ_THEME_ID:
            case ThemeConstants.NINJA_THEME_ID:
            case ThemeConstants.SPACE_THEME_ID:
            case ThemeConstants.VIETNAM_THEME_ID:
               return this.themeMenu3;
            case ThemeConstants.CHRISTMAS_THEME_ID:
            case ThemeConstants.MONSTERMSH_THEME_ID:
            case ThemeConstants.POLITIC_THEME_ID:
            case ThemeConstants.RETRO_THEME_ID:
            case ThemeConstants.STICK_THEME_ID:
            case ThemeConstants.STARTREK_THEME_ID:
               return this.themeMenu4;
            default:
               return this.themeMenu1;
         }
      }
      
      private function onMoreBtnRollOver(param1:Event) : void
      {
         this.subPanel.visible = true;
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timer.reset();
         this._timer.start();
      }
      
      private function onTimerComplete(param1:Event) : void
      {
         this.hideMenu();
      }
      
      private function onMouseClickTheme(param1:Event) : void
      {
         var _loc2_:Object = Canvas(param1.currentTarget).data;
         this.setThemeById(_loc2_["id"]);
         this.hideMenu();
         var _loc3_:ThemeChosenEvent = new ThemeChosenEvent(ThemeChosenEvent.THEME_CHOSEN,this);
         _loc3_.themeId = _loc2_["id"];
         _loc3_.assetType = AnimeConstants.ASSET_TYPE_CHAR;
         dispatchEvent(_loc3_);
      }
      
      private function onMouseOverTheme(param1:Event) : void
      {
         var _loc7_:Button = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc2_:Canvas = Canvas(param1.currentTarget);
         var _loc3_:Canvas = Canvas(_loc2_.getChildByName("bg"));
         var _loc4_:Object = Canvas(param1.currentTarget).data;
         this.highlightThemeItem(_loc4_["id"]);
         if(String(_loc4_["id"]) == "search")
         {
            this._submenu.visible = false;
         }
         else if(String(_loc4_["id"]) == "more")
         {
            this.subPanel.visible = true;
            return;
         }
         this._submenu.x = this._menu.width;
         this._submenu.y = _loc2_.y + this._menu.y;
         if(this._submenu.y + this._submenu.height >= this.height)
         {
            this._submenu.y = this._menu.y + this._menu.height - this._submenu.height;
         }
         if(this._submenu.y < 0)
         {
            this._submenu.y = 0;
         }
         var _loc5_:Number = this._assetTypeBox.numChildren;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = Button(Canvas(this._assetTypeBox.getChildAt(_loc6_)).getChildAt(0));
            Canvas(this._assetTypeBox.getChildAt(_loc6_)).height = 5;
            _loc8_ = this._typeOutOfTheme.getValueByKey(String(_loc4_["id"]));
            _loc9_ = this._typeIntoTheme.getValueByKey(String(_loc6_));
            if(_loc8_ != null && (_loc8_ as Array).indexOf(_loc6_) > -1 || _loc9_ != null && _loc9_ != String(_loc4_["id"]))
            {
               Canvas(this._assetTypeBox.getChildAt(_loc6_)).height = 0;
            }
            else
            {
               Canvas(this._assetTypeBox.getChildAt(_loc6_)).height = 35;
               _loc7_.x = (_loc7_.parent.width - _loc7_.width) / 2;
               _loc7_.y = (_loc7_.parent.height - _loc7_.height) / 2;
               _loc7_.buttonMode = true;
               _loc7_.data = _loc4_;
               _loc7_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverType);
               _loc7_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutType);
               _loc7_.addEventListener(MouseEvent.CLICK,this.onMouseDownType);
            }
            _loc6_++;
         }
      }
      
      private function onMouseOutTheme(param1:Event) : void
      {
         var _loc2_:Canvas = Canvas(param1.currentTarget);
         var _loc3_:Canvas = Canvas(_loc2_.getChildByName("bg"));
         _loc3_.visible = false;
      }
      
      private function onMouseOverType(param1:Event) : void
      {
         var _loc2_:Object = Button(param1.currentTarget).data;
         var _loc3_:String = _loc2_["id"];
         var _loc4_:Canvas;
         (_loc4_ = Canvas(Button(param1.currentTarget).parent)).graphics.beginFill(FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".themeDropDownList").getStyle("highlightColor"));
         _loc4_.graphics.drawRect(0,0,_loc4_.width,_loc4_.height);
         _loc4_.graphics.endFill();
         this.highlightThemeItem(_loc3_);
      }
      
      private function onMouseOutType(param1:Event) : void
      {
         var _loc2_:Object = Button(param1.currentTarget).data;
         var _loc3_:String = _loc2_["id"];
         var _loc4_:Canvas;
         (_loc4_ = Canvas(Button(param1.currentTarget).parent)).graphics.clear();
         this.highlightThemeItem(_loc3_);
      }
      
      private function onMouseDownType(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc2_:Object = Button(param1.currentTarget).data;
         this.setThemeById(_loc2_["id"]);
         this.hideMenu();
         var _loc3_:ThemeChosenEvent = new ThemeChosenEvent(ThemeChosenEvent.THEME_CHOSEN,this);
         _loc3_.themeId = _loc2_["id"];
         switch(param1.currentTarget)
         {
            case this._btnChar:
               _loc4_ = AnimeConstants.ASSET_TYPE_CHAR;
               break;
            case this._btnBubble:
               _loc4_ = AnimeConstants.ASSET_TYPE_BUBBLE;
               break;
            case this._btnBackground:
               _loc4_ = AnimeConstants.ASSET_TYPE_BG;
               break;
            case this._btnProp:
               _loc4_ = AnimeConstants.ASSET_TYPE_PROP;
               break;
            case this._btnSound:
               _loc4_ = AnimeConstants.ASSET_TYPE_SOUND;
               break;
            case this._btnEffect:
               _loc4_ = AnimeConstants.ASSET_TYPE_FX;
               break;
            case this._btnVideo:
               _loc4_ = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
         }
         _loc3_.assetType = _loc4_;
         dispatchEvent(_loc3_);
      }
      
      private function showMenu() : void
      {
         Tweener.addTween(this._menu,{
            "y":this._btnDrop.height,
            "time":0.5
         });
      }
      
      private function hideMenu() : void
      {
         Tweener.addTween(this._menu,{
            "y":-this._menu.height - 10,
            "time":0.5
         });
         this.subPanel.visible = false;
      }
      
      private function onDropButtonClick(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            if(this._menu.y < 0)
            {
               this.showMenu();
            }
         }
      }
      
      private function highlightThemeItem(param1:String) : void
      {
         var _loc2_:Canvas = null;
         var _loc3_:Canvas = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < this._menu.numChildren)
         {
            if(this._menu.getChildAt(_loc5_) is Canvas)
            {
               _loc2_ = Canvas(this._menu.getChildAt(_loc5_));
               _loc3_ = Canvas(_loc2_.getChildByName("bg"));
               _loc3_.visible = false;
               if((_loc4_ = Canvas(_loc2_).data)["id"] == param1)
               {
                  _loc3_.visible = true;
               }
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.themeMenu1.numChildren)
         {
            if(this.themeMenu1.getChildAt(_loc5_) is Canvas)
            {
               _loc2_ = Canvas(this.themeMenu1.getChildAt(_loc5_));
               _loc3_ = Canvas(_loc2_.getChildByName("bg"));
               _loc3_.visible = false;
               if((_loc4_ = Canvas(_loc2_).data)["id"] == param1)
               {
                  _loc3_.visible = true;
               }
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.themeMenu2.numChildren)
         {
            if(this.themeMenu2.getChildAt(_loc5_) is Canvas)
            {
               _loc2_ = Canvas(this.themeMenu2.getChildAt(_loc5_));
               _loc3_ = Canvas(_loc2_.getChildByName("bg"));
               _loc3_.visible = false;
               if((_loc4_ = Canvas(_loc2_).data)["id"] == param1)
               {
                  _loc3_.visible = true;
               }
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.themeMenu3.numChildren)
         {
            if(this.themeMenu3.getChildAt(_loc5_) is Canvas)
            {
               _loc2_ = Canvas(this.themeMenu3.getChildAt(_loc5_));
               _loc3_ = Canvas(_loc2_.getChildByName("bg"));
               _loc3_.visible = false;
               if((_loc4_ = Canvas(_loc2_).data)["id"] == param1)
               {
                  _loc3_.visible = true;
               }
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this.themeMenu4.numChildren)
         {
            if(this.themeMenu4.getChildAt(_loc5_) is Canvas)
            {
               _loc2_ = Canvas(this.themeMenu4.getChildAt(_loc5_));
               _loc3_ = Canvas(_loc2_.getChildByName("bg"));
               _loc3_.visible = false;
               if((_loc4_ = Canvas(_loc2_).data)["id"] == param1)
               {
                  _loc3_.visible = true;
               }
            }
            _loc5_++;
         }
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         this._timer.stop();
      }
      
      private function _ThemeSelection_BevelFilter1_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         this.bevelFilter = _loc1_;
         BindingManager.executeBindings(this,"bevelFilter",this.bevelFilter);
         return _loc1_;
      }
      
      private function _ThemeSelection_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.distance = 2;
         _loc1_.alpha = 0.8;
         _loc1_.color = 3355443;
         _loc1_.blurX = 2;
         _loc1_.blurY = 2;
         this.shadowFilter = _loc1_;
         BindingManager.executeBindings(this,"shadowFilter",this.shadowFilter);
         return _loc1_;
      }
      
      public function ___ThemeSelection_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___ThemeSelection_Canvas1_rollOut(param1:MouseEvent) : void
      {
         this.onRollOut(param1);
      }
      
      public function ___ThemeSelection_Canvas1_rollOver(param1:MouseEvent) : void
      {
         this.onRollOver(param1);
      }
      
      private function _ThemeSelection_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return this._btnDrop.height;
         },null,"_menu.y");
         result[1] = new Binding(this,function():Array
         {
            var _loc1_:* = [shadowFilter];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"_menu.filters");
         result[2] = new Binding(this,function():Number
         {
            return Math.max(0,_menu.y + _menu.height - subPanel.height);
         },null,"subPanel.y");
         result[3] = new Binding(this,function():Array
         {
            var _loc1_:* = [shadowFilter];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"subPanel.filters");
         result[4] = new Binding(this,function():Boolean
         {
            return themeMenu1.visible;
         },null,"themeBox1.includeInLayout");
         result[5] = new Binding(this,function():Boolean
         {
            return themeMenu1.visible;
         },null,"themeBox1.visible");
         result[6] = new Binding(this,function():Boolean
         {
            return themeMenu2.visible;
         },null,"themeBox2.includeInLayout");
         result[7] = new Binding(this,function():Boolean
         {
            return themeMenu2.visible;
         },null,"themeBox2.visible");
         result[8] = new Binding(this,function():Boolean
         {
            return themeMenu3.visible;
         },null,"themeBox3.includeInLayout");
         result[9] = new Binding(this,function():Boolean
         {
            return themeMenu3.visible;
         },null,"themeBox3.visible");
         result[10] = new Binding(this,function():Boolean
         {
            return themeMenu4.visible;
         },null,"themeBox4.includeInLayout");
         result[11] = new Binding(this,function():Boolean
         {
            return themeMenu4.visible;
         },null,"themeBox4.visible");
         result[12] = new Binding(this,function():Number
         {
            return this._menu.width * 2 + this._menu.x;
         },null,"_submenu.x");
         result[13] = new Binding(this,function():Array
         {
            var _loc1_:* = [shadowFilter];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"_submenu.filters");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _assetTypeBox() : VBox
      {
         return this._837788416_assetTypeBox;
      }
      
      public function set _assetTypeBox(param1:VBox) : void
      {
         var _loc2_:Object = this._837788416_assetTypeBox;
         if(_loc2_ !== param1)
         {
            this._837788416_assetTypeBox = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_assetTypeBox",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBackground() : Button
      {
         return this._1113309525_btnBackground;
      }
      
      public function set _btnBackground(param1:Button) : void
      {
         var _loc2_:Object = this._1113309525_btnBackground;
         if(_loc2_ !== param1)
         {
            this._1113309525_btnBackground = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBackground",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBubble() : Button
      {
         return this._1381505911_btnBubble;
      }
      
      public function set _btnBubble(param1:Button) : void
      {
         var _loc2_:Object = this._1381505911_btnBubble;
         if(_loc2_ !== param1)
         {
            this._1381505911_btnBubble = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBubble",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnChar() : Button
      {
         return this._1731027309_btnChar;
      }
      
      public function set _btnChar(param1:Button) : void
      {
         var _loc2_:Object = this._1731027309_btnChar;
         if(_loc2_ !== param1)
         {
            this._1731027309_btnChar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnChar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDrop() : Button
      {
         return this._1730987476_btnDrop;
      }
      
      public function set _btnDrop(param1:Button) : void
      {
         var _loc2_:Object = this._1730987476_btnDrop;
         if(_loc2_ !== param1)
         {
            this._1730987476_btnDrop = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDrop",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEffect() : Button
      {
         return this._1309349490_btnEffect;
      }
      
      public function set _btnEffect(param1:Button) : void
      {
         var _loc2_:Object = this._1309349490_btnEffect;
         if(_loc2_ !== param1)
         {
            this._1309349490_btnEffect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEffect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnProp() : Button
      {
         return this._1730629984_btnProp;
      }
      
      public function set _btnProp(param1:Button) : void
      {
         var _loc2_:Object = this._1730629984_btnProp;
         if(_loc2_ !== param1)
         {
            this._1730629984_btnProp = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnProp",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSound() : Button
      {
         return this._2107234958_btnSound;
      }
      
      public function set _btnSound(param1:Button) : void
      {
         var _loc2_:Object = this._2107234958_btnSound;
         if(_loc2_ !== param1)
         {
            this._2107234958_btnSound = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSound",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnVideo() : Button
      {
         return this._2104659746_btnVideo;
      }
      
      public function set _btnVideo(param1:Button) : void
      {
         var _loc2_:Object = this._2104659746_btnVideo;
         if(_loc2_ !== param1)
         {
            this._2104659746_btnVideo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnVideo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _iconsel() : Canvas
      {
         return this._297949182_iconsel;
      }
      
      public function set _iconsel(param1:Canvas) : void
      {
         var _loc2_:Object = this._297949182_iconsel;
         if(_loc2_ !== param1)
         {
            this._297949182_iconsel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_iconsel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _menu() : VBox
      {
         return this._91082302_menu;
      }
      
      public function set _menu(param1:VBox) : void
      {
         var _loc2_:Object = this._91082302_menu;
         if(_loc2_ !== param1)
         {
            this._91082302_menu = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_menu",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subBackground() : Canvas
      {
         return this._1588530801_subBackground;
      }
      
      public function set _subBackground(param1:Canvas) : void
      {
         var _loc2_:Object = this._1588530801_subBackground;
         if(_loc2_ !== param1)
         {
            this._1588530801_subBackground = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subBackground",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subBubble() : Canvas
      {
         return this._1934207341_subBubble;
      }
      
      public function set _subBubble(param1:Canvas) : void
      {
         var _loc2_:Object = this._1934207341_subBubble;
         if(_loc2_ !== param1)
         {
            this._1934207341_subBubble = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subBubble",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subChar() : Canvas
      {
         return this._489180279_subChar;
      }
      
      public function set _subChar(param1:Canvas) : void
      {
         var _loc2_:Object = this._489180279_subChar;
         if(_loc2_ !== param1)
         {
            this._489180279_subChar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subChar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subEffect() : Canvas
      {
         return this._2006363762_subEffect;
      }
      
      public function set _subEffect(param1:Canvas) : void
      {
         var _loc2_:Object = this._2006363762_subEffect;
         if(_loc2_ !== param1)
         {
            this._2006363762_subEffect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subEffect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subProp() : Canvas
      {
         return this._489577604_subProp;
      }
      
      public function set _subProp(param1:Canvas) : void
      {
         var _loc2_:Object = this._489577604_subProp;
         if(_loc2_ !== param1)
         {
            this._489577604_subProp = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subProp",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subSound() : Canvas
      {
         return this._2000276466_subSound;
      }
      
      public function set _subSound(param1:Canvas) : void
      {
         var _loc2_:Object = this._2000276466_subSound;
         if(_loc2_ !== param1)
         {
            this._2000276466_subSound = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subSound",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _subVideo() : Canvas
      {
         return this._1997701254_subVideo;
      }
      
      public function set _subVideo(param1:Canvas) : void
      {
         var _loc2_:Object = this._1997701254_subVideo;
         if(_loc2_ !== param1)
         {
            this._1997701254_subVideo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subVideo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _submenu() : Canvas
      {
         return this._490429024_submenu;
      }
      
      public function set _submenu(param1:Canvas) : void
      {
         var _loc2_:Object = this._490429024_submenu;
         if(_loc2_ !== param1)
         {
            this._490429024_submenu = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_submenu",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _themeId() : Label
      {
         return this._1008523141_themeId;
      }
      
      public function set _themeId(param1:Label) : void
      {
         var _loc2_:Object = this._1008523141_themeId;
         if(_loc2_ !== param1)
         {
            this._1008523141_themeId = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_themeId",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bevelFilter() : BevelFilter
      {
         return this._2106153838bevelFilter;
      }
      
      public function set bevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._2106153838bevelFilter;
         if(_loc2_ !== param1)
         {
            this._2106153838bevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shadowFilter() : DropShadowFilter
      {
         return this._1956980552shadowFilter;
      }
      
      public function set shadowFilter(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._1956980552shadowFilter;
         if(_loc2_ !== param1)
         {
            this._1956980552shadowFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shadowFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get subPanel() : HBox
      {
         return this._2093988956subPanel;
      }
      
      public function set subPanel(param1:HBox) : void
      {
         var _loc2_:Object = this._2093988956subPanel;
         if(_loc2_ !== param1)
         {
            this._2093988956subPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"subPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeBox1() : GradientCanvas
      {
         return this._16849199themeBox1;
      }
      
      public function set themeBox1(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._16849199themeBox1;
         if(_loc2_ !== param1)
         {
            this._16849199themeBox1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeBox1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeBox2() : GradientCanvas
      {
         return this._16849200themeBox2;
      }
      
      public function set themeBox2(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._16849200themeBox2;
         if(_loc2_ !== param1)
         {
            this._16849200themeBox2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeBox2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeBox3() : GradientCanvas
      {
         return this._16849201themeBox3;
      }
      
      public function set themeBox3(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._16849201themeBox3;
         if(_loc2_ !== param1)
         {
            this._16849201themeBox3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeBox3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeBox4() : GradientCanvas
      {
         return this._16849202themeBox4;
      }
      
      public function set themeBox4(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._16849202themeBox4;
         if(_loc2_ !== param1)
         {
            this._16849202themeBox4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeBox4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeMenu1() : VBox
      {
         return this._532178537themeMenu1;
      }
      
      public function set themeMenu1(param1:VBox) : void
      {
         var _loc2_:Object = this._532178537themeMenu1;
         if(_loc2_ !== param1)
         {
            this._532178537themeMenu1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeMenu1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeMenu2() : VBox
      {
         return this._532178538themeMenu2;
      }
      
      public function set themeMenu2(param1:VBox) : void
      {
         var _loc2_:Object = this._532178538themeMenu2;
         if(_loc2_ !== param1)
         {
            this._532178538themeMenu2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeMenu2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeMenu3() : VBox
      {
         return this._532178539themeMenu3;
      }
      
      public function set themeMenu3(param1:VBox) : void
      {
         var _loc2_:Object = this._532178539themeMenu3;
         if(_loc2_ !== param1)
         {
            this._532178539themeMenu3 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeMenu3",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeMenu4() : VBox
      {
         return this._532178540themeMenu4;
      }
      
      public function set themeMenu4(param1:VBox) : void
      {
         var _loc2_:Object = this._532178540themeMenu4;
         if(_loc2_ !== param1)
         {
            this._532178540themeMenu4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeMenu4",_loc2_,param1));
            }
         }
      }
   }
}
