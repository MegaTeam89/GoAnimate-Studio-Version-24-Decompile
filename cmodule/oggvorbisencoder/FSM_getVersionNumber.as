package cmodule.oggvorbisencoder
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_getVersionNumber extends Machine
   {
      
      public static const intRegCount:int = 1;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public function FSM_getVersionNumber()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_getVersionNumber = null;
         _loc1_ = new FSM_getVersionNumber();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = __2E_str1100;
               mstate.esp -= 4;
               si32(this.i0,mstate.esp);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_String]();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               mstate.eax = this.i0;
               mstate.esp = mstate.ebp;
               mstate.ebp = li32(mstate.esp);
               mstate.esp += 4;
               mstate.esp += 4;
               mstate.gworker = caller;
               return;
            default:
               throw "Invalid state in _getVersionNumber";
         }
      }
   }
}
