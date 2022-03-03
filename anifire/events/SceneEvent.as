package anifire.events
{
   import anifire.core.Asset;
   import flash.events.Event;
   
   public class SceneEvent extends Event
   {
      
      public static const DURATION_CHANGE:String = "DURATION_CHANGE";
      
      public static const DURATION_MODE_CHANGE:String = "DURATION_MODE_CHANGE";
      
      public static const ASSET_ADDED:String = "ASSET_ADDED";
      
      public static const ASSET_REMOVED:String = "ASSET_REMOVED";
      
      public static const ASSET_ORDER_CHANGE:String = "ASSET_ORDER_CHANGE";
      
      public static const CAMERA_ADDED:String = "CAMERA_ADDED";
      
      public static const CAMERA_REMOVED:String = "CAMERA_REMOVED";
      
      public static const TRANSITION_CHANGE:String = "TRANSITION_CHANGE";
       
      
      public var asset:Asset;
      
      public function SceneEvent(param1:String, param2:Asset = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.asset = param2;
      }
   }
}
