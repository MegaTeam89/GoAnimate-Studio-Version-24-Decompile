package anifire.banner
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class StudioLoadingScreen__embed_mxml_images_loading_swf_162774498 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function StudioLoadingScreen__embed_mxml_images_loading_swf_162774498()
      {
         this.dataClass = StudioLoadingScreen__embed_mxml_images_loading_swf_162774498_dataClass;
         super();
         initialWidth = 1000 / 20;
         initialHeight = 1000 / 20;
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
