package anifire.assets.control
{
   import anifire.assets.view.AssetViewCollection;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.EffectThumb;
   import anifire.core.Prop;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetControl;
   import anifire.interfaces.IAssetView;
   import anifire.util.UtilUser;
   
   public class AssetControlFactory
   {
      
      private static var _characterControl:IAssetControl;
      
      private static var _bubbleControl:IAssetControl;
      
      private static var _cameraControl:IAssetControl;
      
      private static var _collectionControl:IAssetControl;
       
      
      public function AssetControlFactory()
      {
         super();
      }
      
      public static function getControl(param1:Object) : IAssetControl
      {
         var _loc2_:IAssetView = null;
         var _loc3_:IAsset = null;
         if(param1 is IAssetView)
         {
            _loc2_ = param1 as IAssetView;
            _loc3_ = _loc2_.asset;
            if(_loc3_ is Prop || _loc3_ is Character)
            {
               if(_characterControl == null)
               {
                  _characterControl = createControl(param1);
               }
               return _characterControl;
            }
            if(_loc3_ is BubbleAsset)
            {
               if(_bubbleControl == null)
               {
                  _bubbleControl = createControl(param1);
               }
               return _bubbleControl;
            }
            if(_loc3_ is EffectAsset)
            {
               if(EffectAsset(_loc3_).getExactType() == EffectThumb.TYPE_ZOOM)
               {
                  if(_cameraControl == null)
                  {
                     _cameraControl = createControl(param1);
                  }
                  return _cameraControl;
               }
            }
         }
         else if(param1 is AssetViewCollection)
         {
            if(_collectionControl == null)
            {
               _collectionControl = createControl(param1);
            }
            return _collectionControl;
         }
         return createControl(param1);
      }
      
      public static function createControl(param1:Object) : IAssetControl
      {
         var _loc2_:IAssetControl = null;
         var _loc3_:IAssetView = null;
         var _loc4_:IAsset = null;
         if(param1 is IAssetView)
         {
            _loc3_ = param1 as IAssetView;
            _loc4_ = _loc3_.asset;
            _loc2_ = new AssetControl(_loc4_);
            if(_loc4_ is Prop || _loc4_ is Character)
            {
               _loc2_ = new ResizableAssetControl(_loc2_);
               _loc2_ = new StretchableAssetControl(_loc2_);
               _loc2_ = new AdvancedRotatableAssetControl(_loc2_);
               _loc2_ = new DraggableAssetControl(_loc2_);
               if(UtilUser.hasAdminFeatures)
               {
                  _loc2_ = new AssetReferencePointControl(_loc2_);
               }
            }
            else if(_loc4_ is BubbleAsset)
            {
               if(!BubbleAsset(_loc4_).isShadow)
               {
                  _loc2_ = new ResizableAssetControl(_loc2_);
                  _loc2_ = new StretchableAssetControl(_loc2_);
                  _loc2_ = new AdvancedRotatableAssetControl(_loc2_);
                  _loc2_ = new BubbleTailControl(_loc2_);
               }
               else
               {
                  _loc2_ = new AdvancedRotatableAssetControl(_loc2_);
               }
               _loc2_ = new DraggableAssetControl(_loc2_);
               if(UtilUser.hasAdminFeatures)
               {
                  _loc2_ = new AssetReferencePointControl(_loc2_);
               }
            }
            else if(_loc4_ is EffectAsset)
            {
               if(EffectAsset(_loc4_).getExactType() != EffectThumb.TYPE_ZOOM)
               {
                  return null;
               }
               if(Console.getConsole().metaData.mver > 3)
               {
                  _loc2_ = new ResizableCameraControl(_loc2_);
               }
               else
               {
                  _loc2_ = new ResizableAssetControl(_loc2_);
               }
               _loc2_ = new DraggableAssetControl(_loc2_);
            }
         }
         else if(param1 is AssetViewCollection)
         {
            _loc2_ = new AssetControl(param1 as AssetViewCollection);
            _loc2_ = new AdvancedRotatableAssetControl(_loc2_);
            _loc2_ = new DraggableAssetControl(_loc2_);
            if(UtilUser.hasAdminFeatures)
            {
               _loc2_ = new AssetReferencePointControl(_loc2_);
            }
         }
         return _loc2_;
      }
   }
}
