package anifire.cc.view
{
   import anifire.cc.interfaces.ICcPairComponent;
   import anifire.constant.CcLibConstant;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   
   public class CcPairComponent extends CcComponent
   {
       
      
      private var _leftSide:DisplayObjectContainer;
      
      private var _rightSide:DisplayObjectContainer;
      
      public function CcPairComponent()
      {
         super();
      }
      
      public function get leftSide() : DisplayObjectContainer
      {
         return this._leftSide;
      }
      
      public function get rightSide() : DisplayObjectContainer
      {
         return this._rightSide;
      }
      
      override protected function addLoader() : void
      {
         if(this.model is ICcPairComponent)
         {
            if(ICcPairComponent(model).split)
            {
               this._leftSide = this.addDefinition(loader.contentLoaderInfo,this.name + CcLibConstant.LIB_LEFT);
               this._rightSide = this.addDefinition(loader.contentLoaderInfo,this.name + CcLibConstant.LIB_RIGHT);
            }
            else
            {
               this._leftSide = this._rightSide = this.addDefinition(loader.contentLoaderInfo,this.name);
            }
         }
         if(this._leftSide && this._rightSide)
         {
            this.addChild(this._leftSide);
            this.addChild(this._rightSide);
         }
      }
      
      override protected function setProperties() : void
      {
         if(this.model)
         {
            if(this.model is ICcPairComponent)
            {
               if(ICcPairComponent(model).split == false)
               {
                  return;
               }
            }
            if(this._leftSide)
            {
               this._leftSide.x = this.model.x;
               this._leftSide.y = this.model.y;
               this._leftSide.getChildAt(0).scaleX = this.model.xscale;
               this._leftSide.getChildAt(0).scaleY = this.model.yscale;
               this._leftSide.getChildAt(0).rotation = -this.model.rotation;
            }
            if(this._rightSide)
            {
               this._rightSide.x = this.model.x;
               this._rightSide.y = this.model.y;
               this._rightSide.getChildAt(0).scaleX = this.model.xscale;
               this._rightSide.getChildAt(0).scaleY = this.model.yscale;
               this._rightSide.getChildAt(0).rotation = this.model.rotation;
            }
            if(this.model is ICcPairComponent)
            {
               if(this._leftSide)
               {
                  this._leftSide.x += ICcPairComponent(model).offset / 2;
               }
               if(this._rightSide)
               {
                  this._rightSide.x -= ICcPairComponent(model).offset / 2;
               }
            }
         }
      }
      
      protected function addDefinition(param1:LoaderInfo, param2:String) : DisplayObjectContainer
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
