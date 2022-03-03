package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_vorbis_book_decode extends Machine
   {
       
      
      public function FSM_vorbis_book_decode()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc3_ = li32(_loc1_ + 8);
         if(_loc3_ >= 1)
         {
            mstate.esp -= 8;
            si32(_loc1_,mstate.esp);
            si32(_loc2_,mstate.esp + 4);
            mstate.esp -= 4;
            FSM_decode_packed_entry_number.start();
            _loc2_ = int(mstate.eax);
            mstate.esp += 8;
            if(_loc2_ >= 0)
            {
               _loc1_ = li32(_loc1_ + 24);
               _loc2_ <<= 2;
               _loc1_ += _loc2_;
               _loc1_ = li32(_loc1_);
            }
            else
            {
               addr132:
               _loc1_ = -1;
            }
            mstate.eax = _loc1_;
            mstate.esp = mstate.ebp;
            mstate.ebp = li32(mstate.esp);
            mstate.esp += 4;
            mstate.esp += 4;
            return;
         }
         §§goto(addr132);
      }
   }
}
