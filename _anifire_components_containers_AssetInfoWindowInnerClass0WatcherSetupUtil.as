package
{
   import anifire.components.containers.AssetInfoWindowInnerClass0;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_AssetInfoWindowInnerClass0WatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_containers_AssetInfoWindowInnerClass0WatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetInfoWindowInnerClass0.watcherSetupUtil = new _anifire_components_containers_AssetInfoWindowInnerClass0WatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("data",{"dataChange":true},[param4[0],param4[2],param4[3],param4[5]],param2);
         param5[3] = new PropertyWatcher("id",null,[param4[2]],null);
         param5[1] = new PropertyWatcher("name",null,[param4[0]],null);
         param5[4] = new PropertyWatcher("notDefault",null,[param4[3],param4[5]],null);
         param5[0].updateParent(param1);
         param5[0].addChild(param5[3]);
         param5[0].addChild(param5[1]);
         param5[0].addChild(param5[4]);
      }
   }
}
