package anifire.events
{
   import anifire.constant.AnimeConstants;
   import anifire.event.ExtraDataEvent;
   import anifire.util.UtilUser;
   
   public class ThemeChosenEvent extends ExtraDataEvent
   {
      
      public static const THEME_CHOSEN:String = "theme_chosen";
       
      
      public var themeId:String;
      
      private var _assetType:String;
      
      public function ThemeChosenEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      public function get assetType() : String
      {
         return this._assetType;
      }
      
      public function set assetType(param1:String) : void
      {
         if(this.themeId == "User" && param1 == AnimeConstants.ASSET_TYPE_BG && UtilUser.hasPlusFeatures())
         {
            param1 = AnimeConstants.ASSET_TYPE_TEMPLATE;
         }
         this._assetType = param1;
      }
   }
}
