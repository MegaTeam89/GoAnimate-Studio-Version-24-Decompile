package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.core.SoundThumb;
   import anifire.core.sound.StudioSoundManager;
   import anifire.managers.StudioDragManager;
   import anifire.util.UtilUnitConvert;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import mx.binding.BindingManager;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.IUIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.events.DragEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.managers.DragManager;
   
   public class SoundTrackArea extends Canvas
   {
      
      private static const VERTICAL_GAP:Number = 1;
       
      
      private var _3141bg:Canvas;
      
      private var _433101796dropArea:Canvas;
      
      private var _65731834scrollArea:Canvas;
      
      private var _1956980552shadowFilter:DropShadowFilter;
      
      private var _356359521soundProxy:SoundContainer;
      
      private var _1742657952sound_cs:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function SoundTrackArea()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"click":"___SoundTrackArea_Canvas1_click"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"bg",
                  "events":{"resize":"__bg_resize"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"scrollArea",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":0,
                        "width":9999999,
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"dropArea",
                           "events":{
                              "dragEnter":"__dropArea_dragEnter",
                              "dragOver":"__dropArea_dragOver",
                              "dragExit":"__dropArea_dragExit",
                              "dragDrop":"__dropArea_dragDrop",
                              "click":"__dropArea_click",
                              "mouseMove":"__dropArea_mouseMove",
                              "rollOut":"__dropArea_rollOut"
                           },
                           "stylesFactory":function():void
                           {
                              this.backgroundAlpha = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":9999999,
                                 "percentHeight":100
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":SoundContainer,
                           "id":"soundProxy",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "visible":false,
                                 "height":19,
                                 "mouseChildren":false,
                                 "mouseEnabled":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"sound_cs",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off"
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._SoundTrackArea_DropShadowFilter1_i();
         this.addEventListener("click",this.___SoundTrackArea_Canvas1_click);
      }
      
      public static function trackToPixel(param1:Number) : Number
      {
         return Math.floor(param1 * (SoundContainer.SOUNDCONTAINER_HEIGHT + VERTICAL_GAP));
      }
      
      public static function pixelToTrack(param1:Number) : Number
      {
         return Number(param1 / (SoundContainer.SOUNDCONTAINER_HEIGHT + VERTICAL_GAP));
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
      
      public function scroll(param1:Number) : void
      {
         this.scrollArea.scrollRect = new Rectangle(param1,0,this.width,this.height);
      }
      
      protected function onDragEnter(param1:DragEvent) : void
      {
         if(param1.dragSource.hasFormat(SoundThumb.DRAG_DATA_FORMAT))
         {
            DragManager.acceptDragDrop(param1.target as IUIComponent);
            this.onDragOver(param1);
         }
      }
      
      protected function onDragDrop(param1:DragEvent) : void
      {
         var _loc2_:SoundThumb = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(param1.dragSource.hasFormat(SoundThumb.DRAG_DATA_FORMAT))
         {
            this.soundProxy.visible = false;
            _loc2_ = param1.dragSource.dataForFormat(SoundThumb.DRAG_DATA_FORMAT) as SoundThumb;
            _loc3_ = UtilUnitConvert.xToFrame(this.scrollArea.contentMouseX - 20);
            _loc4_ = SoundTrackArea.pixelToTrack(param1.localY);
            if(param1.dragSource.hasFormat(AnimeSound.DRAG_DATA_FORMAT))
            {
               if(StudioSoundManager.isDuplicatingSound)
               {
                  StudioSoundManager.pasteSoundAt(_loc3_,_loc4_);
                  StudioSoundManager.isDuplicatingSound = false;
               }
            }
            else
            {
               Console.getConsole().addSoundThumbAt(_loc2_,_loc3_,_loc4_);
            }
         }
      }
      
      protected function onDragOver(param1:DragEvent) : void
      {
         var _loc2_:SoundThumb = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:AnimeSound = null;
         var _loc8_:AnimeSound = null;
         var _loc9_:AnimeSound = null;
         if(param1.dragSource.hasFormat(SoundThumb.DRAG_DATA_FORMAT))
         {
            _loc2_ = param1.dragSource.dataForFormat(SoundThumb.DRAG_DATA_FORMAT) as SoundThumb;
            _loc3_ = UtilUnitConvert.xToFrame(this.scrollArea.contentMouseX - 20);
            _loc4_ = SoundTrackArea.pixelToTrack(param1.localY);
            _loc5_ = UtilUnitConvert.secToFrame(_loc2_.duration / 1000);
            _loc6_ = 1;
            (_loc7_ = new AnimeSound()).init(_loc2_,_loc3_,_loc5_);
            if(param1.dragSource.hasFormat(AnimeSound.DRAG_DATA_FORMAT))
            {
               _loc5_ = (_loc7_ = param1.dragSource.dataForFormat(AnimeSound.DRAG_DATA_FORMAT) as AnimeSound).totalFrame;
               _loc6_ = _loc7_.inner_volume;
            }
            _loc3_ = StudioSoundManager.validateStartFrame(_loc3_);
            _loc4_ = StudioSoundManager.validateTrack(_loc4_);
            _loc5_ = StudioSoundManager.validateTotalFrame(_loc5_);
            _loc8_ = StudioSoundManager.getLastSoundBeforeFrameOnTrack(Console.getConsole().sounds,_loc3_,_loc4_);
            _loc9_ = StudioSoundManager.getFirstSoundAfterFrameOnTrack(Console.getConsole().sounds,_loc3_,_loc4_);
            if(StudioSoundManager.getSoundAtFrameOnTrack(Console.getConsole().sounds,_loc3_,_loc4_) != null)
            {
               DragManager.showFeedback(DragManager.NONE);
               this.soundProxy.visible = false;
               return;
            }
            if(_loc8_ && _loc8_.endFrame + AnimeConstants.SOUND_FRAME_INTERVAL >= _loc3_)
            {
               DragManager.showFeedback(DragManager.NONE);
               this.soundProxy.visible = false;
               return;
            }
            if(_loc9_ && _loc9_.startFrame - AnimeConstants.SOUND_FRAME_INTERVAL - AnimeConstants.SOUND_FRAME_MINIMUM < _loc3_)
            {
               DragManager.showFeedback(DragManager.NONE);
               this.soundProxy.visible = false;
               return;
            }
            DragManager.showFeedback(DragManager.COPY);
            this.soundProxy.visible = true;
            if(StudioDragManager.getDragImage(param1.dragSource))
            {
               StudioDragManager.getDragImage(param1.dragSource).visible = false;
            }
            if(_loc9_)
            {
               _loc5_ = Math.min(_loc5_,_loc9_.startFrame - AnimeConstants.SOUND_FRAME_INTERVAL - _loc3_);
            }
            this.updateSoundProxy(_loc2_.name,_loc3_,_loc5_,_loc4_,_loc6_,_loc7_);
         }
      }
      
      private function updateSoundProxy(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:AnimeSound = null) : void
      {
         this.soundProxy.label = param1;
         this.soundProxy.y = SoundTrackArea.trackToPixel(param4);
         this.soundProxy.stime = UtilUnitConvert.frameToX(param2);
         this.soundProxy.slength = UtilUnitConvert.frameToPixel(param3);
         this.soundProxy.inner_volume = param5;
         this.soundProxy.animeSound = param6;
         this.soundProxy.visible = true;
      }
      
      protected function onDragExit(param1:DragEvent) : void
      {
         if(param1.dragSource.hasFormat(SoundThumb.DRAG_DATA_FORMAT))
         {
            this.soundProxy.visible = false;
            if(StudioDragManager.getDragImage(param1.dragSource))
            {
               StudioDragManager.getDragImage(param1.dragSource).visible = true;
            }
         }
      }
      
      protected function onDropAreaClick(param1:MouseEvent) : void
      {
      }
      
      protected function onDropAreaMouseMove(param1:MouseEvent) : void
      {
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         if(!param1.shiftKey)
         {
            StudioSoundManager.isDuplicatingSound = false;
         }
         this.soundProxy.visible = false;
      }
      
      protected function onDropAreaRollOut(param1:MouseEvent) : void
      {
         this.soundProxy.visible = false;
      }
      
      protected function onBgResize(param1:ResizeEvent) : void
      {
         this.bg.graphics.clear();
         this.bg.graphics.lineStyle(1,7829367,1,true);
         var _loc2_:uint = 1;
         while(_loc2_ < 6)
         {
            this.bg.graphics.moveTo(0,_loc2_ * 20 - 1);
            this.bg.graphics.lineTo(this.bg.width,_loc2_ * 20 - 1);
            _loc2_++;
         }
      }
      
      private function _SoundTrackArea_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.inner = true;
         _loc1_.angle = 90;
         _loc1_.color = 6710886;
         _loc1_.distance = 2;
         this.shadowFilter = _loc1_;
         BindingManager.executeBindings(this,"shadowFilter",this.shadowFilter);
         return _loc1_;
      }
      
      public function ___SoundTrackArea_Canvas1_click(param1:MouseEvent) : void
      {
         this.onClick(param1);
      }
      
      public function __bg_resize(param1:ResizeEvent) : void
      {
         this.onBgResize(param1);
      }
      
      public function __dropArea_dragEnter(param1:DragEvent) : void
      {
         this.onDragEnter(param1);
      }
      
      public function __dropArea_dragOver(param1:DragEvent) : void
      {
         this.onDragOver(param1);
      }
      
      public function __dropArea_dragExit(param1:DragEvent) : void
      {
         this.onDragExit(param1);
      }
      
      public function __dropArea_dragDrop(param1:DragEvent) : void
      {
         this.onDragDrop(param1);
      }
      
      public function __dropArea_click(param1:MouseEvent) : void
      {
         this.onDropAreaClick(param1);
      }
      
      public function __dropArea_mouseMove(param1:MouseEvent) : void
      {
         this.onDropAreaMouseMove(param1);
      }
      
      public function __dropArea_rollOut(param1:MouseEvent) : void
      {
         this.onDropAreaRollOut(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get bg() : Canvas
      {
         return this._3141bg;
      }
      
      public function set bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._3141bg;
         if(_loc2_ !== param1)
         {
            this._3141bg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dropArea() : Canvas
      {
         return this._433101796dropArea;
      }
      
      public function set dropArea(param1:Canvas) : void
      {
         var _loc2_:Object = this._433101796dropArea;
         if(_loc2_ !== param1)
         {
            this._433101796dropArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dropArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scrollArea() : Canvas
      {
         return this._65731834scrollArea;
      }
      
      public function set scrollArea(param1:Canvas) : void
      {
         var _loc2_:Object = this._65731834scrollArea;
         if(_loc2_ !== param1)
         {
            this._65731834scrollArea = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scrollArea",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shadowFilter() : DropShadowFilter
      {
         return this._1956980552shadowFilter;
      }
      
      public function set shadowFilter(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._1956980552shadowFilter;
         if(_loc2_ !== param1)
         {
            this._1956980552shadowFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shadowFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get soundProxy() : SoundContainer
      {
         return this._356359521soundProxy;
      }
      
      public function set soundProxy(param1:SoundContainer) : void
      {
         var _loc2_:Object = this._356359521soundProxy;
         if(_loc2_ !== param1)
         {
            this._356359521soundProxy = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundProxy",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sound_cs() : Canvas
      {
         return this._1742657952sound_cs;
      }
      
      public function set sound_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1742657952sound_cs;
         if(_loc2_ !== param1)
         {
            this._1742657952sound_cs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sound_cs",_loc2_,param1));
            }
         }
      }
   }
}
