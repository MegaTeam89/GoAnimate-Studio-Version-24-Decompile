package anifire.font
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class FontChooser__embed_mxml_image_icon_fontsize_swf_1938158565 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function FontChooser__embed_mxml_image_icon_fontsize_swf_1938158565()
      {
         this.dataClass = FontChooser__embed_mxml_image_icon_fontsize_swf_1938158565_dataClass;
         super();
         initialWidth = 540 / 20;
         initialHeight = 440 / 20;
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
