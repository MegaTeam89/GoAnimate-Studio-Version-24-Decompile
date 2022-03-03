package anifire.playback.asset.transition.hand
{
   import anifire.assets.transition.AssetTransitionConstants;
   import flash.display.MovieClip;
   
   public class HandClip extends MovieClip
   {
       
      
      private var HandImage:Class;
      
      private var _hand:MovieClip;
      
      public function HandClip()
      {
         this.HandImage = HandClip_HandImage;
         super();
         this._hand = new this.HandImage() as MovieClip;
         this._hand.x = -10;
         this._hand.y = 150;
         this.addChild(this._hand);
      }
      
      public function set destination(param1:uint) : void
      {
         switch(param1)
         {
            case AssetTransitionConstants.DEST_TL:
               this.rotation = 135;
               break;
            case AssetTransitionConstants.DEST_TOP:
               this.rotation = 180;
               break;
            case AssetTransitionConstants.DEST_TR:
               this.rotation = -135;
               break;
            case AssetTransitionConstants.DEST_LEFT:
               this.rotation = 90;
               break;
            case AssetTransitionConstants.DEST_RIGHT:
               this.rotation = -90;
               break;
            case AssetTransitionConstants.DEST_BL:
               this.rotation = 45;
               break;
            case AssetTransitionConstants.DEST_BOTTOM:
               this.rotation = 0;
               break;
            case AssetTransitionConstants.DEST_BR:
               this.rotation = -45;
         }
      }
   }
}
