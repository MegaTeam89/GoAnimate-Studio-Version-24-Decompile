package anifire.playback.asset.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.interfaces.IPlayerAssetView;
   import anifire.playback.asset.transition.interfaces.IDestination;
   import anifire.playback.asset.transition.interfaces.IShape;
   import anifire.util.UtilEffect;
   import fl.transitions.TransitionManager;
   import flash.events.Event;
   
   public class AssetFlexTransitionView extends AssetTransitionView
   {
       
      
      private var _isTransitting:Boolean = false;
      
      public function AssetFlexTransitionView(param1:IPlayerAssetView)
      {
         super(param1);
      }
      
      override public function playFrame(param1:uint, param2:uint) : void
      {
         var _loc3_:Object = null;
         var _loc4_:TransitionManager = null;
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
               _loc3_ = new Object();
               _loc3_["type"] = UtilEffect.getTransitionByName(this.transition.type);
               _loc3_["direction"] = this.transition.direction;
               _loc3_["duration"] = this.transition.duration / 24;
               if(this.transition.type == AssetTransitionConstants.TYPE_ZOOM)
               {
                  if(this.transition.direction == AssetTransitionConstants.DIRECTION_IN)
                  {
                     _loc3_["easing"] = UtilEffect.getEffectByName("easeOutElastic");
                  }
                  else
                  {
                     _loc3_["easing"] = UtilEffect.getEffectByName("easeInElastic");
                  }
               }
               if(this.transition is IDestination)
               {
                  _loc3_["startPoint"] = IDestination(this.transition).destination;
               }
               if(this.transition is IShape)
               {
                  _loc3_["shape"] = IShape(this.transition).shape;
               }
               (_loc4_ = new TransitionManager(this)).addEventListener("allTransitionsInDone",this.onTransitionsInDone);
               _loc4_.addEventListener("allTransitionsOutDone",this.onTransitionsOutDone);
               _loc4_.startTransition(_loc3_);
            }
            this.assetView.visible = true;
         }
      }
      
      private function onTransitionsInDone(param1:Event) : void
      {
         this._isTransitting = false;
      }
      
      private function onTransitionsOutDone(param1:Event) : void
      {
         this.assetView.visible = false;
         this._isTransitting = false;
      }
   }
}
