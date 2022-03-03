package mx.controls.scrollClasses
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import mx.controls.Button;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.SandboxMouseEvent;
   import mx.events.ScrollEvent;
   import mx.events.ScrollEventDetail;
   import mx.styles.ISimpleStyleClient;
   import mx.styles.StyleProxy;
   
   use namespace mx_internal;
   
   public class ScrollBar extends UIComponent
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
      
      public static const THICKNESS:Number = 16;
       
      
      mx_internal var upArrow:Button;
      
      mx_internal var downArrow:Button;
      
      mx_internal var scrollTrack:Button;
      
      mx_internal var scrollThumb:ScrollThumb;
      
      mx_internal var _minWidth:Number = 16;
      
      mx_internal var _minHeight:Number = 32;
      
      mx_internal var isScrolling:Boolean;
      
      private var trackScrollTimer:Timer;
      
      private var trackScrollRepeatDirection:int;
      
      private var trackScrolling:Boolean = false;
      
      private var trackPosition:Number;
      
      mx_internal var oldPosition:Number;
      
      private var _direction:String = "vertical";
      
      private var _lineScrollSize:Number = 1;
      
      private var _maxScrollPosition:Number = 0;
      
      private var _minScrollPosition:Number = 0;
      
      private var _pageSize:Number = 0;
      
      private var _pageScrollSize:Number = 0;
      
      private var _scrollPosition:Number = 0;
      
      public function ScrollBar()
      {
         super();
      }
      
      override public function set doubleClickEnabled(param1:Boolean) : void
      {
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         invalidateDisplayList();
      }
      
      [Bindable("directionChanged")]
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         this._direction = param1;
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("directionChanged"));
      }
      
      protected function get downArrowStyleFilters() : Object
      {
         return null;
      }
      
      mx_internal function get lineMinusDetail() : String
      {
         return this.direction == ScrollBarDirection.VERTICAL ? ScrollEventDetail.LINE_UP : ScrollEventDetail.LINE_LEFT;
      }
      
      mx_internal function get linePlusDetail() : String
      {
         return this.direction == ScrollBarDirection.VERTICAL ? ScrollEventDetail.LINE_DOWN : ScrollEventDetail.LINE_RIGHT;
      }
      
      public function get lineScrollSize() : Number
      {
         return this._lineScrollSize;
      }
      
      public function set lineScrollSize(param1:Number) : void
      {
         this._lineScrollSize = param1;
      }
      
      private function get maxDetail() : String
      {
         return this.direction == ScrollBarDirection.VERTICAL ? ScrollEventDetail.AT_BOTTOM : ScrollEventDetail.AT_RIGHT;
      }
      
      public function get maxScrollPosition() : Number
      {
         return this._maxScrollPosition;
      }
      
      public function set maxScrollPosition(param1:Number) : void
      {
         this._maxScrollPosition = param1;
         invalidateDisplayList();
      }
      
      private function get minDetail() : String
      {
         return this.direction == ScrollBarDirection.VERTICAL ? ScrollEventDetail.AT_TOP : ScrollEventDetail.AT_LEFT;
      }
      
      public function get minScrollPosition() : Number
      {
         return this._minScrollPosition;
      }
      
      public function set minScrollPosition(param1:Number) : void
      {
         this._minScrollPosition = param1;
         invalidateDisplayList();
      }
      
      mx_internal function get pageMinusDetail() : String
      {
         return this.direction == ScrollBarDirection.VERTICAL ? ScrollEventDetail.PAGE_UP : ScrollEventDetail.PAGE_LEFT;
      }
      
      mx_internal function get pagePlusDetail() : String
      {
         return this.direction == ScrollBarDirection.VERTICAL ? ScrollEventDetail.PAGE_DOWN : ScrollEventDetail.PAGE_RIGHT;
      }
      
      public function get pageSize() : Number
      {
         return this._pageSize;
      }
      
      public function set pageSize(param1:Number) : void
      {
         this._pageSize = param1;
      }
      
      public function get pageScrollSize() : Number
      {
         return this._pageScrollSize;
      }
      
      public function set pageScrollSize(param1:Number) : void
      {
         this._pageScrollSize = param1;
      }
      
      public function get scrollPosition() : Number
      {
         return this._scrollPosition;
      }
      
      public function set scrollPosition(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         this._scrollPosition = param1;
         if(this.scrollThumb)
         {
            if(!cacheAsBitmap)
            {
               cacheHeuristic = this.scrollThumb.cacheHeuristic = true;
            }
            if(!this.isScrolling)
            {
               param1 = Math.min(param1,this.maxScrollPosition);
               param1 = Math.max(param1,this.minScrollPosition);
               _loc2_ = this.maxScrollPosition - this.minScrollPosition;
               _loc3_ = _loc2_ == 0 || isNaN(_loc2_) ? Number(0) : Number((param1 - this.minScrollPosition) * (this.trackHeight - this.scrollThumb.height) / _loc2_ + this.trackY);
               _loc4_ = (this.virtualWidth - this.scrollThumb.width) / 2 + getStyle("thumbOffset");
               this.scrollThumb.move(Math.round(_loc4_),Math.round(_loc3_));
            }
         }
      }
      
      protected function get thumbStyleFilters() : Object
      {
         return null;
      }
      
      private function get trackHeight() : Number
      {
         return this.virtualHeight - (this.upArrow.getExplicitOrMeasuredHeight() + this.downArrow.getExplicitOrMeasuredHeight());
      }
      
      private function get trackY() : Number
      {
         return this.upArrow.getExplicitOrMeasuredHeight();
      }
      
      protected function get upArrowStyleFilters() : Object
      {
         return null;
      }
      
      mx_internal function get virtualHeight() : Number
      {
         return unscaledHeight;
      }
      
      mx_internal function get virtualWidth() : Number
      {
         return unscaledWidth;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(!this.scrollTrack)
         {
            this.scrollTrack = new Button();
            this.scrollTrack.focusEnabled = false;
            this.scrollTrack.tabEnabled = false;
            this.scrollTrack.skinName = "trackSkin";
            this.scrollTrack.upSkinName = "trackUpSkin";
            this.scrollTrack.overSkinName = "trackOverSkin";
            this.scrollTrack.downSkinName = "trackDownSkin";
            this.scrollTrack.disabledSkinName = "trackDisabledSkin";
            if(this.scrollTrack is ISimpleStyleClient)
            {
               ISimpleStyleClient(this.scrollTrack).styleName = this;
            }
            addChild(this.scrollTrack);
            this.scrollTrack.validateProperties();
         }
         if(!this.upArrow)
         {
            this.upArrow = new Button();
            this.upArrow.enabled = false;
            this.upArrow.autoRepeat = true;
            this.upArrow.focusEnabled = false;
            this.upArrow.tabEnabled = false;
            this.upArrow.upSkinName = "upArrowUpSkin";
            this.upArrow.overSkinName = "upArrowOverSkin";
            this.upArrow.downSkinName = "upArrowDownSkin";
            this.upArrow.disabledSkinName = "upArrowDisabledSkin";
            this.upArrow.skinName = "upArrowSkin";
            this.upArrow.upIconName = "";
            this.upArrow.overIconName = "";
            this.upArrow.downIconName = "";
            this.upArrow.disabledIconName = "";
            addChild(this.upArrow);
            this.upArrow.styleName = new StyleProxy(this,this.upArrowStyleFilters);
            this.upArrow.validateProperties();
            this.upArrow.addEventListener(FlexEvent.BUTTON_DOWN,this.upArrow_buttonDownHandler);
         }
         if(!this.downArrow)
         {
            this.downArrow = new Button();
            this.downArrow.enabled = false;
            this.downArrow.autoRepeat = true;
            this.downArrow.focusEnabled = false;
            this.downArrow.tabEnabled = false;
            this.downArrow.upSkinName = "downArrowUpSkin";
            this.downArrow.overSkinName = "downArrowOverSkin";
            this.downArrow.downSkinName = "downArrowDownSkin";
            this.downArrow.disabledSkinName = "downArrowDisabledSkin";
            this.downArrow.skinName = "downArrowSkin";
            this.downArrow.upIconName = "";
            this.downArrow.overIconName = "";
            this.downArrow.downIconName = "";
            this.downArrow.disabledIconName = "";
            addChild(this.downArrow);
            this.downArrow.styleName = new StyleProxy(this,this.downArrowStyleFilters);
            this.downArrow.validateProperties();
            this.downArrow.addEventListener(FlexEvent.BUTTON_DOWN,this.downArrow_buttonDownHandler);
         }
      }
      
      override protected function measure() : void
      {
         super.measure();
         this.upArrow.validateSize();
         this.downArrow.validateSize();
         this.scrollTrack.validateSize();
         this._minWidth = !!this.scrollThumb ? Number(this.scrollThumb.getExplicitOrMeasuredWidth()) : Number(0);
         this._minWidth = Math.max(this.scrollTrack.getExplicitOrMeasuredWidth(),this.upArrow.getExplicitOrMeasuredWidth(),this.downArrow.getExplicitOrMeasuredWidth(),this._minWidth);
         this._minHeight = this.upArrow.getExplicitOrMeasuredHeight() + this.downArrow.getExplicitOrMeasuredHeight();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         if(mx_internal::$height == 1)
         {
            return;
         }
         if(!this.upArrow)
         {
            return;
         }
         super.updateDisplayList(param1,param2);
         if(cacheAsBitmap)
         {
            cacheHeuristic = false;
            if(this.scrollThumb)
            {
               this.scrollThumb.cacheHeuristic = false;
            }
         }
         this.upArrow.setActualSize(this.upArrow.getExplicitOrMeasuredWidth(),this.upArrow.getExplicitOrMeasuredHeight());
         this.upArrow.move((this.virtualWidth - this.upArrow.width) / 2,0);
         this.scrollTrack.setActualSize(this.scrollTrack.getExplicitOrMeasuredWidth(),this.virtualHeight);
         this.scrollTrack.x = (this.virtualWidth - this.scrollTrack.width) / 2;
         this.scrollTrack.y = 0;
         this.downArrow.setActualSize(this.downArrow.getExplicitOrMeasuredWidth(),this.downArrow.getExplicitOrMeasuredHeight());
         this.downArrow.move((this.virtualWidth - this.downArrow.width) / 2,this.virtualHeight - this.downArrow.getExplicitOrMeasuredHeight());
         this.setScrollProperties(this.pageSize,this.minScrollPosition,this.maxScrollPosition,this._pageScrollSize);
         this.scrollPosition = this._scrollPosition;
      }
      
      public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
      {
         var _loc5_:Number = NaN;
         this.pageSize = param1;
         this._pageScrollSize = param4 > 0 ? Number(param4) : Number(param1);
         this.minScrollPosition = Math.max(param2,0);
         this.maxScrollPosition = Math.max(param3,0);
         this._scrollPosition = Math.max(this.minScrollPosition,this._scrollPosition);
         this._scrollPosition = Math.min(this.maxScrollPosition,this._scrollPosition);
         if(this.maxScrollPosition - this.minScrollPosition > 0 && enabled)
         {
            this.upArrow.enabled = true;
            this.downArrow.enabled = true;
            this.scrollTrack.enabled = true;
            addEventListener(MouseEvent.MOUSE_DOWN,this.scrollTrack_mouseDownHandler);
            addEventListener(MouseEvent.MOUSE_OVER,this.scrollTrack_mouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.scrollTrack_mouseOutHandler);
            if(!this.scrollThumb)
            {
               this.scrollThumb = new ScrollThumb();
               this.scrollThumb.focusEnabled = false;
               this.scrollThumb.tabEnabled = false;
               addChildAt(this.scrollThumb,getChildIndex(this.downArrow));
               this.scrollThumb.styleName = new StyleProxy(this,this.thumbStyleFilters);
               this.scrollThumb.upSkinName = "thumbUpSkin";
               this.scrollThumb.overSkinName = "thumbOverSkin";
               this.scrollThumb.downSkinName = "thumbDownSkin";
               this.scrollThumb.iconName = "thumbIcon";
               this.scrollThumb.skinName = "thumbSkin";
            }
            if((_loc5_ = this.trackHeight < 0 ? Number(0) : Number(Math.round(param1 / (this.maxScrollPosition - this.minScrollPosition + param1) * this.trackHeight))) < this.scrollThumb.minHeight)
            {
               if(this.trackHeight < this.scrollThumb.minHeight)
               {
                  this.scrollThumb.visible = false;
               }
               else
               {
                  _loc5_ = this.scrollThumb.minHeight;
                  this.scrollThumb.visible = true;
                  this.scrollThumb.setActualSize(this.scrollThumb.measuredWidth,this.scrollThumb.minHeight);
               }
            }
            else
            {
               this.scrollThumb.visible = true;
               this.scrollThumb.setActualSize(this.scrollThumb.measuredWidth,_loc5_);
            }
            this.scrollThumb.setRange(this.upArrow.getExplicitOrMeasuredHeight() + 0,this.virtualHeight - this.downArrow.getExplicitOrMeasuredHeight() - this.scrollThumb.height,this.minScrollPosition,this.maxScrollPosition);
            this.scrollPosition = Math.max(Math.min(this.scrollPosition,this.maxScrollPosition),this.minScrollPosition);
         }
         else
         {
            this.upArrow.enabled = false;
            this.downArrow.enabled = false;
            this.scrollTrack.enabled = false;
            if(this.scrollThumb)
            {
               this.scrollThumb.visible = false;
            }
         }
      }
      
      mx_internal function lineScroll(param1:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc2_:Number = this._lineScrollSize;
         var _loc3_:Number = this._scrollPosition + param1 * _loc2_;
         if(_loc3_ > this.maxScrollPosition)
         {
            _loc3_ = this.maxScrollPosition;
         }
         else if(_loc3_ < this.minScrollPosition)
         {
            _loc3_ = this.minScrollPosition;
         }
         if(_loc3_ != this.scrollPosition)
         {
            _loc4_ = this.scrollPosition;
            this.scrollPosition = _loc3_;
            _loc5_ = param1 < 0 ? this.lineMinusDetail : this.linePlusDetail;
            this.dispatchScrollEvent(_loc4_,_loc5_);
         }
      }
      
      mx_internal function pageScroll(param1:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc2_:Number = this._pageScrollSize != 0 ? Number(this._pageScrollSize) : Number(this.pageSize);
         var _loc3_:Number = this._scrollPosition + param1 * _loc2_;
         if(_loc3_ > this.maxScrollPosition)
         {
            _loc3_ = this.maxScrollPosition;
         }
         else if(_loc3_ < this.minScrollPosition)
         {
            _loc3_ = this.minScrollPosition;
         }
         if(_loc3_ != this.scrollPosition)
         {
            _loc4_ = this.scrollPosition;
            this.scrollPosition = _loc3_;
            _loc5_ = param1 < 0 ? this.pageMinusDetail : this.pagePlusDetail;
            this.dispatchScrollEvent(_loc4_,_loc5_);
         }
      }
      
      mx_internal function dispatchScrollEvent(param1:Number, param2:String) : void
      {
         var _loc3_:ScrollEvent = new ScrollEvent(ScrollEvent.SCROLL);
         _loc3_.detail = param2;
         _loc3_.position = this.scrollPosition;
         _loc3_.delta = this.scrollPosition - param1;
         _loc3_.direction = this.direction;
         dispatchEvent(_loc3_);
      }
      
      mx_internal function isScrollBarKey(param1:uint) : Boolean
      {
         var _loc2_:Number = NaN;
         if(param1 == Keyboard.HOME)
         {
            if(this.scrollPosition != 0)
            {
               _loc2_ = this.scrollPosition;
               this.scrollPosition = 0;
               this.dispatchScrollEvent(_loc2_,this.minDetail);
            }
            return true;
         }
         if(param1 == Keyboard.END)
         {
            if(this.scrollPosition < this.maxScrollPosition)
            {
               _loc2_ = this.scrollPosition;
               this.scrollPosition = this.maxScrollPosition;
               this.dispatchScrollEvent(_loc2_,this.maxDetail);
            }
            return true;
         }
         return false;
      }
      
      private function upArrow_buttonDownHandler(param1:FlexEvent) : void
      {
         if(isNaN(this.oldPosition))
         {
            this.oldPosition = this.scrollPosition;
         }
         this.lineScroll(-1);
      }
      
      private function downArrow_buttonDownHandler(param1:FlexEvent) : void
      {
         if(isNaN(this.oldPosition))
         {
            this.oldPosition = this.scrollPosition;
         }
         this.lineScroll(1);
      }
      
      private function scrollTrack_mouseOverHandler(param1:MouseEvent) : void
      {
         if(!(param1.target == this || param1.target == this.scrollTrack) || !enabled)
         {
            return;
         }
         if(this.trackScrolling)
         {
            this.trackScrollTimer.start();
         }
      }
      
      private function scrollTrack_mouseOutHandler(param1:MouseEvent) : void
      {
         if(this.trackScrolling && enabled)
         {
            this.trackScrollTimer.stop();
         }
      }
      
      private function scrollTrack_mouseDownHandler(param1:MouseEvent) : void
      {
         if(!(param1.target == this || param1.target == this.scrollTrack) || !enabled)
         {
            return;
         }
         this.trackScrolling = true;
         var _loc2_:DisplayObject = systemManager.getSandboxRoot();
         _loc2_.addEventListener(MouseEvent.MOUSE_UP,this.scrollTrack_mouseUpHandler,true);
         _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.scrollTrack_mouseMoveHandler,true);
         _loc2_.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.scrollTrack_mouseLeaveHandler);
         systemManager.deployMouseShields(true);
         var _loc3_:Point = new Point(param1.localX,param1.localY);
         _loc3_ = param1.target.localToGlobal(_loc3_);
         _loc3_ = globalToLocal(_loc3_);
         this.trackPosition = _loc3_.y;
         if(isNaN(this.oldPosition))
         {
            this.oldPosition = this.scrollPosition;
         }
         this.trackScrollRepeatDirection = this.scrollThumb.y + this.scrollThumb.height < _loc3_.y ? 1 : (this.scrollThumb.y > _loc3_.y ? -1 : 0);
         this.pageScroll(this.trackScrollRepeatDirection);
         if(!this.trackScrollTimer)
         {
            this.trackScrollTimer = new Timer(getStyle("repeatDelay"),1);
            this.trackScrollTimer.addEventListener(TimerEvent.TIMER,this.trackScrollTimerHandler);
         }
         else
         {
            this.trackScrollTimer.delay = getStyle("repeatDelay");
            this.trackScrollTimer.repeatCount = 1;
         }
         this.trackScrollTimer.start();
      }
      
      private function trackScrollTimerHandler(param1:Event) : void
      {
         if(this.trackScrollRepeatDirection == 1)
         {
            if(this.scrollThumb.y + this.scrollThumb.height > this.trackPosition)
            {
               return;
            }
         }
         if(this.trackScrollRepeatDirection == -1)
         {
            if(this.scrollThumb.y < this.trackPosition)
            {
               return;
            }
         }
         this.pageScroll(this.trackScrollRepeatDirection);
         if(this.trackScrollTimer && this.trackScrollTimer.repeatCount == 1)
         {
            this.trackScrollTimer.delay = getStyle("repeatInterval");
            this.trackScrollTimer.repeatCount = 0;
         }
      }
      
      private function scrollTrack_mouseUpHandler(param1:MouseEvent) : void
      {
         this.scrollTrack_mouseLeaveHandler(param1);
      }
      
      private function scrollTrack_mouseLeaveHandler(param1:Event) : void
      {
         this.trackScrolling = false;
         var _loc2_:DisplayObject = systemManager.getSandboxRoot();
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,this.scrollTrack_mouseUpHandler,true);
         _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,this.scrollTrack_mouseMoveHandler,true);
         _loc2_.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.scrollTrack_mouseLeaveHandler);
         systemManager.deployMouseShields(false);
         if(this.trackScrollTimer)
         {
            this.trackScrollTimer.reset();
         }
         if(param1.target != this.scrollTrack)
         {
            return;
         }
         var _loc3_:String = this.oldPosition > this.scrollPosition ? this.pageMinusDetail : this.pagePlusDetail;
         this.dispatchScrollEvent(this.oldPosition,_loc3_);
         this.oldPosition = NaN;
      }
      
      private function scrollTrack_mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(this.trackScrolling)
         {
            _loc2_ = new Point(param1.stageX,param1.stageY);
            _loc2_ = globalToLocal(_loc2_);
            this.trackPosition = _loc2_.y;
         }
      }
   }
}
