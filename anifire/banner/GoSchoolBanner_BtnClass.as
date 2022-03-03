package anifire.banner
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class GoSchoolBanner_BtnClass extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function GoSchoolBanner_BtnClass()
      {
         this.dataClass = GoSchoolBanner_BtnClass_dataClass;
         super();
         initialWidth = 4360 / 20;
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
