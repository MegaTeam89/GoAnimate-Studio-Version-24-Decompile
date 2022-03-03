package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.sxi8;
   
   public final class FSM_decode_packed_entry_number extends Machine
   {
       
      
      public function FSM_decode_packed_entry_number()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(_loc1_ + 40);
         _loc3_ = int(li32(_loc1_ + 36));
         mstate.esp -= 8;
         si32(_loc4_ = li32(mstate.ebp + 12),mstate.esp);
         si32(_loc3_,mstate.esp + 4);
         mstate.esp -= 4;
         FSM_oggpack_look.start();
         _loc3_ = int(mstate.eax);
         mstate.esp += 8;
         if(_loc3_ >= 0)
         {
            _loc5_ = int(li32(_loc1_ + 32));
            _loc3_ <<= 2;
            _loc3_ = int(_loc5_ + _loc3_);
            _loc3_ = int(li32(_loc3_));
            if(_loc3_ <= -1)
            {
               _loc5_ = int(_loc3_ >>> 15);
               _loc6_ = int(li32(_loc1_ + 8));
               _loc3_ &= 32767;
               _loc3_ = int(_loc6_ - _loc3_);
               _loc5_ &= 32767;
               addr255:
               mstate.esp -= 8;
               si32(_loc4_,mstate.esp);
               si32(_loc2_,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_oggpack_look.start();
               _loc6_ = int(mstate.eax);
               mstate.esp += 8;
               while(_loc2_ >= 2)
               {
                  if(_loc6_ >= 0)
                  {
                     break;
                  }
                  mstate.esp -= 8;
                  _loc2_ += -1;
                  si32(_loc4_,mstate.esp);
                  si32(_loc2_,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_oggpack_look.start();
                  _loc6_ = int(mstate.eax);
                  mstate.esp += 8;
               }
               if(_loc6_ >= 0)
               {
                  _loc7_ = _loc6_ << 16;
                  _loc7_ = (_loc6_ = (_loc6_ >>>= 16) | _loc7_) << 8;
                  _loc6_ >>>= 8;
                  _loc7_ &= -16711936;
                  _loc7_ = (_loc6_ = (_loc6_ &= 16711935) | _loc7_) << 4;
                  _loc6_ >>>= 4;
                  _loc7_ &= -252645136;
                  _loc7_ = (_loc6_ = (_loc6_ &= 252645135) | _loc7_) << 2;
                  _loc6_ >>>= 2;
                  _loc7_ &= -858993460;
                  _loc7_ = (_loc6_ = (_loc6_ &= 858993459) | _loc7_) << 1;
                  _loc6_ >>>= 1;
                  _loc7_ &= -1431655766;
                  _loc6_ &= 1431655765;
                  _loc8_ = _loc1_ + 20;
                  _loc6_ |= _loc7_;
                  while(true)
                  {
                     _loc7_ = int(_loc5_);
                     if((_loc5_ = int(_loc3_ - _loc7_)) <= 1)
                     {
                        break;
                     }
                     _loc5_ >>= 1;
                     _loc9_ = int(_loc7_ + _loc5_);
                     _loc10_ = li32(_loc8_);
                     _loc9_ <<= 2;
                     _loc9_ = int(li32(_loc9_ = int(_loc10_ + _loc9_)));
                     _loc9_ = (_loc9_ = int(uint(_loc9_) > uint(_loc6_) ? 1 : 0)) & 1;
                     _loc10_ = 0 - _loc9_;
                     _loc9_ = (_loc9_ += -1) & _loc5_;
                     _loc5_ &= _loc10_;
                     _loc3_ -= _loc5_;
                     _loc5_ = int(_loc9_ + _loc7_);
                  }
                  _loc1_ = li32(_loc1_ + 28);
                  _loc1_ += _loc7_;
                  _loc1_ = si8(li8(_loc1_));
                  if(_loc1_ <= _loc2_)
                  {
                     mstate.esp -= 8;
                     si32(_loc4_,mstate.esp);
                     si32(_loc1_,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_oggpack_adv.start();
                     mstate.esp += 8;
                     mstate.eax = _loc7_;
                     §§goto(addr660);
                  }
                  else
                  {
                     _loc1_ = -1;
                     mstate.esp -= 8;
                     si32(_loc4_,mstate.esp);
                     si32(_loc2_,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_oggpack_adv.start();
                     mstate.esp += 8;
                  }
                  §§goto(addr660);
               }
               else
               {
                  _loc1_ = -1;
               }
               mstate.eax = _loc1_;
            }
            else
            {
               _loc1_ = li32(_loc1_ + 28);
               _loc2_ = _loc3_ + -1;
               _loc1_ += _loc2_;
               _loc1_ = si8(li8(_loc1_));
               mstate.esp -= 8;
               si32(_loc4_,mstate.esp);
               si32(_loc1_,mstate.esp + 4);
               mstate.esp -= 4;
               FSM_oggpack_adv.start();
               mstate.esp += 8;
               mstate.eax = _loc2_;
            }
            addr660:
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         _loc3_ = 0;
         _loc6_ = int(li32(_loc1_ + 8));
         _loc5_ = int(_loc3_);
         _loc3_ = int(_loc6_);
         §§goto(addr255);
      }
   }
}
