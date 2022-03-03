package anifire.popups
{
   import anifire.util.UtilDict;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class SceneNumberWarning extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _SceneNumberWarning_Button1:Button;
      
      public var _SceneNumberWarning_Text1:Text;
      
      private var _981817656_message:Text;
      
      private var _951530617content:VBox;
      
      private var _1221270899header:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SceneNumberWarning()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___SceneNumberWarning_Canvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.dropShadowEnabled = true;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "id":"header",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.paddingTop = 10;
                              this.paddingBottom = 10;
                              this.paddingLeft = 10;
                              this.paddingRight = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_SceneNumberWarning_Text1",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontSize = 18;
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"content",
                           "stylesFactory":function():void
                           {
                              this.horizontalAlign = "center";
                              this.paddingTop = 10;
                              this.paddingBottom = 10;
                              this.paddingLeft = 10;
                              this.paddingRight = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_message",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_SceneNumberWarning_Button1",
                                    "events":{"click":"___SceneNumberWarning_Button1_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "buttonMode":true,
                                          "styleName":"assetPurchaseAddMe",
                                          "minWidth":100
                                       };
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SceneNumberWarning_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_popups_SceneNumberWarningWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SceneNumberWarning[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___SceneNumberWarning_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SceneNumberWarning._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.dropShadowEnabled = true;
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function init() : void
      {
         this.draw();
      }
      
      private function draw() : void
      {
         this.content.graphics.beginFill(16777215);
         this.content.graphics.drawRoundRectComplex(0,0,this.content.width,this.content.height,0,0,10,10);
         this.content.graphics.endFill();
         this.header.graphics.beginFill(12201261);
         this.header.graphics.drawRoundRectComplex(0,0,this.header.width,this.header.height,10,10,0,0);
         this.header.graphics.endFill();
      }
      
      private function onOkClick() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      public function set text(param1:String) : void
      {
         this._message.text = param1;
      }
      
      public function ___SceneNumberWarning_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___SceneNumberWarning_Button1_click(param1:MouseEvent) : void
      {
         this.onOkClick();
      }
      
      private function _SceneNumberWarning_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Animation Complexity Warning");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneNumberWarning_Text1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Your movie contains a large number of scenes.  Some features in our studio may slow down due to the complexity.\nWe recommend splitting your project into shorter episodes to ensure the best studio experience.\nWe continue to work on studio enhancements to support longer movies such as yours.  Thank you for your patience.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_message.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Ok");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneNumberWarning_Button1.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _message() : Text
      {
         return this._981817656_message;
      }
      
      public function set _message(param1:Text) : void
      {
         var _loc2_:Object = this._981817656_message;
         if(_loc2_ !== param1)
         {
            this._981817656_message = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_message",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get content() : VBox
      {
         return this._951530617content;
      }
      
      public function set content(param1:VBox) : void
      {
         var _loc2_:Object = this._951530617content;
         if(_loc2_ !== param1)
         {
            this._951530617content = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"content",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get header() : VBox
      {
         return this._1221270899header;
      }
      
      public function set header(param1:VBox) : void
      {
         var _loc2_:Object = this._1221270899header;
         if(_loc2_ !== param1)
         {
            this._1221270899header = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"header",_loc2_,param1));
            }
         }
      }
   }
}
