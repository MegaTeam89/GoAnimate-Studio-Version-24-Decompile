package mx.containers.utilityClasses
{
   import flash.accessibility.AccessibilityProperties;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Transform;
   import mx.core.FlexVersion;
   import mx.core.IConstraintClient;
   import mx.core.IInvalidating;
   import mx.core.IUIComponent;
   import mx.managers.ISystemManager;
   
   public class PostScaleAdapter implements IUIComponent, IConstraintClient, IInvalidating
   {
       
      
      private var obj:IUIComponent;
      
      public function PostScaleAdapter(param1:IUIComponent)
      {
         super();
         this.obj = param1;
      }
      
      public static function getCompatibleIUIComponent(param1:Object) : IUIComponent
      {
         var _loc2_:IUIComponent = param1 as IUIComponent;
         if(!_loc2_)
         {
            return null;
         }
         if(_loc2_.scaleX == 1 && _loc2_.scaleY == 1 || FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_0)
         {
            return _loc2_;
         }
         if(_loc2_ is PostScaleAdapter)
         {
            return _loc2_;
         }
         return new PostScaleAdapter(_loc2_);
      }
      
      public function get baselinePosition() : Number
      {
         return this.obj.baselinePosition;
      }
      
      public function get document() : Object
      {
         return this.obj.document;
      }
      
      public function set document(param1:Object) : void
      {
         this.obj.document = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this.obj.enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this.obj.enabled = param1;
      }
      
      public function get explicitHeight() : Number
      {
         return this.obj.explicitHeight * Math.abs(this.obj.scaleY);
      }
      
      public function set explicitHeight(param1:Number) : void
      {
         this.obj.explicitHeight = this.obj.scaleY == 0 ? Number(0) : Number(param1 / Math.abs(this.obj.scaleY));
      }
      
      public function get explicitMaxHeight() : Number
      {
         return this.obj.explicitMaxHeight * Math.abs(this.obj.scaleY);
      }
      
      public function get explicitMaxWidth() : Number
      {
         return this.obj.explicitMaxWidth * Math.abs(this.obj.scaleX);
      }
      
      public function get explicitMinHeight() : Number
      {
         return this.obj.explicitMinHeight * Math.abs(this.obj.scaleY);
      }
      
      public function get explicitMinWidth() : Number
      {
         return this.obj.explicitMinWidth * Math.abs(this.obj.scaleX);
      }
      
      public function get explicitWidth() : Number
      {
         return this.obj.explicitWidth * Math.abs(this.obj.scaleX);
      }
      
      public function set explicitWidth(param1:Number) : void
      {
         this.obj.explicitWidth = this.obj.scaleX == 0 ? Number(0) : Number(param1 / Math.abs(this.obj.scaleX));
      }
      
      public function get focusPane() : Sprite
      {
         return this.obj.focusPane;
      }
      
      public function set focusPane(param1:Sprite) : void
      {
         this.obj.focusPane = param1;
      }
      
      public function get includeInLayout() : Boolean
      {
         return this.obj.includeInLayout;
      }
      
      public function set includeInLayout(param1:Boolean) : void
      {
         this.obj.includeInLayout = param1;
      }
      
      public function get isPopUp() : Boolean
      {
         return this.obj.isPopUp;
      }
      
      public function set isPopUp(param1:Boolean) : void
      {
         this.obj.isPopUp = param1;
      }
      
      public function get maxHeight() : Number
      {
         return this.obj.maxHeight * Math.abs(this.obj.scaleY);
      }
      
      public function get maxWidth() : Number
      {
         return this.obj.maxWidth * Math.abs(this.obj.scaleX);
      }
      
      public function get measuredMinHeight() : Number
      {
         return this.obj.measuredMinHeight * Math.abs(this.obj.scaleY);
      }
      
      public function set measuredMinHeight(param1:Number) : void
      {
         this.obj.measuredMinHeight = this.obj.scaleY == 0 ? Number(0) : Number(param1 / Math.abs(this.obj.scaleY));
      }
      
      public function get measuredMinWidth() : Number
      {
         return this.obj.measuredMinWidth * Math.abs(this.obj.scaleX);
      }
      
      public function set measuredMinWidth(param1:Number) : void
      {
         this.obj.measuredMinWidth = this.obj.scaleX == 0 ? Number(0) : Number(param1 / Math.abs(this.obj.scaleX));
      }
      
      public function get minHeight() : Number
      {
         return this.obj.minHeight * Math.abs(this.obj.scaleY);
      }
      
      public function get minWidth() : Number
      {
         return this.obj.minWidth * Math.abs(this.obj.scaleX);
      }
      
      public function get owner() : DisplayObjectContainer
      {
         return this.obj.owner;
      }
      
      public function set owner(param1:DisplayObjectContainer) : void
      {
         this.obj.owner = param1;
      }
      
      public function get percentHeight() : Number
      {
         return this.obj.percentHeight;
      }
      
      public function set percentHeight(param1:Number) : void
      {
         this.obj.percentHeight = param1;
      }
      
      public function get percentWidth() : Number
      {
         return this.obj.percentWidth;
      }
      
      public function set percentWidth(param1:Number) : void
      {
         this.obj.percentWidth = param1;
      }
      
      public function get systemManager() : ISystemManager
      {
         return this.obj.systemManager;
      }
      
      public function set systemManager(param1:ISystemManager) : void
      {
         this.obj.systemManager = param1;
      }
      
      public function get tweeningProperties() : Array
      {
         return this.obj.tweeningProperties;
      }
      
      public function set tweeningProperties(param1:Array) : void
      {
         this.obj.tweeningProperties = param1;
      }
      
      public function initialize() : void
      {
         this.obj.initialize();
      }
      
      public function parentChanged(param1:DisplayObjectContainer) : void
      {
         this.obj.parentChanged(param1);
      }
      
      public function getExplicitOrMeasuredWidth() : Number
      {
         return this.obj.getExplicitOrMeasuredWidth() * Math.abs(this.obj.scaleX);
      }
      
      public function getExplicitOrMeasuredHeight() : Number
      {
         return this.obj.getExplicitOrMeasuredHeight() * Math.abs(this.obj.scaleY);
      }
      
      public function setVisible(param1:Boolean, param2:Boolean = false) : void
      {
         this.obj.setVisible(param1,param2);
      }
      
      public function owns(param1:DisplayObject) : Boolean
      {
         return this.obj.owns(param1);
      }
      
      public function get measuredHeight() : Number
      {
         return this.obj.measuredHeight * Math.abs(this.obj.scaleY);
      }
      
      public function get measuredWidth() : Number
      {
         return this.obj.measuredWidth * Math.abs(this.obj.scaleX);
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         this.obj.move(param1,param2);
      }
      
      public function setActualSize(param1:Number, param2:Number) : void
      {
         this.obj.setActualSize(this.obj.scaleX == 0 ? Number(0) : Number(param1 / Math.abs(this.obj.scaleX)),this.obj.scaleY == 0 ? Number(0) : Number(param2 / Math.abs(this.obj.scaleY)));
      }
      
      public function get root() : DisplayObject
      {
         return this.obj.root;
      }
      
      public function get stage() : Stage
      {
         return this.obj.stage;
      }
      
      public function get name() : String
      {
         return this.obj.name;
      }
      
      public function set name(param1:String) : void
      {
         this.obj.name = param1;
      }
      
      public function get parent() : DisplayObjectContainer
      {
         return this.obj.parent;
      }
      
      public function get mask() : DisplayObject
      {
         return this.obj.mask;
      }
      
      public function set mask(param1:DisplayObject) : void
      {
         this.obj.mask = param1;
      }
      
      public function get visible() : Boolean
      {
         return this.obj.visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this.obj.visible = param1;
      }
      
      public function get x() : Number
      {
         return this.obj.x;
      }
      
      public function set x(param1:Number) : void
      {
         this.obj.x = param1;
      }
      
      public function get y() : Number
      {
         return this.obj.y;
      }
      
      public function set y(param1:Number) : void
      {
         this.obj.y = param1;
      }
      
      public function get scaleX() : Number
      {
         return this.obj.scaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         this.obj.scaleX = param1;
      }
      
      public function get scaleY() : Number
      {
         return this.obj.scaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         this.obj.scaleY = param1;
      }
      
      public function get mouseX() : Number
      {
         return this.obj.mouseX;
      }
      
      public function get mouseY() : Number
      {
         return this.obj.mouseY;
      }
      
      public function get rotation() : Number
      {
         return this.obj.rotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         this.obj.rotation = param1;
      }
      
      public function get alpha() : Number
      {
         return this.obj.alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this.obj.alpha = param1;
      }
      
      public function get width() : Number
      {
         return this.obj.width * Math.abs(this.obj.scaleX);
      }
      
      public function set width(param1:Number) : void
      {
         this.obj.width = this.obj.scaleX == 0 ? Number(0) : Number(param1 / Math.abs(this.obj.scaleX));
      }
      
      public function get height() : Number
      {
         return this.obj.height * Math.abs(this.obj.scaleY);
      }
      
      public function set height(param1:Number) : void
      {
         this.obj.height = this.obj.scaleY == 0 ? Number(0) : Number(param1 / Math.abs(this.obj.scaleY));
      }
      
      public function get cacheAsBitmap() : Boolean
      {
         return this.obj.cacheAsBitmap;
      }
      
      public function set cacheAsBitmap(param1:Boolean) : void
      {
         this.obj.cacheAsBitmap = param1;
      }
      
      public function get opaqueBackground() : Object
      {
         return this.obj.opaqueBackground;
      }
      
      public function set opaqueBackground(param1:Object) : void
      {
         this.obj.opaqueBackground = param1;
      }
      
      public function get scrollRect() : Rectangle
      {
         return this.obj.scrollRect;
      }
      
      public function set scrollRect(param1:Rectangle) : void
      {
         this.obj.scrollRect = param1;
      }
      
      public function get filters() : Array
      {
         return this.obj.filters;
      }
      
      public function set filters(param1:Array) : void
      {
         this.obj.filters = param1;
      }
      
      public function get blendMode() : String
      {
         return this.obj.blendMode;
      }
      
      public function set blendMode(param1:String) : void
      {
         this.obj.blendMode = param1;
      }
      
      public function get transform() : Transform
      {
         return this.obj.transform;
      }
      
      public function set transform(param1:Transform) : void
      {
         this.obj.transform = param1;
      }
      
      public function get scale9Grid() : Rectangle
      {
         return this.obj.scale9Grid;
      }
      
      public function set scale9Grid(param1:Rectangle) : void
      {
         this.obj.scale9Grid = param1;
      }
      
      public function globalToLocal(param1:Point) : Point
      {
         return this.obj.globalToLocal(param1);
      }
      
      public function localToGlobal(param1:Point) : Point
      {
         return this.obj.localToGlobal(param1);
      }
      
      public function getBounds(param1:DisplayObject) : Rectangle
      {
         return this.obj.getBounds(param1);
      }
      
      public function getRect(param1:DisplayObject) : Rectangle
      {
         return this.obj.getRect(param1);
      }
      
      public function get loaderInfo() : LoaderInfo
      {
         return this.obj.loaderInfo;
      }
      
      public function hitTestObject(param1:DisplayObject) : Boolean
      {
         return param1.hitTestObject(param1);
      }
      
      public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return this.hitTestPoint(param1,param2,param3);
      }
      
      public function get accessibilityProperties() : AccessibilityProperties
      {
         return this.obj.accessibilityProperties;
      }
      
      public function set accessibilityProperties(param1:AccessibilityProperties) : void
      {
         this.obj.accessibilityProperties = param1;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.obj.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this.obj.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this.obj.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.obj.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this.obj.willTrigger(param1);
      }
      
      public function getConstraintValue(param1:String) : *
      {
         if(this.obj is IConstraintClient)
         {
            return IConstraintClient(this.obj).getConstraintValue(param1);
         }
         return null;
      }
      
      public function setConstraintValue(param1:String, param2:*) : void
      {
         if(this.obj is IConstraintClient)
         {
            IConstraintClient(this.obj).setConstraintValue(param1,param2);
            return;
         }
         throw new Error("PostScaleAdapter can\'t set constraint value, underlying object is not an IConstraintClient");
      }
      
      public function invalidateProperties() : void
      {
         if(this.obj is IInvalidating)
         {
            IInvalidating(this.obj).invalidateProperties();
         }
      }
      
      public function invalidateSize() : void
      {
         if(this.obj is IInvalidating)
         {
            IInvalidating(this.obj).invalidateSize();
         }
      }
      
      public function invalidateDisplayList() : void
      {
         if(this.obj is IInvalidating)
         {
            IInvalidating(this.obj).invalidateDisplayList();
         }
      }
      
      public function validateNow() : void
      {
         if(this.obj is IInvalidating)
         {
            IInvalidating(this.obj).validateNow();
         }
      }
   }
}
