package
{
   import anifire.popups.SceneNumberWarning;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_popups_SceneNumberWarningWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_popups_SceneNumberWarningWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SceneNumberWarning.watcherSetupUtil = new _anifire_popups_SceneNumberWarningWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}
