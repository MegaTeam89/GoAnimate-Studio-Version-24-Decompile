package
{
   import anifire.timeline.SceneContainer;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_timeline_SceneContainerWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_timeline_SceneContainerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SceneContainer.watcherSetupUtil = new _anifire_timeline_SceneContainerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("cce",{"propertyChange":true},[param4[0]],param2);
         param5[0].updateParent(param1);
      }
   }
}
