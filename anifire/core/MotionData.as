package anifire.core
{
   import Singularity.Geom.BezierSpline;
   import anifire.interfaces.IXmlConvertable;
   import anifire.playback.asset.motion.BezierSplineController;
   import anifire.util.UtilMath;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class MotionData extends EventDispatcher implements IXmlConvertable
   {
      
      public static const XML_TAG_NAME:String = "assetMotion";
       
      
      private var _interPoints:Array;
      
      private var _startPoint:Point;
      
      private var _endPoint:Point;
      
      private var _startSize:SizeData;
      
      private var _endSize:SizeData;
      
      private var _startRotation:Number = 0;
      
      private var _endRotation:Number = 0;
      
      private var _maxInterPointNum:uint = 99;
      
      private var _startShiftPoint:Point;
      
      private var _endShiftPoint:Point;
      
      private var _pathOriented:Boolean = false;
      
      private var _version:String = "2";
      
      private var _spline:BezierSpline;
      
      private var _splineController:BezierSplineController;
      
      public function MotionData()
      {
         this._interPoints = new Array();
         this._startPoint = new Point(0,0);
         this._startSize = new SizeData(0,0);
         this._endSize = new SizeData(0,0);
         this._startShiftPoint = new Point(0,0);
         this._endShiftPoint = new Point(0,0);
         super();
      }
      
      public function set pathOriented(param1:Boolean) : void
      {
         if(this._pathOriented != param1)
         {
            this._pathOriented = param1;
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function get version() : String
      {
         return this._version;
      }
      
      public function set version(param1:String) : void
      {
         this._version = param1;
      }
      
      public function get pathOriented() : Boolean
      {
         return this._pathOriented;
      }
      
      public function get ssp() : Point
      {
         return this._startShiftPoint;
      }
      
      public function set ssp(param1:Point) : void
      {
         this._startShiftPoint = param1;
      }
      
      public function get esp() : Point
      {
         return this._endShiftPoint;
      }
      
      public function set esp(param1:Point) : void
      {
         this._endShiftPoint = param1;
      }
      
      public function get maxInterPointNum() : uint
      {
         return this._maxInterPointNum;
      }
      
      public function set maxInterPointNum(param1:uint) : void
      {
         this._maxInterPointNum = param1;
      }
      
      public function get path() : Array
      {
         var _loc2_:Point = null;
         var _loc1_:Array = new Array();
         if(this.startPoint)
         {
            _loc2_ = this.startPoint.add(this.ssp);
            _loc1_.push(_loc2_);
         }
         _loc1_ = _loc1_.concat(this._interPoints);
         if(this.endPoint)
         {
            _loc2_ = this.endPoint.add(this.esp);
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function set path(param1:Array) : void
      {
         var _loc2_:uint = 0;
         if(param1.length > 1)
         {
            this._startPoint = Point(param1[0]).clone();
            this._interPoints = new Array();
            if(param1.length > 2)
            {
               _loc2_ = 1;
               while(_loc2_ < param1.length - 1)
               {
                  this._interPoints.push(Point(param1[_loc2_]).clone());
                  _loc2_++;
               }
            }
            this._endPoint = Point(param1[param1.length - 1]).clone();
            this.updateSpline();
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function clone() : MotionData
      {
         var _loc1_:MotionData = new MotionData();
         _loc1_.path = this.path;
         _loc1_.pathOriented = this.pathOriented;
         _loc1_.version = this.version;
         return _loc1_;
      }
      
      public function set startPoint(param1:Point) : void
      {
         if(param1)
         {
            this._startPoint = param1.clone();
            this.updateSpline();
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function get startPoint() : Point
      {
         return this._startPoint;
      }
      
      public function set endPoint(param1:Point) : void
      {
         if(param1)
         {
            this._endPoint = param1.clone();
            this.updateSpline();
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function get endPoint() : Point
      {
         return this._endPoint;
      }
      
      public function get startSize() : SizeData
      {
         return this._startSize;
      }
      
      public function get endSize() : SizeData
      {
         return this._endSize;
      }
      
      public function set startSize(param1:SizeData) : void
      {
         this._startSize = param1;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function set endSize(param1:SizeData) : void
      {
         this._endSize = param1;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get displacement() : Point
      {
         return new Point(this.endPoint.x - this.startPoint.x,this.endPoint.y - this.startPoint.y);
      }
      
      public function convertToXml() : XML
      {
         var _loc1_:XML = new XML("<" + XML_TAG_NAME + "/>");
         if(this._pathOriented)
         {
            _loc1_.@pathOriented = "1";
         }
         _loc1_.@ver = this._version;
         return _loc1_;
      }
      
      public function convertFromXml(param1:XML) : Boolean
      {
         if(param1)
         {
            if(param1.hasOwnProperty("@pathOriented") && String(param1.@pathOriented) == "1")
            {
               this._pathOriented = true;
            }
            if(param1.hasOwnProperty("@ver"))
            {
               this._version = String(param1.@ver);
            }
            else
            {
               this._version = "1";
            }
         }
         return true;
      }
      
      public function set startRotation(param1:Number) : void
      {
         if(this._startRotation != param1)
         {
            this._startRotation = param1;
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function set endRotation(param1:Number) : void
      {
         if(this._endRotation != param1)
         {
            this._endRotation = param1;
         }
      }
      
      public function get startRotation() : Number
      {
         return this._startRotation;
      }
      
      public function get endRotation() : Number
      {
         if(this._pathOriented)
         {
            return this.getRotation(1);
         }
         return this._endRotation;
      }
      
      private function getRotation(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc2_:Number = this.startRotation;
         if(this._pathOriented)
         {
            if(this._interPoints.length > 0)
            {
               _loc3_ = 100;
               _loc4_ = 0;
               _loc5_ = this._splineController.getPosition(0,this._version == "2");
               _loc6_ = this._splineController.getPosition(1 / _loc3_,this._version == "2");
               if(Point(this._interPoints[0]).x > this.startPoint.x)
               {
                  _loc4_ = Math.atan2(_loc6_.y - _loc5_.y,_loc6_.x - _loc5_.x) * 180 / Math.PI;
               }
               else
               {
                  _loc4_ = Math.atan2(-_loc6_.y + _loc5_.y,-_loc6_.x + _loc5_.x) * 180 / Math.PI;
               }
               _loc7_ = 0;
               _loc5_ = this._splineController.getPosition(Math.max(0,param1 - 1 / _loc3_),this._version == "2");
               _loc6_ = this._splineController.getPosition(Math.min(1,param1 + 1 / _loc3_),this._version == "2");
               if(Point(this._interPoints[0]).x > this.startPoint.x)
               {
                  _loc7_ = Math.atan2(_loc6_.y - _loc5_.y,_loc6_.x - _loc5_.x) * 180 / Math.PI;
               }
               else
               {
                  _loc7_ = Math.atan2(-_loc6_.y + _loc5_.y,-_loc6_.x + _loc5_.x) * 180 / Math.PI;
               }
               _loc2_ += _loc7_ - _loc4_;
            }
         }
         else
         {
            _loc2_ = UtilMath.linearInterpolation(this.startRotation,this.endRotation,param1);
         }
         return _loc2_;
      }
      
      private function updateSpline() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = this.path;
         if(_loc1_.length > 2)
         {
            this._spline = new BezierSpline();
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               this._spline.addControlPoint(Point(_loc1_[_loc2_]).x,Point(_loc1_[_loc2_]).y);
               _loc2_++;
            }
            this._splineController = new BezierSplineController(this._spline);
         }
      }
   }
}
