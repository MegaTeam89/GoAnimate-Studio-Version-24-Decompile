package
{
   import anifire.components.containers.AssetPurchaseWindow;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_AssetPurchaseWindowWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_containers_AssetPurchaseWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetPurchaseWindow.watcherSetupUtil = new _anifire_components_containers_AssetPurchaseWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[7] = new PropertyWatcher("_textCost",{"propertyChange":true},[param4[9]],param2);
         param5[6] = new PropertyWatcher("_textYou",{"propertyChange":true},[param4[7]],param2);
         param5[5] = new PropertyWatcher("_assetTitle",{"propertyChange":true},[param4[5]],param2);
         param5[9] = new PropertyWatcher("_textDesc",{"propertyChange":true},[param4[13]],param2);
         param5[8] = new PropertyWatcher("_textLink",{"propertyChange":true},[param4[11]],param2);
         param5[7].updateParent(param1);
         param5[6].updateParent(param1);
         param5[5].updateParent(param1);
         param5[9].updateParent(param1);
         param5[8].updateParent(param1);
      }
   }
}
