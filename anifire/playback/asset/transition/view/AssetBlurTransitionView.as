package anifire.playback.asset.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.interfaces.IPlayerAssetView;
   import anifire.playback.asset.transition.model.AssetTransition;
   import anifire.util.UtilEffect;
   import mx.effects.Blur;
   import mx.events.EffectEvent;
   
   public class AssetBlurTransitionView extends AssetTransitionView
   {
       
      
      private var _effect:Blur;
      
      private var _isTransitting:Boolean = false;
      
      public function AssetBlurTransitionView(param1:IPlayerAssetView)
      {
         this._effect = new Blur();
         super(param1);
      }
      
      override public function set transition(param1:AssetTransition) : void
      {
         super.transition = param1;
         this._effect.duration = 1000 * transition.duration / 24;
         this._effect.blurXFrom = 0;
         this._effect.blurYFrom = 0;
         this._effect.blurXTo = 55;
         this._effect.blurYTo = 55;
         this._effect.easingFunction = UtilEffect.getEffectByName("easeInCubic");
      }
      
      override public function playFrame(param1:uint, param2:uint) : void
      {
         super.playFrame(param1,param2);
         if(param1 == 1)
         {
            this._isTransitting = false;
         }
         if(param1 >= this.transition.startFrame && param1 <= this.transition.startFrame + 2)
         {
            if(!this._isTransitting)
            {
               this._isTransitting = true;
               this._effect.addEventListener(EffectEvent.EFFECT_END,this.onEffectEnd);
               if(this.transition.direction == AssetTransitionConstants.DIRECTION_IN)
               {
                  this._effect.play([this],true);
               }
               else
               {
                  this._effect.play([this]);
               }
            }
            this.assetView.visible = true;
         }
      }
      
      private function onEffectStart(param1:EffectEvent) : void
      {
         this._effect.removeEventListener(EffectEvent.EFFECT_START,this.onEffectStart);
         this.assetView.visible = true;
      }
      
      private function onEffectEnd(param1:EffectEvent) : void
      {
         this._effect.removeEventListener(EffectEvent.EFFECT_END,this.onEffectEnd);
         if(this.transition.direction == AssetTransitionConstants.DIRECTION_OUT)
         {
            this.assetView.visible = false;
            this._effect.play([this],true);
         }
         this._isTransitting = false;
      }
   }
}
