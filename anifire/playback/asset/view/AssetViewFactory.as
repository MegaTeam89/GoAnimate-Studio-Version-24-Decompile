package anifire.playback.asset.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IPlayerAssetView;
   import anifire.playback.asset.transition.model.AssetTransition;
   import anifire.playback.asset.transition.model.AssetTransitionCollection;
   import anifire.playback.asset.transition.view.AssetAppearTransitionView;
   import anifire.playback.asset.transition.view.AssetBlurTransitionView;
   import anifire.playback.asset.transition.view.AssetFlashEffSpriteTransitionView;
   import anifire.playback.asset.transition.view.AssetFlashEffTransitionView;
   import anifire.playback.asset.transition.view.AssetFlexTransitionView;
   import anifire.playback.asset.transition.view.AssetHandSlideTransitionView;
   import anifire.playback.asset.transition.view.AssetSlideTransitionView;
   import anifire.playback.asset.transition.view.AssetTransitionView;
   import anifire.playback.asset.transition.view.AssetZoomTransitionView;
   import flash.display.DisplayObject;
   
   public class AssetViewFactory
   {
       
      
      public function AssetViewFactory()
      {
         super();
      }
      
      public static function createAssetView(param1:AssetTransitionCollection) : DisplayObject
      {
         var _loc3_:AssetTransition = null;
         var _loc2_:IIterator = param1.iterator();
         var _loc4_:IPlayerAssetView = new AssetView();
         while(_loc2_.hasNext)
         {
            _loc3_ = _loc2_.next as AssetTransition;
            switch(_loc3_.type)
            {
               case AssetTransitionConstants.TYPE_APPEAR:
                  _loc4_ = new AssetAppearTransitionView(_loc4_);
                  break;
               case AssetTransitionConstants.TYPE_HANDSLIDE:
                  _loc4_ = new AssetHandSlideTransitionView(_loc4_);
                  break;
               case AssetTransitionConstants.TYPE_SLIDE:
                  _loc4_ = new AssetSlideTransitionView(_loc4_);
                  break;
               case AssetTransitionConstants.TYPE_BLUR:
                  _loc4_ = new AssetBlurTransitionView(_loc4_);
                  break;
               case AssetTransitionConstants.TYPE_ZOOM:
                  _loc4_ = new AssetZoomTransitionView(_loc4_);
                  break;
               case AssetTransitionConstants.TYPE_TEXT_3DCAMDEPTH:
               case AssetTransitionConstants.TYPE_TEXT_3DCAMFOCUS:
               case AssetTransitionConstants.TYPE_TEXT_3DCAMMATRIX:
               case AssetTransitionConstants.TYPE_TEXT_3DCAMXYZ:
               case AssetTransitionConstants.TYPE_TEXT_3DCAMXYZPIVOT:
               case AssetTransitionConstants.TYPE_TEXT_3DMOTION:
               case AssetTransitionConstants.TYPE_TEXT_ALPHA:
               case AssetTransitionConstants.TYPE_TEXT_BLUR + "_16":
               case AssetTransitionConstants.TYPE_TEXT_BLUR + "_26":
               case AssetTransitionConstants.TYPE_TEXT_BLUR + "_1":
               case AssetTransitionConstants.TYPE_TEXT_BLUR + "_20":
               case AssetTransitionConstants.TYPE_TEXT_BLURRYLIGHT:
               case AssetTransitionConstants.TYPE_TEXT_BUBBLES:
               case AssetTransitionConstants.TYPE_TEXT_BUBBLESCALE:
               case AssetTransitionConstants.TYPE_TEXT_CENTERSCALEDISSOLVE:
               case AssetTransitionConstants.TYPE_TEXT_CHAOTIC:
               case AssetTransitionConstants.TYPE_TEXT_CHASINGWORDS:
               case AssetTransitionConstants.TYPE_TEXT_CREATION:
               case AssetTransitionConstants.TYPE_TEXT_DYNAMICCURVE:
               case AssetTransitionConstants.TYPE_TEXT_ELASTICSCALE:
               case AssetTransitionConstants.TYPE_TEXT_EMERGE:
               case AssetTransitionConstants.TYPE_TEXT_FALLANDGLOW:
               case AssetTransitionConstants.TYPE_TEXT_FLIP:
               case AssetTransitionConstants.TYPE_TEXT_GLOW:
               case AssetTransitionConstants.TYPE_TEXT_GLOWNBURN:
               case AssetTransitionConstants.TYPE_TEXT_GLOWINGGROUP:
               case AssetTransitionConstants.TYPE_TEXT_HORIZONTALDISOLVE:
               case AssetTransitionConstants.TYPE_TEXT_HORIZONTALGROW:
               case AssetTransitionConstants.TYPE_TEXT_INDUSTRIAL:
               case AssetTransitionConstants.TYPE_TEXT_INDUSTRIAL2:
               case AssetTransitionConstants.TYPE_TEXT_JIGGY:
               case AssetTransitionConstants.TYPE_TEXT_LIGHTBEAM:
               case AssetTransitionConstants.TYPE_TEXT_LINEBENT:
               case AssetTransitionConstants.TYPE_TEXT_LINEBURNANDFLOW:
               case AssetTransitionConstants.TYPE_TEXT_MAGNETICWIND + "_9":
               case AssetTransitionConstants.TYPE_TEXT_MAGNETICWIND + "_14":
               case AssetTransitionConstants.TYPE_TEXT_NEONTUBES:
               case AssetTransitionConstants.TYPE_TEXT_SCRAMBLE:
               case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDE:
               case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDE + "_19_3":
               case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDE + "_19_4":
               case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDE + "_18":
               case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDEBLUR:
               case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDEGLOW:
               case AssetTransitionConstants.TYPE_TEXT_SLICE + "_1_v":
               case AssetTransitionConstants.TYPE_TEXT_SLICE + "_2_h":
               case AssetTransitionConstants.TYPE_TEXT_SLICE + "_1_h":
               case AssetTransitionConstants.TYPE_TEXT_SLIDEBOUNCE:
               case AssetTransitionConstants.TYPE_TEXT_SLOWSLIDE:
               case AssetTransitionConstants.TYPE_TEXT_SMARTSLIDE:
               case AssetTransitionConstants.TYPE_TEXT_SPINNINGGENIE:
               case AssetTransitionConstants.TYPE_TEXT_SPIRAL:
               case AssetTransitionConstants.TYPE_TEXT_SPIRALNO2:
               case AssetTransitionConstants.TYPE_TEXT_STATIONPANELS:
               case AssetTransitionConstants.TYPE_TEXT_TWILIGHT + "_d":
               case AssetTransitionConstants.TYPE_TEXT_TWILIGHT + "_n":
               case AssetTransitionConstants.TYPE_TEXT_VERTICALDISOLVE:
               case AssetTransitionConstants.TYPE_TEXT_VERTICALSTRIPES:
               case AssetTransitionConstants.TYPE_TEXT_WAVESMASK:
               case AssetTransitionConstants.TYPE_TEXT_WAVINGLINES:
               case AssetTransitionConstants.TYPE_TEXT_WIGILIGI:
               case AssetTransitionConstants.TYPE_TEXT_XYRESOLVE:
               case AssetTransitionConstants.TYPE_TEXT_XYSCALE + "_18":
               case AssetTransitionConstants.TYPE_TEXT_XYSCALE + "_24":
               case AssetTransitionConstants.TYPE_TEXT_XYSCALEBLUR:
                  _loc4_ = new AssetFlashEffTransitionView(_loc4_);
                  break;
               case AssetTransitionConstants.TYPE_SPRITE_BADTRAN:
               case AssetTransitionConstants.TYPE_SPRITE_BRIGHTSQ + "_11":
               case AssetTransitionConstants.TYPE_SPRITE_BRIGHTSQ + "_13":
               case AssetTransitionConstants.TYPE_SPRITE_DESERTILL:
               case AssetTransitionConstants.TYPE_SPRITE_INTERSTRIPES + "_1":
               case AssetTransitionConstants.TYPE_SPRITE_INTERSTRIPES + "_4":
               case AssetTransitionConstants.TYPE_SPRITE_LIGHTSTRIPES:
               case AssetTransitionConstants.TYPE_SPRITE_MYSTERY:
               case AssetTransitionConstants.TYPE_SPRITE_SCALE:
               case AssetTransitionConstants.TYPE_SPRITE_SPARKLE + "_1":
               case AssetTransitionConstants.TYPE_SPRITE_SPARKLE + "_4":
               case AssetTransitionConstants.TYPE_SPRITE_SQEXPLODE:
               case AssetTransitionConstants.TYPE_SPRITE_UNPACK + "_2":
               case AssetTransitionConstants.TYPE_SPRITE_UNPACK + "_1":
               case AssetTransitionConstants.TYPE_SPRITE_UNPACK + "_8":
               case AssetTransitionConstants.TYPE_SPRITE_ZOOMBLUR:
               case AssetTransitionConstants.TYPE_SPRITE_DISC:
                  _loc4_ = new AssetFlashEffSpriteTransitionView(_loc4_);
                  break;
               default:
                  _loc4_ = new AssetFlexTransitionView(_loc4_);
            }
            if(_loc4_ is AssetTransitionView)
            {
               AssetTransitionView(_loc4_).transition = _loc3_;
            }
         }
         return _loc4_ as DisplayObject;
      }
   }
}
