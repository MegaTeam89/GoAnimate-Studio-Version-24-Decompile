package anifire.components.containers
{
   import anifire.component.DoubleStateButton;
   import anifire.core.SoundThumb;
   import anifire.core.sound.ISoundable;
   import anifire.core.sound.SoundEvent;
   import anifire.core.sound.SoundPlaybackManager;
   import anifire.event.CoreEvent;
   import anifire.util.UtilString;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   
   use namespace mx_internal;
   
   public class SoundTileCell extends Canvas implements IBindingClient
   {
      
      public static const EVENT_PLAY_BUT_CLICK:String = "play_but_click";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1417497074dragSensor:HBox;
      
      private var _572854271playPauseBut:DoubleStateButton;
      
      private var _360573147soundLabel:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _soundThumb:SoundThumb;
      
      private var _2017207313_soundLabelText:String;
      
      private var _sound:ISoundable;
      
      private var _isCanceled:Boolean = false;
      
      private var _embed_mxml__________styles_note_music_swf_1053227495:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SoundTileCell()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___SoundTileCell_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "height":30,
                  "width":295,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "id":"dragSensor",
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "middle";
                        this.paddingLeft = 5;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentHeight":100,
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Image,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "source":_embed_mxml__________styles_note_music_swf_1053227495,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"soundLabel",
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "left";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":230,
                                    "x":28,
                                    "y":1,
                                    "buttonMode":true,
                                    "useHandCursor":true,
                                    "mouseChildren":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":DoubleStateButton,
                     "id":"playPauseBut",
                     "events":{
                        "mouseOver":"__playPauseBut_mouseOver",
                        "mouseOut":"__playPauseBut_mouseOut",
                        "But1Click":"__playPauseBut_But1Click",
                        "But2Click":"__playPauseBut_But2Click"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "scaleX":0.8,
                           "scaleY":0.8,
                           "left":5,
                           "y":4,
                           "visible":false
                        };
                     }
                  })]
               };
            }
         });
         this._embed_mxml__________styles_note_music_swf_1053227495 = SoundTileCell__embed_mxml__________styles_note_music_swf_1053227495;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SoundTileCell_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_SoundTileCellWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SoundTileCell[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.height = 30;
         this.width = 295;
         this.buttonMode = true;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___SoundTileCell_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SoundTileCell._watcherSetupUtil = param1;
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
      
      public function clone() : SoundTileCell
      {
         var _loc1_:SoundTileCell = new SoundTileCell();
         _loc1_.soundThumb = this.soundThumb;
         _loc1_.tileLabel = this.tileLabel;
         _loc1_.sound = this.sound;
         return _loc1_;
      }
      
      private function doUpdateSoundObj(param1:Event) : void
      {
         this.sound = this.soundThumb.sound;
      }
      
      public function get soundThumb() : SoundThumb
      {
         return this._soundThumb;
      }
      
      public function set soundThumb(param1:SoundThumb) : void
      {
         if(this._soundThumb)
         {
            this._soundThumb.removeEventListener(CoreEvent.LOAD_THUMB_COMPLETE,this.doUpdateSoundObj);
         }
         this._soundThumb = param1;
         if(this._soundThumb)
         {
            this._soundThumb.addEventListener(CoreEvent.LOAD_THUMB_COMPLETE,this.doUpdateSoundObj);
         }
      }
      
      public function get tileLabel() : String
      {
         return this._soundLabelText;
      }
      
      public function set tileLabel(param1:String) : void
      {
         this._soundLabelText = param1 + (!!this.soundThumb ? " (" + UtilString.secToTimeString(this.soundThumb.duration / 1000) + ")" : "");
      }
      
      public function get sound() : ISoundable
      {
         return this._sound;
      }
      
      public function set sound(param1:ISoundable) : void
      {
         if(this._sound)
         {
            this._sound.removeEventListener(SoundEvent.STOPPED,this.onSoundStopped);
            this._sound.removeEventListener(SoundEvent.PLAYED,this.onSoundPlayed);
         }
         this._sound = param1;
         if(this._sound)
         {
            this._sound.addEventListener(SoundEvent.STOPPED,this.onSoundStopped);
            this._sound.addEventListener(SoundEvent.PLAYED,this.onSoundPlayed);
         }
      }
      
      public function hideButton() : void
      {
         this.playPauseBut.enabled = false;
         this.playPauseBut.visible = false;
      }
      
      public function getHitArea() : UIComponent
      {
         return this.dragSensor;
      }
      
      private function creationCompleteHandler(param1:Event) : void
      {
         this.doResize(null);
         this.addEventListener(FlexEvent.ADD,this.doResize);
         this.addEventListener(ResizeEvent.RESIZE,this.doResize);
         if(this.parent != null)
         {
            this.parent.addEventListener(ResizeEvent.RESIZE,this.doResize);
         }
      }
      
      private function doResize(param1:Event) : void
      {
         if(this.parent != null)
         {
            if(this.parent.width > 0)
            {
               this.width = this.parent.width;
            }
         }
      }
      
      private function onPlayButClick(param1:Event) : void
      {
         this.playSound();
      }
      
      private function onPauseButClick(param1:Event) : void
      {
         this.stopSound();
      }
      
      public function stopSound() : void
      {
         if(this.soundThumb != null && this.soundThumb.isLoading)
         {
            this._isCanceled = true;
         }
         SoundPlaybackManager.stop();
      }
      
      public function playSound(... rest) : void
      {
         if(this._isCanceled)
         {
            this._isCanceled = false;
         }
         else
         {
            SoundPlaybackManager.playSoundThumb(this.soundThumb);
         }
      }
      
      private function onSoundPlayed(param1:Event) : void
      {
         if(this.playPauseBut)
         {
            this.playPauseBut.setState(DoubleStateButton.STATE_BUT2);
         }
      }
      
      private function onSoundPlayComplete(param1:Event) : void
      {
         if(this.playPauseBut)
         {
            this.playPauseBut.setState(DoubleStateButton.STATE_BUT1);
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.PLAY_SOUND_COMPLETE,this));
      }
      
      private function onSoundStopped(param1:Event) : void
      {
         if(this.playPauseBut)
         {
            this.playPauseBut.setState(DoubleStateButton.STATE_BUT1);
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.PLAY_SOUND_COMPLETE,this));
      }
      
      private function mouseOverSoundBtnHandler() : void
      {
         this.dispatchEvent(new Event("mouseOverSoundBtnEvent"));
      }
      
      private function mouseOutSoundBtnHandler() : void
      {
         this.dispatchEvent(new Event("mouseOutSoundBtnEvent"));
      }
      
      public function ___SoundTileCell_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.creationCompleteHandler(param1);
      }
      
      public function __playPauseBut_mouseOver(param1:MouseEvent) : void
      {
         this.mouseOverSoundBtnHandler();
      }
      
      public function __playPauseBut_mouseOut(param1:MouseEvent) : void
      {
         this.mouseOutSoundBtnHandler();
      }
      
      public function __playPauseBut_But1Click(param1:Event) : void
      {
         this.onPlayButClick(param1);
      }
      
      public function __playPauseBut_But2Click(param1:Event) : void
      {
         this.onPauseButClick(param1);
      }
      
      private function _SoundTileCell_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = this._soundLabelText;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"soundLabel.text");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get dragSensor() : HBox
      {
         return this._1417497074dragSensor;
      }
      
      public function set dragSensor(param1:HBox) : void
      {
         var _loc2_:Object = this._1417497074dragSensor;
         if(_loc2_ !== param1)
         {
            this._1417497074dragSensor = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dragSensor",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playPauseBut() : DoubleStateButton
      {
         return this._572854271playPauseBut;
      }
      
      public function set playPauseBut(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._572854271playPauseBut;
         if(_loc2_ !== param1)
         {
            this._572854271playPauseBut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playPauseBut",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get soundLabel() : Label
      {
         return this._360573147soundLabel;
      }
      
      public function set soundLabel(param1:Label) : void
      {
         var _loc2_:Object = this._360573147soundLabel;
         if(_loc2_ !== param1)
         {
            this._360573147soundLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _soundLabelText() : String
      {
         return this._2017207313_soundLabelText;
      }
      
      private function set _soundLabelText(param1:String) : void
      {
         var _loc2_:Object = this._2017207313_soundLabelText;
         if(_loc2_ !== param1)
         {
            this._2017207313_soundLabelText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_soundLabelText",_loc2_,param1));
            }
         }
      }
   }
}
