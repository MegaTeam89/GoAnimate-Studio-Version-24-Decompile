package
{
   import anifire.components.containers.HyperLinkWindow;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_HyperLinkWindowWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_containers_HyperLinkWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         HyperLinkWindow.watcherSetupUtil = new _anifire_components_containers_HyperLinkWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[8] = new PropertyWatcher("_btnRemove",{"propertyChange":true},[param4[3]],param2);
         param5[9] = new PropertyWatcher("width",{"widthChanged":true},[param4[3]],null);
         param5[5] = new PropertyWatcher("txtURLReal",{"propertyChange":true},[param4[3]],param2);
         param5[7] = new PropertyWatcher("width",{"widthChanged":true},[param4[3]],null);
         param5[6] = new PropertyWatcher("x",{"xChanged":true},[param4[3]],null);
         param5[2] = new PropertyWatcher("hostURL",{"propertyChange":true},[param4[2]],param2);
         param5[4] = new PropertyWatcher("width",{"widthChanged":true},[param4[2]],null);
         param5[3] = new PropertyWatcher("x",{"xChanged":true},[param4[2]],null);
         param5[8].updateParent(param1);
         param5[8].addChild(param5[9]);
         param5[5].updateParent(param1);
         param5[5].addChild(param5[7]);
         param5[5].addChild(param5[6]);
         param5[2].updateParent(param1);
         param5[2].addChild(param5[4]);
         param5[2].addChild(param5[3]);
      }
   }
}
