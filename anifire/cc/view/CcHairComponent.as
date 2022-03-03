package anifire.cc.view
{
   import anifire.constant.CcLibConstant;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   
   public class CcHairComponent extends CcComponent
   {
       
      
      private var _frontHair:DisplayObjectContainer;
      
      private var _backHair:DisplayObjectContainer;
      
      public function CcHairComponent()
      {
         super();
      }
      
      public function get frontHair() : DisplayObjectContainer
      {
         return this._frontHair;
      }
      
      public function get backHair() : DisplayObjectContainer
      {
         return this._backHair;
      }
      
      override protected function addLoader() : void
      {
         super.addLoader();
         this._frontHair = this.addDefinitionFromParent(loader.contentLoaderInfo,CcLibConstant.COMPONENT_TYPE_FRONT_HAIR);
         this._backHair = this.addDefinitionFromParent(loader.contentLoaderInfo,CcLibConstant.COMPONENT_TYPE_BACK_HAIR);
         if(this._backHair)
         {
            this.addChild(this._backHair);
         }
         if(this._frontHair)
         {
            this.addChild(this._frontHair);
         }
      }
      
      override protected function setProperties() : void
      {
         super.setProperties();
         if(this.model)
         {
            if(this._frontHair)
            {
               this._frontHair.x = this.model.x;
               this._frontHair.y = this.model.y;
               this._frontHair.scaleX = this.model.xscale;
               this._frontHair.scaleY = this.model.yscale;
               this._frontHair.rotation = this.model.rotation;
            }
            if(this._backHair)
            {
               this._backHair.x = this.model.x;
               this._backHair.y = this.model.y;
               this._backHair.scaleX = this.model.xscale;
               this._backHair.scaleY = this.model.yscale;
               this._backHair.rotation = this.model.rotation;
            }
         }
      }
      
      private function addDefinitionFromParent(param1:LoaderInfo, param2:String) : DisplayObjectContainer
      {
         var _loc3_:Class = null;
         var _loc4_:DisplayObjectContainer = null;
         try
         {
            _loc3_ = param1.applicationDomain.getDefinition(param2) as Class;
            if(_loc3_)
            {
               (_loc4_ = new _loc3_()).name = param2;
               return _loc4_;
            }
         }
         catch(e:Error)
         {
         }
         return null;
      }
   }
}
