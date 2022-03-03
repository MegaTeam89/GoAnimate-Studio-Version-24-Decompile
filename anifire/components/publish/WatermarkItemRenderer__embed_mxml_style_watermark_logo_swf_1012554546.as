package anifire.components.publish
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class WatermarkItemRenderer__embed_mxml_style_watermark_logo_swf_1012554546 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function WatermarkItemRenderer__embed_mxml_style_watermark_logo_swf_1012554546()
      {
         this.dataClass = WatermarkItemRenderer__embed_mxml_style_watermark_logo_swf_1012554546_dataClass;
         super();
         initialWidth = 2400 / 20;
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
