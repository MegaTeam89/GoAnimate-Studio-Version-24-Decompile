package anifire.debug
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class PlayerDebugManager extends EventDispatcher
   {
      
      public static var _198450538debugMode:Boolean = false;
      
      private static var _staticBindingEventDispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function PlayerDebugManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      [Bindable(event="propertyChange")]
      public static function get debugMode() : Boolean
      {
         return PlayerDebugManager._198450538debugMode;
      }
      
      public static function set debugMode(param1:Boolean) : void
      {
         var _loc3_:IEventDispatcher = null;
         var _loc2_:Object = PlayerDebugManager._198450538debugMode;
         switch(param1)
         {
            default:
               _loc3_.dispatchEvent(PropertyChangeEvent.createUpdateEvent(PlayerDebugManager,"debugMode",_loc2_,param1));
               break;
            case _loc2_:
            case _loc3_:
         }
      }
      
      public static function get staticEventDispatcher() : IEventDispatcher
      {
         return _staticBindingEventDispatcher;
      }
   }
}
