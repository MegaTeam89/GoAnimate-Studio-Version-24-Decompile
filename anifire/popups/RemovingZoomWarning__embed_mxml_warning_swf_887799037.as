package anifire.popups
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class RemovingZoomWarning__embed_mxml_warning_swf_887799037 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function RemovingZoomWarning__embed_mxml_warning_swf_887799037()
      {
         this.dataClass = RemovingZoomWarning__embed_mxml_warning_swf_887799037_dataClass;
         super();
         initialWidth = 540 / 20;
         initialHeight = 540 / 20;
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
