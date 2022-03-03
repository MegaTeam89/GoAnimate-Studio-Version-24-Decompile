package anifire.component
{
   import mx.controls.LinkButton;
   import mx.core.IFlexModuleFactory;
   import mx.skins.ProgrammaticSkin;
   
   public class IconTextButton extends LinkButton
   {
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function IconTextButton()
      {
         super();
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.upSkin = ProgrammaticSkin;
            this.downSkin = ProgrammaticSkin;
            this.overSkin = ProgrammaticSkin;
         };
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
   }
}
