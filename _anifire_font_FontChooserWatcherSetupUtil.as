package
{
   import anifire.font.FontChooser;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_font_FontChooserWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_font_FontChooserWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         FontChooser.watcherSetupUtil = new _anifire_font_FontChooserWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[9] = new PropertyWatcher("innerShadow",{"propertyChange":true},[param4[8]],param2);
         param5[6] = new PropertyWatcher("bgPaletteSection",{"propertyChange":true},[param4[6],param4[7]],param2);
         param5[8] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[7]],null);
         param5[7] = new PropertyWatcher("includeInLayout",{"includeInLayoutChanged":true},[param4[6]],null);
         param5[13] = new PropertyWatcher("_bgColor",{"propertyChange":true},[param4[12],param4[13]],param2);
         param5[11] = new PropertyWatcher("transparentBtn",{"propertyChange":true},[param4[10],param4[11]],param2);
         param5[12] = new PropertyWatcher("visible",{
            "hide":true,
            "show":true
         },[param4[10],param4[11]],null);
         param5[5] = new PropertyWatcher("_color",{"propertyChange":true},[param4[5]],param2);
         param5[3] = new PropertyWatcher("_bold",{"propertyChange":true},[param4[3]],param2);
         param5[9].updateParent(param1);
         param5[6].updateParent(param1);
         param5[6].addChild(param5[8]);
         param5[6].addChild(param5[7]);
         param5[13].updateParent(param1);
         param5[11].updateParent(param1);
         param5[11].addChild(param5[12]);
         param5[5].updateParent(param1);
         param5[3].updateParent(param1);
      }
   }
}
