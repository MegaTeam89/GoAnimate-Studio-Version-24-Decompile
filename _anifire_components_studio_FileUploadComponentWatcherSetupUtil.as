package
{
   import anifire.components.studio.FileUploadComponent;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_FileUploadComponentWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_components_studio_FileUploadComponentWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         FileUploadComponent.watcherSetupUtil = new _anifire_components_studio_FileUploadComponentWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[0] = new PropertyWatcher("width",{"widthChanged":true},[param4[0]],param2);
         param5[1] = new PropertyWatcher("_btnBrowse",{"propertyChange":true},[param4[0]],param2);
         param5[2] = new PropertyWatcher("width",{"widthChanged":true},[param4[0]],null);
         param5[3] = new PropertyWatcher("_txtFile",{"propertyChange":true},[param4[1],param4[2],param4[3],param4[4]],param2);
         param5[7] = new PropertyWatcher("height",{"heightChanged":true},[param4[4]],null);
         param5[6] = new PropertyWatcher("width",{"widthChanged":true},[param4[3]],null);
         param5[5] = new PropertyWatcher("y",{"yChanged":true},[param4[2]],null);
         param5[4] = new PropertyWatcher("x",{"xChanged":true},[param4[1]],null);
         param5[0].updateParent(param1);
         param5[1].updateParent(param1);
         param5[1].addChild(param5[2]);
         param5[3].updateParent(param1);
         param5[3].addChild(param5[7]);
         param5[3].addChild(param5[6]);
         param5[3].addChild(param5[5]);
         param5[3].addChild(param5[4]);
      }
   }
}
