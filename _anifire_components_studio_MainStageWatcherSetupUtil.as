package
{
   import anifire.components.studio.MainStage;
   import anifire.managers.StudioStatusManager;
   import anifire.util.UtilSite;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_MainStageWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_MainStageWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MainStage.watcherSetupUtil = new _anifire_components_studio_MainStageWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[14] = new PropertyWatcher("_zoomControl",{"propertyChange":true},[param4[12],param4[13]],param2);
         param5[15] = new PropertyWatcher("_bottomControlBar",{"propertyChange":true},[param4[14],param4[16],param4[18],param4[20],param4[23]],param2);
         param5[2] = new StaticPropertyWatcher("instance",null,[param4[2]],null);
         param5[3] = new PropertyWatcher("status",{"propertyChange":true},[param4[2]],null);
         param5[11] = new PropertyWatcher("_uiCanvasAutoSave",{"propertyChange":true},[param4[7],param4[8],param4[9]],param2);
         param5[9] = new PropertyWatcher("_zoomSlider",{"propertyChange":true},[param4[6]],param2);
         param5[10] = new PropertyWatcher("value",{
            "valueCommit":true,
            "change":true
         },[param4[6]],null);
         param5[18] = new PropertyWatcher("sceneIndexStr",{"propertyChange":true},[param4[17]],param2);
         param5[21] = new PropertyWatcher("toolBar",{"propertyChange":true},[param4[22]],param2);
         param5[7] = new PropertyWatcher("percentFormatter",{"propertyChange":true},[param4[6]],param2);
         param5[1] = new StaticPropertyWatcher("isDevelopmentSite",null,[param4[1]],null);
         param5[14].updateParent(param1);
         param5[15].updateParent(param1);
         param5[2].updateParent(StudioStatusManager);
         param5[2].addChild(param5[3]);
         param5[11].updateParent(param1);
         param5[9].updateParent(param1);
         param5[9].addChild(param5[10]);
         param5[18].updateParent(param1);
         param5[21].updateParent(param1);
         param5[7].updateParent(param1);
         param5[1].updateParent(UtilSite);
      }
   }
}
