package anifire.playerComponent
{
   import anifire.component.DoubleStateButton;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import mx.containers.HBox;
   import mx.core.FlexGlobals;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   public class FullScreenControl extends HBox
   {
       
      
      private var _511269518fullBut:DoubleStateButton;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function FullScreenControl()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "events":{"creationComplete":"___FullScreenControl_HBox1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":DoubleStateButton,
                  "id":"fullBut",
                  "events":{
                     "But1Click":"__fullBut_But1Click",
                     "But2Click":"__fullBut_But2Click"
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "but1StyleName":"btnFull",
                        "but2StyleName":"btnNor"
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.addEventListener("creationComplete",this.___FullScreenControl_HBox1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onCreationCompleted(... rest) : void
      {
         FlexGlobals.topLevelApplication.addEventListener(FullScreenEvent.FULL_SCREEN,this.fullScreenHandler);
         try
         {
            if(FlexGlobals.topLevelApplication.stage.displayState == StageDisplayState.FULL_SCREEN)
            {
               this.fullBut.setState(DoubleStateButton.STATE_BUT2);
            }
            else
            {
               this.fullBut.setState(DoubleStateButton.STATE_BUT1);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function fullScreenHandler(param1:FullScreenEvent) : void
      {
         if(param1.fullScreen)
         {
            this.fullBut.setState(DoubleStateButton.STATE_BUT2);
         }
         else
         {
            this.fullBut.setState(DoubleStateButton.STATE_BUT1);
         }
      }
      
      private function switchToNor(param1:Event = null) : void
      {
         try
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
         catch(e:Error)
         {
         }
      }
      
      private function switchToFull(param1:Event = null) : void
      {
         try
         {
            stage.displayState = StageDisplayState.FULL_SCREEN;
         }
         catch(e:Error)
         {
         }
      }
      
      public function ___FullScreenControl_HBox1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationCompleted();
      }
      
      public function __fullBut_But1Click(param1:Event) : void
      {
         this.switchToFull(param1);
      }
      
      public function __fullBut_But2Click(param1:Event) : void
      {
         this.switchToNor(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get fullBut() : DoubleStateButton
      {
         return this._511269518fullBut;
      }
      
      public function set fullBut(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._511269518fullBut;
         if(_loc2_ !== param1)
         {
            this._511269518fullBut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fullBut",_loc2_,param1));
            }
         }
      }
   }
}
