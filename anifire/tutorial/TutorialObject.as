package anifire.tutorial
{
   public class TutorialObject implements ITutorial
   {
       
      
      protected const MESSAGE_BOX_X_DEFAULT:uint = 276;
      
      protected const MESSAGE_BOX_Y_DEFAULT:uint = 380;
      
      protected var _data:XML;
      
      public function TutorialObject()
      {
         super();
      }
      
      public function get data() : XML
      {
         return this._data;
      }
   }
}
