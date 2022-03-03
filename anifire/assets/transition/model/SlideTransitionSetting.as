package anifire.assets.transition.model
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.interfaces.IDestination;
   import anifire.interfaces.IXmlConvertable;
   
   public class SlideTransitionSetting extends TransitionSetting implements IDestination, IXmlConvertable
   {
       
      
      private var _dest:DestinationSetting;
      
      public function SlideTransitionSetting()
      {
         this._dest = new DestinationSetting();
         super();
      }
      
      public function set destination(param1:uint) : void
      {
         if(param1 != this._dest.destination)
         {
            this._dest.destination = param1;
         }
      }
      
      public function get destination() : uint
      {
         return this._dest.destination;
      }
      
      public function convertToXml() : XML
      {
         return new XML("<" + AssetTransitionConstants.TAG_NAME_TRANSITION_SETTING + " dest=\"" + ({this._dest.destination}) + "\"></" + AssetTransitionConstants.TAG_NAME_TRANSITION_SETTING + ">");
      }
      
      public function convertFromXml(param1:XML) : Boolean
      {
         if(param1.hasOwnProperty("@dest"))
         {
            this._dest.destination = uint(param1.@dest);
            return true;
         }
         return false;
      }
      
      override public function clone() : TransitionSetting
      {
         var _loc1_:SlideTransitionSetting = new SlideTransitionSetting();
         _loc1_.destination = this.destination;
         return _loc1_;
      }
   }
}
