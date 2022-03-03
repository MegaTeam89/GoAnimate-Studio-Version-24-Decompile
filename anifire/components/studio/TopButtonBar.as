package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.events.SelectedAreaEvent;
   import anifire.managers.*;
   import anifire.timeline.SceneLengthController;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilUser;
   import com.adobe.images.JPGEncoder;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.controls.Menu;
   import mx.controls.VRule;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.ToolTipManager;
   import mx.states.AddChild;
   import mx.states.RemoveChild;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class TopButtonBar extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _TopButtonBar_AddChild1:AddChild;
      
      public var _TopButtonBar_AddChild2:AddChild;
      
      public var _TopButtonBar_IconTextButton2:IconTextButton;
      
      public var _TopButtonBar_IconTextButton3:IconTextButton;
      
      public var _TopButtonBar_RemoveChild1:RemoveChild;
      
      public var _TopButtonBar_RemoveChild2:RemoveChild;
      
      public var _TopButtonBar_RemoveChild3:RemoveChild;
      
      public var _TopButtonBar_SetProperty1:SetProperty;
      
      public var _TopButtonBar_SetProperty2:SetProperty;
      
      public var _TopButtonBar_SetProperty3:SetProperty;
      
      private var _2116813633_btnIdeas:Button;
      
      private var _938620689_btnMoreMenu:IconTextButton;
      
      private var _419384469_btnPreview:Button;
      
      private var _938173362_btnRecord:Button;
      
      private var _1730556742_btnSave:Button;
      
      private var _1899870462_container:HBox;
      
      private var _1336746749_maskCanvas:Canvas;
      
      private var _1463663725_vRule:VRule;
      
      private var _1097545472dpMoreMenu:XML;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _738130066iconMore:Class;
      
      private var _1300184823iconNewMovie:Class;
      
      private var _1896998209iconScreenshot:Class;
      
      private var _1411229853iconIdeas:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function TopButtonBar()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___TopButtonBar_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "id":"_container",
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "middle";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"topControlBar",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "id":"_btnRecord",
                           "events":{"click":"___btnRecord_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "visible":false,
                                 "includeInLayout":false,
                                 "styleName":"btnRecord",
                                 "buttonMode":true,
                                 "labelPlacement":"right",
                                 "enabled":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_btnIdeas",
                           "events":{"click":"___btnIdeas_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnScript",
                                 "buttonMode":true,
                                 "labelPlacement":"right"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_btnPreview",
                           "events":{"click":"___btnPreview_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "maxWidth":100,
                                 "styleName":"btnPreview",
                                 "buttonMode":true,
                                 "labelPlacement":"right"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_btnSave",
                           "events":{"click":"___btnSave_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "maxWidth":90,
                                 "styleName":"btnSave",
                                 "buttonMode":true,
                                 "labelPlacement":"right"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VRule,
                           "id":"_vRule",
                           "propertiesFactory":function():Object
                           {
                              return {"height":12};
                           }
                        }),new UIComponentDescriptor({
                           "type":IconTextButton,
                           "id":"_btnMoreMenu",
                           "events":{"click":"___btnMoreMenu_click"},
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"btnMore"};
                           }
                        })]
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
                        "percentWidth":100,
                        "percentHeight":100,
                        "alpha":0,
                        "visible":false
                     };
                  }
               })]};
            }
         });
         this._738130066iconMore = TopButtonBar_iconMore;
         this._1300184823iconNewMovie = TopButtonBar_iconNewMovie;
         this._1896998209iconScreenshot = TopButtonBar_iconScreenshot;
         this._1411229853iconIdeas = TopButtonBar_iconIdeas;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._TopButtonBar_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_TopButtonBarWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return TopButtonBar[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.states = [this._TopButtonBar_State1_c(),this._TopButtonBar_State2_c(),this._TopButtonBar_State3_c(),this._TopButtonBar_State4_c(),this._TopButtonBar_State5_c()];
         this._TopButtonBar_XML1_i();
         this.addEventListener("creationComplete",this.___TopButtonBar_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         TopButtonBar._watcherSetupUtil = param1;
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
      
      public function set stageQuality(param1:String) : void
      {
      }
      
      public function setLoadingStatus(param1:Boolean) : void
      {
         this._maskCanvas.visible = param1;
      }
      
      private function init() : void
      {
         ToolTipManager.showDelay = 200;
         if(!FeatureManager.shouldThemeColorBeSwitchable)
         {
            delete this.dpMoreMenu.menuitem.(attribute("id") == "color_theme")[0];
         }
         if(!UtilUser.hasPlusFeatures() || UtilUser.isTrialAccount)
         {
            delete this.dpMoreMenu.menuitem.(attribute("id") == "save_template")[0];
         }
         if(!UtilUser.hasBusinessFeatures)
         {
            delete this.dpMoreMenu.menuitem.(attribute("id") == "snapping")[0];
         }
      }
      
      private function openInspiration(param1:Event) : void
      {
         Console.getConsole().showInspirationWindow();
      }
      
      private function clickNewAnimationButton(param1:MouseEvent) : void
      {
         Console.getConsole().removeGuideBubbles();
         Console.getConsole().doNewAnimation();
      }
      
      private function captureMainStage() : void
      {
         Util.gaTracking("/gostudio/screenCapture",this.stage);
         var _loc1_:MainStage = Console.getConsole().mainStage;
         var _loc2_:Canvas = Console.getConsole().mainStage._stageArea;
         Console.getConsole().currentScene.selectedAsset = null;
         Console.getConsole().screenCapTool.addEventListener(SelectedAreaEvent.AREA_SELECTED,this.onSelectedCaptureArea);
         if(UtilUser.userType == UtilUser.ADMIN_USER)
         {
            Console.getConsole().screenCapTool.show(0,0,FlexGlobals.topLevelApplication.width,FlexGlobals.topLevelApplication.height);
         }
         else
         {
            Console.getConsole().screenCapTool.show(_loc1_.x + _loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
         }
      }
      
      private function onSelectedCaptureArea(param1:SelectedAreaEvent) : void
      {
         var _loc5_:BitmapData = null;
         var _loc10_:FileReference = null;
         var _loc11_:JPGEncoder = null;
         var _loc12_:ByteArray = null;
         var _loc13_:URLRequest = null;
         Console.getConsole().screenCapTool.removeEventListener(SelectedAreaEvent.AREA_SELECTED,this.onSelectedCaptureArea);
         var _loc2_:Point = param1.startPt;
         var _loc3_:Point = param1.endPt;
         var _loc4_:Stage = FlexGlobals.topLevelApplication.stage;
         var _loc6_:Matrix = new Matrix();
         var _loc7_:Number = 85;
         var _loc8_:Number = 2;
         if(UtilUser.userType == UtilUser.ADMIN_USER)
         {
            _loc7_ = 95;
            _loc8_ = 10;
         }
         var _loc9_:String = this.stage.quality;
         if(Math.abs(_loc3_.x - _loc2_.x) * Math.abs(_loc3_.y - _loc2_.y) < 100)
         {
            if(AnimeConstants.SCREEN_WIDTH * _loc8_ <= 2880 && AnimeConstants.SCREEN_HEIGHT * _loc8_ <= 2880)
            {
               _loc5_ = new BitmapData(AnimeConstants.SCREEN_WIDTH * _loc8_,AnimeConstants.screenHeight * _loc8_);
               _loc6_.translate(-AnimeConstants.SCREEN_X,-AnimeConstants.screenY);
               _loc6_.scale(_loc8_,_loc8_);
               this.stage.quality = StageQuality.BEST;
               _loc5_.draw(Console.getConsole().mainStage.sceneEditor.view.view,_loc6_);
            }
         }
         else if(Math.abs(_loc3_.x - _loc2_.x) * _loc8_ <= 2880 && Math.abs(_loc3_.y - _loc2_.y) * _loc8_ <= 2880)
         {
            _loc5_ = new BitmapData(Math.abs(_loc3_.x - _loc2_.x) * _loc8_,Math.abs(_loc3_.y - _loc2_.y) * _loc8_);
            _loc6_.translate(-_loc2_.x + _loc4_.x,-_loc2_.y + _loc4_.y);
            _loc6_.scale(_loc8_,_loc8_);
            this.stage.quality = StageQuality.BEST;
            _loc5_.draw(_loc4_,_loc6_);
         }
         this.stage.quality = _loc9_;
         if(_loc5_)
         {
            _loc10_ = new FileReference();
            _loc12_ = (_loc11_ = new JPGEncoder(_loc7_)).encode(_loc5_);
            if(UtilUser.hasBizFeatures)
            {
               _loc10_.save(_loc12_,"screen.jpg");
            }
            else
            {
               _loc13_ = UtilNetwork.getSaveJpegReuqest("screen.jpg",_loc12_);
               _loc10_.download(_loc13_);
            }
         }
      }
      
      private function onMoreMenuItemClick(param1:MenuEvent) : void
      {
         var so:SharedObject = null;
         var e:MenuEvent = param1;
         var id:String = e.item.@id;
         var flashVar:UtilHashArray = Util.getFlashVar();
         var tlang:String = flashVar.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE);
         try
         {
            so = SharedObject.getLocal("studioPreferences");
         }
         catch(e:Error)
         {
            so = null;
         }
         if(id == "screenshot")
         {
            this.captureMainStage();
         }
         else if(id == "new_movie")
         {
            this.clickNewAnimationButton(null);
         }
         else if(id == "ideas")
         {
            this.openInspiration(null);
         }
         else if(id == "low_quality")
         {
            this.stage.quality = StageQuality.LOW;
            if(so)
            {
               so.data.stageQuality = StageQuality.LOW;
            }
         }
         else if(id == "medium_quality")
         {
            this.stage.quality = StageQuality.MEDIUM;
            if(so)
            {
               so.data.stageQuality = StageQuality.MEDIUM;
            }
         }
         else if(id == "high_quality")
         {
            this.stage.quality = StageQuality.HIGH;
            if(so)
            {
               so.data.stageQuality = StageQuality.HIGH;
            }
         }
         else if(id == "best_quality")
         {
            this.stage.quality = StageQuality.BEST;
            if(so)
            {
               so.data.stageQuality = StageQuality.BEST;
            }
         }
         else if(id == "dark_theme" || id == "light_theme")
         {
            Util.changeClientTheming(e.item.@themeCode,tlang,"go_full",this.onClientThemeLoaded);
            if(so)
            {
               so.data.clientThemeCode = String(e.item.@themeCode);
            }
         }
         else if(id == SceneLengthController.FULL_AUTO)
         {
            Console.getConsole().updateScLnCtrlPerf(SceneLengthController.FULL_AUTO);
            if(so)
            {
               so.data.sceneLengthAdjustment = SceneLengthController.FULL_AUTO;
            }
         }
         else if(id == SceneLengthController.ONLY_LENGTHEN)
         {
            Console.getConsole().updateScLnCtrlPerf(SceneLengthController.ONLY_LENGTHEN);
            if(so)
            {
               so.data.sceneLengthAdjustment = SceneLengthController.ONLY_LENGTHEN;
            }
         }
         else if(id == SceneLengthController.FULL_MANUAL)
         {
            Console.getConsole().updateScLnCtrlPerf(SceneLengthController.FULL_MANUAL);
            if(so)
            {
               so.data.sceneLengthAdjustment = SceneLengthController.FULL_MANUAL;
            }
         }
         else if(id == "current_scene")
         {
            Console.getConsole().showSaveTemplateWindow(false);
         }
         else if(id == "whole_movie")
         {
            Console.getConsole().showSaveTemplateWindow(true);
         }
         else if(id == "snapObjects")
         {
            Console.getConsole().sceneController.toggleSnapMode(id);
         }
         else if(id == "snapCamera")
         {
            Console.getConsole().sceneController.toggleSnapMode(id);
         }
         else if(id == "snapOldPosition")
         {
            Console.getConsole().sceneController.toggleSnapMode(id);
         }
         try
         {
            if(so)
            {
               so.flush();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onClientThemeLoaded(param1:Event) : void
      {
         Console.getConsole().thumbTray.resetTabIcon();
      }
      
      private function showMoreMenu(param1:MouseEvent) : void
      {
         var node:XML = null;
         var e:MouseEvent = param1;
         var quality:String = this.stage.quality;
         if(quality)
         {
            node = this.dpMoreMenu..menuitem.(attribute("value") == quality.toLowerCase())[0];
            if(node)
            {
               node.@toggled = "true";
            }
         }
         var myMenu:Menu = Menu.createMenu(this,this.dpMoreMenu,false);
         myMenu.labelField = "@label";
         myMenu.buttonMode = true;
         myMenu.addEventListener(MenuEvent.ITEM_CLICK,this.onMoreMenuItemClick);
         myMenu.show(e.stageX - 130,e.stageY + 12);
      }
      
      private function onSaveBtnClick() : void
      {
         Console.getConsole().showPublishWindow();
      }
      
      private function _TopButtonBar_XML1_i() : XML
      {
         var _loc1_:XML = <menuitem label="" icon="iconMore"><menuitem id="screenshot" icon="iconScreenshot"></menuitem><menuitem><menuitem id="low_quality" type="radio" groupName="quality" toggled=""></menuitem><menuitem id="medium_quality" type="radio" groupName="quality" toggled=""></menuitem><menuitem id="high_quality" type="radio" groupName="quality" toggled=""></menuitem></menuitem><menuitem id="save_template"><menuitem id="current_scene" value="scene"></menuitem><menuitem id="whole_movie" value="movie"></menuitem></menuitem><menuitem id="snapping"><menuitem id="snapObjects" toggled="true" type="check"></menuitem><menuitem id="snapCamera" toggled="true" type="check"></menuitem></menuitem></menuitem>;
         this.dpMoreMenu = _loc1_;
         BindingManager.executeBindings(this,"dpMoreMenu",this.dpMoreMenu);
         return _loc1_;
      }
      
      private function _TopButtonBar_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "autoSave";
         _loc1_.overrides = [this._TopButtonBar_SetProperty1_i()];
         return _loc1_;
      }
      
      private function _TopButtonBar_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "label";
         this._TopButtonBar_SetProperty1 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_SetProperty1",this._TopButtonBar_SetProperty1);
         return _loc1_;
      }
      
      private function _TopButtonBar_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "simple";
         return _loc1_;
      }
      
      private function _TopButtonBar_State3_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "cn";
         _loc1_.basedOn = "simple";
         _loc1_.overrides = [this._TopButtonBar_SetProperty2_i(),this._TopButtonBar_SetProperty3_i(),this._TopButtonBar_AddChild1_i(),this._TopButtonBar_RemoveChild1_i(),this._TopButtonBar_RemoveChild2_i(),this._TopButtonBar_RemoveChild3_i()];
         return _loc1_;
      }
      
      private function _TopButtonBar_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         this._TopButtonBar_SetProperty2 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_SetProperty2",this._TopButtonBar_SetProperty2);
         return _loc1_;
      }
      
      private function _TopButtonBar_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         this._TopButtonBar_SetProperty3 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_SetProperty3",this._TopButtonBar_SetProperty3);
         return _loc1_;
      }
      
      private function _TopButtonBar_AddChild1_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         _loc1_.position = "firstChild";
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._TopButtonBar_IconTextButton2_i);
         this._TopButtonBar_AddChild1 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_AddChild1",this._TopButtonBar_AddChild1);
         return _loc1_;
      }
      
      private function _TopButtonBar_IconTextButton2_i() : IconTextButton
      {
         var _loc1_:IconTextButton = new IconTextButton();
         _loc1_.styleName = "btnNew";
         _loc1_.buttonMode = true;
         _loc1_.labelPlacement = "bottom";
         _loc1_.addEventListener("click",this.___TopButtonBar_IconTextButton2_click);
         _loc1_.id = "_TopButtonBar_IconTextButton2";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._TopButtonBar_IconTextButton2 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_IconTextButton2",this._TopButtonBar_IconTextButton2);
         return _loc1_;
      }
      
      public function ___TopButtonBar_IconTextButton2_click(param1:MouseEvent) : void
      {
         this.clickNewAnimationButton(param1);
      }
      
      private function _TopButtonBar_RemoveChild1_i() : RemoveChild
      {
         var _loc1_:RemoveChild = new RemoveChild();
         this._TopButtonBar_RemoveChild1 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_RemoveChild1",this._TopButtonBar_RemoveChild1);
         return _loc1_;
      }
      
      private function _TopButtonBar_RemoveChild2_i() : RemoveChild
      {
         var _loc1_:RemoveChild = new RemoveChild();
         this._TopButtonBar_RemoveChild2 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_RemoveChild2",this._TopButtonBar_RemoveChild2);
         return _loc1_;
      }
      
      private function _TopButtonBar_RemoveChild3_i() : RemoveChild
      {
         var _loc1_:RemoveChild = new RemoveChild();
         this._TopButtonBar_RemoveChild3 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_RemoveChild3",this._TopButtonBar_RemoveChild3);
         return _loc1_;
      }
      
      private function _TopButtonBar_State4_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "domo";
         _loc1_.basedOn = "cn";
         _loc1_.overrides = [this._TopButtonBar_AddChild2_i()];
         return _loc1_;
      }
      
      private function _TopButtonBar_AddChild2_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         _loc1_.position = "firstChild";
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._TopButtonBar_IconTextButton3_i);
         this._TopButtonBar_AddChild2 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_AddChild2",this._TopButtonBar_AddChild2);
         return _loc1_;
      }
      
      private function _TopButtonBar_IconTextButton3_i() : IconTextButton
      {
         var _loc1_:IconTextButton = new IconTextButton();
         _loc1_.styleName = "btnScreenShot";
         _loc1_.buttonMode = true;
         _loc1_.labelPlacement = "bottom";
         _loc1_.addEventListener("click",this.___TopButtonBar_IconTextButton3_click);
         _loc1_.id = "_TopButtonBar_IconTextButton3";
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         this._TopButtonBar_IconTextButton3 = _loc1_;
         BindingManager.executeBindings(this,"_TopButtonBar_IconTextButton3",this._TopButtonBar_IconTextButton3);
         return _loc1_;
      }
      
      public function ___TopButtonBar_IconTextButton3_click(param1:MouseEvent) : void
      {
         this.captureMainStage();
      }
      
      private function _TopButtonBar_State5_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "emessage";
         _loc1_.basedOn = "simple";
         return _loc1_;
      }
      
      public function ___TopButtonBar_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___btnRecord_click(param1:MouseEvent) : void
      {
      }
      
      public function ___btnIdeas_click(param1:MouseEvent) : void
      {
         Console.getConsole().showInspirationWindow();
      }
      
      public function ___btnPreview_click(param1:MouseEvent) : void
      {
         Console.getConsole().preview();
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.onSaveBtnClick();
      }
      
      public function ___btnMoreMenu_click(param1:MouseEvent) : void
      {
         this.showMoreMenu(param1);
      }
      
      private function _TopButtonBar_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Record");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnRecord.toolTip");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Record");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnRecord.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Script Ideas");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnIdeas.toolTip");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Script Ideas");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnIdeas.label");
         result[4] = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldIdeaButtonBeShown;
         },null,"_btnIdeas.visible");
         result[5] = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldIdeaButtonBeShown;
         },null,"_btnIdeas.includeInLayout");
         result[6] = new Binding(this,function():Boolean
         {
            return UtilLicense.isInspirationButtonShouldBeShown();
         },null,"_btnIdeas.enabled");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_preview");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnPreview.toolTip");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Preview");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnPreview.label");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_savenshare");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSave.toolTip");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Save");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSave.label");
         result[11] = new Binding(this,function():Boolean
         {
            return Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) != "1";
         },null,"_btnSave.enabled");
         result[12] = new Binding(this,null,null,"_TopButtonBar_SetProperty1.target","_btnSave");
         result[13] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Auto-Saving");
         },null,"_TopButtonBar_SetProperty1.value");
         result[14] = new Binding(this,null,null,"_TopButtonBar_SetProperty2.target","_btnPreview");
         result[15] = new Binding(this,null,null,"_TopButtonBar_SetProperty3.target","_btnSave");
         result[16] = new Binding(this,null,null,"_TopButtonBar_AddChild1.relativeTo","_container");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_new");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TopButtonBar_IconTextButton2.toolTip");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","New");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TopButtonBar_IconTextButton2.label");
         result[19] = new Binding(this,null,null,"_TopButtonBar_RemoveChild1.target","_btnRecord");
         result[20] = new Binding(this,null,null,"_TopButtonBar_RemoveChild2.target","_vRule");
         result[21] = new Binding(this,null,null,"_TopButtonBar_RemoveChild3.target","_btnMoreMenu");
         result[22] = new Binding(this,null,null,"_TopButtonBar_AddChild2.relativeTo","_container");
         result[23] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_screenshot");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TopButtonBar_IconTextButton3.toolTip");
         result[24] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Screenshot");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TopButtonBar_IconTextButton3.label");
         result[25] = new Binding(this,function():Boolean
         {
            return UtilLicense.isScreenShotAbilityEnabled(UtilLicense.getCurrentLicenseId());
         },null,"_TopButtonBar_IconTextButton3.visible");
         result[26] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","topbtnbar_screenshot");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[0]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[0].@ns1::label");
         result[27] = new Binding(this,function():*
         {
            return UtilLicense.isScreenShotAbilityEnabled(UtilLicense.getCurrentLicenseId());
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[0]._loc2_::@enabled = param1;
         },"dpMoreMenu.menuitem[0].@ns1::enabled");
         result[28] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Quality");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[1]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[1].@ns1::label");
         result[29] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Low");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[1].menuitem[0]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[1].menuitem[0].@ns1::label");
         result[30] = new Binding(this,function():*
         {
            return StageQuality.LOW;
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[1].menuitem[0]._loc2_::@value = param1;
         },"dpMoreMenu.menuitem[1].menuitem[0].@ns1::value");
         result[31] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Medium");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[1].menuitem[1]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[1].menuitem[1].@ns1::label");
         result[32] = new Binding(this,function():*
         {
            return StageQuality.MEDIUM;
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[1].menuitem[1]._loc2_::@value = param1;
         },"dpMoreMenu.menuitem[1].menuitem[1].@ns1::value");
         result[33] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","High");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[1].menuitem[2]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[1].menuitem[2].@ns1::label");
         result[34] = new Binding(this,function():*
         {
            return StageQuality.HIGH;
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[1].menuitem[2]._loc2_::@value = param1;
         },"dpMoreMenu.menuitem[1].menuitem[2].@ns1::value");
         result[35] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Save As Template");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[2]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[2].@ns1::label");
         result[36] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Current Scene");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[2].menuitem[0]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[2].menuitem[0].@ns1::label");
         result[37] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Whole Movie");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[2].menuitem[1]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[2].menuitem[1].@ns1::label");
         result[38] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Snapping");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[3]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[3].@ns1::label");
         result[39] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Snap to objects");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[3].menuitem[0]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[3].menuitem[0].@ns1::label");
         result[40] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Snap to camera");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            dpMoreMenu.menuitem[3].menuitem[1]._loc2_::@label = param1;
         },"dpMoreMenu.menuitem[3].menuitem[1].@ns1::label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnIdeas() : Button
      {
         return this._2116813633_btnIdeas;
      }
      
      public function set _btnIdeas(param1:Button) : void
      {
         var _loc2_:Object = this._2116813633_btnIdeas;
         if(_loc2_ !== param1)
         {
            this._2116813633_btnIdeas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnIdeas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMoreMenu() : IconTextButton
      {
         return this._938620689_btnMoreMenu;
      }
      
      public function set _btnMoreMenu(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._938620689_btnMoreMenu;
         if(_loc2_ !== param1)
         {
            this._938620689_btnMoreMenu = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMoreMenu",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPreview() : Button
      {
         return this._419384469_btnPreview;
      }
      
      public function set _btnPreview(param1:Button) : void
      {
         var _loc2_:Object = this._419384469_btnPreview;
         if(_loc2_ !== param1)
         {
            this._419384469_btnPreview = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPreview",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRecord() : Button
      {
         return this._938173362_btnRecord;
      }
      
      public function set _btnRecord(param1:Button) : void
      {
         var _loc2_:Object = this._938173362_btnRecord;
         if(_loc2_ !== param1)
         {
            this._938173362_btnRecord = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRecord",_loc2_,param1));
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
      public function get _container() : HBox
      {
         return this._1899870462_container;
      }
      
      public function set _container(param1:HBox) : void
      {
         var _loc2_:Object = this._1899870462_container;
         if(_loc2_ !== param1)
         {
            this._1899870462_container = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_container",_loc2_,param1));
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
      public function get _vRule() : VRule
      {
         return this._1463663725_vRule;
      }
      
      public function set _vRule(param1:VRule) : void
      {
         var _loc2_:Object = this._1463663725_vRule;
         if(_loc2_ !== param1)
         {
            this._1463663725_vRule = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vRule",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dpMoreMenu() : XML
      {
         return this._1097545472dpMoreMenu;
      }
      
      public function set dpMoreMenu(param1:XML) : void
      {
         var _loc2_:Object = this._1097545472dpMoreMenu;
         if(_loc2_ !== param1)
         {
            this._1097545472dpMoreMenu = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dpMoreMenu",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconMore() : Class
      {
         return this._738130066iconMore;
      }
      
      public function set iconMore(param1:Class) : void
      {
         var _loc2_:Object = this._738130066iconMore;
         if(_loc2_ !== param1)
         {
            this._738130066iconMore = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconMore",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconNewMovie() : Class
      {
         return this._1300184823iconNewMovie;
      }
      
      public function set iconNewMovie(param1:Class) : void
      {
         var _loc2_:Object = this._1300184823iconNewMovie;
         if(_loc2_ !== param1)
         {
            this._1300184823iconNewMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconNewMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconScreenshot() : Class
      {
         return this._1896998209iconScreenshot;
      }
      
      public function set iconScreenshot(param1:Class) : void
      {
         var _loc2_:Object = this._1896998209iconScreenshot;
         if(_loc2_ !== param1)
         {
            this._1896998209iconScreenshot = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconScreenshot",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iconIdeas() : Class
      {
         return this._1411229853iconIdeas;
      }
      
      public function set iconIdeas(param1:Class) : void
      {
         var _loc2_:Object = this._1411229853iconIdeas;
         if(_loc2_ !== param1)
         {
            this._1411229853iconIdeas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconIdeas",_loc2_,param1));
            }
         }
      }
   }
}
