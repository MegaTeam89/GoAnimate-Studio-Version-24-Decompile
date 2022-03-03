package anifire.playback.asset.motion
{
   import flash.geom.Point;
   
   public class MotionCache
   {
       
      
      private var _position:Array;
      
      private var _scale:Array;
      
      private var _rotation:Array;
      
      private var _hFlipped:Array;
      
      public function MotionCache(param1:IAssetMotion, param2:uint)
      {
         this._position = new Array();
         this._scale = new Array();
         this._rotation = new Array();
         this._hFlipped = new Array();
         super();
         var _loc3_:uint = 0;
         while(_loc3_ < param2)
         {
            this._position.push(param1.getPosition(_loc3_ / (param2 - 1)));
            this._scale.push(param1.getScale(_loc3_ / (param2 - 1)));
            this._rotation.push(param1.getRotation(_loc3_ / (param2 - 1)));
            this._hFlipped.push(param1.getHFlipped(_loc3_ / (param2 - 1)));
            _loc3_++;
         }
      }
      
      public function getPosition(param1:uint) : Point
      {
         return this._position[param1 - 1];
      }
      
      public function getScale(param1:uint) : Point
      {
         return this._scale[param1 - 1];
      }
      
      public function getRotation(param1:uint) : Number
      {
         return this._rotation[param1 - 1];
      }
      
      public function getHFlipped(param1:uint) : Boolean
      {
         return this._hFlipped[param1 - 1];
      }
   }
}
