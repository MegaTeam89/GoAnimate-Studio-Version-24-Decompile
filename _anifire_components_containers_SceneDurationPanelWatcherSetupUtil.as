package
{
   import anifire.components.containers.SceneDurationPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_SceneDurationPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_containers_SceneDurationPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SceneDurationPanel.watcherSetupUtil = new _anifire_components_containers_SceneDurationPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[10] = new PropertyWatcher("rbCustom",{"propertyChange":true},[param4[8]],param2);
         param5[11] = new PropertyWatcher("selected",{
            "valueCommit":true,
            "click":true
         },[param4[8]],null);
         param5[6] = new PropertyWatcher("rbSpeech",{"propertyChange":true},[param4[5]],param2);
         param5[7] = new PropertyWatcher("selected",{
            "valueCommit":true,
            "click":true
         },[param4[5]],null);
         param5[2] = new PropertyWatcher("rbAuto",{"propertyChange":true},[param4[2]],param2);
         param5[3] = new PropertyWatcher("selected",{
            "valueCommit":true,
            "click":true
         },[param4[2]],null);
         param5[10].updateParent(param1);
         param5[10].addChild(param5[11]);
         param5[6].updateParent(param1);
         param5[6].addChild(param5[7]);
         param5[2].updateParent(param1);
         param5[2].addChild(param5[3]);
      }
   }
}
