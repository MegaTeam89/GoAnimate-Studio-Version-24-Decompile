package anifire.playback
{
   import anifire.component.ProcessRegulator;
   import anifire.component.ProgressMonitor;
   import anifire.events.SceneBufferEvent;
   import anifire.util.Util;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.ProgressEvent;
   
   public class SceneBufferManager extends EventDispatcher
   {
      
      public static const MIN_BUFFER_TIME_IN_SEC:Number = 30;
      
      private static var _instance:SceneBufferManager;
      
      private static var _highSpeedMode:Boolean = true;
       
      
      private var _anime:Anime;
      
      private var _bufferingTime:Number = 0;
      
      private var _remainingDurationInSecond:Number = 0;
      
      private var _sceneRegulator:ProcessRegulator;
      
      private var _fromSceneIndex:Number = 0;
      
      private var _isBufferReady:Boolean = false;
      
      public function SceneBufferManager(param1:IEventDispatcher = null)
      {
         this._sceneRegulator = new ProcessRegulator();
         super(param1);
         this._isBufferReady = false;
      }
      
      public static function get instance() : SceneBufferManager
      {
         if(!_instance)
         {
            _instance = new SceneBufferManager();
         }
         return _instance;
      }
      
      public static function get highSpeedMode() : Boolean
      {
         return _highSpeedMode;
      }
      
      public static function set highSpeedMode(param1:Boolean) : void
      {
         _highSpeedMode = param1;
      }
      
      public function get isBufferReady() : Boolean
      {
         return this._isBufferReady;
      }
      
      private function calculateRemainingDurationInSecond() : void
      {
         var _loc2_:AnimeScene = null;
         this._remainingDurationInSecond = 0;
         var _loc1_:uint = this._fromSceneIndex;
         while(_loc1_ < this._anime.getNumScene())
         {
            _loc2_ = this._anime.getSceneByIndex(_loc1_);
            if(_loc2_)
            {
               this._remainingDurationInSecond += _loc2_.durationInSecond;
            }
            _loc1_++;
         }
      }
      
      public function startBuffering(param1:Number, param2:Anime) : void
      {
         this._anime = param2;
         if(this._anime)
         {
            this._bufferingTime = 0;
            this._isBufferReady = false;
            this._fromSceneIndex = param1;
            this.calculateRemainingDurationInSecond();
            this.bufferScene(param1);
         }
      }
      
      private function bufferScene(param1:Number = 0) : void
      {
         var _loc3_:AnimeScene = null;
         this._sceneRegulator.removeEventListener(ProgressEvent.PROGRESS,this.onSceneBuffering);
         this._sceneRegulator.reset();
         ProgressMonitor.getInstance().addProgressEventDispatcher(this);
         var _loc2_:int = param1;
         while(_loc2_ < this._anime.getNumScene())
         {
            _loc3_ = this._anime.getSceneByIndex(_loc2_);
            this._sceneRegulator.addProcess(_loc3_,PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
            _loc2_++;
         }
         this._sceneRegulator.addEventListener(ProgressEvent.PROGRESS,this.onSceneBuffering);
         this._sceneRegulator.startProcess(true);
      }
      
      private function onSceneBuffering(param1:ProgressEvent) : void
      {
         var _loc2_:AnimeScene = this._anime.getSceneByIndex(this._fromSceneIndex + param1.bytesLoaded - 1);
         if(_loc2_)
         {
            this._bufferingTime += _loc2_.durationInSecond;
         }
         var _loc3_:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
         if(param1.bytesLoaded == param1.bytesTotal)
         {
            _loc3_.bytesLoaded = 100;
            _loc3_.bytesTotal = 100;
         }
         else
         {
            _loc3_.bytesLoaded = this._bufferingTime;
            _loc3_.bytesTotal = this.minBufferTimeInSecond;
         }
         if(_loc3_.bytesLoaded / _loc3_.bytesTotal <= 1)
         {
            this.dispatchEvent(_loc3_);
         }
         var _loc4_:SceneBufferEvent;
         (_loc4_ = new SceneBufferEvent(SceneBufferEvent.SCENE_BUFFERED)).sceneIndex = this._fromSceneIndex + param1.bytesLoaded - 1;
         this.dispatchEvent(_loc4_);
         if(this._isBufferReady == false)
         {
            if(this._bufferingTime >= this.minBufferTimeInSecond || param1.bytesLoaded == param1.bytesTotal)
            {
               this._isBufferReady = true;
               this.dispatchEvent(new SceneBufferEvent(SceneBufferEvent.BUFFER_READY));
            }
         }
      }
      
      private function get minBufferTimeInSecond() : Number
      {
         if(Util.isVideoRecording())
         {
            return 9999999;
         }
         return Math.min(MIN_BUFFER_TIME_IN_SEC,this._remainingDurationInSecond);
      }
   }
}
