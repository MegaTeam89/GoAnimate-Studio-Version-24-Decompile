package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM__UTF8_wcrtomb extends Machine
   {
       
      
      public function FSM__UTF8_wcrtomb()
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
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 16);
         _loc2_ = li32(mstate.ebp + 8);
         _loc1_ = li32(_loc1_ + 4);
         _loc3_ = int(li32(mstate.ebp + 12));
         _loc4_ = _loc2_;
         if(_loc1_ != 0)
         {
            _loc2_ = 22;
            si32(_loc2_,_val_2E_939);
            _loc2_ = -1;
            mstate.eax = _loc2_;
         }
         else
         {
            if(_loc2_ != 0)
            {
               if(uint(_loc3_) <= uint(127))
               {
                  _loc4_ = 1;
                  si8(_loc3_,_loc2_);
                  mstate.eax = _loc4_;
                  §§goto(addr256);
               }
               else if(uint(_loc3_) <= uint(2047))
               {
                  _loc1_ = 2;
                  _loc5_ = 192;
                  addr181:
                  _loc6_ = int(_loc3_);
                  if((_loc7_ = _loc1_ + -1) <= 0)
                  {
                     _loc3_ = int(_loc6_);
                  }
                  else
                  {
                     _loc7_ = _loc1_ + -1;
                     while(true)
                     {
                        _loc6_ = (_loc6_ |= -128) & -65;
                        _loc8_ = _loc4_ + _loc7_;
                        si8(_loc6_,_loc8_);
                        _loc6_ = _loc3_ >> 6;
                        _loc3_ = int(_loc7_ + -1);
                        _loc8_ = _loc6_;
                        if(_loc3_ <= 0)
                        {
                           break;
                        }
                        _loc7_ = _loc3_;
                        _loc3_ = int(_loc8_);
                     }
                     _loc3_ = int(_loc6_);
                  }
                  _loc3_ |= _loc5_;
                  si8(_loc3_,_loc2_);
               }
               else if(uint(_loc3_) <= uint(65535))
               {
                  _loc1_ = 3;
                  _loc5_ = 224;
                  §§goto(addr181);
               }
               else if(uint(_loc3_) <= uint(2097151))
               {
                  _loc1_ = 4;
                  _loc5_ = 240;
                  §§goto(addr181);
               }
               else if(uint(_loc3_) <= uint(67108863))
               {
                  _loc1_ = 5;
                  _loc5_ = 248;
                  §§goto(addr181);
               }
               else if(_loc3_ >= 0)
               {
                  _loc1_ = 6;
                  _loc5_ = 252;
                  §§goto(addr181);
               }
               else
               {
                  _loc1_ = 86;
                  si32(_loc1_,_val_2E_939);
                  _loc1_ = -1;
               }
               §§goto(addr256);
            }
            else
            {
               _loc1_ = 1;
            }
            mstate.eax = _loc1_;
         }
         addr256:
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}