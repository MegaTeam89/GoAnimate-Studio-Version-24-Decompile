package anifire.debug
{
   import anifire.playback.PlainPlayer;
   import anifire.playback.PlayerEvent;
   import flash.events.IEventDispatcher;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.TextArea;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class PlaybackStatusPanel extends Canvas
   {
       
      
      private var _1783146217_drawingCanvas:Canvas;
      
      private var _951510359console:TextArea;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _plainPlayer:PlainPlayer;
      
      public function PlaybackStatusPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___PlaybackStatusPanel_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":550,
                  "height":100,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TextArea,
                              "id":"console",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "alpha":0.5
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_drawingCanvas",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "height":10
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.width = 550;
         this.height = 100;
         this.addEventListener("creationComplete",this.___PlaybackStatusPanel_Canvas1_creationComplete);
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
               this._plainPlayer.removeEventListener(PlayerEvent.PLAYHEAD_MOVIE_END,this.onMovieEnd);
               this._plainPlayer.removeEventListener(PlayerEvent.PAUSE,this.onMoviePause);
               this._plainPlayer.removeEventListener(PlayerEvent.RESUME,this.onMovieResume);
            }
            this._plainPlayer = param1;
            this._plainPlayer.addEventListener(PlayerEvent.MOVIE_STRUCTURE_READY,this.onMovieStructureReady);
            this._plainPlayer.addEventListener(PlayerEvent.PLAYHEAD_MOVIE_END,this.onMovieEnd);
            this._plainPlayer.addEventListener(PlayerEvent.PAUSE,this.onMoviePause);
            this._plainPlayer.addEventListener(PlayerEvent.RESUME,this.onMovieResume);
            this._drawingCanvas.graphics.clear();
         }
      }
      
      private function onPlayheadChange(param1:PlayerEvent) : void
      {
         var _loc2_:Number = Number(param1.getData()) * 10;
         this._drawingCanvas.graphics.clear();
         this._drawingCanvas.graphics.beginFill(16776960);
         this._drawingCanvas.graphics.drawRect(0,0,_loc2_,10);
         this._drawingCanvas.graphics.endFill();
      }
      
      private function onMovieStructureReady(param1:PlayerEvent) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onMovieStructureReady);
         this.console.text = "Movie structure ready.\n" + this.console.text;
      }
      
      private function onMovieEnd(param1:PlayerEvent) : void
      {
         this.console.text = "Movie end.\n" + this.console.text;
      }
      
      private function onMovieResume(param1:PlayerEvent) : void
      {
         this.console.text = "Movie resume.\n" + this.console.text;
      }
      
      private function onMoviePause(param1:PlayerEvent) : void
      {
         this.console.text = "Movie pause.\n" + this.console.text;
      }
      
      public function ___PlaybackStatusPanel_Canvas1_creationComplete(param1:FlexEvent) : void
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
      public function get console() : TextArea
      {
         return this._951510359console;
      }
      
      public function set console(param1:TextArea) : void
      {
         var _loc2_:Object = this._951510359console;
         if(_loc2_ !== param1)
         {
            this._951510359console = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"console",_loc2_,param1));
            }
         }
      }
   }
}
