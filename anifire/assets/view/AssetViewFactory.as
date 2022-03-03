package anifire.assets.view
{
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.EffectAsset;
   import anifire.core.EffectThumb;
   import anifire.core.Prop;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetView;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class AssetViewFactory extends EventDispatcher
   {
       
      
      public function AssetViewFactory(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function createAssetView(param1:IAsset) : IAssetView
      {
         var _loc2_:IAssetView = null;
         if(param1)
         {
            _loc2_ = new AssetView(param1);
            if(param1 is Character)
            {
               _loc2_ = new FacialAssetView(_loc2_);
               _loc2_ = new EyeAssetView(_loc2_);
               _loc2_ = new MouthAssetView(_loc2_);
               _loc2_ = new HoldableAssetView(_loc2_);
               _loc2_ = new WearableAssetView(_loc2_);
               _loc2_ = new ColorableAssetView(_loc2_);
               _loc2_ = new FlippableAssetView(_loc2_);
               _loc2_ = new ScalableAssetView(_loc2_);
               _loc2_ = new RotatableAssetView(_loc2_);
               _loc2_ = new MovableAssetView(_loc2_);
            }
            else if(param1 is Prop)
            {
               _loc2_ = new EyeAssetView(_loc2_);
               _loc2_ = new MouthAssetView(_loc2_);
               _loc2_ = new ColorableAssetView(_loc2_);
               _loc2_ = new FlippableAssetView(_loc2_);
               _loc2_ = new ScalableAssetView(_loc2_);
               _loc2_ = new RotatableAssetView(_loc2_);
               _loc2_ = new MovableAssetView(_loc2_);
            }
            else if(param1 is Background)
            {
               _loc2_ = new ColorableAssetView(_loc2_);
               _loc2_ = new FlippableAssetView(_loc2_);
               _loc2_ = new MovableAssetView(_loc2_);
            }
            else if(param1 is BubbleAsset)
            {
               _loc2_ = new TextableAssetView(_loc2_);
               _loc2_ = new BubbleAssetView(_loc2_);
               _loc2_ = new ScalableAssetView(_loc2_);
               _loc2_ = new RotatableAssetView(_loc2_);
               _loc2_ = new MovableAssetView(_loc2_);
            }
            else if(param1 is EffectAsset)
            {
               if(EffectAsset(param1).getExactType() == EffectThumb.TYPE_ZOOM)
               {
                  _loc2_ = new ResizableAssetView(_loc2_);
                  _loc2_ = new MovableAssetView(_loc2_);
               }
               if(EffectAsset(param1).isShadow)
               {
                  _loc2_ = new ProgramEffectShadowView(_loc2_);
               }
            }
            _loc2_ = new AssetEditor(_loc2_);
            if(!(param1 is BubbleAsset))
            {
               AssetEditor(_loc2_).mouseChildren = false;
            }
            return _loc2_;
         }
         return null;
      }
   }
}
