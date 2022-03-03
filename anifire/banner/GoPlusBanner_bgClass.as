package anifire.banner
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class GoPlusBanner_bgClass extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function GoPlusBanner_bgClass()
      {
         this.dataClass = GoPlusBanner_bgClass_dataClass;
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