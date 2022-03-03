package
{
   import anifire.component.SharingPanel;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_component_SharingPanelWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_component_SharingPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SharingPanel.watcherSetupUtil = new _anifire_component_SharingPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[1] = new PropertyWatcher("_hboxEmail",{"propertyChange":true},[param4[1],param4[2]],param2);
         param5[3] = new PropertyWatcher("y",{"yChanged":true},[param4[2]],null);
         param5[2] = new PropertyWatcher("x",{"xChanged":true},[param4[1]],null);
         param5[45] = new PropertyWatcher("_btnNewAnimation",{"propertyChange":true},[param4[36]],param2);
         param5[46] = new PropertyWatcher("width",{"widthChanged":true},[param4[36]],null);
         param5[43] = new PropertyWatcher("lblCreateTitle",{"propertyChange":true},[param4[35]],param2);
         param5[44] = new PropertyWatcher("width",{"widthChanged":true},[param4[35]],null);
         param5[41] = new PropertyWatcher("_canCreate",{"propertyChange":true},[param4[35],param4[36]],param2);
         param5[42] = new PropertyWatcher("width",{"widthChanged":true},[param4[35],param4[36]],null);
         param5[31] = new PropertyWatcher("_emailSentText",{"propertyChange":true},[param4[28]],param2);
         param5[4] = new PropertyWatcher("_txtRecEmail",{"propertyChange":true},[param4[2]],param2);
         param5[5] = new PropertyWatcher("y",{"yChanged":true},[param4[2]],null);
         param5[1].updateParent(param1);
         param5[1].addChild(param5[3]);
         param5[1].addChild(param5[2]);
         param5[45].updateParent(param1);
         param5[45].addChild(param5[46]);
         param5[43].updateParent(param1);
         param5[43].addChild(param5[44]);
         param5[41].updateParent(param1);
         param5[41].addChild(param5[42]);
         param5[31].updateParent(param1);
         param5[4].updateParent(param1);
         param5[4].addChild(param5[5]);
      }
   }
}
