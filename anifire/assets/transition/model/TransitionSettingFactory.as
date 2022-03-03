package anifire.assets.transition.model
{
   import anifire.assets.transition.AssetTransitionConstants;
   
   public class TransitionSettingFactory
   {
       
      
      public function TransitionSettingFactory()
      {
         super();
      }
      
      public static function createSetting(param1:String) : TransitionSetting
      {
         switch(param1)
         {
            case AssetTransitionConstants.TYPE_HANDSLIDE:
            case AssetTransitionConstants.TYPE_SLIDE:
               return new SlideTransitionSetting();
            case AssetTransitionConstants.TYPE_WIPE:
               return new WipeTransitionSetting();
            default:
               return new TransitionSetting();
         }
      }
   }
}
