package
{
   import anifire.component.DoubleStateButton;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_component_DoubleStateButtonWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_component_DoubleStateButtonWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         DoubleStateButton.watcherSetupUtil = new _anifire_component_DoubleStateButtonWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("but1Label",{"propertyChange":true},[param4[0]],param2);
         param5[1] = new PropertyWatcher("but1StyleName",{"propertyChange":true},[param4[1]],param2);
         param5[3] = new PropertyWatcher("but2StyleName",{"propertyChange":true},[param4[3]],param2);
         param5[2] = new PropertyWatcher("but2Label",{"propertyChange":true},[param4[2]],param2);
         param5[0].updateParent(param1);
         param5[1].updateParent(param1);
         param5[3].updateParent(param1);
         param5[2].updateParent(param1);
      }
   }
}
