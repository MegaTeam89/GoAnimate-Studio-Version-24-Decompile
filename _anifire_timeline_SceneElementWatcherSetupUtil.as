package
{
   import anifire.timeline.SceneElement;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_timeline_SceneElementWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_timeline_SceneElementWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SceneElement.watcherSetupUtil = new _anifire_timeline_SceneElementWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[5] = new PropertyWatcher("voiceBevelFilter",{"propertyChange":true},[param4[5]],param2);
         param5[1] = new PropertyWatcher("shadowFilter",{"propertyChange":true},[param4[2]],param2);
         param5[6] = new PropertyWatcher("speechLabel",{"propertyChange":true},[param4[7]],param2);
         param5[7] = new PropertyWatcher("text",{"valueCommit":true},[param4[7]],null);
         param5[0] = new PropertyWatcher("cce",{"propertyChange":true},[param4[0]],param2);
         param5[3] = new PropertyWatcher("_bg",{"propertyChange":true},[param4[4],param4[6],param4[8]],param2);
         param5[4] = new PropertyWatcher("width",{"widthChanged":true},[param4[4],param4[6],param4[8]],null);
         param5[2] = new PropertyWatcher("sceneBevelFilter",{"propertyChange":true},[param4[3]],param2);
         param5[5].updateParent(param1);
         param5[1].updateParent(param1);
         param5[6].updateParent(param1);
         param5[6].addChild(param5[7]);
         param5[0].updateParent(param1);
         param5[3].updateParent(param1);
         param5[3].addChild(param5[4]);
         param5[2].updateParent(param1);
      }
   }
}
