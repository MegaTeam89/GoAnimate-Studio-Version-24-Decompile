package anifire.font
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class FontChooser__embed_mxml_image_icon_fontcolor_swf_1474137115 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function FontChooser__embed_mxml_image_icon_fontcolor_swf_1474137115()
      {
         this.dataClass = FontChooser__embed_mxml_image_icon_fontcolor_swf_1474137115_dataClass;
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
