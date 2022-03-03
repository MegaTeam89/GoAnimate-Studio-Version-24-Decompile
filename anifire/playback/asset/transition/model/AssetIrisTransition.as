package anifire.playback.asset.transition.model
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.AssetTransitionNode;
   import anifire.playback.asset.transition.interfaces.IShape;
   import fl.transitions.Iris;
   
   public class AssetIrisTransition extends AssetTransition implements IShape
   {
       
      
      private var _shape:String = "SQUARE";
      
      public function AssetIrisTransition()
      {
         super();
      }
      
      override public function init(param1:AssetTransitionNode) : void
      {
         super.init(param1);
         if(this.type == AssetTransitionConstants.TYPE_IRIS_CIRCLE)
         {
            this._shape = Iris.CIRCLE;
         }
      }
      
      public function get shape() : String
      {
         return this._shape;
      }
   }
}
