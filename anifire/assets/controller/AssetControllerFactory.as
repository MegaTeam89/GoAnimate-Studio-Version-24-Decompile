package anifire.assets.controller
{
   import anifire.assets.view.AssetViewCollection;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.EffectAsset;
   import anifire.core.Prop;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetController;
   import anifire.interfaces.IAssetView;
   
   public class AssetControllerFactory
   {
      
      private static var _characterController:IAssetController;
      
      private static var _bubbleController:IAssetController;
      
      private static var _cameraController:IAssetController;
      
      private static var _collectionController:AssetCollectionController;
       
      
      public function AssetControllerFactory()
      {
         super();
      }
      
      public static function createController(param1:IAssetView) : IAssetController
      {
         var _loc2_:IAssetController = null;
         var _loc3_:IAsset = null;
         if(param1)
         {
            _loc3_ = param1.asset;
            if(_loc3_ is Prop || _loc3_ is Character)
            {
               _loc2_ = new CharacterController(param1);
            }
            else if(_loc3_ is BubbleAsset)
            {
               _loc2_ = new BubbleController(param1);
            }
            else if(_loc3_ is EffectAsset)
            {
               _loc2_ = new CameraController(param1);
            }
         }
         return _loc2_;
      }
      
      public static function getController(param1:IAssetView) : IAssetController
      {
         var _loc2_:IAsset = null;
         if(param1)
         {
            _loc2_ = param1.asset;
            if(_loc2_ is Prop || _loc2_ is Character)
            {
               if(_characterController == null)
               {
                  _characterController = createController(param1);
               }
               return _characterController;
            }
            if(_loc2_ is BubbleAsset)
            {
               if(_bubbleController == null)
               {
                  _bubbleController = createController(param1);
               }
               return _bubbleController;
            }
            if(_loc2_ is EffectAsset)
            {
               if(_cameraController == null)
               {
                  _cameraController = createController(param1);
               }
               return _cameraController;
            }
         }
         return createController(param1);
      }
      
      public static function getCollectionController(param1:AssetViewCollection) : AssetCollectionController
      {
         if(_collectionController == null)
         {
            _collectionController = createCollectionController(param1);
         }
         return _collectionController;
      }
      
      public static function createCollectionController(param1:AssetViewCollection) : AssetCollectionController
      {
         var _loc2_:AssetCollectionController = null;
         if(param1)
         {
            _loc2_ = new AssetCollectionController(param1);
         }
         return _loc2_;
      }
   }
}
