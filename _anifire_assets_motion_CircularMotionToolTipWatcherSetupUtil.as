package
{
   import anifire.assets.motion.CircularMotionToolTip;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_assets_motion_CircularMotionToolTipWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_assets_motion_CircularMotionToolTipWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CircularMotionToolTip.watcherSetupUtil = new _anifire_assets_motion_CircularMotionToolTipWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("glow",{"propertyChange":true},[param4[0]],param2);
         param5[0].updateParent(param1);
      }
   }
}
