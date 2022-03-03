package anifire.products.character
{
   import mx.controls.TileList;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   
   public class ActionTileList extends TileList
   {
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ActionTileList()
      {
         super();
         this.labelField = "name";
         this.itemRenderer = this._ActionTileList_ClassFactory1_c();
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
            this.selectionColor = 11184810;
            this.rollOverColor = 13421772;
            this.borderStyle = "none";
         };
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      private function _ActionTileList_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = ActionItemRenderer;
         return _loc1_;
      }
   }
}
