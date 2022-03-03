package anifire.util
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class UtilMovieInfoXMLLoader extends URLLoader
   {
      
      public static const LOAD_COMPLETE:String = "movieinfo_complete";
       
      
      private var req:URLRequest;
      
      private var _loading:Boolean = false;
      
      private var _loaded:Boolean = false;
      
      private var movieInfo:Object;
      
      public function UtilMovieInfoXMLLoader()
      {
         this.movieInfo = {};
         super();
      }
      
      override public function load(param1:URLRequest) : void
      {
         var request:URLRequest = param1;
         this.req = request;
         this.addEventListener(Event.COMPLETE,this.processMovieInfoXml);
         this._loading = true;
         try
         {
            super.load(request);
         }
         catch(err:Error)
         {
            _loading = false;
         }
      }
      
      private function processMovieInfoXml(param1:Event) : void
      {
         var _loc2_:XML = null;
         try
         {
            _loc2_ = XML(param1.target.data);
            this.movieInfo = _loc2_;
         }
         catch(err:Error)
         {
         }
         this._loading = false;
         this._loaded = true;
         dispatchEvent(new Event(LOAD_COMPLETE));
      }
      
      public function get info() : Object
      {
         return this.movieInfo;
      }
      
      public function get loading() : Boolean
      {
         return this._loading;
      }
   }
}
