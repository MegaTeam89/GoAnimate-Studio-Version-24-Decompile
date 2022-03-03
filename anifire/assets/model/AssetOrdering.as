package anifire.assets.model
{
   import anifire.interfaces.IAsset;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
   import anifire.iterators.ArrayIterator;
   
   public class AssetOrdering implements ICollection
   {
       
      
      private var _assetOrders:Array;
      
      public function AssetOrdering()
      {
         this._assetOrders = new Array();
         super();
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         return new ArrayIterator(this._assetOrders);
      }
      
      public function getOrdering(param1:IAsset) : int
      {
         if(param1)
         {
            return this._assetOrders.indexOf(param1);
         }
         return -1;
      }
      
      public function addAsset(param1:IAsset) : int
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = this.getOrdering(param1);
            if(_loc2_ == -1)
            {
               this._assetOrders.push(param1);
               return this._assetOrders.length - 1;
            }
         }
         return -1;
      }
      
      public function removeAsset(param1:IAsset) : int
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = this.getOrdering(param1);
            if(_loc2_ != -1)
            {
               this._assetOrders.splice(_loc2_,1);
               return _loc2_;
            }
         }
         return -1;
      }
      
      public function bringForward(param1:IAsset) : int
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = this.getOrdering(param1);
            if(_loc2_ != -1)
            {
               if(_loc2_ < this._assetOrders.length - 1)
               {
                  this._assetOrders.splice(_loc2_,1);
                  _loc2_++;
                  this._assetOrders.splice(_loc2_,0,param1);
               }
               return _loc2_;
            }
         }
         return -1;
      }
      
      public function sendBackward(param1:IAsset) : int
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = this.getOrdering(param1);
            if(_loc2_ != -1)
            {
               if(_loc2_ > 0)
               {
                  this._assetOrders.splice(_loc2_,1);
                  _loc2_--;
                  this._assetOrders.splice(_loc2_,0,param1);
               }
               return _loc2_;
            }
         }
         return -1;
      }
      
      public function bringToFront(param1:IAsset) : int
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = this.getOrdering(param1);
            if(_loc2_ != -1)
            {
               this._assetOrders.splice(_loc2_,1);
               this._assetOrders.splice(this._assetOrders.length,0,param1);
               return 0;
            }
         }
         return -1;
      }
      
      public function sendToBack(param1:IAsset) : int
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = this.getOrdering(param1);
            if(_loc2_ != -1)
            {
               this._assetOrders.splice(_loc2_,1);
               this._assetOrders.splice(0,0,param1);
               return 0;
            }
         }
         return -1;
      }
      
      public function get length() : uint
      {
         return this._assetOrders.length;
      }
   }
}
