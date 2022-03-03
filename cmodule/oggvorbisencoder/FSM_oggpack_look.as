package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_oggpack_look extends Machine
   {
       
      
      public function FSM_oggpack_look()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc2_ = li32(mstate.ebp + 12);
         if(uint(_loc2_) >= uint(33))
         {
            addr72:
            _loc1_ = -1;
         }
         else
         {
            _loc3_ = _mask;
            _loc4_ = _loc2_ << 2;
            _loc3_ += _loc4_;
            _loc4_ = int(li32(_loc1_ + 4));
            _loc5_ = int(li32(_loc1_ + 16));
            _loc3_ = li32(_loc3_);
            _loc6_ = int(li32(_loc1_));
            _loc2_ = _loc4_ + _loc2_;
            _loc7_ = int(_loc5_ + -4);
            if(_loc6_ >= _loc7_)
            {
               _loc7_ = (_loc7_ = int(_loc2_ + 7)) >> 3;
               _loc5_ -= _loc7_;
               if(_loc6_ <= _loc5_)
               {
                  if(_loc2_ == 0)
                  {
                     _loc1_ = 0;
                  }
                  §§goto(addr279);
               }
               else
               {
                  §§goto(addr72);
               }
            }
            _loc1_ = int(li32(_loc1_ + 12));
            _loc5_ = int((_loc5_ = int(li8(_loc1_))) >>> _loc4_);
            if(_loc2_ <= 8)
            {
               _loc1_ = int(_loc5_);
            }
            else
            {
               _loc6_ = int(li8(_loc1_ + 1));
               _loc7_ = int(8 - _loc4_);
               _loc5_ = (_loc6_ <<= _loc7_) | _loc5_;
               if(_loc2_ <= 16)
               {
                  _loc1_ = int(_loc5_);
               }
               else
               {
                  _loc6_ = int(li8(_loc1_ + 2));
                  _loc7_ = int(16 - _loc4_);
                  _loc5_ = (_loc6_ <<= _loc7_) | _loc5_;
                  if(_loc2_ <= 24)
                  {
                     _loc1_ = int(_loc5_);
                  }
                  else
                  {
                     _loc6_ = int(li8(_loc1_ + 3));
                     _loc7_ = int(24 - _loc4_);
                     _loc5_ = (_loc6_ <<= _loc7_) | _loc5_;
                     if(_loc4_ != 0)
                     {
                        if(_loc2_ > 32)
                        {
                           _loc1_ = int(li8(_loc1_ + 4));
                           _loc2_ = 32 - _loc4_;
                           _loc1_ <<= _loc2_;
                           _loc1_ |= _loc5_;
                        }
                        §§goto(addr275);
                     }
                     _loc1_ = int(_loc5_);
                  }
               }
            }
            addr275:
            _loc1_ = _loc3_ & _loc1_;
            §§goto(addr279);
         }
         addr279:
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
