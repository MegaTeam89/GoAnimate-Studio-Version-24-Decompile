package anifire.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface IAssetImage extends IEventDispatcher, IDestroyable, IPlayable
   {
       
      
      function set asset(param1:IAsset) : void;
      
      function get rect() : Rectangle;
   }
}
