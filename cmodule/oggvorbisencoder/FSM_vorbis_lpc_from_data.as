package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_vorbis_lpc_from_data extends Machine
   {
       
      
      public function FSM_vorbis_lpc_from_data()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 20);
         _loc2_ = int(_loc1_ + 1);
         _loc3_ = int(mstate.esp);
         _loc2_ <<= 3;
         _loc2_ = int(_loc3_ - _loc2_);
         mstate.esp = _loc2_;
         _loc3_ = _loc1_ << 3;
         _loc4_ = (_loc4_ = mstate.esp) - _loc3_;
         mstate.esp = _loc4_;
         _loc5_ = li32(mstate.ebp + 8);
         _loc6_ = li32(mstate.ebp + 12);
         _loc7_ = _loc1_ << 2;
         _loc3_ = int(_loc2_ + _loc3_);
         _loc8_ = li32(mstate.ebp + 16);
         _loc9_ = _loc4_;
         _loc10_ = _loc2_;
         _loc11_ = _loc1_;
         while(true)
         {
            _loc14_ = _loc3_;
            _loc12_ = _loc7_;
            _loc13_ = _loc11_;
            _loc11_ = _loc14_;
            if(_loc13_ == -1)
            {
               break;
            }
            _loc17_ = 0;
            _loc7_ = int(_loc5_);
            _loc3_ = int(_loc13_);
            while(true)
            {
               _loc15_ = _loc7_;
               if(_loc3_ >= _loc8_)
               {
                  break;
               }
               _loc18_ = lf32(_loc16_ = _loc12_ + _loc7_);
               _loc19_ = lf32(_loc15_);
               _loc18_ *= _loc19_;
               _loc7_ += 4;
               _loc3_ += 1;
               _loc17_ = _loc18_ + _loc17_;
            }
            sf64(_loc17_,_loc11_);
            _loc3_ = int(_loc14_ + -8);
            _loc7_ = int(_loc12_ + -4);
            _loc11_ = _loc13_ + -1;
         }
         _loc3_ = 0;
         _loc18_ = (_loc17_ = lf64(_loc2_)) * 1e-9;
         _loc2_ = int(_loc9_ + -8);
         _loc18_ += 1e-10;
         _loc17_ *= 1;
         _loc5_ = _loc3_;
         while(true)
         {
            if(_loc3_ >= _loc1_)
            {
               _loc17_ = 0.99;
               _loc5_ = 0;
               _loc3_ = int(_loc9_);
               break;
            }
            _loc19_ = lf64((_loc7_ = int(_loc10_ + _loc5_)) + 8);
            if(_loc17_ < _loc18_)
            {
               _loc5_ = 0;
               _loc2_ = _loc3_ << 3;
               _loc2_ = int(_loc4_ + _loc2_);
               _loc3_ = int(_loc1_ - _loc3_);
               _loc4_ = _loc5_;
               _loc3_ <<= 3;
            }
            continue;
            memset(_loc2_,_loc4_,_loc3_);
            _loc17_ = 0.99;
            _loc3_ = int(_loc9_);
            break;
         }
         while(true)
         {
            _loc2_ = int(_loc3_);
            _loc3_ = int(_loc5_);
            _loc5_ = _loc2_;
            if(_loc3_ >= _loc1_)
            {
               break;
            }
            sf64(_loc18_ = (_loc18_ = lf64(_loc5_)) * _loc17_,_loc5_);
            _loc5_ = _loc2_ + 8;
            _loc2_ = int(_loc3_ + 1);
            _loc17_ *= 0.99;
            _loc3_ = int(_loc5_);
            _loc5_ = _loc2_;
         }
         _loc2_ = 0;
         _loc3_ = int(_loc9_);
         _loc4_ = _loc6_;
         while(true)
         {
            _loc5_ = _loc3_;
            _loc3_ = int(_loc6_ = _loc4_);
            _loc4_ = _loc5_;
            if(_loc2_ >= _loc1_)
            {
               break;
            }
            sf32(_loc17_ = _loc17_ = lf64(_loc4_),_loc3_);
            _loc3_ = int(_loc5_ + 8);
            _loc4_ = _loc6_ + 4;
            _loc2_ += 1;
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
