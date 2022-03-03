package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_ilog21 extends Machine
   {
       
      
      public function FSM_ilog21()
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
         if(_loc1_ == 0)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = 0;
            _loc1_ += -1;
         }
         while(_loc1_ != 0)
         {
            _loc2_ += 1;
            _loc1_ >>>= 1;
         }
         mstate.eax = _loc2_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
