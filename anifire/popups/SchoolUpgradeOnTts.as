package anifire.popups
{
   import anifire.component.IconTextButton;
   import anifire.util.UtilDict;
   import anifire.util.UtilNavigate;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class SchoolUpgradeOnTts extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _SchoolUpgradeOnTts_Button1:Button;
      
      public var _SchoolUpgradeOnTts_Text1:Text;
      
      public var _SchoolUpgradeOnTts_Text2:Text;
      
      private var _951530617content:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SchoolUpgradeOnTts()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___SchoolUpgradeOnTts_Canvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.dropShadowEnabled = true;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
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
                           "id":"_SchoolUpgradeOnTts_Text1",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 18;
                              this.color = 2972302;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"_SchoolUpgradeOnTts_Text2",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Spacer,
                           "propertiesFactory":function():Object
                           {
                              return {"height":10};
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_SchoolUpgradeOnTts_Button1",
                           "events":{"click":"___SchoolUpgradeOnTts_Button1_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"btnUpgrade",
                                 "buttonMode":true
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Spacer,
                           "propertiesFactory":function():Object
                           {
                              return {"height":10};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":IconTextButton,
                  "events":{"click":"___SchoolUpgradeOnTts_IconTextButton1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "right":10,
                        "top":10,
                        "styleName":"btnCloseTop",
                        "buttonMode":true,
                        "labelPlacement":"left"
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
         var bindings:Array = this._SchoolUpgradeOnTts_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_popups_SchoolUpgradeOnTtsWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SchoolUpgradeOnTts[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___SchoolUpgradeOnTts_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SchoolUpgradeOnTts._watcherSetupUtil = param1;
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
      
      private function onClick() : void
      {
      }
      
      private function onClose() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function onUpgradeBtnClick() : void
      {
         UtilNavigate.toUpgradePage();
         this.onClose();
      }
      
      private function init() : void
      {
         this.draw();
      }
      
      private function draw() : void
      {
         this.content.graphics.beginFill(13421772);
         this.content.graphics.drawRoundRectComplex(0,0,this.content.width,this.content.height,10,10,10,10);
         this.content.graphics.endFill();
      }
      
      public function ___SchoolUpgradeOnTts_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___SchoolUpgradeOnTts_Button1_click(param1:MouseEvent) : void
      {
         this.onUpgradeBtnClick();
      }
      
      public function ___SchoolUpgradeOnTts_IconTextButton1_click(param1:MouseEvent) : void
      {
         this.onClose();
      }
      
      private function _SchoolUpgradeOnTts_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Getting more TTS Credits");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SchoolUpgradeOnTts_Text1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Your students have 50 TTS credits per month to use on GoAnimate 4 schools. To get more credits, you can upgrade your account to SchoolPlus.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SchoolUpgradeOnTts_Text2.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Contact us to upgrade");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SchoolUpgradeOnTts_Button1.label");
         return result;
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
   }
}
