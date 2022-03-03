package anifire.core
{
   import anifire.core.sound.SoundEvent;
   import flash.events.EventDispatcher;
   
   public class LinkageController
   {
       
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _linkages:Array;
      
      public function LinkageController()
      {
         this._eventDispatcher = new EventDispatcher();
         super();
         this._linkages = new Array();
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function set eventDispatcher(param1:EventDispatcher) : void
      {
         this._eventDispatcher = param1;
      }
      
      public function addLinkage(param1:AssetLinkage) : void
      {
         this._linkages.push(param1);
         var _loc2_:SoundEvent = new SoundEvent(SoundEvent.UPDATED,this);
         _loc2_.sceneId = param1.getSceneId();
         this.eventDispatcher.dispatchEvent(_loc2_);
      }
      
      public function removeLinkage(param1:AssetLinkage) : void
      {
         var _loc2_:SoundEvent = new SoundEvent(SoundEvent.UPDATED,this);
         _loc2_.sceneId = param1.getSceneId();
         this.eventDispatcher.dispatchEvent(_loc2_);
         var _loc3_:Number = this._linkages.indexOf(param1);
         this._linkages.splice(_loc3_,1);
      }
      
      public function getLinkageByIndex(param1:int) : AssetLinkage
      {
         return this._linkages[param1];
      }
      
      public function isLinkageExist(param1:String) : Array
      {
         var _loc3_:AssetLinkage = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._linkages.length)
         {
            _loc3_ = this.getLinkageByIndex(_loc2_);
            if(_loc3_.getLinkage().indexOf(param1) > -1)
            {
               return _loc3_.getLinkage();
            }
            _loc2_++;
         }
         return null;
      }
      
      public function deleteLinkage(param1:Object) : String
      {
         var _loc3_:String = null;
         var _loc4_:Asset = null;
         var _loc5_:AnimeScene = null;
         var _loc2_:String = "";
         if(param1 is Asset)
         {
            _loc3_ = (_loc4_ = param1 as Asset).scene.id + AssetLinkage.LINK + _loc4_.id;
         }
         else if(param1 is AnimeScene)
         {
            _loc3_ = (_loc5_ = param1 as AnimeScene).id;
         }
         return this.deleteLinkageById(_loc3_);
      }
      
      public function deleteLinkageById(param1:String) : String
      {
         var _loc4_:AssetLinkage = null;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < this._linkages.length)
         {
            if((_loc4_ = this.getLinkageByIndex(_loc3_)).getLinkage().indexOf(param1) > -1)
            {
               if(_loc4_.getLinkage().length <= 2)
               {
                  this.removeLinkage(_loc4_);
               }
               _loc4_.removeLinkage(param1);
               _loc2_ = _loc4_.getLinkage().join("");
               _loc4_ = null;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getSpeechSoundIdByScene(param1:AnimeScene, param2:Boolean = false) : String
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:Character = null;
         var _loc13_:Array = null;
         var _loc3_:String = "";
         var _loc6_:XML;
         if(_loc6_ = param1.sceneXML)
         {
            _loc7_ = false;
            _loc5_ = _loc6_.@id + AssetLinkage.LINK;
            _loc4_ = this.isLinkageExist(_loc5_);
            if(!param2 && _loc4_ != null)
            {
               _loc7_ = true;
            }
            else
            {
               _loc4_ = new Array();
               for each(_loc8_ in _loc6_.children())
               {
                  _loc9_ = _loc8_.name();
                  switch(_loc9_)
                  {
                     case Character.XML_NODE_NAME:
                        _loc5_ = _loc6_.@id + AssetLinkage.LINK + _loc8_.@id;
                        if((_loc4_ = this.isLinkageExist(_loc5_)) != null)
                        {
                           _loc7_ = true;
                        }
                  }
                  if(_loc7_)
                  {
                     break;
                  }
               }
            }
         }
         else
         {
            _loc5_ = param1.id + AssetLinkage.LINK;
            _loc4_ = this.isLinkageExist(_loc5_);
            if(!(!param2 && _loc4_ != null))
            {
               _loc4_ = new Array();
               _loc10_ = param1.characters.length;
               _loc11_ = 0;
               while(_loc11_ < _loc10_)
               {
                  _loc5_ = (_loc12_ = param1.characters.getValueByIndex(_loc11_) as Character).scene.id + AssetLinkage.LINK + _loc12_.id;
                  if((_loc4_ = this.isLinkageExist(_loc5_)) != null)
                  {
                     break;
                  }
                  _loc11_++;
               }
            }
         }
         if(_loc4_ != null)
         {
            _loc13_ = _loc4_.concat();
            _loc13_.splice(_loc13_.indexOf(_loc5_),1);
            _loc3_ = _loc13_.join("");
         }
         return _loc3_;
      }
      
      public function getSpeechIdOfAsset(param1:Asset = null) : String
      {
         var _loc3_:AnimeScene = null;
         var _loc2_:Asset = param1;
         if(_loc2_ && _loc2_.scene)
         {
            _loc3_ = _loc2_.scene;
         }
         else
         {
            _loc3_ = Console.getConsole().currentScene;
         }
         return this.getSpeechSoundIdByScene(_loc3_,true);
      }
      
      public function getTargetIdOfSpeech(param1:String) : String
      {
         var _loc4_:Array = null;
         var _loc2_:String = "";
         var _loc3_:Array = this.isLinkageExist(param1);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.concat();
            _loc4_.splice(_loc4_.indexOf(param1),1);
            _loc2_ = _loc4_.join("");
         }
         return _loc2_;
      }
      
      public function serialize() : String
      {
         var _loc2_:int = 0;
         var _loc3_:AssetLinkage = null;
         var _loc1_:String = "";
         if(this._linkages)
         {
            _loc2_ = 0;
            while(_loc2_ < this._linkages.length)
            {
               _loc3_ = this.getLinkageByIndex(_loc2_);
               if(_loc3_)
               {
                  _loc1_ += _loc3_.serialize();
               }
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function deserialize(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:AssetLinkage = null;
         var _loc5_:String = null;
         var _loc6_:AnimeScene = null;
         var _loc7_:String = null;
         _loc3_ = 0;
         while(_loc3_ < param1.child(AssetLinkage.XML_TAG).length())
         {
            _loc2_ = param1.child(AssetLinkage.XML_TAG)[_loc3_];
            (_loc4_ = new AssetLinkage()).deserialize(_loc2_);
            _loc5_ = _loc4_.getSceneId();
            if(_loc6_ = Console.getConsole().getScenebyId(_loc5_))
            {
               this.addLinkage(_loc4_);
            }
            else
            {
               _loc7_ = _loc4_.getSoundId();
               Console.getConsole().speechManager.removeSoundById(_loc7_);
            }
            _loc3_++;
         }
      }
      
      public function isDemoSpeechNeeded(param1:Character) : Boolean
      {
         var _loc2_:String = this.getSpeechSoundIdByScene(param1.scene);
         var _loc3_:String = this.getTargetIdOfSpeech(_loc2_);
         var _loc4_:String;
         return (_loc4_ = AssetLinkage.getCharIdFromLinkage(_loc3_)) == param1.id;
      }
   }
}
