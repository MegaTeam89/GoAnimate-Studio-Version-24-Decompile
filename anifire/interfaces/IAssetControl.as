package anifire.interfaces
{
   import flash.events.IEventDispatcher;
   import mx.core.UIComponent;
   
   public interface IAssetControl extends IDestroyable, IEventDispatcher
   {
       
      
      function get asset() : IEventDispatcher;
      
      function set asset(param1:IEventDispatcher) : void;
      
      function set drawingScale(param1:Number) : void;
      
      function get drawingScale() : Number;
      
      function get border() : UIComponent;
   }
}
