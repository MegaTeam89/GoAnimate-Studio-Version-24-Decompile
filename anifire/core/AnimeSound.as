package anifire.core
{
   import anifire.command.ChangeSoundLengthCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveSoundCommand;
   import anifire.component.GoAlert;
   import anifire.constant.AnimeConstants;
   import anifire.core.sound.ISoundable;
   import anifire.core.sound.SoundPlaybackManager;
   import anifire.core.sound.StudioSoundFactory;
   import anifire.core.sound.StudioSoundManager;
   import anifire.errors.SerializeError;
   import anifire.managers.StudioDragManager;
   import anifire.managers.ThemeManager;
   import anifire.timeline.ElementInfo;
   import anifire.timeline.SoundContainer;
   import anifire.timeline.SoundTrackArea;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilXmlInfo;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.containers.Canvas;
   import mx.core.DragSource;
   import mx.core.IUIComponent;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.events.MenuEvent;
   import mx.managers.DragManager;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class AnimeSound
   {
      
      public static const DRAG_DATA_FORMAT:String = "AnimeSound";
      
      private static var _existIDs:UtilHashArray = new UtilHashArray();
      
      public static const XML_NODE_NAME:String = "sound";
      
      private static const MENU_LABEL_PLAY:String = "playat:";
      
      private static const MENU_LABEL_PLAY_SOUND:String = "timeline_playsound";
      
      private static const MENU_LABEL_STOP_SOUND:String = "timeline_stopsound";
      
      private static const MENU_LABEL_CLEAR_MARKER:String = "timeline_clearmarker";
      
      private static const MENU_LABEL_REMOVE_SOUND:String = "timeline_removesound";
      
      private static const ACTION_DUPLICATE_SOUND:String = "ACTION_DUPLICATE_SOUND";
      
      private static const MENU_LABEL_SOUND_LENGTH:String = "timeline_duration";
      
      private static const MENU_LABEL_SOUND_LENGTH_1:String = "timeline_1sc";
      
      private static const MENU_LABEL_SOUND_LENGTH_2:String = "timeline_2sc";
      
      private static const MENU_LABEL_SOUND_LENGTH_5:String = "timeline_5sc";
      
      private static const MENU_LABEL_SOUND_LENGTH_10:String = "timeline_10sc";
      
      private static const MENU_LABEL_SOUND_LENGTH_20:String = "timeline_20sc";
      
      private static const MENU_LABEL_SOUND_LENGTH_30:String = "timeline_30sc";
      
      private static const MENU_LABEL_SOUND_LENGTH_FULL:String = "timeline_allsc";
      
      private static const MENU_LABEL_SOUND_LENGTH_RESET:String = "timeline_reset";
      
      private static const MENU_LABEL_SOUND_VOLUME:String = "timeline_volume";
      
      private static const MENU_LABEL_SOUND_VOLUME_0:String = "0%";
      
      private static const MENU_LABEL_SOUND_VOLUME_10:String = "10%";
      
      private static const MENU_LABEL_SOUND_VOLUME_25:String = "25%";
      
      private static const MENU_LABEL_SOUND_VOLUME_50:String = "50%";
      
      private static const MENU_LABEL_SOUND_VOLUME_75:String = "75%";
      
      private static const MENU_LABEL_SOUND_VOLUME_100:String = "100%";
      
      private static const MENU_LABEL_SOUND_VOLUME_200:String = "200%";
      
      private static const MENU_LABEL_SOUND_VOLUME_300:String = "300%";
      
      private static const MENU_LABEL_SOUND_VOLUME_400:String = "400%";
      
      private static const MENU_LABEL_SOUND_VOLUME_800:String = "800%";
       
      
      private var _soundThumb:SoundThumb;
      
      private var _sound:ISoundable;
      
      private var _id:String;
      
      private var _startFrame:Number;
      
      private var _totalFrame:Number;
      
      private var _trackNum:Number;
      
      private var _soundContainer:SoundContainer;
      
      private var _inner_volume:Number = 1;
      
      public function AnimeSound()
      {
         super();
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc8_:ByteArray = null;
         var _loc9_:UtilCrypto = null;
         var _loc3_:UtilHashArray = new UtilHashArray();
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfSound(param1["sfile"]);
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc6_:ThemeTree = new ThemeTree(_loc5_);
         var _loc7_:ZipEntry;
         if((_loc7_ = param2.getEntry(_loc4_)) != null)
         {
            _loc8_ = param2.getInput(_loc7_);
            if(_loc5_ != "ugc")
            {
               (_loc9_ = new UtilCrypto()).decrypt(_loc8_);
            }
         }
         else
         {
            _loc8_ = new ByteArray();
         }
         _loc6_.addSoundThumbId(UtilXmlInfo.getThumbIdFromFileName(_loc4_),_loc8_);
         _loc3_.push(_loc5_,_loc6_);
         return _loc3_;
      }
      
      private function get index() : int
      {
         var _loc1_:int = Console.getConsole().timeline.getSoundIndexById(this.getID());
         if(_loc1_ == -1)
         {
            _loc1_ = Console.getConsole().speechManager.ttsManager.sounds.getIndex(this.getID());
         }
         return _loc1_;
      }
      
      public function getID() : String
      {
         return this._id;
      }
      
      private function setID(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get startFrame() : Number
      {
         return this._startFrame;
      }
      
      public function set startFrame(param1:Number) : void
      {
         param1 = StudioSoundManager.validateStartFrame(param1);
         if(this._startFrame != param1)
         {
            this._startFrame = param1;
         }
      }
      
      public function get endFrame() : Number
      {
         return this._startFrame + this._totalFrame - 1;
      }
      
      public function set endFrame(param1:Number) : void
      {
         if(param1 >= this.startFrame)
         {
            this.totalFrame = param1 - this.startFrame + 1;
         }
      }
      
      public function get totalFrame() : Number
      {
         return this._totalFrame;
      }
      
      public function set totalFrame(param1:Number) : void
      {
         if(this._totalFrame != param1)
         {
            this._totalFrame = param1;
         }
      }
      
      private function getSoundThumb() : SoundThumb
      {
         return this._soundThumb;
      }
      
      private function setSoundThumb(param1:SoundThumb) : void
      {
         this._soundThumb = param1;
      }
      
      public function getLabel() : String
      {
         return this.getSoundThumb().name;
      }
      
      private function get sound() : ISoundable
      {
         return this._sound;
      }
      
      private function set sound(param1:ISoundable) : void
      {
         this._sound = param1;
      }
      
      public function get trackNum() : Number
      {
         return this._trackNum;
      }
      
      public function set trackNum(param1:Number) : void
      {
         this._trackNum = param1;
      }
      
      public function get inner_volume() : Number
      {
         return this._inner_volume;
      }
      
      public function set inner_volume(param1:Number) : void
      {
         this._inner_volume = param1;
      }
      
      public function set soundContainer(param1:SoundContainer) : void
      {
         this._soundContainer = param1;
      }
      
      public function get soundContainer() : SoundContainer
      {
         return this._soundContainer;
      }
      
      public function get soundThumb() : SoundThumb
      {
         return this._soundThumb;
      }
      
      public function playSound(param1:Number = 0) : void
      {
         SoundPlaybackManager.playSoundThumb(this._soundThumb,param1,this.soundContainer,this.inner_volume);
      }
      
      public function stopSound() : void
      {
         SoundPlaybackManager.stop();
      }
      
      public function init(param1:SoundThumb, param2:Number, param3:Number, param4:String = null, param5:Number = 0, param6:Number = 1, param7:Number = 0) : void
      {
         var _loc9_:int = 0;
         this.setSoundThumb(param1);
         var _loc8_:String = param4 != null ? param4 : "SOUND" + AnimeSound._existIDs.length;
         if(param4 == null)
         {
            _loc9_ = AnimeSound._existIDs.length + 1;
            while(AnimeSound._existIDs.containsKey(_loc8_))
            {
               _loc8_ = "SOUND" + _loc9_;
               _loc9_++;
            }
         }
         AnimeSound._existIDs.push(_loc8_,_loc8_);
         this.setID(_loc8_);
         this.startFrame = param2;
         this.endFrame = param3;
         this.trackNum = param5;
         this.inner_volume = param6;
      }
      
      public function convertToXml() : XML
      {
         var childXml:XML = null;
         var xml:XML = <sound/>;
         try
         {
            if(this.endFrame > this.startFrame)
            {
               xml.@id = this.getID();
               xml.@index = this.index;
               xml.@track = this.trackNum;
               xml.@vol = this.inner_volume;
               xml.sfile = this.getSoundThumb().theme.id + "." + this.getSoundThumb().id;
               xml.start = this.startFrame;
               xml.stop = this.endFrame;
               if(this.soundThumb.ttsData)
               {
                  childXml = new XML(this.soundThumb.ttsData.serialize());
                  if(childXml.toXMLString() != "")
                  {
                     xml.appendChild(childXml);
                  }
               }
               if(this.soundThumb)
               {
                  childXml = this.soundThumb.infoXml;
                  if(childXml.toXMLString() != "")
                  {
                     xml.appendChild(childXml);
                  }
               }
            }
         }
         catch(e:Error)
         {
            xml = SerializeError.createErrorNode("Failed to serialize anime sound: " + this.getSoundThumb().id);
         }
         return xml;
      }
      
      public function serialize(param1:Boolean, param2:Boolean = false, param3:Object = null) : String
      {
         var xmlStr:String = null;
         var stockdata:Boolean = param1;
         var isTTS:Boolean = param2;
         var log:Object = param3;
         var xml:XML = this.convertToXml();
         xmlStr = "";
         try
         {
            xml.@tts = !!isTTS ? "1" : "0";
            xmlStr = xml.toXMLString();
            if(this.endFrame > this.startFrame)
            {
               if(stockdata)
               {
                  Console.getConsole().putData(this.getSoundThumb().theme.id + ".sound." + this.getSoundThumb().id,ByteArray(this.getSoundThumb().imageData));
               }
            }
         }
         catch(e:Error)
         {
            throw new SerializeError("Failed to serialize sound " + this.getSoundThumb().id,xmlStr,e);
         }
         return xmlStr;
      }
      
      public function deSerialize(param1:XML) : void
      {
         var _loc2_:String = UtilXmlInfo.getZipFileNameOfSound(param1["sfile"].toString());
         var _loc3_:String = UtilXmlInfo.getThumbIdFromFileName(_loc2_);
         var _loc4_:String = UtilXmlInfo.getThemeIdFromFileName(_loc2_);
         this.init(ThemeManager.instance.getTheme(_loc4_).getSoundThumbById(_loc3_),Number(param1["start"].toString()),Number(param1["stop"].toString()),param1.@id,param1.@track,param1.@vol);
         if(param1.@tts == 1)
         {
            this.soundThumb.ttsData = new SpeechData();
            this.soundThumb.ttsData.deserialize(param1.ttsdata[0]);
         }
      }
      
      public function showMenu(param1:Number, param2:Number, param3:SoundContainer = null) : void
      {
         var _loc5_:XML = null;
         var _loc6_:ScrollableArrowMenu = null;
         var _loc8_:Number = NaN;
         var _loc14_:Boolean = false;
         StudioSoundManager.selection.currentSound = this;
         this.soundContainer = param3;
         var _loc4_:* = "";
         var _loc7_:Number = Console.getConsole().scenes.length;
         var _loc9_:UtilHashArray;
         (_loc9_ = new UtilHashArray()).push(MENU_LABEL_SOUND_LENGTH_1,1);
         _loc9_.push(MENU_LABEL_SOUND_LENGTH_2,2);
         _loc9_.push(MENU_LABEL_SOUND_LENGTH_5,5);
         _loc9_.push(MENU_LABEL_SOUND_LENGTH_10,10);
         _loc9_.push(MENU_LABEL_SOUND_LENGTH_20,20);
         _loc9_.push(MENU_LABEL_SOUND_LENGTH_30,30);
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_.length)
         {
            if(_loc7_ >= _loc9_.getValueByIndex(_loc10_))
            {
               _loc8_ = _loc10_ + 1;
            }
            _loc10_++;
         }
         var _loc11_:Number = this.soundContainer.mouseX / AnimeConstants.PIXEL_PER_SEC;
         _loc4_ = "<root><menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PLAY_SOUND) + "\" value=\"" + MENU_LABEL_PLAY_SOUND + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PLAY_SOUND) + " @ " + Util.roundNum(_loc11_) + UtilDict.toDisplay("go","timeline_sfsecond") + "\" value=\"" + MENU_LABEL_PLAY + Util.roundNum(_loc11_) * 1000 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_STOP_SOUND) + "\" value=\"" + MENU_LABEL_STOP_SOUND + "\" />";
         if(this.soundContainer.hasMarker())
         {
            _loc4_ += "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_CLEAR_MARKER) + "\" value=\"" + MENU_LABEL_CLEAR_MARKER + "\" />";
         }
         _loc4_ += "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SOUND_LENGTH) + "\" value=\"" + MENU_LABEL_SOUND_LENGTH + "\" >";
         var _loc12_:int = 0;
         while(_loc12_ < _loc8_)
         {
            _loc4_ += "<menuItem label=\"" + UtilDict.toDisplay("go",_loc9_.getKey(_loc12_)) + "\" value=\"" + _loc9_.getKey(_loc12_) + "\" />";
            _loc12_++;
         }
         _loc4_ += "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SOUND_LENGTH_FULL) + "\" value=\"" + MENU_LABEL_SOUND_LENGTH_FULL + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SOUND_LENGTH_RESET) + "\" value=\"" + MENU_LABEL_SOUND_LENGTH_RESET + "\" />" + "</menuItem>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SOUND_VOLUME) + "\" >";
         var _loc13_:UtilHashArray;
         (_loc13_ = new UtilHashArray()).push(MENU_LABEL_SOUND_VOLUME_10,0.1);
         _loc13_.push(MENU_LABEL_SOUND_VOLUME_25,0.25);
         _loc13_.push(MENU_LABEL_SOUND_VOLUME_50,0.5);
         _loc13_.push(MENU_LABEL_SOUND_VOLUME_75,0.75);
         _loc13_.push(MENU_LABEL_SOUND_VOLUME_100,1);
         _loc13_.push(MENU_LABEL_SOUND_VOLUME_200,2);
         _loc13_.push(MENU_LABEL_SOUND_VOLUME_400,4);
         _loc13_.push(MENU_LABEL_SOUND_VOLUME_800,8);
         var _loc15_:int = 0;
         while(_loc15_ < _loc13_.length)
         {
            if(_loc13_.getValueByIndex(_loc15_) == this.inner_volume)
            {
               _loc14_ = true;
            }
            else
            {
               _loc14_ = false;
            }
            _loc4_ += "<menuItem label=\"" + _loc13_.getKey(_loc15_) + "\" " + "type=\"check\" " + "toggled=\"" + _loc14_ + "\" value=\"" + _loc13_.getKey(_loc15_) + "\" />";
            _loc15_++;
         }
         _loc4_ = (_loc4_ = (_loc4_ += "</menuItem>" + "<menuItem label=\"\" type=\"separator\"/>") + ("<menuItem label=\"" + UtilDict.toDisplay("go","Duplicate sound") + "\" value=\"" + ACTION_DUPLICATE_SOUND + "\" />")) + ("<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_REMOVE_SOUND) + "\" value=\"" + MENU_LABEL_REMOVE_SOUND + "\" /></root>");
         _loc5_ = new XML(_loc4_);
         (_loc6_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),_loc5_,false)).labelField = "@label";
         _loc6_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         _loc6_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc6_.arrowScrollPolicy = ScrollPolicy.OFF;
         var _loc16_:Number = 0;
         var _loc17_:Number = 0;
         _loc16_ = 125;
         _loc17_ = 180;
         var _loc18_:Canvas;
         var _loc19_:Point = (_loc18_ = this.getSceneCanvas()).localToGlobal(new Point(0,0));
         var _loc20_:Number = param1;
         var _loc21_:Number = param2 - 180;
         if(_loc20_ + _loc16_ > _loc19_.x + _loc18_.width)
         {
            _loc20_ = _loc19_.x + _loc18_.width - _loc16_;
         }
         if(_loc21_ + _loc17_ > _loc19_.y + _loc18_.height)
         {
            _loc21_ = _loc19_.y + _loc18_.height - _loc17_;
         }
         _loc6_.show(_loc20_,_loc21_ - 20);
      }
      
      protected function getSceneCanvas() : Canvas
      {
         if(Console.getConsole().timeline == null)
         {
            return null;
         }
         return Canvas(Console.getConsole().timeline);
      }
      
      private function duplicateSound() : void
      {
         StudioSoundManager.duplicateSound(StudioSoundManager.selection);
         var _loc1_:IUIComponent = this.soundContainer;
         var _loc2_:DragSource = new DragSource();
         _loc2_.addData(this.soundThumb,SoundThumb.DRAG_DATA_FORMAT);
         _loc2_.addData(this,AnimeSound.DRAG_DATA_FORMAT);
         var _loc3_:UIComponent = new UIComponent();
         var _loc4_:DisplayObject = this.soundThumb.getDragImage();
         _loc3_.addChild(_loc4_);
         _loc2_.addData(_loc3_,StudioDragManager.DRAG_IMAGE);
         var _loc5_:MouseEvent = new MouseEvent(MouseEvent.CLICK);
         DragManager.doDrag(_loc1_,_loc2_,_loc5_,_loc3_,100,20);
      }
      
      private function doMenuClick(param1:MenuEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:ElementInfo = null;
         var _loc5_:ICommand = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc2_:XML = XML(param1.item);
         var _loc9_:String;
         if((_loc9_ = _loc2_.attribute("value").toString()).indexOf(MENU_LABEL_PLAY) > -1)
         {
            _loc10_ = Number(_loc9_.slice(MENU_LABEL_PLAY.length));
            this.playSound(_loc10_);
         }
         else
         {
            switch(_loc9_)
            {
               case MENU_LABEL_PLAY_SOUND:
                  this.playSound();
                  break;
               case MENU_LABEL_STOP_SOUND:
                  this.stopSound();
                  break;
               case MENU_LABEL_CLEAR_MARKER:
                  this.soundContainer.clearIndicator();
                  break;
               case MENU_LABEL_REMOVE_SOUND:
                  (_loc5_ = new RemoveSoundCommand(this)).execute();
                  break;
               case ACTION_DUPLICATE_SOUND:
                  this.duplicateSound();
                  break;
               case MENU_LABEL_SOUND_LENGTH_1:
               case MENU_LABEL_SOUND_LENGTH_2:
               case MENU_LABEL_SOUND_LENGTH_5:
               case MENU_LABEL_SOUND_LENGTH_10:
               case MENU_LABEL_SOUND_LENGTH_20:
               case MENU_LABEL_SOUND_LENGTH_30:
               case MENU_LABEL_SOUND_LENGTH_FULL:
               case MENU_LABEL_SOUND_LENGTH_RESET:
                  this.trySetSoundLength(_loc2_.attribute("value").toString());
                  break;
               case MENU_LABEL_SOUND_VOLUME_0:
               case MENU_LABEL_SOUND_VOLUME_10:
               case MENU_LABEL_SOUND_VOLUME_25:
               case MENU_LABEL_SOUND_VOLUME_50:
               case MENU_LABEL_SOUND_VOLUME_75:
               case MENU_LABEL_SOUND_VOLUME_100:
               case MENU_LABEL_SOUND_VOLUME_200:
               case MENU_LABEL_SOUND_VOLUME_300:
               case MENU_LABEL_SOUND_VOLUME_400:
               case MENU_LABEL_SOUND_VOLUME_800:
                  this.trySetSoundVolume(_loc2_.attribute("value").toString());
            }
         }
      }
      
      private function trySetSoundVolume(param1:String) : void
      {
         var _loc2_:String = this.getID();
         var _loc3_:ElementInfo = Console.getConsole().timeline.getSoundInfoById(_loc2_);
         var _loc4_:Number = 1;
         switch(param1)
         {
            case MENU_LABEL_SOUND_VOLUME_0:
               _loc4_ = 0;
               break;
            case MENU_LABEL_SOUND_VOLUME_10:
               _loc4_ = 0.1;
               break;
            case MENU_LABEL_SOUND_VOLUME_25:
               _loc4_ = 0.25;
               break;
            case MENU_LABEL_SOUND_VOLUME_50:
               _loc4_ = 0.5;
               break;
            case MENU_LABEL_SOUND_VOLUME_75:
               _loc4_ = 0.75;
               break;
            case MENU_LABEL_SOUND_VOLUME_100:
               _loc4_ = 1;
               break;
            case MENU_LABEL_SOUND_VOLUME_200:
               _loc4_ = 2;
               break;
            case MENU_LABEL_SOUND_VOLUME_400:
               _loc4_ = 4;
               break;
            case MENU_LABEL_SOUND_VOLUME_800:
               _loc4_ = 8;
         }
         this.inner_volume = _loc4_;
         Console.getConsole().timeline.setSoundVolumeById(_loc2_,this.inner_volume);
      }
      
      private function trySetSoundLength(param1:String) : void
      {
         var _loc5_:Number = NaN;
         var _loc10_:GoAlert = null;
         var _loc2_:String = this.getID();
         var _loc3_:ElementInfo = Console.getConsole().timeline.getSoundInfoById(_loc2_);
         var _loc4_:ICommand = new ChangeSoundLengthCommand(_loc2_,_loc3_);
         var _loc6_:Number = _loc3_.startPixel;
         var _loc7_:Number = _loc3_.startPixel;
         var _loc8_:Number = _loc3_.totalPixel;
         var _loc9_:Number = Console.getConsole().timeline.getSceneLocalPositionIndex(_loc7_);
         switch(param1)
         {
            case MENU_LABEL_SOUND_LENGTH_1:
               _loc5_ = this.getScenesLengthFromCurrent(1,_loc9_);
               _loc6_ = Console.getConsole().timeline.getSceneLocalPositionByIndex(_loc9_);
               break;
            case MENU_LABEL_SOUND_LENGTH_2:
               _loc5_ = this.getScenesLengthFromCurrent(2,_loc9_);
               _loc6_ = Console.getConsole().timeline.getSceneLocalPositionByIndex(_loc9_);
               break;
            case MENU_LABEL_SOUND_LENGTH_5:
               _loc5_ = this.getScenesLengthFromCurrent(5,_loc9_);
               _loc6_ = Console.getConsole().timeline.getSceneLocalPositionByIndex(_loc9_);
               break;
            case MENU_LABEL_SOUND_LENGTH_10:
               _loc5_ = this.getScenesLengthFromCurrent(10,_loc9_);
               _loc6_ = Console.getConsole().timeline.getSceneLocalPositionByIndex(_loc9_);
               break;
            case MENU_LABEL_SOUND_LENGTH_20:
               _loc5_ = this.getScenesLengthFromCurrent(20,_loc9_);
               _loc6_ = Console.getConsole().timeline.getSceneLocalPositionByIndex(_loc9_);
               break;
            case MENU_LABEL_SOUND_LENGTH_30:
               _loc5_ = this.getScenesLengthFromCurrent(30,_loc9_);
               _loc6_ = Console.getConsole().timeline.getSceneLocalPositionByIndex(_loc9_);
               break;
            case MENU_LABEL_SOUND_LENGTH_FULL:
               _loc5_ = Console.getConsole().timeline.getTotalTimeInPixel();
               _loc6_ = 0;
               break;
            case MENU_LABEL_SOUND_LENGTH_RESET:
               _loc5_ = UtilUnitConvert.secToPixel(Util.roundNum(this.getSoundThumb().duration / 1000));
         }
         Console.getConsole().timeline.setSoundInfoById(_loc2_,_loc6_,_loc5_,null,_loc3_.y,_loc3_.inner_volume);
         this.startFrame = UtilUnitConvert.xToFrame(_loc6_);
         this.endFrame = UtilUnitConvert.xToFrame(_loc6_ + _loc5_) - 1;
         this.trackNum = SoundTrackArea.pixelToTrack(_loc3_.y);
         if(Console.getConsole().timeline.checkSoundOverlap())
         {
            _loc6_ = _loc7_;
            _loc5_ = _loc8_;
            Console.getConsole().timeline.setSoundInfoById(_loc2_,_loc6_,_loc5_,null,_loc3_.y,_loc3_.inner_volume);
            this.startFrame = UtilUnitConvert.xToFrame(_loc6_);
            this.endFrame = UtilUnitConvert.xToFrame(_loc6_ + _loc5_) - 1;
            this.trackNum = SoundTrackArea.pixelToTrack(_loc3_.y);
            (_loc10_ = GoAlert(PopUpManager.createPopUp(Console.getConsole().mainStage,GoAlert,true)))._lblConfirm.text = "";
            _loc10_._txtDelete.text = UtilDict.toDisplay("go","timeline_soundexceed");
            _loc10_._btnDelete.visible = false;
            _loc10_._btnCancel.label = UtilDict.toDisplay("go","ok");
            _loc10_.x = (_loc10_.stage.width - _loc10_.width) / 2;
            _loc10_.y = 100;
         }
         else
         {
            _loc4_.execute();
         }
      }
      
      private function getScenesLengthFromCurrent(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            if(Console.getConsole().getScene(param2 + _loc3_) != null)
            {
               _loc4_ += Console.getConsole().timeline.getSceneWidthByIndex(param2 + _loc3_);
            }
            else
            {
               _loc4_ += AnimeConstants.SCENE_LENGTH_DEFAULT;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function clone() : AnimeSound
      {
         var _loc1_:AnimeSound = StudioSoundFactory.createSound(this.soundThumb);
         _loc1_.init(this.soundThumb,this.startFrame,this.endFrame,null,this.trackNum,this.inner_volume);
         return _loc1_;
      }
   }
}
