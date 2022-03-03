package anifire.debug
{
   import anifire.events.SceneBufferEvent;
   import anifire.interfaces.IIterator;
   import anifire.playback.AnimeScene;
   import anifire.playback.PlainPlayer;
   import anifire.playback.PlayerEvent;
   import anifire.playback.SceneBufferManager;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class TimelineControl extends Canvas
   {
       
      
      private var _1969868915_playhead:Canvas;
      
      private var _349507947_sceneBuffering:Canvas;
      
      private var _1144153660_sceneLayer:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _plainPlayer:PlainPlayer;
      
      public function TimelineControl()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___TimelineControl_Canvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.backgroundColor = 0;
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":550,
                  "height":5,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_sceneLayer",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "toolTip":"not yet buffered scenes"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_sceneBuffering",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "toolTip":"buffered scenes"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_playhead",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16711680;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":3,
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
         this.height = 5;
         this.addEventListener("creationComplete",this.___TimelineControl_Canvas1_creationComplete);
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
         SceneBufferManager.instance.addEventListener(SceneBufferEvent.SCENE_BUFFERED,this.onSceneBuffered);
      }
      
      public function set plainPlayer(param1:PlainPlayer) : void
      {
         if(param1 && param1 != this._plainPlayer)
         {
            if(this._plainPlayer)
            {
               this._plainPlayer.removeEventListener(PlayerEvent.MOVIE_STRUCTURE_READY,this.onMovieStructureReady);
               this._plainPlayer.removeEventListener(Event.ENTER_FRAME,this.onPlayheadChange);
            }
            this._plainPlayer = param1;
            this._plainPlayer.addEventListener(PlayerEvent.MOVIE_STRUCTURE_READY,this.onMovieStructureReady);
            this._plainPlayer.addEventListener(Event.ENTER_FRAME,this.onPlayheadChange);
            this._sceneBuffering.graphics.clear();
            this._sceneLayer.graphics.clear();
         }
      }
      
      private function onMovieStructureReady(param1:PlayerEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:IIterator = null;
         var _loc4_:AnimeScene = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onMovieStructureReady);
         if(this._plainPlayer)
         {
            _loc2_ = this.width / this._plainPlayer.getDuration();
            _loc3_ = this._plainPlayer.iterator();
            _loc7_ = 0;
            this._sceneLayer.graphics.beginFill(65280);
            while(_loc3_.hasNext)
            {
               _loc5_ = ((_loc4_ = _loc3_.next as AnimeScene).getStartFrame() - 1) * _loc2_;
               _loc6_ = _loc4_.getDuration() * _loc2_;
               if(_loc7_ % 2)
               {
                  this._sceneLayer.graphics.beginFill(65280,0.2);
               }
               else
               {
                  this._sceneLayer.graphics.beginFill(255,0.2);
               }
               this._sceneLayer.graphics.drawRect(_loc5_,0,_loc6_,10);
               _loc7_++;
            }
            this._sceneLayer.graphics.endFill();
            _loc6_ = UtilUnitConvert.timeToFrame(SceneBufferManager.MIN_BUFFER_TIME_IN_SEC) * _loc2_;
            this._playhead.graphics.beginFill(16711680);
            this._playhead.graphics.drawRect(0,9,_loc6_,1);
            this._playhead.graphics.endFill();
         }
      }
      
      private function onSceneBuffered(param1:SceneBufferEvent) : void
      {
         var _loc2_:AnimeScene = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this._plainPlayer)
         {
            _loc2_ = this._plainPlayer.getSceneByIndex(param1.sceneIndex);
            if(_loc2_)
            {
               _loc3_ = this.width / this._plainPlayer.getDuration();
               _loc4_ = (_loc2_.getStartFrame() - 1) * _loc3_;
               _loc5_ = _loc2_.getDuration() * _loc3_;
               if(param1.sceneIndex % 2)
               {
                  this._sceneBuffering.graphics.beginFill(65280);
               }
               else
               {
                  this._sceneBuffering.graphics.beginFill(255);
               }
               this._sceneBuffering.graphics.drawRect(_loc4_,0,_loc5_,10);
               this._sceneBuffering.graphics.endFill();
            }
         }
      }
      
      private function onPlayheadChange(param1:Event) : void
      {
         this._playhead.x = (this._plainPlayer.currentFrame - 1) * this.width / this._plainPlayer.getDuration();
      }
      
      public function ___TimelineControl_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      [Bindable(event="propertyChange")]
      public function get _playhead() : Canvas
      {
         return this._1969868915_playhead;
      }
      
      public function set _playhead(param1:Canvas) : void
      {
         var _loc2_:Object = this._1969868915_playhead;
         if(_loc2_ !== param1)
         {
            this._1969868915_playhead = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_playhead",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sceneBuffering() : Canvas
      {
         return this._349507947_sceneBuffering;
      }
      
      public function set _sceneBuffering(param1:Canvas) : void
      {
         var _loc2_:Object = this._349507947_sceneBuffering;
         if(_loc2_ !== param1)
         {
            this._349507947_sceneBuffering = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sceneBuffering",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sceneLayer() : Canvas
      {
         return this._1144153660_sceneLayer;
      }
      
      public function set _sceneLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1144153660_sceneLayer;
         if(_loc2_ !== param1)
         {
            this._1144153660_sceneLayer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sceneLayer",_loc2_,param1));
            }
         }
      }
   }
}
