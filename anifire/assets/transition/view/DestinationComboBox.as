package anifire.assets.transition.view
{
   import anifire.assets.transition.AssetTransitionConstants;
   import com.IconComboBox;
   import mx.core.IFlexModuleFactory;
   
   public class DestinationComboBox extends IconComboBox
   {
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public const arr_uppercenter:Class = DestinationComboBox_arr_uppercenter;
      
      public const arr_upperright:Class = DestinationComboBox_arr_upperright;
      
      public const arr_right:Class = DestinationComboBox_arr_right;
      
      public const arr_lowerright:Class = DestinationComboBox_arr_lowerright;
      
      public const arr_lowercenter:Class = DestinationComboBox_arr_lowercenter;
      
      public const arr_lowerleft:Class = DestinationComboBox_arr_lowerleft;
      
      public const arr_left:Class = DestinationComboBox_arr_left;
      
      public const arr_upperleft:Class = DestinationComboBox_arr_upperleft;
      
      public const arr_center:Class = DestinationComboBox_arr_center;
      
      public var reverse:Boolean = false;
      
      public function DestinationComboBox()
      {
         super();
         this.iconFunction = this.geticon;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      private function geticon(param1:Object) : Class
      {
         try
         {
            if(this.reverse)
            {
               switch(param1.id)
               {
                  case AssetTransitionConstants.DEST_TL:
                     return this.arr_lowerright;
                  case AssetTransitionConstants.DEST_TOP:
                     return this.arr_lowercenter;
                  case AssetTransitionConstants.DEST_TR:
                     return this.arr_lowerleft;
                  case AssetTransitionConstants.DEST_LEFT:
                     return this.arr_right;
                  case AssetTransitionConstants.DEST_RIGHT:
                     return this.arr_left;
                  case AssetTransitionConstants.DEST_BL:
                     return this.arr_upperright;
                  case AssetTransitionConstants.DEST_BOTTOM:
                     return this.arr_uppercenter;
                  case AssetTransitionConstants.DEST_BR:
                     return this.arr_upperleft;
               }
            }
            else
            {
               switch(param1.id)
               {
                  case AssetTransitionConstants.DEST_TL:
                     return this.arr_upperleft;
                  case AssetTransitionConstants.DEST_TOP:
                     return this.arr_uppercenter;
                  case AssetTransitionConstants.DEST_TR:
                     return this.arr_upperright;
                  case AssetTransitionConstants.DEST_LEFT:
                     return this.arr_left;
                  case AssetTransitionConstants.DEST_RIGHT:
                     return this.arr_right;
                  case AssetTransitionConstants.DEST_BL:
                     return this.arr_lowerleft;
                  case AssetTransitionConstants.DEST_BOTTOM:
                     return this.arr_lowercenter;
                  case AssetTransitionConstants.DEST_BR:
                     return this.arr_lowerright;
               }
            }
         }
         catch(e:Error)
         {
         }
         return null;
      }
   }
}
