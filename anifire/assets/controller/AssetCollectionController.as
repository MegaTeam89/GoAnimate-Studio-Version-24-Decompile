package anifire.assets.controller
{
   import anifire.assets.geom.AssetRotation;
   import anifire.assets.interfaces.IReferencePoint;
   import anifire.assets.model.AssetCollectionShadow;
   import anifire.assets.motion.ICircularMotion;
   import anifire.assets.view.AssetViewCollection;
   import anifire.constant.AnimeConstants;
   import anifire.core.MotionData;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IAssetController;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IBubbleTail;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IMotion;
   import anifire.interfaces.IMovable;
   import anifire.interfaces.IResizable;
   import anifire.interfaces.IRotatable;
   import anifire.interfaces.ISlidable;
   import anifire.util.UtilMath;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AssetCollectionController extends EventDispatcher implements IMovable, IResizable, IRotatable, ISlidable, IMotion
   {
       
      
      private var _collection:AssetViewCollection;
      
      private var _rect:Rectangle;
      
      private var _rotation:AssetRotation;
      
      private var _motionData:MotionData;
      
      private var _shadow:AssetCollectionShadow;
      
      private var _referencePoint:Point;
      
      private var _circularMotion:ICircularMotion;
      
      public function AssetCollectionController(param1:AssetViewCollection, param2:IEventDispatcher = null)
      {
         this._rect = new Rectangle();
         this._rotation = new AssetRotation();
         this._referencePoint = new Point();
         super(param2);
         this._collection = param1;
         this.updateRect();
      }
      
      public function get collection() : AssetViewCollection
      {
         return this._collection;
      }
      
      public function set collection(param1:AssetViewCollection) : void
      {
         if(param1)
         {
            this._collection = param1;
            this.updateRect();
         }
      }
      
      private function updateRect() : void
      {
         var _loc1_:Rectangle = null;
         var _loc3_:IIterator = null;
         var _loc4_:IAssetView = null;
         var _loc5_:IAssetController = null;
         if(this._rect)
         {
            _loc1_ = this._rect.clone();
         }
         this._rect = new Rectangle();
         var _loc2_:Rectangle = new Rectangle();
         if(this._collection)
         {
            _loc3_ = this._collection.iterator();
            while(_loc3_.hasNext)
            {
               if((_loc4_ = _loc3_.next as IAssetView) is DisplayObject)
               {
                  _loc2_ = DisplayObject(_loc4_).getBounds(DisplayObject(_loc4_));
                  this._rect = this._rect != null ? this._rect.union(_loc2_) : _loc2_;
               }
            }
         }
         if(this._rect == null)
         {
            this._rect = new Rectangle();
         }
         this.setReferencePoint(this.x,this.y);
         this._rotation.rotation = 0;
         this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_ROTATED));
         if(_loc1_)
         {
            if(_loc1_.x + _loc1_.width / 2 != this._rect.x + this._rect.width / 2 || _loc1_.y + _loc1_.height / 2 != this._rect.y + this._rect.height / 2)
            {
               this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED));
            }
            if(_loc1_.width != this._rect.width || _loc1_.height != this._rect.height)
            {
               this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED));
            }
         }
      }
      
      public function get minWidth() : Number
      {
         return 20;
      }
      
      public function get minHeight() : Number
      {
         return 20;
      }
      
      public function get maxWidth() : Number
      {
         return 99999;
      }
      
      public function get maxHeight() : Number
      {
         return 99999;
      }
      
      public function destroy() : void
      {
         this._collection = null;
         this._motionData = null;
      }
      
      public function get width() : Number
      {
         return this._rect.width;
      }
      
      public function set width(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Rectangle = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:IIterator = null;
         var _loc7_:IAssetView = null;
         var _loc8_:IAssetController = null;
         if(param1 != this.width)
         {
            _loc2_ = 1;
            if(this.width > 0)
            {
               _loc2_ = param1 / this.width;
            }
            _loc3_ = new Rectangle();
            _loc4_ = new Point();
            _loc5_ = new Point();
            if(this._collection)
            {
               _loc6_ = this._collection.iterator();
               while(_loc6_.hasNext)
               {
                  _loc7_ = IAssetView(_loc6_.next);
                  if(_loc8_ = AssetControllerFactory.getController(_loc7_))
                  {
                     _loc3_ = new Rectangle();
                     _loc8_.view = _loc7_;
                     if(_loc8_ is IMovable)
                     {
                        _loc3_.x = IMovable(_loc8_).x;
                        _loc3_.y = IMovable(_loc8_).y;
                     }
                     if(_loc8_ is IResizable)
                     {
                        _loc3_.width = IResizable(_loc8_).width;
                        _loc3_.height = IResizable(_loc8_).height;
                        _loc3_ = UtilMath.scaleRect(_loc3_,_loc2_,1,this._referencePoint);
                        IResizable(_loc8_).width = UtilMath.boundaryCheck(_loc2_ * _loc3_.width,IResizable(_loc8_).minWidth,IResizable(_loc8_).maxWidth);
                     }
                     if(_loc8_ is IBubbleTail)
                     {
                        IBubbleTail(_loc8_).tailX = IBubbleTail(_loc8_).tailX * _loc2_;
                     }
                     if(_loc8_ is IMovable)
                     {
                        IMovable(_loc8_).x = _loc3_.x;
                        IMovable(_loc8_).y = _loc3_.y;
                     }
                     if(_loc8_ is IReferencePoint)
                     {
                        _loc5_.x = IReferencePoint(_loc8_).referenceX;
                        _loc5_.y = IReferencePoint(_loc8_).referenceY;
                        _loc5_ = UtilMath.scalePoint(_loc5_,_loc2_,1,this._referencePoint);
                        IReferencePoint(_loc8_).setReferencePoint(_loc5_.x,_loc5_.y);
                     }
                  }
               }
            }
            this._rect = UtilMath.scaleRect(this._rect,_loc2_,1,this._referencePoint);
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED));
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED));
         }
      }
      
      public function get height() : Number
      {
         return this._rect.height;
      }
      
      public function set height(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Rectangle = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:IIterator = null;
         var _loc7_:IAssetView = null;
         var _loc8_:IAssetController = null;
         if(param1 != this.height)
         {
            _loc2_ = 1;
            if(this.height > 0)
            {
               _loc2_ = param1 / this.height;
            }
            _loc3_ = new Rectangle();
            _loc4_ = new Point();
            _loc5_ = new Point();
            if(this._collection)
            {
               _loc6_ = this._collection.iterator();
               while(_loc6_.hasNext)
               {
                  _loc7_ = IAssetView(_loc6_.next);
                  if(_loc8_ = AssetControllerFactory.getController(_loc7_))
                  {
                     _loc3_ = new Rectangle();
                     _loc8_.view = _loc7_;
                     if(_loc8_ is IMovable)
                     {
                        _loc3_.x = IMovable(_loc8_).x;
                        _loc3_.y = IMovable(_loc8_).y;
                     }
                     if(_loc8_ is IResizable)
                     {
                        _loc3_.width = IResizable(_loc8_).width;
                        _loc3_.height = IResizable(_loc8_).height;
                        _loc3_ = UtilMath.scaleRect(_loc3_,1,_loc2_,this._referencePoint);
                        IResizable(_loc8_).height = UtilMath.boundaryCheck(_loc2_ * _loc3_.height,IResizable(_loc8_).minHeight,IResizable(_loc8_).maxHeight);
                     }
                     if(_loc8_ is IBubbleTail)
                     {
                        IBubbleTail(_loc8_).tailY = IBubbleTail(_loc8_).tailY * _loc2_;
                     }
                     if(_loc8_ is IMovable)
                     {
                        IMovable(_loc8_).x = _loc3_.x;
                        IMovable(_loc8_).y = _loc3_.y;
                     }
                     if(_loc8_ is IReferencePoint)
                     {
                        _loc5_.x = IReferencePoint(_loc8_).referenceX;
                        _loc5_.y = IReferencePoint(_loc8_).referenceY;
                        _loc5_ = UtilMath.scalePoint(_loc5_,1,_loc2_,this._referencePoint);
                        IReferencePoint(_loc8_).setReferencePoint(_loc5_.x,_loc5_.y);
                     }
                  }
               }
            }
            this._rect = UtilMath.scaleRect(this._rect,1,_loc2_,this._referencePoint);
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED));
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED));
         }
      }
      
      public function resize(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Rectangle = null;
         var _loc7_:Point = null;
         var _loc8_:IIterator = null;
         var _loc9_:IAssetView = null;
         var _loc10_:IAssetController = null;
         if(param1 != this.width || param2 != this.height)
         {
            param1 = UtilMath.boundaryCheck(param1,this.minWidth,this.maxWidth);
            param2 = UtilMath.boundaryCheck(param2,this.minHeight,this.maxHeight);
            _loc4_ = 1;
            if(this.width > 0)
            {
               _loc4_ = param1 / this.width;
            }
            _loc5_ = 1;
            if(this.height > 0)
            {
               _loc5_ = param2 / this.height;
            }
            _loc6_ = new Rectangle();
            _loc7_ = new Point();
            if(this._collection)
            {
               _loc8_ = this._collection.iterator();
               while(_loc8_.hasNext)
               {
                  if(_loc9_ = _loc8_.next as IAssetView)
                  {
                     if(_loc10_ = AssetControllerFactory.getController(_loc9_))
                     {
                        _loc6_ = new Rectangle();
                        _loc10_.view = _loc9_;
                        if(_loc10_ is IMovable)
                        {
                           _loc6_.x = IMovable(_loc10_).x;
                           _loc6_.y = IMovable(_loc10_).y;
                        }
                        if(_loc10_ is IResizable)
                        {
                           _loc6_.width = IResizable(_loc10_).width;
                           _loc6_.height = IResizable(_loc10_).height;
                           _loc6_ = UtilMath.scaleRect(_loc6_,_loc4_,_loc5_,this._referencePoint);
                           IResizable(_loc10_).resize(_loc6_.width,_loc6_.height);
                        }
                        if(_loc10_ is IBubbleTail)
                        {
                           IBubbleTail(_loc10_).tailX = IBubbleTail(_loc10_).tailX * _loc4_;
                           IBubbleTail(_loc10_).tailY = IBubbleTail(_loc10_).tailY * _loc5_;
                        }
                        if(_loc10_ is IMovable)
                        {
                           IMovable(_loc10_).move(_loc6_.x,_loc6_.y);
                        }
                        if(_loc10_ is IReferencePoint)
                        {
                           _loc7_.x = IReferencePoint(_loc10_).referenceX;
                           _loc7_.y = IReferencePoint(_loc10_).referenceY;
                           _loc7_ = UtilMath.scalePoint(_loc7_,_loc4_,_loc5_,this._referencePoint);
                           IReferencePoint(_loc10_).setReferencePoint(_loc7_.x,_loc7_.y);
                        }
                     }
                  }
               }
            }
            this._rect = UtilMath.scaleRect(this._rect,_loc4_,_loc5_,this._referencePoint);
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_RESIZED));
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED));
         }
      }
      
      public function get x() : Number
      {
         return this._rect.x + this._rect.width / 2;
      }
      
      public function get y() : Number
      {
         return this._rect.y + this._rect.height / 2;
      }
      
      public function set x(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:IIterator = null;
         var _loc4_:IAssetView = null;
         var _loc5_:IAssetController = null;
         if(param1 != this.x)
         {
            _loc2_ = param1 - this.x;
            if(this._collection)
            {
               _loc3_ = this._collection.iterator();
               while(_loc3_.hasNext)
               {
                  _loc4_ = IAssetView(_loc3_.next);
                  if(_loc5_ = AssetControllerFactory.getController(_loc4_))
                  {
                     _loc5_.view = _loc4_;
                     if(_loc5_ is IMovable)
                     {
                        if(_loc5_ is IRotatable)
                        {
                           IRotatable(_loc5_).setReferencePoint(IRotatable(_loc5_).referenceX + _loc2_,IRotatable(_loc5_).referenceY);
                        }
                        IMovable(_loc5_).x = IMovable(_loc5_).x + _loc2_;
                     }
                  }
               }
            }
            this._rect.x += _loc2_;
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED));
            if(this._motionData)
            {
               this._motionData.startPoint = new Point(this.x,this.y);
               this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE));
            }
         }
      }
      
      public function set y(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:IIterator = null;
         var _loc4_:IAssetView = null;
         var _loc5_:IAssetController = null;
         if(param1 != this.y)
         {
            _loc2_ = param1 - this.y;
            if(this._collection)
            {
               _loc3_ = this._collection.iterator();
               while(_loc3_.hasNext)
               {
                  _loc4_ = IAssetView(_loc3_.next);
                  if(_loc5_ = AssetControllerFactory.getController(_loc4_))
                  {
                     _loc5_.view = _loc4_;
                     if(_loc5_ is IMovable)
                     {
                        if(_loc5_ is IRotatable)
                        {
                           IRotatable(_loc5_).setReferencePoint(IRotatable(_loc5_).referenceX,IRotatable(_loc5_).referenceY + _loc2_);
                        }
                        IMovable(_loc5_).y = IMovable(_loc5_).y + _loc2_;
                     }
                  }
               }
            }
            this._rect.y += _loc2_;
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED));
            if(this._motionData)
            {
               this._motionData.startPoint = new Point(this.x,this.y);
               this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE));
            }
         }
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         var _loc3_:Point = null;
         var _loc4_:IIterator = null;
         var _loc5_:IAssetView = null;
         var _loc6_:IAssetController = null;
         if(param1 != this.x || param2 != this.y)
         {
            _loc3_ = new Point(param1 - this.x,param2 - this.y);
            if(this._collection)
            {
               _loc4_ = this._collection.iterator();
               while(_loc4_.hasNext)
               {
                  _loc5_ = IAssetView(_loc4_.next);
                  if(_loc6_ = AssetControllerFactory.getController(_loc5_))
                  {
                     _loc6_.view = _loc5_;
                     if(_loc6_ is IMovable)
                     {
                        IMovable(_loc6_).move(IMovable(_loc6_).x + _loc3_.x,IMovable(_loc6_).y + _loc3_.y);
                        if(_loc6_ is IReferencePoint)
                        {
                           IReferencePoint(_loc6_).setReferencePoint(IReferencePoint(_loc6_).referenceX + _loc3_.x,IReferencePoint(_loc6_).referenceY + _loc3_.y);
                        }
                     }
                  }
               }
            }
            this._rect.x += _loc3_.x;
            this._rect.y += _loc3_.y;
            this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED));
            if(this._motionData)
            {
               this._motionData.startPoint = new Point(this.x,this.y);
               this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE));
            }
         }
      }
      
      public function get isRotatable() : Boolean
      {
         return true;
      }
      
      public function get rotation() : Number
      {
         return this._rotation.rotation;
      }
      
      private function get mat() : Matrix
      {
         var _loc1_:Matrix = new Matrix();
         _loc1_.rotate(this.rotation * Math.PI / 180);
         _loc1_.translate(this.x,this.y);
         return _loc1_;
      }
      
      public function set rotation(param1:Number) : void
      {
         var _loc2_:Matrix = null;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:Number = NaN;
         var _loc6_:IIterator = null;
         var _loc7_:IAssetView = null;
         var _loc8_:IAssetController = null;
         if(param1 != this.rotation)
         {
            if(this._collection)
            {
               _loc2_ = this.mat;
               _loc3_ = new Point();
               _loc4_ = new Point();
               _loc5_ = param1 - this.rotation;
               _loc6_ = this._collection.iterator();
               while(_loc6_.hasNext)
               {
                  _loc7_ = IAssetView(_loc6_.next);
                  if(_loc8_ = AssetControllerFactory.getController(_loc7_))
                  {
                     _loc8_.view = _loc7_;
                     if(_loc8_ is IMovable)
                     {
                        _loc3_.x = IMovable(_loc8_).x;
                        _loc3_.y = IMovable(_loc8_).y;
                     }
                     if(_loc8_ is IReferencePoint)
                     {
                        _loc4_.x = IReferencePoint(_loc8_).referenceX;
                        _loc4_.y = IReferencePoint(_loc8_).referenceY;
                     }
                     if(_loc8_ is IRotatable)
                     {
                        if(IRotatable(_loc8_).isRotatable)
                        {
                           IRotatable(_loc8_).rotation = IRotatable(_loc8_).rotation + _loc5_;
                        }
                     }
                     if(_loc8_ is IReferencePoint)
                     {
                        _loc4_ = UtilMath.rotatePoint(_loc4_,_loc5_,this._referencePoint);
                        IReferencePoint(_loc8_).setReferencePoint(_loc4_.x,_loc4_.y);
                     }
                     if(_loc8_ is IMovable)
                     {
                        _loc3_ = UtilMath.rotatePoint(_loc3_,_loc5_,this._referencePoint);
                        IMovable(_loc8_).move(_loc3_.x,_loc3_.y);
                     }
                  }
               }
               this._rotation.rotation = param1;
               _loc3_.x = this.x;
               _loc3_.y = this.y;
               _loc3_ = UtilMath.rotatePoint(_loc3_,_loc5_,this._referencePoint);
               this._rect.x = _loc3_.x - this._rect.width / 2;
               this._rect.y = _loc3_.y - this._rect.height / 2;
               this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_ROTATED));
               this.dispatchEvent(new AssetEvent(AssetEvent.ASSET_MOVED));
            }
         }
      }
      
      public function set referenceX(param1:Number) : void
      {
         if(param1 != this.referenceX)
         {
            this._referencePoint.x = param1;
            this.dispatchEvent(new AssetEvent(AssetEvent.REFERENCE_POINT_CHANGED));
         }
      }
      
      public function set referenceY(param1:Number) : void
      {
         if(param1 != this.referenceY)
         {
            this._referencePoint.y = param1;
            this.dispatchEvent(new AssetEvent(AssetEvent.REFERENCE_POINT_CHANGED));
         }
      }
      
      public function setReferencePoint(param1:Number, param2:Number) : void
      {
         if(param1 != this.referenceX || param2 != this.referenceY)
         {
            this._referencePoint.x = param1;
            this._referencePoint.y = param2;
            this.dispatchEvent(new AssetEvent(AssetEvent.REFERENCE_POINT_CHANGED));
            if(this._circularMotion)
            {
               this._circularMotion.center = new Point(param1,param2);
            }
         }
      }
      
      public function get referenceX() : Number
      {
         return this._referencePoint.x;
      }
      
      public function get referenceY() : Number
      {
         return this._referencePoint.y;
      }
      
      public function startSlideMotion() : void
      {
         var _loc1_:int = 0;
         if(this.slideEnabled && !this.isSliding)
         {
            this._shadow = new AssetCollectionShadow();
            this._shadow.addEventListener(Event.CHANGE,this.onShadowChange);
            _loc1_ = this.x > AnimeConstants.STAGE_WIDTH / 2 ? -100 : 100;
            this._shadow.move(this.x + _loc1_,this.y);
            this._motionData = new MotionData();
            this._motionData.maxInterPointNum = 0;
            this._motionData.startPoint = new Point(this.x,this.y);
            this._motionData.endPoint = new Point(this._shadow.x,this._shadow.y);
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE));
         }
      }
      
      private function onShadowChange(param1:Event) : void
      {
         if(this._motionData)
         {
            this._motionData.endPoint = new Point(this._shadow.x,this._shadow.y);
            this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE));
         }
      }
      
      public function removeSlideMotion() : void
      {
         var _loc1_:IIterator = null;
         var _loc2_:IAssetView = null;
         if(this._collection)
         {
            _loc1_ = this._collection.iterator();
            while(_loc1_.hasNext)
            {
               _loc2_ = IAssetView(_loc1_.next);
               if(_loc2_ && _loc2_.asset is ISlidable)
               {
                  ISlidable(_loc2_.asset).removeSlideMotion();
               }
            }
         }
         if(this._shadow)
         {
            this._shadow.removeEventListener(Event.CHANGE,this.onShadowChange);
         }
         this._shadow = null;
         this._motionData = null;
         this.dispatchEvent(new AssetEvent(AssetEvent.MOTION_CHANGE));
      }
      
      public function get motionData() : MotionData
      {
         return this._motionData;
      }
      
      public function get shadow() : Object
      {
         return this._shadow;
      }
      
      public function set motionData(param1:MotionData) : void
      {
         this.commitMotionData();
         this._motionData = param1;
         if(param1 == null)
         {
            if(this._shadow)
            {
               this._shadow.removeEventListener(Event.CHANGE,this.onShadowChange);
            }
            this._shadow = null;
         }
      }
      
      public function get slideEnabled() : Boolean
      {
         var _loc1_:IIterator = null;
         var _loc2_:IAssetView = null;
         if(this._collection)
         {
            _loc1_ = this._collection.iterator();
            while(_loc1_.hasNext)
            {
               _loc2_ = IAssetView(_loc1_.next);
               if(!(_loc2_ && _loc2_.asset is ISlidable && ISlidable(_loc2_.asset).slideEnabled))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function get isSliding() : Boolean
      {
         return this._motionData != null;
      }
      
      public function commitMotionData() : void
      {
         var _loc1_:IIterator = null;
         var _loc2_:IAssetView = null;
         if(this._motionData)
         {
            if(this._collection)
            {
               _loc1_ = this._collection.iterator();
               while(_loc1_.hasNext)
               {
                  _loc2_ = IAssetView(_loc1_.next);
                  if(_loc2_ && _loc2_.asset is ISlidable)
                  {
                     ISlidable(_loc2_.asset).motionData = this._motionData;
                  }
               }
            }
         }
      }
   }
}
