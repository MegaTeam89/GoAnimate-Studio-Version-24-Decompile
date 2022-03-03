package anifire.managers
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   import mx.managers.CursorManager;
   
   public class StudioStatusManager extends EventDispatcher
   {
      
      private static var _instance:StudioStatusManager;
       
      
      private var _loadRequestCounter:int = 0;
      
      private var _status:String = "Initializing studio...";
      
      private var _statusLog:Array;
      
      public function StudioStatusManager(param1:IEventDispatcher = null)
      {
         super(param1);
         this._statusLog = new Array();
      }
      
      public static function get instance() : StudioStatusManager
      {
         if(_instance == null)
         {
            _instance = new StudioStatusManager();
         }
         return _instance;
      }
      
      private function set _892481550status(param1:String) : void
      {
         this._status = param1;
         this._statusLog.push(param1);
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function setBusy(param1:Boolean = true, param2:Number = 1) : Boolean
      {
         if(param1)
         {
            this._loadRequestCounter += param2;
            if(this._loadRequestCounter == 1)
            {
               CursorManager.setBusyCursor();
               return true;
            }
         }
         else
         {
            this._loadRequestCounter -= param2;
            if(this._loadRequestCounter < 0)
            {
               this._loadRequestCounter = 0;
            }
            if(this._loadRequestCounter == 0)
            {
               CursorManager.removeBusyCursor();
               return true;
            }
         }
         return false;
      }
      
      [Bindable(event="propertyChange")]
      public function set status(param1:String) : void
      {
         var _loc2_:Object = this.status;
         if(_loc2_ !== param1)
         {
            this._892481550status = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"status",_loc2_,param1));
            }
         }
      }
   }
}
