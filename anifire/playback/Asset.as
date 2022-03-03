package anifire.playback
{
   import anifire.assets.transition.AssetTransitionNode;
   import anifire.color.SelectedColor;
   import anifire.interfaces.IPlayerAssetView;
   import anifire.playback.asset.transition.model.AssetTransitionCollection;
   import anifire.playback.asset.transition.model.AssetTransitionFactory;
   import anifire.playback.asset.view.AssetView;
   import anifire.playback.asset.view.AssetViewFactory;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilHashSelectedColor;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   
   public class Asset implements IEventDispatcher
   {
       
      
      private var _id:String;
      
      private var _parentScene:AnimeScene;
      
      private var _data:ByteArray;
      
      protected var _bundle:DisplayObjectContainer;
      
      protected var _x:Number = 47;
      
      protected var _xs:Array;
      
      protected var _y:Number = 24;
      
      protected var _ys:Array;
      
      protected var _state:int;
      
      protected var _sttime:Number;
      
      protected var _edtime:Number;
      
      protected var _stzoom:Number;
      
      protected var _edzoom:Number;
      
      private var _zOrder:int;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _sound:Sound;
      
      private var _soundChannel:SoundChannel;
      
      private var _customColor:UtilHashSelectedColor;
      
      protected var _dataStock:PlayerDataStock;
      
      private var _raceCode:int = 0;
      
      private var _assetView:DisplayObject;
      
      private var _transitions:AssetTransitionCollection;
      
      public var isPlaying:Boolean = false;
      
      private var _currSoundPos:Number = 0;
      
      public function Asset()
      {
         this._xs = new Array();
         this._ys = new Array();
         this._eventDispatcher = new EventDispatcher();
         this._transitions = new AssetTransitionCollection();
         super();
      }
      
      public static function reArrangeZorder(param1:Array) : void
      {
         var curAsset:Asset = null;
         var assets:Array = param1;
         var compareZorder:Function = function(param1:Asset, param2:Asset):int
         {
            if(param1.getZorder() < param2.getZorder())
            {
               return -1;
            }
            if(param1.getZorder() > param2.getZorder())
            {
               return 1;
            }
            return 0;
         };
         assets.sort(compareZorder);
         var i:int = 0;
         while(i < assets.length)
         {
            curAsset = assets[i] as Asset;
            curAsset.setZorder(i);
            i++;
         }
      }
      
      public function get assetView() : DisplayObject
      {
         return this._assetView;
      }
      
      public function get raceCode() : int
      {
         return this._raceCode;
      }
      
      public function set raceCode(param1:int) : void
      {
         this._raceCode = param1;
      }
      
      public function addCustomColor(param1:String, param2:SelectedColor) : void
      {
         this._customColor.push(param1,param2);
      }
      
      public function get customColor() : UtilHashSelectedColor
      {
         return this._customColor;
      }
      
      public function set customColor(param1:UtilHashSelectedColor) : void
      {
         this._customColor = param1;
      }
      
      public function set stzoom(param1:Number) : void
      {
         this._stzoom = param1;
      }
      
      public function get stzoom() : Number
      {
         return this._stzoom;
      }
      
      public function set edzoom(param1:Number) : void
      {
         this._edzoom = param1;
      }
      
      public function get edzoom() : Number
      {
         return this._edzoom;
      }
      
      public function set sttime(param1:Number) : void
      {
         this._sttime = param1;
      }
      
      public function get sttime() : Number
      {
         return this._sttime;
      }
      
      public function set edtime(param1:Number) : void
      {
         this._edtime = param1;
      }
      
      public function get edtime() : Number
      {
         return this._edtime;
      }
      
      public function set sound(param1:Sound) : void
      {
         this._sound = param1;
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      public function get soundChannel() : SoundChannel
      {
         return this._soundChannel;
      }
      
      public function set soundChannel(param1:SoundChannel) : void
      {
         this._soundChannel = param1;
      }
      
      public function playMusic(param1:Number = 0, param2:int = 0, param3:SoundTransform = null) : void
      {
         var _loc4_:String = null;
         if(this.isPlaying == false)
         {
            if(this.sound != null)
            {
               if(param1 == this.sound.length || param1 < 0)
               {
                  param1 = 0;
               }
               if(this is Character)
               {
                  if((this as Character).state == 1)
                  {
                     _loc4_ = "action";
                  }
                  else if((this as Character).state == 2)
                  {
                     _loc4_ = "motion";
                  }
               }
               this.isPlaying = true;
               this.soundChannel = this.sound.play(param1,param2,param3);
               if(!this.soundChannel.hasEventListener(Event.SOUND_COMPLETE))
               {
                  this.soundChannel.addEventListener(Event.SOUND_COMPLETE,this.repeatMusic);
               }
            }
         }
      }
      
      private function repeatMusic(param1:Event) : void
      {
         if(this.soundChannel.hasEventListener(Event.SOUND_COMPLETE))
         {
            this.isPlaying = false;
            this.soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.repeatMusic);
            this.playMusic(0,0,this.soundChannel.soundTransform);
         }
      }
      
      public function set currSoundPos(param1:Number) : void
      {
         this._currSoundPos = param1;
      }
      
      public function get currSoundPos() : Number
      {
         return this._currSoundPos;
      }
      
      public function stopMusic(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         if(this.soundChannel != null)
         {
            if(this.soundChannel.hasEventListener(Event.SOUND_COMPLETE))
            {
               this.soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.repeatMusic);
            }
            this.soundChannel.stop();
            if(this is Character)
            {
               if((this as Character).state == 1)
               {
                  _loc2_ = "action";
               }
               else if((this as Character).state == 2)
               {
                  _loc2_ = "motion";
               }
            }
            this.isPlaying = false;
         }
         if(param1)
         {
            this.currSoundPos = 0;
            this.sound = null;
            this.soundChannel = null;
         }
      }
      
      public function getEventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get parentScene() : AnimeScene
      {
         return this._parentScene;
      }
      
      public function set parentScene(param1:AnimeScene) : void
      {
         this._parentScene = param1;
      }
      
      public function get data() : ByteArray
      {
         return this._data;
      }
      
      public function set data(param1:ByteArray) : void
      {
         this._data = param1;
      }
      
      public function getBundle() : DisplayObjectContainer
      {
         return this._bundle;
      }
      
      protected function setBundle(param1:DisplayObjectContainer) : void
      {
         this._bundle = param1;
      }
      
      protected function setState(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:UtilHashArray = null;
         var _loc4_:SelectedColor = null;
         this._state = param1;
         if(this.customColor != null && param1 != Character.STATE_NULL && param1 != Background.STATE_NULL)
         {
            _loc3_ = new UtilHashArray();
            _loc2_ = 0;
            while(_loc2_ < this.customColor.length)
            {
               _loc4_ = SelectedColor(this.customColor.getValueByIndex(_loc2_));
               UtilColor.setAssetPartColor(this._bundle,_loc4_.areaName,_loc4_.dstColor);
               _loc2_++;
            }
         }
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function getZorder() : int
      {
         return this._zOrder;
      }
      
      private function setZorder(param1:int) : void
      {
         this._zOrder = param1;
      }
      
      public function addTransition(param1:AssetTransitionNode) : void
      {
         this._transitions.add(AssetTransitionFactory.createTransition(param1));
         this._assetView = AssetViewFactory.createAssetView(this._transitions);
         if(this._assetView is IPlayerAssetView)
         {
            IPlayerAssetView(this._assetView).bundle = this._bundle;
         }
      }
      
      protected function initAsset(param1:String, param2:int, param3:AnimeScene) : void
      {
         this.id = param1;
         this.setZorder(param2);
         this.parentScene = param3;
         this._bundle = new Sprite();
         this._assetView = new AssetView();
         AssetView(this._assetView).bundle = this._bundle;
      }
      
      protected function initAssetDependency() : void
      {
         this._bundle.x = this._xs[0];
         this._bundle.y = this._ys[0];
      }
      
      public function propagateSceneState(param1:int) : void
      {
      }
      
      public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         PlayerConstant.goToAndStopFamily(this.getBundle(),param1);
      }
      
      public function goToAndPauseReset() : void
      {
         PlayerConstant.goToAndStopFamilyAt1(this.getBundle());
      }
      
      public function pause() : void
      {
         PlayerConstant.stopFamily(this.getBundle());
      }
      
      public function resume() : void
      {
         PlayerConstant.playFamily(this.getBundle());
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         this.pause();
         if(param1)
         {
            this.setBundle(null);
         }
      }
      
      public function setVolume(param1:Number) : void
      {
      }
      
      public function get x() : Number
      {
         return this._xs[0];
      }
      
      public function get y() : Number
      {
         return this._ys[0];
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
   }
}
