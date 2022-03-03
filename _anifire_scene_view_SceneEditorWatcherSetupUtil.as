package
{
   import anifire.scene.view.SceneEditor;
   import mx.binding.IWatcherSetupUtil2;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_scene_view_SceneEditorWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_scene_view_SceneEditorWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SceneEditor.watcherSetupUtil = new _anifire_scene_view_SceneEditorWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
      }
   }
}
