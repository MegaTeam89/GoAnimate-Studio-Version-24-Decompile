package
{
   import anifire.assets.transition.view.TransitionList;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_assets_transition_view_TransitionListWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_assets_transition_view_TransitionListWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TransitionList.watcherSetupUtil = new _anifire_assets_transition_view_TransitionListWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("dataProvider",{"collectionChange":true},[param4[0]],param2);
         param5[1] = new PropertyWatcher("length",null,[param4[0]],null);
         param5[0].updateParent(param1);
         param5[0].addChild(param5[1]);
      }
   }
}
