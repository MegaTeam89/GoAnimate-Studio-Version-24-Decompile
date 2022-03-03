package anifire.playback.asset.transition.model
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.AssetTransitionNode;
   import anifire.playback.asset.transition.sound.TransitionSoundData;
   
   public class AssetTransition
   {
       
      
      private var _type:String;
      
      private var _direction:int;
      
      private var _timing:AssetTransitionTiming;
      
      private var _sound:TransitionSoundData;
      
      public function AssetTransition()
      {
         this._timing = new AssetTransitionTiming();
         super();
      }
      
      public function init(param1:AssetTransitionNode) : void
      {
         this._type = String(param1.xml.@type);
         this._direction = uint(param1.xml.@direction);
         this._timing.startFrame = param1.startFrame;
         this._timing.duration = param1.duration;
         if(param1.xml.hasOwnProperty(AssetTransitionConstants.TAG_NAME_TRANSITION_SOUND))
         {
            this._sound = new TransitionSoundData();
         }
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get hasSound() : Boolean
      {
         return this._sound != null;
      }
      
      public function get direction() : uint
      {
         return this._direction;
      }
      
      public function get startFrame() : int
      {
         return this._timing.startFrame;
      }
      
      public function get duration() : int
      {
         return this._timing.duration;
      }
      
      public function get endFrame() : int
      {
         return this.startFrame + this.duration - 1;
      }
   }
}
