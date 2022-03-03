package anifire.assets.transition.model
{
   import flash.events.Event;
   
   public class AssetTransitionEvent extends Event
   {
      
      public static const SECTION_CHANGE:String = "SECTION_CHANGE";
      
      public static const TIMING_CHANGE:String = "TIMING_CHANGE";
      
      public static const CONFLICT_CHANGE:String = "CONFLICT_CHANGE";
       
      
      public function AssetTransitionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
