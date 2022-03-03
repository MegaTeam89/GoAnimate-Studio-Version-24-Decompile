package anifire.timeline
{
   public class SceneLengthController
   {
      
      public static const FULL_AUTO:String = "full_auto";
      
      public static const ONLY_LENGTHEN:String = "lengthen";
      
      public static const FULL_MANUAL:String = "full_manual";
       
      
      private var _timelineControl:Timeline = null;
      
      private var _userPreference:String = "full_auto";
      
      public function SceneLengthController()
      {
         super();
      }
      
      public function get userPreference() : String
      {
         return this._userPreference;
      }
      
      public function set userPreference(param1:String) : void
      {
         this._userPreference = param1;
      }
      
      private function get timelineControl() : Timeline
      {
         return this._timelineControl;
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
      }
      
      public function doChangeSceneLength(param1:Number, param2:int = -1, param3:Boolean = false) : void
      {
         this.timelineControl.updateSceneLength(param1,param2,param3);
      }
      
      public function doSystemUpdateSceneLength(param1:Number, param2:Number, param3:int, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:Number = 0;
         if(this.userPreference == FULL_MANUAL && !param5)
         {
            return;
         }
         if(param2 > -1)
         {
            _loc6_ = param2;
         }
         else if(this.userPreference == ONLY_LENGTHEN)
         {
            if(param1 > this.timelineControl.getSceneWidthByIndex(param3))
            {
               _loc6_ = param1;
            }
         }
         else
         {
            _loc6_ = param1;
         }
         if(_loc6_)
         {
            this.doChangeSceneLength(_loc6_,param3,param4);
         }
      }
   }
}
