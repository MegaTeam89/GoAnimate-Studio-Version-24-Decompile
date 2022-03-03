package anifire.assets.view
{
   import anifire.assets.image.PropAssetImage;
   import anifire.constant.AnimeConstants;
   import anifire.core.CharThumb;
   import anifire.core.Character;
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.events.CharacterAssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IWearable;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class WearableAssetView extends AbstractAssetViewDecorator
   {
       
      
      private var _wear:IAssetView;
      
      public function WearableAssetView(param1:IAssetView)
      {
         super(param1);
         this.addAssetEventListeners(param1.asset);
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
         if(super.asset is IWearable)
         {
            this.changeWear(super.asset as IWearable);
         }
      }
      
      private function changeWear(param1:IWearable) : void
      {
         var _loc2_:AssetViewFactory = null;
         this.removeWear();
         if(param1.wear && super.assetImage)
         {
            _loc2_ = new AssetViewFactory();
            this._wear = _loc2_.createAssetView(param1.wear);
            this._wear.addEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
            this._wear.loadImage();
         }
      }
      
      private function onPropImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.currentTarget).removeEventListener(param1.type,this.onPropImageReady);
         var _loc2_:DisplayObject = PropAssetImage(this._wear.assetImage).imageObject;
         this.addWearClipToHeadContainer(_loc2_,super.assetImage as DisplayObjectContainer);
         this.callLater(this.dispatchEvent,[new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true)]);
         this.callLater(this.dispatchEvent,[new AssetViewEvent(AssetViewEvent.VIEW_IMAGE_CHANGE,true)]);
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         this.removeAssetEventListeners(super.asset);
         if(this._wear)
         {
            this._wear.removeEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
            this._wear.destroy(param1);
            this._wear = null;
         }
         super.destroy(param1);
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(CharacterAssetEvent.WEAR_CHANGE,this.onHandheldChange);
            param1.addEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(CharacterAssetEvent.WEAR_CHANGE,this.onHandheldChange);
            param1.removeEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
         }
      }
      
      private function onHandheldChange(param1:CharacterAssetEvent) : void
      {
         if(param1.asset is IWearable)
         {
            this.changeWear(param1.asset as IWearable);
         }
      }
      
      private function onActionChange(param1:AssetEvent) : void
      {
         if(param1.asset is IWearable)
         {
            this.changeWear(param1.asset as IWearable);
         }
      }
      
      private function addWearClipToHeadContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && Character(super.asset).facing != CharThumb(super.asset.thumb).facing)
            {
               _loc5_ = UtilPlain.getHead(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getHead(_loc4_);
            }
            if(_loc5_ != null)
            {
               param1.name = AnimeConstants.MOVIECLIP_THE_WEAR;
               _loc5_.addChild(param1);
               this.updateWearSize(param1,_loc5_);
               this.updateWearPosition(_loc5_);
            }
         }
      }
      
      private function updateWearPosition(param1:DisplayObjectContainer) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:DisplayObject = null;
         var _loc5_:uint = 0;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(param1,"theTop");
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            if(param1.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha != 0)
            {
               _loc3_ = param1.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).getBounds(param1).y;
            }
            else
            {
               _loc5_ = 0;
               _loc5_ = param1.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = param1.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_HEAD && _loc4_.name != AnimeConstants.MOVIECLIP_THE_WEAR)
                  {
                     _loc3_ = _loc4_.getBounds(param1).y;
                     break;
                  }
                  _loc5_--;
               }
            }
            _loc2_.y = _loc3_;
         }
      }
      
      private function updateWearSize(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         if(param1)
         {
            try
            {
               param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(param2,super.assetImage as DisplayObjectContainer,UtilPlain.PROPERTY_SCALEX));
               param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(param2,super.assetImage as DisplayObjectContainer,UtilPlain.PROPERTY_SCALEY));
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function removeWear() : void
      {
         var _loc3_:DisplayObjectContainer = null;
         if(this._wear == null)
         {
            return;
         }
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(super.assetImage as DisplayObjectContainer,UtilPlain.THE_CHAR);
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(super.assetImage as DisplayObjectContainer,UtilPlain.THE_CHAR_FLIP);
         if(_loc1_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc1_);
            if(_loc3_ != null)
            {
               if(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR))
               {
                  _loc3_.removeChild(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR));
               }
            }
         }
         if(_loc2_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc2_);
            if(_loc3_ != null)
            {
               if(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR))
               {
                  _loc3_.removeChild(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR));
               }
            }
         }
         this._wear.removeEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
         this._wear.destroy();
         this._wear = null;
      }
   }
}
