package anifire.fonts
{
   import anifire.util.FontManager;
   import anifire.util.UtilNetwork;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class FontLoader extends EventDispatcher
   {
       
      
      private var _url:String;
      
      public function FontLoader(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function loadFont(param1:String) : void
      {
         var _loc2_:Loader = new Loader();
         _loc2_.name = param1;
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadFontComplete);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadFontFail);
         this._url = UtilNetwork.getFont(FontManager.getFontManager().nameToFileName(param1) + ".swf");
         _loc2_.load(new URLRequest(this._url));
      }
      
      private function onLoadFontComplete(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onLoadFontComplete);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onLoadFontFail(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onLoadFontFail);
         throw new Error("Fail to load font!");
      }
   }
}
