package
{
   import anifire.playerComponent.playerEndScreen.PlayerEndScreen;
   import mx.binding.IWatcherSetupUtil2;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_playerComponent_playerEndScreen_PlayerEndScreenWatcherSetupUtil implements IWatcherSetupUtil2
   {
       
      
      public function _anifire_playerComponent_playerEndScreen_PlayerEndScreenWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PlayerEndScreen.watcherSetupUtil = new _anifire_playerComponent_playerEndScreen_PlayerEndScreenWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
      {
         param5[22] = new PropertyWatcher("_txtEndReminder1",{"propertyChange":true},[param4[23]],param2);
         param5[24] = new PropertyWatcher("_btnEndReminderPri",{"propertyChange":true},[param4[25],param4[27]],param2);
         param5[23] = new PropertyWatcher("_btnEndReminderPub",{"propertyChange":true},[param4[24],param4[26]],param2);
         param5[22].updateParent(param1);
         param5[24].updateParent(param1);
         param5[23].updateParent(param1);
      }
   }
}
