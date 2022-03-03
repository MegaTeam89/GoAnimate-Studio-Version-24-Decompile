package
{
   import anifire.components.publish.PublishPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_publish_PublishPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_publish_PublishPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PublishPanel.watcherSetupUtil = new _anifire_components_publish_PublishPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[1] = new PropertyWatcher("logo",{"propertyChange":true},[param4[1]],param2);
         param5[8] = new PropertyWatcher("hdButtonDisabled",{"propertyChange":true},[param4[8],param4[12]],param2);
         param5[1].updateParent(param1);
         param5[8].updateParent(param1);
      }
   }
}
