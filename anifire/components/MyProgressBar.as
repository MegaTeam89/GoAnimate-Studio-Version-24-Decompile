package anifire.components
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mx.controls.ProgressBar;
   import mx.core.IFlexModuleFactory;
   import mx.events.FlexEvent;
   
   public class MyProgressBar extends ProgressBar
   {
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _timer:Timer;
      
      private var _labels:Array;
      
      public function MyProgressBar()
      {
         this._labels = new Array();
         super();
         this.addEventListener("creationComplete",this.___MyProgressBar_ProgressBar1_creationComplete);
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
         super.initialize();
      }
      
      private function init() : void
      {
         this._timer = new Timer(500);
         this._timer.addEventListener(TimerEvent.TIMER,this.animate);
      }
      
      override public function setProgress(param1:Number, param2:Number) : void
      {
         super.setProgress(param1,param2);
         if(this._timer.running)
         {
            this.stopAnimation();
         }
      }
      
      public function startAnimation() : void
      {
         this._timer.start();
      }
      
      private function animate(param1:TimerEvent) : void
      {
         var _loc2_:Number = this.value;
         if(_loc2_ >= 100)
         {
            _loc2_ = 0;
         }
         visible = true;
         super.setProgress(_loc2_ + Math.floor(Math.random() * 20) + 5,100);
      }
      
      public function stopAnimation() : void
      {
         visible = false;
         this._timer.stop();
      }
      
      public function setLabal(param1:String) : void
      {
         this._labels.push(this.label);
         this.label = param1;
      }
      
      public function resetLabel() : void
      {
         if(this._labels.length > 0)
         {
            label = this._labels.pop();
         }
      }
      
      public function ___MyProgressBar_ProgressBar1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
   }
}
