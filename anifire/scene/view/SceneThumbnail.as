package anifire.scene.view
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   import anifire.events.AssetViewEvent;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.utils.Timer;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class SceneThumbnail extends Canvas
   {
       
      
      private var _625717802photoCanvas:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _target:Object;
      
      private var _timer:Timer;
      
      private var _locked:Boolean = false;
      
      private const BG_COLOR:uint = 14540253;
      
      public function SceneThumbnail()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"photoCanvas",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":80,
                        "height":80
                     };
                  }
               })]};
            }
         });
         this._timer = new Timer(2000,1);
         super();
         mx_internal::_document = this;
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
      
      public function set target(param1:Object) : void
      {
         if(this._target is IEventDispatcher)
         {
            this._target.removeEventListener(AssetViewEvent.VIEW_CHANGE,this.onViewChange);
         }
         this._target = param1;
         this.updateThumbnail();
         if(this._target is IEventDispatcher)
         {
            this._target.addEventListener(AssetViewEvent.VIEW_CHANGE,this.onViewChange);
         }
      }
      
      private function onViewChange(param1:AssetViewEvent) : void
      {
         if(!this._locked)
         {
            this.updateThumbnail();
            this._locked = true;
            this._timer.reset();
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
            this._timer.start();
         }
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this.updateThumbnail();
         this._locked = false;
      }
      
      private function updateThumbnail() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:Matrix = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:AnimeScene = null;
         var _loc6_:int = 0;
         var _loc7_:BitmapData = null;
         var _loc8_:Number = NaN;
         var _loc9_:Matrix = null;
         var _loc10_:BitmapData = null;
         this.photoCanvas.removeAllChildren();
         this.photoCanvas.graphics.clear();
         if(this._target)
         {
            _loc1_ = null;
            _loc2_ = new Matrix();
            _loc3_ = 0;
            _loc4_ = 0;
            if(this._target is AnimeScene)
            {
               _loc5_ = AnimeScene(this._target);
               _loc6_ = Console.getConsole().getSceneIndex(_loc5_);
               _loc7_ = Console.getConsole().timeline.getSceneImageBitmapByIndex(_loc6_);
               _loc8_ = this.photoCanvas.width / _loc7_.width;
               (_loc9_ = new Matrix()).scale(_loc8_,_loc8_);
               _loc3_ = (this.photoCanvas.width - _loc8_ * _loc7_.width) / 2;
               _loc4_ = (this.photoCanvas.height - _loc8_ * _loc7_.height) / 2;
               _loc9_.translate(_loc3_,_loc4_);
               (_loc10_ = new BitmapData(this.photoCanvas.width,this.photoCanvas.height)).draw(_loc7_,_loc9_);
               _loc1_ = _loc10_;
            }
            this.photoCanvas.graphics.beginFill(this.BG_COLOR);
            if(_loc1_)
            {
               this.photoCanvas.graphics.beginBitmapFill(_loc1_,new Matrix(),false,true);
            }
            this.photoCanvas.graphics.drawRoundRect(0,0,this.photoCanvas.width,this.photoCanvas.height,10,10);
            this.photoCanvas.graphics.endFill();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get photoCanvas() : Canvas
      {
         return this._625717802photoCanvas;
      }
      
      public function set photoCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._625717802photoCanvas;
         if(_loc2_ !== param1)
         {
            this._625717802photoCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"photoCanvas",_loc2_,param1));
            }
         }
      }
   }
}
