package anifire.scene.view
{
   import anifire.core.Console;
   import anifire.events.SceneViewEvent;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SceneThumbnailManager extends EventDispatcher
   {
       
      
      private var _sceneView:DisplayObject;
      
      private var _timer:Timer;
      
      private var _locked:Boolean = false;
      
      public function SceneThumbnailManager(param1:DisplayObject, param2:IEventDispatcher = null)
      {
         this._timer = new Timer(2000,1);
         super(param2);
         this._sceneView = param1;
         param1.addEventListener(SceneViewEvent.VIEW_CHANGE,this.onSceneViewChange);
         param1.addEventListener(SceneViewEvent.VIEW_LOAD_COMPLETE,this.onSceneViewLoadComplete);
      }
      
      private function onSceneViewChange(param1:SceneViewEvent) : void
      {
         if(!this._locked)
         {
            Console.getConsole().doUpdateTimelineByScene(Console.getConsole().currentScene,true);
            this._locked = true;
            this._timer.reset();
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
            this._timer.start();
         }
      }
      
      private function onSceneViewLoadComplete(param1:SceneViewEvent) : void
      {
         Console.getConsole().doUpdateTimelineByScene(Console.getConsole().currentScene,true);
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         Console.getConsole().doUpdateTimelineByScene(Console.getConsole().currentScene,true);
         this._locked = false;
      }
   }
}
