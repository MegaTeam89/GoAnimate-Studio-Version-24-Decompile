package
{
   import anifire.popups.GoPopUp;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_popups_GoPopUpWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_popups_GoPopUpWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         GoPopUp.watcherSetupUtil = new _anifire_popups_GoPopUpWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}
