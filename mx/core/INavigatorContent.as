package mx.core
{
   import mx.managers.IToolTipManagerClient;
   
   public interface INavigatorContent extends IDeferredContentOwner, IToolTipManagerClient
   {
       
      
      [Bindable("labelChanged")]
      function get label() : String;
      
      [Bindable("iconChanged")]
      function get icon() : Class;
   }
}
