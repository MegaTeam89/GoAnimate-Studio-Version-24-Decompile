package mx.containers.utilityClasses
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mx.core.IInvalidating;
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class ConstraintColumn extends EventDispatcher implements IMXMLObject
   {
      
      mx_internal static const VERSION:String = "4.6.0.23201";
       
      
      mx_internal var contentSize:Boolean = false;
      
      private var _container:IInvalidating;
      
      private var _id:String;
      
      private var _explicitMaxWidth:Number;
      
      private var _explicitMinWidth:Number;
      
      mx_internal var _width:Number;
      
      private var _explicitWidth:Number;
      
      private var _percentWidth:Number;
      
      private var _x:Number;
      
      public function ConstraintColumn()
      {
         super();
      }
      
      public function get container() : IInvalidating
      {
         return this._container;
      }
      
      public function set container(param1:IInvalidating) : void
      {
         this._container = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      [Bindable("maxWidthChanged")]
      public function get maxWidth() : Number
      {
         return !isNaN(this._explicitMaxWidth) ? Number(this._explicitMaxWidth) : Number(10000);
      }
      
      public function set maxWidth(param1:Number) : void
      {
         if(this._explicitMaxWidth != param1)
         {
            this._explicitMaxWidth = param1;
            if(this.container)
            {
               this.container.invalidateSize();
               this.container.invalidateDisplayList();
            }
            dispatchEvent(new Event("maxWidthChanged"));
         }
      }
      
      [Bindable("minWidthChanged")]
      public function get minWidth() : Number
      {
         return !isNaN(this._explicitMinWidth) ? Number(this._explicitMinWidth) : Number(0);
      }
      
      public function set minWidth(param1:Number) : void
      {
         if(this._explicitMinWidth != param1)
         {
            this._explicitMinWidth = param1;
            if(this.container)
            {
               this.container.invalidateSize();
               this.container.invalidateDisplayList();
            }
            dispatchEvent(new Event("minWidthChanged"));
         }
      }
      
      [Bindable("widthChanged")]
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(param1:Number) : void
      {
         if(this.explicitWidth != param1)
         {
            this.explicitWidth = param1;
            if(this._width != param1)
            {
               this._width = param1;
               if(!isNaN(this._width))
               {
                  this.contentSize = false;
               }
               if(this.container)
               {
                  this.container.invalidateSize();
                  this.container.invalidateDisplayList();
               }
               dispatchEvent(new Event("widthChanged"));
            }
         }
      }
      
      [Bindable("explicitWidthChanged")]
      public function get explicitWidth() : Number
      {
         return this._explicitWidth;
      }
      
      public function set explicitWidth(param1:Number) : void
      {
         if(this._explicitWidth == param1)
         {
            return;
         }
         if(!isNaN(param1))
         {
            this._percentWidth = NaN;
         }
         this._explicitWidth = param1;
         if(this.container)
         {
            this.container.invalidateSize();
            this.container.invalidateDisplayList();
         }
         dispatchEvent(new Event("explicitWidthChanged"));
      }
      
      [Bindable("percentWidthChanged")]
      public function get percentWidth() : Number
      {
         return this._percentWidth;
      }
      
      public function set percentWidth(param1:Number) : void
      {
         if(this._percentWidth == param1)
         {
            return;
         }
         if(!isNaN(param1))
         {
            this._explicitWidth = NaN;
         }
         this._percentWidth = param1;
         if(!isNaN(this._percentWidth))
         {
            this.contentSize = false;
         }
         if(this.container)
         {
            this.container.invalidateSize();
            this.container.invalidateDisplayList();
         }
         dispatchEvent(new Event("percentWidthChanged"));
      }
      
      [Bindable("xChanged")]
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         if(param1 != this._x)
         {
            this._x = param1;
            dispatchEvent(new Event("xChanged"));
         }
      }
      
      public function initialized(param1:Object, param2:String) : void
      {
         this.id = param2;
         if(!this.width && !this.percentWidth)
         {
            this.contentSize = true;
         }
      }
      
      public function setActualWidth(param1:Number) : void
      {
         if(this._width != param1)
         {
            this._width = param1;
            dispatchEvent(new Event("widthChanged"));
         }
      }
   }
}
