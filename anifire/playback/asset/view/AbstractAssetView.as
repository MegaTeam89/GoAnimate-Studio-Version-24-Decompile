package anifire.playback.asset.view
{
   import anifire.bubble.Bubble;
   import anifire.interfaces.IPlayerAssetView;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class AbstractAssetView extends MovieClip implements IPlayerAssetView
   {
       
      
      private var _bundle:DisplayObject;
      
      private var _bubble:Bubble;
      
      public function AbstractAssetView()
      {
         super();
      }
      
      public function set bundle(param1:DisplayObject) : void
      {
         this.addChild(param1);
         this._bundle = param1;
      }
      
      public function get bundle() : DisplayObject
      {
         return this._bundle;
      }
      
      public function get bubble() : Bubble
      {
         return this._bubble;
      }
      
      public function set bubble(param1:Bubble) : void
      {
         this._bubble = param1;
      }
      
      public function get assetView() : DisplayObject
      {
         return this;
      }
   }
}
