package anifire.assets.view
{
   import anifire.assets.image.PropAssetImage;
   import anifire.core.CharThumb;
   import anifire.core.Character;
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.events.CharacterAssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IHoldable;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class HoldableAssetView extends AbstractAssetViewDecorator
   {
       
      
      private var _prop:IAssetView;
      
      public function HoldableAssetView(param1:IAssetView)
      {
         super(param1);
         this.addAssetEventListeners(param1.asset);
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
         if(super.asset is IHoldable)
         {
            this.changeHandheld(super.asset as IHoldable);
         }
      }
      
      private function changeHandheld(param1:IHoldable) : void
      {
         var _loc2_:AssetViewFactory = null;
         this.removeProp();
         if(param1.prop && super.assetImage)
         {
            _loc2_ = new AssetViewFactory();
            this._prop = _loc2_.createAssetView(param1.prop);
            this._prop.addEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
            this._prop.loadImage();
            if(super.assetImage is IHoldable)
            {
               IHoldable(super.assetImage).addProp(param1.prop);
            }
         }
      }
      
      private function onPropImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.currentTarget).removeEventListener(param1.type,this.onPropImageReady);
         var _loc2_:DisplayObject = PropAssetImage(this._prop.assetImage).imageObject;
         this.addPropClipToPropContainer(_loc2_,super.assetImage as DisplayObjectContainer);
         this.callLater(this.dispatchEvent,[new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true)]);
         this.callLater(this.dispatchEvent,[new AssetViewEvent(AssetViewEvent.VIEW_IMAGE_CHANGE,true)]);
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         this.removeAssetEventListeners(super.asset);
         if(this._prop)
         {
            this._prop.removeEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
            this._prop.destroy(param1);
            this._prop = null;
         }
         super.destroy(param1);
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(CharacterAssetEvent.HANDHELD_CHANGE,this.onHandheldChange);
            param1.addEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(CharacterAssetEvent.HANDHELD_CHANGE,this.onHandheldChange);
            param1.removeEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
         }
      }
      
      private function onHandheldChange(param1:CharacterAssetEvent) : void
      {
         if(param1.asset is IHoldable)
         {
            this.changeHandheld(param1.asset as IHoldable);
         }
      }
      
      private function onActionChange(param1:AssetEvent) : void
      {
         if(param1.asset is IHoldable)
         {
            this.changeHandheld(param1.asset as IHoldable);
         }
      }
      
      private function addPropClipToPropContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && Character(super.asset).facing != CharThumb(super.asset.thumb).facing)
            {
               _loc5_ = UtilPlain.getProp(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getProp(_loc4_);
            }
            if(_loc5_ != null)
            {
               UtilPlain.removeAllSon(_loc5_);
               _loc5_.addChild(param1);
               this.updatePropSize(param1,_loc5_);
            }
         }
      }
      
      private function updatePropSize(param1:DisplayObject, param2:DisplayObjectContainer) : void
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
      
      private function removeProp() : void
      {
         var _loc3_:DisplayObjectContainer = null;
         if(this._prop == null)
         {
            return;
         }
         this._prop.removeEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
         this._prop.destroy();
         this._prop = null;
         if(super.assetImage is IHoldable)
         {
            IHoldable(super.assetImage).removeProp();
         }
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(super.assetImage as DisplayObjectContainer,UtilPlain.THE_CHAR);
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(super.assetImage as DisplayObjectContainer,UtilPlain.THE_CHAR_FLIP);
         if(_loc1_ != null)
         {
            _loc3_ = UtilPlain.getProp(_loc1_);
            if(_loc3_ != null)
            {
               UtilPlain.removeAllSon(_loc3_);
            }
         }
         if(_loc2_ != null)
         {
            _loc3_ = UtilPlain.getProp(_loc2_);
            if(_loc3_ != null)
            {
               UtilPlain.removeAllSon(_loc3_);
            }
         }
      }
   }
}
