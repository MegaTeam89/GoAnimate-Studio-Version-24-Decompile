package
{
   import anifire.components.containers.TemplateInfoWindow;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_TemplateInfoWindowWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_containers_TemplateInfoWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TemplateInfoWindow.watcherSetupUtil = new _anifire_components_containers_TemplateInfoWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[1] = new PropertyWatcher("_assetTitle",{"propertyChange":true},[param4[1]],param2);
         param5[3] = new PropertyWatcher("_tags",{"propertyChange":true},[param4[3]],param2);
         param5[1].updateParent(param1);
         param5[3].updateParent(param1);
      }
   }
}
