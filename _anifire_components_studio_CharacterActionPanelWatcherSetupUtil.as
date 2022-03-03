package
{
   import anifire.components.studio.CharacterActionPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_CharacterActionPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_CharacterActionPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CharacterActionPanel.watcherSetupUtil = new _anifire_components_studio_CharacterActionPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[7] = new PropertyWatcher("btnFacial",{"propertyChange":true},[param4[6]],param2);
         param5[8] = new PropertyWatcher("enabled",{"enabledChanged":true},[param4[6]],null);
         param5[14] = new PropertyWatcher("btnHeadGear",{"propertyChange":true},[param4[11]],param2);
         param5[15] = new PropertyWatcher("enabled",{"enabledChanged":true},[param4[11]],null);
         param5[5] = new PropertyWatcher("actionSelectPanel",{"propertyChange":true},[param4[4],param4[5]],param2);
         param5[6] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[4],param4[5]],null);
         param5[11] = new PropertyWatcher("btnHandHeld",{"propertyChange":true},[param4[9]],param2);
         param5[12] = new PropertyWatcher("enabled",{"enabledChanged":true},[param4[9]],null);
         param5[1] = new PropertyWatcher("btnAction",{"propertyChange":true},[param4[1]],param2);
         param5[2] = new PropertyWatcher("enabled",{"enabledChanged":true},[param4[1]],null);
         param5[18] = new PropertyWatcher("btnRestoreHead",{"propertyChange":true},[param4[14]],param2);
         param5[19] = new PropertyWatcher("enabled",{"enabledChanged":true},[param4[14]],null);
         param5[7].updateParent(param1);
         param5[7].addChild(param5[8]);
         param5[14].updateParent(param1);
         param5[14].addChild(param5[15]);
         param5[5].updateParent(param1);
         param5[5].addChild(param5[6]);
         param5[11].updateParent(param1);
         param5[11].addChild(param5[12]);
         param5[1].updateParent(param1);
         param5[1].addChild(param5[2]);
         param5[18].updateParent(param1);
         param5[18].addChild(param5[19]);
      }
   }
}
