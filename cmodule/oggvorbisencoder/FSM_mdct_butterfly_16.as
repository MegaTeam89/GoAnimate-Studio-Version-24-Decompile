package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_mdct_butterfly_16 extends Machine
   {
       
      
      public function FSM_mdct_butterfly_16()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc2_ = 0.707107;
         _loc1_ = li32(mstate.ebp + 8);
         _loc3_ = lf32(_loc1_ + 4);
         _loc4_ = lf32(_loc1_ + 36);
         _loc5_ = lf32(_loc1_);
         _loc6_ = lf32(_loc1_ + 32);
         _loc7_ = _loc3_ - _loc4_;
         _loc8_ = _loc5_ - _loc6_;
         _loc7_ = _loc7_;
         _loc9_ = _loc9_ = (_loc7_ = _loc7_) + (_loc8_ = Number(_loc8_));
         _loc7_ -= _loc8_;
         _loc5_ = _loc6_ + _loc5_;
         _loc2_ = _loc2_;
         _loc6_ = _loc7_;
         _loc3_ = _loc4_ + _loc3_;
         _loc4_ = _loc9_;
         _loc2_ = _loc2_;
         _loc5_ = _loc5_;
         _loc4_ *= _loc2_;
         _loc6_ = _loc6_;
         sf32(_loc5_,_loc1_ + 32);
         _loc3_ = _loc3_;
         _loc5_ = _loc6_ * _loc2_;
         sf32(_loc3_,_loc1_ + 36);
         _loc3_ = _loc4_;
         sf32(_loc3_,_loc1_);
         _loc3_ = _loc5_;
         sf32(_loc3_,_loc1_ + 4);
         _loc3_ = lf32(_loc1_ + 40);
         _loc4_ = lf32(_loc1_ + 8);
         _loc5_ = _loc3_ + _loc4_;
         _loc6_ = lf32(_loc1_ + 12);
         _loc8_ = (_loc7_ = lf32(_loc1_ + 44)) + _loc6_;
         _loc5_ = _loc5_;
         _loc6_ -= _loc7_;
         sf32(_loc5_,_loc1_ + 40);
         _loc5_ = _loc8_;
         _loc3_ -= _loc4_;
         sf32(_loc5_,_loc1_ + 44);
         sf32(_loc4_ = _loc6_,_loc1_ + 8);
         _loc3_ = _loc3_;
         sf32(_loc3_,_loc1_ + 12);
         _loc3_ = lf32(_loc1_ + 48);
         _loc4_ = lf32(_loc1_ + 16);
         _loc5_ = lf32(_loc1_ + 52);
         _loc6_ = lf32(_loc1_ + 20);
         _loc7_ = _loc3_ - _loc4_;
         _loc8_ = _loc5_ - _loc6_;
         _loc7_ = _loc7_;
         _loc9_ = _loc9_ = (_loc7_ = _loc7_) - (_loc8_ = Number(_loc8_));
         _loc7_ += _loc8_;
         _loc3_ += _loc4_;
         _loc4_ = _loc9_;
         _loc7_ = _loc7_;
         _loc5_ += _loc6_;
         _loc3_ = _loc3_;
         _loc4_ *= _loc2_;
         _loc6_ = _loc7_;
         sf32(_loc3_,_loc1_ + 48);
         _loc3_ = _loc5_;
         _loc2_ = _loc6_ * _loc2_;
         sf32(_loc3_,_loc1_ + 52);
         _loc3_ = _loc4_;
         sf32(_loc3_,_loc1_ + 16);
         _loc2_ = _loc2_;
         sf32(_loc2_,_loc1_ + 20);
         _loc2_ = lf32(_loc1_ + 56);
         _loc3_ = lf32(_loc1_ + 24);
         _loc4_ = _loc2_ + _loc3_;
         _loc5_ = lf32(_loc1_ + 60);
         _loc6_ = lf32(_loc1_ + 28);
         _loc7_ = _loc5_ + _loc6_;
         _loc4_ = _loc4_;
         _loc2_ -= _loc3_;
         sf32(_loc4_,_loc1_ + 56);
         _loc3_ = _loc7_;
         _loc4_ = _loc5_ - _loc6_;
         sf32(_loc3_,_loc1_ + 60);
         _loc2_ = _loc2_;
         sf32(_loc2_,_loc1_ + 24);
         _loc2_ = _loc4_;
         sf32(_loc2_,_loc1_ + 28);
         mstate.esp -= 4;
         si32(_loc1_,mstate.esp);
         mstate.esp -= 4;
         FSM_mdct_butterfly_8.start();
         mstate.esp += 4;
         mstate.esp -= 4;
         _loc1_ += 32;
         si32(_loc1_,mstate.esp);
         mstate.esp -= 4;
         FSM_mdct_butterfly_8.start();
         mstate.esp += 4;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
