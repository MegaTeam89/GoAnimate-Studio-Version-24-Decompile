package anifire.timeline
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class SoundWaveformRenderer__embed_mxml_image_icon_loading_swf_742683607 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function SoundWaveformRenderer__embed_mxml_image_icon_loading_swf_742683607()
      {
         this.dataClass = SoundWaveformRenderer__embed_mxml_image_icon_loading_swf_742683607_dataClass;
         super();
         initialWidth = 360 / 20;
         initialHeight = 360 / 20;
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
