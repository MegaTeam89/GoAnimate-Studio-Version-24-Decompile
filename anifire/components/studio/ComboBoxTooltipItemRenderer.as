package anifire.components.studio
{
   import mx.controls.Label;
   import mx.events.PropertyChangeEvent;
   
   public class ComboBoxTooltipItemRenderer extends Label
   {
       
      
      public function ComboBoxTooltipItemRenderer()
      {
         super();
      }
      
      public function set _3076010data(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.data = param1;
         this.toolTip = String(Object(param1).label);
      }
      
      [Bindable(event="propertyChange")]
      override public function set data(param1:Object) : void
      {
         var _loc2_:Object = this.data;
         if(_loc2_ !== param1)
         {
            this._3076010data = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"data",_loc2_,param1));
            }
         }
      }
   }
}
