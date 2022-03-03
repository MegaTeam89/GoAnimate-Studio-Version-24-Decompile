package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM__float32_unpack extends Machine
   {
       
      
      public function FSM__float32_unpack()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 88;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc2_ = _loc1_ & 2097151;
         _loc7_ = -(_loc6_ = Number(_loc2_));
         sf64(_loc6_ = _loc1_ < 0 ? Number(_loc7_) : Number(_loc6_),mstate.ebp + -8);
         _loc2_ = int(li32(mstate.ebp + -4));
         _loc1_ >>>= 21;
         _loc3_ = int(_loc2_ >>> 20);
         _loc1_ &= 1023;
         _loc4_ = int(li32(mstate.ebp + -8));
         _loc3_ &= 2047;
         _loc1_ += -788;
         _loc5_ = int(_loc2_);
         if((_loc5_ = _loc2_ & 2146435072) != 0)
         {
            _loc4_ = int(_loc3_);
            addr191:
            _loc3_ = int(_loc4_);
            if(_loc3_ == 2047)
            {
               _loc6_ += _loc6_;
            }
            else
            {
               _loc3_ += _loc1_;
               if(_loc3_ >= 2047)
               {
                  _loc1_ = -2013235812;
                  sf64(_loc6_,mstate.ebp + -24);
                  _loc2_ = int(li32(mstate.ebp + -20));
                  _loc2_ |= 2117592124;
                  _loc2_ &= -29891524;
                  si32(_loc1_,mstate.ebp + -32);
                  si32(_loc2_,mstate.ebp + -28);
                  _loc6_ = (_loc6_ = lf64(mstate.ebp + -32)) * 1e+300;
               }
               else if(_loc3_ >= 1)
               {
                  sf64(_loc6_,mstate.ebp + -40);
                  _loc1_ = _loc3_ << 20;
                  _loc2_ &= -2146435073;
                  _loc3_ = int(li32(mstate.ebp + -40));
                  _loc1_ = _loc2_ | _loc1_;
                  si32(_loc3_,mstate.ebp + -48);
                  si32(_loc1_,mstate.ebp + -44);
                  _loc6_ = lf64(mstate.ebp + -48);
               }
               else if(_loc3_ <= -54)
               {
                  sf64(_loc6_,mstate.ebp + -56);
                  _loc2_ = int(li32(mstate.ebp + -56));
                  _loc2_ = int(li32(mstate.ebp + -52));
                  if(_loc1_ >= 50001)
                  {
                     _loc3_ = -2013235812;
                     _loc2_ |= 2117592124;
                     _loc2_ &= -29891524;
                     si32(_loc3_,mstate.ebp + -64);
                     si32(_loc2_,mstate.ebp + -60);
                     _loc6_ = (_loc6_ = lf64(mstate.ebp + -64)) * 1e+300;
                  }
                  else
                  {
                     _loc3_ = -1023872167;
                     _loc2_ |= 27618847;
                     _loc2_ &= -2119864801;
                     si32(_loc3_,mstate.ebp + -72);
                     si32(_loc2_,mstate.ebp + -68);
                     _loc6_ = (_loc6_ = lf64(mstate.ebp + -72)) * 1e-300;
                  }
               }
               else
               {
                  _loc1_ = _loc3_ << 20;
                  sf64(_loc6_,mstate.ebp + -80);
                  _loc1_ += 56623104;
                  _loc2_ &= -2146435073;
                  _loc3_ = int(li32(mstate.ebp + -80));
                  _loc1_ |= _loc2_;
                  si32(_loc3_,mstate.ebp + -88);
                  si32(_loc1_,mstate.ebp + -84);
                  _loc6_ = (_loc6_ = lf64(mstate.ebp + -88)) * 5.55112e-17;
               }
            }
         }
         else
         {
            _loc2_ &= 2147483647;
            _loc2_ |= _loc4_;
            if(_loc2_ != 0)
            {
               sf64(_loc6_ *= 18014400000000000,mstate.ebp + -16);
               _loc2_ = int(li32(mstate.ebp + -12));
               _loc4_ = int((_loc4_ = (_loc4_ = int(_loc2_ >>> 20)) & 2047) + -54);
               if(_loc1_ >= -50000)
               {
                  §§goto(addr191);
               }
               else
               {
                  _loc6_ *= 1e-300;
               }
            }
         }
         _loc6_ = _loc6_;
         mstate.st0 = _loc6_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
