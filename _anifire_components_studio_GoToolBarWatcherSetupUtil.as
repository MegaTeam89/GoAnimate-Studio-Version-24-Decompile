package
{
   import anifire.components.studio.GoToolBar;
   import anifire.util.UtilSite;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_GoToolBarWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_GoToolBarWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         GoToolBar.watcherSetupUtil = new _anifire_components_studio_GoToolBarWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[11] = new PropertyWatcher("_btnUndo",{"propertyChange":true},[param4[18]],param2);
         param5[9] = new PropertyWatcher("_btnCopy",{"propertyChange":true},[param4[16]],param2);
         param5[12] = new PropertyWatcher("_btnRedo",{"propertyChange":true},[param4[19]],param2);
         param5[10] = new PropertyWatcher("_btnPaste",{"propertyChange":true},[param4[17]],param2);
         param5[8] = new StaticPropertyWatcher("isDevelopmentSite",null,[param4[8],param4[9],param4[10],param4[11],param4[12],param4[13],param4[14],param4[15]],null);
         param5[11].updateParent(param1);
         param5[9].updateParent(param1);
         param5[12].updateParent(param1);
         param5[10].updateParent(param1);
         param5[8].updateParent(UtilSite);
      }
   }
}
