package anifire.components.studio
{
   import mx.controls.TileList;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   
   public class ProductThumbPanel extends TileList
   {
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ProductThumbPanel()
      {
         super();
         this.selectable = false;
         this.labelField = "name";
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.styleName = "propTileContainer";
         this.itemRenderer = this._ProductThumbPanel_ClassFactory1_c();
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
            this.borderStyle = "none";
            this.backgroundAlpha = 0;
            this.useRollOver = false;
         };
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      private function _ProductThumbPanel_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = ProductItemRenderer;
         return _loc1_;
      }
   }
}
