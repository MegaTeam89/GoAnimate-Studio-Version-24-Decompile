package anifire.tutorial
{
   import anifire.constant.ServerConstants;
   import anifire.core.Asset;
   import anifire.core.Console;
   import anifire.timeline.Timeline;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilNetwork;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.filters.BlurFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Proxy;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.Move;
   import mx.effects.Resize;
   import mx.effects.Rotate;
   import mx.events.EffectEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class TutorialManager extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1549296987_boxMessage:Canvas;
      
      private var _853725098_btnMessage:Button;
      
      private var _985212102_content:VBox;
      
      private var _1480345928_cover:Canvas;
      
      private var _447569799_effFadeIn:Fade;
      
      private var _989767980_effFadeOut:Fade;
      
      private var _523592727_effMove:Move;
      
      private var _795265914_effResize:Resize;
      
      private var _804523041_effRotate:Rotate;
      
      private var _18423959_filterShadow:DropShadowFilter;
      
      private var _1476485635_guide:Button;
      
      private var _1126112268_guideArrow:Button;
      
      private var _729258365_guideHead:Button;
      
      private var _1266936593_overlay:Canvas;
      
      private var _543526166_txtMessage:Text;
      
      private var _206195195btnSkip:Button;
      
      private var _170696188btnStopTutorial:Button;
      
      private var _1553599489filterBlur:BlurFilter;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private const MESSAGE_BOX_X_DEFAULT:uint = 276;
      
      private const MESSAGE_BOX_Y_DEFAULT:uint = 380;
      
      private var _guideMode:Boolean;
      
      private var _currStepNum:int;
      
      private var _existingUser:Boolean;
      
      private var _extraData:Object;
      
      private var _console:IEventDispatcher;
      
      private var _myWalkerGuide:WalkerGuide;
      
      private var _actionArray:Array;
      
      private var _currAction:String;
      
      private var GUIDE_ID:String;
      
      private var _guide_location_y:Number = 430;
      
      private var _xmlTutorial:XML;
      
      private var _ptCharacterPos:Point = null;
      
      private var _ptButtonBarPos:Point = null;
      
      private var _ptSoundPos:Point = null;
      
      private var _currentTutorial:ITutorial;
      
      private var _hasSoundGuideShown:Boolean = false;
      
      private var _hasTemplateGuideShown:Boolean = false;
      
      private var _hasTemplateThumbGuideShown:Boolean = false;
      
      private var _needDarkCover:Boolean = true;
      
      private const TITLE_HEIGHT:Number = 28;
      
      mx_internal var _TutorialManager_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function TutorialManager()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":954,
                  "height":629,
                  "creationPolicy":"all",
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_cover",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_boxMessage",
                     "effects":["moveEffect"],
                     "propertiesFactory":function():Object
                     {
                        return {
                           "clipContent":false,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnStopTutorial",
                              "events":{"click":"__btnStopTutorial_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "right":10,
                                    "styleName":"btnStopTutorial",
                                    "visible":true,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "id":"_content",
                              "effects":["resizeEffect"],
                              "stylesFactory":function():void
                              {
                                 this.horizontalAlign = "center";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"messageBox",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Text,
                                       "id":"_txtMessage",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"message",
                                             "width":400
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnMessage",
                                       "events":{"click":"___btnMessage_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnMessage",
                                             "buttonMode":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_guideArrow",
                              "effects":["moveEffect"],
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":-50,
                                    "y":50,
                                    "styleName":"guideArrow"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_guideHead",
                              "effects":["showEffect","hideEffect"],
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"guideHead",
                                    "right":-80,
                                    "top":-30,
                                    "visible":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnSkip",
                     "events":{"click":"__btnSkip_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "buttonMode":true,
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_guide",
                     "effects":["showEffect","hideEffect"],
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"guideChar",
                           "x":700,
                           "y":480
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_overlay",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
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
         var bindings:Array = this._TutorialManager_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_tutorial_TutorialManagerWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return TutorialManager[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 954;
         this.height = 629;
         this.visible = false;
         this.creationPolicy = "all";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._TutorialManager_Fade1_i();
         this._TutorialManager_Fade2_i();
         this._TutorialManager_Move1_i();
         this._TutorialManager_Resize1_i();
         this._TutorialManager_Rotate1_i();
         this._TutorialManager_DropShadowFilter1_i();
         this._TutorialManager_BlurFilter1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         TutorialManager._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_TutorialManager_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get hasTemplateThumbGuideShown() : Boolean
      {
         return this._hasTemplateThumbGuideShown;
      }
      
      public function get hasTemplateGuideShown() : Boolean
      {
         return this._hasTemplateGuideShown;
      }
      
      public function set console(param1:IEventDispatcher) : void
      {
         this._console = param1;
      }
      
      private function get myWalkerGuide() : WalkerGuide
      {
         return this._myWalkerGuide;
      }
      
      private function set myWalkerGuide(param1:WalkerGuide) : void
      {
         this._myWalkerGuide = param1;
      }
      
      public function get hasSoundGuideShown() : Boolean
      {
         return this._hasSoundGuideShown;
      }
      
      public function get currStepNum() : int
      {
         return this._currStepNum;
      }
      
      public function get guideMode() : Boolean
      {
         return this._guideMode;
      }
      
      public function startTutorial(param1:int = 0, param2:Boolean = true, param3:Boolean = false, param4:Object = null) : void
      {
         this.GUIDE_ID = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE_CC);
         this._currStepNum = param1;
         this._guideMode = param2;
         this._existingUser = param3;
         this._extraData = param4;
         this._actionArray = new Array();
         this._currentTutorial = new BasicTutorial();
         this._xmlTutorial = this._currentTutorial.data;
         this.visible = true;
         if(ExternalInterface.available)
         {
            ExternalInterface.call("tutorialStarted");
         }
         this.nextStep();
      }
      
      public function isBasicTutorialRunning() : Boolean
      {
         if(this._currentTutorial && this._currentTutorial is BasicTutorial)
         {
            return true;
         }
         return false;
      }
      
      public function startSoundTutorial(param1:Timeline, param2:Object = null) : void
      {
         this._extraData = param2;
         if(!this._hasSoundGuideShown)
         {
            this._currStepNum = 0;
            this.GUIDE_ID = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_TUTORIAL_MODE_CC);
            this._currentTutorial = new SoundGuide();
            this._xmlTutorial = this._currentTutorial.data;
            this._ptSoundPos = new Point(param1.x + 72,param1.y + 37);
            this.btnStopTutorial.label = UtilDict.toDisplay("go","Stop Tutorial") + " x";
            this.visible = true;
            this._effResize.duration = 0;
            this.stage.addEventListener(Event.RESIZE,this.onStageResize);
            this.onStageResize();
            this._hasSoundGuideShown = true;
            this.nextStep();
         }
         else
         {
            this.onTutorialEnd();
         }
      }
      
      public function startTemplateTutorial() : void
      {
         this._currStepNum = 0;
         this._currentTutorial = new TemplateTutorial();
         this._xmlTutorial = this._currentTutorial.data;
         this.btnStopTutorial.label = UtilDict.toDisplay("go","hide") + " x";
         this.visible = true;
         this._needDarkCover = false;
         this._hasTemplateGuideShown = true;
         this.nextStep();
      }
      
      public function startTemplateThumbTutorial() : void
      {
         this._currStepNum = 0;
         this._currentTutorial = new TemplateThumbTutorial();
         this._xmlTutorial = this._currentTutorial.data;
         this.btnStopTutorial.label = UtilDict.toDisplay("go","hide") + " x";
         this.visible = true;
         this._needDarkCover = false;
         this._hasTemplateThumbGuideShown = true;
         this.nextStep();
      }
      
      private function loadCharacter(param1:String, param2:String) : void
      {
      }
      
      private function claimTutorialBadges() : void
      {
         var _loc1_:URLLoader = new URLLoader();
         var _loc2_:URLRequest = UtilNetwork.addTutorialGoPoint(-1);
         _loc1_.addEventListener(Event.COMPLETE,this.onClaimBadgesComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onClaimBadgesFail);
         _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onClaimBadgesFail);
         _loc1_.load(_loc2_);
      }
      
      private function onClaimBadgesComplete(param1:Event) : void
      {
      }
      
      private function onClaimBadgesFail(param1:Event) : void
      {
      }
      
      private function updateMessageBox(param1:TutorialEvent = null) : void
      {
         this._txtMessage.htmlText = UtilDict.toDisplay("go",this._xmlTutorial.step[this._currStepNum].message);
         this._boxMessage.validateNow();
         if(this._xmlTutorial.step[this._currStepNum].focus.@target == "lastAddedCharacter" && this._ptCharacterPos)
         {
            this._boxMessage.x = this._ptCharacterPos.x - 47 + 361 - 400;
            this._boxMessage.y = this._ptCharacterPos.y - 30 + 60 + 100;
         }
         else if(this._xmlTutorial.step[this._currStepNum].focus.@target == "assetButtonBar" && this._ptButtonBarPos)
         {
            this._boxMessage.x = this._ptButtonBarPos.x - 400;
            this._boxMessage.y = this._ptButtonBarPos.y + 50;
         }
         else if(this._xmlTutorial.step[this._currStepNum].focus.@target == "lastAddedSound" && this._ptSoundPos)
         {
            this._boxMessage.height = 347;
            this._boxMessage.x = this._ptSoundPos.x;
            this._boxMessage.y = this._ptSoundPos.y - this._boxMessage.height;
         }
         else if(this._xmlTutorial.step[this._currStepNum].focus.@target == "TrayPublicTemplate")
         {
            this._boxMessage.x = Console.getConsole().thumbTray.width + 45;
            this._boxMessage.y = Console.getConsole().timeline.y - 50;
         }
         else
         {
            this._boxMessage.x = this._xmlTutorial.step[this._currStepNum].message.@x;
            this._boxMessage.y = this._xmlTutorial.step[this._currStepNum].message.@y;
         }
         this._btnMessage.visible = this._btnMessage.includeInLayout = this._xmlTutorial.step[this._currStepNum].event.@type == MouseEvent.CLICK;
         if(this._currStepNum + 1 == this._xmlTutorial.step.length() && this._xmlTutorial.step[this._currStepNum].focus.@target != "lastAddedSound")
         {
         }
      }
      
      private function updateGuideArrow(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         if(this._xmlTutorial.step[param1].hasOwnProperty("focus"))
         {
            _loc5_ = 0;
            _loc6_ = 0;
            if(this._xmlTutorial.step[param1].focus.@target == "lastAddedCharacter" && this._ptCharacterPos)
            {
               _loc5_ = this._ptCharacterPos.x - 47 + 361;
               _loc6_ = this._ptCharacterPos.y - 30 + 60;
            }
            else if(this._xmlTutorial.step[param1].focus.@target == "assetButtonBar" && this._ptButtonBarPos)
            {
               _loc5_ = this._ptButtonBarPos.x;
               _loc6_ = this._ptButtonBarPos.y;
            }
            else if(this._xmlTutorial.step[param1].focus.@target == "lastAddedSound" && this._ptSoundPos)
            {
               _loc5_ = this._ptSoundPos.x;
               _loc6_ = this._ptSoundPos.y;
            }
            else if(this._xmlTutorial.step[this._currStepNum].focus.@target == "TrayPublicTemplate")
            {
               _loc5_ = Console.getConsole().thumbTray.width;
               _loc6_ = Console.getConsole().timeline.y - 25;
            }
            else
            {
               _loc5_ = this._xmlTutorial.step[param1].focus.@x;
               _loc6_ = this._xmlTutorial.step[param1].focus.@y;
            }
            _loc2_ = _loc5_ - this._boxMessage.x;
            _loc3_ = _loc6_ - this._boxMessage.y;
            if(_loc2_ < 0)
            {
               _loc4_ = -90;
               _loc2_ = this.boundaryCheck(_loc2_,5 - this._guideArrow.height,this._boxMessage.width);
               _loc3_ = this.boundaryCheck(_loc3_ + this._guideArrow.width / 2,0,this._boxMessage.height);
            }
            else if(_loc3_ < 0)
            {
               _loc4_ = 0;
               _loc2_ = this.boundaryCheck(_loc2_ - this._guideArrow.width / 2,0,this._boxMessage.width - this._guideArrow.width);
               _loc3_ = this.boundaryCheck(_loc3_,5 - this._guideArrow.height,this._boxMessage.height);
            }
            else
            {
               _loc4_ = 180;
               _loc2_ = this.boundaryCheck(this._guideArrow.width,0,this._boxMessage.width);
               _loc3_ = this.boundaryCheck(_loc3_ + this._guideArrow.height - 5,5 - this._guideArrow.height,this._boxMessage.height + this._guideArrow.height);
            }
            this._guideArrow.visible = true;
         }
         else
         {
            this._guideArrow.visible = false;
         }
         this._guideArrow.x = _loc2_;
         this._guideArrow.y = _loc3_;
         this._guideArrow.rotation = _loc4_;
      }
      
      private function boundaryCheck(param1:Number, param2:Number = -9999999, param3:Number = 9999999) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      private function onStageResize(param1:Event = null) : void
      {
         this.updateCover();
      }
      
      private function updateCover() : void
      {
         var _loc1_:XML = null;
         this._cover.graphics.clear();
         if(this._needDarkCover)
         {
            this._cover.graphics.beginFill(0,0.5);
            this._cover.graphics.drawRect(0,0,this.width,this.height);
            if(this._xmlTutorial.step[this._currStepNum])
            {
               for each(_loc1_ in this._xmlTutorial.step[this._currStepNum].uncover.rect)
               {
                  this._cover.graphics.drawRect(_loc1_.@x,_loc1_.@y,_loc1_.@w,_loc1_.@h);
               }
            }
            this._cover.graphics.endFill();
         }
      }
      
      private function updateGuideCharacter() : void
      {
         if(this._currStepNum == 0 || this._currStepNum > 0 && this._xmlTutorial.step[this._currStepNum].guide.@action != this._xmlTutorial.step[this._currStepNum - 1].guide.@action)
         {
            this.loadCharacter(this.GUIDE_ID,this._xmlTutorial.step[this._currStepNum].guide.@action);
         }
         this._guide.visible = this._xmlTutorial.step[this._currStepNum].guide.@visible == "true";
         this._guideHead.visible = this._xmlTutorial.step[this._currStepNum].guide.@visible != "true";
         if(this._currStepNum + 1 == 1 || this._currStepNum + 1 == 2 || this._currStepNum + 1 == this._xmlTutorial.step.length())
         {
            this._guide.y = 180;
         }
         else
         {
            this._guide.y = 280;
         }
      }
      
      private function updateEventListener() : void
      {
         var _loc2_:String = null;
         if(this._currStepNum > 0)
         {
            _loc2_ = this._xmlTutorial.step[this._currStepNum - 1].event.@type;
            if(this._console)
            {
               this._console.removeEventListener(_loc2_,this.onStepDone);
            }
         }
         var _loc1_:String = this._xmlTutorial.step[this._currStepNum].event.@type;
         if(this._console)
         {
            this._console.addEventListener(_loc1_,this.onStepDone);
         }
      }
      
      private function onTutorialEnd() : void
      {
         this._guideMode = false;
         this._currentTutorial = null;
         this.visible = false;
         this.claimTutorialBadges();
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         var _loc1_:TutorialEvent = new TutorialEvent(TutorialEvent.TUTORIAL_DONE,!!this._extraData ? this._extraData : null);
         this.dispatchEvent(_loc1_);
         if(ExternalInterface.available)
         {
            ExternalInterface.call("tutorialCompleted");
         }
      }
      
      private function nextStep(param1:TutorialEvent = null) : void
      {
         if(this._currStepNum >= this._xmlTutorial.step.length())
         {
            this.onTutorialEnd();
            return;
         }
         if(param1 && param1.data is Asset)
         {
            this._ptCharacterPos = new Point(param1.data.x,param1.data.y);
            this._ptButtonBarPos = new Point(Console.getConsole().mainStage.buttonBar.x + 311 + 10,Console.getConsole().mainStage.buttonBar.y + 36 + 20);
         }
         this.updateMessageBox(param1);
         this.updateGuideArrow(this._currStepNum);
         this.updateCover();
         this.updateGuideCharacter();
         this.updateEventListener();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("tutorialStep",this._currStepNum);
         }
         if(this._currStepNum == this._xmlTutorial.step.length() - 1)
         {
            this.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         ++this._currStepNum;
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(!this._boxMessage.hitTestPoint(param1.stageX,param1.stageY))
         {
            this.nextStep();
         }
      }
      
      private function onStepDone(param1:TutorialEvent) : void
      {
         var _loc2_:String = null;
         if(this._currStepNum > 0)
         {
            _loc2_ = this._xmlTutorial.step[this._currStepNum - 1].event.@type;
            if(param1.type == _loc2_)
            {
               this.nextStep(param1);
            }
         }
      }
      
      private function onMoveEffectStart(param1:Event) : void
      {
         this._overlay.graphics.clear();
         this._overlay.graphics.beginFill(0,0);
         this._overlay.graphics.drawRect(0,0,this.width,this.height);
         this._overlay.graphics.endFill();
      }
      
      private function onMoveEffectEnd(param1:Event) : void
      {
         this._overlay.graphics.clear();
      }
      
      private function _TutorialManager_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 1000;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         this._effFadeIn = _loc1_;
         BindingManager.executeBindings(this,"_effFadeIn",this._effFadeIn);
         return _loc1_;
      }
      
      private function _TutorialManager_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 1000;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         this._effFadeOut = _loc1_;
         BindingManager.executeBindings(this,"_effFadeOut",this._effFadeOut);
         return _loc1_;
      }
      
      private function _TutorialManager_Move1_i() : Move
      {
         var _loc1_:Move = new Move();
         _loc1_.duration = 1000;
         _loc1_.addEventListener("effectStart",this.___effMove_effectStart);
         _loc1_.addEventListener("effectEnd",this.___effMove_effectEnd);
         this._effMove = _loc1_;
         BindingManager.executeBindings(this,"_effMove",this._effMove);
         return _loc1_;
      }
      
      public function ___effMove_effectStart(param1:EffectEvent) : void
      {
         this.onMoveEffectStart(param1);
      }
      
      public function ___effMove_effectEnd(param1:EffectEvent) : void
      {
         this.onMoveEffectEnd(param1);
      }
      
      private function _TutorialManager_Resize1_i() : Resize
      {
         var _loc1_:Resize = new Resize();
         _loc1_.duration = 500;
         this._effResize = _loc1_;
         BindingManager.executeBindings(this,"_effResize",this._effResize);
         return _loc1_;
      }
      
      private function _TutorialManager_Rotate1_i() : Rotate
      {
         var _loc1_:Rotate = new Rotate();
         _loc1_.duration = 1000;
         this._effRotate = _loc1_;
         BindingManager.executeBindings(this,"_effRotate",this._effRotate);
         return _loc1_;
      }
      
      private function _TutorialManager_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.distance = 10;
         _loc1_.blurX = 10;
         _loc1_.blurY = 10;
         _loc1_.angle = 45;
         _loc1_.color = 0;
         _loc1_.alpha = 0.5;
         this._filterShadow = _loc1_;
         BindingManager.executeBindings(this,"_filterShadow",this._filterShadow);
         return _loc1_;
      }
      
      private function _TutorialManager_BlurFilter1_i() : BlurFilter
      {
         var _loc1_:BlurFilter = new BlurFilter();
         _loc1_.blurX = 5;
         _loc1_.blurY = 5;
         this.filterBlur = _loc1_;
         BindingManager.executeBindings(this,"filterBlur",this.filterBlur);
         return _loc1_;
      }
      
      public function __btnStopTutorial_click(param1:MouseEvent) : void
      {
         this.onTutorialEnd();
      }
      
      public function ___btnMessage_click(param1:MouseEvent) : void
      {
         this.nextStep();
      }
      
      public function __btnSkip_click(param1:MouseEvent) : void
      {
         this.nextStep();
      }
      
      private function _TutorialManager_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Array
         {
            var _loc1_:* = [filterBlur];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"_cover.filters");
         result[1] = new Binding(this,null,function(param1:*):void
         {
            _boxMessage.setStyle("moveEffect",param1);
         },"_boxMessage.moveEffect","_effMove");
         result[2] = new Binding(this,function():Array
         {
            var _loc1_:* = [_filterShadow];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"_boxMessage.filters");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Stop Tutorial") + " x";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnStopTutorial.label");
         result[4] = new Binding(this,function():Number
         {
            return _content.height - 8;
         },null,"btnStopTutorial.y");
         result[5] = new Binding(this,null,function(param1:*):void
         {
            _content.setStyle("resizeEffect",param1);
         },"_content.resizeEffect","_effResize");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Continue") + " >";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnMessage.label");
         result[7] = new Binding(this,null,function(param1:*):void
         {
            _guideArrow.setStyle("moveEffect",param1);
         },"_guideArrow.moveEffect","_effMove");
         result[8] = new Binding(this,null,function(param1:*):void
         {
            _guideHead.setStyle("showEffect",param1);
         },"_guideHead.showEffect","_effFadeIn");
         result[9] = new Binding(this,null,function(param1:*):void
         {
            _guideHead.setStyle("hideEffect",param1);
         },"_guideHead.hideEffect","_effFadeOut");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Skip") + " >";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnSkip.label");
         result[11] = new Binding(this,null,function(param1:*):void
         {
            _guide.setStyle("showEffect",param1);
         },"_guide.showEffect","_effFadeIn");
         result[12] = new Binding(this,null,function(param1:*):void
         {
            _guide.setStyle("hideEffect",param1);
         },"_guide.hideEffect","_effFadeOut");
         return result;
      }
      
      mx_internal function _TutorialManager_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_TutorialManager_StylesInit_done)
         {
            return;
         }
         mx_internal::_TutorialManager_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".message");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".message",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16777215;
               this.fontSize = 18;
            };
         }
         style = styleManager.getStyleDeclaration(".messageBox");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".messageBox",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.borderColor = 16777215;
               this.paddingTop = 10;
               this.backgroundColor = 8963870;
               this.cornerRadius = 10;
               this.borderThickness = 5;
               this.paddingLeft = 10;
               this.paddingBottom = 10;
               this.paddingRight = 10;
            };
         }
         style = styleManager.getStyleDeclaration(".btnStopTutorial");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnStopTutorial",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.paddingTop = 10;
               this.borderColor = 4742946;
               this.color = 2635279;
               this.borderThickness = 1;
               this.cornerRadius = 10;
               this.highlightAlphas = [0,0];
               this.fontSize = 12;
               this.fillColors = [4742946,4742946,5730604,5730604];
               this.fillAlphas = [1,1];
               this.themeColor = 4742946;
            };
         }
         style = styleManager.getStyleDeclaration(".btnMessage");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnMessage",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderStyle = "solid";
               this.color = 16777215;
               this.cornerRadius = 10;
               this.highlightAlphas = [0,0];
               this.fontSize = 20;
               this.fillColors = [39423,39423];
               this.fillAlphas = [1,1];
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxMessage() : Canvas
      {
         return this._1549296987_boxMessage;
      }
      
      public function set _boxMessage(param1:Canvas) : void
      {
         var _loc2_:Object = this._1549296987_boxMessage;
         if(_loc2_ !== param1)
         {
            this._1549296987_boxMessage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxMessage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMessage() : Button
      {
         return this._853725098_btnMessage;
      }
      
      public function set _btnMessage(param1:Button) : void
      {
         var _loc2_:Object = this._853725098_btnMessage;
         if(_loc2_ !== param1)
         {
            this._853725098_btnMessage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMessage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _content() : VBox
      {
         return this._985212102_content;
      }
      
      public function set _content(param1:VBox) : void
      {
         var _loc2_:Object = this._985212102_content;
         if(_loc2_ !== param1)
         {
            this._985212102_content = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_content",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cover() : Canvas
      {
         return this._1480345928_cover;
      }
      
      public function set _cover(param1:Canvas) : void
      {
         var _loc2_:Object = this._1480345928_cover;
         if(_loc2_ !== param1)
         {
            this._1480345928_cover = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cover",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effFadeIn() : Fade
      {
         return this._447569799_effFadeIn;
      }
      
      public function set _effFadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._447569799_effFadeIn;
         if(_loc2_ !== param1)
         {
            this._447569799_effFadeIn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effFadeIn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effFadeOut() : Fade
      {
         return this._989767980_effFadeOut;
      }
      
      public function set _effFadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._989767980_effFadeOut;
         if(_loc2_ !== param1)
         {
            this._989767980_effFadeOut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effFadeOut",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effMove() : Move
      {
         return this._523592727_effMove;
      }
      
      public function set _effMove(param1:Move) : void
      {
         var _loc2_:Object = this._523592727_effMove;
         if(_loc2_ !== param1)
         {
            this._523592727_effMove = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effMove",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effResize() : Resize
      {
         return this._795265914_effResize;
      }
      
      public function set _effResize(param1:Resize) : void
      {
         var _loc2_:Object = this._795265914_effResize;
         if(_loc2_ !== param1)
         {
            this._795265914_effResize = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effResize",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effRotate() : Rotate
      {
         return this._804523041_effRotate;
      }
      
      public function set _effRotate(param1:Rotate) : void
      {
         var _loc2_:Object = this._804523041_effRotate;
         if(_loc2_ !== param1)
         {
            this._804523041_effRotate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effRotate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _filterShadow() : DropShadowFilter
      {
         return this._18423959_filterShadow;
      }
      
      public function set _filterShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._18423959_filterShadow;
         if(_loc2_ !== param1)
         {
            this._18423959_filterShadow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_filterShadow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _guide() : Button
      {
         return this._1476485635_guide;
      }
      
      public function set _guide(param1:Button) : void
      {
         var _loc2_:Object = this._1476485635_guide;
         if(_loc2_ !== param1)
         {
            this._1476485635_guide = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_guide",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _guideArrow() : Button
      {
         return this._1126112268_guideArrow;
      }
      
      public function set _guideArrow(param1:Button) : void
      {
         var _loc2_:Object = this._1126112268_guideArrow;
         if(_loc2_ !== param1)
         {
            this._1126112268_guideArrow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_guideArrow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _guideHead() : Button
      {
         return this._729258365_guideHead;
      }
      
      public function set _guideHead(param1:Button) : void
      {
         var _loc2_:Object = this._729258365_guideHead;
         if(_loc2_ !== param1)
         {
            this._729258365_guideHead = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_guideHead",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _overlay() : Canvas
      {
         return this._1266936593_overlay;
      }
      
      public function set _overlay(param1:Canvas) : void
      {
         var _loc2_:Object = this._1266936593_overlay;
         if(_loc2_ !== param1)
         {
            this._1266936593_overlay = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_overlay",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtMessage() : Text
      {
         return this._543526166_txtMessage;
      }
      
      public function set _txtMessage(param1:Text) : void
      {
         var _loc2_:Object = this._543526166_txtMessage;
         if(_loc2_ !== param1)
         {
            this._543526166_txtMessage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtMessage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSkip() : Button
      {
         return this._206195195btnSkip;
      }
      
      public function set btnSkip(param1:Button) : void
      {
         var _loc2_:Object = this._206195195btnSkip;
         if(_loc2_ !== param1)
         {
            this._206195195btnSkip = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSkip",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnStopTutorial() : Button
      {
         return this._170696188btnStopTutorial;
      }
      
      public function set btnStopTutorial(param1:Button) : void
      {
         var _loc2_:Object = this._170696188btnStopTutorial;
         if(_loc2_ !== param1)
         {
            this._170696188btnStopTutorial = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnStopTutorial",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get filterBlur() : BlurFilter
      {
         return this._1553599489filterBlur;
      }
      
      public function set filterBlur(param1:BlurFilter) : void
      {
         var _loc2_:Object = this._1553599489filterBlur;
         if(_loc2_ !== param1)
         {
            this._1553599489filterBlur = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"filterBlur",_loc2_,param1));
            }
         }
      }
   }
}
