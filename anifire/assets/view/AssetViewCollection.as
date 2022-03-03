package anifire.assets.view
{
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.ProgramEffectAsset;
   import anifire.core.Prop;
   import anifire.interfaces.IAssetCollection;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IPlayable;
   import anifire.iterators.ArrayIterator;
   import anifire.tutorial.TutorialEvent;
   import anifire.util.UtilUser;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public class AssetViewCollection extends EventDispatcher implements IAssetCollection
   {
       
      
      private var _assets:Array;
      
      public function AssetViewCollection(param1:IEventDispatcher = null)
      {
         super(param1);
         this._assets = new Array();
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         return new ArrayIterator(this._assets);
      }
      
      private function isGroupable(param1:IAssetView) : Boolean
      {
         if(param1.asset is ProgramEffectAsset && ProgramEffectAsset(param1.asset).getExactType() == "zoom")
         {
            return true;
         }
         if(param1.asset)
         {
            return param1.asset is Character || param1.asset is Prop || param1.asset is BubbleAsset;
         }
         return false;
      }
      
      public function intersects(param1:IAssetCollection) : Boolean
      {
         var _loc3_:Object = null;
         var _loc2_:IIterator = param1.iterator();
         while(_loc2_.hasNext)
         {
            _loc3_ = _loc2_.next;
            if(this._assets.indexOf(_loc3_) >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isInCollection(param1:IAssetView) : Boolean
      {
         return this._assets.indexOf(param1) != -1;
      }
      
      public function get selectedAsset() : IAssetView
      {
         if(this._assets.length == 1)
         {
            return this._assets[0] as IAssetView;
         }
         return null;
      }
      
      public function get length() : Number
      {
         return this._assets.length;
      }
      
      public function addAsset(param1:IAssetCollection) : Boolean
      {
         var _loc2_:IIterator = null;
         var _loc3_:Boolean = false;
         var _loc4_:IAssetView = null;
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
         }
         if(param1)
         {
            _loc2_ = param1.iterator();
            _loc3_ = false;
            while(_loc2_.hasNext)
            {
               if((_loc4_ = _loc2_.next as IAssetView) && !this.isInCollection(_loc4_))
               {
                  this.addView(_loc4_);
                  _loc3_ = true;
               }
            }
            if(_loc3_)
            {
               this.dispatchEvent(new Event(Event.CHANGE));
               return true;
            }
         }
         return false;
      }
      
      public function replaceAllAssets(param1:Array) : void
      {
         var _loc3_:IAssetView = null;
         var _loc4_:uint = 0;
         var _loc2_:IIterator = this.iterator();
         while(_loc2_.hasNext)
         {
            _loc3_ = IAssetView(_loc2_.next);
            if(_loc3_ is IPlayable)
            {
               IPlayable(_loc3_).resume();
            }
         }
         this._assets = new Array();
         if(param1 && param1.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ = param1[_loc4_] as IAssetView;
               if(_loc3_ && !this.isInCollection(_loc3_))
               {
                  this.addView(_loc3_);
               }
               _loc4_++;
            }
         }
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function addView(param1:IAssetView) : Boolean
      {
         if(param1 && !this.isInCollection(param1))
         {
            if(!this.isGroupable(param1))
            {
               this.clearCollection();
            }
            if(this.selectedAsset && !this.isGroupable(this.selectedAsset))
            {
               this.clearCollection();
            }
            this._assets.push(param1);
            if(param1 is IPlayable)
            {
               IPlayable(param1).pause();
            }
            if(this.selectedAsset)
            {
               if(Console.getConsole().isTutorialOn && param1.asset is Character)
               {
                  Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_SELECTED,param1.asset));
               }
            }
            return true;
         }
         return false;
      }
      
      public function removeAsset(param1:IAssetCollection) : Boolean
      {
         var _loc4_:IAssetView = null;
         var _loc2_:IIterator = param1.iterator();
         var _loc3_:Boolean = false;
         while(_loc2_.hasNext)
         {
            if(_loc4_ = _loc2_.next as IAssetView)
            {
               this.removeView(_loc4_);
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            this.dispatchEvent(new Event(Event.CHANGE));
            return true;
         }
         return false;
      }
      
      private function removeView(param1:IAssetView) : Boolean
      {
         if(param1 && this.isInCollection(param1))
         {
            this._assets.splice(this._assets.indexOf(param1),1);
            if(param1 is IPlayable)
            {
               IPlayable(param1).resume();
            }
            return true;
         }
         return false;
      }
      
      public function clearCollection() : void
      {
         var _loc2_:IAssetView = null;
         var _loc1_:IIterator = this.iterator();
         while(_loc1_.hasNext)
         {
            _loc2_ = IAssetView(_loc1_.next);
            if(_loc2_ is IPlayable)
            {
               IPlayable(_loc2_).resume();
            }
         }
         this._assets = new Array();
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function getBounds(param1:DisplayObject) : Rectangle
      {
         var _loc2_:Rectangle = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:uint = 0;
         while(_loc4_ < this._assets.length)
         {
            _loc3_ = this._assets[_loc4_] as DisplayObject;
            if(_loc3_)
            {
               if(_loc2_)
               {
                  _loc2_ = _loc2_.union(_loc3_.getBounds(param1));
               }
               else
               {
                  _loc2_ = _loc3_.getBounds(param1);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}
