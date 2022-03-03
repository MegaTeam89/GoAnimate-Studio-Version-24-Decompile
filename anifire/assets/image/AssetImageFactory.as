package anifire.assets.image
{
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.EffectAsset;
   import anifire.core.ProgramEffectAsset;
   import anifire.core.Prop;
   import anifire.core.VideoProp;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetImage;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class AssetImageFactory extends EventDispatcher
   {
       
      
      public function AssetImageFactory(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function createImage(param1:IAsset) : IAssetImage
      {
         var _loc2_:IAssetImage = this.makeImage(param1);
         return this.assemblyImage(_loc2_);
      }
      
      private function assemblyImage(param1:IAssetImage) : IAssetImage
      {
         return param1;
      }
      
      protected function makeImage(param1:IAsset) : IAssetImage
      {
         if(param1 is Background)
         {
            return new BgAssetImage();
         }
         if(param1 is VideoProp)
         {
            return new VideoAssetImage();
         }
         if(param1 is Prop)
         {
            return new PropAssetImage();
         }
         if(param1 is Character)
         {
            return new CharacterAssetImage();
         }
         if(param1 is BubbleAsset)
         {
            return new BubbleAssetImage();
         }
         if(param1 is EffectAsset)
         {
            if(param1 is ProgramEffectAsset && ProgramEffectAsset(param1).isShadow)
            {
               return new EffectShadowAssetImage();
            }
            return new EffectAssetImage();
         }
         return null;
      }
   }
}
