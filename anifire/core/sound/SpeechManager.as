package anifire.core.sound
{
   import anifire.core.AnimeScene;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.SoundThumb;
   import anifire.errors.SerializeError;
   import anifire.managers.ThemeManager;
   import anifire.util.UtilUnitConvert;
   import flash.utils.ByteArray;
   
   public class SpeechManager
   {
       
      
      private var _ttsManager:TTSManager;
      
      private var _micRecordingManager:MicRecordingManager;
      
      private var _voiceFileManager:VoiceFileManager;
      
      public function SpeechManager()
      {
         this._ttsManager = new TTSManager();
         this._micRecordingManager = new MicRecordingManager();
         this._voiceFileManager = new VoiceFileManager();
         super();
      }
      
      public function get ttsManager() : TTSManager
      {
         return this._ttsManager;
      }
      
      public function get micRecordingManager() : MicRecordingManager
      {
         return this._micRecordingManager;
      }
      
      public function get voiceFileManager() : VoiceFileManager
      {
         return this._voiceFileManager;
      }
      
      public function serializeSound(param1:Boolean = true, param2:Object = null) : String
      {
         var xml:String = null;
         var stockdata:Boolean = param1;
         var log:Object = param2;
         try
         {
            xml = "";
            log.phase = "Speech manager began";
            xml += this.ttsManager.serializeSound(stockdata,log);
            xml += this.micRecordingManager.serializeSound(stockdata,log);
            xml += this.voiceFileManager.serializeSound(stockdata,log);
            log.phase = "Speech manager ended";
         }
         catch(e:SerializeError)
         {
            throw new SerializeError("Failed to serialize sounds in SpeechManager",xml,e);
         }
         return xml;
      }
      
      public function getValueByKey(param1:String) : AnimeSound
      {
         if(this.ttsManager.sounds.containsKey(param1))
         {
            return this.ttsManager.sounds.getValueByKey(param1) as AnimeSound;
         }
         if(this.micRecordingManager.sounds.containsKey(param1))
         {
            return this.micRecordingManager.sounds.getValueByKey(param1) as AnimeSound;
         }
         if(this.voiceFileManager.sounds.containsKey(param1))
         {
            return this.voiceFileManager.sounds.getValueByKey(param1) as AnimeSound;
         }
         return null;
      }
      
      public function createSoundThumbByByte(param1:ByteArray, param2:XML) : SoundThumb
      {
         var _loc3_:SoundThumb = new SoundThumb();
         _loc3_.deSerializeByUserAssetXML(param2,ThemeManager.instance.userTheme);
         _loc3_.enable = true;
         _loc3_.initSoundByByteArray(param1);
         Console.getConsole().addNewlyAddedAssetId(param2.id);
         return _loc3_;
      }
      
      public function addSoundByThumb(param1:SoundThumb) : void
      {
         var _loc2_:AnimeSound = new AnimeSound();
         _loc2_.init(param1,0,UtilUnitConvert.secToFrame(param1.duration / 1000));
         var _loc3_:Asset = Console.getConsole().currentScene.selectedAsset;
         if(_loc3_ && _loc3_ is Character)
         {
            _loc2_.inner_volume = Character(_loc3_).speakingVolume;
         }
         this.addSoundBySound(_loc2_);
      }
      
      public function addSoundBySound(param1:AnimeSound, param2:Boolean = true) : void
      {
         var _loc3_:SoundThumb = param1.soundThumb;
         if(_loc3_.ttsData.type == "mic")
         {
            this.micRecordingManager.addSoundBySound(param1,param2);
         }
         else if(_loc3_.ttsData.type == "file")
         {
            this.voiceFileManager.addSoundBySound(param1,param2);
         }
         else
         {
            this.ttsManager.addSoundBySound(param1,param2);
         }
      }
      
      public function removeSoundById(param1:String) : void
      {
         if(this.ttsManager.sounds.containsKey(param1))
         {
            return this.ttsManager.removeSoundById(param1);
         }
         if(this.micRecordingManager.sounds.containsKey(param1))
         {
            return this.micRecordingManager.removeSoundById(param1);
         }
         if(this.voiceFileManager.sounds.containsKey(param1))
         {
            return this.voiceFileManager.removeSoundById(param1);
         }
      }
      
      public function getNumOfSpeech() : Number
      {
         return this.ttsManager.sounds.length + this.micRecordingManager.sounds.length + this.voiceFileManager.sounds.length;
      }
      
      public function getSpeech(param1:AnimeScene) : AnimeSound
      {
         var _loc2_:AnimeSound = null;
         var _loc3_:String = null;
         if(param1)
         {
            _loc3_ = Console.getConsole().linkageController.getSpeechSoundIdByScene(param1);
            if(_loc3_)
            {
               _loc2_ = Console.getConsole().speechManager.getValueByKey(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getSpeechTotalFrame(param1:AnimeScene) : int
      {
         var _loc2_:int = 0;
         var _loc3_:AnimeSound = this.getSpeech(param1);
         if(_loc3_)
         {
            if(_loc3_ && _loc3_.soundThumb)
            {
               _loc2_ = UtilUnitConvert.secToFrame(_loc3_.soundThumb.duration / 1000);
            }
         }
         return _loc2_;
      }
   }
}
