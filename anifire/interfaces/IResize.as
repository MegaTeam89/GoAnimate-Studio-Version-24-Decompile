package anifire.interfaces
{
   import anifire.control.Control;
   
   public interface IResize
   {
       
      
      function startResize() : void;
      
      function resizing(param1:Control) : void;
      
      function endResize() : void;
   }
}
