package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_apsort extends Machine
   {
       
      
      public function FSM_apsort()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = int(li32(mstate.ebp + 8));
         _loc2_ = int(li32(mstate.ebp + 12));
         _loc1_ = int(li32(_loc1_));
         _loc2_ = int(li32(_loc2_));
         _loc3_ = lf32(_loc1_);
         _loc4_ = lf32(_loc2_);
         _loc1_ = int(_loc3_ < _loc4_ ? 1 : 0);
         _loc2_ = int(_loc3_ > _loc4_ ? 1 : 0);
         _loc1_ &= 1;
         _loc2_ &= 1;
         _loc1_ -= _loc2_;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
