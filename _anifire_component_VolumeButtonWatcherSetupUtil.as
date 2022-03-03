package
{
   import anifire.component.VolumeButton;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_component_VolumeButtonWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_component_VolumeButtonWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         VolumeButton.watcherSetupUtil = new _anifire_component_VolumeButtonWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}
