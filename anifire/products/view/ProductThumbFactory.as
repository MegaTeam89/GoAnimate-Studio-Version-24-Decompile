package anifire.products.view
{
   import anifire.constant.AnimeConstants;
   import anifire.core.BackgroundThumb;
   import anifire.core.BubbleThumb;
   import anifire.core.CharThumb;
   import anifire.core.EffectThumb;
   import anifire.core.PropThumb;
   import anifire.core.SoundThumb;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductThumb;
   import anifire.util.UtilDict;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import mx.containers.Canvas;
   import mx.controls.Label;
   
   public class ProductThumbFactory extends EventDispatcher
   {
       
      
      public function ProductThumbFactory(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function createThumb(param1:IProduct) : IProductThumb
      {
         if(param1 is PropThumb)
         {
            return new PropProductThumb();
         }
         if(param1 is BackgroundThumb)
         {
            return new BgProductThumb();
         }
         if(param1 is CharThumb)
         {
            return new CharProductThumb();
         }
         if(param1 is EffectThumb)
         {
            return new EffectProductThumb();
         }
         if(param1 is BubbleThumb)
         {
            return new BubbleProductThumb();
         }
         if(param1 is SoundThumb)
         {
            return new SoundProductThumb();
         }
         return new ProductThumb();
      }
      
      public static function createLoadingThumb(param1:String) : Canvas
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(param1 == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc2_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
            _loc3_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            _loc4_ = "tileBackground";
            _loc5_ = 18;
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_TEMPLATE)
         {
            _loc2_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
            _loc3_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            _loc4_ = "tileBackground";
            _loc5_ = 18;
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            _loc2_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
            _loc3_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            _loc4_ = "tileBackground";
            _loc5_ = 18;
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc2_ = AnimeConstants.TILE_PROP_WIDTH;
            _loc3_ = AnimeConstants.TILE_PROP_HEIGHT;
            _loc4_ = "tileProp";
            _loc5_ = 10;
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_CHAR)
         {
            _loc2_ = AnimeConstants.TILE_CHAR_WIDTH;
            _loc3_ = AnimeConstants.TILE_CHAR_HEIGHT;
            _loc4_ = "tileChar";
            _loc5_ = 10;
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_FX)
         {
            _loc2_ = AnimeConstants.TILE_CHAR_WIDTH;
            _loc3_ = AnimeConstants.TILE_CHAR_HEIGHT;
            _loc4_ = "tileEffect";
            _loc5_ = 10;
         }
         var _loc6_:Canvas;
         (_loc6_ = new Canvas()).buttonMode = true;
         _loc6_.width = _loc2_;
         _loc6_.height = _loc3_;
         _loc6_.styleName = _loc4_;
         _loc6_.scrollRect = new Rectangle(0,0,_loc6_.width,_loc6_.height);
         _loc6_.name = "helperCanvas";
         var _loc7_:Label;
         (_loc7_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_loading");
         _loc7_.setStyle("fontWeight","bold");
         _loc7_.setStyle("fontSize",_loc5_);
         _loc6_.addChild(_loc7_);
         _loc7_.y = _loc6_.height / 2 - 10;
         return _loc6_;
      }
   }
}
