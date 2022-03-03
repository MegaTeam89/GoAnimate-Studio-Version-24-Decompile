package anifire.playback.asset.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.bubble.Bubble;
   import anifire.interfaces.IPlayerAssetView;
   import com.jumpeye.Events.FLASHEFFEvents;
   import com.jumpeye.flashEff2.core.interfaces.IFlashEffSymbolText;
   import com.jumpeye.flashEff2.text.alpha.FETAlpha;
   import com.jumpeye.flashEff2.text.blur.FETBlur;
   import com.jumpeye.flashEff2.text.blur.FETBlurryLight;
   import com.jumpeye.flashEff2.text.bubbleScale.FETBubbleScale;
   import com.jumpeye.flashEff2.text.bubbles.FETBubbles;
   import com.jumpeye.flashEff2.text.centerScaleDissolve.FETCenterScaleDissolve;
   import com.jumpeye.flashEff2.text.chaotic.FETChaotic;
   import com.jumpeye.flashEff2.text.chasingWords.FETChasingWords;
   import com.jumpeye.flashEff2.text.creation.FETCreation;
   import com.jumpeye.flashEff2.text.dynamicCurve.FETDynamicCurve;
   import com.jumpeye.flashEff2.text.elasticScale.FETElasticScale;
   import com.jumpeye.flashEff2.text.emerge.FETEmerge;
   import com.jumpeye.flashEff2.text.fallAndGlow.FETFallAndGlow;
   import com.jumpeye.flashEff2.text.fe3D.camDepth.FET3DCamDepth;
   import com.jumpeye.flashEff2.text.fe3D.camFocus.FET3DCamFocus;
   import com.jumpeye.flashEff2.text.fe3D.camMatrix.FET3DCamMatrix;
   import com.jumpeye.flashEff2.text.fe3D.camXYZ.FET3DCamXYZ;
   import com.jumpeye.flashEff2.text.fe3D.camXYZPivot.FET3DCamXYZPivot;
   import com.jumpeye.flashEff2.text.fe3D.motion.FET3DMotion;
   import com.jumpeye.flashEff2.text.flip.FETFlip;
   import com.jumpeye.flashEff2.text.glow.FETGlow;
   import com.jumpeye.flashEff2.text.glowAndBurn.FETGlowAndBurn;
   import com.jumpeye.flashEff2.text.glowingGroup.FETGlowingGroup;
   import com.jumpeye.flashEff2.text.horizontalDisolve.FETHorizontalDisolve;
   import com.jumpeye.flashEff2.text.horizontalGrow.FETHorizontalGrow;
   import com.jumpeye.flashEff2.text.industrial.FETIndustrial;
   import com.jumpeye.flashEff2.text.industrial.FETIndustrial2;
   import com.jumpeye.flashEff2.text.jiggy.FETJiggy;
   import com.jumpeye.flashEff2.text.lightBeam.FETLightBeam;
   import com.jumpeye.flashEff2.text.lineBent.FETLineBent;
   import com.jumpeye.flashEff2.text.lineBurnAndFlow.FETLineBurnAndFlow;
   import com.jumpeye.flashEff2.text.magneticWind.FETMagneticWind;
   import com.jumpeye.flashEff2.text.neonTubes.FETNeonTubes;
   import com.jumpeye.flashEff2.text.scramble.FETScramble;
   import com.jumpeye.flashEff2.text.scrollSlide.FETScrollSlide;
   import com.jumpeye.flashEff2.text.scrollSlide.FETScrollSlideBlur;
   import com.jumpeye.flashEff2.text.scrollSlide.FETScrollSlideGlow;
   import com.jumpeye.flashEff2.text.slice.FETSlice;
   import com.jumpeye.flashEff2.text.slideBounce.FETSlideBounce;
   import com.jumpeye.flashEff2.text.slowSlide.FETSlowSlide;
   import com.jumpeye.flashEff2.text.smartSlide.FETSmartSlide;
   import com.jumpeye.flashEff2.text.spinningGenie.FETSpinningGenie;
   import com.jumpeye.flashEff2.text.spiral.FETSpiral;
   import com.jumpeye.flashEff2.text.spiral.FETSpiralNo2;
   import com.jumpeye.flashEff2.text.stationPanels.FETStationPanels;
   import com.jumpeye.flashEff2.text.twilight.FETTwilight;
   import com.jumpeye.flashEff2.text.verticalDisolve.FETVerticalDisolve;
   import com.jumpeye.flashEff2.text.verticalStripes.FETVerticalStripes;
   import com.jumpeye.flashEff2.text.wavesMask.FETWavesMask;
   import com.jumpeye.flashEff2.text.wavingLines.FETWavingLines;
   import com.jumpeye.flashEff2.text.wigiligi.FETWigiligi;
   import com.jumpeye.flashEff2.text.xyResolve.FETXYResolve;
   import com.jumpeye.flashEff2.text.xyscale.FETXYScale;
   import com.jumpeye.flashEff2.text.xyscaleBlur.FETXYScaleBlur;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class AssetFlashEffTransitionView extends AssetTransitionView
   {
       
      
      private var _isTransitting:Boolean = false;
      
      private var myEffect:FlashEff2Flex;
      
      public function AssetFlashEffTransitionView(param1:IPlayerAssetView)
      {
         this.myEffect = new FlashEff2Flex();
         super(param1);
      }
      
      override public function playFrame(param1:uint, param2:uint) : void
      {
         var _loc3_:TextField = null;
         var _loc4_:IFlashEffSymbolText = null;
         var _loc5_:int = 0;
         super.playFrame(param1,param2);
         if(param1 == 1)
         {
            this._isTransitting = false;
         }
         if(param1 >= this.transition.startFrame + 1 && param1 <= this.transition.startFrame + 3)
         {
            if(!this._isTransitting)
            {
               this._isTransitting = true;
               if(this.bubble)
               {
                  _loc3_ = Bubble(this.bubble).getLabel();
                  if(!Bubble(this.bubble).contains(this.myEffect) && Bubble(this.bubble).textEmbed)
                  {
                     switch(this.transition.type)
                     {
                        case AssetTransitionConstants.TYPE_TEXT_3DCAMDEPTH:
                           _loc4_ = new FET3DCamDepth();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_3DCAMFOCUS:
                           _loc4_ = new FET3DCamFocus();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_3DCAMMATRIX:
                           _loc4_ = new FET3DCamMatrix();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_3DCAMXYZ:
                           _loc4_ = new FET3DCamXYZ();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_3DCAMXYZPIVOT:
                           _loc4_ = new FET3DCamXYZPivot();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_3DMOTION:
                           _loc4_ = new FET3DMotion();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_ALPHA:
                           _loc4_ = new FETAlpha();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_BLUR + "_16":
                           _loc4_ = new FETBlur();
                           FETBlur(_loc4_).preset = 16;
                           FETBlur(_loc4_).maxBlurX = 8;
                           FETBlur(_loc4_).maxBlurY = 8;
                           FETBlur(_loc4_).blurQuality = 2;
                           FETBlur(_loc4_).groupDuration = 1;
                           FETBlur(_loc4_).partialGroup = "letters";
                           FETBlur(_loc4_).partialPercent = 100;
                           FETBlur(_loc4_).partialBlurAmount = 0;
                           FETBlur(_loc4_).partialStart = 50;
                           FETBlur(_loc4_).tweenType = "Elastic";
                           FETBlur(_loc4_).easeType = "easeIn";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_BLUR + "_26":
                           _loc4_ = new FETBlur();
                           FETBlur(_loc4_).preset = 26;
                           FETBlur(_loc4_).maxBlurX = 10;
                           FETBlur(_loc4_).maxBlurY = 10;
                           FETBlur(_loc4_).blurQuality = 2;
                           FETBlur(_loc4_).groupDuration = 0.6;
                           FETBlur(_loc4_).partialGroup = "letters";
                           FETBlur(_loc4_).partialPercent = 100;
                           FETBlur(_loc4_).partialBlurAmount = 0;
                           FETBlur(_loc4_).partialStart = 50;
                           FETBlur(_loc4_).tweenType = "Strong";
                           FETBlur(_loc4_).easeType = "easeInOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_BLUR + "_1":
                           _loc4_ = new FETBlur();
                           FETBlur(_loc4_).preset = 1;
                           FETBlur(_loc4_).maxBlurX = 20;
                           FETBlur(_loc4_).maxBlurY = 10;
                           FETBlur(_loc4_).blurQuality = 2;
                           FETBlur(_loc4_).groupDuration = 0.2;
                           FETBlur(_loc4_).partialGroup = "letters";
                           FETBlur(_loc4_).partialPercent = 100;
                           FETBlur(_loc4_).partialBlurAmount = 0;
                           FETBlur(_loc4_).partialStart = 75;
                           FETBlur(_loc4_).tweenType = "Back";
                           FETBlur(_loc4_).easeType = "easeIn";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_BLUR + "_20":
                           _loc4_ = new FETBlur();
                           FETBlur(_loc4_).preset = 20;
                           FETBlur(_loc4_).maxBlurX = 4;
                           FETBlur(_loc4_).maxBlurY = 75;
                           FETBlur(_loc4_).blurQuality = 2;
                           FETBlur(_loc4_).groupDuration = 0.4;
                           FETBlur(_loc4_).partialGroup = "letters";
                           FETBlur(_loc4_).partialPercent = 100;
                           FETBlur(_loc4_).partialBlurAmount = 0;
                           FETBlur(_loc4_).partialStart = 50;
                           FETBlur(_loc4_).tweenType = "Bounce";
                           FETBlur(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_BLURRYLIGHT:
                           _loc4_ = new FETBlurryLight();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_BUBBLES:
                           _loc4_ = new FETBubbles();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_BUBBLESCALE:
                           _loc4_ = new FETBubbleScale();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_CENTERSCALEDISSOLVE:
                           _loc4_ = new FETCenterScaleDissolve();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_CHAOTIC:
                           _loc4_ = new FETChaotic();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_CHASINGWORDS:
                           _loc4_ = new FETChasingWords();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_CREATION:
                           _loc4_ = new FETCreation();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_DYNAMICCURVE:
                           _loc4_ = new FETDynamicCurve();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_ELASTICSCALE:
                           _loc4_ = new FETElasticScale();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_EMERGE:
                           _loc4_ = new FETEmerge();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_FALLANDGLOW:
                           _loc4_ = new FETFallAndGlow();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_FLIP:
                           _loc4_ = new FETFlip();
                           FETFlip(_loc4_).preset = 18;
                           FETFlip(_loc4_).focalDistance = 50;
                           FETFlip(_loc4_).axis = "up";
                           FETFlip(_loc4_).smooth = true;
                           FETFlip(_loc4_).alphaPercentage = 0;
                           FETFlip(_loc4_).blurAmount = 80;
                           FETFlip(_loc4_).blurQuality = 2;
                           FETFlip(_loc4_).groupDuration = 0.7;
                           FETFlip(_loc4_).partialGroup = "letters";
                           FETFlip(_loc4_).partialPercent = 100;
                           FETFlip(_loc4_).partialBlurAmount = 0;
                           FETFlip(_loc4_).partialStart = 50;
                           FETFlip(_loc4_).tweenType = "Back";
                           FETFlip(_loc4_).easeType = "easeIn";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_GLOW:
                           _loc4_ = new FETGlow();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_GLOWNBURN:
                           _loc4_ = new FETGlowAndBurn();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_GLOWINGGROUP:
                           _loc4_ = new FETGlowingGroup();
                           FETGlowingGroup(_loc4_).preset = 1;
                           FETGlowingGroup(_loc4_).glowAmount = 30;
                           FETGlowingGroup(_loc4_).groupSize = 1;
                           FETGlowingGroup(_loc4_).glowColor = 16777215;
                           FETGlowingGroup(_loc4_).maxBlur = 10;
                           FETGlowingGroup(_loc4_).groupDuration = 1;
                           FETGlowingGroup(_loc4_).partialGroup = "letters";
                           FETGlowingGroup(_loc4_).partialPercent = 100;
                           FETGlowingGroup(_loc4_).partialBlurAmount = 0;
                           FETGlowingGroup(_loc4_).partialStart = 50;
                           FETGlowingGroup(_loc4_).tweenType = "Strong";
                           FETGlowingGroup(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_HORIZONTALDISOLVE:
                           _loc4_ = new FETHorizontalDisolve();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_HORIZONTALGROW:
                           _loc4_ = new FETHorizontalGrow();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_INDUSTRIAL:
                           _loc4_ = new FETIndustrial();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_INDUSTRIAL2:
                           _loc4_ = new FETIndustrial2();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_JIGGY:
                           _loc4_ = new FETJiggy();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_LIGHTBEAM:
                           _loc4_ = new FETLightBeam();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_LINEBENT:
                           _loc4_ = new FETLineBent();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_LINEBURNANDFLOW:
                           _loc4_ = new FETLineBurnAndFlow();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_MAGNETICWIND + "_9":
                           _loc4_ = new FETMagneticWind();
                           FETMagneticWind(_loc4_).preset = 9;
                           FETMagneticWind(_loc4_).randomX = 80;
                           FETMagneticWind(_loc4_).randomY = 20;
                           FETMagneticWind(_loc4_).maxScaleAmount = 4;
                           FETMagneticWind(_loc4_).changeLetters = false;
                           FETMagneticWind(_loc4_).alphaPercentage = 50;
                           FETMagneticWind(_loc4_).groupDuration = 1;
                           FETMagneticWind(_loc4_).partialGroup = "letters";
                           FETMagneticWind(_loc4_).partialPercent = 100;
                           FETMagneticWind(_loc4_).partialBlurAmount = 0;
                           FETMagneticWind(_loc4_).partialStart = 50;
                           FETMagneticWind(_loc4_).tweenType = "Strong";
                           FETMagneticWind(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_MAGNETICWIND + "_14":
                           _loc4_ = new FETMagneticWind();
                           FETMagneticWind(_loc4_).preset = 14;
                           FETMagneticWind(_loc4_).randomX = 20;
                           FETMagneticWind(_loc4_).randomY = 40;
                           FETMagneticWind(_loc4_).maxScaleAmount = 4;
                           FETMagneticWind(_loc4_).changeLetters = true;
                           FETMagneticWind(_loc4_).alphaPercentage = 50;
                           FETMagneticWind(_loc4_).groupDuration = 0.8;
                           FETMagneticWind(_loc4_).partialGroup = "letters";
                           FETMagneticWind(_loc4_).partialPercent = 100;
                           FETMagneticWind(_loc4_).partialBlurAmount = 0;
                           FETMagneticWind(_loc4_).partialStart = 50;
                           FETMagneticWind(_loc4_).tweenType = "Strong";
                           FETMagneticWind(_loc4_).easeType = "easeIn";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_NEONTUBES:
                           _loc4_ = new FETNeonTubes();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SCRAMBLE:
                           _loc4_ = new FETScramble();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDE + "_19_3":
                           _loc4_ = new FETScrollSlide();
                           FETScrollSlide(_loc4_).preset = 19;
                           FETScrollSlide(_loc4_).startPosition = 3;
                           FETScrollSlide(_loc4_).alphaPercentage = 50;
                           FETScrollSlide(_loc4_).groupDuration = 0.8;
                           FETScrollSlide(_loc4_).partialGroup = "letters";
                           FETScrollSlide(_loc4_).partialPercent = 100;
                           FETScrollSlide(_loc4_).partialBlurAmount = 0;
                           FETScrollSlide(_loc4_).partialStart = 50;
                           FETScrollSlide(_loc4_).tweenType = "Strong";
                           FETScrollSlide(_loc4_).easeType = "easeIn";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDE + "_19_4":
                           _loc4_ = new FETScrollSlide();
                           FETScrollSlide(_loc4_).preset = 19;
                           FETScrollSlide(_loc4_).startPosition = 4;
                           FETScrollSlide(_loc4_).alphaPercentage = 50;
                           FETScrollSlide(_loc4_).groupDuration = 0.8;
                           FETScrollSlide(_loc4_).partialGroup = "letters";
                           FETScrollSlide(_loc4_).partialPercent = 100;
                           FETScrollSlide(_loc4_).partialBlurAmount = 0;
                           FETScrollSlide(_loc4_).partialStart = 50;
                           FETScrollSlide(_loc4_).tweenType = "Strong";
                           FETScrollSlide(_loc4_).easeType = "easeIn";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDE + "_18":
                           _loc4_ = new FETScrollSlide();
                           FETScrollSlide(_loc4_).preset = 18;
                           FETScrollSlide(_loc4_).startPosition = 2;
                           FETScrollSlide(_loc4_).alphaPercentage = 100;
                           FETScrollSlide(_loc4_).groupDuration = 0.6;
                           FETScrollSlide(_loc4_).partialGroup = "letters";
                           FETScrollSlide(_loc4_).partialPercent = 100;
                           FETScrollSlide(_loc4_).partialBlurAmount = 0;
                           FETScrollSlide(_loc4_).partialStart = 50;
                           FETScrollSlide(_loc4_).tweenType = "Strong";
                           FETScrollSlide(_loc4_).easeType = "easeInOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDEBLUR:
                           _loc4_ = new FETScrollSlideBlur();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SCROLLSLIDEGLOW:
                           _loc4_ = new FETScrollSlideGlow();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SLICE + "_1_v":
                           _loc4_ = new FETSlice();
                           FETSlice(_loc4_).preset = 1;
                           FETSlice(_loc4_).slices = 4;
                           FETSlice(_loc4_).direction = "v";
                           FETSlice(_loc4_).position = 200;
                           FETSlice(_loc4_).subGrupDuration = 0.6;
                           FETSlice(_loc4_).alphaPercentage = 100;
                           FETSlice(_loc4_).blurQuality = 2;
                           FETSlice(_loc4_).groupDuration = 1;
                           FETSlice(_loc4_).partialGroup = "letters";
                           FETSlice(_loc4_).partialPercent = 100;
                           FETSlice(_loc4_).partialBlurAmount = 0;
                           FETSlice(_loc4_).partialStart = 50;
                           FETSlice(_loc4_).tweenType = "Strong";
                           FETSlice(_loc4_).easeType = "easeInOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SLICE + "_2_h":
                           _loc4_ = new FETSlice();
                           FETSlice(_loc4_).preset = 2;
                           FETSlice(_loc4_).slices = 10;
                           FETSlice(_loc4_).direction = "h";
                           FETSlice(_loc4_).position = -200;
                           FETSlice(_loc4_).subGrupDuration = 0.6;
                           FETSlice(_loc4_).alphaPercentage = 100;
                           FETSlice(_loc4_).blurQuality = 2;
                           FETSlice(_loc4_).groupDuration = 0.6;
                           FETSlice(_loc4_).partialGroup = "letters";
                           FETSlice(_loc4_).partialPercent = 100;
                           FETSlice(_loc4_).partialBlurAmount = 0;
                           FETSlice(_loc4_).partialStart = 50;
                           FETSlice(_loc4_).tweenType = "Bounce";
                           FETSlice(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SLICE + "_1_h":
                           _loc4_ = new FETSlice();
                           FETSlice(_loc4_).preset = 1;
                           FETSlice(_loc4_).slices = 10;
                           FETSlice(_loc4_).direction = "h";
                           FETSlice(_loc4_).position = 200;
                           FETSlice(_loc4_).subGrupDuration = 0.6;
                           FETSlice(_loc4_).alphaPercentage = 100;
                           FETSlice(_loc4_).blurQuality = 2;
                           FETSlice(_loc4_).groupDuration = 0.6;
                           FETSlice(_loc4_).partialGroup = "letters";
                           FETSlice(_loc4_).partialPercent = 100;
                           FETSlice(_loc4_).partialBlurAmount = 0;
                           FETSlice(_loc4_).partialStart = 50;
                           FETSlice(_loc4_).tweenType = "Bounce";
                           FETSlice(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SLIDEBOUNCE:
                           _loc4_ = new FETSlideBounce();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SLOWSLIDE:
                           _loc4_ = new FETSlowSlide();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SMARTSLIDE:
                           _loc4_ = new FETSmartSlide();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SPINNINGGENIE:
                           _loc4_ = new FETSpinningGenie();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SPIRAL:
                           _loc4_ = new FETSpiral();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_SPIRALNO2:
                           _loc4_ = new FETSpiralNo2();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_STATIONPANELS:
                           _loc4_ = new FETStationPanels();
                           FETStationPanels(_loc4_).preset = 1;
                           FETStationPanels(_loc4_).blurAmount = 30;
                           FETStationPanels(_loc4_).groupDuration = 1;
                           FETStationPanels(_loc4_).partialGroup = "letters";
                           FETStationPanels(_loc4_).partialPercent = 100;
                           FETStationPanels(_loc4_).partialBlurAmount = 0;
                           FETStationPanels(_loc4_).partialStart = 50;
                           FETStationPanels(_loc4_).tweenType = "Quadratic";
                           FETStationPanels(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_TWILIGHT + "_d":
                           _loc4_ = new FETTwilight();
                           FETTwilight(_loc4_).offset = 0;
                           FETTwilight(_loc4_).scale = 0.5;
                           FETTwilight(_loc4_).lightColor = 16777215;
                           FETTwilight(_loc4_).glowAmount = 10;
                           FETTwilight(_loc4_).radius = 210;
                           FETTwilight(_loc4_).tweenType = "Strong";
                           FETTwilight(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_TWILIGHT + "_n":
                           _loc4_ = new FETTwilight();
                           FETTwilight(_loc4_).offset = 0;
                           FETTwilight(_loc4_).scale = 0.5;
                           FETTwilight(_loc4_).lightColor = 16777215;
                           FETTwilight(_loc4_).glowAmount = 10;
                           FETTwilight(_loc4_).radius = 210;
                           FETTwilight(_loc4_).tweenType = "Strong";
                           FETTwilight(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_VERTICALDISOLVE:
                           _loc4_ = new FETVerticalDisolve();
                           FETVerticalDisolve(_loc4_).glowAmount = 5;
                           FETVerticalDisolve(_loc4_).groupSize = 7;
                           FETVerticalDisolve(_loc4_).glowColor = 16777215;
                           FETVerticalDisolve(_loc4_).maxVerticalSpace = 50;
                           FETVerticalDisolve(_loc4_).translateDurationPercent = 70;
                           FETVerticalDisolve(_loc4_).groupDuration = 1;
                           FETVerticalDisolve(_loc4_).partialGroup = "letters";
                           FETVerticalDisolve(_loc4_).partialPercent = 100;
                           FETVerticalDisolve(_loc4_).partialBlurAmount = 0;
                           FETVerticalDisolve(_loc4_).partialStart = 50;
                           FETVerticalDisolve(_loc4_).tweenType = "Quadratic";
                           FETVerticalDisolve(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_VERTICALSTRIPES:
                           _loc4_ = new FETVerticalStripes();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_WAVESMASK:
                           _loc4_ = new FETWavesMask();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_WAVINGLINES:
                           _loc4_ = new FETWavingLines();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_WIGILIGI:
                           _loc4_ = new FETWigiligi();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_XYRESOLVE:
                           _loc4_ = new FETXYResolve();
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_XYSCALE + "_18":
                           _loc4_ = new FETXYScale();
                           FETXYScale(_loc4_).preset = 18;
                           FETXYScale(_loc4_).positionX = -10;
                           FETXYScale(_loc4_).positionY = 80;
                           FETXYScale(_loc4_).maxScale = 3;
                           FETXYScale(_loc4_).alphaPercentage = 90;
                           FETXYScale(_loc4_).groupDuration = 0.9;
                           FETXYScale(_loc4_).partialGroup = "letters";
                           FETXYScale(_loc4_).partialPercent = 100;
                           FETXYScale(_loc4_).partialBlurAmount = 0;
                           FETXYScale(_loc4_).partialStart = 50;
                           FETXYScale(_loc4_).tweenType = "Strong";
                           FETXYScale(_loc4_).easeType = "easeOut";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_XYSCALE + "_24":
                           _loc4_ = new FETXYScale();
                           FETXYScale(_loc4_).preset = 24;
                           FETXYScale(_loc4_).positionX = 50;
                           FETXYScale(_loc4_).positionY = 50;
                           FETXYScale(_loc4_).maxScale = 1;
                           FETXYScale(_loc4_).alphaPercentage = 50;
                           FETXYScale(_loc4_).groupDuration = 0.4;
                           FETXYScale(_loc4_).partialGroup = "letters";
                           FETXYScale(_loc4_).partialPercent = 100;
                           FETXYScale(_loc4_).partialBlurAmount = 0;
                           FETXYScale(_loc4_).partialStart = 50;
                           FETXYScale(_loc4_).tweenType = "Back";
                           FETXYScale(_loc4_).easeType = "easeIn";
                           break;
                        case AssetTransitionConstants.TYPE_TEXT_XYSCALEBLUR:
                           _loc4_ = new FETXYScaleBlur();
                           break;
                        default:
                           _loc4_ = new FETGlowAndBurn();
                     }
                     _loc4_.tweenDuration = this.transition.duration / 24;
                     _loc5_ = 0;
                     while(_loc5_ < Bubble(this.bubble).numChildren)
                     {
                        if(Bubble(this.bubble).getChildAt(_loc5_) is FlashEff2Flex)
                        {
                           Bubble(this.bubble).removeChildAt(_loc5_);
                        }
                        _loc5_++;
                     }
                     Bubble(this.bubble).addChild(this.myEffect);
                     if(this.transition.direction == 0)
                     {
                        this.myEffect.addEventListener(FLASHEFFEvents.TRANSITION_END,this.onTransitionsInDone);
                        this.myEffect.showDelay = 0;
                        this.myEffect.showTransition = _loc4_;
                     }
                     else if(this.transition.direction == 1)
                     {
                        this.myEffect.addEventListener(FLASHEFFEvents.TRANSITION_END,this.onTransitionsOutDone);
                        this.myEffect.hideDelay = 0;
                        this.myEffect.hideTransition = _loc4_;
                     }
                     this.myEffect.target = _loc3_;
                  }
               }
            }
            this.assetView.visible = true;
         }
      }
      
      private function onTransitionsInDone(param1:Event) : void
      {
         this.myEffect = new FlashEff2Flex();
         this._isTransitting = false;
      }
      
      private function onTransitionsOutDone(param1:Event) : void
      {
         this.myEffect = new FlashEff2Flex();
         this.assetView.visible = false;
         this._isTransitting = false;
      }
   }
}
