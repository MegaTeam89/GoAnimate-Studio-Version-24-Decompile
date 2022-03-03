package anifire.managers
{
   import anifire.core.sound.TTSManager;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   
   public class GoFeatureManager extends FeatureManager
   {
       
      
      public function GoFeatureManager()
      {
         super();
      }
      
      public static function get shouldTTSCreditBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.SCHOOL || UtilSite.siteId == UtilSite.YOUTUBE)
         {
            if(UtilUser.userType == UtilUser.BASIC_USER || TTSManager.credit < 100)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function get shouldTribeOfNoiseBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE)
         {
            return true;
         }
         return false;
      }
      
      public static function get shouldImportButtonBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.siteId == UtilSite.SCHOOL || UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            return true;
         }
         return false;
      }
   }
}
