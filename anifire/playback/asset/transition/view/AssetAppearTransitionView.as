package anifire.playback.asset.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.interfaces.IPlayerAssetView;
   
   public class AssetAppearTransitionView extends AssetTransitionView
   {
       
      
      public function AssetAppearTransitionView(param1:IPlayerAssetView)
      {
         super(param1);
      }
      
      override public function playFrame(param1:uint, param2:uint) : void
      {
         super.playFrame(param1,param2);
         if(param1 >= this.transition.startFrame && param1 <= this.transition.startFrame + 3)
         {
            if(this.transition.direction == AssetTransitionConstants.DIRECTION_IN)
            {
               this.assetView.visible = true;
            }
            else
            {
               this.assetView.visible = false;
            }
         }
      }
   }
}
