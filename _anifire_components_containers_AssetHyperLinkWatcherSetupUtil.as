package
{
   import anifire.components.containers.AssetHyperLink;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_AssetHyperLinkWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_containers_AssetHyperLinkWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetHyperLink.watcherSetupUtil = new _anifire_components_containers_AssetHyperLinkWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[3] = new PropertyWatcher("mainContent",{"propertyChange":true},[param4[3],param4[4]],param2);
         param5[4] = new PropertyWatcher("btnLink",{"propertyChange":true},[param4[5],param4[6]],param2);
         param5[3].updateParent(param1);
         param5[4].updateParent(param1);
      }
   }
}
