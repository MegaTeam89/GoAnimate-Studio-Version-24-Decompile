package anifire.core.sound
{
   import anifire.core.AnimeSound;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IXmlConvertable;
   import anifire.iterators.ArrayIterator;
   import anifire.util.UtilHashArray;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class SoundCollection extends EventDispatcher implements IXmlConvertable, ICollection
   {
       
      
      private var _sounds:UtilHashArray;
      
      public function SoundCollection(param1:IEventDispatcher = null)
      {
         this._sounds = new UtilHashArray();
         super(param1);
      }
      
      public function addSound(param1:AnimeSound) : void
      {
         this._sounds.push(param1.getID(),param1);
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get length() : int
      {
         return this._sounds.length;
      }
      
      public function getSoundById(param1:String) : AnimeSound
      {
         return this._sounds.getValueByKey(param1);
      }
      
      public function removeSoundById(param1:String) : void
      {
         SoundPlaybackManager.stop();
         this._sounds.removeByKey(param1);
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function removeAll() : void
      {
         SoundPlaybackManager.stop();
         this._sounds.removeAll();
         this.dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function convertToXml() : XML
      {
         return new XML();
      }
      
      public function convertFromXml(param1:XML) : Boolean
      {
         return false;
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         return new ArrayIterator(this._sounds.getArray());
      }
   }
}
