package anifire.assets.interfaces
{
   import anifire.assets.motion.ICircularMotion;
   
   public interface ISupportCircularMotion
   {
       
      
      function startCircularMotion(param1:Boolean = true) : void;
      
      function removeCircularMotion() : void;
      
      function get circularMotion() : ICircularMotion;
      
      function set circularMotion(param1:ICircularMotion) : void;
   }
}
