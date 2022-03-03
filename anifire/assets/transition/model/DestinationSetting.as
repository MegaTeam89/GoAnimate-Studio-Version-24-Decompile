package anifire.assets.transition.model
{
   public class DestinationSetting
   {
       
      
      private var _dest:uint = 2;
      
      public function DestinationSetting()
      {
         super();
      }
      
      public function set destination(param1:uint) : void
      {
         if(param1 >= 1 && param1 <= 9)
         {
            if(this._dest != param1)
            {
               this._dest = param1;
            }
         }
      }
      
      public function get destination() : uint
      {
         return this._dest;
      }
   }
}
