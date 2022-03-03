package
{
   import anifire.tutorial.TutorialManager;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_tutorial_TutorialManagerWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_tutorial_TutorialManagerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TutorialManager.watcherSetupUtil = new _anifire_tutorial_TutorialManagerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("filterBlur",{"propertyChange":true},[param4[0]],param2);
         param5[6] = new PropertyWatcher("_effResize",{"propertyChange":true},[param4[5]],param2);
         param5[1] = new PropertyWatcher("_effMove",{"propertyChange":true},[param4[1],param4[7]],param2);
         param5[9] = new PropertyWatcher("_effFadeOut",{"propertyChange":true},[param4[9],param4[12]],param2);
         param5[4] = new PropertyWatcher("_content",{"propertyChange":true},[param4[4]],param2);
         param5[5] = new PropertyWatcher("height",{"heightChanged":true},[param4[4]],null);
         param5[2] = new PropertyWatcher("_filterShadow",{"propertyChange":true},[param4[2]],param2);
         param5[8] = new PropertyWatcher("_effFadeIn",{"propertyChange":true},[param4[8],param4[11]],param2);
         param5[0].updateParent(param1);
         param5[6].updateParent(param1);
         param5[1].updateParent(param1);
         param5[9].updateParent(param1);
         param5[4].updateParent(param1);
         param5[4].addChild(param5[5]);
         param5[2].updateParent(param1);
         param5[8].updateParent(param1);
      }
   }
}
