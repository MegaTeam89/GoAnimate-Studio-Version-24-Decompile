package anifire.components.studio
{
   import anifire.component.IconTextButton;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.event.LoadMgrEvent;
   import anifire.playerComponent.PreviewPlayer;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilUser;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class PreviewWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _PreviewWindow_Label1:Label;
      
      private var _1731063772_btnBack:Button;
      
      private var _2044384006_btnCloseTop:IconTextButton;
      
      private var _1730556742_btnSave:Button;
      
      private var _1722718208_player:PreviewPlayer;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _301526948_movieName:String;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function PreviewWindow()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "events":{"initialize":"___PreviewWindow_TitleWindow1_initialize"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":616,
                  "height":500,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "stylesFactory":function():void
                     {
                        this.backgroundSize = "100%";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"popupWindowBackground"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "stylesFactory":function():void
                     {
                        this.verticalGap = 20;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "horizontalCenter":0,
                           "y":60,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":PreviewPlayer,
                              "id":"_player",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":550,
                                    "height":384,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":HBox,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "y":454,
                                    "horizontalCenter":0,
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnBack",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "minWidth":132,
                                             "height":32,
                                             "styleName":"btnBlack",
                                             "buttonMode":true
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Spacer,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"percentWidth":100};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnSave",
                                       "events":{"click":"___btnSave_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "minWidth":132,
                                             "height":32,
                                             "styleName":"btnBlack",
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
                     "type":Label,
                     "id":"_PreviewWindow_Label1",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":25,
                           "y":15,
                           "styleName":"title"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":IconTextButton,
                     "id":"_btnCloseTop",
                     "events":{
                        "click":"___btnCloseTop_click",
                        "creationComplete":"___btnCloseTop_creationComplete"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "right":10,
                           "top":10,
                           "styleName":"btnCloseTop",
                           "buttonMode":true,
                           "labelPlacement":"left"
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
         var bindings:Array = this._PreviewWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_PreviewWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return PreviewWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.layout = "absolute";
         this.width = 616;
         this.height = 500;
         this.styleName = "popupWindow";
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("initialize",this.___PreviewWindow_TitleWindow1_initialize);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         PreviewWindow._watcherSetupUtil = param1;
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
      
      public function initAndPreviewMovie(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : void
      {
         var filmXML:XML = param1;
         var imageDatas:UtilHashArray = param2;
         var loaddedThemes:UtilHashArray = param3;
         this._player.initAndPreview(filmXML,imageDatas,loaddedThemes);
         this.initPlayerEndScreen();
         this._btnBack.addEventListener(MouseEvent.CLICK,this.onCancelHandler,false,0,true);
         stage.frameRate = AnimeConstants.FRAME_PER_SEC;
         var setFrameRate:Function = function():void
         {
            stage.frameRate = AnimeConstants.FRAME_PER_SEC;
         };
         this.addEventListener(FlexEvent.CREATION_COMPLETE,setFrameRate,false,0,true);
         if(!UtilUser.loggedIn || Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
         {
            this._btnSave.enabled = false;
         }
         if(Console.getConsole().isTutorialOn)
         {
            this._btnSave.enabled = false;
            this._btnBack.enabled = false;
         }
      }
      
      private function initPlayerEndScreen() : void
      {
         this._player.endScreen.isPreviewMode = true;
         this._player.playerControl.fullScreenControl.visible = false;
      }
      
      private function doResetFramerate(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Stage = _loc2_.getExtraData() as Stage;
         _loc3_.frameRate = AnimeConstants.FRAME_PER_SEC_FAST;
         this._player.removeEventListener(Event.REMOVED_FROM_STAGE,this.doResetFramerate);
      }
      
      public function get movieName() : String
      {
         return this._movieName;
      }
      
      public function set movieName(param1:String) : void
      {
         this._movieName = param1;
      }
      
      public function addPublishListener(param1:Function) : void
      {
         this._btnSave.addEventListener(MouseEvent.CLICK,param1,false,0,true);
      }
      
      public function pause(param1:Boolean = false) : void
      {
         this._player.pause(true,param1);
      }
      
      public function play(param1:Boolean = false) : void
      {
         this._player.play(param1);
      }
      
      public function addExitListener(param1:Function) : void
      {
      }
      
      private function showPublishWindow() : void
      {
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onCancelHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.CANCEL));
      }
      
      public function destoryMC() : void
      {
         this._player.destroyMC();
         this._player = null;
      }
      
      private function initClose() : void
      {
         var _loc1_:ColorTransform = new ColorTransform(0.5,0.5,0.5);
         this._btnCloseTop.transform.colorTransform = _loc1_;
      }
      
      public function ___PreviewWindow_TitleWindow1_initialize(param1:FlexEvent) : void
      {
         this.setFocus();
      }
      
      public function ___btnSave_click(param1:MouseEvent) : void
      {
         this.showPublishWindow();
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.onCancelHandler(param1);
      }
      
      public function ___btnCloseTop_creationComplete(param1:FlexEvent) : void
      {
         this.initClose();
      }
      
      private function _PreviewWindow_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = "< " + UtilDict.toDisplay("go","Back to editing");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnBack.label");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","previewwindow_save");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSave.label");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Preview") + _movieName;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_PreviewWindow_Label1.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("player","Close");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCloseTop.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBack() : Button
      {
         return this._1731063772_btnBack;
      }
      
      public function set _btnBack(param1:Button) : void
      {
         var _loc2_:Object = this._1731063772_btnBack;
         if(_loc2_ !== param1)
         {
            this._1731063772_btnBack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : IconTextButton
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _btnCloseTop(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
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
      public function get _player() : PreviewPlayer
      {
         return this._1722718208_player;
      }
      
      public function set _player(param1:PreviewPlayer) : void
      {
         var _loc2_:Object = this._1722718208_player;
         if(_loc2_ !== param1)
         {
            this._1722718208_player = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_player",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _movieName() : String
      {
         return this._301526948_movieName;
      }
      
      private function set _movieName(param1:String) : void
      {
         var _loc2_:Object = this._301526948_movieName;
         if(_loc2_ !== param1)
         {
            this._301526948_movieName = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_movieName",_loc2_,param1));
            }
         }
      }
   }
}
