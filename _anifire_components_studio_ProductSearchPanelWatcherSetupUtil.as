package
{
   import anifire.components.studio.ProductSearchPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_ProductSearchPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_ProductSearchPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ProductSearchPanel.watcherSetupUtil = new _anifire_components_studio_ProductSearchPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("btnSearch",{"propertyChange":true},[param4[0]],param2);
         param5[10] = new PropertyWatcher("handPropPanel",{"propertyChange":true},[param4[9]],param2);
         param5[11] = new PropertyWatcher("bgPanel",{"propertyChange":true},[param4[9]],param2);
         param5[3] = new PropertyWatcher("themeSelectPanel",{"propertyChange":true},[param4[3],param4[8]],param2);
         param5[4] = new PropertyWatcher("height",{"heightChanged":true},[param4[3]],null);
         param5[9] = new PropertyWatcher("propPanel",{"propertyChange":true},[param4[9]],param2);
         param5[0].updateParent(param1);
         param5[10].updateParent(param1);
         param5[11].updateParent(param1);
         param5[3].updateParent(param1);
         param5[3].addChild(param5[4]);
         param5[9].updateParent(param1);
      }
   }
}
