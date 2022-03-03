package anifire.components.studio
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import mx.controls.TileList;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   
   public class ThemeTileList extends TileList
   {
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function ThemeTileList()
      {
         super();
         this.height = 70;
         this.percentWidth = 100;
         this.itemRenderer = this._ThemeTileList_ClassFactory1_c();
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
      
      override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
      {
         var _loc8_:Graphics;
         (_loc8_ = Sprite(param1).graphics).clear();
         _loc8_.lineStyle(1,10066329);
         _loc8_.beginFill(0,0);
         _loc8_.drawRect(0,0,param4,param5);
         _loc8_.endFill();
         param1.x = param2;
         param1.y = param3;
      }
      
      private function _ThemeTileList_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = ThemeItemRenderer;
         return _loc1_;
      }
   }
}
