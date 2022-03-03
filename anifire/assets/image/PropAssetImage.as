package anifire.assets.image
{
   import anifire.component.CustomHeadMaker;
   import anifire.component.SkinnedHeadMaker;
   import anifire.constant.AnimeConstants;
   import anifire.constant.RaceConstants;
   import anifire.core.Prop;
   import anifire.core.PropThumb;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetImage;
   import anifire.interfaces.IColorable;
   import anifire.interfaces.IEye;
   import anifire.interfaces.IMouth;
   import anifire.interfaces.IProduct;
   import anifire.util.UtilArray;
   import anifire.util.UtilColor;
   import anifire.util.UtilCommonLoader;
   import anifire.util.UtilHashBytes;
   import anifire.util.UtilHashSelectedColor;
   import anifire.util.UtilPlain;
   import flash.display.AVM1Movie;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class PropAssetImage extends AbstractAssetImage implements IAssetImage, IColorable, IEye, IMouth
   {
       
      
      private var _prop:Prop;
      
      private var _imageObject:DisplayObject;
      
      public function PropAssetImage()
      {
         super();
      }
      
      public function get imageObject() : DisplayObject
      {
         return this._imageObject;
      }
      
      public function set imageObject(param1:DisplayObject) : void
      {
         this._imageObject = param1;
      }
      
      public function set asset(param1:IAsset) : void
      {
         var _loc2_:IProduct = null;
         var _loc3_:PropThumb = null;
         var _loc4_:Object = null;
         var _loc5_:CustomHeadMaker = null;
         var _loc6_:Object = null;
         var _loc7_:SkinnedHeadMaker = null;
         var _loc8_:Loader = null;
         if(param1 is Prop)
         {
            this._prop = param1 as Prop;
            _loc2_ = param1.thumb as IProduct;
            if(_loc2_ is PropThumb)
            {
               _loc3_ = _loc2_ as PropThumb;
               if(param1 is Prop)
               {
                  if(this._prop.state && this._prop.state.imageData)
                  {
                     _loc4_ = this._prop.state.imageData;
                  }
                  else
                  {
                     _loc4_ = _loc2_.imageData;
                  }
               }
               if(_loc4_)
               {
                  switch(_loc3_.raceCode)
                  {
                     case RaceConstants.CUSTOM_CHARACTER:
                        _loc5_ = new CustomHeadMaker();
                        this._imageObject = _loc5_;
                        _loc6_ = _loc4_;
                        _loc5_.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onImageReady);
                        if(this._prop is IMouth)
                        {
                           _loc5_.demoSpeech = IMouth(this._prop).demoSpeech;
                        }
                        _loc5_.init(_loc6_["xml"] as XML);
                        _loc5_.name = AnimeConstants.IMAGE_OBJECT_NAME;
                        this.addChild(_loc5_);
                        this.visible = false;
                        break;
                     case RaceConstants.SKINNED_SWF:
                        _loc7_ = new SkinnedHeadMaker();
                        this._imageObject = _loc7_;
                        _loc7_.themeId = _loc3_.themeId;
                        _loc7_.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onImageReady);
                        if(_loc4_ is ByteArray)
                        {
                           _loc7_.init(_loc3_.xml,ByteArray(_loc4_),null,false,false,"",this._prop.stateId);
                        }
                        else
                        {
                           _loc7_.init(_loc3_.xml,ByteArray(_loc4_["figure"]),_loc4_["imageData"] as UtilHashBytes,false,false,"",this._prop.stateId);
                        }
                        _loc7_.name = AnimeConstants.IMAGE_OBJECT_NAME;
                        this.addChild(_loc7_);
                        this.visible = false;
                        break;
                     case RaceConstants.STATIC_SWF:
                        _loc8_ = new Loader();
                        this._imageObject = _loc8_;
                        _loc8_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageReady);
                        if(_loc4_ is ByteArray)
                        {
                           _loc8_.loadBytes(ByteArray(_loc4_),UtilCommonLoader.externalLoaderContext);
                        }
                        else
                        {
                           _loc8_.loadBytes(ByteArray(_loc4_["figure"]));
                        }
                        _loc8_.name = AnimeConstants.IMAGE_OBJECT_NAME;
                        this.addChild(_loc8_);
                  }
               }
            }
         }
      }
      
      private function onImageReady(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:Rectangle = null;
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageReady);
         if(!(param1 is LoadEmbedMovieEvent))
         {
            _loc2_ = param1.target.loader;
         }
         if(_loc2_ != null)
         {
            if(this._prop && this._prop.char == null)
            {
               _loc3_ = _loc2_.getBounds(_loc2_);
               _loc2_.content.x = -(_loc3_.x + _loc3_.width / 2);
               _loc2_.content.y = -(_loc3_.y + _loc3_.height / 2);
            }
            else if(_loc2_.content is AVM1Movie)
            {
               _loc3_ = _loc2_.getBounds(this);
               if(_loc3_.x < 0 && _loc3_.y < 0)
               {
                  this.graphics.beginFill(0,0);
                  this.graphics.drawRect(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
                  this.graphics.endFill();
               }
            }
         }
         if(this._imageObject)
         {
            _loc3_ = this._imageObject.getBounds(this);
            super.rect.x = _loc3_.x;
            super.rect.y = _loc3_.y;
            super.rect.width = _loc3_.width;
            super.rect.height = _loc3_.height;
         }
         this.visible = true;
         dispatchImageReady();
      }
      
      public function get lookAtCameraSupported() : Boolean
      {
         if(this._imageObject is CustomHeadMaker)
         {
            return CustomHeadMaker(this._imageObject).lookAtCameraSupported;
         }
         return false;
      }
      
      public function get lookAtCamera() : Boolean
      {
         if(this._imageObject is CustomHeadMaker)
         {
            return CustomHeadMaker(this._imageObject).lookAtCamera;
         }
         return false;
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         if(this._imageObject is CustomHeadMaker)
         {
            CustomHeadMaker(this._imageObject).lookAtCamera = param1;
         }
      }
      
      public function changeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc3_:uint = 0;
         if(this._imageObject is Loader)
         {
            UtilColor.setAssetPartColor(this._imageObject,param1,param2);
         }
         return _loc3_;
      }
      
      public function get colorableArea() : Array
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:Array = new Array();
         if(this._imageObject is Loader)
         {
            _loc2_ = UtilPlain.getColorItem(this._imageObject);
            if(_loc2_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc4_ = DisplayObject(_loc2_[_loc3_]).name.split("_");
                  _loc1_.push(_loc4_[1]);
                  _loc3_++;
               }
               _loc1_ = UtilArray.removeDuplicates(_loc1_,true);
            }
         }
         return _loc1_;
      }
      
      public function restoreColor() : void
      {
         if(this._imageObject is Loader)
         {
            UtilColor.resetAssetPartsColor(this._imageObject);
         }
      }
      
      public function get customColor() : UtilHashSelectedColor
      {
         return new UtilHashSelectedColor();
      }
      
      public function get demoSpeech() : Boolean
      {
         if(this._imageObject is CustomHeadMaker)
         {
            return CustomHeadMaker(this._imageObject).demoSpeech;
         }
         return false;
      }
      
      public function set demoSpeech(param1:Boolean) : void
      {
         if(this._imageObject is CustomHeadMaker)
         {
            CustomHeadMaker(this._imageObject).demoSpeech = param1;
         }
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         super.destroy(param1);
         this._prop = null;
         this._imageObject = null;
      }
   }
}
