package
{
   import anifire.component.GoAlert;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_component_GoAlertWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_component_GoAlertWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         GoAlert.watcherSetupUtil = new _anifire_component_GoAlertWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}
