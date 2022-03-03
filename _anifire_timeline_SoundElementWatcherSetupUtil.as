package
{
   import anifire.timeline.SoundElement;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_timeline_SoundElementWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_timeline_SoundElementWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SoundElement.watcherSetupUtil = new _anifire_timeline_SoundElementWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[4] = new PropertyWatcher("height",{"heightChanged":true},[param4[4]],param2);
         param5[0] = new PropertyWatcher("_length",{"propertyChange":true},[param4[0],param4[6]],param2);
         param5[5] = new PropertyWatcher("soundLabel",{"propertyChange":true},[param4[7]],param2);
         param5[6] = new PropertyWatcher("text",{"valueCommit":true},[param4[7]],null);
         param5[1] = new PropertyWatcher("musicBevelFilter",{"propertyChange":true},[param4[1]],param2);
         param5[4].updateParent(param1);
         param5[0].updateParent(param1);
         param5[5].updateParent(param1);
         param5[5].addChild(param5[6]);
         param5[1].updateParent(param1);
      }
   }
}
