package anifire.assets.transition.model
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.NarrationNode;
   import anifire.core.AnimeScene;
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.ITiming;
   import anifire.iterators.TreeNode;
   import anifire.util.UtilMath;
   
   public class AssetTransitionHelper
   {
       
      
      public function AssetTransitionHelper()
      {
         super();
      }
      
      public static function getTransitions(param1:String, param2:AssetTransitionCollection) : Array
      {
         var _loc4_:IIterator = null;
         var _loc5_:AssetTransition = null;
         var _loc3_:Array = new Array();
         if(param2)
         {
            _loc4_ = param2.iterator();
            while(_loc4_.hasNext)
            {
               if((_loc5_ = _loc4_.next as AssetTransition) && _loc5_.assetId == param1)
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         return _loc3_;
      }
      
      public static function getTransition(param1:String, param2:AssetTransitionCollection) : AssetTransition
      {
         var _loc3_:IIterator = null;
         var _loc4_:AssetTransition = null;
         if(param2)
         {
            _loc3_ = param2.iterator();
            while(_loc3_.hasNext)
            {
               if((_loc4_ = _loc3_.next as AssetTransition) && _loc4_.id == param1)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public static function isAlreadyOut(param1:String, param2:AssetTransitionCollection) : Boolean
      {
         var _loc3_:Array = AssetTransitionHelper.getTransitions(param1,param2);
         if(_loc3_.length > 0)
         {
            return AssetTransition(_loc3_[_loc3_.length - 1]).direction == AssetTransitionConstants.DIRECTION_OUT;
         }
         return false;
      }
      
      public static function getTotalFrameOfTransitionBeforeNarration(param1:AssetTransitionCollection) : int
      {
         var _loc3_:TreeNode = null;
         var _loc5_:AssetTransitionTreeNode = null;
         var _loc2_:uint = 0;
         _loc3_ = AssetTransitionTreeNode.getTreeFromTransitionCollection(param1);
         var _loc4_:IIterator = _loc3_.iterator();
         while(_loc4_.hasNext)
         {
            if((_loc5_ = _loc4_.next as AssetTransitionTreeNode) && _loc5_.transition && _loc5_.transition.section == AssetTransitionConstants.TIMING_BEFORE_NARRATION)
            {
               _loc2_ = Math.max(_loc2_,_loc5_.endFrame);
            }
         }
         return _loc2_;
      }
      
      public static function totalFramesByAssetTransition(param1:AnimeScene) : int
      {
         var _loc6_:ITiming = null;
         var _loc7_:int = 0;
         var _loc8_:NarrationNode = null;
         var _loc2_:uint = 0;
         var _loc3_:AnimeSound = Console.getConsole().speechManager.getSpeech(param1);
         if(_loc3_ && _loc3_.soundThumb)
         {
            _loc7_ = Console.getConsole().speechManager.getSpeechTotalFrame(param1);
            (_loc8_ = new NarrationNode()).init(0,_loc7_);
         }
         var _loc4_:TreeNode;
         var _loc5_:IIterator = (_loc4_ = AssetTransitionTreeNode.getTreeFromTransitionCollection(param1.assetTransitions,_loc8_)).iterator();
         while(_loc5_.hasNext)
         {
            if((_loc6_ = _loc5_.next as ITiming) && !(_loc6_ is NarrationNode))
            {
               _loc2_ = Math.max(_loc2_,_loc6_.endFrame);
            }
         }
         return _loc2_;
      }
      
      public static function checkAssetTransitionConflict(param1:AnimeScene) : void
      {
         var _loc5_:AssetTransitionTreeNode = null;
         var _loc6_:AssetTransition = null;
         var _loc8_:AssetTransitionTreeNode = null;
         var _loc9_:AssetTransition = null;
         var _loc10_:int = 0;
         var _loc11_:NarrationNode = null;
         var _loc2_:AnimeSound = Console.getConsole().speechManager.getSpeech(param1);
         if(_loc2_)
         {
            _loc10_ = Console.getConsole().speechManager.getSpeechTotalFrame(param1);
            (_loc11_ = new NarrationNode()).init(0,_loc10_);
         }
         var _loc3_:TreeNode = AssetTransitionTreeNode.getTreeFromTransitionCollection(param1.assetTransitions,_loc11_);
         var _loc4_:IIterator = _loc3_.iterator();
         var _loc7_:IIterator = _loc3_.iterator();
         while(_loc4_.hasNext)
         {
            if(_loc5_ = _loc4_.next as AssetTransitionTreeNode)
            {
               if(_loc6_ = _loc5_.data as AssetTransition)
               {
                  _loc7_.reset();
                  while(_loc7_.hasNext)
                  {
                     if(_loc8_ = _loc7_.next as AssetTransitionTreeNode)
                     {
                        if((_loc9_ = _loc8_.data as AssetTransition) && _loc9_ != _loc6_ && _loc6_.assetId == _loc9_.assetId)
                        {
                           _loc6_.conflict = _loc9_.conflict = UtilMath.checkOverlap(_loc5_.startFrame,_loc5_.startFrame + _loc5_.duration - 1,_loc8_.startFrame,_loc8_.startFrame + _loc8_.duration - 1);
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
