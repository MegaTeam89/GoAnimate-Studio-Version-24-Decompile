package anifire.debug
{
   import anifire.playback.PlainPlayer;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class PlayerDebugPanel extends Canvas
   {
       
      
      private var _1229214189playbackStatus:PlaybackStatusPanel;
      
      private var _829530656soundDebugPanel:SoundDebugPanel;
      
      private var _1108151772timelineControl:TimelineControl;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function PlayerDebugPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":TimelineControl,
                        "id":"timelineControl"
                     }),new UIComponentDescriptor({
                        "type":SoundDebugPanel,
                        "id":"soundDebugPanel"
                     }),new UIComponentDescriptor({
                        "type":PlaybackStatusPanel,
                        "id":"playbackStatus",
                        "propertiesFactory":function():Object
                        {
                           return {"visible":false};
                        }
                     })]};
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
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
      
      public function set plainPlayer(param1:PlainPlayer) : void
      {
         this.timelineControl.plainPlayer = param1;
         this.soundDebugPanel.plainPlayer = param1;
         this.playbackStatus.plainPlayer = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get playbackStatus() : PlaybackStatusPanel
      {
         return this._1229214189playbackStatus;
      }
      
      public function set playbackStatus(param1:PlaybackStatusPanel) : void
      {
         var _loc2_:Object = this._1229214189playbackStatus;
         if(_loc2_ !== param1)
         {
            this._1229214189playbackStatus = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playbackStatus",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get soundDebugPanel() : SoundDebugPanel
      {
         return this._829530656soundDebugPanel;
      }
      
      public function set soundDebugPanel(param1:SoundDebugPanel) : void
      {
         var _loc2_:Object = this._829530656soundDebugPanel;
         if(_loc2_ !== param1)
         {
            this._829530656soundDebugPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundDebugPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get timelineControl() : TimelineControl
      {
         return this._1108151772timelineControl;
      }
      
      public function set timelineControl(param1:TimelineControl) : void
      {
         var _loc2_:Object = this._1108151772timelineControl;
         if(_loc2_ !== param1)
         {
            this._1108151772timelineControl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"timelineControl",_loc2_,param1));
            }
         }
      }
   }
}
