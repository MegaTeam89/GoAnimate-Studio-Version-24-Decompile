package
{
   import anifire.components.studio.SpeechComponent;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_SpeechComponentWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_SpeechComponentWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SpeechComponent.watcherSetupUtil = new _anifire_components_studio_SpeechComponentWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[17] = new PropertyWatcher("_boxCloseBtn",{"propertyChange":true},[param4[13]],param2);
         param5[3] = new PropertyWatcher("_boxOpenBtn",{"propertyChange":true},[param4[3],param4[14]],param2);
         param5[4] = new PropertyWatcher("height",{"heightChanged":true},[param4[3]],null);
         param5[12] = new PropertyWatcher("_btnDelete",{"propertyChange":true},[param4[9]],param2);
         param5[13] = new PropertyWatcher("enabled",{"enabledChanged":true},[param4[9]],null);
         param5[5] = new PropertyWatcher("_advPanel",{"propertyChange":true},[param4[4],param4[15],param4[16],param4[17],param4[18]],param2);
         param5[6] = new PropertyWatcher("height",{"heightChanged":true},[param4[4],param4[16],param4[18]],null);
         param5[10] = new PropertyWatcher("_btnSave",{"propertyChange":true},[param4[8]],param2);
         param5[11] = new PropertyWatcher("enabled",{"enabledChanged":true},[param4[8]],null);
         param5[21] = new PropertyWatcher("_images",{"propertyChange":true},[param4[22]],param2);
         param5[22] = new PropertyWatcher("item",{"propertyChange":true},[param4[22]],null);
         param5[17].updateParent(param1);
         param5[3].updateParent(param1);
         param5[3].addChild(param5[4]);
         param5[12].updateParent(param1);
         param5[12].addChild(param5[13]);
         param5[5].updateParent(param1);
         param5[5].addChild(param5[6]);
         param5[10].updateParent(param1);
         param5[10].addChild(param5[11]);
         param5[21].updateParent(param1);
         param5[21].addChild(param5[22]);
      }
   }
}
