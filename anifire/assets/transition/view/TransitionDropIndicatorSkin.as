package anifire.assets.transition.view
{
   import mx.skins.ProgrammaticSkin;
   
   public class TransitionDropIndicatorSkin extends ProgrammaticSkin
   {
       
      
      public function TransitionDropIndicatorSkin()
      {
         super();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         graphics.clear();
         graphics.lineStyle(2,7978021);
         graphics.moveTo(0,0);
         graphics.lineTo(param1,0);
      }
   }
}
