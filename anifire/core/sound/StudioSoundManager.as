package anifire.core.sound
{
   import anifire.command.AddSoundCommand;
   import anifire.command.ICommand;
   import anifire.constant.AnimeConstants;
   import anifire.core.AnimeSound;
   import anifire.interfaces.IIterator;
   import anifire.util.UtilMath;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class StudioSoundManager extends EventDispatcher
   {
      
      public static const SOUND_TRACK_MAX:int = 4;
      
      private static var _selection:SoundSelection = new SoundSelection();
      
      private static var _copiedSound:AnimeSound;
      
      private static var _isDuplicatingSound:Boolean;
       
      
      public function StudioSoundManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get selection() : SoundSelection
      {
         return _selection;
      }
      
      public static function get copiedSound() : AnimeSound
      {
         return _copiedSound;
      }
      
      public static function copySound(param1:SoundSelection) : void
      {
         if(param1 && param1.currentSound)
         {
            _copiedSound = param1.currentSound.clone();
         }
      }
      
      public static function set isDuplicatingSound(param1:Boolean) : void
      {
         _isDuplicatingSound = param1;
      }
      
      public static function get isDuplicatingSound() : Boolean
      {
         return _isDuplicatingSound;
      }
      
      public static function duplicateSound(param1:SoundSelection) : void
      {
         if(param1 && param1.currentSound)
         {
            _isDuplicatingSound = true;
            _copiedSound = param1.currentSound.clone();
         }
      }
      
      public static function pasteSoundAt(param1:Number, param2:Number) : void
      {
         var _loc3_:AnimeSound = null;
         var _loc4_:ICommand = null;
         if(_copiedSound)
         {
            _loc3_ = _copiedSound.clone();
            _loc3_.startFrame = param1;
            _loc3_.trackNum = param2;
            (_loc4_ = new AddSoundCommand(_loc3_)).execute();
         }
      }
      
      public static function validateStartFrame(param1:Number) : Number
      {
         param1 = Math.round((param1 - 1) / AnimeConstants.SOUND_FRAME_INTERVAL) * AnimeConstants.SOUND_FRAME_INTERVAL + 1;
         if(param1 < 1)
         {
            param1 = 1;
         }
         return param1;
      }
      
      public static function validateTotalFrame(param1:Number) : Number
      {
         return Number(Math.round(param1 / AnimeConstants.SOUND_FRAME_INTERVAL) * AnimeConstants.SOUND_FRAME_INTERVAL);
      }
      
      public static function validateTrack(param1:int) : int
      {
         return int(UtilMath.boundaryCheck(param1,0,SOUND_TRACK_MAX - 1));
      }
      
      public static function getFirstSoundAfterFrameOnTrack(param1:SoundCollection, param2:Number, param3:int) : AnimeSound
      {
         var _loc5_:AnimeSound = null;
         var _loc6_:AnimeSound = null;
         var _loc4_:IIterator = param1.iterator();
         while(_loc4_.hasNext)
         {
            if((_loc5_ = _loc4_.next as AnimeSound) && _loc5_.trackNum == param3 && _loc5_.startFrame > param2)
            {
               if(_loc6_)
               {
                  if(_loc6_.startFrame > _loc5_.startFrame)
                  {
                     _loc6_ = _loc5_;
                  }
               }
               else
               {
                  _loc6_ = _loc5_;
               }
            }
         }
         return _loc6_;
      }
      
      public static function getLastSoundBeforeFrameOnTrack(param1:SoundCollection, param2:Number, param3:int) : AnimeSound
      {
         var _loc5_:AnimeSound = null;
         var _loc6_:AnimeSound = null;
         var _loc4_:IIterator = param1.iterator();
         while(_loc4_.hasNext)
         {
            if((_loc5_ = _loc4_.next as AnimeSound) && _loc5_.trackNum == param3 && _loc5_.startFrame < param2)
            {
               if(_loc6_)
               {
                  if(_loc6_.startFrame < _loc5_.startFrame)
                  {
                     _loc6_ = _loc5_;
                  }
               }
               else
               {
                  _loc6_ = _loc5_;
               }
            }
         }
         return _loc6_;
      }
      
      public static function getSoundAtFrameOnTrack(param1:SoundCollection, param2:Number, param3:int) : AnimeSound
      {
         var _loc5_:AnimeSound = null;
         var _loc4_:IIterator = param1.iterator();
         while(_loc4_.hasNext)
         {
            if((_loc5_ = _loc4_.next as AnimeSound) && _loc5_.trackNum == param3 && _loc5_.startFrame == param2)
            {
               return _loc5_;
            }
         }
         return null;
      }
   }
}
