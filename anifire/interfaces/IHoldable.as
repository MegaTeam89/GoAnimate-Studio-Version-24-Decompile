package anifire.interfaces
{
   import anifire.core.Prop;
   
   public interface IHoldable
   {
       
      
      function get prop() : Prop;
      
      function addProp(param1:Prop) : void;
      
      function removeProp() : void;
   }
}
