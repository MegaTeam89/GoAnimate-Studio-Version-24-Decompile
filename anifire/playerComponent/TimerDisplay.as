package anifire.playerComponent
{
   import anifire.debug.PlayerDebugManager;
   import anifire.util.UtilString;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class TimerDisplay extends Canvas
   {
       
      
      private var _177936123infoText:Text;
      
      private var _838772035totalTimeLabel:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _total:Number;
      
      private var _cur:Number;
      
      public function TimerDisplay()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"click":"___TimerDisplay_Canvas1_click"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":112,
                  "height":26,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Text,
                     "id":"infoText",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":100,
                           "x":8,
                           "y":4,
                           "selectable":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Text,
                     "id":"totalTimeLabel",
                     "stylesFactory":function():void
                     {
                        this.textAlign = "center";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "text":"--:-- / --:--",
                           "x":4,
                           "y":4,
                           "selectable":false,
                           "width":104
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.width = 112;
         this.height = 26;
         this.addEventListener("click",this.___TimerDisplay_Canvas1_click);
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
      
      public function setTotalTime(param1:Number) : void
      {
         this._total = param1;
         this.totalTimeLabel.text = UtilString.convertSecToTimeString(this._cur) + " / " + UtilString.convertSecToTimeString(this._total);
      }
      
      public function setCurTime(param1:Number) : void
      {
         this._cur = param1;
         this.totalTimeLabel.text = UtilString.convertSecToTimeString(this._cur) + " / " + UtilString.convertSecToTimeString(this._total);
      }
      
      public function set text(param1:String) : void
      {
         this.infoText.text = param1;
         this.totalTimeLabel.visible = param1 == "";
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(param1.shiftKey && param1.ctrlKey)
         {
            PlayerDebugManager.debugMode = !PlayerDebugManager.debugMode;
         }
      }
      
      public function ___TimerDisplay_Canvas1_click(param1:MouseEvent) : void
      {
         this.onClick(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get infoText() : Text
      {
         return this._177936123infoText;
      }
      
      public function set infoText(param1:Text) : void
      {
         var _loc2_:Object = this._177936123infoText;
         if(_loc2_ !== param1)
         {
            this._177936123infoText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"infoText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get totalTimeLabel() : Text
      {
         return this._838772035totalTimeLabel;
      }
      
      public function set totalTimeLabel(param1:Text) : void
      {
         var _loc2_:Object = this._838772035totalTimeLabel;
         if(_loc2_ !== param1)
         {
            this._838772035totalTimeLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"totalTimeLabel",_loc2_,param1));
            }
         }
      }
   }
}
