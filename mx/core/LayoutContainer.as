package mx.core
{
   import flash.events.Event;
   import mx.containers.BoxDirection;
   import mx.containers.utilityClasses.BoxLayout;
   import mx.containers.utilityClasses.CanvasLayout;
   import mx.containers.utilityClasses.ConstraintColumn;
   import mx.containers.utilityClasses.ConstraintRow;
   import mx.containers.utilityClasses.IConstraintLayout;
   import mx.containers.utilityClasses.Layout;
   
   use namespace mx_internal;
   
   public class LayoutContainer extends Container implements IConstraintLayout
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
      
      mx_internal static var useProgressiveLayout:Boolean = false;
       
      
      protected var layoutObject:Layout;
      
      protected var canvasLayoutClass:Class;
      
      protected var boxLayoutClass:Class;
      
      private var resizeHandlerAdded:Boolean = false;
      
      private var preloadObj:Object;
      
      private var creationQueue:Array;
      
      private var processingCreationQueue:Boolean = false;
      
      private var _constraintColumns:Array;
      
      private var _constraintRows:Array;
      
      private var _layout:String = "vertical";
      
      public function LayoutContainer()
      {
         this.layoutObject = new BoxLayout();
         this.canvasLayoutClass = CanvasLayout;
         this.boxLayoutClass = BoxLayout;
         this.creationQueue = [];
         this._constraintColumns = [];
         this._constraintRows = [];
         super();
         this.layoutObject.target = this;
      }
      
      public function get constraintColumns() : Array
      {
         return this._constraintColumns;
      }
      
      public function set constraintColumns(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != this._constraintColumns)
         {
            _loc2_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               ConstraintColumn(param1[_loc3_]).container = this;
               _loc3_++;
            }
            this._constraintColumns = param1;
            invalidateSize();
            invalidateDisplayList();
         }
      }
      
      public function get constraintRows() : Array
      {
         return this._constraintRows;
      }
      
      public function set constraintRows(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != this._constraintRows)
         {
            _loc2_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               ConstraintRow(param1[_loc3_]).container = this;
               _loc3_++;
            }
            this._constraintRows = param1;
            invalidateSize();
            invalidateDisplayList();
         }
      }
      
      [Bindable("layoutChanged")]
      public function get layout() : String
      {
         return this._layout;
      }
      
      public function set layout(param1:String) : void
      {
         if(this._layout != param1)
         {
            this._layout = param1;
            if(this.layoutObject)
            {
               this.layoutObject.target = null;
            }
            if(this._layout == ContainerLayout.ABSOLUTE)
            {
               this.layoutObject = new this.canvasLayoutClass();
            }
            else
            {
               this.layoutObject = new this.boxLayoutClass();
               if(this._layout == ContainerLayout.VERTICAL)
               {
                  BoxLayout(this.layoutObject).direction = BoxDirection.VERTICAL;
               }
               else
               {
                  BoxLayout(this.layoutObject).direction = BoxDirection.HORIZONTAL;
               }
            }
            if(this.layoutObject)
            {
               this.layoutObject.target = this;
            }
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("layoutChanged"));
         }
      }
      
      override mx_internal function get usePadding() : Boolean
      {
         return this.layout != ContainerLayout.ABSOLUTE;
      }
      
      override protected function measure() : void
      {
         super.measure();
         this.layoutObject.measure();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         this.layoutObject.updateDisplayList(param1,param2);
         createBorder();
      }
      
      override protected function layoutChrome(param1:Number, param2:Number) : void
      {
         super.layoutChrome(param1,param2);
         if(!mx_internal::doingLayout)
         {
            createBorder();
         }
      }
   }
}
