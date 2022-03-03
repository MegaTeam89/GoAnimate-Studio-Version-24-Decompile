package anifire.managers
{
   import anifire.constant.ServerConstants;
   import anifire.events.SaveMovieCompleteEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   
   public class MovieManager extends EventDispatcher
   {
      
      public static const SAVE_MOVIE_COMPLETE:String = "save_movie_complete";
      
      public static const SAVE_MOVIE_ERROR:String = "save_movie_error";
       
      
      private var _urlStream:URLStream;
      
      public function MovieManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function saveMovie(param1:URLVariables) : void
      {
         var _loc2_:URLRequest = new URLRequest(ServerConstants.get_ACTION_SAVE_MOVIE());
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.data = param1;
         this._urlStream = new URLStream();
         this.addEventListenerToStream();
         this._urlStream.load(_loc2_);
      }
      
      public function saveTemplate(param1:URLVariables) : void
      {
         var _loc2_:URLRequest = new URLRequest(ServerConstants.get_ACTION_SAVE_TEMPLATE());
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.data = param1;
         this._urlStream = new URLStream();
         this.addEventListenerToStream();
         this._urlStream.load(_loc2_);
      }
      
      private function addEventListenerToStream() : void
      {
         this._urlStream.addEventListener(Event.COMPLETE,this.onComplete);
         this._urlStream.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      private function removeListenerFromStream() : void
      {
         this._urlStream.removeEventListener(Event.COMPLETE,this.onComplete);
         this._urlStream.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._urlStream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      private function onError(param1:Event) : void
      {
         this.removeListenerFromStream();
         if(param1.type == IOErrorEvent.IO_ERROR)
         {
            this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
         }
         else if(param1.type == SecurityErrorEvent.SECURITY_ERROR)
         {
            this.dispatchEvent(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR));
         }
      }
      
      private function onComplete(param1:Event) : void
      {
         this.removeListenerFromStream();
         this.dispatchEvent(SaveMovieCompleteEvent.getInstance(this._urlStream));
      }
   }
}
