package
{
   import anifire.components.publish.MusicPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_publish_MusicPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_publish_MusicPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MusicPanel.watcherSetupUtil = new _anifire_components_publish_MusicPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[13] = new PropertyWatcher("width",{"widthChanged":true},[param4[13]],param2);
         param5[14] = new PropertyWatcher("height",{"heightChanged":true},[param4[14]],param2);
         param5[13].updateParent(param1);
         param5[14].updateParent(param1);
      }
   }
}
