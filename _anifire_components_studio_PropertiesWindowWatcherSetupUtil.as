package
{
   import anifire.components.studio.PropertiesWindow;
   import anifire.managers.FeatureManager;
   import anifire.util.UtilUser;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_PropertiesWindowWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_PropertiesWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PropertiesWindow.watcherSetupUtil = new _anifire_components_studio_PropertiesWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[15] = new StaticPropertyWatcher("hasAdminFeatures",null,[param4[23],param4[25]],null);
         param5[14] = new StaticPropertyWatcher("shouldBubbleUrlBeEditable",null,[param4[20],param4[22]],null);
         param5[0] = new PropertyWatcher("_target",{"propertyChange":true},[param4[0],param4[2],param4[5],param4[11],param4[13],param4[16],param4[19],param4[21],param4[24]],param2);
         param5[15].updateParent(UtilUser);
         param5[14].updateParent(FeatureManager);
         param5[0].updateParent(param1);
      }
   }
}
