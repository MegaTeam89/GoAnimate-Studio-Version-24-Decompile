package mx.containers.utilityClasses
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mx.core.IInvalidating;
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class ConstraintRow extends EventDispatcher implements IMXMLObject
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      mx_internal var contentSize:Boolean = false;
      
      private var _baseline:Object = "maxAscent:0";
      
      private var _container:IInvalidating;
      
      mx_internal var _height:Number;
      
      private var _explicitHeight:Number;
      
      private var _id:String;
      
      private var _explicitMaxHeight:Number;
      
      private var _explicitMinHeight:Number;
      
      private var _percentHeight:Number;
      
      private var _y:Number;
      
      public function ConstraintRow()
      {
         super();
      }
      
      [Bindable("baselineChanged")]
      public function get baseline() : Object
      {
         return this._baseline;
      }
      
      public function set baseline(param1:Object) : void
      {
         if(this._baseline != param1)
         {
            this._baseline = param1;
            if(this.container)
            {
               this.container.invalidateSize();
               this.container.invalidateDisplayList();
            }
            dispatchEvent(new Event("baselineChanged"));
         }
      }
      
      public function get container() : IInvalidating
      {
         return this._container;
      }
      
      public function set container(param1:IInvalidating) : void
      {
         this._container = param1;
      }
      
      [Bindable("heightChanged")]
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(param1:Number) : void
      {
         if(this.explicitHeight != param1)
         {
            this.explicitHeight = param1;
            if(this._height != param1)
            {
               this._height = param1;
               if(!isNaN(this._height))
               {
                  this.contentSize = false;
               }
               if(this.container)
               {
                  this.container.invalidateSize();
                  this.container.invalidateDisplayList();
               }
               dispatchEvent(new Event("heightChanged"));
            }
         }
      }
      
      [Bindable("explicitHeightChanged")]
      public function get explicitHeight() : Number
      {
         return this._explicitHeight;
      }
      
      public function set explicitHeight(param1:Number) : void
      {
         if(this._explicitHeight == param1)
         {
            return;
         }
         if(!isNaN(param1))
         {
            this._percentHeight = NaN;
         }
         this._explicitHeight = param1;
         if(this.container)
         {
            this.container.invalidateSize();
            this.container.invalidateDisplayList();
         }
         dispatchEvent(new Event("explicitHeightChanged"));
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      [Bindable("maxHeightChanged")]
      public function get maxHeight() : Number
      {
         return !isNaN(this._explicitMaxHeight) ? Number(this._explicitMaxHeight) : Number(10000);
      }
      
      public function set maxHeight(param1:Number) : void
      {
         if(this._explicitMaxHeight != param1)
         {
            this._explicitMaxHeight = param1;
            if(this.container)
            {
               this.container.invalidateSize();
               this.container.invalidateDisplayList();
            }
            dispatchEvent(new Event("maxHeightChanged"));
         }
      }
      
      [Bindable("minHeightChanged")]
      public function get minHeight() : Number
      {
         return !isNaN(this._explicitMinHeight) ? Number(this._explicitMinHeight) : Number(0);
      }
      
      public function set minHeight(param1:Number) : void
      {
         if(this._explicitMinHeight != param1)
         {
            this._explicitMinHeight = param1;
            if(this.container)
            {
               this.container.invalidateSize();
               this.container.invalidateDisplayList();
            }
            dispatchEvent(new Event("minHeightChanged"));
         }
      }
      
      [Bindable("percentHeightChanged")]
      public function get percentHeight() : Number
      {
         return this._percentHeight;
      }
      
      public function set percentHeight(param1:Number) : void
      {
         if(this._percentHeight == param1)
         {
            return;
         }
         if(!isNaN(param1))
         {
            this._explicitHeight = NaN;
         }
         this._percentHeight = param1;
         if(!isNaN(this._percentHeight))
         {
            this.contentSize = false;
         }
         if(this.container)
         {
            this.container.invalidateSize();
            this.container.invalidateDisplayList();
         }
      }
      
      [Bindable("yChanged")]
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         if(param1 != this._y)
         {
            this._y = param1;
            dispatchEvent(new Event("yChanged"));
         }
      }
      
      public function initialized(param1:Object, param2:String) : void
      {
         this.id = param2;
         if(!this.height && !this.percentHeight)
         {
            this.contentSize = true;
         }
      }
      
      public function setActualHeight(param1:Number) : void
      {
         if(this._height != param1)
         {
            this._height = param1;
            dispatchEvent(new Event("heightChanged"));
         }
      }
   }
}
