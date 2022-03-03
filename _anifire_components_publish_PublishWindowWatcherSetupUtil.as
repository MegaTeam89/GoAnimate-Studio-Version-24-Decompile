package
{
   import anifire.components.publish.PublishWindow;
   import anifire.util.UtilUser;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_publish_PublishWindowWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_publish_PublishWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PublishWindow.watcherSetupUtil = new _anifire_components_publish_PublishWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[25] = new StaticPropertyWatcher("loggedIn",null,[param4[22]],null);
         param5[16] = new PropertyWatcher("_vsCaptures",{"propertyChange":true},[param4[16]],param2);
         param5[17] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "creationComplete":true,
            "change":true
         },[param4[16]],null);
         param5[8] = new PropertyWatcher("LANG_ARRAY",null,[param4[8]],param2);
         param5[18] = new PropertyWatcher("_captures",{"propertyChange":true},[param4[16]],param2);
         param5[19] = new PropertyWatcher("length",null,[param4[16]],null);
         param5[25].updateParent(UtilUser);
         param5[16].updateParent(param1);
         param5[16].addChild(param5[17]);
         param5[8].updateParent(param1);
         param5[18].updateParent(param1);
         param5[18].addChild(param5[19]);
      }
   }
}
