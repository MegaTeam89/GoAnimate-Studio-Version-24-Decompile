package anifire.products.character
{
   import anifire.constant.ServerConstants;
   import anifire.core.Action;
   import anifire.event.CoreEvent;
   import anifire.util.UtilHashArray;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.containers.Canvas;
   import mx.controls.Image;
   
   public class ActionThumbImage extends Canvas
   {
      
      private static var _images:UtilHashArray = new UtilHashArray();
       
      
      private const IMAGE_HEIGHT:Number = 38;
      
      private const IMAGE_WIDTH:Number = 38;
      
      public function ActionThumbImage()
      {
         super();
         this.width = this.IMAGE_WIDTH;
         this.height = this.IMAGE_HEIGHT;
      }
      
      public static function getImage(param1:Action) : ActionThumbImage
      {
         var _loc2_:ActionThumbImage = _images.getValueByKey(param1.aid) as ActionThumbImage;
         if(!_loc2_)
         {
            _loc2_ = new ActionThumbImage();
            _loc2_.action = param1;
            _images.push(param1.aid,_loc2_);
         }
         return _loc2_;
      }
      
      public function set action(param1:Action) : void
      {
         var _loc3_:Loader = null;
         var _loc4_:ByteArray = null;
         this.removeAllChildren();
         var _loc2_:Image = new Image();
         this.addChild(_loc2_);
         if(param1)
         {
            if(param1.imageData)
            {
               _loc3_ = new Loader();
               _loc2_.addChild(_loc3_);
               _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageReady);
               _loc4_ = param1.imageData as ByteArray;
               _loc3_.loadBytes(_loc4_);
            }
            else
            {
               param1.addEventListener(CoreEvent.LOAD_STATE_COMPLETE,this.onImageDataLoaded);
               param1.loadImageData(ServerConstants.PARAM_CHAR_ACTION);
            }
         }
      }
      
      private function onImageDataLoaded(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageDataLoaded);
         this.action = Action(param1.target);
      }
      
      private function onImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(Event.COMPLETE,this.onImageReady);
         var _loc2_:Number = Math.min(this.IMAGE_WIDTH / LoaderInfo(param1.target).loader.content.width,this.IMAGE_HEIGHT / LoaderInfo(param1.target).loader.content.height);
         LoaderInfo(param1.target).loader.content.width = LoaderInfo(param1.target).loader.content.width * _loc2_;
         LoaderInfo(param1.target).loader.content.height = LoaderInfo(param1.target).loader.content.height * _loc2_;
         var _loc3_:Rectangle = LoaderInfo(param1.target).loader.getBounds(this);
         LoaderInfo(param1.target).loader.x = this.IMAGE_WIDTH / 2 - _loc3_.x - _loc3_.width / 2;
         LoaderInfo(param1.target).loader.y = this.IMAGE_HEIGHT / 2 - _loc3_.y - _loc3_.height / 2;
      }
   }
}
