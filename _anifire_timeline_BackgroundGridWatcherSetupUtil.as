package
{
   import anifire.timeline.BackgroundGrid;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_timeline_BackgroundGridWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_timeline_BackgroundGridWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         BackgroundGrid.watcherSetupUtil = new _anifire_timeline_BackgroundGridWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[1] = new PropertyWatcher("height",{"heightChanged":true},[param4[0]],param2);
         param5[0] = new PropertyWatcher("width",{"widthChanged":true},[param4[0]],param2);
         param5[1].updateParent(param1);
         param5[0].updateParent(param1);
      }
   }
}
