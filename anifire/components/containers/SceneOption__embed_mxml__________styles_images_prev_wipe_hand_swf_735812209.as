package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class SceneOption__embed_mxml__________styles_images_prev_wipe_hand_swf_735812209 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function SceneOption__embed_mxml__________styles_images_prev_wipe_hand_swf_735812209()
      {
         this.dataClass = SceneOption__embed_mxml__________styles_images_prev_wipe_hand_swf_735812209_dataClass;
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
