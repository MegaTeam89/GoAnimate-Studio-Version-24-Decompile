package anifire.playback.asset.transition.hand
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class HandClip_HandImage extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function HandClip_HandImage()
      {
         this.dataClass = HandClip_HandImage_dataClass;
         super();
         initialWidth = 11000 / 20;
         initialHeight = 6200 / 20;
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
