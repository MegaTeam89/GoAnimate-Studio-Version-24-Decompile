package anifire.cc.model
{
   import anifire.core.CCLipSyncController;
   
   public class CcMouthModel extends CcComponentModel
   {
       
      
      private var _lipsyncMouthUrl:String;
      
      private var _talkMouthUrl:String;
      
      public function CcMouthModel()
      {
         super();
      }
      
      override public function initByXml(param1:XML) : void
      {
         super.initByXml(param1);
         this._lipsyncMouthUrl = CCLipSyncController.getLipSyncMouthUrl(param1);
         this._talkMouthUrl = CCLipSyncController.getDemoLipSyncMouthUrl(param1);
      }
      
      public function get lipsyncMouthUrl() : String
      {
         return this._lipsyncMouthUrl;
      }
      
      public function get talkMouthUrl() : String
      {
         return this._talkMouthUrl;
      }
   }
}
