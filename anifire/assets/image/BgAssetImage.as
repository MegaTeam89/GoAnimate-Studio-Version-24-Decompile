package anifire.assets.image
{
   import anifire.constant.AnimeConstants;
   import anifire.core.Console;
   import anifire.interfaces.IAsset;
   import anifire.interfaces.IAssetImage;
   import anifire.interfaces.IColorable;
   import anifire.util.UtilArray;
   import anifire.util.UtilColor;
   import anifire.util.UtilCommonLoader;
   import anifire.util.UtilHashSelectedColor;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class BgAssetImage extends AbstractAssetImage implements IAssetImage, IColorable
   {
       
      
      private var _loader:Loader;
      
      public function BgAssetImage()
      {
         super();
      }
      
      public function set asset(param1:IAsset) : void
      {
         if(param1)
         {
            if(param1.imageData is ByteArray)
            {
               this._loader = new Loader();
               this.addChild(this._loader);
               this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageReady);
               this._loader.loadBytes(ByteArray(param1.imageData),UtilCommonLoader.externalLoaderContext);
            }
         }
      }
      
      private function onImageReady(param1:Event) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onImageReady);
         this.resizeImage(param1.target.loader);
         super.rect.width = AnimeConstants.SCREEN_WIDTH;
         super.rect.height = AnimeConstants.SCREEN_HEIGHT;
         dispatchImageReady();
      }
      
      private function resizeImage(param1:Loader) : void
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = Console.getConsole().screenMode == AnimeConstants.SCREEN_MODE_WIDE ? Number(0 + (AnimeConstants.SCREEN_HEIGHT - AnimeConstants.WIDE_SCREEN_HEIGHT) / 2) : Number(0);
         var _loc4_:Number = AnimeConstants.SCREEN_WIDTH;
         var _loc5_:Number = Console.getConsole().screenMode == AnimeConstants.SCREEN_MODE_WIDE ? Number(AnimeConstants.WIDE_SCREEN_HEIGHT) : Number(AnimeConstants.SCREEN_HEIGHT);
         var _loc6_:Rectangle = new Rectangle(_loc2_,_loc3_,_loc4_,_loc5_);
         param1.scrollRect = _loc6_;
         param1.y = _loc3_;
         if(param1.content.width == 1119 && param1.content.height == 720 || param1.content.width == 1679 && param1.content.height == 1080)
         {
            param1.content.width = AnimeConstants.SCREEN_WIDTH + 2;
            param1.content.height = AnimeConstants.SCREEN_HEIGHT + 2;
         }
      }
      
      public function changeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc3_:uint = 0;
         if(this._loader)
         {
            UtilColor.setAssetPartColor(this._loader,param1,param2);
         }
         return _loc3_;
      }
      
      public function restoreColor() : void
      {
         if(this._loader)
         {
            UtilColor.resetAssetPartsColor(this._loader);
         }
      }
      
      public function get customColor() : UtilHashSelectedColor
      {
         return new UtilHashSelectedColor();
      }
      
      public function get colorableArea() : Array
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:Array = new Array();
         if(this._loader)
         {
            _loc2_ = UtilPlain.getColorItem(this._loader);
            if(_loc2_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc4_ = DisplayObject(_loc2_[_loc3_]).name.split("_");
                  _loc1_.push(_loc4_[1]);
                  _loc3_++;
               }
               _loc1_ = UtilArray.removeDuplicates(_loc1_,true);
            }
         }
         return _loc1_;
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         super.destroy(param1);
         this._loader = null;
      }
   }
}
