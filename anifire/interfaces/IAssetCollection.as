package anifire.interfaces
{
   public interface IAssetCollection extends ICollection
   {
       
      
      function addAsset(param1:IAssetCollection) : Boolean;
      
      function removeAsset(param1:IAssetCollection) : Boolean;
      
      function clearCollection() : void;
   }
}
