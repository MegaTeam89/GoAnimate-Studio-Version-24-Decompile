package anifire.util
{
   import flash.display.DisplayObject;
   
   public class UtilLog
   {
       
      
      public function UtilLog()
      {
         super();
      }
      
      public static function triggerGoPlusFeature(param1:String, param2:DisplayObject) : void
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
         {
            Util.gaTracking("/gostudio/upsell/" + param1,param2);
         }
      }
   }
}
