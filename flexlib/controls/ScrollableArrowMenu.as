package flexlib.controls
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import mx.controls.Button;
   import mx.controls.Menu;
   import mx.controls.scrollClasses.ScrollBar;
   import mx.core.Application;
   import mx.core.ScrollPolicy;
   import mx.core.mx_internal;
   import mx.events.ScrollEvent;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class ScrollableArrowMenu extends ScrollableMenu
   {
      
      private static var DEFAULT_UP_BUTTON:Class = ScrollableArrowMenu_DEFAULT_UP_BUTTON;
      
      private static var DEFAULT_DOWN_BUTTON:Class = ScrollableArrowMenu_DEFAULT_DOWN_BUTTON;
      
      {
         initializeStyles();
      }
      
      private var upButton:Button;
      
      private var downButton:Button;
      
      private var timer:Timer;
      
      public var scrollSpeed:Number = 80;
      
      public var scrollJump:Number = 1;
      
      private var _arrowScrollPolicy:String = "auto";
      
      public function ScrollableArrowMenu()
      {
         super();
      }
      
      public static function createMenu(param1:DisplayObjectContainer, param2:Object, param3:Boolean = true) : ScrollableArrowMenu
      {
         var _loc4_:ScrollableArrowMenu;
         (_loc4_ = new ScrollableArrowMenu()).tabEnabled = false;
         _loc4_.owner = DisplayObjectContainer(Application.application);
         _loc4_.showRoot = param3;
         popUpMenu(_loc4_,param1,param2);
         return _loc4_;
      }
      
      private static function initializeStyles() : void
      {
         var selector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ScrollableArrowMenu");
         if(!selector)
         {
            selector = new CSSStyleDeclaration();
         }
         selector.defaultFactory = function():void
         {
            this.upButtonStyleName = "upButton";
            this.downButtonStyleName = "downButton";
         };
         StyleManager.setStyleDeclaration("ScrollableArrowMenu",selector,false);
         var upStyleName:String = selector.getStyle("upButtonStyleName");
         var upSelector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("." + upStyleName);
         if(!upSelector)
         {
            upSelector = new CSSStyleDeclaration();
         }
         upSelector.defaultFactory = function():void
         {
            this.icon = DEFAULT_UP_BUTTON;
            this.fillAlphas = [1,1,1,1];
            this.cornerRadius = 0;
         };
         StyleManager.setStyleDeclaration("." + upStyleName,upSelector,false);
         var downStyleName:String = selector.getStyle("downButtonStyleName");
         var downSelector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("." + downStyleName);
         if(!downSelector)
         {
            downSelector = new CSSStyleDeclaration();
         }
         downSelector.defaultFactory = function():void
         {
            this.icon = DEFAULT_DOWN_BUTTON;
            this.fillAlphas = [1,1,1,1];
            this.cornerRadius = 0;
         };
         StyleManager.setStyleDeclaration("." + downStyleName,downSelector,false);
      }
      
      public function get arrowScrollPolicy() : String
      {
         return this._arrowScrollPolicy;
      }
      
      public function set arrowScrollPolicy(param1:String) : void
      {
         this._arrowScrollPolicy = param1;
         invalidateDisplayList();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         ScrollableArrowMenu.initializeStyles();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.upButton = new Button();
         this.downButton = new Button();
         this.upButton.styleName = getStyle("upButtonStyleName");
         this.downButton.styleName = getStyle("downButtonStyleName");
         addChild(this.upButton);
         addChild(this.downButton);
         this.upButton.addEventListener(MouseEvent.ROLL_OVER,this.startScrollingUp);
         this.upButton.addEventListener(MouseEvent.ROLL_OUT,this.stopScrolling);
         this.downButton.addEventListener(MouseEvent.ROLL_OVER,this.startScrollingDown);
         this.downButton.addEventListener(MouseEvent.ROLL_OUT,this.stopScrolling);
         this.addEventListener(ScrollEvent.SCROLL,this.checkButtons);
      }
      
      override protected function createSubMenu() : Menu
      {
         var _loc1_:ScrollableArrowMenu = new ScrollableArrowMenu();
         _loc1_.arrowScrollPolicy = this.arrowScrollPolicy;
         return _loc1_;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:Number = param1;
         if(verticalScrollBar && verticalScrollBar.visible)
         {
            _loc3_ = param1 - ScrollBar.THICKNESS;
         }
         this.upButton.setActualSize(_loc3_,15);
         this.downButton.setActualSize(_loc3_,15);
         this.upButton.move(0,0);
         this.downButton.move(0,measuredHeight - this.downButton.height);
         this.checkButtons(null);
      }
      
      private function checkButtons(param1:Event) : void
      {
         if(this.arrowScrollPolicy == ScrollPolicy.AUTO)
         {
            this.upButton.visible = this.upButton.enabled = this.verticalScrollPosition != 0;
            this.downButton.visible = this.downButton.enabled = this.verticalScrollPosition != this.maxVerticalScrollPosition;
         }
         else if(this.arrowScrollPolicy == ScrollPolicy.ON)
         {
            this.upButton.visible = this.downButton.visible = true;
            this.upButton.enabled = this.verticalScrollPosition != 0;
            this.downButton.enabled = this.verticalScrollPosition != this.maxVerticalScrollPosition;
         }
         else
         {
            this.upButton.visible = this.upButton.enabled = this.downButton.visible = this.downButton.enabled = false;
         }
      }
      
      private function startScrollingUp(param1:Event) : void
      {
         if(this.timer && this.timer.running)
         {
            this.timer.stop();
         }
         this.timer = new Timer(this.scrollSpeed);
         this.timer.addEventListener(TimerEvent.TIMER,this.scrollUp);
         this.timer.start();
      }
      
      private function startScrollingDown(param1:Event) : void
      {
         if(this.timer && this.timer.running)
         {
            this.timer.stop();
         }
         this.timer = new Timer(this.scrollSpeed);
         this.timer.addEventListener(TimerEvent.TIMER,this.scrollDown);
         this.timer.start();
      }
      
      private function stopScrolling(param1:Event) : void
      {
         param1.currentTarget.removeEventListener(MouseEvent.MOUSE_UP,this.stopScrolling);
         if(this.timer && this.timer.running)
         {
            this.timer.stop();
         }
      }
      
      private function scrollUp(param1:TimerEvent) : void
      {
         if(this.verticalScrollPosition - this.scrollJump > 0)
         {
            this.verticalScrollPosition -= this.scrollJump;
         }
         else
         {
            this.verticalScrollPosition = 0;
         }
         this.checkButtons(null);
      }
      
      private function scrollDown(param1:TimerEvent) : void
      {
         if(this.verticalScrollPosition + this.scrollJump < this.maxVerticalScrollPosition)
         {
            this.verticalScrollPosition += this.scrollJump;
         }
         else
         {
            this.verticalScrollPosition = this.maxVerticalScrollPosition;
         }
         this.checkButtons(null);
      }
   }
}
