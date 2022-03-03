package template.templateApp.classes
{
   public class Global
   {
      
      public static var development:Boolean = false;
      
      public static const getTemplates:String = "/api/getTemplates";
      
      public static const MOVIE_XML_FILENAME = "content.xml";
      
      public static const GOANIMATE:Number = 0;
      
      public static const UNDERDOG:Number = 1;
      
      public static const STREETFIGHTER:Number = 2;
      
      public static const AKON:Number = 3;
      
      public static const STAR_TREK:Number = 4;
      
      public static const WILLIE:Number = 5;
      
      public static const BUNNY:Number = 6;
      
      public static const DOMO:Number = 7;
      
      public static const BEN10:Number = 8;
      
      public static const FULL_ENERGY:Number = 9;
      
      public static const SCHOOL:Number = 11;
      
      public static var show:Boolean;
      
      public static var selectedTitle:String;
      
      public static var selectedID:String;
      
      public static var designatedSite:Number;
      
      public static var otherSites:String = "";
      
      public static var zipFile;
       
      
      public function Global()
      {
         super();
      }
   }
}
