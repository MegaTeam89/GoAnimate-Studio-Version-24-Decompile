package
{
   import anifire.assets.control.AssetResizeToolTip;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_assets_control_AssetResizeToolTipWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_assets_control_AssetResizeToolTipWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetResizeToolTip.watcherSetupUtil = new _anifire_assets_control_AssetResizeToolTipWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("glow",{"propertyChange":true},[param4[0],param4[1]],param2);
         param5[0].updateParent(param1);
      }
   }
}
