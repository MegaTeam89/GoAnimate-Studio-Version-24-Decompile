package anifire.assets.panel
{
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.EffectAsset;
   import anifire.core.Prop;
   import anifire.core.Thumb;
   import anifire.events.AssetViewEvent;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetImage;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IProductImage;
   import anifire.products.ProductThumbImageFactory;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mx.containers.Canvas;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   
   public class AssetThumbnail extends Canvas
   {
       
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _target:Object;
      
      private var _timer:Timer;
      
      private var _locked:Boolean = false;
      
      private const BG_COLOR:uint = 14540253;
      
      public function AssetThumbnail()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":80,
                  "height":80
               };
            }
         });
         this._timer = new Timer(5000,1);
         super();
         mx_internal::_document = this;
         this.width = 80;
         this.height = 80;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set target(param1:Object) : void
      {
         if(this._target is IEventDispatcher)
         {
            this._target.removeEventListener(AssetViewEvent.VIEW_CHANGE,this.onViewChange);
         }
         this._target = param1;
         this.updateThumbnail();
         if(this._target is IEventDispatcher)
         {
            this._target.addEventListener(AssetViewEvent.VIEW_CHANGE,this.onViewChange);
         }
      }
      
      private function onViewChange(param1:AssetViewEvent) : void
      {
         if(!this._locked)
         {
            this.updateThumbnail();
            this._locked = true;
            this._timer.reset();
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
            this._timer.start();
         }
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._locked = false;
      }
      
      private function updateThumbnail() : void
      {
         var _loc1_:IAsset = null;
         var _loc2_:BitmapData = null;
         var _loc3_:Matrix = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:DisplayObject = null;
         var _loc8_:Rectangle = null;
         var _loc9_:Character = null;
         var _loc10_:Background = null;
         var _loc11_:Prop = null;
         var _loc12_:BubbleAsset = null;
         var _loc13_:EffectAsset = null;
         var _loc14_:ProductThumbImageFactory = null;
         var _loc15_:IProductImage = null;
         this.removeAllChildren();
         this.graphics.clear();
         if(this._target)
         {
            if(this._target is IAssetView)
            {
               _loc1_ = IAssetView(this._target).asset;
               this.scrollRect = new Rectangle(0,0,this.width,this.height);
               _loc2_ = null;
               _loc3_ = new Matrix();
               _loc4_ = 0;
               _loc5_ = 0;
               _loc6_ = 1;
               _loc7_ = IAssetView(this._target).assetImage;
               _loc8_ = new Rectangle();
               if(_loc7_ is IAssetImage)
               {
                  _loc8_ = IAssetImage(_loc7_).rect;
               }
               if(_loc7_)
               {
                  if(_loc1_ is Character)
                  {
                     _loc9_ = Character(_loc1_);
                     _loc2_ = new BitmapData(this.width,this.height,true,this.BG_COLOR);
                     _loc6_ = 0.9 * Math.min(this.width / _loc8_.width,this.height / _loc8_.height);
                     _loc4_ = this.width / 2;
                     _loc5_ = this.height / 2;
                     _loc3_.scale(_loc6_,_loc6_);
                     _loc3_.translate(_loc4_,_loc5_);
                     _loc2_.draw(_loc7_,_loc3_);
                  }
                  else if(_loc1_ is Background)
                  {
                     _loc10_ = Background(_loc1_);
                     _loc2_ = new BitmapData(this.width,this.height,true,this.BG_COLOR);
                     _loc6_ = 0.9 * Math.min(this.width / _loc8_.width,this.height / _loc8_.height);
                     _loc4_ = (this.width - _loc6_ * _loc8_.width) / 2;
                     _loc5_ = (this.height - _loc6_ * _loc8_.height) / 2;
                     _loc3_.scale(_loc6_,_loc6_);
                     _loc3_.translate(_loc4_,_loc5_);
                     _loc2_.draw(_loc7_,_loc3_);
                  }
                  else if(_loc1_ is Prop)
                  {
                     _loc11_ = Prop(_loc1_);
                     _loc2_ = new BitmapData(this.width,this.height,true,this.BG_COLOR);
                     _loc6_ = 0.9 * Math.min(this.width / _loc8_.width,this.height / _loc8_.height);
                     _loc4_ = this.width / 2;
                     _loc5_ = this.height / 2;
                     _loc3_.scale(_loc6_,_loc6_);
                     _loc3_.translate(_loc4_,_loc5_);
                     _loc2_.draw(_loc7_,_loc3_);
                  }
                  else if(_loc1_ is BubbleAsset)
                  {
                     _loc12_ = BubbleAsset(_loc1_);
                     _loc2_ = new BitmapData(this.width,this.height,true,this.BG_COLOR);
                     _loc6_ = 0.9 * Math.min(this.width / _loc8_.width,this.height / _loc8_.height);
                     _loc4_ = (this.width - _loc6_ * _loc8_.width) / 2 - _loc6_ * _loc8_.x;
                     _loc5_ = (this.height - _loc6_ * _loc8_.height) / 2 - _loc6_ * _loc8_.y;
                     _loc3_.scale(_loc6_,_loc6_);
                     _loc3_.translate(_loc4_,_loc5_);
                     _loc2_.draw(_loc7_,_loc3_);
                  }
                  else if(_loc1_ is EffectAsset)
                  {
                     _loc13_ = EffectAsset(_loc1_);
                     (_loc15_ = (_loc14_ = new ProductThumbImageFactory()).createImage(Thumb(_loc13_.thumb))).product = Thumb(_loc13_.thumb);
                     DisplayObject(_loc15_).x = 10;
                     DisplayObject(_loc15_).y = 10;
                     this.addChild(_loc15_ as DisplayObject);
                  }
               }
            }
            this.graphics.beginFill(this.BG_COLOR);
            if(_loc2_)
            {
               this.graphics.beginBitmapFill(_loc2_,new Matrix(),false,true);
            }
            this.graphics.drawRoundRect(0,0,this.width,this.height,10,10);
            this.graphics.endFill();
         }
      }
   }
}
