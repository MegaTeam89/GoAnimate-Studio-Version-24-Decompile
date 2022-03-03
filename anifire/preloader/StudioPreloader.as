package anifire.preloader
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import mx.events.FlexEvent;
   import mx.preloaders.IPreloaderDisplay;
   
   public class StudioPreloader extends Sprite implements IPreloaderDisplay
   {
       
      
      private var _preloader:IPreloaderDisplay;
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      public function StudioPreloader()
      {
         super();
      }
      
      public function set preloader(param1:Sprite) : void
      {
         var value:Sprite = param1;
         value.addEventListener(Event.COMPLETE,this.handleComplete);
         value.addEventListener(FlexEvent.INIT_PROGRESS,this.handleInitProgress);
         value.addEventListener(FlexEvent.INIT_COMPLETE,this.handleInitComplete);
         var siteId:String = "0";
         var ut:String = "10";
         try
         {
            siteId = value.loaderInfo.parameters["siteId"];
            ut = value.loaderInfo.parameters["ut"];
         }
         catch(e:Error)
         {
            siteId = "0";
            ut = "10";
         }
         if(siteId == "0" || siteId == "4")
         {
            if(ut == "10")
            {
               if(Math.random() < 0.3)
               {
                  this._preloader = new GoPlusPreloader();
               }
               else if(Math.random() < 0.6)
               {
                  this._preloader = new GoSchoolPreloader();
               }
               else
               {
                  this._preloader = new GoBusinessPreloader();
               }
            }
            else if(ut == "20")
            {
               if(Math.random() < 0.5)
               {
                  this._preloader = new GoSchoolPreloader();
               }
               else
               {
                  this._preloader = new GoBusinessPreloader();
               }
            }
            else
            {
               this._preloader = new SimplePreloader();
            }
         }
         else
         {
            this._preloader = new SimplePreloader();
         }
         this._preloader.preloader = value;
         this.addChild(this._preloader as DisplayObject);
      }
      
      private function onClientLocaleComplete(param1:Event) : void
      {
      }
      
      public function initialize() : void
      {
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
   }
}
