package
{
   import anifire.components.containers.SceneOption;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_SceneOptionWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_containers_SceneOptionWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SceneOption.watcherSetupUtil = new _anifire_components_containers_SceneOptionWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[1] = new PropertyWatcher("_effects",{"propertyChange":true},[param4[1]],param2);
         param5[2] = new PropertyWatcher("_eases",{"propertyChange":true},[param4[2]],param2);
         param5[40] = new PropertyWatcher("_directionArr",{"propertyChange":true},[param4[23]],param2);
         param5[1].updateParent(param1);
         param5[2].updateParent(param1);
         param5[40].updateParent(param1);
      }
   }
}
