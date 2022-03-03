package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.core.AnimeSound;
   import anifire.event.ExtraDataEvent;
   import anifire.util.Util;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.ChildExistenceChangedEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class SceneContainer extends Canvas implements ITimelineContainer, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _67793216canvasSceneLabel:Canvas;
      
      private var _98309cce:Fade;
      
      private var _351951586itemList_cs:Canvas;
      
      private var _351951448itemList_hb:HBox;
      
      private var _2135423153title_lbl:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _enableFocus:Boolean = true;
      
      private var _label:String;
      
      private var _focus:Boolean = false;
      
      private var _items:Array;
      
      private var _itemsCollect:ArrayCollection;
      
      private var _currItem:ITimelineElement;
      
      private var _timelineControl:Timeline = null;
      
      private var _controlCreateStatus:Boolean = false;
      
      private var _controlClickStatus:Boolean = false;
      
      private var _controlPrevX:Number = 0;
      
      private var _controlPrevW:Number = 0;
      
      private var _controlStageX:Number = 0;
      
      private const MAX_WIDTH:Number = 2000;
      
      private const MOTION_TIME:Number = UtilUnitConvert.secToPixel(AnimeConstants.MOTION_DURATION);
      
      private var _wingWidth:Number;
      
      private var _wingHeight:Number;
      
      private var E_Symbol:Class;
      
      private var _selection:ArrayCollection;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var sceneChangeType:String = "Resize";
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SceneContainer()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"initialize":"___SceneContainer_Canvas1_initialize"},
            "effects":["creationCompleteEffect"],
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"canvasSceneLabel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "width":72,
                        "percentHeight":100,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "id":"title_lbl",
                  "events":{"creationComplete":"__title_lbl_creationComplete"},
                  "stylesFactory":function():void
                  {
                     this.fontWeight = "bold";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "verticalCenter":0,
                        "left":5,
                        "width":60,
                        "text":"Element"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"itemList_cs",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "verticalCenter":0,
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "buttonMode":true,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "id":"itemList_hb",
                           "events":{
                              "childAdd":"__itemList_hb_childAdd",
                              "childRemove":"__itemList_hb_childRemove",
                              "updateComplete":"__itemList_hb_updateComplete"
                           },
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "left":0,
                                 "verticalCenter":0,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off"
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this.E_Symbol = SceneContainer_E_Symbol;
         this._selection = new ArrayCollection();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SceneContainer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SceneContainerWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SceneContainer[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.styleName = "normal";
         this._SceneContainer_Fade1_i();
         this.addEventListener("initialize",this.___SceneContainer_Canvas1_initialize);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SceneContainer._watcherSetupUtil = param1;
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
      
      private function initApp() : void
      {
         this._items = new Array();
         this._itemsCollect = new ArrayCollection(this._items);
      }
      
      override public function get label() : String
      {
         return this._label;
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      public function get length() : Number
      {
         return this._itemsCollect.length;
      }
      
      public function get count() : int
      {
         return this._itemsCollect.length;
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.showTitle();
      }
      
      public function set focus(param1:Boolean) : void
      {
         this._focus = param1;
         if(this._focus && this._enableFocus)
         {
         }
      }
      
      public function updateSpeechTxtByIndex(param1:int = -1, param2:String = "", param3:AnimeSound = null) : void
      {
         if(param1 < 0)
         {
            param1 = this.getCurrIndex();
         }
         var _loc4_:SceneElement;
         (_loc4_ = this._itemsCollect.getItemAt(param1) as SceneElement).updateSpeechComment(param2,param3);
      }
      
      public function addSceneMotionTimeByIndex(param1:int = -1) : void
      {
         if(param1 < 0)
         {
            param1 = this.getCurrIndex();
         }
         var _loc2_:SceneElement = this._itemsCollect.getItemAt(param1) as SceneElement;
         if(_loc2_.motionTime <= 0)
         {
            _loc2_.width += this.MOTION_TIME;
         }
         _loc2_.motionTime = this.MOTION_TIME;
      }
      
      public function removeSceneMotionTimeByIndex(param1:int = -1) : void
      {
         if(param1 < 0)
         {
            param1 = this.getCurrIndex();
         }
         var _loc2_:SceneElement = this._itemsCollect.getItemAt(param1) as SceneElement;
         if(_loc2_.motionTime == this.MOTION_TIME)
         {
            _loc2_.width -= this.MOTION_TIME;
         }
         _loc2_.motionTime = 0;
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
      }
      
      public function enableFocus() : void
      {
         this._enableFocus = true;
      }
      
      public function disableFocus() : void
      {
         this._enableFocus = false;
      }
      
      public function showTitle() : void
      {
         try
         {
            this.title_lbl.text = this._label;
         }
         catch(e:Error)
         {
         }
      }
      
      public function setCurrentItemByIndex(param1:int) : void
      {
         this.currentIndex = param1;
      }
      
      private function set currentIndex(param1:Number) : void
      {
         var _loc2_:ITimelineElement = null;
         if(param1 >= 0 && param1 < this._itemsCollect.length)
         {
            _loc2_ = this._itemsCollect.getItemAt(param1) as ITimelineElement;
            this.currentScene = _loc2_;
         }
      }
      
      private function selectScene(param1:ITimelineElement) : void
      {
         if(this._selection.getItemIndex(param1) == -1)
         {
            this._selection.addItem(param1);
            param1.focus = true;
            this._currItem = param1;
         }
      }
      
      private function deselectScene(param1:ITimelineElement) : void
      {
         if(this._selection.length > 1 && this._selection.getItemIndex(param1) >= 0)
         {
            this._selection.removeItemAt(this._selection.getItemIndex(param1));
            param1.focus = false;
            this._currItem = this._selection[0] as ITimelineElement;
         }
      }
      
      private function set currentScene(param1:ITimelineElement) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ITimelineElement = null;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < this._selection.length)
            {
               _loc3_ = this._selection.getItemAt(_loc2_) as ITimelineElement;
               if(_loc3_)
               {
                  _loc3_.focus = false;
               }
               _loc2_++;
            }
            this._selection.removeAll();
            this._selection.addItem(param1);
            param1.focus = true;
            this._currItem = param1;
         }
      }
      
      public function addItem(param1:UIComponent) : void
      {
         this.addItemAt(param1,this._itemsCollect.length);
      }
      
      public function addItemAt(param1:UIComponent, param2:int) : void
      {
         this._itemsCollect.addItemAt(param1,param2);
         var _loc3_:ITimelineElement = this.itemList_hb.addChildAt(param1,param2) as ITimelineElement;
         this.itemList_hb.validateNow();
         _loc3_.setTimelineReferer(this._timelineControl);
         param1.addEventListener("TIMELINE_CHANGE",this.timelineChangeHandler);
         SceneElement(_loc3_).id = String(param2);
         this.currentIndex = param2;
         param1.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this.callLater(this.addSceneHandler);
      }
      
      private function timelineChangeHandler(param1:Event) : void
      {
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this,"SetSceneDuration"));
      }
      
      private function addSceneHandler() : void
      {
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this,"AddScene"));
      }
      
      public function removeItem(param1:Number = -1) : Boolean
      {
         var index:Number = param1;
         try
         {
            if(index < 0)
            {
               index = this.getCurrIndex();
            }
            if(index <= this._itemsCollect.length)
            {
               this._itemsCollect.removeItemAt(index);
               this.itemList_hb.removeChildAt(index);
               if(index >= this._itemsCollect.length && index != 0)
               {
                  index = this._itemsCollect.length - 1;
               }
               if(this._itemsCollect.length > 0)
               {
                  this.currentIndex = index;
               }
               else
               {
                  this._currItem = null;
               }
               this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this,"RemoveScene"));
               return true;
            }
            return false;
         }
         catch(e:RangeError)
         {
            return false;
         }
      }
      
      public function removeAllItems() : void
      {
         this._itemsCollect.removeAll();
         this.itemList_hb.removeAllChildren();
         this._currItem = null;
      }
      
      public function changeProperty(param1:int, param2:String, param3:* = null) : void
      {
         var _loc4_:ITimelineElement = null;
         if(param1 >= 0 && param1 < this._itemsCollect.length)
         {
            (_loc4_ = this._itemsCollect.getItemAt(param1) as ITimelineElement)[param2] = param3;
            this._itemsCollect.setItemAt(_loc4_,param1);
            this.itemList_hb.setChildIndex(_loc4_ as UIComponent,param1);
         }
      }
      
      public function setCurrIndex(param1:Number) : void
      {
         this.currentIndex = param1;
      }
      
      public function getCurrItem() : ITimelineElement
      {
         return this._currItem;
      }
      
      public function getCurrIndex() : int
      {
         return this._itemsCollect.getItemIndex(this._currItem);
      }
      
      public function getItemAt(param1:int) : ITimelineElement
      {
         var _loc2_:ITimelineElement = null;
         try
         {
            _loc2_ = this._itemsCollect.getItemAt(param1) as ITimelineElement;
         }
         catch(e:RangeError)
         {
         }
         return _loc2_;
      }
      
      public function setHorizontalView(param1:Number = 0) : void
      {
         this.itemList_hb.setStyle("left",-param1);
      }
      
      public function getHorizontalView() : Number
      {
         return this.itemList_hb.getStyle("left");
      }
      
      public function getSceneBounds() : Array
      {
         var _loc4_:ITimelineElement = null;
         var _loc1_:Array = new Array();
         var _loc2_:Number = this._itemsCollect.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.itemList_hb.getChildAt(_loc3_) as ITimelineElement;
            _loc1_.push(new Rectangle(_loc4_.x,_loc4_.y,_loc4_.width,_loc4_.height));
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function isSceneVisible(param1:int) : Boolean
      {
         var _loc2_:SceneElement = this._itemsCollect.getItemAt(param1) as SceneElement;
         var _loc3_:Number = _loc2_.x + this.itemList_hb.x;
         var _loc4_:Number = _loc2_.x + _loc2_.width + this.itemList_hb.x;
         var _loc5_:Number = 0;
         var _loc6_:Number = this.itemList_cs.width;
         if(_loc3_ > _loc5_ && _loc3_ < _loc6_ && (_loc4_ > _loc5_ && _loc4_ < _loc6_))
         {
            return true;
         }
         return false;
      }
      
      public function selectSceneElement(param1:SceneElement) : void
      {
         this.currentScene = param1;
      }
      
      private function resetItemsFocus() : void
      {
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:TimelineEvent = null;
         if(!this._controlClickStatus)
         {
            _loc2_ = new TimelineEvent(TimelineEvent.SCENE_MOUSE_UP);
            _loc2_.shiftKey = param1.shiftKey;
            dispatchEvent(_loc2_);
         }
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:ITimelineElement = param1.currentTarget as ITimelineElement;
         if(param1.shiftKey)
         {
            if(this._selection.getItemIndex(_loc2_) == -1)
            {
               this.selectScene(_loc2_);
            }
            else
            {
               this.deselectScene(_loc2_);
            }
         }
         else if(this._selection.getItemIndex(_loc2_) == -1)
         {
            this.currentScene = _loc2_;
         }
         SceneElement(_loc2_).id = this._itemsCollect.getItemIndex(_loc2_) as String;
         var _loc3_:TimelineEvent = new TimelineEvent(TimelineEvent.SCENE_MOUSE_DOWN,this._itemsCollect.getItemIndex(_loc2_));
         _loc3_.shiftKey = param1.shiftKey;
         dispatchEvent(_loc3_);
         this._originalX = this.stage.mouseX;
         this._originalY = this.stage.mouseY;
      }
      
      private function onControlDownHandler(param1:MouseEvent) : void
      {
         this._controlClickStatus = true;
         this._controlPrevX = param1.stageX;
         this._controlPrevW = this._currItem.width;
         SceneElement(this._currItem).showIndicator();
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onControlMoveHandler);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onControlUpHandler);
         stage.addEventListener(MouseEvent.MOUSE_OUT,this.onStageMouseOut);
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_START));
      }
      
      private function onStageMouseOut(param1:MouseEvent) : void
      {
         if(param1.stageX <= 0 || param1.stageX >= stage.stageWidth || param1.stageY <= 0 || param1.stageY >= stage.stageHeight)
         {
            this.onControlUpHandler(param1);
         }
      }
      
      private function onControlMoveHandler(param1:MouseEvent) : void
      {
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this,"Resize"));
         param1.updateAfterEvent();
         var _loc2_:Number = this._controlPrevW + param1.stageX - this._controlPrevX;
         var _loc3_:Number = AnimeConstants.SCENE_LENGTH_MINIMUM;
         if(_loc2_ < _loc3_)
         {
            _loc2_ = _loc3_;
         }
         this._timelineControl.onSceneResize(SceneElement(this._currItem),_loc2_);
      }
      
      private function onControlUpHandler(param1:Event) : void
      {
         this._controlClickStatus = false;
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onControlMoveHandler);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onControlUpHandler);
         stage.removeEventListener(MouseEvent.MOUSE_OUT,this.onStageMouseOut);
         this.itemList_hb.graphics.clear();
         SceneElement(this._currItem).removeIndicator();
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_COMPLETE));
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_MOUSE_UP));
         Util.gaTracking("/gostudio/timeline/ControlSceneResize",this.stage);
         this.dispatchEvent(new Event("TIMELINE_CHANGE_COMPLETE"));
      }
      
      private function onUpdateComplete(param1:Event) : void
      {
      }
      
      private function addArrowListener(param1:ChildExistenceChangedEvent) : void
      {
         if(param1.relatedObject is SceneElement)
         {
            (param1.relatedObject as SceneElement).addEventListener("ArrowClick",this.arrowEventHandler);
         }
      }
      
      private function removeArrowListener(param1:ChildExistenceChangedEvent) : void
      {
         if(param1.relatedObject is SceneElement && (param1.relatedObject as SceneElement).hasEventListener("ArrowClick"))
         {
            (param1.relatedObject as SceneElement).removeEventListener("ArrowClick",this.arrowEventHandler);
         }
      }
      
      private function arrowEventHandler(param1:ExtraDataEvent) : void
      {
         this.currentScene = param1.getEventCreater() as SceneElement;
         this.onControlDownHandler(param1.getData() as MouseEvent);
      }
      
      private function _SceneContainer_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 200;
         this.cce = _loc1_;
         BindingManager.executeBindings(this,"cce",this.cce);
         return _loc1_;
      }
      
      public function ___SceneContainer_Canvas1_initialize(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function __title_lbl_creationComplete(param1:FlexEvent) : void
      {
         this.showTitle();
      }
      
      public function __itemList_hb_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.addArrowListener(param1);
      }
      
      public function __itemList_hb_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.removeArrowListener(param1);
      }
      
      public function __itemList_hb_updateComplete(param1:FlexEvent) : void
      {
         this.onUpdateComplete(param1);
      }
      
      private function _SceneContainer_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,null,function(param1:*):void
         {
            this.setStyle("creationCompleteEffect",param1);
         },"this.creationCompleteEffect","cce");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get canvasSceneLabel() : Canvas
      {
         return this._67793216canvasSceneLabel;
      }
      
      public function set canvasSceneLabel(param1:Canvas) : void
      {
         var _loc2_:Object = this._67793216canvasSceneLabel;
         if(_loc2_ !== param1)
         {
            this._67793216canvasSceneLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvasSceneLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cce() : Fade
      {
         return this._98309cce;
      }
      
      public function set cce(param1:Fade) : void
      {
         var _loc2_:Object = this._98309cce;
         if(_loc2_ !== param1)
         {
            this._98309cce = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cce",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemList_cs() : Canvas
      {
         return this._351951586itemList_cs;
      }
      
      public function set itemList_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._351951586itemList_cs;
         if(_loc2_ !== param1)
         {
            this._351951586itemList_cs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemList_cs",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get itemList_hb() : HBox
      {
         return this._351951448itemList_hb;
      }
      
      public function set itemList_hb(param1:HBox) : void
      {
         var _loc2_:Object = this._351951448itemList_hb;
         if(_loc2_ !== param1)
         {
            this._351951448itemList_hb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemList_hb",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get title_lbl() : Label
      {
         return this._2135423153title_lbl;
      }
      
      public function set title_lbl(param1:Label) : void
      {
         var _loc2_:Object = this._2135423153title_lbl;
         if(_loc2_ !== param1)
         {
            this._2135423153title_lbl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"title_lbl",_loc2_,param1));
            }
         }
      }
   }
}
