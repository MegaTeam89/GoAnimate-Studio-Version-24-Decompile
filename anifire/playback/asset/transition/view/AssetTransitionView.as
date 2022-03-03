package anifire.playback.asset.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.interfaces.IPlayerAssetView;
   import anifire.playback.asset.transition.model.AssetTransition;
   import anifire.playback.asset.transition.sound.TransitionSound;
   import anifire.playback.asset.view.AbstractAssetViewDecorator;
   
   public class AssetTransitionView extends AbstractAssetViewDecorator
   {
       
      
      private var _transition:AssetTransition;
      
      private var _sound:TransitionSound;
      
      public function AssetTransitionView(param1:IPlayerAssetView)
      {
         super(param1);
      }
      
      public function set transition(param1:AssetTransition) : void
      {
         this._transition = param1;
         if(param1 && param1.hasSound)
         {
            this._sound = new TransitionSound();
         }
      }
      
      public function get transition() : AssetTransition
      {
         return this._transition;
      }
      
      override public function playFrame(param1:uint, param2:uint) : void
      {
         var _loc4_:AssetTransition = null;
         super.playFrame(param1,param2);
         if(param1 == 1)
         {
            if(this.decorated is AssetTransitionView)
            {
               _loc4_ = AssetTransitionView(this.decorated).transition;
            }
            if(_loc4_ && _loc4_.startFrame > this.transition.startFrame || _loc4_ == null)
            {
               if(this.transition.direction == AssetTransitionConstants.DIRECTION_IN)
               {
                  this.assetView.visible = false;
               }
               else
               {
                  this.assetView.visible = true;
               }
               this.assetView.x = 0;
               this.assetView.y = 0;
            }
         }
         var _loc3_:int = this.transition.startFrame;
         if(this.transition.direction == AssetTransitionConstants.DIRECTION_IN)
         {
            _loc3_ = Math.max(_loc3_,this.transition.startFrame + this.transition.duration - 12);
         }
         if(param1 == _loc3_ && this._sound)
         {
            this._sound.play();
         }
      }
      
      protected function getFactor(param1:uint, param2:uint) : Number
      {
         var _loc3_:Number = 0;
         var _loc4_:uint = this.transition.startFrame;
         var _loc5_:uint = this.transition.duration;
         var _loc6_:uint = _loc4_ + _loc5_ - 1;
         if(param1 >= _loc4_)
         {
            _loc3_ = (param1 - _loc4_) / _loc5_;
         }
         if(param1 > _loc6_)
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
