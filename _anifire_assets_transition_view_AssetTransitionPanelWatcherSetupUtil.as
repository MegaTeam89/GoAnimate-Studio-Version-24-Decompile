package
{
   import anifire.assets.transition.view.AssetTransitionPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_assets_transition_view_AssetTransitionPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_assets_transition_view_AssetTransitionPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetTransitionPanel.watcherSetupUtil = new _anifire_assets_transition_view_AssetTransitionPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[12] = new PropertyWatcher("listAfterNarration",{"propertyChange":true},[param4[11],param4[12]],param2);
         param5[13] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[11]],null);
         param5[14] = new PropertyWatcher("includeInLayout",{"includeInLayoutChanged":true},[param4[12]],null);
         param5[7] = new PropertyWatcher("listWithNarration",{"propertyChange":true},[param4[5],param4[6],param4[8],param4[9]],param2);
         param5[8] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[5],param4[8]],null);
         param5[9] = new PropertyWatcher("includeInLayout",{"includeInLayoutChanged":true},[param4[6],param4[9]],null);
         param5[4] = new PropertyWatcher("height",{"heightChanged":true},[param4[4]],param2);
         param5[5] = new PropertyWatcher("vs",{"propertyChange":true},[param4[4]],param2);
         param5[6] = new PropertyWatcher("height",{"heightChanged":true},[param4[4]],null);
         param5[12].updateParent(param1);
         param5[12].addChild(param5[13]);
         param5[12].addChild(param5[14]);
         param5[7].updateParent(param1);
         param5[7].addChild(param5[8]);
         param5[7].addChild(param5[9]);
         param5[4].updateParent(param1);
         param5[5].updateParent(param1);
         param5[5].addChild(param5[6]);
      }
   }
}
