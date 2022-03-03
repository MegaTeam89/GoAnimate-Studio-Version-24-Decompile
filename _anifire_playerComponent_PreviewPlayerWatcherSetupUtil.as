package
{
   import anifire.debug.PlayerDebugManager;
   import anifire.playerComponent.PreviewPlayer;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_playerComponent_PreviewPlayerWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_playerComponent_PreviewPlayerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PreviewPlayer.watcherSetupUtil = new _anifire_playerComponent_PreviewPlayerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[10] = new PropertyWatcher("createYourOwnHeight",{"propertyChange":true},[param4[7]],param2);
         param5[6] = new PropertyWatcher("loading",{"propertyChange":true},[param4[3]],param2);
         param5[7] = new PropertyWatcher("width",{"widthChanged":true},[param4[3]],null);
         param5[1] = new PropertyWatcher("loadingScreen",{"propertyChange":true},[param4[1],param4[3]],param2);
         param5[2] = new PropertyWatcher("width",{"widthChanged":true},[param4[1],param4[3]],null);
         param5[8] = new StaticPropertyWatcher("debugMode",{"propertyChange":true},[param4[4],param4[5]],null);
         param5[9] = new PropertyWatcher("createYourOwnWidth",{"propertyChange":true},[param4[6],param4[8]],param2);
         param5[3] = new PropertyWatcher("createYourOwn",{"propertyChange":true},[param4[1]],param2);
         param5[4] = new PropertyWatcher("width",{"widthChanged":true},[param4[1]],null);
         param5[10].updateParent(param1);
         param5[6].updateParent(param1);
         param5[6].addChild(param5[7]);
         param5[1].updateParent(param1);
         param5[1].addChild(param5[2]);
         param5[8].updateParent(PlayerDebugManager);
         param5[9].updateParent(param1);
         param5[3].updateParent(param1);
         param5[3].addChild(param5[4]);
      }
   }
}
