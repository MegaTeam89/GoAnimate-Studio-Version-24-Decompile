package anifire.assets.view
{
   import anifire.assets.image.EffectAssetImage;
   import anifire.interfaces.IAssetView;
   import flash.display.DisplayObject;
   
   public class ProgramEffectShadowView extends AbstractAssetViewDecorator
   {
       
      
      public function ProgramEffectShadowView(param1:IAssetView)
      {
         super(param1);
      }
      
      public function showEffect(param1:DisplayObject) : void
      {
         if(super.assetImage is EffectAssetImage)
         {
            EffectAssetImage(super.assetImage).showEffect(param1);
         }
      }
   }
}
