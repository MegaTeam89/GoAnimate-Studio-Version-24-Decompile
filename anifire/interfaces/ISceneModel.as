package anifire.interfaces
{
   import anifire.assets.model.AssetSelection;
   import anifire.core.Thumb;
   import flash.events.IEventDispatcher;
   
   public interface ISceneModel extends IEventDispatcher, ICollection
   {
       
      
      function doCreateAsset(param1:Thumb, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Boolean = false) : void;
      
      function getAssetOrdering(param1:IAsset) : int;
      
      function get selection() : AssetSelection;
   }
}
