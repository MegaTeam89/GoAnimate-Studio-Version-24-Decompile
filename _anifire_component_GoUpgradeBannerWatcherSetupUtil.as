package
{
   import anifire.component.GoUpgradeBanner;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_component_GoUpgradeBannerWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_component_GoUpgradeBannerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         GoUpgradeBanner.watcherSetupUtil = new _anifire_component_GoUpgradeBannerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}
