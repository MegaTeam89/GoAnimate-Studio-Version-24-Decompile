package anifire.component
{
   import flash.text.TextFieldAutoSize;
   import mx.controls.LinkButton;
   import mx.core.IFlexModuleFactory;
   import mx.core.UITextField;
   import mx.skins.ProgrammaticSkin;
   
   public class CreateButton extends LinkButton
   {
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function CreateButton()
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
      
      override protected function createChildren() : void
      {
         if(!textField)
         {
            textField = new UITextField();
            textField.styleName = this;
            addChild(UITextField(textField));
         }
         super.createChildren();
         UITextField(textField).multiline = true;
         UITextField(textField).wordWrap = true;
         UITextField(textField).autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
      }
   }
}
