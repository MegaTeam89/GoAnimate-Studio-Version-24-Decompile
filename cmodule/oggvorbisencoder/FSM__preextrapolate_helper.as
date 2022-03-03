package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM__preextrapolate_helper extends Machine
   {
       
      
      public function FSM__preextrapolate_helper()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = 0;
         var _loc16_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 64;
         _loc1_ = 1;
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = int(li32(_loc2_ + 20));
         _loc4_ = mstate.esp;
         _loc5_ = _loc3_ << 2;
         _loc4_ -= _loc5_;
         mstate.esp = _loc4_;
         si32(_loc1_,_loc2_ + 28);
         _loc1_ = int(li32(_loc2_ + 48));
         _loc5_ = int(_loc2_ + 48);
         _loc6_ = _loc2_ + 20;
         _loc7_ = mstate.ebp + -64;
         _loc8_ = _loc4_;
         _loc1_ = int(_loc3_ - _loc1_);
         if(_loc1_ >= 33)
         {
            _loc1_ = 0;
            _loc9_ = _loc2_ + 8;
            _loc2_ += 4;
            while(true)
            {
               _loc12_ = _loc1_;
               _loc11_ = _loc3_;
               _loc1_ = int(li32(_loc2_));
               _loc1_ = int(li32(_loc1_ + 4));
               if(_loc1_ <= _loc12_)
               {
                  break;
               }
               _loc1_ = 0;
               _loc3_ = _loc11_ << 2;
               _loc3_ += -4;
               _loc10_ = int(_loc3_);
               _loc3_ = int(_loc8_);
               while(true)
               {
                  _loc13_ = _loc3_;
                  if(_loc11_ <= _loc1_)
                  {
                     break;
                  }
                  _loc14_ = li32(_loc9_);
                  _loc15_ = _loc12_ << 2;
                  sf32(_loc16_ = lf32(_loc14_ = (_loc14_ = li32(_loc14_ += _loc15_)) + _loc10_),_loc13_);
                  _loc10_ += -4;
                  _loc3_ += 4;
                  _loc1_ += 1;
               }
               _loc1_ = 16;
               _loc3_ = int(li32(_loc5_));
               mstate.esp -= 16;
               _loc3_ = int(_loc11_ - _loc3_);
               si32(_loc4_,mstate.esp);
               si32(_loc7_,mstate.esp + 4);
               si32(_loc3_,mstate.esp + 8);
               si32(_loc1_,mstate.esp + 12);
               mstate.esp -= 4;
               FSM_vorbis_lpc_from_data.start();
               mstate.esp += 16;
               _loc3_ = int(li32(_loc5_));
               _loc11_ = (_loc10_ = (_loc10_ = int((_loc10_ = int(li32(_loc6_))) - _loc3_)) << 2) + _loc4_;
               mstate.esp -= 20;
               _loc11_ += -64;
               _loc10_ = int(_loc4_ + _loc10_);
               si32(_loc7_,mstate.esp);
               si32(_loc11_,mstate.esp + 4);
               si32(_loc1_,mstate.esp + 8);
               si32(_loc10_,mstate.esp + 12);
               si32(_loc3_,mstate.esp + 16);
               mstate.esp -= 4;
               FSM_vorbis_lpc_predict.start();
               mstate.esp += 20;
               _loc1_ = -1;
               _loc3_ = 0;
               _loc10_ = int(_loc8_);
               while(true)
               {
                  _loc13_ = _loc10_;
                  _loc11_ = _loc1_;
                  _loc10_ = int(li32(_loc6_));
                  _loc1_ = int(_loc13_);
                  if(_loc10_ <= _loc3_)
                  {
                     break;
                  }
                  _loc14_ = li32(_loc9_);
                  _loc15_ = _loc12_ << 2;
                  _loc10_ += _loc11_;
                  _loc14_ = li32(_loc14_ += _loc15_);
                  _loc16_ = lf32(_loc1_);
                  _loc1_ = _loc10_ << 2;
                  _loc1_ = int(_loc14_ + _loc1_);
                  sf32(_loc16_,_loc1_);
                  _loc1_ = int(_loc13_ + 4);
                  _loc11_ += -1;
                  _loc3_ += 1;
                  _loc10_ = int(_loc1_);
                  _loc1_ = int(_loc11_);
               }
               _loc1_ = int(_loc12_ + 1);
               _loc3_ = int(_loc10_);
            }
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
