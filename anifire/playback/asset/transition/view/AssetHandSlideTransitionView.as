package anifire.playback.asset.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.constant.AnimeConstants;
   import anifire.interfaces.IPlayerAssetView;
   import anifire.playback.asset.transition.hand.HandClip;
   import anifire.playback.asset.transition.model.AssetSlideTransition;
   import anifire.playback.asset.transition.model.AssetTransition;
   import anifire.util.UtilEffect;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AssetHandSlideTransitionView extends AssetTransitionView
   {
       
      
      private var _pt:Point;
      
      private var _hand:HandClip;
      
      private var _offset:Point;
      
      public function AssetHandSlideTransitionView(param1:IPlayerAssetView)
      {
         this._hand = new HandClip();
         super(param1);
      }
      
      override public function set transition(param1:AssetTransition) : void
      {
         var _loc2_:AssetSlideTransition = null;
         super.transition = param1;
         this._pt = new Point(0,-AnimeConstants.SCREEN_HEIGHT);
         if(this.transition is AssetSlideTransition)
         {
            _loc2_ = this.transition as AssetSlideTransition;
            switch(_loc2_.destination)
            {
               case AssetTransitionConstants.DEST_TL:
                  this._pt.x = -AnimeConstants.SCREEN_WIDTH;
                  this._pt.y = -AnimeConstants.SCREEN_HEIGHT;
                  break;
               case AssetTransitionConstants.DEST_TOP:
                  this._pt.x = 0;
                  this._pt.y = -AnimeConstants.SCREEN_HEIGHT;
                  break;
               case AssetTransitionConstants.DEST_TR:
                  this._pt.x = AnimeConstants.SCREEN_WIDTH;
                  this._pt.y = -AnimeConstants.SCREEN_HEIGHT;
                  break;
               case AssetTransitionConstants.DEST_LEFT:
                  this._pt.x = -AnimeConstants.SCREEN_WIDTH;
                  this._pt.y = 0;
                  break;
               case AssetTransitionConstants.DEST_RIGHT:
                  this._pt.x = AnimeConstants.SCREEN_HEIGHT;
                  this._pt.y = 0;
                  break;
               case AssetTransitionConstants.DEST_BL:
                  this._pt.x = -AnimeConstants.SCREEN_WIDTH;
                  this._pt.y = AnimeConstants.SCREEN_HEIGHT;
                  break;
               case AssetTransitionConstants.DEST_BOTTOM:
                  this._pt.x = 0;
                  this._pt.y = AnimeConstants.SCREEN_HEIGHT;
                  break;
               case AssetTransitionConstants.DEST_BR:
                  this._pt.x = AnimeConstants.SCREEN_WIDTH;
                  this._pt.y = AnimeConstants.SCREEN_HEIGHT;
            }
            this._hand.destination = _loc2_.destination;
            this.addChild(this._hand);
         }
         this._pt.x *= 1.5;
         this._pt.y *= 1.5;
      }
      
      override public function playFrame(param1:uint, param2:uint) : void
      {
         var _loc6_:Function = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc11_:Rectangle = null;
         var _loc12_:Rectangle = null;
         var _loc13_:AssetSlideTransition = null;
         super.playFrame(param1,param2);
         if(!this._offset && this.bundle)
         {
            if((_loc11_ = this.bundle.getBounds(this.assetView)).width > 0)
            {
               _loc12_ = new Rectangle(_loc11_.x + _loc11_.width / 3,_loc11_.y + _loc11_.height / 3,_loc11_.width / 3,_loc11_.height / 3);
               this._offset = new Point(_loc12_.x,_loc12_.y);
               if(this.transition is AssetSlideTransition)
               {
                  _loc13_ = this.transition as AssetSlideTransition;
                  switch(_loc13_.destination)
                  {
                     case AssetTransitionConstants.DEST_TL:
                        break;
                     case AssetTransitionConstants.DEST_TOP:
                        this._offset.offset(_loc12_.width / 2,0);
                        break;
                     case AssetTransitionConstants.DEST_TR:
                        this._offset.offset(_loc12_.width,0);
                        break;
                     case AssetTransitionConstants.DEST_LEFT:
                        this._offset.offset(0,_loc12_.height / 2);
                        break;
                     case AssetTransitionConstants.DEST_RIGHT:
                        this._offset.offset(_loc12_.width,_loc12_.height / 2);
                        break;
                     case AssetTransitionConstants.DEST_BL:
                        this._offset.offset(0,_loc12_.height);
                        break;
                     case AssetTransitionConstants.DEST_BOTTOM:
                        this._offset.offset(_loc12_.width / 2,_loc12_.height);
                        break;
                     case AssetTransitionConstants.DEST_BR:
                        this._offset.offset(_loc12_.width,_loc12_.height);
                  }
               }
            }
         }
         this._hand.visible = false;
         if(!this._offset)
         {
            return;
         }
         var _loc3_:Number = 3;
         var _loc4_:Number = 9;
         var _loc5_:Number = 9;
         var _loc7_:Number = 0;
         var _loc10_:Number = 0;
         if(this.transition.direction == AssetTransitionConstants.DIRECTION_IN)
         {
            _loc10_ = this.transition.duration - _loc3_ - _loc5_;
            if(param1 >= this.transition.startFrame && param1 < this.transition.startFrame + _loc10_)
            {
               this.assetView.visible = true;
               _loc7_ = (_loc6_ = UtilEffect.getEffectByName("easeOutBack"))(param1 - this.transition.startFrame,0,1,_loc10_,0.7);
               _loc8_ = this._pt.x * (1 - _loc7_);
               _loc9_ = this._pt.y * (1 - _loc7_);
               this.assetView.x = _loc8_;
               this.assetView.y = _loc9_;
               this._hand.visible = true;
               this._hand.x = _loc8_ + this._offset.x;
               this._hand.y = _loc9_ + this._offset.y;
            }
            else if(param1 >= this.transition.startFrame + _loc10_ && param1 < this.transition.startFrame + _loc10_ + _loc3_)
            {
               this.assetView.x = 0;
               this.assetView.y = 0;
               this._hand.x = this._offset.x;
               this._hand.y = this._offset.y;
               this._hand.visible = true;
            }
            else if(param1 >= this.transition.startFrame + _loc10_ + _loc3_ && param1 < this.transition.endFrame)
            {
               _loc7_ = (_loc6_ = UtilEffect.getEffectByName("easeInQuad"))(param1 - (this.transition.endFrame - _loc5_),0,1,_loc5_);
               _loc8_ = this._pt.x * _loc7_;
               _loc9_ = this._pt.y * _loc7_;
               this._hand.x = _loc8_ + this._offset.x;
               this._hand.y = _loc9_ + this._offset.y;
               this._hand.visible = true;
            }
         }
         else
         {
            _loc10_ = this.transition.duration - _loc3_ - _loc4_;
            if(param1 >= this.transition.startFrame && param1 < this.transition.startFrame + _loc4_)
            {
               _loc7_ = (_loc6_ = UtilEffect.getEffectByName("easeOutBack"))(param1 - this.transition.startFrame,0,1,_loc4_,0.5);
               _loc8_ = this._pt.x * (1 - _loc7_);
               _loc9_ = this._pt.y * (1 - _loc7_);
               this._hand.x = _loc8_ + this._offset.x;
               this._hand.y = _loc9_ + this._offset.y;
               this._hand.visible = true;
            }
            else if(param1 >= this.transition.startFrame + _loc4_ && param1 < this.transition.startFrame + _loc4_ + _loc3_)
            {
               this._hand.x = this._offset.x;
               this._hand.y = this._offset.y;
               this._hand.visible = true;
            }
            else if(param1 >= this.transition.startFrame + _loc4_ + _loc3_ && param1 < this.transition.endFrame)
            {
               this.assetView.visible = true;
               _loc7_ = (_loc6_ = UtilEffect.getEffectByName("easeInQuad"))(param1 - (this.transition.startFrame + _loc4_ + _loc3_),0,1,_loc10_);
               _loc8_ = this._pt.x * _loc7_;
               _loc9_ = this._pt.y * _loc7_;
               this.assetView.x = _loc8_;
               this.assetView.y = _loc9_;
               this._hand.visible = true;
               this._hand.x = _loc8_ + this._offset.x;
               this._hand.y = _loc9_ + this._offset.y;
            }
            else if(param1 == this.transition.endFrame)
            {
               this.assetView.visible = false;
            }
         }
      }
      
      override protected function getFactor(param1:uint, param2:uint) : Number
      {
         var _loc7_:Function = null;
         var _loc3_:Number = 0;
         var _loc4_:uint = this.transition.startFrame;
         var _loc5_:uint = this.transition.duration;
         var _loc6_:uint = _loc4_ + _loc5_ - 1;
         if(param1 >= _loc4_)
         {
            if(this.transition.direction == AssetTransitionConstants.DIRECTION_OUT)
            {
               _loc3_ = (_loc7_ = UtilEffect.getEffectByName("easeInQuad"))(param1 - _loc4_,0,1,_loc5_ - 1);
            }
            else
            {
               _loc3_ = (_loc7_ = UtilEffect.getEffectByName("easeOutBack"))(param1 - _loc4_,0,1,_loc5_ - 1,0.7);
            }
         }
         if(param1 >= _loc6_)
         {
            _loc3_ = 1;
         }
         if(this.transition.direction == AssetTransitionConstants.DIRECTION_OUT)
         {
            _loc3_ = 1 - _loc3_;
         }
         return _loc3_;
      }
   }
}
