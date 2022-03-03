package mx.core
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.Loader;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.text.TextLineMetrics;
   import flash.ui.Keyboard;
   import flash.utils.getDefinitionByName;
   import mx.binding.BindingManager;
   import mx.containers.utilityClasses.PostScaleAdapter;
   import mx.controls.HScrollBar;
   import mx.controls.VScrollBar;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.controls.scrollClasses.ScrollBar;
   import mx.events.ChildExistenceChangedEvent;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.ScrollEvent;
   import mx.events.ScrollEventDetail;
   import mx.events.ScrollEventDirection;
   import mx.geom.RoundedRectangle;
   import mx.managers.IFocusManager;
   import mx.managers.IFocusManagerContainer;
   import mx.managers.ILayoutManagerClient;
   import mx.managers.ISystemManager;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.ISimpleStyleClient;
   import mx.styles.IStyleClient;
   import mx.styles.StyleProtoChain;
   
   use namespace mx_internal;
   
   public class Container extends UIComponent implements IContainer, IDataRenderer, IFocusManagerContainer, IListItemRenderer, IRawChildrenContainer, IChildList, IVisualElementContainer, INavigatorContent
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
      
      private static const MULTIPLE_PROPERTIES:String = "<MULTIPLE>";
      
      private static var haloBorder:Class;
      
      private static var sparkBorder:Class;
      
      private static var sparkContainerBorder:Class;
      
      private static var didLookup:Boolean = false;
       
      
      protected var actualCreationPolicy:String;
      
      private var numChildrenBefore:int;
      
      private var recursionFlag:Boolean = true;
      
      private var forceLayout:Boolean = false;
      
      mx_internal var doingLayout:Boolean = false;
      
      private var changedStyles:String = null;
      
      private var _creatingContentPane:Boolean = false;
      
      protected var whiteBox:Shape;
      
      mx_internal var contentPane:Sprite = null;
      
      private var scrollPropertiesChanged:Boolean = false;
      
      private var scrollPositionChanged:Boolean = true;
      
      private var horizontalScrollPositionPending:Number;
      
      private var verticalScrollPositionPending:Number;
      
      private var scrollableWidth:Number = 0;
      
      private var scrollableHeight:Number = 0;
      
      private var viewableWidth:Number = 0;
      
      private var viewableHeight:Number = 0;
      
      mx_internal var border:IFlexDisplayObject;
      
      mx_internal var blocker:Sprite;
      
      private var mouseEventReferenceCount:int = 0;
      
      private var richEditableTextClass:Class;
      
      private var _focusPane:Sprite;
      
      mx_internal var _numChildren:int = 0;
      
      private var _autoLayout:Boolean = true;
      
      private var _childDescriptors:Array;
      
      private var _childRepeaters:Array;
      
      private var _clipContent:Boolean = true;
      
      private var _createdComponents:Array;
      
      private var _creationIndex:int = -1;
      
      private var creationPolicyNone:Boolean = false;
      
      private var _defaultButton:IFlexDisplayObject;
      
      private var _data:Object;
      
      private var _firstChildIndex:int = 0;
      
      private var _horizontalLineScrollSize:Number = 5;
      
      private var _horizontalPageScrollSize:Number = 0;
      
      private var _horizontalScrollBar:ScrollBar;
      
      private var _horizontalScrollPosition:Number = 0;
      
      mx_internal var _horizontalScrollPolicy:String = "auto";
      
      private var _icon:Class = null;
      
      private var _label:String = "";
      
      private var _numChildrenCreated:int = -1;
      
      private var _rawChildren:ContainerRawChildrenList;
      
      private var _verticalLineScrollSize:Number = 5;
      
      private var _verticalPageScrollSize:Number = 0;
      
      private var _verticalScrollBar:ScrollBar;
      
      private var _verticalScrollPosition:Number = 0;
      
      mx_internal var _verticalScrollPolicy:String = "auto";
      
      private var _viewMetrics:EdgeMetrics;
      
      private var _viewMetricsAndPadding:EdgeMetrics;
      
      private var _forceClippingCount:int;
      
      public function Container()
      {
         super();
         tabEnabled = false;
         tabFocusEnabled = false;
         showInAutomationHierarchy = false;
         if(ApplicationDomain.currentDomain.hasDefinition("spark.components.RichEditableText"))
         {
            this.richEditableTextClass = Class(ApplicationDomain.currentDomain.getDefinition("spark.components.RichEditableText"));
         }
      }
      
      private static function getDefinition(param1:String) : Class
      {
         var _loc2_:Object = null;
         try
         {
            _loc2_ = getDefinitionByName(param1);
         }
         catch(e:Error)
         {
         }
         return _loc2_ as Class;
      }
      
      mx_internal function getLayoutChildAt(param1:int) : IUIComponent
      {
         return PostScaleAdapter.getCompatibleIUIComponent(this.getChildAt(param1));
      }
      
      public function get creatingContentPane() : Boolean
      {
         return this._creatingContentPane;
      }
      
      public function set creatingContentPane(param1:Boolean) : void
      {
         this._creatingContentPane = param1;
      }
      
      override public function get baselinePosition() : Number
      {
         if(!validateBaselinePosition())
         {
            return NaN;
         }
         var _loc1_:TextLineMetrics = measureText("Wj");
         if(height < 2 * this.viewMetrics.top + 4 + _loc1_.ascent)
         {
            return int(height + (_loc1_.ascent - height) / 2);
         }
         return this.viewMetrics.top + 2 + _loc1_.ascent;
      }
      
      override public function get contentMouseX() : Number
      {
         if(this.contentPane)
         {
            return this.contentPane.mouseX;
         }
         return super.contentMouseX;
      }
      
      override public function get contentMouseY() : Number
      {
         if(this.contentPane)
         {
            return this.contentPane.mouseY;
         }
         return super.contentMouseY;
      }
      
      override public function set doubleClickEnabled(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:InteractiveObject = null;
         super.doubleClickEnabled = param1;
         if(this.contentPane)
         {
            _loc2_ = this.contentPane.numChildren;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc4_ = this.contentPane.getChildAt(_loc3_) as InteractiveObject)
               {
                  _loc4_.doubleClickEnabled = param1;
               }
               _loc3_++;
            }
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(this.horizontalScrollBar)
         {
            this.horizontalScrollBar.enabled = param1;
         }
         if(this.verticalScrollBar)
         {
            this.verticalScrollBar.enabled = param1;
         }
         invalidateProperties();
         if(this.border && this.border is IInvalidating)
         {
            IInvalidating(this.border).invalidateDisplayList();
         }
      }
      
      override public function get focusPane() : Sprite
      {
         return this._focusPane;
      }
      
      override public function set focusPane(param1:Sprite) : void
      {
         var _loc2_:Boolean = mx_internal::invalidateSizeFlag;
         var _loc3_:Boolean = mx_internal::invalidateDisplayListFlag;
         invalidateSizeFlag = true;
         invalidateDisplayListFlag = true;
         if(param1)
         {
            this.rawChildren.addChild(param1);
            param1.x = 0;
            param1.y = 0;
            param1.scrollRect = null;
            this._focusPane = param1;
         }
         else
         {
            this.rawChildren.removeChild(this._focusPane);
            this._focusPane = null;
         }
         if(param1 && this.contentPane)
         {
            param1.x = this.contentPane.x;
            param1.y = this.contentPane.y;
            param1.scrollRect = this.contentPane.scrollRect;
         }
         invalidateSizeFlag = _loc2_;
         invalidateDisplayListFlag = _loc3_;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         styleManager.registerInheritingStyle("_creationPolicy");
      }
      
      mx_internal final function get $numChildren() : int
      {
         return super.numChildren;
      }
      
      override public function get numChildren() : int
      {
         return !!this.contentPane ? int(this.contentPane.numChildren) : int(this._numChildren);
      }
      
      public function get autoLayout() : Boolean
      {
         return this._autoLayout;
      }
      
      public function set autoLayout(param1:Boolean) : void
      {
         var _loc2_:IInvalidating = null;
         this._autoLayout = param1;
         if(param1)
         {
            invalidateSize();
            invalidateDisplayList();
            _loc2_ = parent as IInvalidating;
            if(_loc2_)
            {
               _loc2_.invalidateSize();
               _loc2_.invalidateDisplayList();
            }
         }
      }
      
      public function get borderMetrics() : EdgeMetrics
      {
         return this.border && this.border is IRectangularBorder ? IRectangularBorder(this.border).borderMetrics : EdgeMetrics.EMPTY;
      }
      
      public function get childDescriptors() : Array
      {
         return this._childDescriptors;
      }
      
      mx_internal function get childRepeaters() : Array
      {
         return this._childRepeaters;
      }
      
      mx_internal function set childRepeaters(param1:Array) : void
      {
         this._childRepeaters = param1;
      }
      
      public function get clipContent() : Boolean
      {
         return this._clipContent;
      }
      
      public function set clipContent(param1:Boolean) : void
      {
         if(this._clipContent != param1)
         {
            this._clipContent = param1;
            invalidateDisplayList();
         }
      }
      
      mx_internal function get createdComponents() : Array
      {
         return this._createdComponents;
      }
      
      mx_internal function set createdComponents(param1:Array) : void
      {
         this._createdComponents = param1;
      }
      
      public function get creationIndex() : int
      {
         return this._creationIndex;
      }
      
      public function set creationIndex(param1:int) : void
      {
         this._creationIndex = param1;
      }
      
      public function get creationPolicy() : String
      {
         if(this.creationPolicyNone)
         {
            return ContainerCreationPolicy.NONE;
         }
         return getStyle("_creationPolicy");
      }
      
      public function set creationPolicy(param1:String) : void
      {
         var _loc2_:String = param1;
         if(param1 == ContainerCreationPolicy.NONE)
         {
            this.creationPolicyNone = true;
            _loc2_ = ContainerCreationPolicy.AUTO;
         }
         else
         {
            this.creationPolicyNone = false;
         }
         setStyle("_creationPolicy",_loc2_);
         this.setActualCreationPolicies(param1);
      }
      
      public function get defaultButton() : IFlexDisplayObject
      {
         return this._defaultButton;
      }
      
      public function set defaultButton(param1:IFlexDisplayObject) : void
      {
         this._defaultButton = param1;
         ContainerGlobals.focusedContainer = null;
      }
      
      public function get deferredContentCreated() : Boolean
      {
         return processedDescriptors;
      }
      
      [Bindable("dataChange")]
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
         dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
         invalidateDisplayList();
      }
      
      mx_internal function get firstChildIndex() : int
      {
         return this._firstChildIndex;
      }
      
      [Bindable("horizontalLineScrollSizeChanged")]
      public function get horizontalLineScrollSize() : Number
      {
         return this._horizontalLineScrollSize;
      }
      
      public function set horizontalLineScrollSize(param1:Number) : void
      {
         this.scrollPropertiesChanged = true;
         this._horizontalLineScrollSize = param1;
         invalidateDisplayList();
         dispatchEvent(new Event("horizontalLineScrollSizeChanged"));
      }
      
      [Bindable("horizontalPageScrollSizeChanged")]
      public function get horizontalPageScrollSize() : Number
      {
         return this._horizontalPageScrollSize;
      }
      
      public function set horizontalPageScrollSize(param1:Number) : void
      {
         this.scrollPropertiesChanged = true;
         this._horizontalPageScrollSize = param1;
         invalidateDisplayList();
         dispatchEvent(new Event("horizontalPageScrollSizeChanged"));
      }
      
      public function get horizontalScrollBar() : ScrollBar
      {
         return this._horizontalScrollBar;
      }
      
      public function set horizontalScrollBar(param1:ScrollBar) : void
      {
         this._horizontalScrollBar = param1;
      }
      
      [Bindable("viewChanged")]
      [Bindable("scroll")]
      public function get horizontalScrollPosition() : Number
      {
         if(!isNaN(this.horizontalScrollPositionPending))
         {
            return this.horizontalScrollPositionPending;
         }
         return this._horizontalScrollPosition;
      }
      
      public function set horizontalScrollPosition(param1:Number) : void
      {
         if(this._horizontalScrollPosition == param1)
         {
            return;
         }
         this._horizontalScrollPosition = param1;
         this.scrollPositionChanged = true;
         if(!initialized)
         {
            this.horizontalScrollPositionPending = param1;
         }
         invalidateDisplayList();
         dispatchEvent(new Event("viewChanged"));
      }
      
      [Bindable("horizontalScrollPolicyChanged")]
      public function get horizontalScrollPolicy() : String
      {
         return this._horizontalScrollPolicy;
      }
      
      public function set horizontalScrollPolicy(param1:String) : void
      {
         if(this._horizontalScrollPolicy != param1)
         {
            this._horizontalScrollPolicy = param1;
            invalidateDisplayList();
            dispatchEvent(new Event("horizontalScrollPolicyChanged"));
         }
      }
      
      [Bindable("iconChanged")]
      public function get icon() : Class
      {
         return this._icon;
      }
      
      public function set icon(param1:Class) : void
      {
         this._icon = param1;
         dispatchEvent(new Event("iconChanged"));
      }
      
      [Bindable("labelChanged")]
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         dispatchEvent(new Event("labelChanged"));
      }
      
      public function get maxHorizontalScrollPosition() : Number
      {
         return !!this.horizontalScrollBar ? Number(this.horizontalScrollBar.maxScrollPosition) : Number(Math.max(this.scrollableWidth - this.viewableWidth,0));
      }
      
      public function get maxVerticalScrollPosition() : Number
      {
         return !!this.verticalScrollBar ? Number(this.verticalScrollBar.maxScrollPosition) : Number(Math.max(this.scrollableHeight - this.viewableHeight,0));
      }
      
      mx_internal function get numChildrenCreated() : int
      {
         return this._numChildrenCreated;
      }
      
      mx_internal function set numChildrenCreated(param1:int) : void
      {
         this._numChildrenCreated = param1;
      }
      
      mx_internal function get numRepeaters() : int
      {
         return !!this.childRepeaters ? int(this.childRepeaters.length) : 0;
      }
      
      public function get rawChildren() : IChildList
      {
         if(!this._rawChildren)
         {
            this._rawChildren = new ContainerRawChildrenList(this);
         }
         return this._rawChildren;
      }
      
      mx_internal function get usePadding() : Boolean
      {
         return true;
      }
      
      [Bindable("verticalLineScrollSizeChanged")]
      public function get verticalLineScrollSize() : Number
      {
         return this._verticalLineScrollSize;
      }
      
      public function set verticalLineScrollSize(param1:Number) : void
      {
         this.scrollPropertiesChanged = true;
         this._verticalLineScrollSize = param1;
         invalidateDisplayList();
         dispatchEvent(new Event("verticalLineScrollSizeChanged"));
      }
      
      [Bindable("verticalPageScrollSizeChanged")]
      public function get verticalPageScrollSize() : Number
      {
         return this._verticalPageScrollSize;
      }
      
      public function set verticalPageScrollSize(param1:Number) : void
      {
         this.scrollPropertiesChanged = true;
         this._verticalPageScrollSize = param1;
         invalidateDisplayList();
         dispatchEvent(new Event("verticalPageScrollSizeChanged"));
      }
      
      public function get verticalScrollBar() : ScrollBar
      {
         return this._verticalScrollBar;
      }
      
      public function set verticalScrollBar(param1:ScrollBar) : void
      {
         this._verticalScrollBar = param1;
      }
      
      [Bindable("viewChanged")]
      [Bindable("scroll")]
      public function get verticalScrollPosition() : Number
      {
         if(!isNaN(this.verticalScrollPositionPending))
         {
            return this.verticalScrollPositionPending;
         }
         return this._verticalScrollPosition;
      }
      
      public function set verticalScrollPosition(param1:Number) : void
      {
         if(this._verticalScrollPosition == param1)
         {
            return;
         }
         this._verticalScrollPosition = param1;
         this.scrollPositionChanged = true;
         if(!initialized)
         {
            this.verticalScrollPositionPending = param1;
         }
         invalidateDisplayList();
         dispatchEvent(new Event("viewChanged"));
      }
      
      [Bindable("verticalScrollPolicyChanged")]
      public function get verticalScrollPolicy() : String
      {
         return this._verticalScrollPolicy;
      }
      
      public function set verticalScrollPolicy(param1:String) : void
      {
         if(this._verticalScrollPolicy != param1)
         {
            this._verticalScrollPolicy = param1;
            invalidateDisplayList();
            dispatchEvent(new Event("verticalScrollPolicyChanged"));
         }
      }
      
      public function get viewMetrics() : EdgeMetrics
      {
         var _loc1_:EdgeMetrics = this.borderMetrics;
         var _loc2_:Boolean = this.verticalScrollBar != null && (this.doingLayout || this.verticalScrollPolicy == ScrollPolicy.ON);
         var _loc3_:Boolean = this.horizontalScrollBar != null && (this.doingLayout || this.horizontalScrollPolicy == ScrollPolicy.ON);
         if(!_loc2_ && !_loc3_)
         {
            return _loc1_;
         }
         if(!this._viewMetrics)
         {
            this._viewMetrics = _loc1_.clone();
         }
         else
         {
            this._viewMetrics.left = _loc1_.left;
            this._viewMetrics.right = _loc1_.right;
            this._viewMetrics.top = _loc1_.top;
            this._viewMetrics.bottom = _loc1_.bottom;
         }
         if(_loc2_)
         {
            this._viewMetrics.right += this.verticalScrollBar.minWidth;
         }
         if(_loc3_)
         {
            this._viewMetrics.bottom += this.horizontalScrollBar.minHeight;
         }
         return this._viewMetrics;
      }
      
      public function get viewMetricsAndPadding() : EdgeMetrics
      {
         if(this._viewMetricsAndPadding && (!this.horizontalScrollBar || this.horizontalScrollPolicy == ScrollPolicy.ON) && (!this.verticalScrollBar || this.verticalScrollPolicy == ScrollPolicy.ON))
         {
            return this._viewMetricsAndPadding;
         }
         if(!this._viewMetricsAndPadding)
         {
            this._viewMetricsAndPadding = new EdgeMetrics();
         }
         var _loc1_:EdgeMetrics = this._viewMetricsAndPadding;
         var _loc2_:EdgeMetrics = this.viewMetrics;
         _loc1_.left = _loc2_.left + getStyle("paddingLeft");
         _loc1_.right = _loc2_.right + getStyle("paddingRight");
         _loc1_.top = _loc2_.top + getStyle("paddingTop");
         _loc1_.bottom = _loc2_.bottom + getStyle("paddingBottom");
         return _loc1_;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(param1 == MouseEvent.CLICK || param1 == MouseEvent.DOUBLE_CLICK || param1 == MouseEvent.MOUSE_DOWN || param1 == MouseEvent.MOUSE_MOVE || param1 == MouseEvent.MOUSE_OVER || param1 == MouseEvent.MOUSE_OUT || param1 == MouseEvent.MOUSE_UP || param1 == MouseEvent.MOUSE_WHEEL)
         {
            if(this.mouseEventReferenceCount < 2147483647 && this.mouseEventReferenceCount++ == 0)
            {
               setStyle("mouseShield",true);
               setStyle("mouseShieldChildren",true);
            }
         }
      }
      
      mx_internal function $addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         super.removeEventListener(param1,param2,param3);
         if(param1 == MouseEvent.CLICK || param1 == MouseEvent.DOUBLE_CLICK || param1 == MouseEvent.MOUSE_DOWN || param1 == MouseEvent.MOUSE_MOVE || param1 == MouseEvent.MOUSE_OVER || param1 == MouseEvent.MOUSE_OUT || param1 == MouseEvent.MOUSE_UP || param1 == MouseEvent.MOUSE_WHEEL)
         {
            if(this.mouseEventReferenceCount > 0 && --this.mouseEventReferenceCount == 0)
            {
               setStyle("mouseShield",false);
               setStyle("mouseShieldChildren",false);
            }
         }
      }
      
      mx_internal function $removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         super.removeEventListener(param1,param2,param3);
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         return this.addChildAt(param1,this.numChildren);
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:DisplayObjectContainer = param1.parent;
         if(_loc3_ && !(_loc3_ is Loader))
         {
            if(_loc3_ == this)
            {
               param2 = param2 == this.numChildren ? int(param2 - 1) : int(param2);
            }
            _loc3_.removeChild(param1);
         }
         this.addingChild(param1);
         if(this.contentPane)
         {
            this.contentPane.addChildAt(param1,param2);
         }
         else
         {
            $addChildAt(param1,this._firstChildIndex + param2);
         }
         this.childAdded(param1);
         if(param1 is UIComponent && UIComponent(param1).isDocument)
         {
            BindingManager.setEnabled(param1,true);
         }
         return param1;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 is IDeferredInstantiationUIComponent && IDeferredInstantiationUIComponent(param1).descriptor)
         {
            if(this.createdComponents)
            {
               _loc2_ = this.createdComponents.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if(this.createdComponents[_loc3_] === param1)
                  {
                     this.createdComponents.splice(_loc3_,1);
                  }
                  _loc3_++;
               }
            }
         }
         this.removingChild(param1);
         if(param1 is UIComponent && UIComponent(param1).isDocument)
         {
            BindingManager.setEnabled(param1,false);
         }
         if(this.contentPane)
         {
            this.contentPane.removeChild(param1);
         }
         else
         {
            $removeChild(param1);
         }
         this.childRemoved(param1);
         return param1;
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         return this.removeChild(this.getChildAt(param1));
      }
      
      override public function getChildAt(param1:int) : DisplayObject
      {
         if(this.contentPane)
         {
            return this.contentPane.getChildAt(param1);
         }
         return super.getChildAt(this._firstChildIndex + param1);
      }
      
      override public function getChildByName(param1:String) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         if(this.contentPane)
         {
            return this.contentPane.getChildByName(param1);
         }
         _loc2_ = super.getChildByName(param1);
         if(!_loc2_)
         {
            return null;
         }
         _loc3_ = super.getChildIndex(_loc2_) - this._firstChildIndex;
         if(_loc3_ < 0 || _loc3_ >= this._numChildren)
         {
            return null;
         }
         return _loc2_;
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         var _loc2_:int = 0;
         if(this.contentPane)
         {
            return this.contentPane.getChildIndex(param1);
         }
         return int(super.getChildIndex(param1) - this._firstChildIndex);
      }
      
      override public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = _loc3_;
         var _loc5_:int = param2;
         if(this.contentPane)
         {
            this.contentPane.setChildIndex(param1,param2);
            if(this._autoLayout || this.forceLayout)
            {
               invalidateDisplayList();
            }
         }
         else
         {
            _loc3_ = super.getChildIndex(param1);
            param2 += this._firstChildIndex;
            if(param2 == _loc3_)
            {
               return;
            }
            super.setChildIndex(param1,param2);
            invalidateDisplayList();
            _loc4_ = _loc3_ - this._firstChildIndex;
            _loc5_ = param2 - this._firstChildIndex;
         }
         var _loc6_:IndexChangedEvent;
         (_loc6_ = new IndexChangedEvent(IndexChangedEvent.CHILD_INDEX_CHANGE)).relatedObject = param1;
         _loc6_.oldIndex = _loc4_;
         _loc6_.newIndex = _loc5_;
         dispatchEvent(_loc6_);
         dispatchEvent(new Event("childrenChanged"));
      }
      
      override public function contains(param1:DisplayObject) : Boolean
      {
         if(this.contentPane)
         {
            return this.contentPane.contains(param1);
         }
         return super.contains(param1);
      }
      
      public function get numElements() : int
      {
         return this.numChildren;
      }
      
      public function getElementAt(param1:int) : IVisualElement
      {
         return this.getChildAt(param1) as IVisualElement;
      }
      
      public function getElementIndex(param1:IVisualElement) : int
      {
         if(!(param1 is DisplayObject))
         {
            throw ArgumentError(param1 + " is not found in this Container");
         }
         return this.getChildIndex(param1 as DisplayObject);
      }
      
      public function addElement(param1:IVisualElement) : IVisualElement
      {
         if(!(param1 is DisplayObject))
         {
            throw ArgumentError(param1 + " is not supported in this Container");
         }
         return this.addChild(param1 as DisplayObject) as IVisualElement;
      }
      
      public function addElementAt(param1:IVisualElement, param2:int) : IVisualElement
      {
         if(!(param1 is DisplayObject))
         {
            throw ArgumentError(param1 + " is not supported in this Container");
         }
         return this.addChildAt(param1 as DisplayObject,param2) as IVisualElement;
      }
      
      public function removeElement(param1:IVisualElement) : IVisualElement
      {
         if(!(param1 is DisplayObject))
         {
            throw ArgumentError(param1 + " is not found in this Container");
         }
         return this.removeChild(param1 as DisplayObject) as IVisualElement;
      }
      
      public function removeElementAt(param1:int) : IVisualElement
      {
         return this.removeChildAt(param1) as IVisualElement;
      }
      
      public function removeAllElements() : void
      {
         var _loc1_:int = this.numElements - 1;
         while(_loc1_ >= 0)
         {
            this.removeElementAt(_loc1_);
            _loc1_--;
         }
      }
      
      public function setElementIndex(param1:IVisualElement, param2:int) : void
      {
         if(!(param1 is DisplayObject))
         {
            throw ArgumentError(param1 + " is not found in this Container");
         }
         return this.setChildIndex(param1 as DisplayObject,param2);
      }
      
      public function swapElements(param1:IVisualElement, param2:IVisualElement) : void
      {
         if(!(param1 is DisplayObject))
         {
            throw ArgumentError(param1 + " is not found in this Container");
         }
         if(!(param2 is DisplayObject))
         {
            throw ArgumentError(param2 + " is not found in this Container");
         }
         swapChildren(param1 as DisplayObject,param2 as DisplayObject);
      }
      
      public function swapElementsAt(param1:int, param2:int) : void
      {
         swapChildrenAt(param1,param2);
      }
      
      override public function initialize() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         if(mx_internal::documentDescriptor && !processedDescriptors)
         {
            _loc1_ = mx_internal::documentDescriptor.properties;
            if(_loc1_ && _loc1_.childDescriptors)
            {
               if(this._childDescriptors)
               {
                  _loc2_ = resourceManager.getString("core","multipleChildSets_ClassAndInstance");
                  throw new Error(_loc2_);
               }
               this._childDescriptors = _loc1_.childDescriptors;
            }
         }
         super.initialize();
      }
      
      override protected function createChildren() : void
      {
         var _loc1_:* = undefined;
         super.createChildren();
         this.createBorder();
         this.createOrDestroyScrollbars(this.horizontalScrollPolicy == ScrollPolicy.ON,this.verticalScrollPolicy == ScrollPolicy.ON,this.horizontalScrollPolicy == ScrollPolicy.ON || this.verticalScrollPolicy == ScrollPolicy.ON);
         if(this.actualCreationPolicy == null)
         {
            if(this.creationPolicy != null)
            {
               this.actualCreationPolicy = this.creationPolicy;
            }
            if(this.actualCreationPolicy == ContainerCreationPolicy.QUEUED)
            {
               this.actualCreationPolicy = ContainerCreationPolicy.AUTO;
            }
         }
         if(this.actualCreationPolicy == ContainerCreationPolicy.NONE)
         {
            this.actualCreationPolicy = ContainerCreationPolicy.AUTO;
         }
         else if(this.actualCreationPolicy == ContainerCreationPolicy.QUEUED)
         {
            _loc1_ = !!parentApplication ? parentApplication : FlexGlobals.topLevelApplication;
            if("addToCreationQueue" in _loc1_)
            {
               _loc1_.addToCreationQueue(this,this._creationIndex,null,this);
            }
            else
            {
               this.createComponentsFromDescriptors();
            }
         }
         else if(this.recursionFlag)
         {
            this.createComponentsFromDescriptors();
         }
         if(this.autoLayout == false)
         {
            this.forceLayout = true;
         }
         UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE,this.layoutCompleteHandler,false,0,true);
      }
      
      override protected function initializationComplete() : void
      {
      }
      
      override public function invalidateLayoutDirection() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         super.invalidateLayoutDirection();
         if(this._rawChildren)
         {
            _loc1_ = this._rawChildren.numChildren;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this._rawChildren.getChildAt(_loc2_);
               if(!(_loc3_ is IStyleClient) && _loc3_ is ILayoutDirectionElement)
               {
                  ILayoutDirectionElement(_loc3_).invalidateLayoutDirection();
               }
               _loc2_++;
            }
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:String = null;
         super.commitProperties();
         if(this.changedStyles)
         {
            _loc1_ = this.changedStyles == MULTIPLE_PROPERTIES ? null : this.changedStyles;
            super.notifyStyleChangeInChildren(_loc1_,true);
            this.changedStyles = null;
         }
         this.createOrDestroyBlocker();
      }
      
      override public function validateSize(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         if(this.autoLayout == false && this.forceLayout == false)
         {
            if(param1)
            {
               _loc2_ = super.numChildren;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if((_loc4_ = super.getChildAt(_loc3_)) is ILayoutManagerClient)
                  {
                     ILayoutManagerClient(_loc4_).validateSize(true);
                  }
                  _loc3_++;
               }
            }
            adjustSizesForScaleChanges();
         }
         else
         {
            super.validateSize(param1);
         }
      }
      
      override public function validateDisplayList() : void
      {
         var _loc1_:EdgeMetrics = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Object = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this._autoLayout || this.forceLayout)
         {
            this.doingLayout = true;
            super.validateDisplayList();
            this.doingLayout = false;
         }
         else
         {
            this.layoutChrome(unscaledWidth,unscaledHeight);
         }
         invalidateDisplayListFlag = true;
         if(this.createContentPaneAndScrollbarsIfNeeded())
         {
            if(this._autoLayout || this.forceLayout)
            {
               this.doingLayout = true;
               super.validateDisplayList();
               this.doingLayout = false;
            }
            this.createContentPaneAndScrollbarsIfNeeded();
         }
         if(this.clampScrollPositions())
         {
            this.scrollChildren();
         }
         if(this.contentPane)
         {
            _loc1_ = this.viewMetrics;
            if(mx_internal::effectOverlay)
            {
               mx_internal::effectOverlay.x = 0;
               mx_internal::effectOverlay.y = 0;
               mx_internal::effectOverlay.width = unscaledWidth;
               mx_internal::effectOverlay.height = unscaledHeight;
            }
            if(this.horizontalScrollBar || this.verticalScrollBar)
            {
               if(this.verticalScrollBar && this.verticalScrollPolicy == ScrollPolicy.ON)
               {
                  _loc1_.right -= this.verticalScrollBar.minWidth;
               }
               if(this.horizontalScrollBar && this.horizontalScrollPolicy == ScrollPolicy.ON)
               {
                  _loc1_.bottom -= this.horizontalScrollBar.minHeight;
               }
               if(this.horizontalScrollBar)
               {
                  _loc2_ = unscaledWidth - _loc1_.left - _loc1_.right;
                  if(this.verticalScrollBar)
                  {
                     _loc2_ -= this.verticalScrollBar.minWidth;
                  }
                  this.horizontalScrollBar.setActualSize(_loc2_,this.horizontalScrollBar.minHeight);
                  this.horizontalScrollBar.move(_loc1_.left,unscaledHeight - _loc1_.bottom - this.horizontalScrollBar.minHeight);
               }
               if(this.verticalScrollBar)
               {
                  _loc3_ = unscaledHeight - _loc1_.top - _loc1_.bottom;
                  if(this.horizontalScrollBar)
                  {
                     _loc3_ -= this.horizontalScrollBar.minHeight;
                  }
                  this.verticalScrollBar.setActualSize(this.verticalScrollBar.minWidth,_loc3_);
                  this.verticalScrollBar.move(unscaledWidth - _loc1_.right - this.verticalScrollBar.minWidth,_loc1_.top);
               }
               if(this.whiteBox)
               {
                  this.whiteBox.x = this.verticalScrollBar.x;
                  this.whiteBox.y = this.horizontalScrollBar.y;
               }
            }
            this.contentPane.x = _loc1_.left;
            this.contentPane.y = _loc1_.top;
            if(this.focusPane)
            {
               this.focusPane.x = _loc1_.left;
               this.focusPane.y = _loc1_.top;
            }
            this.scrollChildren();
         }
         invalidateDisplayListFlag = false;
         if(this.blocker)
         {
            _loc1_ = this.viewMetrics;
            if(FlexVersion.compatibilityVersion >= FlexVersion.VERSION_4_0)
            {
               _loc1_ = EdgeMetrics.EMPTY;
            }
            if((_loc4_ = !!enabled ? null : getStyle("backgroundDisabledColor")) === null || isNaN(Number(_loc4_)))
            {
               _loc4_ = getStyle("backgroundColor");
            }
            if(_loc4_ === null || isNaN(Number(_loc4_)))
            {
               _loc4_ = 16777215;
            }
            _loc5_ = getStyle("disabledOverlayAlpha");
            if(isNaN(_loc5_))
            {
               _loc5_ = 0.6;
            }
            this.blocker.x = _loc1_.left;
            this.blocker.y = _loc1_.top;
            _loc6_ = unscaledWidth - (_loc1_.left + _loc1_.right);
            _loc7_ = unscaledHeight - (_loc1_.top + _loc1_.bottom);
            this.blocker.graphics.clear();
            this.blocker.graphics.beginFill(uint(_loc4_),_loc5_);
            this.blocker.graphics.drawRect(0,0,_loc6_,_loc7_);
            this.blocker.graphics.endFill();
            this.rawChildren.setChildIndex(this.blocker,this.rawChildren.numChildren - 1);
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Number = NaN;
         super.updateDisplayList(param1,param2);
         this.layoutChrome(param1,param2);
         if(this.scrollPositionChanged)
         {
            this.clampScrollPositions();
            this.scrollChildren();
            this.scrollPositionChanged = false;
         }
         if(this.scrollPropertiesChanged)
         {
            if(this.horizontalScrollBar)
            {
               this.horizontalScrollBar.lineScrollSize = this.horizontalLineScrollSize;
               this.horizontalScrollBar.pageScrollSize = this.horizontalPageScrollSize;
            }
            if(this.verticalScrollBar)
            {
               this.verticalScrollBar.lineScrollSize = this.verticalLineScrollSize;
               this.verticalScrollBar.pageScrollSize = this.verticalPageScrollSize;
            }
            this.scrollPropertiesChanged = false;
         }
         if(this.contentPane && this.contentPane.scrollRect)
         {
            _loc3_ = !!enabled ? null : getStyle("backgroundDisabledColor");
            if(_loc3_ === null || isNaN(Number(_loc3_)))
            {
               _loc3_ = getStyle("backgroundColor");
            }
            _loc4_ = getStyle("backgroundAlpha");
            if(!this._clipContent || isNaN(Number(_loc3_)) || _loc3_ === "" || !(this.horizontalScrollBar || this.verticalScrollBar) && !cacheAsBitmap)
            {
               _loc3_ = null;
            }
            else if(getStyle("backgroundImage") || getStyle("background"))
            {
               _loc3_ = null;
            }
            else if(_loc4_ != 1)
            {
               _loc3_ = null;
            }
            this.contentPane.opaqueBackground = _loc3_;
            this.contentPane.cacheAsBitmap = _loc3_ != null;
         }
      }
      
      override public function contentToGlobal(param1:Point) : Point
      {
         if(this.contentPane)
         {
            return this.contentPane.localToGlobal(param1);
         }
         return localToGlobal(param1);
      }
      
      override public function globalToContent(param1:Point) : Point
      {
         if(this.contentPane)
         {
            return this.contentPane.globalToLocal(param1);
         }
         return globalToLocal(param1);
      }
      
      override public function contentToLocal(param1:Point) : Point
      {
         if(!this.contentPane)
         {
            return param1;
         }
         param1 = this.contentToGlobal(param1);
         return globalToLocal(param1);
      }
      
      override public function localToContent(param1:Point) : Point
      {
         if(!this.contentPane)
         {
            return param1;
         }
         param1 = localToGlobal(param1);
         return this.globalToContent(param1);
      }
      
      override public function styleChanged(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:Boolean = param1 == null || param1 == "styleName";
         if(_loc2_ || styleManager.isSizeInvalidatingStyle(param1))
         {
            invalidateDisplayList();
         }
         if(_loc2_ || param1 == "borderSkin")
         {
            if(this.border)
            {
               this.rawChildren.removeChild(DisplayObject(this.border));
               this.border = null;
               this.createBorder();
            }
         }
         if(_loc2_ || param1 == "borderStyle" || param1 == "backgroundColor" || param1 == "backgroundImage" || param1 == "mouseShield" || param1 == "mouseShieldChildren")
         {
            this.createBorder();
         }
         super.styleChanged(param1);
         if(_loc2_ || styleManager.isSizeInvalidatingStyle(param1))
         {
            this.invalidateViewMetricsAndPadding();
         }
         if(_loc2_ || param1 == "horizontalScrollBarStyleName")
         {
            if(this.horizontalScrollBar && this.horizontalScrollBar is ISimpleStyleClient)
            {
               _loc3_ = getStyle("horizontalScrollBarStyleName");
               ISimpleStyleClient(this.horizontalScrollBar).styleName = _loc3_;
            }
         }
         if(_loc2_ || param1 == "verticalScrollBarStyleName")
         {
            if(this.verticalScrollBar && this.verticalScrollBar is ISimpleStyleClient)
            {
               _loc4_ = getStyle("verticalScrollBarStyleName");
               ISimpleStyleClient(this.verticalScrollBar).styleName = _loc4_;
            }
         }
      }
      
      override public function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void
      {
         var _loc5_:ISimpleStyleClient = null;
         var _loc3_:int = super.numChildren;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.contentPane || _loc4_ < this._firstChildIndex || _loc4_ >= this._firstChildIndex + this._numChildren)
            {
               if(_loc5_ = super.getChildAt(_loc4_) as ISimpleStyleClient)
               {
                  _loc5_.styleChanged(param1);
                  if(_loc5_ is IStyleClient)
                  {
                     IStyleClient(_loc5_).notifyStyleChangeInChildren(param1,param2);
                  }
               }
            }
            _loc4_++;
         }
         if(param2)
         {
            this.changedStyles = this.changedStyles != null || param1 == null ? MULTIPLE_PROPERTIES : param1;
            invalidateProperties();
         }
      }
      
      override public function regenerateStyleCache(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         super.regenerateStyleCache(param1);
         if(this.contentPane)
         {
            _loc2_ = this.contentPane.numChildren;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if((_loc4_ = this.getChildAt(_loc3_)) is UIComponent)
               {
                  if(UIComponent(_loc4_).inheritingStyles != StyleProtoChain.STYLE_UNINITIALIZED)
                  {
                     UIComponent(_loc4_).regenerateStyleCache(param1);
                  }
               }
               else if(_loc4_ is IUITextField && IUITextField(_loc4_).inheritingStyles)
               {
                  StyleProtoChain.initTextField(IUITextField(_loc4_));
               }
               _loc3_++;
            }
         }
      }
      
      override protected function attachOverlay() : void
      {
         this.rawChildren_addChild(mx_internal::effectOverlay);
      }
      
      override mx_internal function fillOverlay(param1:UIComponent, param2:uint, param3:RoundedRectangle = null) : void
      {
         var _loc4_:EdgeMetrics = this.viewMetrics;
         var _loc5_:Number = 0;
         if(!param3)
         {
            param3 = new RoundedRectangle(_loc4_.left,_loc4_.top,unscaledWidth - _loc4_.right - _loc4_.left,unscaledHeight - _loc4_.bottom - _loc4_.top,_loc5_);
         }
         if(isNaN(param3.x) || isNaN(param3.y) || isNaN(param3.width) || isNaN(param3.height) || isNaN(param3.cornerRadius))
         {
            return;
         }
         var _loc6_:Graphics;
         (_loc6_ = param1.graphics).clear();
         _loc6_.beginFill(param2);
         _loc6_.drawRoundRect(param3.x,param3.y,param3.width,param3.height,param3.cornerRadius * 2,param3.cornerRadius * 2);
         _loc6_.endFill();
      }
      
      override public function executeBindings(param1:Boolean = false) : void
      {
         var _loc2_:Object = descriptor && descriptor.document ? descriptor.document : parentDocument;
         BindingManager.executeBindings(_loc2_,id,this);
         if(param1)
         {
            this.executeChildBindings(param1);
         }
      }
      
      override public function prepareToPrint(param1:IFlexDisplayObject) : Object
      {
         var _loc2_:Rectangle = this.contentPane && this.contentPane.scrollRect ? this.contentPane.scrollRect : null;
         if(_loc2_)
         {
            this.contentPane.scrollRect = null;
         }
         super.prepareToPrint(param1);
         return _loc2_;
      }
      
      override public function finishPrint(param1:Object, param2:IFlexDisplayObject) : void
      {
         if(param1)
         {
            this.contentPane.scrollRect = Rectangle(param1);
         }
         super.finishPrint(param1,param2);
      }
      
      override mx_internal function addingChild(param1:DisplayObject) : void
      {
         var _loc2_:IUIComponent = IUIComponent(param1);
         super.addingChild(param1);
         invalidateSize();
         invalidateDisplayList();
         if(!this.contentPane)
         {
            if(this._numChildren == 0)
            {
               this._firstChildIndex = super.numChildren;
            }
            ++this._numChildren;
         }
         if(this.contentPane && !this.autoLayout)
         {
            this.forceLayout = true;
            UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE,this.layoutCompleteHandler,false,0,true);
         }
      }
      
      override mx_internal function childAdded(param1:DisplayObject) : void
      {
         var _loc2_:ChildExistenceChangedEvent = null;
         if(hasEventListener("childrenChanged"))
         {
            dispatchEvent(new Event("childrenChanged"));
         }
         if(hasEventListener(ChildExistenceChangedEvent.CHILD_ADD))
         {
            _loc2_ = new ChildExistenceChangedEvent(ChildExistenceChangedEvent.CHILD_ADD);
            _loc2_.relatedObject = param1;
            dispatchEvent(_loc2_);
         }
         if(param1.hasEventListener(FlexEvent.ADD))
         {
            param1.dispatchEvent(new FlexEvent(FlexEvent.ADD));
         }
         super.childAdded(param1);
      }
      
      override mx_internal function removingChild(param1:DisplayObject) : void
      {
         var _loc2_:ChildExistenceChangedEvent = null;
         super.removingChild(param1);
         if(param1.hasEventListener(FlexEvent.REMOVE))
         {
            param1.dispatchEvent(new FlexEvent(FlexEvent.REMOVE));
         }
         if(hasEventListener(ChildExistenceChangedEvent.CHILD_REMOVE))
         {
            _loc2_ = new ChildExistenceChangedEvent(ChildExistenceChangedEvent.CHILD_REMOVE);
            _loc2_.relatedObject = param1;
            dispatchEvent(_loc2_);
         }
      }
      
      override mx_internal function childRemoved(param1:DisplayObject) : void
      {
         super.childRemoved(param1);
         invalidateSize();
         invalidateDisplayList();
         if(!this.contentPane)
         {
            --this._numChildren;
            if(this._numChildren == 0)
            {
               this._firstChildIndex = super.numChildren;
            }
         }
         if(this.contentPane && !this.autoLayout)
         {
            this.forceLayout = true;
            UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE,this.layoutCompleteHandler,false,0,true);
         }
         if(hasEventListener("childrenChanged"))
         {
            dispatchEvent(new Event("childrenChanged"));
         }
      }
      
      [Bindable("childrenChanged")]
      public function getChildren() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = this.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.push(this.getChildAt(_loc3_));
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function removeAllChildren() : void
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      mx_internal function setDocumentDescriptor(param1:UIComponentDescriptor) : void
      {
         var _loc2_:String = null;
         if(processedDescriptors)
         {
            return;
         }
         if(mx_internal::_documentDescriptor && mx_internal::_documentDescriptor.properties.childDescriptors)
         {
            if(param1.properties.childDescriptors)
            {
               _loc2_ = resourceManager.getString("core","multipleChildSets_ClassAndSubclass");
               throw new Error(_loc2_);
            }
         }
         else
         {
            _documentDescriptor = param1;
            mx_internal::_documentDescriptor.document = this;
         }
      }
      
      mx_internal function setActualCreationPolicies(param1:String) : void
      {
         var _loc5_:IFlexDisplayObject = null;
         var _loc6_:Container = null;
         this.actualCreationPolicy = param1;
         var _loc2_:String = param1;
         if(param1 == ContainerCreationPolicy.QUEUED)
         {
            _loc2_ = ContainerCreationPolicy.AUTO;
         }
         var _loc3_:int = this.numChildren;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = IFlexDisplayObject(this.getChildAt(_loc4_))) is Container)
            {
               if((_loc6_ = Container(_loc5_)).creationPolicy == null)
               {
                  _loc6_.setActualCreationPolicies(_loc2_);
               }
            }
            _loc4_++;
         }
      }
      
      public function createComponentsFromDescriptors(param1:Boolean = true) : void
      {
         var _loc4_:IFlexDisplayObject = null;
         this.numChildrenBefore = this.numChildren;
         this.createdComponents = [];
         var _loc2_:int = !!this.childDescriptors ? int(this.childDescriptors.length) : 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.createComponentFromDescriptor(this.childDescriptors[_loc3_],param1);
            this.createdComponents.push(_loc4_);
            _loc3_++;
         }
         if(this.creationPolicy == ContainerCreationPolicy.QUEUED || this.creationPolicy == ContainerCreationPolicy.NONE)
         {
            UIComponentGlobals.layoutManager.usePhasedInstantiation = false;
         }
         this.numChildrenCreated = this.numChildren - this.numChildrenBefore;
         processedDescriptors = true;
         dispatchEvent(new FlexEvent(FlexEvent.CONTENT_CREATION_COMPLETE));
      }
      
      public function createDeferredContent() : void
      {
         this.createComponentsFromDescriptors(true);
      }
      
      public function createComponentFromDescriptor(param1:ComponentDescriptor, param2:Boolean) : IFlexDisplayObject
      {
         var _loc7_:* = null;
         var _loc10_:IRepeaterClient = null;
         var _loc11_:IStyleClient = null;
         var _loc12_:* = null;
         var _loc13_:String = null;
         var _loc3_:UIComponentDescriptor = UIComponentDescriptor(param1);
         var _loc4_:Object = _loc3_.properties;
         if((this.numChildrenBefore != 0 || this.numChildrenCreated != -1) && _loc3_.instanceIndices == null && this.hasChildMatchingDescriptor(_loc3_))
         {
            return null;
         }
         UIComponentGlobals.layoutManager.usePhasedInstantiation = true;
         var _loc6_:IDeferredInstantiationUIComponent;
         var _loc5_:Class;
         (_loc6_ = new (_loc5_ = _loc3_.type)()).id = _loc3_.id;
         if(_loc6_.id && _loc6_.id != "")
         {
            _loc6_.name = _loc6_.id;
         }
         _loc6_.descriptor = _loc3_;
         if(_loc4_.childDescriptors && _loc6_ is Container)
         {
            Container(_loc6_)._childDescriptors = _loc4_.childDescriptors;
            delete _loc4_.childDescriptors;
         }
         for(_loc7_ in _loc4_)
         {
            _loc6_[_loc7_] = _loc4_[_loc7_];
         }
         if(_loc6_ is Container)
         {
            Container(_loc6_).recursionFlag = param2;
         }
         if(_loc3_.instanceIndices)
         {
            if(_loc6_ is IRepeaterClient)
            {
               (_loc10_ = IRepeaterClient(_loc6_)).instanceIndices = _loc3_.instanceIndices;
               _loc10_.repeaters = _loc3_.repeaters;
               _loc10_.repeaterIndices = _loc3_.repeaterIndices;
            }
         }
         if(_loc6_ is IStyleClient)
         {
            _loc11_ = IStyleClient(_loc6_);
            if(_loc3_.stylesFactory != null)
            {
               if(!_loc11_.styleDeclaration)
               {
                  _loc11_.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
               }
               _loc11_.styleDeclaration.factory = _loc3_.stylesFactory;
            }
         }
         var _loc8_:Object;
         if(_loc8_ = _loc3_.events)
         {
            for(_loc12_ in _loc8_)
            {
               _loc13_ = _loc8_[_loc12_];
               _loc6_.addEventListener(_loc12_,_loc3_.document[_loc13_]);
            }
         }
         var _loc9_:Array;
         if(_loc9_ = _loc3_.effects)
         {
            _loc6_.registerEffects(_loc9_);
         }
         if(_loc6_ is IRepeaterClient)
         {
            IRepeaterClient(_loc6_).initializeRepeaterArrays(this);
         }
         _loc6_.createReferenceOnParentDocument(IFlexDisplayObject(_loc3_.document));
         if(!_loc6_.document)
         {
            _loc6_.document = _loc3_.document;
         }
         if(_loc6_ is IRepeater)
         {
            if(!this.childRepeaters)
            {
               this.childRepeaters = [];
            }
            this.childRepeaters.push(_loc6_);
            _loc6_.executeBindings();
            IRepeater(_loc6_).initializeRepeater(this,param2);
         }
         else
         {
            this.addChild(DisplayObject(_loc6_));
            _loc6_.executeBindings();
            if(this.creationPolicy == ContainerCreationPolicy.QUEUED || this.creationPolicy == ContainerCreationPolicy.NONE)
            {
               _loc6_.addEventListener(FlexEvent.CREATION_COMPLETE,this.creationCompleteHandler);
            }
         }
         return _loc6_;
      }
      
      private function hasChildMatchingDescriptor(param1:UIComponentDescriptor) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:IUIComponent = null;
         var _loc2_:String = param1.id;
         if(_loc2_ != null && _loc2_ in document && document[_loc2_] == null)
         {
            return false;
         }
         var _loc3_:int = this.numChildren;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = IUIComponent(this.getChildAt(_loc4_))) is IDeferredInstantiationUIComponent && IDeferredInstantiationUIComponent(_loc5_).descriptor == param1)
            {
               return true;
            }
            _loc4_++;
         }
         if(this.childRepeaters)
         {
            _loc3_ = this.childRepeaters.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(IDeferredInstantiationUIComponent(this.childRepeaters[_loc4_]).descriptor == param1)
               {
                  return true;
               }
               _loc4_++;
            }
         }
         return false;
      }
      
      mx_internal function rawChildren_addChild(param1:DisplayObject) : DisplayObject
      {
         if(this._numChildren == 0)
         {
            ++this._firstChildIndex;
         }
         super.addingChild(param1);
         $addChild(param1);
         super.childAdded(param1);
         dispatchEvent(new Event("childrenChanged"));
         return param1;
      }
      
      mx_internal function rawChildren_addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         if(this._firstChildIndex < param2 && param2 < this._firstChildIndex + this._numChildren + 1)
         {
            ++this._numChildren;
         }
         else if(param2 <= this._firstChildIndex)
         {
            ++this._firstChildIndex;
         }
         super.addingChild(param1);
         $addChildAt(param1,param2);
         super.childAdded(param1);
         dispatchEvent(new Event("childrenChanged"));
         return param1;
      }
      
      mx_internal function rawChildren_removeChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:int = this.rawChildren_getChildIndex(param1);
         return this.rawChildren_removeChildAt(_loc2_);
      }
      
      mx_internal function rawChildren_removeChildAt(param1:int) : DisplayObject
      {
         var _loc2_:DisplayObject = super.getChildAt(param1);
         super.removingChild(_loc2_);
         $removeChildAt(param1);
         super.childRemoved(_loc2_);
         if(this._firstChildIndex < param1 && param1 < this._firstChildIndex + this._numChildren)
         {
            --this._numChildren;
         }
         else if(this._numChildren == 0 || param1 < this._firstChildIndex)
         {
            --this._firstChildIndex;
         }
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("childrenChanged"));
         return _loc2_;
      }
      
      mx_internal function rawChildren_getChildAt(param1:int) : DisplayObject
      {
         return super.getChildAt(param1);
      }
      
      mx_internal function rawChildren_getChildByName(param1:String) : DisplayObject
      {
         return super.getChildByName(param1);
      }
      
      mx_internal function rawChildren_getChildIndex(param1:DisplayObject) : int
      {
         return super.getChildIndex(param1);
      }
      
      mx_internal function rawChildren_setChildIndex(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:int = super.getChildIndex(param1);
         super.setChildIndex(param1,param2);
         if(_loc3_ < this._firstChildIndex && param2 >= this._firstChildIndex)
         {
            --this._firstChildIndex;
         }
         else if(_loc3_ >= this._firstChildIndex && param2 <= this._firstChildIndex)
         {
            ++this._firstChildIndex;
         }
         dispatchEvent(new Event("childrenChanged"));
      }
      
      mx_internal function rawChildren_getObjectsUnderPoint(param1:Point) : Array
      {
         return super.getObjectsUnderPoint(param1);
      }
      
      mx_internal function rawChildren_contains(param1:DisplayObject) : Boolean
      {
         return super.contains(param1);
      }
      
      protected function layoutChrome(param1:Number, param2:Number) : void
      {
         if(this.border)
         {
            this.updateBackgroundImageRect();
            this.border.move(0,0);
            this.border.setActualSize(param1,param2);
         }
      }
      
      protected function createBorder() : void
      {
         var _loc1_:Class = null;
         if(!this.border && this.isBorderNeeded())
         {
            _loc1_ = getStyle("borderSkin");
            if(_loc1_ != null)
            {
               this.border = new _loc1_();
               this.border.name = "border";
               if(this.border is IUIComponent)
               {
                  IUIComponent(this.border).enabled = enabled;
               }
               if(this.border is ISimpleStyleClient)
               {
                  ISimpleStyleClient(this.border).styleName = this;
               }
               this.rawChildren.addChildAt(DisplayObject(this.border),0);
               invalidateDisplayList();
            }
         }
      }
      
      private function isBorderNeeded() : Boolean
      {
         var _loc1_:Class = getStyle("borderSkin");
         if(!didLookup)
         {
            haloBorder = getDefinition("mx.skins.halo::HaloBorder");
            sparkBorder = getDefinition("mx.skins.spark::BorderSkin");
            sparkContainerBorder = getDefinition("mx.skins.spark::ContainerBorderSkin");
            didLookup = true;
         }
         if(!(_loc1_ == haloBorder || _loc1_ == sparkBorder || _loc1_ == sparkContainerBorder))
         {
            return true;
         }
         var _loc2_:Object = getStyle("borderStyle");
         if(_loc2_)
         {
            if(_loc2_ != "none" || _loc2_ == "none" && getStyle("mouseShield"))
            {
               return true;
            }
         }
         _loc2_ = getStyle("contentBackgroundColor");
         if(_loc1_ == sparkBorder && _loc2_ !== null)
         {
            return true;
         }
         _loc2_ = getStyle("backgroundColor");
         if(_loc2_ !== null && _loc2_ !== "")
         {
            return true;
         }
         _loc2_ = getStyle("backgroundImage");
         return _loc2_ != null && _loc2_ != "";
      }
      
      mx_internal function invalidateViewMetricsAndPadding() : void
      {
         this._viewMetricsAndPadding = null;
      }
      
      private function createOrDestroyBlocker() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:ISystemManager = null;
         if(enabled)
         {
            if(this.blocker)
            {
               this.rawChildren.removeChild(this.blocker);
               this.blocker = null;
            }
         }
         else if(!this.blocker)
         {
            this.blocker = new FlexSprite();
            this.blocker.name = "blocker";
            this.blocker.mouseEnabled = true;
            this.rawChildren.addChild(this.blocker);
            this.blocker.addEventListener(MouseEvent.CLICK,this.blocker_clickHandler);
            _loc1_ = !!focusManager ? DisplayObject(focusManager.getFocus()) : null;
            while(_loc1_)
            {
               if(_loc1_ == this)
               {
                  _loc2_ = systemManager;
                  if(_loc2_ && _loc2_.stage)
                  {
                     _loc2_.stage.focus = null;
                  }
                  break;
               }
               _loc1_ = _loc1_.parent;
            }
         }
      }
      
      private function updateBackgroundImageRect() : void
      {
         var _loc1_:IRectangularBorder = this.border as IRectangularBorder;
         if(!_loc1_)
         {
            return;
         }
         if(this.viewableWidth == 0 && this.viewableHeight == 0)
         {
            _loc1_.backgroundImageBounds = null;
            return;
         }
         var _loc2_:EdgeMetrics = this.viewMetrics;
         var _loc3_:Number = !!this.viewableWidth ? Number(this.viewableWidth) : Number(unscaledWidth - _loc2_.left - _loc2_.right);
         var _loc4_:Number = !!this.viewableHeight ? Number(this.viewableHeight) : Number(unscaledHeight - _loc2_.top - _loc2_.bottom);
         if(getStyle("backgroundAttachment") == "fixed")
         {
            _loc1_.backgroundImageBounds = new Rectangle(_loc2_.left,_loc2_.top,_loc3_,_loc4_);
         }
         else
         {
            _loc1_.backgroundImageBounds = new Rectangle(_loc2_.left,_loc2_.top,Math.max(this.scrollableWidth,_loc3_),Math.max(this.scrollableHeight,_loc4_));
         }
      }
      
      private function createContentPaneAndScrollbarsIfNeeded() : Boolean
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Boolean = false;
         if(this._clipContent)
         {
            _loc1_ = this.getScrollableRect();
            _loc2_ = this.createScrollbarsIfNeeded(_loc1_);
            if(this.border)
            {
               this.updateBackgroundImageRect();
            }
            return _loc2_;
         }
         _loc2_ = this.createOrDestroyScrollbars(false,false,false);
         _loc1_ = this.getScrollableRect();
         this.scrollableWidth = _loc1_.right;
         this.scrollableHeight = _loc1_.bottom;
         if(_loc2_ && this.border)
         {
            this.updateBackgroundImageRect();
         }
         return _loc2_;
      }
      
      mx_internal function getScrollableRect() : Rectangle
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:DisplayObject = null;
         var _loc14_:IUIComponent = null;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = this.numChildren;
         var _loc6_:int = 0;
         for(; _loc6_ < _loc5_; _loc6_++)
         {
            if((_loc13_ = this.getChildAt(_loc6_)) is IUIComponent)
            {
               if(!IUIComponent(_loc13_).includeInLayout)
               {
                  continue;
               }
               _loc11_ = (_loc14_ = PostScaleAdapter.getCompatibleIUIComponent(_loc13_)).width;
               _loc12_ = _loc14_.height;
               _loc9_ = _loc14_.x;
               _loc10_ = _loc14_.y;
            }
            else
            {
               _loc11_ = _loc13_.width;
               _loc12_ = _loc13_.height;
               _loc9_ = _loc13_.x;
               _loc10_ = _loc13_.y;
            }
            _loc1_ = Math.min(_loc1_,_loc9_);
            _loc2_ = Math.min(_loc2_,_loc10_);
            if(!isNaN(_loc11_))
            {
               _loc3_ = Math.max(_loc3_,_loc9_ + _loc11_);
            }
            if(!isNaN(_loc12_))
            {
               _loc4_ = Math.max(_loc4_,_loc10_ + _loc12_);
            }
         }
         var _loc7_:EdgeMetrics = this.viewMetrics;
         var _loc8_:Rectangle;
         (_loc8_ = new Rectangle()).left = _loc1_;
         _loc8_.top = _loc2_;
         _loc8_.right = _loc3_;
         _loc8_.bottom = _loc4_;
         if(this.usePadding)
         {
            _loc8_.right += getStyle("paddingRight");
            _loc8_.bottom += getStyle("paddingBottom");
         }
         return _loc8_;
      }
      
      private function createScrollbarsIfNeeded(param1:Rectangle) : Boolean
      {
         var _loc2_:Number = param1.right;
         var _loc3_:Number = param1.bottom;
         var _loc4_:Number = unscaledWidth;
         var _loc5_:Number = unscaledHeight;
         var _loc6_:Boolean = param1.left < 0 || param1.top < 0;
         var _loc7_:EdgeMetrics = this.viewMetrics;
         if(scaleX != 1)
         {
            _loc4_ += 1 / Math.abs(scaleX);
         }
         if(scaleY != 1)
         {
            _loc5_ += 1 / Math.abs(scaleY);
         }
         _loc4_ = Math.floor(_loc4_);
         _loc5_ = Math.floor(_loc5_);
         _loc2_ = Math.floor(_loc2_);
         _loc3_ = Math.floor(_loc3_);
         if(this.horizontalScrollBar && this.horizontalScrollPolicy != ScrollPolicy.ON)
         {
            _loc5_ -= this.horizontalScrollBar.minHeight;
         }
         if(this.verticalScrollBar && this.verticalScrollPolicy != ScrollPolicy.ON)
         {
            _loc4_ -= this.verticalScrollBar.minWidth;
         }
         _loc4_ -= _loc7_.left + _loc7_.right;
         _loc5_ -= _loc7_.top + _loc7_.bottom;
         var _loc8_:* = this.horizontalScrollPolicy == ScrollPolicy.ON;
         var _loc9_:* = this.verticalScrollPolicy == ScrollPolicy.ON;
         var _loc10_:Boolean = _loc8_ || _loc9_ || _loc6_ || mx_internal::effectOverlay != null || _loc7_.left > 0 || _loc7_.top > 0;
         if(_loc4_ < _loc2_)
         {
            _loc10_ = true;
            if(this.horizontalScrollPolicy == ScrollPolicy.AUTO && unscaledHeight - _loc7_.top - _loc7_.bottom >= 18 && unscaledWidth - _loc7_.left - _loc7_.right >= 32)
            {
               _loc8_ = true;
            }
         }
         if(_loc5_ < _loc3_)
         {
            _loc10_ = true;
            if(this.verticalScrollPolicy == ScrollPolicy.AUTO && unscaledWidth - _loc7_.left - _loc7_.right >= 18 && unscaledHeight - _loc7_.top - _loc7_.bottom >= 32)
            {
               _loc9_ = true;
            }
         }
         if(_loc8_ && _loc9_ && this.horizontalScrollPolicy == ScrollPolicy.AUTO && this.verticalScrollPolicy == ScrollPolicy.AUTO && this.horizontalScrollBar && this.verticalScrollBar && _loc4_ + this.verticalScrollBar.minWidth >= _loc2_ && _loc5_ + this.horizontalScrollBar.minHeight >= _loc3_)
         {
            _loc8_ = Boolean(_loc9_ = Boolean(false));
         }
         else if(_loc8_ && !_loc9_ && this.verticalScrollBar && this.horizontalScrollPolicy == ScrollPolicy.AUTO && _loc4_ + this.verticalScrollBar.minWidth >= _loc2_)
         {
            _loc8_ = false;
         }
         var _loc11_:Boolean = this.createOrDestroyScrollbars(_loc8_,_loc9_,_loc10_);
         if(this.scrollableWidth != _loc2_ || this.viewableWidth != _loc4_ || _loc11_)
         {
            if(this.horizontalScrollBar)
            {
               this.horizontalScrollBar.setScrollProperties(_loc4_,0,_loc2_ - _loc4_,this.horizontalPageScrollSize);
               this.scrollPositionChanged = true;
            }
            this.viewableWidth = _loc4_;
            this.scrollableWidth = _loc2_;
         }
         if(this.scrollableHeight != _loc3_ || this.viewableHeight != _loc5_ || _loc11_)
         {
            if(this.verticalScrollBar)
            {
               this.verticalScrollBar.setScrollProperties(_loc5_,0,_loc3_ - _loc5_,this.verticalPageScrollSize);
               this.scrollPositionChanged = true;
            }
            this.viewableHeight = _loc5_;
            this.scrollableHeight = _loc3_;
         }
         return _loc11_;
      }
      
      private function createOrDestroyScrollbars(param1:Boolean, param2:Boolean, param3:Boolean) : Boolean
      {
         var _loc5_:IFocusManager = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Graphics = null;
         var _loc4_:Boolean = false;
         if(param1 || param2 || param3)
         {
            this.createContentPane();
         }
         if(param1)
         {
            if(!this.horizontalScrollBar)
            {
               this.horizontalScrollBar = new HScrollBar();
               this.horizontalScrollBar.name = "horizontalScrollBar";
               if((_loc6_ = getStyle("horizontalScrollBarStyleName")) && this.horizontalScrollBar is ISimpleStyleClient)
               {
                  ISimpleStyleClient(this.horizontalScrollBar).styleName = _loc6_;
               }
               this.rawChildren.addChild(DisplayObject(this.horizontalScrollBar));
               this.horizontalScrollBar.lineScrollSize = this.horizontalLineScrollSize;
               this.horizontalScrollBar.pageScrollSize = this.horizontalPageScrollSize;
               this.horizontalScrollBar.addEventListener(ScrollEvent.SCROLL,this.horizontalScrollBar_scrollHandler);
               this.horizontalScrollBar.enabled = enabled;
               if(this.horizontalScrollBar is IInvalidating)
               {
                  IInvalidating(this.horizontalScrollBar).validateNow();
               }
               invalidateDisplayList();
               this.invalidateViewMetricsAndPadding();
               _loc4_ = true;
               if(!this.verticalScrollBar)
               {
                  this.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
               }
            }
         }
         else if(this.horizontalScrollBar)
         {
            this.horizontalScrollBar.removeEventListener(ScrollEvent.SCROLL,this.horizontalScrollBar_scrollHandler);
            this.rawChildren.removeChild(DisplayObject(this.horizontalScrollBar));
            this.horizontalScrollBar = null;
            this.viewableWidth = this.scrollableWidth = 0;
            if(this._horizontalScrollPosition != 0)
            {
               this._horizontalScrollPosition = 0;
               this.scrollPositionChanged = true;
            }
            invalidateDisplayList();
            this.invalidateViewMetricsAndPadding();
            _loc4_ = true;
            _loc5_ = focusManager;
            if(!this.verticalScrollBar && (!_loc5_ || _loc5_.getFocus() != this))
            {
               this.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
            }
         }
         if(param2)
         {
            if(!this.verticalScrollBar)
            {
               this.verticalScrollBar = new VScrollBar();
               this.verticalScrollBar.name = "verticalScrollBar";
               if((_loc7_ = getStyle("verticalScrollBarStyleName")) && this.verticalScrollBar is ISimpleStyleClient)
               {
                  ISimpleStyleClient(this.verticalScrollBar).styleName = _loc7_;
               }
               this.rawChildren.addChild(DisplayObject(this.verticalScrollBar));
               this.verticalScrollBar.lineScrollSize = this.verticalLineScrollSize;
               this.verticalScrollBar.pageScrollSize = this.verticalPageScrollSize;
               this.verticalScrollBar.addEventListener(ScrollEvent.SCROLL,this.verticalScrollBar_scrollHandler);
               this.verticalScrollBar.enabled = enabled;
               if(this.verticalScrollBar is IInvalidating)
               {
                  IInvalidating(this.verticalScrollBar).validateNow();
               }
               invalidateDisplayList();
               this.invalidateViewMetricsAndPadding();
               _loc4_ = true;
               if(!this.horizontalScrollBar)
               {
                  this.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
               }
               this.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
            }
         }
         else if(this.verticalScrollBar)
         {
            this.verticalScrollBar.removeEventListener(ScrollEvent.SCROLL,this.verticalScrollBar_scrollHandler);
            this.rawChildren.removeChild(DisplayObject(this.verticalScrollBar));
            this.verticalScrollBar = null;
            this.viewableHeight = this.scrollableHeight = 0;
            if(this._verticalScrollPosition != 0)
            {
               this._verticalScrollPosition = 0;
               this.scrollPositionChanged = true;
            }
            invalidateDisplayList();
            this.invalidateViewMetricsAndPadding();
            _loc4_ = true;
            _loc5_ = focusManager;
            if(!this.horizontalScrollBar && (!_loc5_ || _loc5_.getFocus() != this))
            {
               this.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
            }
            this.removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
         }
         if(this.horizontalScrollBar && this.verticalScrollBar)
         {
            if(!this.whiteBox)
            {
               this.whiteBox = new FlexShape();
               this.whiteBox.name = "whiteBox";
               (_loc8_ = this.whiteBox.graphics).beginFill(16777215);
               _loc8_.drawRect(0,0,this.verticalScrollBar.minWidth,this.horizontalScrollBar.minHeight);
               _loc8_.endFill();
               this.rawChildren.addChild(this.whiteBox);
            }
         }
         else if(this.whiteBox)
         {
            this.rawChildren.removeChild(this.whiteBox);
            this.whiteBox = null;
         }
         return _loc4_;
      }
      
      private function clampScrollPositions() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this._horizontalScrollPosition < 0)
         {
            this._horizontalScrollPosition = 0;
            _loc1_ = true;
         }
         else if(this._horizontalScrollPosition > this.maxHorizontalScrollPosition)
         {
            this._horizontalScrollPosition = this.maxHorizontalScrollPosition;
            _loc1_ = true;
         }
         if(this.horizontalScrollBar && this.horizontalScrollBar.scrollPosition != this._horizontalScrollPosition)
         {
            this.horizontalScrollBar.scrollPosition = this._horizontalScrollPosition;
         }
         if(this._verticalScrollPosition < 0)
         {
            this._verticalScrollPosition = 0;
            _loc1_ = true;
         }
         else if(this._verticalScrollPosition > this.maxVerticalScrollPosition)
         {
            this._verticalScrollPosition = this.maxVerticalScrollPosition;
            _loc1_ = true;
         }
         if(this.verticalScrollBar && this.verticalScrollBar.scrollPosition != this._verticalScrollPosition)
         {
            this.verticalScrollBar.scrollPosition = this._verticalScrollPosition;
         }
         return _loc1_;
      }
      
      mx_internal function createContentPane() : void
      {
         var _loc3_:int = 0;
         var _loc5_:IUIComponent = null;
         if(this.contentPane)
         {
            return;
         }
         this.creatingContentPane = true;
         var _loc1_:int = this.numChildren;
         var _loc2_:Sprite = new FlexSprite();
         _loc2_.name = "contentPane";
         if(this.border)
         {
            _loc3_ = this.rawChildren.getChildIndex(DisplayObject(this.border)) + 1;
            if(this.border is IRectangularBorder && IRectangularBorder(this.border).hasBackgroundImage)
            {
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
         }
         this.rawChildren.addChildAt(_loc2_,_loc3_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc5_ = IUIComponent(super.getChildAt(this._firstChildIndex));
            _loc2_.addChild(DisplayObject(_loc5_));
            _loc5_.parentChanged(_loc2_);
            --this._numChildren;
            _loc4_++;
         }
         this.contentPane = _loc2_;
         this.creatingContentPane = false;
         this.contentPane.visible = true;
      }
      
      protected function scrollChildren() : void
      {
         if(!this.contentPane)
         {
            return;
         }
         var _loc1_:EdgeMetrics = this.viewMetrics;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = unscaledWidth - _loc1_.left - _loc1_.right;
         var _loc5_:Number = unscaledHeight - _loc1_.top - _loc1_.bottom;
         if(this._clipContent)
         {
            _loc2_ += this._horizontalScrollPosition;
            if(this.horizontalScrollBar)
            {
               _loc4_ = this.viewableWidth;
            }
            _loc3_ += this._verticalScrollPosition;
            if(this.verticalScrollBar)
            {
               _loc5_ = this.viewableHeight;
            }
         }
         else
         {
            _loc4_ = this.scrollableWidth;
            _loc5_ = this.scrollableHeight;
         }
         var _loc6_:Rectangle = this.getScrollableRect();
         if(_loc2_ == 0 && _loc3_ == 0 && _loc4_ >= _loc6_.right && _loc5_ >= _loc6_.bottom && _loc6_.left >= 0 && _loc6_.top >= 0 && this._forceClippingCount <= 0)
         {
            this.contentPane.scrollRect = null;
            this.contentPane.opaqueBackground = null;
            this.contentPane.cacheAsBitmap = false;
         }
         else
         {
            this.contentPane.scrollRect = new Rectangle(_loc2_,_loc3_,_loc4_,_loc5_);
         }
         if(this.focusPane)
         {
            this.focusPane.scrollRect = this.contentPane.scrollRect;
         }
         if(this.border && this.border is IRectangularBorder && IRectangularBorder(this.border).hasBackgroundImage)
         {
            IRectangularBorder(this.border).layoutBackgroundImage();
         }
      }
      
      private function dispatchScrollEvent(param1:String, param2:Number, param3:Number, param4:String) : void
      {
         var _loc5_:ScrollEvent;
         (_loc5_ = new ScrollEvent(ScrollEvent.SCROLL)).direction = param1;
         _loc5_.position = param3;
         _loc5_.delta = param3 - param2;
         _loc5_.detail = param4;
         dispatchEvent(_loc5_);
      }
      
      mx_internal function set forceClipping(param1:Boolean) : void
      {
         if(this._clipContent)
         {
            if(param1)
            {
               ++this._forceClippingCount;
            }
            else
            {
               --this._forceClippingCount;
            }
            this.createContentPane();
            this.scrollChildren();
         }
      }
      
      public function executeChildBindings(param1:Boolean) : void
      {
         var _loc4_:IUIComponent = null;
         var _loc2_:int = this.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = IUIComponent(this.getChildAt(_loc3_))) is IDeferredInstantiationUIComponent)
            {
               IDeferredInstantiationUIComponent(_loc4_).executeBindings(param1);
            }
            _loc3_++;
         }
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc2_:Object = getFocus();
         if(_loc2_ is TextField || this.richEditableTextClass && _loc2_ is this.richEditableTextClass)
         {
            return;
         }
         if(param1.isDefaultPrevented())
         {
            return;
         }
         if(this.verticalScrollBar)
         {
            _loc3_ = ScrollEventDirection.VERTICAL;
            _loc4_ = this.verticalScrollPosition;
            switch(param1.keyCode)
            {
               case Keyboard.DOWN:
                  this.verticalScrollPosition += this.verticalLineScrollSize;
                  this.dispatchScrollEvent(_loc3_,_loc4_,this.verticalScrollPosition,ScrollEventDetail.LINE_DOWN);
                  param1.stopPropagation();
                  break;
               case Keyboard.UP:
                  this.verticalScrollPosition -= this.verticalLineScrollSize;
                  this.dispatchScrollEvent(_loc3_,_loc4_,this.verticalScrollPosition,ScrollEventDetail.LINE_UP);
                  param1.stopPropagation();
                  break;
               case Keyboard.PAGE_UP:
                  this.verticalScrollPosition -= this.verticalPageScrollSize;
                  this.dispatchScrollEvent(_loc3_,_loc4_,this.verticalScrollPosition,ScrollEventDetail.PAGE_UP);
                  param1.stopPropagation();
                  break;
               case Keyboard.PAGE_DOWN:
                  this.verticalScrollPosition += this.verticalPageScrollSize;
                  this.dispatchScrollEvent(_loc3_,_loc4_,this.verticalScrollPosition,ScrollEventDetail.PAGE_DOWN);
                  param1.stopPropagation();
                  break;
               case Keyboard.HOME:
                  this.verticalScrollPosition = this.verticalScrollBar.minScrollPosition;
                  this.dispatchScrollEvent(_loc3_,_loc4_,this.verticalScrollPosition,ScrollEventDetail.AT_TOP);
                  param1.stopPropagation();
                  break;
               case Keyboard.END:
                  this.verticalScrollPosition = this.verticalScrollBar.maxScrollPosition;
                  this.dispatchScrollEvent(_loc3_,_loc4_,this.verticalScrollPosition,ScrollEventDetail.AT_BOTTOM);
                  param1.stopPropagation();
            }
         }
         if(this.horizontalScrollBar)
         {
            _loc3_ = ScrollEventDirection.HORIZONTAL;
            _loc4_ = this.horizontalScrollPosition;
            _loc5_ = mapKeycodeForLayoutDirection(param1);
            switch(_loc5_)
            {
               case Keyboard.LEFT:
                  this.horizontalScrollPosition -= this.horizontalLineScrollSize;
                  this.dispatchScrollEvent(_loc3_,_loc4_,this.horizontalScrollPosition,ScrollEventDetail.LINE_LEFT);
                  param1.stopPropagation();
                  break;
               case Keyboard.RIGHT:
                  this.horizontalScrollPosition += this.horizontalLineScrollSize;
                  this.dispatchScrollEvent(_loc3_,_loc4_,this.horizontalScrollPosition,ScrollEventDetail.LINE_RIGHT);
                  param1.stopPropagation();
            }
         }
      }
      
      private function mouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.verticalScrollBar && !param1.isDefaultPrevented())
         {
            _loc2_ = param1.delta <= 0 ? 1 : -1;
            _loc3_ = !!this.verticalScrollBar ? int(this.verticalScrollBar.lineScrollSize) : 1;
            _loc4_ = Math.max(Math.abs(param1.delta),_loc3_);
            _loc5_ = this.verticalScrollPosition;
            this.verticalScrollPosition += 3 * _loc4_ * _loc2_;
            this.dispatchScrollEvent(ScrollEventDirection.VERTICAL,_loc5_,this.verticalScrollPosition,param1.delta <= 0 ? ScrollEventDetail.LINE_UP : ScrollEventDetail.LINE_DOWN);
            param1.preventDefault();
         }
      }
      
      private function layoutCompleteHandler(param1:FlexEvent) : void
      {
         UIComponentGlobals.layoutManager.removeEventListener(FlexEvent.UPDATE_COMPLETE,this.layoutCompleteHandler);
         this.forceLayout = false;
         var _loc2_:Boolean = false;
         if(!isNaN(this.horizontalScrollPositionPending))
         {
            if(this.horizontalScrollPositionPending < 0)
            {
               this.horizontalScrollPositionPending = 0;
            }
            else if(this.horizontalScrollPositionPending > this.maxHorizontalScrollPosition)
            {
               this.horizontalScrollPositionPending = this.maxHorizontalScrollPosition;
            }
            if(this.horizontalScrollBar && this.horizontalScrollBar.scrollPosition != this.horizontalScrollPositionPending)
            {
               this._horizontalScrollPosition = this.horizontalScrollPositionPending;
               this.horizontalScrollBar.scrollPosition = this.horizontalScrollPositionPending;
               _loc2_ = true;
            }
            this.horizontalScrollPositionPending = NaN;
         }
         if(!isNaN(this.verticalScrollPositionPending))
         {
            if(this.verticalScrollPositionPending < 0)
            {
               this.verticalScrollPositionPending = 0;
            }
            else if(this.verticalScrollPositionPending > this.maxVerticalScrollPosition)
            {
               this.verticalScrollPositionPending = this.maxVerticalScrollPosition;
            }
            if(this.verticalScrollBar && this.verticalScrollBar.scrollPosition != this.verticalScrollPositionPending)
            {
               this._verticalScrollPosition = this.verticalScrollPositionPending;
               this.verticalScrollBar.scrollPosition = this.verticalScrollPositionPending;
               _loc2_ = true;
            }
            this.verticalScrollPositionPending = NaN;
         }
         if(_loc2_)
         {
            this.scrollChildren();
         }
      }
      
      private function creationCompleteHandler(param1:FlexEvent) : void
      {
         --this.numChildrenCreated;
         if(this.numChildrenCreated <= 0)
         {
            dispatchEvent(new FlexEvent("childrenCreationComplete"));
         }
      }
      
      private function horizontalScrollBar_scrollHandler(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(param1 is ScrollEvent)
         {
            _loc2_ = this.horizontalScrollPosition;
            this.horizontalScrollPosition = this.horizontalScrollBar.scrollPosition;
            this.dispatchScrollEvent(ScrollEventDirection.HORIZONTAL,_loc2_,this.horizontalScrollPosition,ScrollEvent(param1).detail);
         }
      }
      
      private function verticalScrollBar_scrollHandler(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(param1 is ScrollEvent)
         {
            _loc2_ = this.verticalScrollPosition;
            this.verticalScrollPosition = this.verticalScrollBar.scrollPosition;
            this.dispatchScrollEvent(ScrollEventDirection.VERTICAL,_loc2_,this.verticalScrollPosition,ScrollEvent(param1).detail);
         }
      }
      
      private function blocker_clickHandler(param1:Event) : void
      {
         param1.stopPropagation();
      }
   }
}
