package anifire.banner
{
   import mx.controls.Image;
   import mx.core.IFlexModuleFactory;
   
   public class LoadingImage extends Image
   {
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _embed_mxml_images_loading_swf_162774498:Class;
      
      public function LoadingImage()
      {
         this._embed_mxml_images_loading_swf_162774498 = LoadingImage__embed_mxml_images_loading_swf_162774498;
         super();
         this.source = this._embed_mxml_images_loading_swf_162774498;
         this.horizontalCenter = 0;
         this.verticalCenter = 0;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
   }
}
