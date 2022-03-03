package
{
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _go_fullWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _go_fullWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         go_full.watcherSetupUtil = new _go_fullWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[1] = new PropertyWatcher("_thumbTray",{"propertyChange":true},[param4[1],param4[2]],param2);
         param5[2] = new PropertyWatcher("width",{"widthChanged":true},[param4[1],param4[2]],null);
         param5[1].updateParent(param1);
         param5[1].addChild(param5[2]);
      }
   }
}
