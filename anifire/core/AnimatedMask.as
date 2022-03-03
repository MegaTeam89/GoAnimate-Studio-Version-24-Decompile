package anifire.core
{
   import anifire.constant.AnimeConstants;
   import anifire.util.UtilPlain;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import mx.controls.Image;
   
   public class AnimatedMask extends EventDispatcher
   {
      
      private static var isSingletonCall:Boolean = false;
      
      private static var myAnimatedMask:AnimatedMask = null;
       
      
      private var myCircleFadeOut:Class;
      
      private var _parentDisplayObj:Sprite;
      
      private var _maskImage:Image;
      
      private var _circleMovieClip:MovieClip;
      
      private var _isPlaying:Boolean = false;
      
      public function AnimatedMask()
      {
         var _loc1_:ByteArray = null;
         var _loc2_:Loader = null;
         this.myCircleFadeOut = AnimatedMask_myCircleFadeOut;
         super();
         if(!isSingletonCall)
         {
            throw new Error("Error: Instantiation failed");
         }
         _loc1_ = new this.myCircleFadeOut();
         _loc2_ = new Loader();
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         _loc2_.loadBytes(_loc1_);
         isSingletonCall = false;
      }
      
      public static function getInstance() : AnimatedMask
      {
         if(myAnimatedMask == null)
         {
            isSingletonCall = true;
            myAnimatedMask = new AnimatedMask();
         }
         return myAnimatedMask;
      }
      
      private function loaderCompleteHandler(param1:Event) : void
      {
         this._circleMovieClip = param1.target.content as MovieClip;
         this._maskImage = new Image();
         this._maskImage.name = "circleMask";
         this._maskImage.addChild(this._circleMovieClip);
      }
      
      public function startDrawing(param1:Sprite) : void
      {
         var _loc2_:Number = NaN;
         if(this._maskImage == null)
         {
            this.dispatchEvent(new Event("EventFinished"));
         }
         else
         {
            this.isPlaying = true;
            this._parentDisplayObj = param1;
            this._maskImage.width = param1.width;
            this._maskImage.height = param1.height;
            _loc2_ = Math.max(param1.width / AnimeConstants.STAGE_WIDTH,param1.height / AnimeConstants.STAGE_HEIGHT);
            this._maskImage.scaleX = this._maskImage.scaleY = _loc2_;
            this._maskImage.x = (param1.width - AnimeConstants.STAGE_WIDTH * _loc2_) / 2 + AnimeConstants.SCREEN_X * _loc2_;
            this._maskImage.y = (param1.height - AnimeConstants.STAGE_HEIGHT * _loc2_) / 2 + AnimeConstants.SCREEN_Y * _loc2_;
            UtilPlain.gotoAndStopFamilyAt1(this._circleMovieClip);
            this._parentDisplayObj.addChild(this._maskImage);
            this._circleMovieClip.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            UtilPlain.playFamily(this._circleMovieClip);
         }
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         if(this._isPlaying != param1)
         {
            this._isPlaying = param1;
            Console.getConsole().requestLoadStatus(param1,true);
         }
      }
      
      public function get isplaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function stopDrawing() : void
      {
         if(this._parentDisplayObj.contains(this._maskImage))
         {
            this._parentDisplayObj.removeChild(this._maskImage);
         }
         this.isPlaying = false;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.isPlaying = true;
         if(this._circleMovieClip.currentFrame >= this._circleMovieClip.totalFrames)
         {
            this._circleMovieClip.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            setTimeout(this.dispatchFinish,100);
         }
      }
      
      private function dispatchFinish() : void
      {
         this.dispatchEvent(new Event("EventFinished"));
      }
   }
}
