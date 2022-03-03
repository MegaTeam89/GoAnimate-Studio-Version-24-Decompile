package anifire.interfaces
{
   import anifire.bubble.Bubble;
   import flash.display.DisplayObject;
   
   public interface IPlayerAssetView
   {
       
      
      function set bundle(param1:DisplayObject) : void;
      
      function get bundle() : DisplayObject;
      
      function get assetView() : DisplayObject;
      
      function set bubble(param1:Bubble) : void;
      
      function get bubble() : Bubble;
   }
}
