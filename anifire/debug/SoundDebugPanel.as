package anifire.debug
{
   import anifire.interfaces.IIterator;
   import anifire.playback.AnimeSound;
   import anifire.playback.EmbedSound;
   import anifire.playback.PlainPlayer;
   import anifire.playback.PlayerEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class SoundDebugPanel extends Canvas
   {
       
      
      private var _1783146217_drawingCanvas:Canvas;
      
      private var _1608507022_soundBuffering:Canvas;
      
      private var _1361291701_soundPlayback:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _plainPlayer:PlainPlayer;
      
      public function SoundDebugPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___SoundDebugPanel_Canvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.backgroundColor = 0;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":550,
                  "height":25,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_drawingCanvas",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_soundBuffering",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_soundPlayback",
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
         super();
         mx_internal::_document = this;
         this.width = 550;
         this.height = 25;
         this.toolTip = "top row is TTS";
         this.addEventListener("creationComplete",this.___SoundDebugPanel_Canvas1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 0;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onCreationComplete() : void
      {
      }
      
      public function set plainPlayer(param1:PlainPlayer) : void
      {
         if(param1 && param1 != this._plainPlayer)
         {
            if(this._plainPlayer)
            {
               this._plainPlayer.removeEventListener(PlayerEvent.MOVIE_STRUCTURE_READY,this.onMovieStructureReady);
            }
            this._plainPlayer = param1;
            this._plainPlayer.addEventListener(PlayerEvent.MOVIE_STRUCTURE_READY,this.onMovieStructureReady);
            this._soundBuffering.graphics.clear();
            this._drawingCanvas.graphics.clear();
         }
      }
      
      private function onMovieStructureReady(param1:PlayerEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:IIterator = null;
         var _loc4_:AnimeSound = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onMovieStructureReady);
         if(this._plainPlayer)
         {
            _loc2_ = this.width / this._plainPlayer.getDuration();
            _loc3_ = this._plainPlayer.iterator("sound");
            this._drawingCanvas.graphics.beginFill(16776960,0.2);
            while(_loc3_.hasNext)
            {
               if(_loc4_ = _loc3_.next as AnimeSound)
               {
                  _loc5_ = (_loc4_.getStartFrame() - 1) * _loc2_;
                  if(_loc4_.isSpeech)
                  {
                     _loc6_ = 0;
                  }
                  else
                  {
                     _loc6_ = (_loc4_.track + 1) * 5;
                  }
                  _loc7_ = _loc4_.getEndFrame() * _loc2_ - _loc5_;
                  if(_loc4_ is EmbedSound)
                  {
                     this._drawingCanvas.graphics.beginFill(16711935);
                  }
                  else
                  {
                     this._drawingCanvas.graphics.beginFill(16776960,0.2);
                  }
                  this._drawingCanvas.graphics.drawRect(_loc5_,_loc6_,_loc7_,5);
                  _loc4_.addEventListener(ProgressEvent.PROGRESS,this.onSoundDownloading);
                  _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.onSoundLoadFailed);
               }
            }
            this._drawingCanvas.graphics.endFill();
         }
      }
      
      private function onSoundDownloading(param1:ProgressEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:AnimeSound = AnimeSound(param1.target);
         if(_loc2_ && param1.bytesTotal > 0)
         {
            _loc3_ = this.width / this._plainPlayer.getDuration();
            _loc4_ = (_loc2_.getStartFrame() - 1) * _loc3_;
            _loc5_ = (_loc2_.track + 1) * 5;
            if(_loc2_.isSpeech)
            {
               _loc5_ = 0;
            }
            _loc6_ = (_loc2_.getEndFrame() * _loc3_ - _loc4_) * param1.bytesLoaded / param1.bytesTotal;
            if(_loc2_ is EmbedSound)
            {
               this._soundBuffering.graphics.beginFill(16711935);
            }
            else
            {
               this._soundBuffering.graphics.beginFill(16776960);
            }
            this._soundBuffering.graphics.drawRect(_loc4_,_loc5_,_loc6_,5);
            this._soundBuffering.graphics.endFill();
         }
      }
      
      private function onSoundLoadFailed(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onSoundLoadFailed);
         var _loc2_:AnimeSound = AnimeSound(param1.target);
         if(_loc2_)
         {
            _loc3_ = this.width / this._plainPlayer.getDuration();
            _loc4_ = (_loc2_.getStartFrame() - 1) * _loc3_;
            _loc5_ = (_loc2_.track + 1) * 5;
            if(_loc2_.isSpeech)
            {
               _loc5_ = 0;
            }
            _loc6_ = _loc2_.getEndFrame() * _loc3_ - _loc4_;
            if(_loc2_ is EmbedSound)
            {
               this._soundBuffering.graphics.beginFill(16711680);
            }
            else
            {
               this._soundBuffering.graphics.beginFill(16711680);
            }
            this._soundBuffering.graphics.drawRect(_loc4_,_loc5_,_loc6_,5);
            this._soundBuffering.graphics.endFill();
         }
      }
      
      public function ___SoundDebugPanel_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      [Bindable(event="propertyChange")]
      public function get _drawingCanvas() : Canvas
      {
         return this._1783146217_drawingCanvas;
      }
      
      public function set _drawingCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1783146217_drawingCanvas;
         if(_loc2_ !== param1)
         {
            this._1783146217_drawingCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_drawingCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _soundBuffering() : Canvas
      {
         return this._1608507022_soundBuffering;
      }
      
      public function set _soundBuffering(param1:Canvas) : void
      {
         var _loc2_:Object = this._1608507022_soundBuffering;
         if(_loc2_ !== param1)
         {
            this._1608507022_soundBuffering = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_soundBuffering",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _soundPlayback() : Canvas
      {
         return this._1361291701_soundPlayback;
      }
      
      public function set _soundPlayback(param1:Canvas) : void
      {
         var _loc2_:Object = this._1361291701_soundPlayback;
         if(_loc2_ !== param1)
         {
            this._1361291701_soundPlayback = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_soundPlayback",_loc2_,param1));
            }
         }
      }
   }
}
