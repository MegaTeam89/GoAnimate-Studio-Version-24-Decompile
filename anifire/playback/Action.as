package anifire.playback
{
   import anifire.util.UtilHashArray;
   import anifire.util.UtilXmlInfo;
   
   public class Action extends Behaviour
   {
      
      public static const XML_TAG:String = "action";
       
      
      public function Action()
      {
         super();
      }
      
      public function init(param1:XML, param2:UtilHashArray, param3:PlayerDataStock) : Boolean
      {
         var _loc4_:Boolean = false;
         if(!(_loc4_ = super.initBehaviour(param1,XML_TAG,param2,param3)))
         {
            return false;
         }
         return true;
      }
      
      public function initDependency(param1:Number, param2:Motion, param3:Number, param4:Action, param5:Number, param6:UtilHashArray, param7:int) : void
      {
         var themeXML:XML = null;
         var item:XML = null;
         var charXML:XML = null;
         var curActionDuration:Number = param1;
         var prevMotion:Motion = param2;
         var prevMotionDuration:Number = param3;
         var prevAction:Action = param4;
         var prevActionDuration:Number = param5;
         var themesXML:UtilHashArray = param6;
         var raceCode:int = param7;
         prevBehavior = prevMotion == null ? prevAction : prevMotion;
         if(prevMotion != null && prevMotionDuration > 0)
         {
            if(prevMotion.getFile() == this.getFile())
            {
               this.setLocalStartFrame(prevMotion.getLocalEndFrame() + 1);
               this.firstBehavior = prevMotion.firstBehavior;
               prevMotion.nextBehavior = this;
            }
            else
            {
               this.setLocalStartFrame(1);
               this.isFirstBehavior = true;
               this.firstBehavior = this;
            }
         }
         else if(prevAction != null && prevActionDuration > 0)
         {
            if(prevAction.getFile() == this.getFile())
            {
               this.setLocalStartFrame(prevAction.getLocalEndFrame() + 1);
               this.firstBehavior = prevAction.firstBehavior;
               prevAction.nextBehavior = this;
            }
            else
            {
               this.setLocalStartFrame(1);
               this.isFirstBehavior = true;
               this.firstBehavior = this;
            }
         }
         else
         {
            this.setLocalStartFrame(1);
            this.isFirstBehavior = true;
            this.firstBehavior = this;
         }
         this.setLocalEndFrame(this.getLocalStartFrame() + curActionDuration - 1);
         var themeId:String = UtilXmlInfo.getThemeIdFromFileName(this.getFile());
         var charId:String = UtilXmlInfo.getCharIdFromFileName(this.getFile());
         themeXML = XML(themesXML.getValueByKey(themeId));
         var result:XMLList = themeXML.char.(@id == charId);
         for each(item in result)
         {
            charXML = item;
         }
         this.initLoader(raceCode,charXML);
      }
   }
}
