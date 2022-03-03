package anifire.interfaces
{
   import anifire.effect.SuperEffect;
   
   public interface IEffectProduct extends IProduct
   {
       
      
      function getNewEffect(param1:XML = null) : SuperEffect;
   }
}
