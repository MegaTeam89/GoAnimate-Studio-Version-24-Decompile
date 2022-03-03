package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_vorbis_book_decodev_add extends Machine
   {
       
      
      public function FSM_vorbis_book_decodev_add()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:int = 0;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         _loc3_ = int(li32(_loc1_ + 8));
         _loc4_ = li32(mstate.ebp + 16);
         _loc5_ = li32(mstate.ebp + 20);
         _loc6_ = _loc2_;
         if(_loc3_ <= 0)
         {
            addr109:
            _loc1_ = 0;
         }
         else
         {
            _loc3_ = int(li32(_loc1_));
            _loc7_ = _loc1_ + 16;
            _loc8_ = _loc1_;
            if(_loc3_ <= 8)
            {
               _loc6_ = 0;
               while(true)
               {
                  if(_loc6_ >= _loc5_)
                  {
                     addr108:
                     §§goto(addr109);
                  }
                  else
                  {
                     mstate.esp -= 8;
                     si32(_loc1_,mstate.esp);
                     si32(_loc4_,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_decode_packed_entry_number.start();
                     _loc3_ = int(mstate.eax);
                     mstate.esp += 8;
                     if(_loc3_ != -1)
                     {
                        _loc9_ = li32(_loc7_);
                        _loc3_ = int((_loc10_ = int(li32(_loc8_))) * _loc3_);
                        if(_loc10_ <= 4)
                        {
                           if(_loc10_ <= 2)
                           {
                              if(_loc10_ != 1)
                              {
                                 if(_loc10_ != 2)
                                 {
                                    continue;
                                 }
                                 _loc10_ = 0;
                                 addr758:
                                 _loc11_ = (_loc11_ = int(_loc3_ + _loc10_)) << 2;
                                 _loc12_ = _loc6_ << 2;
                                 _loc11_ = int(_loc9_ + _loc11_);
                                 _loc14_ = lf32(_loc12_ = int(_loc2_ + _loc12_));
                                 _loc15_ = lf32(_loc11_);
                                 sf32(_loc14_ = _loc14_ += _loc15_,_loc12_);
                                 _loc10_ += 1;
                                 _loc6_ += 1;
                              }
                              else
                              {
                                 _loc10_ = 0;
                              }
                              _loc3_ += _loc10_;
                              _loc3_ <<= 2;
                              _loc10_ = _loc6_ << 2;
                              _loc3_ = int(_loc9_ + _loc3_);
                              _loc14_ = lf32(_loc9_ = _loc2_ + _loc10_);
                              _loc15_ = lf32(_loc3_);
                              sf32(_loc14_ = _loc14_ += _loc15_,_loc9_);
                              _loc6_ += 1;
                              continue;
                           }
                           if(_loc10_ != 3)
                           {
                              if(_loc10_ != 4)
                              {
                                 continue;
                              }
                              _loc10_ = 0;
                              addr654:
                              _loc11_ = (_loc11_ = int(_loc3_ + _loc10_)) << 2;
                              _loc12_ = _loc6_ << 2;
                              _loc11_ = int(_loc9_ + _loc11_);
                              _loc14_ = lf32(_loc12_ = int(_loc2_ + _loc12_));
                              _loc15_ = lf32(_loc11_);
                              sf32(_loc14_ = _loc14_ += _loc15_,_loc12_);
                              _loc10_ += 1;
                              _loc6_ += 1;
                           }
                           else
                           {
                              _loc10_ = 0;
                           }
                           _loc11_ = (_loc11_ = int(_loc3_ + _loc10_)) << 2;
                           _loc12_ = _loc6_ << 2;
                           _loc11_ = int(_loc9_ + _loc11_);
                           _loc14_ = lf32(_loc12_ = int(_loc2_ + _loc12_));
                           _loc15_ = lf32(_loc11_);
                           sf32(_loc14_ = _loc14_ += _loc15_,_loc12_);
                           _loc10_ += 1;
                           _loc6_ += 1;
                           §§goto(addr758);
                        }
                        else
                        {
                           if(_loc10_ <= 6)
                           {
                              if(_loc10_ != 5)
                              {
                                 if(_loc10_ != 6)
                                 {
                                    continue;
                                 }
                                 _loc10_ = 0;
                                 addr550:
                                 _loc11_ = (_loc11_ = int(_loc3_ + _loc10_)) << 2;
                                 _loc12_ = _loc6_ << 2;
                                 _loc11_ = int(_loc9_ + _loc11_);
                                 _loc14_ = lf32(_loc12_ = int(_loc2_ + _loc12_));
                                 _loc15_ = lf32(_loc11_);
                                 sf32(_loc14_ = _loc14_ += _loc15_,_loc12_);
                                 _loc10_ += 1;
                                 _loc6_ += 1;
                              }
                              else
                              {
                                 _loc10_ = 0;
                              }
                              _loc11_ = (_loc11_ = int(_loc3_ + _loc10_)) << 2;
                              _loc12_ = _loc6_ << 2;
                              _loc11_ = int(_loc9_ + _loc11_);
                              _loc14_ = lf32(_loc12_ = int(_loc2_ + _loc12_));
                              _loc15_ = lf32(_loc11_);
                              sf32(_loc14_ = _loc14_ += _loc15_,_loc12_);
                              _loc10_ += 1;
                              _loc6_ += 1;
                              §§goto(addr654);
                           }
                           else
                           {
                              if(_loc10_ != 8)
                              {
                                 if(_loc10_ != 7)
                                 {
                                    continue;
                                 }
                                 _loc10_ = 0;
                              }
                              else
                              {
                                 _loc10_ = 1;
                                 _loc11_ = _loc6_ << 2;
                                 _loc12_ = _loc3_ << 2;
                                 _loc11_ = int(_loc2_ + _loc11_);
                                 _loc12_ = int(_loc9_ + _loc12_);
                                 _loc14_ = lf32(_loc11_);
                                 _loc15_ = lf32(_loc12_);
                                 sf32(_loc14_ = _loc14_ += _loc15_,_loc11_);
                                 _loc6_ += 1;
                              }
                              _loc11_ = (_loc11_ = int(_loc3_ + _loc10_)) << 2;
                              _loc12_ = _loc6_ << 2;
                              _loc11_ = int(_loc9_ + _loc11_);
                              _loc14_ = lf32(_loc12_ = int(_loc2_ + _loc12_));
                              _loc15_ = lf32(_loc11_);
                              sf32(_loc14_ = _loc14_ += _loc15_,_loc12_);
                              _loc10_ += 1;
                              _loc6_ += 1;
                           }
                           §§goto(addr550);
                        }
                     }
                  }
                  §§goto(addr114);
               }
            }
            else
            {
               _loc2_ = 0;
               while(true)
               {
                  if(_loc2_ >= _loc5_)
                  {
                     §§goto(addr108);
                  }
                  else
                  {
                     mstate.esp -= 8;
                     si32(_loc1_,mstate.esp);
                     si32(_loc4_,mstate.esp + 4);
                     mstate.esp -= 4;
                     FSM_decode_packed_entry_number.start();
                     _loc3_ = int(mstate.eax);
                     mstate.esp += 8;
                     if(_loc3_ != -1)
                     {
                        continue;
                     }
                  }
               }
               §§goto(addr114);
            }
            _loc2_ = -1;
            _loc1_ = _loc2_;
         }
         addr114:
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
