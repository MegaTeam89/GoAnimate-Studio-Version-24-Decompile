package anifire.assets.transition
{
   import anifire.util.UtilDict;
   import anifire.util.UtilUser;
   import com.jumpeye.flashEff2.core.interfaces.IFlashEffSymbol;
   import com.jumpeye.flashEff2.symbol.badTransmission.FESBadTransmission;
   import com.jumpeye.flashEff2.symbol.brightSquares.FESBrightSquares;
   import com.jumpeye.flashEff2.symbol.desertIllusion.FESDesertIllusion;
   import com.jumpeye.flashEff2.symbol.disc.FESDisc;
   import com.jumpeye.flashEff2.symbol.intersectingStripes.FESIntersectingStripes;
   import com.jumpeye.flashEff2.symbol.mystery.FESMystery;
   import com.jumpeye.flashEff2.symbol.scale.FESScale;
   import com.jumpeye.flashEff2.symbol.sparkle.FESSparkle;
   import com.jumpeye.flashEff2.symbol.squareEffect.FESSquareExplode;
   import com.jumpeye.flashEff2.symbol.stripes.FESLightStripes;
   import com.jumpeye.flashEff2.symbol.unpack.FESUnpack;
   import com.jumpeye.flashEff2.symbol.zoomBlur.FESZoomBlur;
   
   public class AssetTransitionConstants
   {
      
      public static const DIRECTION_IN:uint = 0;
      
      public static const DIRECTION_OUT:uint = 1;
      
      public static const SOUND_ON:uint = 0;
      
      public static const SOUND_OFF:uint = 1;
      
      public static const TYPE_APPEAR:String = "Appear";
      
      public static const TYPE_BLINDS:String = "Blinds";
      
      public static const TYPE_FADE:String = "Fade";
      
      public static const TYPE_FLY:String = "Fly";
      
      public static const TYPE_IRIS:String = "Iris";
      
      public static const TYPE_IRIS_CIRCLE:String = "IrisCircle";
      
      public static const TYPE_SLIDE:String = "Slide";
      
      public static const TYPE_HAND_DRAWN:String = "HandDrawn";
      
      public static const TYPE_HANDSLIDE:String = "HandSlide";
      
      public static const TYPE_PHOTO:String = "Photo";
      
      public static const TYPE_PIXELDISSOLVE:String = "PixelDissolve";
      
      public static const TYPE_ROTATE:String = "Rotate";
      
      public static const TYPE_SQUEEZE:String = "Squeeze";
      
      public static const TYPE_WIPE:String = "Wipe";
      
      public static const TYPE_ZOOM:String = "Zoom";
      
      public static const TYPE_BLUR:String = "Blur";
      
      public static const TYPE_TEXT_3DCAMDEPTH:String = "FET3DCamDepth";
      
      public static const TYPE_TEXT_3DCAMFOCUS:String = "FET3DCamFocus";
      
      public static const TYPE_TEXT_3DCAMMATRIX:String = "FET3DCamMatrix";
      
      public static const TYPE_TEXT_3DCAMXYZ:String = "FET3DCamXYZ";
      
      public static const TYPE_TEXT_3DCAMXYZPIVOT:String = "FET3DCamXYZPivot";
      
      public static const TYPE_TEXT_3DMOTION:String = "FET3DMotion";
      
      public static const TYPE_TEXT_ALPHA:String = "FETAlpha";
      
      public static const TYPE_TEXT_BLUR:String = "FETBlur";
      
      public static const TYPE_TEXT_BLURRYLIGHT:String = "FETBlurryLight";
      
      public static const TYPE_TEXT_BUBBLES:String = "FETBubbles";
      
      public static const TYPE_TEXT_BUBBLESCALE:String = "FETBubbleScale";
      
      public static const TYPE_TEXT_CENTERSCALEDISSOLVE:String = "FETCenterScaleDissolve";
      
      public static const TYPE_TEXT_CHAOTIC:String = "FETChaotic";
      
      public static const TYPE_TEXT_CHASINGWORDS:String = "FETChasingWords";
      
      public static const TYPE_TEXT_CREATION:String = "FETCreation";
      
      public static const TYPE_TEXT_DYNAMICCURVE:String = "FETDynamicCurve";
      
      public static const TYPE_TEXT_ELASTICSCALE:String = "FETElasticScale";
      
      public static const TYPE_TEXT_EMERGE:String = "FETEmerge";
      
      public static const TYPE_TEXT_FALLANDGLOW:String = "FETFallAndGlow";
      
      public static const TYPE_TEXT_FLIP:String = "FETFlip";
      
      public static const TYPE_TEXT_GLOW:String = "FETGlow";
      
      public static const TYPE_TEXT_GLOWNBURN:String = "FETGlowAndBurn";
      
      public static const TYPE_TEXT_GLOWINGGROUP:String = "FETGlowingGroup";
      
      public static const TYPE_TEXT_HORIZONTALDISOLVE:String = "FETHorizontalDisolve";
      
      public static const TYPE_TEXT_HORIZONTALGROW:String = "FETHorizontalGrow";
      
      public static const TYPE_TEXT_INDUSTRIAL:String = "FETIndustrial";
      
      public static const TYPE_TEXT_INDUSTRIAL2:String = "FETIndustrial2";
      
      public static const TYPE_TEXT_JIGGY:String = "FETJiggy";
      
      public static const TYPE_TEXT_LIGHTBEAM:String = "FETLightBeam";
      
      public static const TYPE_TEXT_LINEBENT:String = "FETLineBent";
      
      public static const TYPE_TEXT_LINEBURNANDFLOW:String = "FETLineBurnAndFlow";
      
      public static const TYPE_TEXT_MAGNETICWIND:String = "FETMagneticWind";
      
      public static const TYPE_TEXT_NEONTUBES:String = "FETNeonTubes";
      
      public static const TYPE_TEXT_SCRAMBLE:String = "FETScramble";
      
      public static const TYPE_TEXT_SCROLLSLIDE:String = "FETScrollSlide";
      
      public static const TYPE_TEXT_SCROLLSLIDEBLUR:String = "FETScrollSlideBlur";
      
      public static const TYPE_TEXT_SCROLLSLIDEGLOW:String = "FETScrollSlideGlow";
      
      public static const TYPE_TEXT_SLICE:String = "FETSlice";
      
      public static const TYPE_TEXT_SLIDEBOUNCE:String = "FETSlideBounce";
      
      public static const TYPE_TEXT_SLOWSLIDE:String = "FETSlowSlide";
      
      public static const TYPE_TEXT_SMARTSLIDE:String = "FETSmartSlide";
      
      public static const TYPE_TEXT_SPINNINGGENIE:String = "FETSpinningGenie";
      
      public static const TYPE_TEXT_SPIRAL:String = "FETSpiral";
      
      public static const TYPE_TEXT_SPIRALNO2:String = "FETSpiralNo2";
      
      public static const TYPE_TEXT_STATIONPANELS:String = "FETStationPanels";
      
      public static const TYPE_TEXT_TWILIGHT:String = "FETTwilight";
      
      public static const TYPE_TEXT_VERTICALDISOLVE:String = "FETVecticalDisolve";
      
      public static const TYPE_TEXT_VERTICALSTRIPES:String = "FETVecticalStripes";
      
      public static const TYPE_TEXT_WAVESMASK:String = "FETWavesMask";
      
      public static const TYPE_TEXT_WAVINGLINES:String = "FETWavingLines";
      
      public static const TYPE_TEXT_WIGILIGI:String = "FETWigiligi";
      
      public static const TYPE_TEXT_XYRESOLVE:String = "FETXYResolve";
      
      public static const TYPE_TEXT_XYSCALE:String = "FETXYScale";
      
      public static const TYPE_TEXT_XYSCALEBLUR:String = "FETXYScaleBlur";
      
      public static const TYPE_SPRITE_BADTRAN:String = "FESBadTransmission";
      
      public static const TYPE_SPRITE_BRIGHTSQ:String = "FESBrightSquares";
      
      public static const TYPE_SPRITE_DESERTILL:String = "FESDesertIllusion";
      
      public static const TYPE_SPRITE_INTERSTRIPES:String = "FESIntersectingStripes";
      
      public static const TYPE_SPRITE_LIGHTSTRIPES:String = "FESLightStripes";
      
      public static const TYPE_SPRITE_MYSTERY:String = "FESMystery";
      
      public static const TYPE_SPRITE_SCALE:String = "FESScale";
      
      public static const TYPE_SPRITE_SPARKLE:String = "FESSparkle";
      
      public static const TYPE_SPRITE_SQEXPLODE:String = "FESSquareExplode";
      
      public static const TYPE_SPRITE_UNPACK:String = "FESUnpack";
      
      public static const TYPE_SPRITE_ZOOMBLUR:String = "FESZoomBlur";
      
      public static const TYPE_SPRITE_DISC:String = "FESDisc";
      
      public static const TIMING_AFTER_PREVIOUS:uint = 0;
      
      public static const TIMING_AFTER_NARRATION:uint = 1;
      
      public static const TIMING_ON_START:uint = 2;
      
      public static const TIMING_WITH_PREVIOUS:uint = 3;
      
      public static const TIMING_BEFORE_NARRATION:uint = 4;
      
      public static const TIMING_WITH_NARRATION:uint = 5;
      
      public static const DEST_TL:uint = 1;
      
      public static const DEST_TOP:uint = 2;
      
      public static const DEST_TR:uint = 3;
      
      public static const DEST_LEFT:uint = 4;
      
      public static const DEST_CENTER:uint = 5;
      
      public static const DEST_RIGHT:uint = 6;
      
      public static const DEST_BL:uint = 7;
      
      public static const DEST_BOTTOM:uint = 8;
      
      public static const DEST_BR:uint = 9;
      
      public static const TAG_NAME_TRANSITION_SOUND:String = "aTranSound";
      
      public static const TAG_NAME_TRANSITION:String = "aTran";
      
      public static const TAG_NAME_TRANSITION_LIST:String = "aTranList";
      
      public static const TAG_NAME_TRANSITION_SETTING:String = "aTranSetting";
      
      private static var _types:Array;
      
      private static var _textTypes:Array;
      
      private static var _spriteTypes:Array;
      
      private static var _directions:Array;
      
      private static var _soundModes:Array;
      
      private static var _timings:Array;
      
      private static var _sections:Array;
      
      private static var _destinations:Array;
       
      
      public function AssetTransitionConstants()
      {
         super();
      }
      
      public static function get directions() : Array
      {
         if(_directions)
         {
            return _directions.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":DIRECTION_IN,
            "label":UtilDict.toDisplay("go","Enter")
         });
         _loc1_.push({
            "id":DIRECTION_OUT,
            "label":UtilDict.toDisplay("go","Exit")
         });
         _directions = _loc1_;
         return _loc1_;
      }
      
      public static function get soundModes() : Array
      {
         if(_soundModes)
         {
            return _soundModes.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":SOUND_ON,
            "label":UtilDict.toDisplay("go","ON")
         });
         _loc1_.push({
            "id":SOUND_OFF,
            "label":UtilDict.toDisplay("go","OFF")
         });
         _soundModes = _loc1_;
         return _loc1_;
      }
      
      public static function get timings() : Array
      {
         if(_timings)
         {
            return _timings.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":TIMING_AFTER_PREVIOUS,
            "label":UtilDict.toDisplay("go","after previous")
         });
         _loc1_.push({
            "id":TIMING_WITH_PREVIOUS,
            "label":UtilDict.toDisplay("go","with previous")
         });
         _timings = _loc1_;
         return _loc1_;
      }
      
      public static function get sections() : Array
      {
         if(_sections)
         {
            return _sections.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":TIMING_BEFORE_NARRATION,
            "label":UtilDict.toDisplay("go","before narration")
         });
         _loc1_.push({
            "id":TIMING_WITH_NARRATION,
            "label":UtilDict.toDisplay("go","with narration")
         });
         _loc1_.push({
            "id":TIMING_AFTER_NARRATION,
            "label":UtilDict.toDisplay("go","after narration")
         });
         _sections = _loc1_;
         return _loc1_;
      }
      
      public static function get destinations() : Array
      {
         if(_destinations)
         {
            return _destinations.concat();
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_TL,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_TOP,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_TR,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_LEFT,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_RIGHT,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_BL,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_BOTTOM,
            "label":""
         });
         _loc1_.push({
            "id":AssetTransitionConstants.DEST_BR,
            "label":""
         });
         _destinations = _loc1_;
         return _loc1_;
      }
      
      public static function getDestinationLabel(param1:uint) : String
      {
         var _loc2_:Array = AssetTransitionConstants.destinations;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         return "";
      }
      
      public static function getTimingLabel(param1:uint) : String
      {
         var _loc2_:Array = AssetTransitionConstants.timings;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         return "";
      }
      
      public static function getDirectionLabel(param1:uint) : String
      {
         var _loc2_:Array = AssetTransitionConstants.directions;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         return "";
      }
      
      public static function getTypeLabel(param1:String) : String
      {
         var _loc2_:Array = AssetTransitionConstants.types;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         _loc2_ = AssetTransitionConstants.textTypes;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         _loc2_ = AssetTransitionConstants.spriteTypes;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_].id)
            {
               return _loc2_[_loc3_].label;
            }
            _loc3_++;
         }
         return "";
      }
      
      public static function get types() : Array
      {
         if(_types)
         {
            return _types;
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":TYPE_APPEAR,
            "label":UtilDict.toDisplay("go","Instant")
         });
         _loc1_.push({
            "id":TYPE_BLINDS,
            "label":UtilDict.toDisplay("go",TYPE_BLINDS)
         });
         _loc1_.push({
            "id":TYPE_BLUR,
            "label":UtilDict.toDisplay("go",TYPE_BLUR)
         });
         _loc1_.push({
            "id":TYPE_FADE,
            "label":UtilDict.toDisplay("go",TYPE_FADE)
         });
         _loc1_.push({
            "id":TYPE_IRIS,
            "label":UtilDict.toDisplay("go","Iris - square")
         });
         _loc1_.push({
            "id":TYPE_IRIS_CIRCLE,
            "label":UtilDict.toDisplay("go","Iris - circle")
         });
         _loc1_.push({
            "id":TYPE_PHOTO,
            "label":UtilDict.toDisplay("go",TYPE_PHOTO)
         });
         _loc1_.push({
            "id":TYPE_PIXELDISSOLVE,
            "label":UtilDict.toDisplay("go",TYPE_PIXELDISSOLVE)
         });
         _loc1_.push({
            "id":TYPE_SLIDE,
            "label":UtilDict.toDisplay("go",TYPE_SLIDE)
         });
         _loc1_.push({
            "id":TYPE_HANDSLIDE,
            "label":UtilDict.toDisplay("go","Hand Slide")
         });
         _loc1_.push({
            "id":TYPE_WIPE,
            "label":UtilDict.toDisplay("go",TYPE_WIPE)
         });
         _types = _loc1_;
         return _loc1_;
      }
      
      public static function get textTypes() : Array
      {
         if(_textTypes)
         {
            return _textTypes;
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":TYPE_TEXT_BLUR + "_16",
            "label":UtilDict.toDisplay("go","Blur")
         });
         _loc1_.push({
            "id":TYPE_TEXT_BLUR + "_26",
            "label":UtilDict.toDisplay("go","Blur - lines")
         });
         _loc1_.push({
            "id":TYPE_TEXT_BLUR + "_1",
            "label":UtilDict.toDisplay("go","Blur - quick writing")
         });
         _loc1_.push({
            "id":TYPE_TEXT_BLUR + "_20",
            "label":UtilDict.toDisplay("go","Blur - lines falling")
         });
         _loc1_.push({
            "id":TYPE_TEXT_FLIP,
            "label":UtilDict.toDisplay("go","Flip - words")
         });
         _loc1_.push({
            "id":TYPE_TEXT_GLOWINGGROUP,
            "label":UtilDict.toDisplay("go","Glow - characters")
         });
         _loc1_.push({
            "id":TYPE_TEXT_MAGNETICWIND + "_9",
            "label":UtilDict.toDisplay("go","Magnetic wind")
         });
         _loc1_.push({
            "id":TYPE_TEXT_MAGNETICWIND + "_14",
            "label":UtilDict.toDisplay("go","Magentic wind - chaos")
         });
         _loc1_.push({
            "id":TYPE_TEXT_SCROLLSLIDE + "_19_3",
            "label":UtilDict.toDisplay("go","Slide - Lines to left")
         });
         _loc1_.push({
            "id":TYPE_TEXT_SCROLLSLIDE + "_19_4",
            "label":UtilDict.toDisplay("go","Slide - Lines to right")
         });
         _loc1_.push({
            "id":TYPE_TEXT_SCROLLSLIDE + "_18",
            "label":UtilDict.toDisplay("go","Slide - Words")
         });
         _loc1_.push({
            "id":TYPE_TEXT_STATIONPANELS,
            "label":UtilDict.toDisplay("go","Station panels - characters")
         });
         _loc1_.push({
            "id":TYPE_TEXT_VERTICALDISOLVE,
            "label":UtilDict.toDisplay("go","Glow - characters sliding")
         });
         _loc1_.push({
            "id":TYPE_TEXT_XYSCALE + "_18",
            "label":UtilDict.toDisplay("go","Flying - words")
         });
         _loc1_.push({
            "id":TYPE_TEXT_XYSCALE + "_24",
            "label":UtilDict.toDisplay("go","Bending - lines")
         });
         _textTypes = _loc1_;
         return _loc1_;
      }
      
      public static function get spriteTypes() : Array
      {
         if(_spriteTypes)
         {
            return _spriteTypes;
         }
         var _loc1_:Array = new Array();
         _loc1_.push({
            "id":TYPE_SPRITE_BRIGHTSQ + "_11",
            "label":UtilDict.toDisplay("go","Bright Squares")
         });
         if(UtilUser.hasAdminFeatures)
         {
            _loc1_.push({
               "id":TYPE_SPRITE_SCALE,
               "label":UtilDict.toDisplay("go","Pop")
            });
         }
         _loc1_.push({
            "id":TYPE_SPRITE_INTERSTRIPES + "_1",
            "label":UtilDict.toDisplay("go","Stripes - vertical")
         });
         _loc1_.push({
            "id":TYPE_SPRITE_INTERSTRIPES + "_4",
            "label":UtilDict.toDisplay("go","Stripes - horizontal")
         });
         _loc1_.push({
            "id":TYPE_SPRITE_LIGHTSTRIPES,
            "label":UtilDict.toDisplay("go","Stripes - blurry")
         });
         _loc1_.push({
            "id":TYPE_SPRITE_SPARKLE + "_1",
            "label":UtilDict.toDisplay("go","Sparkles - horizontal")
         });
         _loc1_.push({
            "id":TYPE_SPRITE_SPARKLE + "_4",
            "label":UtilDict.toDisplay("go","Sparkles - vertical")
         });
         _loc1_.push({
            "id":TYPE_SPRITE_UNPACK + "_2",
            "label":UtilDict.toDisplay("go","Split - Horizontal")
         });
         _loc1_.push({
            "id":TYPE_SPRITE_UNPACK + "_1",
            "label":UtilDict.toDisplay("go","Split - Vertical")
         });
         _loc1_.push({
            "id":TYPE_SPRITE_ZOOMBLUR,
            "label":UtilDict.toDisplay("go","Blur - zooming")
         });
         _loc1_.push({
            "id":TYPE_SPRITE_DISC,
            "label":UtilDict.toDisplay("go","Circular reveal")
         });
         _spriteTypes = _loc1_;
         return _loc1_;
      }
      
      public static function flashEffPlusParamById(param1:String, param2:uint = 0) : IFlashEffSymbol
      {
         var _loc3_:IFlashEffSymbol = null;
         switch(param1)
         {
            case AssetTransitionConstants.TYPE_SPRITE_BADTRAN:
               _loc3_ = new FESBadTransmission();
               FESBadTransmission(_loc3_).disturbance = 0;
               FESBadTransmission(_loc3_).maxNoise = 1;
               FESBadTransmission(_loc3_).tweenType = "Quadratic";
               FESBadTransmission(_loc3_).easeType = "easeOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_BRIGHTSQ + "_11":
               _loc3_ = new FESBrightSquares();
               FESBrightSquares(_loc3_).preset = 11;
               FESBrightSquares(_loc3_).squareWidth = 25;
               FESBrightSquares(_loc3_).squareHeight = 25;
               FESBrightSquares(_loc3_).scaleXAmount = 1;
               FESBrightSquares(_loc3_).scaleYAmount = 1;
               FESBrightSquares(_loc3_).brightness = 255;
               FESBrightSquares(_loc3_).hAlign = "left";
               FESBrightSquares(_loc3_).vAlign = "middle";
               FESBrightSquares(_loc3_).smooth = false;
               FESBrightSquares(_loc3_).groupDuration = 1.1;
               FESBrightSquares(_loc3_).tweenType = "Quadratic";
               FESBrightSquares(_loc3_).easeType = "easeInOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_BRIGHTSQ + "_13":
               _loc3_ = new FESBrightSquares();
               FESBrightSquares(_loc3_).preset = 13;
               FESBrightSquares(_loc3_).squareWidth = 25;
               FESBrightSquares(_loc3_).squareHeight = 25;
               FESBrightSquares(_loc3_).scaleXAmount = 1.2;
               FESBrightSquares(_loc3_).scaleYAmount = 1.2;
               FESBrightSquares(_loc3_).brightness = 255;
               FESBrightSquares(_loc3_).hAlign = "center";
               FESBrightSquares(_loc3_).vAlign = "middle";
               FESBrightSquares(_loc3_).smooth = false;
               FESBrightSquares(_loc3_).groupDuration = 0.8;
               FESBrightSquares(_loc3_).tweenType = "Quadratic";
               FESBrightSquares(_loc3_).easeType = "easeInOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_DESERTILL:
               _loc3_ = new FESDesertIllusion();
               FESDesertIllusion(_loc3_).waveSize = 80;
               FESDesertIllusion(_loc3_).wavesIntensity = 80;
               FESDesertIllusion(_loc3_).blurQuality = 1;
               FESDesertIllusion(_loc3_).smooth = true;
               FESDesertIllusion(_loc3_).tweenType = "Quadratic";
               FESDesertIllusion(_loc3_).easeType = "easeNone";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_INTERSTRIPES + "_1":
               _loc3_ = new FESIntersectingStripes();
               FESIntersectingStripes(_loc3_).preset = 1;
               FESIntersectingStripes(_loc3_).waveThickness = 10;
               FESIntersectingStripes(_loc3_).maxBlurX = 20;
               FESIntersectingStripes(_loc3_).maxBlurY = 20;
               FESIntersectingStripes(_loc3_).groupDuration = 1;
               FESIntersectingStripes(_loc3_).tweenType = "Bounce";
               FESIntersectingStripes(_loc3_).easeType = "easeOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_INTERSTRIPES + "_4":
               _loc3_ = new FESIntersectingStripes();
               FESIntersectingStripes(_loc3_).preset = 4;
               FESIntersectingStripes(_loc3_).waveThickness = 12;
               FESIntersectingStripes(_loc3_).maxBlurX = 30;
               FESIntersectingStripes(_loc3_).maxBlurY = 30;
               FESIntersectingStripes(_loc3_).groupDuration = 0.9;
               FESIntersectingStripes(_loc3_).tweenType = "Strong";
               FESIntersectingStripes(_loc3_).easeType = "easeInOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_LIGHTSTRIPES:
               _loc3_ = new FESLightStripes();
               FESLightStripes(_loc3_).preset = 1;
               FESLightStripes(_loc3_).stripeMaxThickness = 20;
               FESLightStripes(_loc3_).blurAmount = 150;
               FESLightStripes(_loc3_).alphaPercentage = 30;
               FESLightStripes(_loc3_).groupDuration = 0.7;
               FESLightStripes(_loc3_).tweenType = "Strong";
               FESLightStripes(_loc3_).easeType = "easeInOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_MYSTERY:
               _loc3_ = new FESMystery();
               FESMystery(_loc3_).preset = 1;
               FESMystery(_loc3_).amount = 5000;
               break;
            case AssetTransitionConstants.TYPE_SPRITE_SPARKLE + "_1":
               _loc3_ = new FESSparkle();
               FESSparkle(_loc3_).preset = 1;
               FESSparkle(_loc3_).maximumParticleSize = 5;
               FESSparkle(_loc3_).maximumParticleSpread = 60;
               FESSparkle(_loc3_).particleDiversity = 25;
               FESSparkle(_loc3_).particleEmissionInterval = 0.2;
               FESSparkle(_loc3_).particleTweenDuration = 0.5;
               FESSparkle(_loc3_).glowAmount = 10;
               FESSparkle(_loc3_).glowColor = 16777215;
               FESSparkle(_loc3_).emitterSize = 0;
               FESSparkle(_loc3_).tweenType = "Strong";
               FESSparkle(_loc3_).easeType = "easeInOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_SPARKLE + "_4":
               _loc3_ = new FESSparkle();
               FESSparkle(_loc3_).preset = 4;
               FESSparkle(_loc3_).maximumParticleSize = 7;
               FESSparkle(_loc3_).maximumParticleSpread = 150;
               FESSparkle(_loc3_).particleDiversity = 30;
               FESSparkle(_loc3_).particleEmissionInterval = 0.4;
               FESSparkle(_loc3_).particleTweenDuration = 1;
               FESSparkle(_loc3_).glowAmount = 10;
               FESSparkle(_loc3_).glowColor = 16777215;
               FESSparkle(_loc3_).emitterSize = 0;
               FESSparkle(_loc3_).tweenType = "Strong";
               FESSparkle(_loc3_).easeType = "easeInOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_SQEXPLODE:
               _loc3_ = new FESSquareExplode();
               FESSquareExplode(_loc3_).preset = 1;
               FESSquareExplode(_loc3_).squareWidth = FESSquareExplode(_loc3_).squareHeight = 20;
               FESSquareExplode(_loc3_).maxExplosionDistance = 200;
               FESSquareExplode(_loc3_).maxScale = 2;
               FESSquareExplode(_loc3_).groupDuration = 1;
               break;
            case AssetTransitionConstants.TYPE_SPRITE_UNPACK + "_2":
               _loc3_ = new FESUnpack();
               FESUnpack(_loc3_).preset = 2;
               FESUnpack(_loc3_).stepsNumber = 3;
               FESUnpack(_loc3_).focalLength = 60;
               FESUnpack(_loc3_).smooth = true;
               FESUnpack(_loc3_).easeType = "easeInOut";
               FESUnpack(_loc3_).tweenType = "Strong";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_UNPACK + "_1":
               _loc3_ = new FESUnpack();
               FESUnpack(_loc3_).preset = 1;
               FESUnpack(_loc3_).stepsNumber = 3;
               FESUnpack(_loc3_).focalLength = 60;
               FESUnpack(_loc3_).smooth = true;
               FESUnpack(_loc3_).easeType = "easeInOut";
               FESUnpack(_loc3_).tweenType = "Strong";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_UNPACK + "_8":
               _loc3_ = new FESUnpack();
               FESUnpack(_loc3_).preset = 8;
               FESUnpack(_loc3_).stepsNumber = 8;
               FESUnpack(_loc3_).focalLength = 60;
               FESUnpack(_loc3_).smooth = true;
               FESUnpack(_loc3_).easeType = "easeOut";
               FESUnpack(_loc3_).tweenType = "Quadratic";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_ZOOMBLUR:
               _loc3_ = new FESZoomBlur();
               FESZoomBlur(_loc3_).zoom = 1;
               FESZoomBlur(_loc3_).positionX = 50;
               FESZoomBlur(_loc3_).positionY = 50;
               FESZoomBlur(_loc3_).tweenType = "Quadratic";
               FESZoomBlur(_loc3_).easeType = "easeIn";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_DISC:
               _loc3_ = new FESDisc();
               FESDisc(_loc3_).startAngle = 0;
               FESDisc(_loc3_).rotateClockwise = true;
               FESDisc(_loc3_).tweenType = "Strong";
               FESDisc(_loc3_).easeType = "easeInOut";
               break;
            case AssetTransitionConstants.TYPE_SPRITE_SCALE:
               _loc3_ = new FESScale();
               FESScale(_loc3_).preset = 1;
               FESScale(_loc3_).tweenType = "Back";
               FESScale(_loc3_).maxBlur = 0;
               if(param2 == 1)
               {
                  FESScale(_loc3_).easeType = "easeIn";
               }
               else
               {
                  FESScale(_loc3_).easeType = "easeOut";
               }
               break;
            default:
               _loc3_ = new FESUnpack();
         }
         return _loc3_;
      }
   }
}
