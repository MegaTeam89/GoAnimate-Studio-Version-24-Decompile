package anifire.fonts
{
   import anifire.util.FontManager;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public class PlayerFontLoader extends EventDispatcher
   {
       
      
      public function PlayerFontLoader(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function loadFont(param1:String) : void
      {
         this.loadFontFromDataStock(param1);
      }
      
      private function loadFontFromServer(param1:String) : void
      {
         var _loc2_:FontLoader = new FontLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.onFontLoaded);
         _loc2_.loadFont(param1);
      }
      
      private function loadFontFromDataStock(param1:String) : void
      {
         var fontLoader:Loader = null;
         var filename:String = null;
         var fontName:String = param1;
         try
         {
            fontLoader = new Loader();
            fontLoader.name = fontName;
            filename = FontManager.getFontManager().nameToFileName(fontName) + ".swf";
            fontLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontLoaded);
            fontLoader.loadBytes(PlayerFontManager.instance.anime.getDataStock().getPlayerData(filename) as ByteArray);
         }
         catch(e:Error)
         {
            loadFontFromServer(fontName);
         }
      }
      
      private function onFontLoaded(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onFontLoaded);
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
