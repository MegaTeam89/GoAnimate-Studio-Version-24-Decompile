package anifire.fonts
{
   import anifire.event.LoadMgrEvent;
   import anifire.playback.Anime;
   import anifire.util.UtilLoadMgr;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class PlayerFontManager extends EventDispatcher
   {
      
      private static var _instance:PlayerFontManager;
       
      
      public var anime:Anime;
      
      private var _fontNameList:Array;
      
      public function PlayerFontManager(param1:IEventDispatcher = null)
      {
         this._fontNameList = new Array();
         super(param1);
      }
      
      public static function get instance() : PlayerFontManager
      {
         if(_instance == null)
         {
            _instance = new PlayerFontManager();
         }
         return _instance;
      }
      
      public function addFont(param1:String) : void
      {
         if(param1 && param1 != "" && this._fontNameList.indexOf(param1) == -1)
         {
            this._fontNameList.push(param1);
         }
      }
      
      public function loadAllFonts() : void
      {
         var _loc1_:UtilLoadMgr = null;
         var _loc2_:PlayerFontLoader = null;
         var _loc3_:int = 0;
         if(this._fontNameList.length > 0)
         {
            _loc1_ = new UtilLoadMgr();
            _loc1_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onAllFontsLoaded);
            _loc3_ = 0;
            while(_loc3_ < this._fontNameList.length)
            {
               _loc2_ = new PlayerFontLoader();
               _loc1_.addEventDispatcher(_loc2_,Event.COMPLETE);
               _loc2_.loadFont(this._fontNameList[_loc3_]);
               _loc3_++;
            }
            _loc1_.commit();
         }
         else
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function onAllFontsLoaded(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onAllFontsLoaded);
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
