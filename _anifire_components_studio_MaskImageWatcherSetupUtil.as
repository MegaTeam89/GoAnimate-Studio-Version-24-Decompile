package
{
   import anifire.components.studio.MaskImage;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_MaskImageWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_MaskImageWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MaskImage.watcherSetupUtil = new _anifire_components_studio_MaskImageWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[2] = new PropertyWatcher("_canStep3",{"propertyChange":true},[param4[2],param4[5],param4[8],param4[9]],param2);
         param5[1] = new PropertyWatcher("_canStep2",{"propertyChange":true},[param4[1],param4[4],param4[7],param4[9]],param2);
         param5[0] = new PropertyWatcher("_canStep1",{"propertyChange":true},[param4[0],param4[3],param4[6],param4[9]],param2);
         param5[2].updateParent(param1);
         param5[1].updateParent(param1);
         param5[0].updateParent(param1);
      }
   }
}
