package
{
   import anifire.components.containers.AssetInfoWindow;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_AssetInfoWindowWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_containers_AssetInfoWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetInfoWindow.watcherSetupUtil = new _anifire_components_containers_AssetInfoWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[1] = new PropertyWatcher("_assetTitle",{"propertyChange":true},[param4[1]],param2);
         param5[6] = new PropertyWatcher("_actionList",{"propertyChange":true},[param4[6]],param2);
         param5[3] = new PropertyWatcher("_tags",{"propertyChange":true},[param4[3]],param2);
         param5[1].updateParent(param1);
         param5[6].updateParent(param1);
         param5[3].updateParent(param1);
      }
   }
}
