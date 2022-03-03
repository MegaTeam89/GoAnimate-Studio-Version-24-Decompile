package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_vorbis_bitrate_flushpacket extends Machine
   {
       
      
      public function FSM_vorbis_bitrate_flushpacket()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc1_ = li32(_loc1_ + 104);
         _loc2_ = li32(_loc1_ + 120);
         _loc3_ = li32(mstate.ebp + 12);
         if(_loc2_ != 0)
         {
            if(_loc3_ != 0)
            {
               _loc4_ = int(li32((_loc4_ = int(li32(_loc2_ + 64))) + 104));
               _loc5_ = int(li32(_loc2_ + 104));
               if((_loc6_ = _loc4_ + 80) != 0)
               {
                  if((_loc4_ = int(li32(_loc4_ + 80))) != 0)
                  {
                     _loc4_ = int(li32(_loc1_ + 124));
                  }
                  else
                  {
                     addr112:
                     _loc4_ = 7;
                  }
                  _loc6_ = 0;
                  _loc4_ <<= 2;
                  si32(_loc5_ = int(li32((_loc5_ = int(li32((_loc4_ = int(_loc5_ + _loc4_)) + 12))) + 8)),_loc3_);
                  _loc7_ = int((_loc7_ = (_loc5_ = int((_loc5_ = int(li32((_loc4_ = int(li32(_loc4_ + 12))) + 4))) + 7)) >> 31) >>> 29);
                  _loc5_ += _loc7_;
                  _loc4_ = int(li32(_loc4_));
                  _loc5_ >>= 3;
                  si32(_loc4_ += _loc5_,_loc3_ + 4);
                  si32(_loc6_,_loc3_ + 8);
                  si32(_loc4_ = int(li32(_loc2_ + 44)),_loc3_ + 12);
                  _loc4_ = int(li32(_loc2_ + 48));
                  _loc5_ = int(li32(_loc2_ + 52));
                  si32(_loc4_,_loc3_ + 16);
                  si32(_loc5_,_loc3_ + 20);
                  _loc4_ = int(li32(_loc2_ + 56));
                  _loc2_ = li32(_loc2_ + 60);
                  si32(_loc4_,_loc3_ + 24);
                  si32(_loc2_,_loc3_ + 28);
                  §§goto(addr266);
               }
               §§goto(addr112);
            }
            §§goto(addr266);
         }
         else
         {
            _loc1_ = 0;
         }
         addr266:
         _loc2_ = 0;
         si32(_loc2_,_loc1_ + 120);
         _loc1_ = 1;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
