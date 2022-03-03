package
{
   import anifire.assets.panel.AssetViewColorPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_assets_panel_AssetViewColorPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_assets_panel_AssetViewColorPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetViewColorPanel.watcherSetupUtil = new _anifire_assets_panel_AssetViewColorPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}
