package anifire.playerComponent
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class _class_embed_css__styles_player_watermark_new_swf__2042183570_1311154089 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function _class_embed_css__styles_player_watermark_new_swf__2042183570_1311154089()
      {
         this.dataClass = _class_embed_css__styles_player_watermark_new_swf__2042183570_1311154089_dataClass;
         super();
         initialWidth = 2400 / 20;
         initialHeight = 700 / 20;
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
