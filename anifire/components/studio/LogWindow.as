package anifire.components.studio
{
   import anifire.core.Console;
   import anifire.core.sound.TTSManager;
   import anifire.util.UtilUser;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.controls.TextArea;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.CloseEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   public class LogWindow extends TitleWindow
   {
       
      
      private var _100234553movieXml:TextArea;
      
      private var _1148890108userDetail:TextArea;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public function LogWindow()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "events":{
               "creationComplete":"___LogWindow_TitleWindow1_creationComplete",
               "close":"___LogWindow_TitleWindow1_close"
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":800,
                  "height":600,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TextArea,
                              "id":"userDetail",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":20,
                                    "percentHeight":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextArea,
                              "id":"movieXml",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":80,
                                    "percentHeight":100
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         super();
         mx_internal::_document = this;
         this.layout = "absolute";
         this.width = 800;
         this.height = 600;
         this.title = "GoAnimate is the best!";
         this.showCloseButton = true;
         this.addEventListener("creationComplete",this.___LogWindow_TitleWindow1_creationComplete);
         this.addEventListener("close",this.___LogWindow_TitleWindow1_close);
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
      
      private function init() : void
      {
         try
         {
            PopUpManager.centerPopUp(this);
            this.userDetail.text = "User Type: " + UtilUser.userType + "\n";
            this.userDetail.text += "GoBuck: " + UtilUser.goBuck + "\n";
            this.userDetail.text += "GoPoint: " + UtilUser.goPoint + "\n";
            this.userDetail.text += "TTS credit: " + TTSManager.credit + "\n";
            this.movieXml.text = Console.getConsole().serialize().toXMLString();
         }
         catch(e:Error)
         {
         }
      }
      
      public function ___LogWindow_TitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___LogWindow_TitleWindow1_close(param1:CloseEvent) : void
      {
         PopUpManager.removePopUp(this);
      }
      
      [Bindable(event="propertyChange")]
      public function get movieXml() : TextArea
      {
         return this._100234553movieXml;
      }
      
      public function set movieXml(param1:TextArea) : void
      {
         var _loc2_:Object = this._100234553movieXml;
         if(_loc2_ !== param1)
         {
            this._100234553movieXml = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"movieXml",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get userDetail() : TextArea
      {
         return this._1148890108userDetail;
      }
      
      public function set userDetail(param1:TextArea) : void
      {
         var _loc2_:Object = this._1148890108userDetail;
         if(_loc2_ !== param1)
         {
            this._1148890108userDetail = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"userDetail",_loc2_,param1));
            }
         }
      }
   }
}
