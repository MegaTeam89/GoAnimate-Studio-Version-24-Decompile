package anifire.scene.model
{
   import anifire.command.ICommand;
   import anifire.command.RemoveSceneCommand;
   import anifire.constant.AnimeConstants;
   import anifire.constant.LicenseConstants;
   import anifire.core.AnimeScene;
   import anifire.core.EffectThumb;
   import anifire.core.MovieData;
   import anifire.core.ProgramEffectAsset;
   import anifire.core.Theme;
   import anifire.interfaces.IIterator;
   import anifire.managers.ThemeManager;
   import anifire.popups.GoPopUp;
   import anifire.popups.SceneNumberWarning;
   import anifire.timeline.Timeline;
   import anifire.util.UtilDict;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.core.FlexGlobals;
   import mx.core.IFlexDisplayObject;
   import mx.managers.PopUpManager;
   
   public class SceneManager extends EventDispatcher
   {
      
      private static var _copiedScene:String = null;
       
      
      public function SceneManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get copiedScene() : String
      {
         return _copiedScene;
      }
      
      public static function set copiedScene(param1:String) : void
      {
         _copiedScene = param1;
      }
      
      public static function copyScene(param1:AnimeScene) : void
      {
         var scene:AnimeScene = param1;
         try
         {
            if(scene)
            {
               _copiedScene = scene.serialize(-1,false);
            }
         }
         catch(e:Error)
         {
            _copiedScene = null;
         }
      }
      
      public static function deleteSelectedScene(param1:MovieData, param2:Timeline) : void
      {
         var _loc3_:IIterator = null;
         var _loc4_:AnimeScene = null;
         var _loc5_:int = 0;
         var _loc6_:ICommand = null;
         var _loc7_:IFlexDisplayObject = null;
         if(param1 && param2)
         {
            _loc3_ = param1.selection.iterator();
            while(_loc3_.hasNext)
            {
               _loc4_ = _loc3_.next as AnimeScene;
               _loc5_ = param1.getSceneIndex(_loc4_);
               if(param2.getNumOfSoundStartAtScene(_loc5_) > 0)
               {
                  (_loc7_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,GoPopUp,true)).width = 500;
                  _loc7_.y = 100;
                  _loc7_.x = (_loc7_.stage.width - _loc7_.width) / 2;
                  GoPopUp(_loc7_).text = UtilDict.toDisplay("go","goalert_removesound");
                  return;
               }
            }
            (_loc6_ = new RemoveSceneCommand(param1,param1.selection,param2)).execute();
         }
      }
      
      public static function addDefaultZoomEffect(param1:AnimeScene) : void
      {
         var _loc3_:EffectThumb = null;
         var _loc4_:ProgramEffectAsset = null;
         var _loc2_:Theme = ThemeManager.instance.getTheme("common");
         if(_loc2_)
         {
            _loc3_ = _loc2_.getEffectThumbById("cut");
            if(_loc3_)
            {
               (_loc4_ = new ProgramEffectAsset()).thumb = _loc3_;
               _loc4_.scene = param1;
               _loc4_.x = AnimeConstants.SCREEN_X;
               _loc4_.y = !!LicenseConstants.isWideScreen() ? Number(AnimeConstants.WIDE_SCREEN_Y) : Number(AnimeConstants.SCREEN_Y);
               _loc4_.width = AnimeConstants.SCREEN_WIDTH;
               _loc4_.height = !!LicenseConstants.isWideScreen() ? Number(AnimeConstants.WIDE_SCREEN_HEIGHT) : Number(AnimeConstants.SCREEN_HEIGHT);
               _loc4_.stzoom = param1.duration;
               param1.addAsset(_loc4_);
            }
         }
      }
      
      public static function checkSceneNum(param1:Number) : void
      {
         var _loc4_:IFlexDisplayObject = null;
         var _loc2_:Number = 150;
         var _loc3_:Number = 200;
         if(param1 < _loc2_)
         {
            return;
         }
         if(param1 == _loc3_)
         {
            (_loc4_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,SceneNumberWarning,true)).width = 500;
            _loc4_.y = 100;
            _loc4_.x = (_loc4_.stage.width - _loc4_.width) / 2;
            SceneNumberWarning(_loc4_).text = UtilDict.toDisplay("go","Your movie contains a very large number (>200) of scenes.  Please save often as our studio may have issues due to the complexity.\nWe strongly recommend splitting your project into shorter episodes to ensure the best studio experience.\nWe continue to work on studio enhancements to support longer movies such as yours.  Thank you for your patience.");
         }
         else if(param1 == _loc2_)
         {
            (_loc4_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,SceneNumberWarning,true)).width = 500;
            _loc4_.y = 100;
            _loc4_.x = (_loc4_.stage.width - _loc4_.width) / 2;
            SceneNumberWarning(_loc4_).text = UtilDict.toDisplay("go","Your movie contains a large number of scenes.  Some features in our studio may slow down due to the complexity.\nWe recommend splitting your project into shorter episodes to ensure the best studio experience.\nWe continue to work on studio enhancements to support longer movies such as yours.  Thank you for your patience.");
         }
      }
   }
}
