package anifire.playback
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ActionFactory extends EventDispatcher
   {
       
      
      public function ActionFactory(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function createAction(param1:XML) : Action
      {
         var _loc2_:Action = null;
         if(param1.hasOwnProperty("@seq"))
         {
            _loc2_ = new SequentialAction();
            SequentialAction(_loc2_).actionSequence.init(String(param1.@seq).split(","));
         }
         else
         {
            _loc2_ = new Action();
         }
         return _loc2_;
      }
   }
}
