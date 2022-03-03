package anifire.preloader
{
   import flash.display.Sprite;
   
   public class PreloaderProgressBar extends Sprite
   {
       
      
      private const PROGRESS_BAR_HEIGHT:Number = 15;
      
      private const PROGRESS_BAR_WIDTH:Number = 206;
      
      private const PROGRESS_BAR_PADDING:Number = 3;
      
      private const PROGRESS_BAR_COLOR:uint = 8368819;
      
      public function PreloaderProgressBar()
      {
         super();
         this.graphics.beginFill(0,0.1);
         this.graphics.lineStyle(1,16777215);
         this.graphics.beginFill(16777215);
         this.graphics.drawRect(0,0,this.PROGRESS_BAR_WIDTH + this.PROGRESS_BAR_PADDING * 2,this.PROGRESS_BAR_HEIGHT + this.PROGRESS_BAR_PADDING * 2);
         this.graphics.endFill();
      }
      
      public function set progress(param1:Number) : void
      {
         this.graphics.beginFill(this.PROGRESS_BAR_COLOR);
         this.graphics.lineStyle(1,16777215);
         this.graphics.drawRect(this.PROGRESS_BAR_PADDING,this.PROGRESS_BAR_PADDING,this.PROGRESS_BAR_WIDTH * param1,this.PROGRESS_BAR_HEIGHT);
         this.graphics.endFill();
      }
   }
}
