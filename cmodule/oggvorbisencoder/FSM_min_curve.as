package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_min_curve extends Machine
   {
       
      
      public function FSM_min_curve()
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
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = 0;
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = li32(mstate.ebp + 12);
         _loc4_ = _loc1_;
         while(_loc1_ < 56)
         {
            _loc5_ = _loc2_ + _loc4_;
            _loc7_ = lf32(_loc6_ = _loc3_ + _loc4_);
            _loc8_ = lf32(_loc5_);
            if((_loc9_ = _loc7_) < _loc8_)
            {
               sf32(_loc7_,_loc5_);
            }
            _loc4_ += 4;
            _loc1_ += 1;
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
