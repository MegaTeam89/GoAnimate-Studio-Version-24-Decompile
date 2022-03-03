package anifire.preloader
{
   import anifire.banner.GoSchoolBanner;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import mx.events.FlexEvent;
   import mx.preloaders.IPreloaderDisplay;
   
   public class GoSchoolPreloader extends Sprite implements IPreloaderDisplay
   {
       
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      private var _bar:PreloaderProgressBar;
      
      public function GoSchoolPreloader()
      {
         super();
         this.visible = false;
      }
      
      public function set preloader(param1:Sprite) : void
      {
         var preloader:Sprite = param1;
         preloader.addEventListener(ProgressEvent.PROGRESS,this.handleProgress);
         preloader.addEventListener(Event.COMPLETE,this.handleComplete);
         preloader.addEventListener(FlexEvent.INIT_PROGRESS,this.handleInitProgress);
         preloader.addEventListener(FlexEvent.INIT_COMPLETE,this.handleInitComplete);
         var tlang:String = "en_US";
         try
         {
            tlang = preloader.loaderInfo.parameters["tlang"];
         }
         catch(e:Error)
         {
            tlang = "en_US";
         }
         var banner:GoSchoolBanner = new GoSchoolBanner();
         banner.init(tlang);
         this.addChild(banner);
         this._bar = new PreloaderProgressBar();
         this._bar.x = 200;
         this._bar.y = 285;
         banner.addChild(this._bar);
      }
      
      public function initialize() : void
      {
      }
      
      private function handleProgress(param1:ProgressEvent) : void
      {
         this._bar.progress = param1.bytesLoaded / param1.bytesTotal;
         this.centerPreloader();
      }
      
      private function handleComplete(param1:Event) : void
      {
      }
      
      private function handleInitProgress(param1:Event) : void
      {
      }
      
      private function handleInitComplete(param1:Event) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function dispatchComplete(param1:TimerEvent) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function get backgroundColor() : uint
      {
         return 16777215;
      }
      
      public function set backgroundColor(param1:uint) : void
      {
      }
      
      public function get backgroundAlpha() : Number
      {
         return 0;
      }
      
      public function set backgroundAlpha(param1:Number) : void
      {
      }
      
      public function get backgroundImage() : Object
      {
         return undefined;
      }
      
      public function set backgroundImage(param1:Object) : void
      {
      }
      
      public function get backgroundSize() : String
      {
         return "";
      }
      
      public function set backgroundSize(param1:String) : void
      {
      }
      
      public function get stageWidth() : Number
      {
         return this._width;
      }
      
      public function set stageWidth(param1:Number) : void
      {
         this._width = param1;
      }
      
      public function get stageHeight() : Number
      {
         return this._height;
      }
      
      public function set stageHeight(param1:Number) : void
      {
         this._height = param1;
      }
      
      private function centerPreloader() : void
      {
         if(stage)
         {
            this.x = (this.stage.stageWidth - 620) / 2;
            this.y = (this.stage.stageHeight - 370) / 2;
            this.visible = true;
         }
      }
   }
}
