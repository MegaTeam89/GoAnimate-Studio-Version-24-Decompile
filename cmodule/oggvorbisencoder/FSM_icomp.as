package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_icomp extends Machine
   {
       
      
      public function FSM_icomp()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = li32(mstate.ebp + 8);
         _loc2_ = li32(mstate.ebp + 12);
         _loc1_ = li32(_loc1_);
         _loc2_ = li32(_loc2_);
         _loc1_ = li32(_loc1_);
         _loc2_ = li32(_loc2_);
         _loc1_ -= _loc2_;
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
