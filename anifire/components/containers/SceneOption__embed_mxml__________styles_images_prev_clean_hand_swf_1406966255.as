package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class SceneOption__embed_mxml__________styles_images_prev_clean_hand_swf_1406966255 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function SceneOption__embed_mxml__________styles_images_prev_clean_hand_swf_1406966255()
      {
         this.dataClass = SceneOption__embed_mxml__________styles_images_prev_clean_hand_swf_1406966255_dataClass;
         super();
         initialWidth = 1100 / 20;
         initialHeight = 740 / 20;
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
