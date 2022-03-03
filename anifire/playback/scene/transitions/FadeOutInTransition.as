package anifire.playback.scene.transitions
{
   import anifire.constant.AnimeConstants;
   import anifire.playback.AnimeScene;
   import anifire.playback.GoTransition;
   import anifire.util.UtilPlain;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class FadeOutInTransition extends GoTransition
   {
       
      
      private var effectee:DisplayObject;
      
      private var _param:Array;
      
      public function FadeOutInTransition()
      {
         super();
      }
      
      override public function init(param1:XML, param2:AnimeScene, param3:Sprite) : Boolean
      {
         if(super.init(param1,param2,param3))
         {
            this._param = String(param1.fx.@param).split(",");
            return true;
         }
         return false;
      }
      
      override public function play(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:uint = 0;
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Number = NaN;
         if(!prevScene.endSceneCapture)
         {
            return;
         }
         if(param3 <= param1 + dur)
         {
            if(param1 <= param3 && this.getBundle().numChildren == 0)
            {
               _loc4_ = new BitmapData(AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
               _loc4_ = prevScene.endSceneCapture;
               prevSceneCapture.bitmapData = _loc4_;
               prevSceneCapture.scaleX = prevSceneCapture.scaleY = AnimeConstants.SCREEN_WIDTH / prevScene.endSceneCapture.width;
               prevSceneCapture.x = AnimeConstants.SCREEN_X;
               prevSceneCapture.y = AnimeConstants.SCREEN_Y;
               if(!currSMC.contains(this.getBundle()))
               {
                  currSMC.addChild(this.getBundle());
               }
               this.getBundle().addChild(prevSceneCapture);
               this.getBundle().x = 0;
               this.getBundle().y = 0;
               this.getBundle().alpha = 1;
               _loc5_ = 0;
               if(this._param)
               {
                  _loc5_ = uint(this._param[0]);
               }
               _loc6_ = new BitmapData(AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT,false,_loc5_);
               (_loc7_ = new Bitmap(_loc6_)).alpha = 0;
               _loc7_.x = AnimeConstants.SCREEN_X;
               _loc7_.y = AnimeConstants.SCREEN_Y;
               this.effectee = _loc7_;
               this.getBundle().addChild(_loc7_);
            }
            else if(param3 < param1 + dur)
            {
               if((_loc8_ = (param3 - param1) / ((dur - 1) / 2)) > 1)
               {
                  _loc8_ = Math.abs(_loc8_ - 2);
               }
               this.effectee.alpha = _loc8_;
               if(param1 + Math.round(dur / 2) == param3)
               {
                  this.getBundle().removeChildAt(0);
               }
            }
            else if(param3 == param1 + dur)
            {
               UtilPlain.removeAllSon(this.getBundle());
            }
         }
      }
   }
}
