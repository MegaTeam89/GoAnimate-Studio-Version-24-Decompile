package
{
   import anifire.timeline.SoundContainer;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_timeline_SoundContainerWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_timeline_SoundContainerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SoundContainer.watcherSetupUtil = new _anifire_timeline_SoundContainerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[1] = new PropertyWatcher("width",{"widthChanged":true},[param4[1]],param2);
         param5[1].updateParent(param1);
      }
   }
}
