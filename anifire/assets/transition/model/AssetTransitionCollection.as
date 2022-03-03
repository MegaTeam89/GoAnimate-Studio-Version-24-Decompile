package anifire.assets.transition.model
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.command.AddTransitionCommand;
   import anifire.assets.transition.view.TransitionNumberWarning;
   import anifire.command.ICommand;
   import anifire.core.Console;
   import anifire.interfaces.ICollection;
   import anifire.interfaces.IIterator;
   import anifire.interfaces.IXmlConvertable;
   import anifire.iterators.ArrayIterator;
   import anifire.util.UtilDict;
   import anifire.util.UtilPopUp;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import mx.collections.ArrayCollection;
   import mx.core.FlexGlobals;
   import mx.core.IFlexDisplayObject;
   import mx.events.CollectionEvent;
   import mx.managers.PopUpManager;
   
   public class AssetTransitionCollection extends ArrayCollection implements ICollection, IXmlConvertable
   {
       
      
      private var _lastAddedTransition:AssetTransition;
      
      private var _collectionBeforeNarration:ArrayCollection;
      
      private var _collectionWithNarration:ArrayCollection;
      
      private var _collectionAfterNarration:ArrayCollection;
      
      public function AssetTransitionCollection()
      {
         super();
         this._collectionBeforeNarration = new ArrayCollection();
         this._collectionWithNarration = new ArrayCollection();
         this._collectionAfterNarration = new ArrayCollection();
         this._collectionBeforeNarration.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onCollectionChange);
         this._collectionWithNarration.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onCollectionChange);
         this._collectionAfterNarration.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onCollectionChange);
      }
      
      private function onCollectionChange(param1:CollectionEvent) : void
      {
         var _loc2_:AssetTransition = param1.items[0] as AssetTransition;
         if(_loc2_ && param1.kind == "add")
         {
            switch(param1.currentTarget)
            {
               case this._collectionBeforeNarration:
                  _loc2_.setSection(AssetTransitionConstants.TIMING_BEFORE_NARRATION);
                  break;
               case this._collectionWithNarration:
                  _loc2_.setSection(AssetTransitionConstants.TIMING_WITH_NARRATION);
                  break;
               case this._collectionAfterNarration:
                  _loc2_.setSection(AssetTransitionConstants.TIMING_AFTER_NARRATION);
            }
         }
         this.dispatchEvent(new AssetTransitionEvent(AssetTransitionEvent.TIMING_CHANGE));
      }
      
      public function get collectionBeforeNarration() : ArrayCollection
      {
         return this._collectionBeforeNarration;
      }
      
      public function get collectionWithNarration() : ArrayCollection
      {
         return this._collectionWithNarration;
      }
      
      public function get collectionAfterNarration() : ArrayCollection
      {
         return this._collectionAfterNarration;
      }
      
      public function addNew(param1:String, param2:String = "Prop") : AssetTransition
      {
         var _loc4_:ICommand = null;
         var _loc3_:AssetTransition = this.createNew(param1,param2);
         if(_loc3_)
         {
            (_loc4_ = new AddTransitionCommand(_loc3_,this)).execute();
            this._lastAddedTransition = _loc3_;
         }
         return _loc3_;
      }
      
      public function addTransition(param1:AssetTransition) : void
      {
         switch(param1.section)
         {
            case AssetTransitionConstants.TIMING_BEFORE_NARRATION:
               this._collectionBeforeNarration.addItem(param1);
               break;
            case AssetTransitionConstants.TIMING_WITH_NARRATION:
               this._collectionWithNarration.addItem(param1);
               break;
            case AssetTransitionConstants.TIMING_AFTER_NARRATION:
               this._collectionAfterNarration.addItem(param1);
         }
         this.addItem(param1);
         param1.addEventListener(AssetTransitionEvent.SECTION_CHANGE,this.onTransitionSectionChange);
         param1.addEventListener(AssetTransitionEvent.TIMING_CHANGE,this.onTransitionTimingChange);
      }
      
      public function addTransitionAt(param1:AssetTransition, param2:int) : void
      {
         switch(param1.section)
         {
            case AssetTransitionConstants.TIMING_BEFORE_NARRATION:
               this._collectionBeforeNarration.addItemAt(param1,param2);
               break;
            case AssetTransitionConstants.TIMING_WITH_NARRATION:
               this._collectionWithNarration.addItemAt(param1,param2);
               break;
            case AssetTransitionConstants.TIMING_AFTER_NARRATION:
               this._collectionAfterNarration.addItemAt(param1,param2);
         }
         this.addItem(param1);
         param1.addEventListener(AssetTransitionEvent.SECTION_CHANGE,this.onTransitionSectionChange);
         param1.addEventListener(AssetTransitionEvent.TIMING_CHANGE,this.onTransitionTimingChange);
      }
      
      private function createNew(param1:String, param2:String) : AssetTransition
      {
         var _loc4_:IFlexDisplayObject = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:IIterator = null;
         var _loc9_:AssetTransition = null;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         if(this.length >= AssetTransitionFactory.maxTransitionsPerScene)
         {
            UtilPopUp.alert(UtilDict.toDisplay("go","Please upgrade to GoPlus to add more Enter/Exit effects to this scene"));
            return null;
         }
         if(this.length == AssetTransitionFactory.SUGGESTED_TRANSITIONS_PER_SCENE)
         {
            _loc4_ = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,TransitionNumberWarning,true);
            PopUpManager.centerPopUp(_loc4_);
         }
         var _loc3_:AssetTransition = AssetTransitionFactory.create(param1,AssetTransitionConstants.TYPE_SLIDE,param2);
         if(_loc3_)
         {
            if(this._lastAddedTransition)
            {
               _loc10_ = Boolean(_loc3_.atype == "BubbleAsset");
               if((_loc11_ = Boolean(this._lastAddedTransition.atype == "BubbleAsset")) && _loc10_ || !_loc11_)
               {
                  _loc3_.type = this._lastAddedTransition.type;
                  _loc3_.duration = this._lastAddedTransition.duration;
                  _loc3_.timing = this._lastAddedTransition.timing;
                  _loc3_.section = this._lastAddedTransition.section;
                  _loc3_.delay = this._lastAddedTransition.delay;
                  _loc3_.direction = this._lastAddedTransition.direction;
                  _loc3_.soundMode = this._lastAddedTransition.soundMode;
                  _loc3_.setting = this._lastAddedTransition.setting.clone();
               }
            }
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc8_ = this.iterator();
            while(_loc8_.hasNext)
            {
               if((_loc9_ = _loc8_.next as AssetTransition) && _loc9_.assetId == param1)
               {
                  if(_loc9_.direction == AssetTransitionConstants.DIRECTION_IN)
                  {
                     _loc5_++;
                  }
                  else
                  {
                     _loc6_++;
                  }
                  _loc7_++;
               }
            }
            if(_loc5_ == 1 && _loc6_ == 1)
            {
               UtilPopUp.alert("Sorry, an item can only have one enter and one exit effect per scene.");
               return null;
            }
            if(_loc5_ == 1)
            {
               _loc3_.direction = AssetTransitionConstants.DIRECTION_OUT;
            }
            else if(_loc6_ == 1)
            {
               _loc3_.direction = AssetTransitionConstants.DIRECTION_IN;
            }
            if(_loc7_ > 0)
            {
               _loc3_.timing = AssetTransitionConstants.TIMING_AFTER_PREVIOUS;
            }
            if(_loc3_.direction == AssetTransitionConstants.DIRECTION_OUT && Console.getConsole().speechManager.getSpeech(Console.getConsole().currentScene))
            {
               _loc3_.section = AssetTransitionConstants.TIMING_AFTER_NARRATION;
            }
         }
         return _loc3_;
      }
      
      private function onTransitionSectionChange(param1:Event) : void
      {
         var _loc2_:AssetTransition = param1.target as AssetTransition;
         if(_loc2_)
         {
            this.removeTransition(_loc2_);
            this.addTransition(_loc2_);
         }
      }
      
      private function onTransitionTimingChange(param1:Event) : void
      {
         this.dispatchEvent(param1);
      }
      
      public function removeTransition(param1:AssetTransition) : int
      {
         var _loc4_:AssetTransition = null;
         param1.removeEventListener(AssetTransitionEvent.SECTION_CHANGE,this.onTransitionSectionChange);
         param1.removeEventListener(AssetTransitionEvent.TIMING_CHANGE,this.onTransitionTimingChange);
         var _loc2_:Number = -1;
         var _loc3_:Number = -1;
         _loc2_ = this._collectionBeforeNarration.getItemIndex(param1);
         if(_loc2_ != -1)
         {
            _loc4_ = this._collectionBeforeNarration.removeItemAt(_loc2_) as AssetTransition;
            _loc3_ = _loc2_;
         }
         _loc2_ = this._collectionWithNarration.getItemIndex(param1);
         if(_loc2_ != -1)
         {
            _loc4_ = this._collectionWithNarration.removeItemAt(_loc2_) as AssetTransition;
            _loc3_ = _loc2_;
         }
         _loc2_ = this._collectionAfterNarration.getItemIndex(param1);
         if(_loc2_ != -1)
         {
            _loc4_ = this._collectionAfterNarration.removeItemAt(_loc2_) as AssetTransition;
            _loc3_ = _loc2_;
         }
         _loc2_ = this.getItemIndex(param1);
         if(_loc2_ != -1)
         {
            _loc4_ = this.removeItemAt(_loc2_) as AssetTransition;
         }
         return _loc3_;
      }
      
      public function removeByAssetId(param1:String) : Array
      {
         var _loc3_:uint = 0;
         var _loc2_:Array = AssetTransitionHelper.getTransitions(param1,this);
         if(_loc2_.length > 0)
         {
            while(_loc3_ < _loc2_.length)
            {
               this.removeTransition(_loc2_[_loc3_] as AssetTransition);
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function iterator(param1:String = null) : IIterator
      {
         var _loc2_:Array = new Array();
         _loc2_ = _loc2_.concat(this._collectionBeforeNarration.source);
         _loc2_ = _loc2_.concat(this._collectionWithNarration.source);
         _loc2_ = _loc2_.concat(this._collectionAfterNarration.source);
         return new ArrayIterator(_loc2_);
      }
      
      public function convertToXml() : XML
      {
         var _loc3_:IXmlConvertable = null;
         var _loc1_:IIterator = this.iterator();
         if(_loc1_.hasNext == false)
         {
            return new XML();
         }
         var _loc2_:XML = new XML("<" + AssetTransitionConstants.TAG_NAME_TRANSITION_LIST + "></" + AssetTransitionConstants.TAG_NAME_TRANSITION_LIST + ">");
         while(_loc1_.hasNext)
         {
            _loc3_ = _loc1_.next as IXmlConvertable;
            if(_loc3_)
            {
               _loc2_.appendChild(_loc3_.convertToXml());
            }
         }
         return _loc2_;
      }
      
      public function convertFromXml(param1:XML) : Boolean
      {
         var _loc2_:XML = null;
         var _loc3_:AssetTransition = null;
         if(param1.hasOwnProperty(AssetTransitionConstants.TAG_NAME_TRANSITION))
         {
            this.removeAll();
            this._collectionBeforeNarration.removeAll();
            this._collectionWithNarration.removeAll();
            this._collectionAfterNarration.removeAll();
            for each(_loc2_ in param1.child(AssetTransitionConstants.TAG_NAME_TRANSITION))
            {
               _loc3_ = AssetTransitionFactory.create(String(_loc2_.@target),String(_loc2_.@type),String(_loc2_.@atype));
               if(_loc3_)
               {
                  _loc3_.convertFromXml(_loc2_);
                  this.addTransition(_loc3_);
               }
            }
            return true;
         }
         return false;
      }
      
      public function serialize() : String
      {
         return this.convertToXml().toXMLString();
      }
   }
}
