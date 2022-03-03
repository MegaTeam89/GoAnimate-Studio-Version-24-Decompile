package anifire.interfaces
{
   import flash.events.IEventDispatcher;
   
   public interface IAsset extends IEventDispatcher
   {
       
      
      function get id() : String;
      
      function set thumb(param1:IThumb) : void;
      
      function set action(param1:IBehavior) : void;
      
      function set scaleX(param1:Number) : void;
      
      function set scaleY(param1:Number) : void;
      
      function get thumb() : IThumb;
      
      function get imageData() : Object;
   }
}
