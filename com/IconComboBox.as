package com
{
   import flash.display.DisplayObject;
   import mx.controls.ComboBox;
   import mx.controls.List;
   import mx.core.ClassFactory;
   import mx.events.PropertyChangeEvent;
   
   public class IconComboBox extends ComboBox
   {
       
      
      private var internalDropdownFactory:ClassFactory;
      
      private var displayIconObject:Object;
      
      private var _iconField:String = "icon";
      
      private var _icon4Selected:Boolean = true;
      
      private var _iconFunction:Function;
      
      public function IconComboBox()
      {
         this.internalDropdownFactory = new ClassFactory(List);
         super();
         this.internalDropdownFactory.properties = {
            "iconField":"",
            "iconFunction":null
         };
         dropdownFactory = this.internalDropdownFactory;
      }
      
      private function set _1413851135iconField(param1:String) : void
      {
         this._iconField = param1;
         this.internalDropdownFactory.properties = {"iconField":param1};
      }
      
      public function get iconField() : String
      {
         return this._iconField;
      }
      
      [Bindable(event="propertyChange")]
      public function get icon4Selected() : Boolean
      {
         return this._icon4Selected;
      }
      
      private function set _1125146986icon4Selected(param1:Boolean) : void
      {
         this._icon4Selected = param1;
      }
      
      private function set _1279816847iconFunction(param1:Function) : void
      {
         this._iconFunction = param1;
         this.internalDropdownFactory.properties = {"iconFunction":param1};
      }
      
      public function get iconFunction() : Function
      {
         return this._iconFunction;
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         super.selectedIndex = param1;
         if(param1 != -1)
         {
            if(this.icon4Selected)
            {
               this.showIcon();
            }
         }
      }
      
      private function showIcon() : void
      {
         var _loc1_:Class = this.itemToIcon(dataProvider[selectedIndex]);
         if(getChildByName("displayIconObject"))
         {
            removeChild(getChildByName("displayIconObject"));
         }
         if(!_loc1_)
         {
            textInput.x = 0;
            return;
         }
         this.displayIconObject = new _loc1_();
         this.displayIconObject.name = "displayIconObject";
         addChild(DisplayObject(this.displayIconObject));
         DisplayObject(this.displayIconObject).x = getStyle("cornerRadius");
         DisplayObject(this.displayIconObject).y = (height - DisplayObject(this.displayIconObject).height) / 2;
         textInput.x = DisplayObject(this.displayIconObject).width + getStyle("cornerRadius");
      }
      
      override public function set measuredWidth(param1:Number) : void
      {
      }
      
      public function itemToIcon(param1:Object) : Class
      {
         var _loc2_:Class = null;
         var _loc3_:* = undefined;
         if(param1 == null)
         {
            return null;
         }
         if(this.iconFunction != null)
         {
            return this.iconFunction(param1);
         }
         if(param1 is XML)
         {
            try
            {
               if(param1[this.iconField].length() != 0)
               {
                  _loc3_ = String(param1[this.iconField]);
                  if(_loc3_ != null)
                  {
                     _loc2_ = Class(systemManager.getDefinitionByName(_loc3_));
                     if(_loc2_)
                     {
                        return _loc2_;
                     }
                     return document[_loc3_];
                  }
               }
            }
            catch(e:Error)
            {
            }
         }
         else if(param1 is Object)
         {
            try
            {
               if(param1[this.iconField] != null)
               {
                  if(param1[this.iconField] is Class)
                  {
                     return param1[this.iconField];
                  }
                  if(param1[this.iconField] is String)
                  {
                     _loc2_ = Class(systemManager.getDefinitionByName(param1[this.iconField]));
                     if(_loc2_)
                     {
                        return _loc2_;
                     }
                     return document[param1[this.iconField]];
                  }
               }
            }
            catch(e:Error)
            {
            }
         }
         return null;
      }
      
      [Bindable(event="propertyChange")]
      public function set iconFunction(param1:Function) : void
      {
         var _loc2_:Object = this.iconFunction;
         if(_loc2_ !== param1)
         {
            this._1279816847iconFunction = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconFunction",_loc2_,param1));
            }
         }
      }
      
      public function set icon4Selected(param1:Boolean) : void
      {
         var _loc2_:Object = this.icon4Selected;
         if(_loc2_ !== param1)
         {
            this._1125146986icon4Selected = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"icon4Selected",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function set iconField(param1:String) : void
      {
         var _loc2_:Object = this.iconField;
         if(_loc2_ !== param1)
         {
            this._1413851135iconField = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iconField",_loc2_,param1));
            }
         }
      }
   }
}
