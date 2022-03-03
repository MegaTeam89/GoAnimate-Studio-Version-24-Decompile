package anifire.constant
{
   import anifire.util.Util;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class VoiceConstant extends EventDispatcher
   {
      
      public static var STATUS_NULL:Number = 1;
      
      public static var STATUS_LOADING:Number = 2;
      
      public static var STATUS_DONE:Number = 3;
       
      
      private var _xml:XML;
      
      private var _status:Number;
      
      public function VoiceConstant()
      {
         super();
         this._status = STATUS_NULL;
      }
      
      public function get status() : Number
      {
         return this._status;
      }
      
      public function set status(param1:Number) : void
      {
         this._status = param1;
      }
      
      public function get xml() : XML
      {
         return this._xml;
      }
      
      public function set xml(param1:XML) : void
      {
         this._xml = param1;
      }
      
      private function onLoadXML(param1:Event) : void
      {
         this.xml = new XML(String(URLLoader(param1.currentTarget).data));
         this.status = STATUS_DONE;
         this.dispatchEvent(new Event("XML_LOAD"));
      }
      
      public function getVoiceXML() : void
      {
         var _loc1_:URLVariables = null;
         var _loc2_:URLRequest = null;
         var _loc3_:URLLoader = null;
         if(this.status == STATUS_NULL)
         {
            _loc1_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc1_);
            _loc2_ = new URLRequest(ServerConstants.ACTION_GET_TTSVOICE);
            _loc2_.method = URLRequestMethod.POST;
            _loc2_.data = _loc1_;
            _loc3_ = new URLLoader();
            _loc3_.dataFormat = URLLoaderDataFormat.TEXT;
            _loc3_.addEventListener(Event.COMPLETE,this.onLoadXML);
            _loc3_.load(_loc2_);
            this.status = STATUS_LOADING;
         }
      }
   }
}
