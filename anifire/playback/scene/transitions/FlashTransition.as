package anifire.playback.scene.transitions
{
   import anifire.constant.AnimeConstants;
   import anifire.playback.AnimeScene;
   import anifire.playback.GoTransition;
   import anifire.util.Util;
   import anifire.util.UtilEffect;
   import anifire.util.UtilPlain;
   import fl.transitions.Blinds;
   import fl.transitions.Fly;
   import fl.transitions.Iris;
   import fl.transitions.PixelDissolve;
   import fl.transitions.Rotate;
   import fl.transitions.Squeeze;
   import fl.transitions.Transition;
   import fl.transitions.TransitionManager;
   import fl.transitions.Wipe;
   import fl.transitions.Zoom;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class FlashTransition extends GoTransition
   {
       
      
      private var _type:Class;
      
      private var _direction:uint;
      
      private var _param:Array;
      
      private var effectee:DisplayObject;
      
      public function FlashTransition()
      {
         super();
      }
      
      override public function init(param1:XML, param2:AnimeScene, param3:Sprite) : Boolean
      {
         var _loc4_:Array = null;
         if(super.init(param1,param2,param3))
         {
            _loc4_ = String(param1.fx.@type).split(".");
            this._type = UtilEffect.getTransitionByName(_loc4_[1]);
            this._direction = _loc4_[2] == "in" ? uint(0) : uint(1);
            this._param = String(param1.fx.@param).split(",");
            return true;
         }
         return false;
      }
      
      override public function play(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Object = null;
         var _loc6_:MovieClip = null;
         if(!prevScene.endSceneCapture)
         {
            return;
         }
         if(param3 <= param1 + dur)
         {
            if(param1 <= param3 && this.getBundle().numChildren == 0)
            {
               _loc4_ = (dur - 1) / AnimeConstants.FRAME_PER_SEC;
               (_loc5_ = new Object())["type"] = this._type;
               _loc5_["direction"] = this._direction;
               _loc5_["duration"] = Util.roundNum(_loc4_,1);
               _loc5_["easing"] = easeFx;
               switch(this._type)
               {
                  case PixelDissolve:
                     _loc5_["xSections"] = Number(this._param[0]);
                     _loc5_["ySections"] = Number(this._param[1]);
                     break;
                  case Blinds:
                     _loc5_["numStrips"] = Number(this._param[0]);
                     _loc5_["dimension"] = Number(this._param[1]);
                     break;
                  case Fly:
                     _loc5_["startPoint"] = Number(this._param[0]);
                     break;
                  case Iris:
                     _loc5_["startPoint"] = Number(this._param[0]);
                     _loc5_["shape"] = String(this._param[1]);
                     break;
                  case Rotate:
                     _loc5_["ccw"] = this._param[0] == "1" ? true : false;
                     _loc5_["degrees"] = Number(this._param[1]);
                     _loc5_["shiftPoint"] = Number(this._param[2]);
                     break;
                  case Squeeze:
                     _loc5_["dimension"] = Number(this._param[0]);
                     _loc5_["shiftPoint"] = Number(this._param[1]);
                     break;
                  case Wipe:
                     _loc5_["startPoint"] = Number(this._param[0]);
                     break;
                  case Zoom:
                     _loc5_["shiftPoint"] = Number(this._param[0]);
               }
               prevSceneCapture.bitmapData = prevScene.endSceneCapture;
               prevSceneCapture.scaleX = prevSceneCapture.scaleY = AnimeConstants.SCREEN_WIDTH / prevScene.endSceneCapture.width;
               _loc6_ = new MovieClip();
               if(!_loc5_["shiftPoint"])
               {
                  prevSceneCapture.x = AnimeConstants.SCREEN_X;
                  prevSceneCapture.y = AnimeConstants.SCREEN_Y;
                  _loc6_.x = 0;
                  _loc6_.y = 0;
               }
               else
               {
                  switch(_loc5_["shiftPoint"])
                  {
                     case 1:
                     case 4:
                     case 7:
                        prevSceneCapture.x = 0;
                        _loc6_.x = AnimeConstants.SCREEN_X;
                        break;
                     case 2:
                     case 5:
                     case 8:
                        prevSceneCapture.x = -prevSceneCapture.width / 2;
                        _loc6_.x = AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH / 2;
                        break;
                     case 3:
                     case 6:
                     case 9:
                        prevSceneCapture.x = -prevSceneCapture.width;
                        _loc6_.x = AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH;
                  }
                  switch(_loc5_["shiftPoint"])
                  {
                     case 1:
                     case 2:
                     case 3:
                        prevSceneCapture.y = 0;
                        _loc6_.y = AnimeConstants.SCREEN_Y;
                        break;
                     case 4:
                     case 5:
                     case 6:
                        prevSceneCapture.y = -prevSceneCapture.height / 2;
                        _loc6_.y = AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT / 2;
                        break;
                     case 7:
                     case 8:
                     case 9:
                        prevSceneCapture.y = -prevSceneCapture.height;
                        _loc6_.y = AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT;
                  }
               }
               if(this._direction == Transition.IN)
               {
                  UtilPlain.switchParent(currSMC,_loc6_);
               }
               else
               {
                  _loc6_.addChild(prevSceneCapture);
               }
               if(!currSMC.contains(this.getBundle()))
               {
                  if(this._direction == Transition.IN)
                  {
                     currSMC.addChildAt(this.getBundle(),0);
                  }
                  else
                  {
                     currSMC.addChild(this.getBundle());
                  }
               }
               UtilPlain.removeAllSon(this.getBundle());
               if(this._direction == Transition.IN)
               {
                  this.getBundle().addChild(prevSceneCapture);
                  currSMC.addChild(_loc6_);
               }
               else
               {
                  this.getBundle().addChild(_loc6_);
               }
               this.getBundle().x = 0;
               this.getBundle().y = 0;
               this.getBundle().alpha = 1;
               if(_loc6_.stage)
               {
                  TransitionManager.start(_loc6_ as MovieClip,_loc5_);
               }
            }
            else if(param3 == param1 + dur)
            {
               if(!currSMC.contains(this.getBundle()))
               {
               }
            }
         }
      }
   }
}
