package anifire.component
{
   import anifire.cc.view.CcHeadComponent;
   import anifire.color.SelectedColor;
   import anifire.constant.CcLibConstant;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.util.UtilColor;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class CustomHeadMaker extends MovieClip
   {
      
      public static const COMPONENT_NEEDS_REPLACE:String = "event_replace_comp";
      
      public static const STATE_NULL:String = "null";
      
      public static const STATE_LOADING:String = "loading";
      
      public static const STATE_FINISH_LOAD:String = "finish_load";
       
      
      private const SKELETON:String = CcLibConstant.COMPONENT_TYPE_SKELETON;
      
      private const BODYSHAPE:String = CcLibConstant.COMPONENT_TYPE_BODYSHAPE;
      
      private const SWF_EXT:String = CcLibConstant.SWF_EXT;
      
      private const NODE_COMPONENT:String = CcLibConstant.NODE_COMPONENT;
      
      private const XML_DESC:String = CcLibConstant.XML_DESC;
      
      private const UPPERBODY:String = CcLibConstant.COMPONENT_TYPE_UPPER_BODY;
      
      private const CLIPUPPER:String = CcLibConstant.CLIPUPPER;
      
      private const LOWERBODY:String = CcLibConstant.COMPONENT_TYPE_LOWER_BODY;
      
      private const CLIPLOWER:String = CcLibConstant.CLIPLOWER;
      
      private const DEFAULTHEAD:String = "defaultHead";
      
      private const LIB_LEFT:String = CcLibConstant.LIB_LEFT;
      
      private const LIB_RIGHT:String = CcLibConstant.LIB_RIGHT;
      
      private var _headXML:XML;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var should_decrypt:Boolean = true;
      
      private var _shouldPauseOnLoadByteComplete:Boolean;
      
      private var _useSpeechMouth:Boolean = false;
      
      private var _state:String;
      
      private var _sceneId:String;
      
      private var _head:CcHeadComponent;
      
      private var _useImageLibrary:Boolean = false;
      
      public function CustomHeadMaker()
      {
         this._head = new CcHeadComponent();
         super();
         this.state = STATE_NULL;
         this._eventDispatcher = new EventDispatcher();
      }
      
      private function get useSpeechMouth() : Boolean
      {
         return this._useSpeechMouth;
      }
      
      private function set useSpeechMouth(param1:Boolean) : void
      {
         this._useSpeechMouth = param1;
      }
      
      public function get shouldPauseOnLoadBytesComplete() : Boolean
      {
         return this._shouldPauseOnLoadByteComplete;
      }
      
      public function set shouldPauseOnLoadBytesComplete(param1:Boolean) : void
      {
         this._shouldPauseOnLoadByteComplete = param1;
      }
      
      private function get headXML() : XML
      {
         return this._headXML;
      }
      
      private function set headXML(param1:XML) : void
      {
         this._headXML = param1;
      }
      
      private function get state() : String
      {
         return this._state;
      }
      
      private function set state(param1:String) : void
      {
         this._state = param1;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function get lookAtCameraSupported() : Boolean
      {
         return this._head.supportLookAtCamera;
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._head.lookAtCamera;
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         this._head.lookAtCamera = param1;
      }
      
      public function set sceneId(param1:String) : void
      {
         this._sceneId = param1;
      }
      
      public function get demoSpeech() : Boolean
      {
         return false;
      }
      
      public function set demoSpeech(param1:Boolean) : void
      {
         if(this._head)
         {
            this._head.useTalkMouth = param1;
         }
      }
      
      public function initBySwfs(param1:XML) : void
      {
         this.initByXml(param1);
      }
      
      public function set useImageLibrary(param1:Boolean) : void
      {
         this._useImageLibrary = param1;
      }
      
      public function init(param1:XML) : void
      {
         this.initByXml(param1);
      }
      
      private function onHeadLoaded(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onHeadLoaded);
         this.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
      }
      
      public function prepareImage(param1:String, param2:Boolean = true) : void
      {
         if(this._useImageLibrary && this._head)
         {
            this._head.prepareImage(param1,param2);
         }
      }
      
      public function initByXml(param1:XML) : void
      {
         this._head.init(param1,this._sceneId,this._useImageLibrary);
         this._head.addEventListener(Event.COMPLETE,this.onHeadLoaded);
         this._head.load();
         this.addChild(this._head);
      }
      
      public function speak(param1:Number) : void
      {
         if(this._head)
         {
            this._head.speak(param1);
         }
      }
      
      public function changeColor(param1:SelectedColor, param2:String = "") : Number
      {
         var _loc3_:DisplayObject = null;
         if(param2 == "")
         {
            _loc3_ = this;
         }
         else
         {
            _loc3_ = UtilPlain.getInstance(this,param2);
         }
         return uint(UtilColor.setAssetPartColor(_loc3_,param1.areaName,param1.dstColor));
      }
      
      public function removeComponentById(param1:String) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         _loc2_ = UtilPlain.getInstance(this,param1);
         var _loc3_:DisplayObjectContainer = _loc2_.parent;
         var _loc4_:int = _loc3_.numChildren - 1;
         while(_loc4_ >= 0)
         {
            if(_loc3_.getChildAt(_loc4_).name == param1)
            {
               _loc3_.removeChildAt(_loc4_);
            }
            _loc4_--;
         }
      }
      
      public function unloadAssetImage(param1:Boolean) : void
      {
         this.destroy(param1);
      }
      
      public function destroy(param1:Boolean = true, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = UtilPlain.getLoaderItem(this);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            Loader(_loc4_[_loc3_]).unloadAndStop(param1);
            Loader(_loc4_[_loc3_]).parent.removeChild(Loader(_loc4_[_loc3_]));
            _loc3_++;
         }
         _loc3_ = this.numChildren;
         while(_loc3_ > 0)
         {
            _loc3_--;
         }
         this.state = STATE_NULL;
         this._eventDispatcher = new EventDispatcher();
         this._head.destroy();
      }
   }
}
