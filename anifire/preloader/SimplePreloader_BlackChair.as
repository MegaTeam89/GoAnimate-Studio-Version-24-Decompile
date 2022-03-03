package anifire.preloader
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class SimplePreloader_BlackChair extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function SimplePreloader_BlackChair()
      {
         this.dataClass = SimplePreloader_BlackChair_dataClass;
         super();
         initialWidth = 1500 / 20;
         initialHeight = 1600 / 20;
      }
      
      override public function get movieClipData() : ByteArray
      {
         if(bytes == null)
         {
            bytes = ByteArray(new this.dataClass());
         }
         return bytes;
      }
   }
}
