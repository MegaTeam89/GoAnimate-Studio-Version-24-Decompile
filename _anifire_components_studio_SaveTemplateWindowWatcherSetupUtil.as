package
{
   import anifire.components.studio.SaveTemplateWindow;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_SaveTemplateWindowWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_SaveTemplateWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SaveTemplateWindow.watcherSetupUtil = new _anifire_components_studio_SaveTemplateWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[14] = new PropertyWatcher("_winDone",{"propertyChange":true},[param4[11],param4[12]],param2);
         param5[15] = new PropertyWatcher("height",{"heightChanged":true},[param4[11]],null);
         param5[18] = new PropertyWatcher("width",{"widthChanged":true},[param4[12]],null);
         param5[16] = new PropertyWatcher("_vboxDone",{"propertyChange":true},[param4[11],param4[12]],param2);
         param5[17] = new PropertyWatcher("height",{"heightChanged":true},[param4[11]],null);
         param5[19] = new PropertyWatcher("width",{"widthChanged":true},[param4[12]],null);
         param5[8] = new PropertyWatcher("_vsCaptures",{"propertyChange":true},[param4[8]],param2);
         param5[9] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "creationComplete":true,
            "change":true
         },[param4[8]],null);
         param5[10] = new PropertyWatcher("_captures",{"propertyChange":true},[param4[8]],param2);
         param5[11] = new PropertyWatcher("length",null,[param4[8]],null);
         param5[14].updateParent(param1);
         param5[14].addChild(param5[15]);
         param5[14].addChild(param5[18]);
         param5[16].updateParent(param1);
         param5[16].addChild(param5[17]);
         param5[16].addChild(param5[19]);
         param5[8].updateParent(param1);
         param5[8].addChild(param5[9]);
         param5[10].updateParent(param1);
         param5[10].addChild(param5[11]);
      }
   }
}
