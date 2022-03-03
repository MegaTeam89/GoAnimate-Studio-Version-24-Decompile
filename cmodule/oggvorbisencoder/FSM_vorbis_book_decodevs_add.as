package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_vorbis_book_decodevs_add extends Machine
   {
       
      
      public function FSM_vorbis_book_decodevs_add()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 16);
         _loc3_ = li32(mstate.ebp + 20);
         _loc4_ = li32(_loc1_ + 8);
         _loc5_ = li32(mstate.ebp + 12);
         if(_loc4_ <= 0)
         {
            addr108:
            _loc1_ = 0;
         }
         else
         {
            _loc4_ = 0;
            _loc6_ = int(li32(_loc1_));
            _loc7_ = _loc3_ / _loc6_;
            _loc8_ = mstate.esp;
            _loc9_ = _loc7_ << 2;
            _loc8_ -= _loc9_;
            mstate.esp = _loc8_;
            _loc9_ = int(_loc1_ + 16);
            _loc10_ = _loc1_;
            _loc11_ = _loc8_;
            while(true)
            {
               _loc12_ = _loc4_;
               _loc4_ = _loc11_;
               if(_loc12_ < _loc7_)
               {
                  mstate.esp -= 8;
                  si32(_loc1_,mstate.esp);
                  si32(_loc2_,mstate.esp + 4);
                  mstate.esp -= 4;
                  FSM_decode_packed_entry_number.start();
                  _loc13_ = mstate.eax;
                  mstate.esp += 8;
                  if(_loc13_ == -1)
                  {
                     _loc1_ = -1;
                     break;
                  }
                  continue;
               }
               _loc1_ = 0;
               _loc3_ /= _loc6_;
               _loc6_ = _loc3_ << 2;
               _loc3_ = _loc5_;
               while(true)
               {
                  _loc2_ = li32(_loc10_);
                  if(_loc2_ <= _loc1_)
                  {
                     break;
                  }
                  _loc2_ = _loc5_ = 0;
                  while(_loc5_ < _loc7_)
                  {
                     _loc4_ = li32(_loc4_ = _loc8_ + _loc2_);
                     _loc9_ = _loc1_ << 2;
                     _loc4_ += _loc9_;
                     _loc15_ = lf32(_loc9_ = int(_loc3_ + _loc2_));
                     _loc16_ = lf32(_loc4_);
                     sf32(_loc15_ = _loc15_ += _loc16_,_loc9_);
                     _loc2_ += 4;
                     _loc5_ += 1;
                  }
                  _loc3_ = _loc6_ + _loc3_;
                  _loc1_ += 1;
               }
               §§goto(addr108);
            }
         }
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
