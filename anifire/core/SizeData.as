package anifire.core
{
   import anifire.interfaces.IResizable;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SizeData extends EventDispatcher implements IResizable
   {
       
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      private var _originalWidth:Number = 0;
      
      private var _originalHeight:Number = 0;
      
      public function SizeData(param1:Number = 0, param2:Number = 0)
      {
         super();
         this._originalWidth = this._width = param1;
         this._originalHeight = this._height = param2;
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      public function get minWidth() : Number
      {
         return 0;
      }
      
      public function get minHeight() : Number
      {
         return 0;
      }
      
      public function get maxWidth() : Number
      {
         return 99999;
      }
      
      public function get maxHeight() : Number
      {
         return 99999;
      }
      
      public function set width(param1:Number) : void
      {
         this._width = param1;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function set height(param1:Number) : void
      {
         this._height = param1;
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function resize(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         if(param1 != this.width || param2 != this.height)
         {
            this.width = param1;
            this.height = param2;
         }
      }
   }
}
