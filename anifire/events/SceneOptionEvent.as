package anifire.events
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class SceneOptionEvent extends Event
   {
      
      public static const TYPE_CHANGED:String = "transition_type_updated";
      
      public static const DURATION_CHANGED:String = "duration_type_updated";
      
      public static const CAM1_CHANGED:String = "cam1_updated";
      
      public static const CAM2_CHANGED:String = "cam2_updated";
      
      public static const ZOOM1_UPDATED:String = "zoom1_updated";
      
      public static const ZOOM2_UPDATED:String = "zoom2_updated";
       
      
      private var _ttype:String;
      
      private var _duration:Number;
      
      private var _rect:Rectangle;
      
      public function SceneOptionEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function get rect() : Rectangle
      {
         return this._rect;
      }
      
      public function set rect(param1:Rectangle) : void
      {
         this._rect = param1;
      }
      
      public function get duration() : Number
      {
         return this._duration;
      }
      
      public function set duration(param1:Number) : void
      {
         this._duration = param1;
      }
      
      public function get ttype() : String
      {
         return this._ttype;
      }
      
      public function set ttype(param1:String) : void
      {
         this._ttype = param1;
      }
   }
}
