package anifire.playback.asset.transition.model
{
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
   import anifire.iterators.ArrayIterator;
   
   public class AssetTransitionCollection implements ICollection
   {
       
      
      private var _transitions:Array;
      
      public function AssetTransitionCollection()
      {
         this._transitions = new Array();
         super();
      }
      
      public function add(param1:AssetTransition) : void
      {
         if(param1)
         {
            this._transitions.push(param1);
         }
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         return new ArrayIterator(this._transitions);
      }
   }
}
