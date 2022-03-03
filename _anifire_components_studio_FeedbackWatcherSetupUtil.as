package
{
   import anifire.components.studio.Feedback;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_FeedbackWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_FeedbackWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         Feedback.watcherSetupUtil = new _anifire_components_studio_FeedbackWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[3] = new PropertyWatcher("headingText",{"propertyChange":true},[param4[7]],param2);
         param5[0] = new PropertyWatcher("actionButton",{"propertyChange":true},[param4[0],param4[1],param4[3],param4[4],param4[5],param4[13]],param2);
         param5[5] = new PropertyWatcher("line1",{"propertyChange":true},[param4[9]],param2);
         param5[7] = new PropertyWatcher("line2",{"propertyChange":true},[param4[11]],param2);
         param5[3].updateParent(param1);
         param5[0].updateParent(param1);
         param5[5].updateParent(param1);
         param5[7].updateParent(param1);
      }
   }
}
