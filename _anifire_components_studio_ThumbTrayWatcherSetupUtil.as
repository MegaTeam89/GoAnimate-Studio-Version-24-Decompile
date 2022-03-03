package
{
   import anifire.components.studio.ThumbTray;
   import anifire.managers.FeatureManager;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_ThumbTrayWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_ThumbTrayWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ThumbTray.watcherSetupUtil = new _anifire_components_studio_ThumbTrayWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[14] = new PropertyWatcher("btnSearch",{"propertyChange":true},[param4[27]],param2);
         param5[50] = new PropertyWatcher("_uiCanvasVideoPropUser",{"propertyChange":true},[param4[91]],param2);
         param5[4] = new StaticPropertyWatcher("shouldCreateCcButtonBeShown",null,[param4[6],param4[7],param4[12],param4[13],param4[16],param4[17]],null);
         param5[55] = new PropertyWatcher("_uiTilePropHandHeldMovie",{"propertyChange":true},[param4[97]],param2);
         param5[57] = new PropertyWatcher("VSThumbTray",{"propertyChange":true},[param4[99]],param2);
         param5[51] = new PropertyWatcher("_uiCanvasUser",{"propertyChange":true},[param4[93]],param2);
         param5[49] = new PropertyWatcher("_vbTribe",{"propertyChange":true},[param4[88],param4[89],param4[90],param4[92]],param2);
         param5[56] = new PropertyWatcher("_uiTilePropMaskMovie",{"propertyChange":true},[param4[98]],param2);
         param5[58] = new PropertyWatcher("pnlShadow",{"propertyChange":true},[param4[100]],param2);
         param5[48] = new PropertyWatcher("btnImport",{"propertyChange":true},[param4[87]],param2);
         param5[53] = new PropertyWatcher("_uiCanvasCommunity",{"propertyChange":true},[param4[95]],param2);
         param5[14].updateParent(param1);
         param5[50].updateParent(param1);
         param5[4].updateParent(FeatureManager);
         param5[55].updateParent(param1);
         param5[57].updateParent(param1);
         param5[51].updateParent(param1);
         param5[49].updateParent(param1);
         param5[56].updateParent(param1);
         param5[58].updateParent(param1);
         param5[48].updateParent(param1);
         param5[53].updateParent(param1);
      }
   }
}
