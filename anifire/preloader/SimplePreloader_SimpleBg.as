package anifire.preloader
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class SimplePreloader_SimpleBg extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function SimplePreloader_SimpleBg()
      {
         this.dataClass = SimplePreloader_SimpleBg_dataClass;
         super();
         initialWidth = 12360 / 20;
         initialHeight = 7380 / 20;
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
