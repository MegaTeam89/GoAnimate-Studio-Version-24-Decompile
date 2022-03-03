package anifire.components.studio
{
   import anifire.command.AddSpeechCommand;
   import anifire.constant.ServerConstants;
   import anifire.constant.VoiceConstant;
   import anifire.core.AnimeScene;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.SoundThumb;
   import anifire.core.SpeechData;
   import anifire.core.sound.ImporterSoundAsset;
   import anifire.core.sound.SoundEvent;
   import anifire.core.sound.TTSManager;
   import anifire.managers.*;
   import anifire.popups.*;
   import anifire.tutorial.*;
   import anifire.util.*;
   import com.IconComboBox;
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
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class TTSComponent extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _TTSComponent_Button1:Button;
      
      public var _TTSComponent_Button2:Button;
      
      public var _TTSComponent_Text1:Text;
      
      public var _TTSComponent_Text2:Text;
      
      public var _TTSComponent_Text3:Text;
      
      public var _TTSComponent_Text4:Text;
      
      public var _TTSComponent_Text5:Text;
      
      public var _TTSComponent_Text6:Text;
      
      private var _1356879093_cboxVoiceLangSelect:IconComboBox;
      
      private var _1359179495_cboxVoiceSelect:IconComboBox;
      
      private var _496680559_txtConvertArea:TextArea;
      
      private var _1880432102editPanel:VBox;
      
      private var _1282976579helpPanel:VBox;
      
      private var _662307877helpPanel4School:VBox;
      
      private var _610678584helpPanelForGoPlus:VBox;
      
      private var _1081571786mainVS:ViewStack;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _preview:Boolean;
      
      private var _uploadType:String = "tts";
      
      private var _1565956469_modifiedText:Boolean = true;
      
      private var _1364258945_ttsText:String;
      
      public var sound:ImporterSoundAsset;
      
      private var _text:String;
      
      private var _voiceId:String;
      
      private var _bytes:ByteArray;
      
      private var _assetId:String;
      
      private var _uploadedAssetXML:XML;
      
      private var _1897480864_voices:Array;
      
      private var _1472458938_langs:Array;
      
      private var _selectedVoiceIndex:int = 0;
      
      private var _isZoomSelected:Boolean;
      
      private var _isActionSelected:Boolean;
      
      private var _bottom:SpeechComponent;
      
      private var _defaultTTSData:SpeechData;
      
      private var _defaultTTSVoice:String;
      
      private var _target:Object;
      
      public const flag_ca:Class = TTSComponent_flag_ca;
      
      public const flag_CA:Class = TTSComponent_flag_CA;
      
      public const flag_da:Class = TTSComponent_flag_da;
      
      public const flag_DK:Class = TTSComponent_flag_DK;
      
      public const flag_de:Class = TTSComponent_flag_de;
      
      public const flag_el:Class = TTSComponent_flag_el;
      
      public const flag_GR:Class = TTSComponent_flag_GR;
      
      public const flag_en:Class = TTSComponent_flag_en;
      
      public const flag_eo:Class = TTSComponent_flag_eo;
      
      public const flag_es:Class = TTSComponent_flag_es;
      
      public const flag_fi:Class = TTSComponent_flag_fi;
      
      public const flag_fr:Class = TTSComponent_flag_fr;
      
      public const flag_gl:Class = TTSComponent_flag_gl;
      
      public const flag_it:Class = TTSComponent_flag_it;
      
      public const flag_ja:Class = TTSComponent_flag_ja;
      
      public const flag_JP:Class = TTSComponent_flag_JP;
      
      public const flag_ko:Class = TTSComponent_flag_ko;
      
      public const flag_KR:Class = TTSComponent_flag_KR;
      
      public const flag_nl:Class = TTSComponent_flag_nl;
      
      public const flag_no:Class = TTSComponent_flag_no;
      
      public const flag_pl:Class = TTSComponent_flag_pl;
      
      public const flag_pt:Class = TTSComponent_flag_pt;
      
      public const flag_ro:Class = TTSComponent_flag_ro;
      
      public const flag_ru:Class = TTSComponent_flag_ru;
      
      public const flag_sv:Class = TTSComponent_flag_sv;
      
      public const flag_SE:Class = TTSComponent_flag_SE;
      
      public const flag_tr:Class = TTSComponent_flag_tr;
      
      public const flag_zh:Class = TTSComponent_flag_zh;
      
      public const flag_CN:Class = TTSComponent_flag_CN;
      
      public const flag_DE:Class = TTSComponent_flag_DE;
      
      public const flag_AU:Class = TTSComponent_flag_AU;
      
      public const flag_GB:Class = TTSComponent_flag_GB;
      
      public const flag_IN:Class = TTSComponent_flag_IN;
      
      public const flag_US:Class = TTSComponent_flag_US;
      
      public const flag_AR:Class = TTSComponent_flag_AR;
      
      public const flag_CL:Class = TTSComponent_flag_CL;
      
      public const flag_ES:Class = TTSComponent_flag_ES;
      
      public const flag_MX:Class = TTSComponent_flag_MX;
      
      public const flag_FR:Class = TTSComponent_flag_FR;
      
      public const flag_BR:Class = TTSComponent_flag_BR;
      
      public const flag_PT:Class = TTSComponent_flag_PT;
      
      private var _isRequestingVoice:Boolean = false;
      
      private var _voiceConstant:VoiceConstant;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function TTSComponent()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"mainVS",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 4473924;
                     this.paddingLeft = 10;
                     this.paddingRight = 10;
                     this.paddingTop = 10;
                     this.paddingBottom = 10;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "id":"editPanel",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_txtConvertArea",
                                    "events":{
                                       "change":"___txtConvertArea_change",
                                       "click":"___txtConvertArea_click"
                                    },
                                    "stylesFactory":function():void
                                    {
                                       this.color = 2500134;
                                       this.fontSize = 16;
                                       this.backgroundColor = 16777215;
                                       this.borderColor = 13421772;
                                       this.fontFamily = "Arial";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "height":90,
                                          "maxChars":180,
                                          "wordWrap":true,
                                          "editable":true
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalGap = 2;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":IconComboBox,
                                          "id":"_cboxVoiceLangSelect",
                                          "events":{"change":"___cboxVoiceLangSelect_change"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "width":105,
                                                "dropdownWidth":120,
                                                "rowCount":8,
                                                "buttonMode":true,
                                                "styleName":"cbSidePanel",
                                                "iconFunction":geticon,
                                                "icon4Selected":false
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":IconComboBox,
                                          "id":"_cboxVoiceSelect",
                                          "events":{"change":"___cboxVoiceSelect_change"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "width":130,
                                                "dropdownWidth":180,
                                                "rowCount":8,
                                                "buttonMode":true,
                                                "styleName":"cbSidePanel",
                                                "iconFunction":geticon
                                             };
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"helpPanel",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.verticalGap = 0;
                              this.backgroundColor = 16777215;
                              this.paddingLeft = 10;
                              this.paddingRight = 10;
                              this.paddingTop = 10;
                              this.paddingBottom = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text1",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 14;
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text2",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 12;
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_TTSComponent_Button1",
                                    "events":{"click":"___TTSComponent_Button1_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "styleName":"btnAskHelp",
                                          "buttonMode":true
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"helpPanelForGoPlus",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.verticalGap = 0;
                              this.backgroundColor = 16777215;
                              this.paddingLeft = 5;
                              this.paddingRight = 5;
                              this.paddingTop = 5;
                              this.paddingBottom = 5;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text3",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 14;
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text4",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 12;
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"helpPanel4School",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.verticalGap = 0;
                              this.backgroundColor = 16777215;
                              this.paddingLeft = 10;
                              this.paddingRight = 10;
                              this.paddingTop = 10;
                              this.paddingBottom = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text5",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 14;
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_TTSComponent_Text6",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 12;
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_TTSComponent_Button2",
                                    "events":{"click":"___TTSComponent_Button2_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "styleName":"btnAskHelp",
                                          "buttonMode":true
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
         this._voiceConstant = new VoiceConstant();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._TTSComponent_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_TTSComponentWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return TTSComponent[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         TTSComponent._watcherSetupUtil = param1;
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
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function set target(param1:Object) : void
      {
         this._target = param1;
      }
      
      public function init(param1:SpeechComponent = null) : void
      {
         var speechId:String = null;
         var assetId:String = null;
         var obj:Array = null;
         var sceneId:String = null;
         var sound:AnimeSound = null;
         var asset:Asset = null;
         var char:Character = null;
         var charId:String = null;
         var scene:AnimeScene = null;
         var bottom:SpeechComponent = param1;
         try
         {
            if(this.target is Character)
            {
               asset = Console.getConsole().currentScene.selectedAsset;
               this._defaultTTSData = null;
               this._defaultTTSVoice = null;
               if(asset is Character)
               {
                  char = asset as Character;
                  speechId = SpeechComponent.getAssetSpeechId();
                  if(speechId != "")
                  {
                     assetId = SpeechComponent.getAssetIdBySpeechId(speechId);
                     obj = assetId.split(AssetLinkage.LINK);
                     sceneId = obj[0];
                     charId = obj[1];
                     if(char.scene.id == sceneId && char.id == charId)
                     {
                        sound = Console.getConsole().speechManager.getValueByKey(speechId) as AnimeSound;
                        this._defaultTTSData = sound.soundThumb.ttsData;
                     }
                  }
                  else
                  {
                     this.resetForm();
                     if(char.speechVoice != null)
                     {
                        this._defaultTTSVoice = char.speechVoice;
                     }
                  }
               }
            }
            else if(this.target is AnimeScene)
            {
               scene = Console.getConsole().currentScene;
               speechId = SpeechComponent.getSceneSpeechId();
               if(speechId != "")
               {
                  assetId = SpeechComponent.getAssetIdBySpeechId(speechId);
                  obj = assetId.split(AssetLinkage.LINK);
                  sceneId = obj[0];
                  if(scene.id == sceneId)
                  {
                     sound = Console.getConsole().speechManager.getValueByKey(speechId) as AnimeSound;
                     this._defaultTTSData = sound.soundThumb.ttsData;
                  }
               }
               else
               {
                  this.resetForm();
               }
            }
            this._txtConvertArea.restrict = "^<^>^`";
            if(bottom)
            {
               this._bottom = bottom;
            }
            this.initVoice();
         }
         catch(e:Error)
         {
            UtilPopUp.errorAlert("Error: TTSPanel fail.");
            throw e;
         }
      }
      
      private function initVoice() : void
      {
         if(this._voiceConstant.status == VoiceConstant.STATUS_DONE)
         {
            this.buildVoice(this._voiceConstant.xml);
         }
         else if(this._voiceConstant.status == VoiceConstant.STATUS_NULL)
         {
            this._voiceConstant.addEventListener("XML_LOAD",this.onVoiceLoad);
            this._voiceConstant.getVoiceXML();
         }
      }
      
      private function onVoiceLoad(param1:Event) : void
      {
         this.buildVoice(this._voiceConstant.xml);
      }
      
      private function buildVoice(param1:XML, param2:String = "") : void
      {
         var list:XMLList = null;
         var item:XML = null;
         var pVoice:String = null;
         var cnt:String = null;
         var lang:Array = null;
         var flashVar:UtilHashArray = null;
         var tlang:String = null;
         var plus:Boolean = false;
         var xml:XML = param1;
         var selectedLang:String = param2;
         if(selectedLang == "")
         {
            lang = new Array();
            list = xml.language;
            if(!this._langs)
            {
               this._langs = new Array();
               for each(item in list)
               {
                  this._langs.push({
                     "id":String(item.@id),
                     "label":String(item.@desc),
                     "icon":"flag_" + String(item.@id)
                  });
               }
            }
            this._langs.sortOn("label");
            flashVar = Util.getFlashVar();
            tlang = flashVar.getValueByKey(ServerConstants.FLASHVAR_CLIENT_THEME_LANG_CODE);
            if(tlang)
            {
               selectedLang = tlang.substr(0,2);
               this._cboxVoiceLangSelect.selectedIndex = this.getObjectIndexFromArrayByPoperty(this._langs,"id",selectedLang);
            }
            else
            {
               this._cboxVoiceLangSelect.selectedIndex = 0;
               selectedLang = this._langs[0].id;
            }
         }
         if(this._defaultTTSData || this._defaultTTSVoice)
         {
            pVoice = !!this._defaultTTSData ? this._defaultTTSData.voice : this._defaultTTSVoice;
            list = xml..voice.(@id == pVoice);
            for each(item in list)
            {
               selectedLang = item.parent().@id;
               this._cboxVoiceLangSelect.selectedIndex = this.getObjectIndexFromArrayByPoperty(this._langs,"id",selectedLang);
            }
         }
         this._voices = new Array();
         var i:int = 0;
         do
         {
            list = xml.language.(@id == selectedLang).voice;
            if(list.length() == 0)
            {
               selectedLang = this._langs[i].id;
               i++;
            }
         }
         while(list.length() == 0);
         
         for each(item in list)
         {
            if(String(item.@country) == "")
            {
               cnt = this._langs[this._cboxVoiceLangSelect.selectedIndex].id;
            }
            else
            {
               cnt = String(item.@country);
            }
            plus = (String(item.@plus) == "Y") as Boolean;
            if(!plus || plus && FeatureManager.shouldGoPlusTTSVoiceBeShown)
            {
               this._voices.push({
                  "id":item.@id,
                  "label":String(item.@desc),
                  "plus":plus,
                  "country":cnt,
                  "icon":"flag_" + cnt
               });
            }
         }
         this._voices.sortOn("label");
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            this._voices.sortOn(["plus","label"]);
            i = 0;
            while(i < this._voices.length)
            {
               if(this._voices[i].plus)
               {
                  this._voices[i].label += " (" + UtilDict.toDisplay("go","GoPlus+") + ")";
               }
               i++;
            }
         }
         if(pVoice)
         {
            this._cboxVoiceSelect.selectedIndex = this.getObjectIndexFromArrayByPoperty(this._voices,"id",pVoice);
            if(this._defaultTTSData)
            {
               if(this._defaultTTSData.type == "tts")
               {
                  this._txtConvertArea.text = this._defaultTTSData.text;
               }
            }
            this._defaultTTSData = null;
            this._defaultTTSVoice = null;
         }
         else
         {
            this._cboxVoiceSelect.selectedIndex = 0;
         }
      }
      
      private function getObjectIndexFromArrayByPoperty(param1:Array, param2:String, param3:String) : int
      {
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_][param2] == param3)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
      
      public function resetForm() : void
      {
         this._txtConvertArea.text = UtilDict.toDisplay("go","Type it, and your character will say it.  (Max.  180 chars)");
      }
      
      public function setButtonStatus(param1:Boolean) : void
      {
         this._txtConvertArea.editable = param1;
         this._cboxVoiceSelect.enabled = param1;
      }
      
      private function onTextChangeHandler() : void
      {
         this._modifiedText = true;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onVoiceLangChange(param1:ListEvent) : void
      {
         this.buildVoice(this._voiceConstant.xml,this._cboxVoiceLangSelect.selectedItem.id as String);
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onVoiceChange(param1:ListEvent) : void
      {
         this._modifiedText = true;
         if(UtilUser.userType == UtilUser.BASIC_USER && this._cboxVoiceSelect.selectedItem.plus)
         {
            this._cboxVoiceSelect.selectedIndex = this._selectedVoiceIndex;
         }
         this._selectedVoiceIndex = this._cboxVoiceSelect.selectedIndex;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onConvertHandler() : void
      {
         this._preview = true;
         if(!this._modifiedText)
         {
            if(this.sound != null)
            {
               this.sound.play();
               this.setButtonStatus(true);
            }
            else
            {
               this.doCommit(true);
            }
         }
         else
         {
            this.doCommit(true);
            this._modifiedText = true;
         }
      }
      
      public function onSaveHandler(param1:Object) : void
      {
         this._isZoomSelected = param1["zoom"];
         this._isActionSelected = param1["action"];
         this._preview = false;
         if(this.sound != null)
         {
            this.sound.stop();
         }
         if(this._modifiedText)
         {
            this.doCommit(false);
         }
      }
      
      private function doCommit(param1:Boolean) : void
      {
         this.getTextSpeechAsset();
      }
      
      public function getTextSpeechAsset() : void
      {
         var _loc1_:RegExp = new RegExp(String.fromCharCode(13),"g");
         this._text = this._txtConvertArea.text.replace(_loc1_," ");
         this._voiceId = this._cboxVoiceSelect.selectedItem.id;
         var _loc2_:URLRequest = TTSManager.getRequestOfTextToSpeech(this._text,this._voiceId);
         Util.addFlashVarsToURLvar(_loc2_.data as URLVariables);
         var _loc3_:UtilURLStream = new UtilURLStream();
         _loc3_.addEventListener(Event.COMPLETE,this._bottom.onSentCompleteHandler);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.error);
         _loc3_.addEventListener(UtilURLStream.TIME_OUT,this.error);
         _loc3_.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.error);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.error);
         _loc3_.load(_loc2_);
      }
      
      public function error(param1:Event) : void
      {
         if(param1 is HTTPStatusEvent)
         {
            if(HTTPStatusEvent(param1).status == 200)
            {
               return;
            }
         }
         this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
         this.setButtonStatus(true);
         this.sound = null;
      }
      
      public function saveSound(param1:ByteArray, param2:XML) : void
      {
         var _loc3_:SoundThumb = Console.getConsole().speechManager.createSoundThumbByByte(param1,param2);
         this.saveSoundBySoundThumb(_loc3_);
      }
      
      public function saveSoundBySoundThumb(param1:SoundThumb) : void
      {
         Console.getConsole().speechManager.ttsManager.addEventListener(SoundEvent.ADDED,this.onSoundAdded);
         var _loc2_:SpeechData = new SpeechData();
         _loc2_.type = "tts";
         _loc2_.text = this._text;
         _loc2_.voice = this._voiceId;
         param1.ttsData = _loc2_;
         Console.getConsole().speechManager.addSoundByThumb(param1);
         this.setButtonStatus(true);
      }
      
      private function onSoundAdded(param1:SoundEvent) : void
      {
         var _loc5_:String = null;
         var _loc10_:Asset = null;
         var _loc11_:Boolean = false;
         var _loc12_:UtilHashArray = null;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:EffectAsset = null;
         Console.getConsole().speechManager.ttsManager.removeEventListener(SoundEvent.ADDED,this.onSoundAdded);
         var _loc2_:AssetLinkage = new AssetLinkage();
         var _loc3_:Object = param1.getData();
         var _loc4_:String = _loc3_["id"];
         _loc2_.addLinkage(_loc4_);
         if(this.target is Character)
         {
            _loc5_ = (_loc10_ = Console.getConsole().currentScene.selectedAsset).scene.id + AssetLinkage.LINK + _loc10_.id;
         }
         else if(this.target is AnimeScene)
         {
            _loc5_ = Console.getConsole().currentScene.id + AssetLinkage.LINK;
         }
         _loc2_.addLinkage(_loc5_);
         Console.getConsole().linkageController.addLinkage(_loc2_);
         var _loc6_:AddSpeechCommand;
         (_loc6_ = new AddSpeechCommand(Console.getConsole().speechManager.ttsManager.sounds.getValueByKey(_loc4_) as AnimeSound,_loc5_)).execute();
         if(this.target is Character)
         {
            _loc11_ = false;
            _loc13_ = (_loc12_ = Console.getConsole().currentScene.effects).length - 1;
            while(_loc13_ >= 0)
            {
               if((_loc15_ = _loc12_.getValueByIndex(_loc13_) as EffectAsset).fromSpeech)
               {
                  _loc11_ = true;
               }
               _loc13_--;
            }
            if(this._isZoomSelected && !_loc11_)
            {
               Console.getConsole().addCutEffectonChar(Character(_loc10_));
            }
            Character(_loc10_).demoSpeech = true;
            _loc14_ = false;
            if(this._isActionSelected)
            {
               _loc14_ = Character(_loc10_).changeActionAsTalk();
            }
            if(!_loc14_)
            {
               Character(_loc10_).reloadAssetImage();
            }
         }
         var _loc7_:Number = Util.roundNum(_loc3_["duration"] as Number);
         var _loc8_:Number = Console.getConsole().timeline.getCurrentSceneWidth();
         Console.getConsole().currentScene.doUpdateTimelineLength(UtilUnitConvert.secToPixel(_loc7_),true);
         var _loc9_:Number = Console.getConsole().timeline.getCurrentSceneWidth();
         Console.getConsole().currentScene.updateEffectTray(_loc9_,_loc8_);
         Console.getConsole().currentScene.refreshEffectTray();
         if(this.target is Character)
         {
            Character(_loc10_).speechVoice = AnimeSound(Console.getConsole().speechManager.ttsManager.sounds.getValueByKey(_loc4_)).soundThumb.ttsData.voice;
         }
         this.dispatchEvent(new Event(Event.COMPLETE));
         this.init();
      }
      
      private function removeSpeechAndConnection() : void
      {
         var _loc1_:String = SpeechComponent.getAssetSpeechId();
         Console.getConsole().speechManager.ttsManager.removeSoundById(_loc1_);
      }
      
      private function openAdvance() : void
      {
         this.currentState = "advanced";
      }
      
      private function closeAdvance() : void
      {
         this.currentState = "";
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
      
      public function set credit(param1:Number) : void
      {
         if(param1 <= 0)
         {
            if(UtilUser.userType == UtilUser.BASIC_USER)
            {
               if(UtilSite.siteId == UtilSite.SCHOOL)
               {
                  this.mainVS.selectedChild = this.helpPanel4School;
               }
               else
               {
                  this.mainVS.selectedChild = this.helpPanel;
               }
            }
            else
            {
               this.mainVS.selectedChild = this.helpPanelForGoPlus;
            }
         }
      }
      
      private function onAskHelp() : void
      {
         var _loc1_:IFlexDisplayObject = null;
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            _loc1_ = PopUpManager.createPopUp(this,SchoolUpgradeOnTts,true);
         }
         else if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            _loc1_ = PopUpManager.createPopUp(this,YouTubeUpgrade,true);
         }
         else
         {
            _loc1_ = PopUpManager.createPopUp(this,UpgradeOnTts,true);
         }
         _loc1_.width = 500;
         _loc1_.y = 100;
         _loc1_.x = (this.stage.width - _loc1_.width) / 2;
         UtilLog.triggerGoPlusFeature("extra_tts",this);
      }
      
      private function onTextAreaClick() : void
      {
         if(this._txtConvertArea.text == UtilDict.toDisplay("go","Type it, and your character will say it.  (Max.  180 chars)"))
         {
            this._txtConvertArea.setSelection(0,this._txtConvertArea.text.length);
         }
      }
      
      private function geticon(param1:Object) : Class
      {
         try
         {
            if(this[param1.icon])
            {
               return this[param1.icon];
            }
         }
         catch(e:Error)
         {
         }
         try
         {
            if(this[String(param1.icon).toLowerCase()])
            {
               return this[String(param1.icon).toLowerCase()];
            }
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public function ___txtConvertArea_change(param1:Event) : void
      {
         this.onTextChangeHandler();
      }
      
      public function ___txtConvertArea_click(param1:MouseEvent) : void
      {
         this.onTextAreaClick();
      }
      
      public function ___cboxVoiceLangSelect_change(param1:ListEvent) : void
      {
         this.onVoiceLangChange(param1);
      }
      
      public function ___cboxVoiceSelect_change(param1:ListEvent) : void
      {
         this.onVoiceChange(param1);
      }
      
      public function ___TTSComponent_Button1_click(param1:MouseEvent) : void
      {
         this.onAskHelp();
      }
      
      public function ___TTSComponent_Button2_click(param1:MouseEvent) : void
      {
         this.onAskHelp();
      }
      
      private function _TTSComponent_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Object
         {
            return _langs;
         },null,"_cboxVoiceLangSelect.dataProvider");
         result[1] = new Binding(this,function():Object
         {
            return _voices;
         },null,"_cboxVoiceSelect.dataProvider");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Oops.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TTSComponent_Text1.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Looks like you ran out of voice credits. Need extra credits for your animation?");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TTSComponent_Text2.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Upgrade to GoPlus");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TTSComponent_Button1.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Oops.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TTSComponent_Text3.text");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Looks like you ran out of voice credits. Why not check our voice recording and voice upload features in the drop-down just above. Actual voices greatly enhance cartoons.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TTSComponent_Text4.text");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Oops.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TTSComponent_Text5.text");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Looks like you ran out of voice credits. Your teacher can contact us to get more.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TTSComponent_Text6.text");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Get more credits") + " >";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TTSComponent_Button2.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _cboxVoiceLangSelect() : IconComboBox
      {
         return this._1356879093_cboxVoiceLangSelect;
      }
      
      public function set _cboxVoiceLangSelect(param1:IconComboBox) : void
      {
         var _loc2_:Object = this._1356879093_cboxVoiceLangSelect;
         if(_loc2_ !== param1)
         {
            this._1356879093_cboxVoiceLangSelect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cboxVoiceLangSelect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _cboxVoiceSelect() : IconComboBox
      {
         return this._1359179495_cboxVoiceSelect;
      }
      
      public function set _cboxVoiceSelect(param1:IconComboBox) : void
      {
         var _loc2_:Object = this._1359179495_cboxVoiceSelect;
         if(_loc2_ !== param1)
         {
            this._1359179495_cboxVoiceSelect = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cboxVoiceSelect",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtConvertArea() : TextArea
      {
         return this._496680559_txtConvertArea;
      }
      
      public function set _txtConvertArea(param1:TextArea) : void
      {
         var _loc2_:Object = this._496680559_txtConvertArea;
         if(_loc2_ !== param1)
         {
            this._496680559_txtConvertArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtConvertArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get editPanel() : VBox
      {
         return this._1880432102editPanel;
      }
      
      public function set editPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1880432102editPanel;
         if(_loc2_ !== param1)
         {
            this._1880432102editPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"editPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get helpPanel() : VBox
      {
         return this._1282976579helpPanel;
      }
      
      public function set helpPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1282976579helpPanel;
         if(_loc2_ !== param1)
         {
            this._1282976579helpPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"helpPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get helpPanel4School() : VBox
      {
         return this._662307877helpPanel4School;
      }
      
      public function set helpPanel4School(param1:VBox) : void
      {
         var _loc2_:Object = this._662307877helpPanel4School;
         if(_loc2_ !== param1)
         {
            this._662307877helpPanel4School = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"helpPanel4School",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get helpPanelForGoPlus() : VBox
      {
         return this._610678584helpPanelForGoPlus;
      }
      
      public function set helpPanelForGoPlus(param1:VBox) : void
      {
         var _loc2_:Object = this._610678584helpPanelForGoPlus;
         if(_loc2_ !== param1)
         {
            this._610678584helpPanelForGoPlus = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"helpPanelForGoPlus",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainVS() : ViewStack
      {
         return this._1081571786mainVS;
      }
      
      public function set mainVS(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1081571786mainVS;
         if(_loc2_ !== param1)
         {
            this._1081571786mainVS = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainVS",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _modifiedText() : Boolean
      {
         return this._1565956469_modifiedText;
      }
      
      private function set _modifiedText(param1:Boolean) : void
      {
         var _loc2_:Object = this._1565956469_modifiedText;
         if(_loc2_ !== param1)
         {
            this._1565956469_modifiedText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_modifiedText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _ttsText() : String
      {
         return this._1364258945_ttsText;
      }
      
      private function set _ttsText(param1:String) : void
      {
         var _loc2_:Object = this._1364258945_ttsText;
         if(_loc2_ !== param1)
         {
            this._1364258945_ttsText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ttsText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _voices() : Array
      {
         return this._1897480864_voices;
      }
      
      private function set _voices(param1:Array) : void
      {
         var _loc2_:Object = this._1897480864_voices;
         if(_loc2_ !== param1)
         {
            this._1897480864_voices = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_voices",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _langs() : Array
      {
         return this._1472458938_langs;
      }
      
      private function set _langs(param1:Array) : void
      {
         var _loc2_:Object = this._1472458938_langs;
         if(_loc2_ !== param1)
         {
            this._1472458938_langs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_langs",_loc2_,param1));
            }
         }
      }
   }
}
