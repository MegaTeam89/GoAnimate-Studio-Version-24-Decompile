package anifire.preloader
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import mx.events.FlexEvent;
   import mx.preloaders.IPreloaderDisplay;
   
   public class SimplePreloader extends Sprite implements IPreloaderDisplay
   {
       
      
      private var SimpleBg:Class;
      
      private var BlackChair:Class;
      
      private var WhiteChair:Class;
      
      private var _bg:MovieClip;
      
      private var _bar:Sprite;
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      private var _mask:Sprite;
      
      public function SimplePreloader()
      {
         this.SimpleBg = SimplePreloader_SimpleBg;
         this.BlackChair = SimplePreloader_BlackChair;
         this.WhiteChair = SimplePreloader_WhiteChair;
         super();
         this.visible = false;
      }
      
      private function initSimple(param1:String = "en_US") : void
      {
         if(param1 != "en_US" && param1 != "ja_JP" && param1 != "zh_TW")
         {
            param1 = "en_US";
         }
         this._bg = new this.SimpleBg();
         addChild(this._bg);
         var _loc2_:XML = <msg>
					<status>
						<en_US>Loading...</en_US>
						<ja_JP>工作室はダウンロード...</ja_JP>
						<zh_TW>工作室下載中...</zh_TW>
					</status>
				</msg>;
         var _loc3_:TextField = new TextField();
         this._bg.addChild(_loc3_);
         _loc3_.x = 10;
         _loc3_.width = 600;
         _loc3_.y = 180;
         var _loc4_:TextFormat;
         (_loc4_ = new TextFormat()).align = TextFormatAlign.CENTER;
         _loc4_.color = 16777215;
         _loc4_.size = 16;
         _loc4_.bold = true;
         _loc4_.italic = true;
         _loc4_.font = "trebuchet MS";
         _loc3_.defaultTextFormat = _loc4_;
         _loc3_.text = _loc2_.status.child(param1);
         var _loc5_:MovieClip = new this.BlackChair();
         this.addChild(_loc5_);
         this._mask = new Sprite();
         this._mask.graphics.beginFill(0);
         this._mask.graphics.drawRect(0,0,76,200);
         this._mask.graphics.endFill();
         this.addChild(this._mask);
         var _loc6_:MovieClip;
         (_loc6_ = new this.WhiteChair()).mask = this._mask;
         this.addChild(_loc6_);
         _loc6_.x = _loc5_.x = this._mask.x = 270;
         _loc6_.y = _loc5_.y = this._mask.y = 100;
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
         this.initSimple(tlang);
      }
      
      public function initialize() : void
      {
      }
      
      public function handleProgress(param1:ProgressEvent) : void
      {
         this._mask.scaleX = param1.bytesLoaded / param1.bytesTotal;
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
