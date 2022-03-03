package
{
   import anifire.scene.view.ScenePreview;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_scene_view_ScenePreviewWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_scene_view_ScenePreviewWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ScenePreview.watcherSetupUtil = new _anifire_scene_view_ScenePreviewWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}
