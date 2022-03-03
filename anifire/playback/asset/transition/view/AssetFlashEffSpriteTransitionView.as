package anifire.playback.asset.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.interfaces.IPlayerAssetView;
   import com.jumpeye.Events.FLASHEFFEvents;
   import com.jumpeye.flashEff2.core.interfaces.IFlashEffSymbol;
   import flash.events.Event;
   
   public class AssetFlashEffSpriteTransitionView extends AssetTransitionView
   {
       
      
      private var _isTransitting:Boolean = false;
      
      private var myEffect:FlashEff2Flex;
      
      public function AssetFlashEffSpriteTransitionView(param1:IPlayerAssetView)
      {
         this.myEffect = new FlashEff2Flex();
         super(param1);
      }
      
      override public function playFrame(param1:uint, param2:uint) : void
      {
         var _loc3_:IFlashEffSymbol = null;
         var _loc4_:int = 0;
         super.playFrame(param1,param2);
         if(param1 == 1)
         {
            this._isTransitting = false;
         }
         if(param1 >= this.transition.startFrame + 1 && param1 <= this.transition.startFrame + 3)
         {
            if(!this._isTransitting)
            {
               this._isTransitting = true;
               if(this.parent && !this.myEffect.parent)
               {
                  _loc3_ = AssetTransitionConstants.flashEffPlusParamById(this.transition.type,this.transition.direction);
                  _loc3_.tweenDuration = this.transition.duration / 24;
                  if(this.parent)
                  {
                     _loc4_ = this.parent.getChildIndex(this);
                     this.parent.addChildAt(this.myEffect,_loc4_);
                  }
                  if(this.transition.direction == 0)
                  {
                     this.myEffect.addEventListener(FLASHEFFEvents.TRANSITION_END,this.onTransitionsInDone);
                     this.myEffect.showTransition = _loc3_;
                     this.myEffect.showDelay = 0;
                  }
                  else if(this.transition.direction == 1)
                  {
                     this.myEffect.addEventListener(FLASHEFFEvents.TRANSITION_END,this.onTransitionsOutDone);
                     this.myEffect.hideTransition = _loc3_;
                     this.myEffect.hideDelay = 0;
                  }
                  this.myEffect.target = this;
               }
            }
            this.assetView.visible = true;
         }
      }
      
      private function onTransitionsInDone(param1:Event) : void
      {
         this.myEffect = new FlashEff2Flex();
         this._isTransitting = false;
      }
      
      private function onTransitionsOutDone(param1:Event) : void
      {
         this.myEffect = new FlashEff2Flex();
         this.assetView.visible = false;
         this._isTransitting = false;
      }
   }
}
