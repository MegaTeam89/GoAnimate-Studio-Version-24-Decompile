package anifire.bubble
{
   import flash.events.Event;
   
   public class BubbleEvent extends Event
   {
      
      public static const TEXT_CHANGED:String = "textChanged";
      
      public static const TEXT_SIZE_CHANGED:String = "TEXT_SIZE_CHANGED";
       
      
      public function BubbleEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
