package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_book_dup_or_new extends Machine
   {
       
      
      public function FSM_book_dup_or_new()
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
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc1_ = 0;
         _loc2_ = li32(mstate.ebp + 8);
         _loc3_ = li32(_loc2_ + 24);
         _loc4_ = _loc2_ + 1824;
         _loc2_ += 24;
         _loc5_ = li32(mstate.ebp + 12);
         while(true)
         {
            _loc6_ = _loc1_;
            _loc1_ = _loc4_;
            if(_loc3_ <= _loc6_)
            {
               si32(_loc6_ = _loc3_ + 1,_loc2_);
               mstate.eax = _loc3_;
               break;
            }
            _loc1_ = li32(_loc1_);
            if(_loc1_ == _loc5_)
            {
               mstate.eax = _loc6_;
               break;
            }
            _loc1_ = _loc4_ + 4;
            _loc6_ += 1;
            _loc4_ = _loc1_;
            _loc1_ = _loc6_;
         }
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
