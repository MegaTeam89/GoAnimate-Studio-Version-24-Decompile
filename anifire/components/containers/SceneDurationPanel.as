package anifire.components.containers
{
   import anifire.assets.transition.model.AssetTransitionHelper;
   import anifire.command.ChangeSceneDurationCommand;
   import anifire.command.ICommand;
   import anifire.components.studio.TimeStepper;
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   import anifire.events.SceneEvent;
   import anifire.scene.view.AbstractSceneView;
   import anifire.util.UtilDict;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class SceneDurationPanel extends AbstractSceneView implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _SceneDurationPanel_Label1:Label;
      
      public var _SceneDurationPanel_Text2:Text;
      
      public var _SceneDurationPanel_TextInput1:TextInput;
      
      private var _2129096803autoDuration:Text;
      
      private var _1378821641btnTTS:Button;
      
      private var _269608774customOption:HBox;
      
      private var _938686465rbAuto:RadioButton;
      
      private var _77323839rbCustom:RadioButton;
      
      private var _970937903rbGroup:RadioButtonGroup;
      
      private var _375693106rbSpeech:RadioButton;
      
      private var _661145450speechDuration:Text;
      
      private var _1893554479stepper:TimeStepper;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _SceneDurationPanel_StylesInit_done:Boolean = false;
      
      private var _embed_css_image_arrow_png__937809940_255662474:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SceneDurationPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":AbstractSceneView,
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
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_SceneDurationPanel_Label1",
                        "stylesFactory":function():void
                        {
                           this.paddingBottom = 0;
                           this.paddingTop = 0;
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
                              "type":RadioButton,
                              "id":"rbAuto",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 16;
                                 this.color = 6710886;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "groupName":"rbGroup",
                                    "selected":true,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"autoDuration",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 16;
                                 this.color = 10066329;
                              }
                           })]};
                        }
                     }),new UIComponentDescriptor({
                        "type":Text,
                        "id":"_SceneDurationPanel_Text2",
                        "stylesFactory":function():void
                        {
                           this.color = 10066329;
                           this.fontSize = 10;
                           this.paddingLeft = 20;
                        },
                        "propertiesFactory":function():Object
                        {
                           return {"width":260};
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
                              "type":RadioButton,
                              "id":"rbSpeech",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 16;
                                 this.color = 6710886;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "groupName":"rbGroup",
                                    "selected":true,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Text,
                              "id":"speechDuration",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 16;
                                 this.color = 10066329;
                              }
                           })]};
                        }
                     }),new UIComponentDescriptor({
                        "type":HBox,
                        "events":{
                           "rollOver":"___SceneDurationPanel_HBox3_rollOver",
                           "rollOut":"___SceneDurationPanel_HBox3_rollOut"
                        },
                        "stylesFactory":function():void
                        {
                           this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {"childDescriptors":[new UIComponentDescriptor({
                              "type":RadioButton,
                              "id":"rbCustom",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 16;
                                 this.color = 6710886;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "groupName":"rbGroup",
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HBox,
                              "id":"customOption",
                              "stylesFactory":function():void
                              {
                                 this.verticalAlign = "middle";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":TimeStepper,
                                    "id":"stepper",
                                    "events":{
                                       "change":"__stepper_change",
                                       "click":"__stepper_click"
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "minimum":0.25,
                                          "maximum":50,
                                          "stepSize":0.125
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"btnTTS",
                                    "events":{"click":"__btnTTS_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnFitSpeech",
                                          "height":18,
                                          "buttonMode":true,
                                          "visible":false
                                       };
                                    }
                                 })]};
                              }
                           })]};
                        }
                     }),new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"_SceneDurationPanel_TextInput1",
                        "stylesFactory":function():void
                        {
                           this.color = 6710886;
                           this.backgroundColor = 15525302;
                           this.paddingLeft = 5;
                           this.borderStyle = "solid";
                           this.borderColor = 15525302;
                           this.cornerRadius = 10;
                           this.fontSize = 10;
                        },
                        "propertiesFactory":function():Object
                        {
                           return {"editable":false};
                        }
                     })]};
                  }
               })]};
            }
         });
         this._embed_css_image_arrow_png__937809940_255662474 = _class_embed_css_image_arrow_png__937809940_255662474;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SceneDurationPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_SceneDurationPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SceneDurationPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this._SceneDurationPanel_RadioButtonGroup1_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SceneDurationPanel._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_SceneDurationPanel_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onSceneDurationChange(param1:Event) : void
      {
         this.updateUI();
      }
      
      override protected function addEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(SceneEvent.DURATION_CHANGE,this.onSceneDurationChange);
            param1.addEventListener(SceneEvent.DURATION_MODE_CHANGE,this.onSceneDurationChange);
         }
      }
      
      override protected function removeEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(SceneEvent.DURATION_CHANGE,this.onSceneDurationChange);
            param1.removeEventListener(SceneEvent.DURATION_MODE_CHANGE,this.onSceneDurationChange);
         }
      }
      
      override protected function unloadAllAssets() : void
      {
      }
      
      override protected function loadAllAssets() : void
      {
         this.updateUI();
      }
      
      private function updateUI() : void
      {
         if(this.sceneModel is AnimeScene)
         {
            this.stepper.value = AnimeScene(this.sceneModel).customDuration;
            this.speechDuration.text = this.autoDuration.text = "(" + AnimeScene(this.sceneModel).duration.toFixed(2) + "s)";
            if(AnimeScene(this.sceneModel).durationMode == AnimeScene.DURATION_MODE_CUSTOM)
            {
               this.rbGroup.selection = this.rbCustom;
               this.customOption.alpha = 1;
            }
            else if(AnimeScene(this.sceneModel).durationMode == AnimeScene.DURATION_MODE_SPEECH)
            {
               this.rbGroup.selection = this.rbSpeech;
               this.customOption.alpha = 0.4;
            }
            else
            {
               this.rbGroup.selection = this.rbAuto;
               this.customOption.alpha = 0.4;
            }
         }
      }
      
      private function onStepperChange(param1:Event) : void
      {
         var _loc3_:ICommand = null;
         var _loc2_:AnimeScene = this.sceneModel as AnimeScene;
         if(_loc2_)
         {
            _loc3_ = new ChangeSceneDurationCommand(_loc2_,UtilUnitConvert.durationToFrame(this.stepper.value),AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
            _loc3_.execute();
         }
      }
      
      private function resetSceneLengthToTTS() : void
      {
         var _loc2_:int = 0;
         var _loc3_:ICommand = null;
         var _loc4_:AnimeScene = null;
         var _loc1_:int = Console.getConsole().speechManager.getSpeechTotalFrame(AnimeScene(this.sceneModel));
         if(_loc1_ > 0)
         {
            _loc2_ = AssetTransitionHelper.getTotalFrameOfTransitionBeforeNarration(AnimeScene(this.sceneModel).assetTransitions);
            if(_loc4_ = this.sceneModel as AnimeScene)
            {
               _loc3_ = new ChangeSceneDurationCommand(_loc4_,_loc2_ + _loc1_,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
               _loc3_.execute();
            }
         }
      }
      
      private function onRbChange(param1:Event) : void
      {
         var _loc2_:ICommand = null;
         var _loc3_:AnimeScene = this.sceneModel as AnimeScene;
         if(_loc3_)
         {
            if(this.rbGroup.selection == this.rbCustom)
            {
               _loc2_ = new ChangeSceneDurationCommand(_loc3_,_loc3_.customTotalFrames,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
               this.customOption.alpha = 1;
            }
            else if(this.rbGroup.selection == this.rbSpeech)
            {
               _loc2_ = new ChangeSceneDurationCommand(_loc3_,_loc3_.customTotalFrames,AnimeScene.DURATION_MODE_SPEECH,Console.getConsole().timeline);
               this.customOption.alpha = 0.4;
            }
            else
            {
               _loc2_ = new ChangeSceneDurationCommand(_loc3_,_loc3_.customTotalFrames,AnimeScene.DURATION_MODE_AUTO,Console.getConsole().timeline);
               this.customOption.alpha = 0.4;
            }
            _loc2_.execute();
         }
      }
      
      private function onStepperClick() : void
      {
         var _loc2_:ICommand = null;
         this.rbGroup.selection = this.rbCustom;
         this.customOption.alpha = 1;
         var _loc1_:AnimeScene = this.sceneModel as AnimeScene;
         _loc2_ = new ChangeSceneDurationCommand(_loc1_,_loc1_.customTotalFrames,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
      }
      
      private function onCustomOptionRollOver(param1:Event) : void
      {
         this.customOption.alpha = 1;
      }
      
      private function onCustomOptionRollOut(param1:Event) : void
      {
         if(this.rbGroup.selection == this.rbAuto)
         {
            this.customOption.alpha = 0.4;
         }
      }
      
      private function _SceneDurationPanel_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.__rbGroup_change);
         _loc1_.initialized(this,"rbGroup");
         this.rbGroup = _loc1_;
         BindingManager.executeBindings(this,"rbGroup",this.rbGroup);
         return _loc1_;
      }
      
      public function __rbGroup_change(param1:Event) : void
      {
         this.onRbChange(param1);
      }
      
      public function ___SceneDurationPanel_HBox3_rollOver(param1:MouseEvent) : void
      {
         this.onCustomOptionRollOver(param1);
      }
      
      public function ___SceneDurationPanel_HBox3_rollOut(param1:MouseEvent) : void
      {
         this.onCustomOptionRollOut(param1);
      }
      
      public function __stepper_change(param1:Event) : void
      {
         this.onStepperChange(param1);
      }
      
      public function __stepper_click(param1:MouseEvent) : void
      {
         this.onStepperClick();
      }
      
      public function __btnTTS_click(param1:MouseEvent) : void
      {
         this.resetSceneLengthToTTS();
      }
      
      private function _SceneDurationPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Duration");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneDurationPanel_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Fit to all scene content");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"rbAuto.label");
         result[2] = new Binding(this,function():Boolean
         {
            return rbAuto.selected;
         },null,"autoDuration.visible");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","includes speech, actions, bubbles, etc.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneDurationPanel_Text2.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Fit to speech duration");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"rbSpeech.label");
         result[5] = new Binding(this,function():Boolean
         {
            return rbSpeech.selected;
         },null,"speechDuration.visible");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Custom");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"rbCustom.label");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Fit to speech");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnTTS.label");
         result[8] = new Binding(this,function():Boolean
         {
            return rbCustom.selected;
         },null,"_SceneDurationPanel_TextInput1.visible");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Warning: Check that speech does not get cut");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneDurationPanel_TextInput1.text");
         return result;
      }
      
      mx_internal function _SceneDurationPanel_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_SceneDurationPanel_StylesInit_done)
         {
            return;
         }
         mx_internal::_SceneDurationPanel_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".btnFitSpeech");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnFitSpeech",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.paddingTop = 3;
               this.borderColor = 3355443;
               this.upIcon = _embed_css_image_arrow_png__937809940_255662474;
               this.cornerRadius = 10;
               this.textRollOverColor = 16290304;
               this.overIcon = _embed_css_image_arrow_png__937809940_255662474;
               this.fontSize = 10;
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 3355443;
               this.color = 15658734;
               this.highlightAlphas = [0,0];
               this.fillColors = [3355443,3355443,3355443,3355443];
               this.textSelectedColor = 15658734;
               this.downIcon = _embed_css_image_arrow_png__937809940_255662474;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get autoDuration() : Text
      {
         return this._2129096803autoDuration;
      }
      
      public function set autoDuration(param1:Text) : void
      {
         var _loc2_:Object = this._2129096803autoDuration;
         if(_loc2_ !== param1)
         {
            this._2129096803autoDuration = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoDuration",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnTTS() : Button
      {
         return this._1378821641btnTTS;
      }
      
      public function set btnTTS(param1:Button) : void
      {
         var _loc2_:Object = this._1378821641btnTTS;
         if(_loc2_ !== param1)
         {
            this._1378821641btnTTS = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnTTS",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get customOption() : HBox
      {
         return this._269608774customOption;
      }
      
      public function set customOption(param1:HBox) : void
      {
         var _loc2_:Object = this._269608774customOption;
         if(_loc2_ !== param1)
         {
            this._269608774customOption = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"customOption",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rbAuto() : RadioButton
      {
         return this._938686465rbAuto;
      }
      
      public function set rbAuto(param1:RadioButton) : void
      {
         var _loc2_:Object = this._938686465rbAuto;
         if(_loc2_ !== param1)
         {
            this._938686465rbAuto = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rbAuto",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rbCustom() : RadioButton
      {
         return this._77323839rbCustom;
      }
      
      public function set rbCustom(param1:RadioButton) : void
      {
         var _loc2_:Object = this._77323839rbCustom;
         if(_loc2_ !== param1)
         {
            this._77323839rbCustom = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rbCustom",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rbGroup() : RadioButtonGroup
      {
         return this._970937903rbGroup;
      }
      
      public function set rbGroup(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._970937903rbGroup;
         if(_loc2_ !== param1)
         {
            this._970937903rbGroup = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rbGroup",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rbSpeech() : RadioButton
      {
         return this._375693106rbSpeech;
      }
      
      public function set rbSpeech(param1:RadioButton) : void
      {
         var _loc2_:Object = this._375693106rbSpeech;
         if(_loc2_ !== param1)
         {
            this._375693106rbSpeech = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rbSpeech",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechDuration() : Text
      {
         return this._661145450speechDuration;
      }
      
      public function set speechDuration(param1:Text) : void
      {
         var _loc2_:Object = this._661145450speechDuration;
         if(_loc2_ !== param1)
         {
            this._661145450speechDuration = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechDuration",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stepper() : TimeStepper
      {
         return this._1893554479stepper;
      }
      
      public function set stepper(param1:TimeStepper) : void
      {
         var _loc2_:Object = this._1893554479stepper;
         if(_loc2_ !== param1)
         {
            this._1893554479stepper = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stepper",_loc2_,param1));
            }
         }
      }
   }
}
