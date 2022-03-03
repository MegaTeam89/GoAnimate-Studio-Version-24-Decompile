package
{
   import anifire.components.studio.ThemeSelection;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_ThemeSelectionWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_ThemeSelectionWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ThemeSelection.watcherSetupUtil = new _anifire_components_studio_ThemeSelectionWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[2] = new PropertyWatcher("shadowFilter",{"propertyChange":true},[param4[1],param4[3],param4[13]],param2);
         param5[0] = new PropertyWatcher("_btnDrop",{"propertyChange":true},[param4[0]],param2);
         param5[1] = new PropertyWatcher("height",null,[param4[0]],null);
         param5[15] = new PropertyWatcher("themeMenu4",{"propertyChange":true},[param4[10],param4[11]],param2);
         param5[16] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[10],param4[11]],null);
         param5[7] = new PropertyWatcher("subPanel",{"propertyChange":true},[param4[2]],param2);
         param5[8] = new PropertyWatcher("height",{"heightChanged":true},[param4[2]],null);
         param5[9] = new PropertyWatcher("themeMenu1",{"propertyChange":true},[param4[4],param4[5]],param2);
         param5[10] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[4],param4[5]],null);
         param5[11] = new PropertyWatcher("themeMenu2",{"propertyChange":true},[param4[6],param4[7]],param2);
         param5[12] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[6],param4[7]],null);
         param5[4] = new PropertyWatcher("_menu",{"propertyChange":true},[param4[2],param4[12]],param2);
         param5[6] = new PropertyWatcher("height",{"heightChanged":true},[param4[2]],null);
         param5[17] = new PropertyWatcher("width",null,[param4[12]],null);
         param5[5] = new PropertyWatcher("y",{"yChanged":true},[param4[2]],null);
         param5[18] = new PropertyWatcher("x",null,[param4[12]],null);
         param5[13] = new PropertyWatcher("themeMenu3",{"propertyChange":true},[param4[8],param4[9]],param2);
         param5[14] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[8],param4[9]],null);
         param5[2].updateParent(param1);
         param5[0].updateParent(param1);
         param5[0].addChild(param5[1]);
         param5[15].updateParent(param1);
         param5[15].addChild(param5[16]);
         param5[7].updateParent(param1);
         param5[7].addChild(param5[8]);
         param5[9].updateParent(param1);
         param5[9].addChild(param5[10]);
         param5[11].updateParent(param1);
         param5[11].addChild(param5[12]);
         param5[4].updateParent(param1);
         param5[4].addChild(param5[6]);
         param5[4].addChild(param5[17]);
         param5[4].addChild(param5[5]);
         param5[4].addChild(param5[18]);
         param5[13].updateParent(param1);
         param5[13].addChild(param5[14]);
      }
   }
}
