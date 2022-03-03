package anifire.assets.view
{
   import anifire.assets.image.CharacterAssetImage;
   import anifire.assets.image.PropAssetImage;
   import anifire.constant.AnimeConstants;
   import anifire.core.CharThumb;
   import anifire.core.Character;
   import anifire.events.AssetEvent;
   import anifire.events.AssetViewEvent;
   import anifire.events.CharacterAssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IFacial;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class FacialAssetView extends AbstractAssetViewDecorator
   {
       
      
      private var _head:IAssetView;
      
      public function FacialAssetView(param1:IAssetView)
      {
         super(param1);
         if(param1.asset)
         {
            this.addAssetEventListeners(param1.asset);
         }
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
         if(super.asset is IFacial)
         {
            this.changeFacial(super.asset as IFacial);
         }
      }
      
      private function changeFacial(param1:IFacial) : void
      {
         var _loc2_:AssetViewFactory = null;
         this.removeHead();
         if(param1.head && super.assetImage)
         {
            _loc2_ = new AssetViewFactory();
            this._head = _loc2_.createAssetView(param1.head);
            this._head.addEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
            this._head.loadImage();
         }
      }
      
      private function onPropImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.currentTarget).removeEventListener(param1.type,this.onPropImageReady);
         var _loc2_:DisplayObject = PropAssetImage(this._head.assetImage).imageObject;
         this.addHeadClipToHeadContainer(_loc2_,super.assetImage as DisplayObjectContainer);
         this.callLater(this.dispatchEvent,[new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true)]);
         this.callLater(this.dispatchEvent,[new AssetViewEvent(AssetViewEvent.VIEW_IMAGE_CHANGE,true)]);
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         this.removeAssetEventListeners(super.asset);
         if(this._head)
         {
            this._head.removeEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
            this._head.destroy(param1);
            this._head = null;
         }
         super.destroy(param1);
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(CharacterAssetEvent.FACIAL_CHANGE,this.onFacialChange);
            param1.addEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(CharacterAssetEvent.FACIAL_CHANGE,this.onFacialChange);
            param1.removeEventListener(AssetEvent.ACTION_CHANGE,this.onActionChange);
         }
      }
      
      private function onFacialChange(param1:CharacterAssetEvent) : void
      {
         if(param1.asset is IFacial)
         {
            this.changeFacial(param1.asset as IFacial);
         }
      }
      
      private function onActionChange(param1:AssetEvent) : void
      {
         if(param1.asset is IFacial)
         {
            this.changeFacial(param1.asset as IFacial);
         }
      }
      
      private function addHeadClipToHeadContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
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
               _loc5_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 0;
               _loc5_.addChildAt(param1,0);
               this.updateHeadSize(param1,_loc5_);
            }
            if(_loc3_ != null && Character(super.asset).facing != CharThumb(super.asset.thumb).facing)
            {
               _loc5_ = UtilPlain.getTail(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getTail(_loc4_);
            }
            if(_loc5_ != null)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_.numChildren)
               {
                  if(_loc5_.getChildAt(_loc6_).name == AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc5_.getChildAt(_loc6_).alpha = 0;
                  }
                  _loc6_++;
               }
            }
         }
         this.refreshProp();
      }
      
      private function updateHeadSize(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         try
         {
            param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(param2,super.assetImage as DisplayObjectContainer,UtilPlain.PROPERTY_SCALEX));
            param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(param2,super.assetImage as DisplayObjectContainer,UtilPlain.PROPERTY_SCALEY));
            if(super.assetImage is CharacterAssetImage)
            {
               CharacterAssetImage(super.assetImage).refreshScale();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function removeHead() : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         if(this._head == null)
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
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_HEAD && _loc4_.name != AnimeConstants.MOVIECLIP_THE_WEAR)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
            _loc3_ = UtilPlain.getTail(_loc1_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
         }
         if(_loc2_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_HEAD && _loc4_.name != AnimeConstants.MOVIECLIP_THE_WEAR)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
            _loc3_ = UtilPlain.getTail(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
         }
         this._head.removeEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onPropImageReady);
         this._head.destroy();
         this._head = null;
      }
      
      private function refreshProp() : void
      {
      }
   }
}
