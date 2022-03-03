package anifire.assets.transition.model
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.command.ChangeAssetTransitionCommand;
   import anifire.command.ICommand;
   import anifire.interfaces.IXmlConvertable;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class AssetTransition extends EventDispatcher implements IXmlConvertable
   {
      
      private static var _counter:int = 0;
      
      private static var _lastSection:int = AssetTransitionConstants.TIMING_WITH_NARRATION;
       
      
      private const DEFAULT_DURATION:uint = 18;
      
      private const HANDSLIDE_DEFAULT_DURATION:uint = 30;
      
      private const MIN_DURATION:uint = 6;
      
      private const MAX_DURATION:uint = 240;
      
      private const FRAME_INTERVAL:uint = 6;
      
      private var _direction:uint;
      
      private var _type:String;
      
      private var _assetId:String;
      
      private var _atype:String = "prop";
      
      private var _setting:TransitionSetting;
      
      private var _timing:uint;
      
      private var _section:uint;
      
      private var _duration:int;
      
      private var _delay:int;
      
      private var _soundMode:uint;
      
      private var _conflict:Boolean = false;
      
      private var _id:String;
      
      public function AssetTransition(param1:String, param2:String, param3:String)
      {
         super();
         this._assetId = param1;
         this._atype = param3;
         this._type = param2;
         this._setting = TransitionSettingFactory.createSetting(param2);
         this._direction = AssetTransitionConstants.DIRECTION_IN;
         this._timing = AssetTransitionConstants.TIMING_WITH_PREVIOUS;
         this._section = AssetTransitionConstants.TIMING_BEFORE_NARRATION;
         this._delay = 0;
         this._duration = param2 == AssetTransitionConstants.TYPE_APPEAR ? 0 : int(this.DEFAULT_DURATION);
         if(param2 == AssetTransitionConstants.TYPE_HANDSLIDE)
         {
            this._duration = this.HANDSLIDE_DEFAULT_DURATION;
         }
         this._soundMode = AssetTransitionConstants.SOUND_OFF;
         this._id = _counter.toString();
         ++_counter;
      }
      
      public function set conflict(param1:Boolean) : void
      {
         if(this._conflict != param1)
         {
            this._conflict = param1;
            this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.CONFLICT_CHANGE));
         }
      }
      
      public function get conflict() : Boolean
      {
         return this._conflict;
      }
      
      public function set direction(param1:uint) : void
      {
         if(this._direction != param1)
         {
            this._direction = param1;
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function set soundMode(param1:uint) : void
      {
         if(this._soundMode != param1)
         {
            this._soundMode = param1;
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function set timing(param1:uint) : void
      {
         if(this._timing != param1)
         {
            this._timing = param1;
            this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.TIMING_CHANGE));
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function set section(param1:uint) : void
      {
         if(this._section != param1)
         {
            this._section = param1;
            this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.SECTION_CHANGE));
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function setSection(param1:uint) : void
      {
         var _loc2_:ICommand = null;
         if(this._section != param1)
         {
            _loc2_ = new ChangeAssetTransitionCommand(this);
            _loc2_.execute();
            this._section = param1;
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function set duration(param1:int) : void
      {
         if(this.type == AssetTransitionConstants.TYPE_APPEAR || this.type == AssetTransitionConstants.TYPE_HANDSLIDE)
         {
            return;
         }
         param1 = Math.round(param1 / this.FRAME_INTERVAL) * this.FRAME_INTERVAL;
         if(param1 < this.MIN_DURATION)
         {
            param1 = this.MIN_DURATION;
         }
         else if(param1 > this.MAX_DURATION)
         {
            param1 = this.MAX_DURATION;
         }
         if(param1 != this._duration)
         {
            this._duration = param1;
            this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.TIMING_CHANGE));
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function set delay(param1:int) : void
      {
         param1 = Math.round(param1 / this.FRAME_INTERVAL) * this.FRAME_INTERVAL;
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > this.MAX_DURATION)
         {
            param1 = this.MAX_DURATION;
         }
         if(param1 != this._delay)
         {
            this._delay = param1;
            this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.TIMING_CHANGE));
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function set type(param1:String) : void
      {
         if(this._type != param1)
         {
            this._type = param1;
            this._setting = TransitionSettingFactory.createSetting(param1);
            if(param1 == AssetTransitionConstants.TYPE_APPEAR)
            {
               this._duration = 0;
               this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.TIMING_CHANGE));
            }
            else if(param1 == AssetTransitionConstants.TYPE_HANDSLIDE)
            {
               this._duration = this.HANDSLIDE_DEFAULT_DURATION;
               this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.TIMING_CHANGE));
            }
            else if(this.duration == 0)
            {
               this._duration = this.DEFAULT_DURATION;
               this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.TIMING_CHANGE));
            }
            this.dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function get direction() : uint
      {
         return this._direction;
      }
      
      public function get soundMode() : uint
      {
         return this._soundMode;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get timing() : uint
      {
         return this._timing;
      }
      
      public function get section() : uint
      {
         return this._section;
      }
      
      public function get duration() : int
      {
         return this._duration;
      }
      
      public function get delay() : int
      {
         return this._delay;
      }
      
      public function get setting() : TransitionSetting
      {
         return this._setting;
      }
      
      public function set setting(param1:TransitionSetting) : void
      {
         this._setting = param1;
      }
      
      public function get assetId() : String
      {
         return this._assetId;
      }
      
      public function get atype() : String
      {
         return this._atype;
      }
      
      public function get label() : String
      {
         return this._assetId + this._type;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function convertToXml() : XML
      {
         var _loc1_:XML = new XML("<" + AssetTransitionConstants.TAG_NAME_TRANSITION + " id=\"" + ({this._id}) + "\" target=\"" + ({this._assetId}) + "\" type=\"" + ({this._type}) + "\" atype=\"" + ({this._atype}) + "\" direction=\"" + ({this._direction}) + "\" section=\"" + ({this._section}) + "\" timing=\"" + ({this._timing}) + "\" duration=\"" + ({this._duration}) + "\" delay=\"" + ({this._delay}) + "\"></" + AssetTransitionConstants.TAG_NAME_TRANSITION + ">");
         if(this._setting is IXmlConvertable)
         {
            _loc1_.appendChild(IXmlConvertable(this._setting).convertToXml());
         }
         if(this._soundMode == AssetTransitionConstants.SOUND_ON)
         {
            _loc1_.appendChild(new XML("<" + AssetTransitionConstants.TAG_NAME_TRANSITION_SOUND + "/>"));
         }
         return _loc1_;
      }
      
      public function convertFromXml(param1:XML) : Boolean
      {
         if(param1)
         {
            this._assetId = String(param1.@target);
            this._atype = String(param1.@atype);
            this._type = String(param1.@type);
            this._direction = uint(param1.@direction);
            this._timing = uint(param1.@timing);
            this._duration = int(param1.@duration);
            this._delay = int(param1.@delay);
            this._id = String(param1.@id);
            if(param1.hasOwnProperty("@section"))
            {
               this.section = uint(param1.@section);
            }
            else
            {
               if(this._timing == AssetTransitionConstants.TIMING_ON_START)
               {
                  this._section = AssetTransitionConstants.TIMING_WITH_NARRATION;
                  this._timing = AssetTransitionConstants.TIMING_AFTER_PREVIOUS;
               }
               else if(this._timing == AssetTransitionConstants.TIMING_AFTER_NARRATION)
               {
                  this._section = AssetTransitionConstants.TIMING_AFTER_NARRATION;
                  this._timing = AssetTransitionConstants.TIMING_AFTER_PREVIOUS;
               }
               else
               {
                  this._section = _lastSection;
               }
               _lastSection = this._section;
            }
            this._setting = TransitionSettingFactory.createSetting(this._type);
            if(this._setting is IXmlConvertable && param1.hasOwnProperty(AssetTransitionConstants.TAG_NAME_TRANSITION_SETTING))
            {
               IXmlConvertable(this._setting).convertFromXml(param1.child(AssetTransitionConstants.TAG_NAME_TRANSITION_SETTING)[0]);
            }
            if(param1.hasOwnProperty(AssetTransitionConstants.TAG_NAME_TRANSITION_SOUND))
            {
               this._soundMode = AssetTransitionConstants.SOUND_ON;
            }
            else
            {
               this._soundMode = AssetTransitionConstants.SOUND_OFF;
            }
            this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.TIMING_CHANGE));
            this.dispatchEvent(new Event(Event.CHANGE));
            return true;
         }
         return false;
      }
   }
}
