package anifire.util
{
   import anifire.util.Crypto.RC4;
   import anifire.util.Crypto.TEA;
   import flash.utils.ByteArray;
   
   public class UtilCrypto
   {
      
      public static const MODE_DECRYPT_SWF:int = 0;
      
      public static const MODE_DECRYPT_RTMPE_TOKEN:int = 1;
      
      private static const KEY_MODE_DECRYPT_SWF:String = "g0o1a2n3i4m5a6t7e";
      
      private static const KEY_MODE_DECRYPT_RTMPE_TOKEN:String = "gaGh0hiaEb8wa4wi";
       
      
      private var key:ByteArray;
      
      private var _mode:int;
      
      public function UtilCrypto(param1:int = 0)
      {
         var _loc2_:int = 0;
         this.key = new ByteArray();
         super();
         this._mode = param1;
         if(this._mode == MODE_DECRYPT_SWF)
         {
            _loc2_ = 0;
            while(_loc2_ < KEY_MODE_DECRYPT_SWF.length)
            {
               this.key[_loc2_] = KEY_MODE_DECRYPT_SWF.charCodeAt(_loc2_) as uint;
               _loc2_++;
            }
         }
         else if(this._mode == MODE_DECRYPT_RTMPE_TOKEN)
         {
         }
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:RC4 = null;
         if(this._mode == MODE_DECRYPT_SWF)
         {
            _loc2_ = new RC4(this.key);
            _loc2_.init(this.key);
            _loc2_.decrypt(param1);
         }
      }
      
      public function decryptString(param1:String) : String
      {
         var _loc2_:String = null;
         if(this._mode == MODE_DECRYPT_RTMPE_TOKEN)
         {
            _loc2_ = TEA.decrypt(param1,KEY_MODE_DECRYPT_RTMPE_TOKEN);
         }
         return _loc2_;
      }
   }
}
