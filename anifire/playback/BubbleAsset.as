package anifire.playback
{
   import anifire.assets.transition.AssetTransitionNode;
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleMgr;
   import anifire.constant.ServerConstants;
   import anifire.interfaces.IPlayback;
   import anifire.interfaces.IPlayerAssetView;
   import anifire.interfaces.IRegulatedProcess;
   import anifire.playback.asset.motion.IAssetMotion;
   import anifire.playback.asset.motion.MotionCache;
   import anifire.playback.asset.motion.SlideMotion;
   import anifire.util.Util;
   import anifire.util.UtilEffect;
   import anifire.util.UtilHashArray;
   import flash.display.BlendMode;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import mx.managers.CursorManager;
   
   public class BubbleAsset extends Asset implements IRegulatedProcess, IPlayback
   {
      
      private static const STATE_ACTION:int = 0;
      
      private static const STATE_MOTION:int = 1;
      
      private static const STATE_FADE:int = 2;
      
      private static const STATE_NULL:int = 3;
      
      public static const XML_TAG:String = "bubbleAsset";
       
      
      private var _centerPt:Point;
      
      private var _bubbleInNextScene:BubbleAsset;
      
      private var _bubbleInPrevScene:BubbleAsset;
      
      private var _isFirstBubble:Boolean;
      
      private var _firstBubble:BubbleAsset;
      
      private var _bubbleImage:Bubble;
      
      private var _type:String;
      
      private var _bubbleFx:Function;
      
      private var _fxDuration:Number = 12.0;
      
      private var _rotations:Array;
      
      private var _xscales:Array;
      
      private var _yscales:Array;
      
      private var _motion:IAssetMotion;
      
      private var _motionCache:MotionCache;
      
      public function BubbleAsset()
      {
         this._centerPt = new Point();
         this._rotations = [0];
         this._xscales = [1,1];
         this._yscales = [1,1];
         super();
      }
      
      public static function connectBubblesBetweenScenes(param1:UtilHashArray, param2:UtilHashArray) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BubbleAsset = null;
         var _loc6_:BubbleAsset = null;
         var _loc7_:Boolean = false;
         var _loc8_:UtilHashArray = null;
         if(param1 != null && param2 != null && param1.length > 0 && param2.length > 0)
         {
            _loc8_ = param2.clone();
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc5_ = param1.getValueByIndex(_loc3_) as BubbleAsset;
               _loc4_ = 0;
               while(_loc4_ < _loc8_.length)
               {
                  _loc6_ = _loc8_.getValueByIndex(_loc4_) as BubbleAsset;
                  if(BubbleMgr.isSameBubble(_loc5_._bubbleImage,_loc6_._bubbleImage))
                  {
                     if(new Point(_loc5_._x - _loc6_._x,_loc5_._y - _loc6_._y).length <= 1)
                     {
                        _loc5_._bubbleInNextScene = _loc6_;
                        _loc6_._bubbleInPrevScene = _loc5_;
                        _loc8_.remove(_loc4_,1);
                     }
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
         }
      }
      
      public static function isChanged(param1:BubbleAsset, param2:BubbleAsset) : Boolean
      {
         if(param1._x != param2._x || param1._y != param2._y)
         {
            return true;
         }
         return false;
      }
      
      override public function propagateSceneState(param1:int) : void
      {
         if(param1 == AnimeScene.STATE_ACTION)
         {
            this.setState(BubbleAsset.STATE_ACTION);
         }
         else if(param1 == AnimeScene.STATE_MOTION)
         {
            if(this._bubbleInNextScene == null)
            {
               this.setState(BubbleAsset.STATE_FADE);
            }
            else if(BubbleAsset.isChanged(this,this._bubbleInNextScene))
            {
               this.setState(BubbleAsset.STATE_MOTION);
            }
            else
            {
               this.setState(BubbleAsset.STATE_ACTION);
            }
         }
         else if(param1 == AnimeScene.STATE_NULL)
         {
            this.setState(BubbleAsset.STATE_NULL);
         }
      }
      
      override protected function setState(param1:int) : void
      {
         if(param1 != BubbleAsset.STATE_MOTION)
         {
            if(param1 == BubbleAsset.STATE_FADE)
            {
               if(this._state != BubbleAsset.STATE_ACTION)
               {
                  this.updateActionStaticProperty();
               }
            }
            else if(param1 == BubbleAsset.STATE_ACTION)
            {
               this.updateActionStaticProperty();
            }
         }
         super.setState(param1);
      }
      
      public function startProcess(param1:Boolean = false, param2:Number = 0) : void
      {
         this.initRemoteData();
      }
      
      public function initRemoteData() : void
      {
         this.setState(BubbleAsset.STATE_NULL);
         this.updateActionStaticProperty();
         this._bubbleImage.redraw();
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      public function initDependency() : void
      {
         this.initAssetDependency();
         if(this._bubbleInPrevScene == null)
         {
            this._isFirstBubble = true;
            this._firstBubble = this;
         }
         else
         {
            this._isFirstBubble = false;
            this._firstBubble = this._bubbleInPrevScene._firstBubble;
         }
      }
      
      public function init(param1:XML, param2:AnimeScene, param3:Number, param4:Boolean) : Boolean
      {
         var isInitSuccess:Boolean = false;
         var bubbleXML:XML = param1;
         var iParentScene:AnimeScene = param2;
         var mVer:Number = param3;
         var isPreview:Boolean = param4;
         super.initAsset(bubbleXML.@id,bubbleXML.@index,iParentScene);
         this._bundle.blendMode = BlendMode.LAYER;
         try
         {
            this._bubbleImage = BubbleMgr.getBubbleByXML(bubbleXML.child("bubble")[0],mVer);
            this._type = bubbleXML.child("bubble")[0].@type;
            isInitSuccess = true;
         }
         catch(e:Error)
         {
            isInitSuccess = false;
         }
         if(!isInitSuccess)
         {
            return false;
         }
         this._bubbleImage.autoResize = false;
         this._bubbleImage.useDeviceFont = true;
         this._bundle.addChild(this._bubbleImage);
         this._xs = String(bubbleXML["x"]).split(",");
         this._ys = String(bubbleXML["y"]).split(",");
         this._x = this._xs[0];
         this._y = this._ys[0];
         if(bubbleXML.hasOwnProperty("xscale"))
         {
            this._xscales = String(bubbleXML["xscale"]).split(",");
            this._yscales = String(bubbleXML["yscale"]).split(",");
         }
         if(bubbleXML.hasOwnProperty("rotation"))
         {
            this._rotations = String(bubbleXML["rotation"]).split(",");
         }
         if(_xs.length > 1)
         {
            this._motion = new SlideMotion();
            SlideMotion(this._motion).init(_xs,_ys,this._xscales,this._yscales,this._rotations);
            if(bubbleXML.hasOwnProperty(SlideMotion.XML_TAG_NAME))
            {
               SlideMotion(this._motion).convertFromXml(bubbleXML.child(SlideMotion.XML_TAG_NAME)[0]);
            }
            this._motionCache = new MotionCache(this._motion,iParentScene.totalFrame);
         }
         this._sttime = bubbleXML["st"];
         this._edtime = bubbleXML["et"];
         this._bubbleFx = UtilEffect.getEffectByName(bubbleXML["fx"]);
         if(bubbleXML["fxdur"].length() > 0)
         {
            this._fxDuration = bubbleXML["fxdur"];
         }
         else if(this.isTypeNoEffect(this._type))
         {
            this._fxDuration = -1;
         }
         if(this._sttime <= 1)
         {
            this._sttime = 0;
         }
         this.setState(BubbleAsset.STATE_NULL);
         this._bundle.alpha = 0;
         if(this._bubbleImage.textURL != "")
         {
            this._bubbleImage.buttonMode = true;
            this._bubbleImage.addEventListener(MouseEvent.ROLL_OVER,this.rollOverLink);
            this._bubbleImage.addEventListener(MouseEvent.ROLL_OUT,this.rollOutLink);
            this._bubbleImage.getLabel().addEventListener(MouseEvent.ROLL_OVER,this.rollOverLink);
            this._bubbleImage.getLabel().addEventListener(MouseEvent.ROLL_OUT,this.rollOutLink);
            if(!isPreview)
            {
               this._bubbleImage.addEventListener(MouseEvent.CLICK,this.redirect);
               this._bubbleImage.getLabel().addEventListener(MouseEvent.CLICK,this.redirect);
            }
         }
         this._centerPt.x = this._x + this._bubbleImage.x + this._bubbleImage.width / 2;
         this._centerPt.y = this._y + this._bubbleImage.y + this._bubbleImage.height / 2;
         return true;
      }
      
      private function rollOverLink(param1:Event) : void
      {
         this._bubbleImage.alpha = 0.8;
      }
      
      private function rollOutLink(param1:Event) : void
      {
         this._bubbleImage.alpha = 1;
      }
      
      private function redirect(param1:Event) : void
      {
         CursorManager.setBusyCursor();
         var _loc2_:String = this._bubbleImage.textURL;
         if(_loc2_.indexOf("http") != 0)
         {
            _loc2_ = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER) + _loc2_;
         }
         var _loc3_:String = "_top";
         if(this._bubbleImage.islinkNewWin)
         {
            _loc3_ = "_blank";
            CursorManager.removeBusyCursor();
         }
         navigateToURL(new URLRequest(_loc2_),_loc3_);
      }
      
      private function updateActionStaticProperty() : void
      {
         this._bundle.x = this._xs[0];
         this._bundle.y = this._ys[0];
         this._bundle.scaleX = this._xscales[0];
         this._bundle.scaleY = this._yscales[0];
         this._bundle.rotation = this._rotations[0];
         this._bundle.alpha = 1;
      }
      
      private function isTypeNoEffect(param1:String) : Boolean
      {
         return param1 == BubbleMgr.BLANK || param1 == BubbleMgr.BLANKTAIL;
      }
      
      public function playFrame(param1:uint, param2:uint) : void
      {
         this.updateProperties(param1,param2);
         if(this.assetView is IPlayback)
         {
            IPlayback(this.assetView).playFrame(param1,param2);
         }
      }
      
      private function updateProperties(param1:uint, param2:uint) : void
      {
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:Boolean = true;
         var _loc4_:Number = param1;
         var _loc5_:Number = (param1 - 1) / (param2 - 1);
         if(this._state == BubbleAsset.STATE_ACTION)
         {
            if(this._motion)
            {
               _loc6_ = this._motionCache.getPosition(param1);
               this._bundle.x = _loc6_.x;
               this._bundle.y = _loc6_.y;
               _loc6_ = this._motionCache.getScale(param1);
               this._bundle.scaleX = _loc6_.x;
               this._bundle.scaleY = _loc6_.y;
               this._bundle.rotation = this._motionCache.getRotation(param1);
            }
            else if(this._sttime == 0 && this._edtime == 0 || _loc4_ >= this._sttime && _loc4_ <= this._edtime)
            {
               if(_loc4_ <= this._fxDuration + this._sttime && this._isFirstBubble)
               {
                  _loc7_ = 0;
                  _loc8_ = 1;
                  if(!this._bubbleImage.textEmbed)
                  {
                     _loc7_ = 1;
                     _loc8_ = 0;
                  }
                  _loc9_ = this._bubbleFx(_loc4_ - this._sttime,_loc7_,_loc8_,this._fxDuration);
                  this._bundle.scaleX = _loc9_;
                  this._bundle.scaleY = _loc9_;
                  this._bundle.x = this._centerPt.x - (this._bubbleImage.width / 2 + this._bubbleImage.x) * _loc9_;
                  this._bundle.y = this._centerPt.y - (this._bubbleImage.height / 2 + this._bubbleImage.y) * _loc9_;
                  this._bundle.alpha = 1;
               }
               else
               {
                  this._bundle.scaleX = this._xscales[0];
                  this._bundle.scaleY = this._yscales[0];
                  this._bundle.x = this._centerPt.x - this._bubbleImage.width / 2 - this._bubbleImage.x;
                  this._bundle.y = this._centerPt.y - this._bubbleImage.height / 2 - this._bubbleImage.y;
                  this._bundle.alpha = 1;
                  if(this._bubbleImage.textEmbed)
                  {
                  }
               }
            }
            else
            {
               _loc3_ = false;
            }
         }
         else if(this._state == BubbleAsset.STATE_MOTION)
         {
            if(this._x != this._bubbleInNextScene._x)
            {
               this._bundle.x = this._x + (this._bubbleInNextScene._x - this._x) * _loc4_;
            }
            if(this._y != this._bubbleInNextScene._y)
            {
               this._bundle.y = this._y + (this._bubbleInNextScene._y - this._y) * _loc4_;
            }
         }
         else if(this._state == BubbleAsset.STATE_FADE)
         {
            this._bundle.alpha = 1 - _loc4_;
         }
         if(this._bundle.visible != _loc3_)
         {
            this._bundle.visible = _loc3_;
         }
      }
      
      override public function addTransition(param1:AssetTransitionNode) : void
      {
         super.addTransition(param1);
         if(assetView is IPlayerAssetView)
         {
            IPlayerAssetView(assetView).bubble = this._bubbleImage;
         }
      }
      
      override public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
      }
      
      override public function goToAndPauseReset() : void
      {
      }
      
      override public function resume() : void
      {
      }
      
      override public function pause() : void
      {
      }
   }
}
