package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_vorbis_dBquant138 extends Machine
   {
       
      
      public function FSM_vorbis_dBquant138()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         mstate.esp -= 4;
         si32(mstate.ebp,mstate.esp);
         mstate.ebp = mstate.esp;
         mstate.esp -= 0;
         _loc2_ = 7.31429;
         _loc2_ = _loc2_;
         _loc3_ = lf32(mstate.ebp + 8);
         _loc2_ = _loc2_;
         _loc2_ = _loc3_ * _loc2_;
         _loc3_ = 1023.5;
         _loc2_ = _loc2_;
         _loc3_ = _loc3_;
         _loc3_ = _loc3_;
         _loc2_ = _loc2_;
         _loc2_ += _loc3_;
         _loc2_ = _loc2_;
         _loc1_ = int(_loc2_);
         if(_loc1_ <= 1023)
         {
            _loc1_ = _loc1_ < 0 ? 0 : int(_loc1_);
         }
         else
         {
            _loc1_ = 1023;
         }
         mstate.eax = _loc1_;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
      }
   }
}
