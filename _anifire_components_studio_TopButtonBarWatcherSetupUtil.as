package
{
   import anifire.components.studio.TopButtonBar;
   import anifire.managers.FeatureManager;
   import anifire.util.Util;
   import mx.binding.FunctionReturnWatcher;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_TopButtonBarWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_TopButtonBarWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TopButtonBar.watcherSetupUtil = new _anifire_components_studio_TopButtonBarWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         var target:Object = param1;
         var propertyGetter:Function = param2;
         var staticPropertyGetter:Function = param3;
         var bindings:Array = param4;
         var watchers:Array = param5;
         watchers[10] = new FunctionReturnWatcher("getFlashVar",target,function():Array
         {
            return [];
         },null,[bindings[11]],null);
         watchers[4] = new StaticPropertyWatcher("shouldIdeaButtonBeShown",null,[bindings[4],bindings[5]],null);
         watchers[15] = new PropertyWatcher("_btnPreview",{"propertyChange":true},[bindings[14]],propertyGetter);
         watchers[20] = new PropertyWatcher("_vRule",{"propertyChange":true},[bindings[20]],propertyGetter);
         watchers[21] = new PropertyWatcher("_btnMoreMenu",{"propertyChange":true},[bindings[21]],propertyGetter);
         watchers[13] = new PropertyWatcher("_btnSave",{"propertyChange":true},[bindings[12],bindings[15]],propertyGetter);
         watchers[16] = new PropertyWatcher("_container",{"propertyChange":true},[bindings[16],bindings[22]],propertyGetter);
         watchers[19] = new PropertyWatcher("_btnRecord",{"propertyChange":true},[bindings[19]],propertyGetter);
         watchers[10].updateParent(Util);
         watchers[4].updateParent(FeatureManager);
         watchers[15].updateParent(target);
         watchers[20].updateParent(target);
         watchers[21].updateParent(target);
         watchers[13].updateParent(target);
         watchers[16].updateParent(target);
         watchers[19].updateParent(target);
      }
   }
}
