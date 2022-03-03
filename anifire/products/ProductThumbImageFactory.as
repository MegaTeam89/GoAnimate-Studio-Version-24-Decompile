package anifire.products
{
   import anifire.interfaces.IBackgroundProduct;
   import anifire.interfaces.IBubbleProduct;
   import anifire.interfaces.ICharProduct;
   import anifire.interfaces.IEffectProduct;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductImage;
   import anifire.interfaces.IPropProduct;
   import flash.events.IEventDispatcher;
   
   public class ProductThumbImageFactory extends AbstractProductImageFactory
   {
       
      
      public function ProductThumbImageFactory(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      override public function createImage(param1:IProduct) : IProductImage
      {
         if(param1 is IPropProduct)
         {
            return new PropThumbImage();
         }
         if(param1 is IBackgroundProduct)
         {
            return new BackgroundThumbImage();
         }
         if(param1 is ICharProduct)
         {
            return new CharacterThumbImage();
         }
         if(param1 is IEffectProduct)
         {
            return new EffectThumbImage();
         }
         if(param1 is IBubbleProduct)
         {
            return new BubbleThumbImage();
         }
         return new ProductImage();
      }
   }
}
