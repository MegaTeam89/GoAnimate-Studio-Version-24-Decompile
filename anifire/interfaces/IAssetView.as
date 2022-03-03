package anifire.interfaces
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   
   public interface IAssetView extends IDestroyable, IEventDispatcher, IPlayable, IRegulatedProcess
   {
       
      
      function get asset() : IAsset;
      
      function get assetImage() : DisplayObject;
      
      function loadImage() : void;
   }
}
