package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.containers.GradientCanvas;
   import anifire.core.AnimeSound;
   import anifire.core.sound.ProgressiveSound;
   import anifire.core.sound.SoundEvent;
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   import flash.filters.BevelFilter;
   import flash.geom.Rectangle;
   import flash.utils.Proxy;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class SoundElement extends Canvas implements ITimelineElement, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _94436_bg:GradientCanvas;
      
      private var _2934560_ind:Canvas;
      
      private var _91376600_wave:SoundWaveformRenderer;
      
      private var _1008377409effectBevelFilter:BevelFilter;
      
      private var _1419884789endMarker:Canvas;
      
      private var _1180009773musicBevelFilter:BevelFilter;
      
      private var _2132730041muteBevelFilter:BevelFilter;
      
      private var _251225037overEffectBevelFilter:BevelFilter;
      
      private var _922624479overMusicBevelFilter:BevelFilter;
      
      private var _1372166469overMuteBevelFilter:BevelFilter;
      
      private var _360573147soundLabel:Label;
      
      private var _2055474372startMarker:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private const BG_BORDER_COLOR:uint = 6974058;
      
      private const PROGRESS_BG_COLOR:uint = 3519541;
      
      private var _focus:Boolean = false;
      
      private var _timelineControl:Timeline = null;
      
      private var _soundContainer:SoundContainer = null;
      
      private var _1465432895_stime:Number = 0;
      
      private var _1602107397_length:Number = 100;
      
      private var _inner_volume:Number = 1;
      
      private const MIN_WIDTH:Number = 30;
      
      private const MAX_WIDTH:Number = 90000;
      
      private const DBAR_OFFSETY:Number = 1;
      
      private const DBAR_RADIUS:Number = 5;
      
      private var _hasMarker:Boolean = false;
      
      private var _animeSound:AnimeSound;
      
      private var _showWaveform:Boolean = false;
      
      private var _maxLength:Number = 0;
      
      mx_internal var _SoundElement_StylesInit_done:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SoundElement()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___SoundElement_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":GradientCanvas,
                  "id":"_bg",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentHeight":100,
                        "styleName":"musicStyle"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_ind",
                  "stylesFactory":function():void
                  {
                     this.borderStyle = "solid";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "width":0
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":SoundWaveformRenderer,
                  "id":"_wave",
                  "propertiesFactory":function():Object
                  {
                     return {"visible":false};
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"startMarker",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 4411524;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":1,
                        "percentHeight":100,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"endMarker",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 2236962;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":1,
                        "percentHeight":100,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "id":"soundLabel",
                  "stylesFactory":function():void
                  {
                     this.color = 5592405;
                     this.fontSize = 11;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "truncateToFit":true,
                        "buttonMode":true,
                        "useHandCursor":true,
                        "mouseChildren":false,
                        "y":1,
                        "x":6
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
         var bindings:Array = this._SoundElement_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SoundElementWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SoundElement[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.clipContent = false;
         this.blendMode = "layer";
         this._SoundElement_BevelFilter2_i();
         this._SoundElement_BevelFilter1_i();
         this._SoundElement_BevelFilter3_i();
         this._SoundElement_BevelFilter5_i();
         this._SoundElement_BevelFilter4_i();
         this._SoundElement_BevelFilter6_i();
         this.addEventListener("creationComplete",this.___SoundElement_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SoundElement._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_SoundElement_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get animeSound() : AnimeSound
      {
         return this._animeSound;
      }
      
      public function set animeSound(param1:AnimeSound) : void
      {
         if(this._animeSound != param1)
         {
            this._animeSound = param1;
            if(param1 && param1.soundThumb)
            {
               switch(param1.soundThumb.subType)
               {
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC:
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TRIBE_OF_NOISE:
                     this._bg.styleName = "musicStyle";
                     this._bg.filters = [this.musicBevelFilter];
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT:
                     this._bg.styleName = "effectStyle";
                     this._bg.filters = [this.effectBevelFilter];
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER:
                     this._bg.styleName = "voiceStyle";
                     this._bg.filters = [this.musicBevelFilter];
               }
               param1.soundThumb.addEventListener(SoundEvent.WAVEFORM_LOADED,this.onSoundWaveformLoaded);
            }
         }
      }
      
      private function drawWaveform() : void
      {
         var _loc1_:uint = 0;
         if(this._animeSound && this._animeSound.soundThumb)
         {
            if(this._animeSound.soundThumb.waveform)
            {
               _loc1_ = SoundWaveformRenderer.WAVEFORM_COLOR_MUSIC;
               switch(this._animeSound.soundThumb.subType)
               {
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT:
                     _loc1_ = SoundWaveformRenderer.WAVEFORM_COLOR_EFFECT;
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER:
                     _loc1_ = SoundWaveformRenderer.WAVEFORM_COLOR_VOICE;
               }
               this._wave.init(this._animeSound.soundThumb.waveform.samples,_loc1_,true);
            }
         }
      }
      
      private function onSoundWaveformLoaded(param1:Event) : void
      {
         this.drawWaveform();
      }
      
      private function initApp() : void
      {
         this.redraw();
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      public function get time() : Number
      {
         return this._stime;
      }
      
      public function get length() : Number
      {
         return this._length;
      }
      
      public function set focus(param1:Boolean) : void
      {
         this._focus = param1;
      }
      
      public function set time(param1:Number) : void
      {
         this._stime = param1;
      }
      
      public function set length(param1:Number) : void
      {
         this._length = param1;
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      public function set inner_volume(param1:Number) : void
      {
         this._inner_volume = param1;
      }
      
      private function redrawBg() : void
      {
      }
      
      public function redraw() : void
      {
         if(this._length > 0)
         {
            this.redrawBg();
            if(this._length < 2880)
            {
               this._ind.scrollRect = new Rectangle(0,0,this._length,18);
            }
            else
            {
               this._ind.scrollRect = null;
            }
            this.updateIndicator();
         }
         this.soundLabel.width = this._length > 1000 ? Number(1000) : (this._length < 0 ? Number(0) : Number(this._length - 10));
         this.soundLabel.x = 5;
         if(!this._showWaveform)
         {
            this.soundLabel.visible = this.soundLabel.width > 5 ? true : false;
         }
         if(this._length > this._maxLength)
         {
         }
         this._maxLength = Math.max(this._maxLength,this._length);
         this.invalidateProperties();
         this.invalidateDisplayList();
      }
      
      public function updateLabel(param1:String) : void
      {
         this.soundLabel.text = param1;
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
      }
      
      public function setSoundContainerReferer(param1:SoundContainer) : void
      {
         this._soundContainer = param1;
      }
      
      public function updateIndicator(param1:Number = -1, param2:Number = -1) : void
      {
         if(param1 == -1)
         {
            param1 = this._ind.x;
         }
         if(param2 == -1)
         {
            param2 = this._ind.width;
         }
         param1 = Math.min(param1,this._length);
         param2 = Math.min(param2,this._length - param1);
         this._ind.x = param1;
         this._ind.width = param2;
         if(param2 > 0)
         {
            this.startMarker.visible = true;
            this.endMarker.visible = true;
            this.startMarker.x = param1;
            this.endMarker.x = param1 + param2;
            this._hasMarker = true;
         }
      }
      
      public function clearIndicator() : void
      {
         this._ind.x = 0;
         this._ind.width = 0;
         this._ind.visible = false;
         this.startMarker.visible = false;
         this.endMarker.visible = false;
         this._hasMarker = false;
      }
      
      public function hasMarker() : Boolean
      {
         return this._hasMarker;
      }
      
      public function triggerWaveformMode() : void
      {
         this._showWaveform = !this._showWaveform;
         this.setWaveformVisible(this._showWaveform);
      }
      
      public function setWaveformVisible(param1:Boolean) : void
      {
         this._showWaveform = param1;
         this._wave.visible = param1;
         this.soundLabel.visible = !param1 && this.soundLabel.width > 5;
         if(param1)
         {
            this.drawWaveform();
            if(this.animeSound && this.animeSound.soundThumb)
            {
               if(!(this.animeSound.soundThumb.sound is ProgressiveSound))
               {
                  this._wave.showWarning();
               }
               this.animeSound.soundThumb.loadWaveform();
            }
         }
      }
      
      private function _SoundElement_BevelFilter2_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 1;
         _loc1_.highlightColor = 14212278;
         _loc1_.shadowColor = 10462326;
         _loc1_.blurX = 0;
         _loc1_.blurY = 0;
         this.effectBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"effectBevelFilter",this.effectBevelFilter);
         return _loc1_;
      }
      
      private function _SoundElement_BevelFilter1_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 1;
         _loc1_.highlightColor = 12111559;
         _loc1_.shadowColor = 7376266;
         _loc1_.blurX = 0;
         _loc1_.blurY = 0;
         this.musicBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"musicBevelFilter",this.musicBevelFilter);
         return _loc1_;
      }
      
      private function _SoundElement_BevelFilter3_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 1;
         _loc1_.highlightColor = 10197915;
         _loc1_.shadowColor = 10197915;
         _loc1_.blurX = 0;
         _loc1_.blurY = 0;
         this.muteBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"muteBevelFilter",this.muteBevelFilter);
         return _loc1_;
      }
      
      private function _SoundElement_BevelFilter5_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 1;
         _loc1_.highlightColor = 14935997;
         _loc1_.shadowColor = 11646602;
         _loc1_.blurX = 0;
         _loc1_.blurY = 0;
         this.overEffectBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"overEffectBevelFilter",this.overEffectBevelFilter);
         return _loc1_;
      }
      
      private function _SoundElement_BevelFilter4_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 1;
         _loc1_.highlightColor = 13098198;
         _loc1_.shadowColor = 8626077;
         _loc1_.blurX = 0;
         _loc1_.blurY = 0;
         this.overMusicBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"overMusicBevelFilter",this.overMusicBevelFilter);
         return _loc1_;
      }
      
      private function _SoundElement_BevelFilter6_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 1;
         _loc1_.highlightColor = 10197915;
         _loc1_.shadowColor = 10197915;
         _loc1_.blurX = 0;
         _loc1_.blurY = 0;
         this.overMuteBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"overMuteBevelFilter",this.overMuteBevelFilter);
         return _loc1_;
      }
      
      public function ___SoundElement_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      private function _SoundElement_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return _length;
         },null,"_bg.width");
         result[1] = new Binding(this,function():Array
         {
            var _loc1_:* = [musicBevelFilter];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"_bg.filters");
         result[2] = new Binding(this,function():uint
         {
            return PROGRESS_BG_COLOR;
         },function(param1:uint):void
         {
            _ind.setStyle("backgroundColor",param1);
         },"_ind.backgroundColor");
         result[3] = new Binding(this,function():Number
         {
            return DBAR_OFFSETY;
         },null,"_ind.y");
         result[4] = new Binding(this,function():Number
         {
            return height - DBAR_OFFSETY * 2;
         },null,"_ind.height");
         result[5] = new Binding(this,function():uint
         {
            return PROGRESS_BG_COLOR;
         },function(param1:uint):void
         {
            _ind.setStyle("borderColor",param1);
         },"_ind.borderColor");
         result[6] = new Binding(this,function():Number
         {
            return _length;
         },null,"_wave.width");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = soundLabel.text;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_wave.toolTip");
         return result;
      }
      
      mx_internal function _SoundElement_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_SoundElement_StylesInit_done)
         {
            return;
         }
         mx_internal::_SoundElement_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".musicStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".musicStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 9351591;
            };
         }
         style = styleManager.getStyleDeclaration(".effectStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".effectStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 12765067;
            };
         }
         style = styleManager.getStyleDeclaration(".voiceStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".voiceStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 10792920;
            };
         }
         style = styleManager.getStyleDeclaration(".muteStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".muteStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 11908533;
            };
         }
         style = styleManager.getStyleDeclaration(".overMusicStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".overMusicStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 10930110;
            };
         }
         style = styleManager.getStyleDeclaration(".overEffectStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".overEffectStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 14212514;
            };
         }
         style = styleManager.getStyleDeclaration(".overVoiceStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".overVoiceStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 12436185;
            };
         }
         style = styleManager.getStyleDeclaration(".overMuteStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".overMuteStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 11908533;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : GradientCanvas
      {
         return this._94436_bg;
      }
      
      public function set _bg(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ind() : Canvas
      {
         return this._2934560_ind;
      }
      
      public function set _ind(param1:Canvas) : void
      {
         var _loc2_:Object = this._2934560_ind;
         if(_loc2_ !== param1)
         {
            this._2934560_ind = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ind",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _wave() : SoundWaveformRenderer
      {
         return this._91376600_wave;
      }
      
      public function set _wave(param1:SoundWaveformRenderer) : void
      {
         var _loc2_:Object = this._91376600_wave;
         if(_loc2_ !== param1)
         {
            this._91376600_wave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_wave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get effectBevelFilter() : BevelFilter
      {
         return this._1008377409effectBevelFilter;
      }
      
      public function set effectBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._1008377409effectBevelFilter;
         if(_loc2_ !== param1)
         {
            this._1008377409effectBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effectBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get endMarker() : Canvas
      {
         return this._1419884789endMarker;
      }
      
      public function set endMarker(param1:Canvas) : void
      {
         var _loc2_:Object = this._1419884789endMarker;
         if(_loc2_ !== param1)
         {
            this._1419884789endMarker = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"endMarker",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get musicBevelFilter() : BevelFilter
      {
         return this._1180009773musicBevelFilter;
      }
      
      public function set musicBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._1180009773musicBevelFilter;
         if(_loc2_ !== param1)
         {
            this._1180009773musicBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"musicBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get muteBevelFilter() : BevelFilter
      {
         return this._2132730041muteBevelFilter;
      }
      
      public function set muteBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._2132730041muteBevelFilter;
         if(_loc2_ !== param1)
         {
            this._2132730041muteBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"muteBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get overEffectBevelFilter() : BevelFilter
      {
         return this._251225037overEffectBevelFilter;
      }
      
      public function set overEffectBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._251225037overEffectBevelFilter;
         if(_loc2_ !== param1)
         {
            this._251225037overEffectBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"overEffectBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get overMusicBevelFilter() : BevelFilter
      {
         return this._922624479overMusicBevelFilter;
      }
      
      public function set overMusicBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._922624479overMusicBevelFilter;
         if(_loc2_ !== param1)
         {
            this._922624479overMusicBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"overMusicBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get overMuteBevelFilter() : BevelFilter
      {
         return this._1372166469overMuteBevelFilter;
      }
      
      public function set overMuteBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._1372166469overMuteBevelFilter;
         if(_loc2_ !== param1)
         {
            this._1372166469overMuteBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"overMuteBevelFilter",_loc2_,param1));
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
      public function get startMarker() : Canvas
      {
         return this._2055474372startMarker;
      }
      
      public function set startMarker(param1:Canvas) : void
      {
         var _loc2_:Object = this._2055474372startMarker;
         if(_loc2_ !== param1)
         {
            this._2055474372startMarker = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"startMarker",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _stime() : Number
      {
         return this._1465432895_stime;
      }
      
      private function set _stime(param1:Number) : void
      {
         var _loc2_:Object = this._1465432895_stime;
         if(_loc2_ !== param1)
         {
            this._1465432895_stime = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_stime",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _length() : Number
      {
         return this._1602107397_length;
      }
      
      private function set _length(param1:Number) : void
      {
         var _loc2_:Object = this._1602107397_length;
         if(_loc2_ !== param1)
         {
            this._1602107397_length = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_length",_loc2_,param1));
            }
         }
      }
   }
}
