package anifire.assets.image
{
   import anifire.util.UtilPlain;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.core.UIComponent;
   
   public class AbstractAssetImage extends UIComponent
   {
       
      
      private var _origin:Point;
      
      private var _rect:Rectangle;
      
      public function AbstractAssetImage()
      {
         this._origin = new Point(100,0);
         this._rect = new Rectangle();
         super();
      }
      
      public function destroy(param1:String = "rip") : void
      {
      }
      
      protected function dispatchImageReady() : void
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function goToAndPause(param1:Number) : void
      {
         this.pause();
      }
      
      public function pause() : void
      {
         UtilPlain.gotoAndStopFamilyAt1(this);
      }
      
      public function resume() : void
      {
         UtilPlain.playFamily(this);
      }
      
      public function get rect() : Rectangle
      {
         return this._rect;
      }
   }
}
