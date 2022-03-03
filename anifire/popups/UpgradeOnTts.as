package anifire.popups
{
   import anifire.component.IconTextButton;
   import anifire.component.TextButton;
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
   
   public class UpgradeOnTts extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _UpgradeOnTts_Button1:Button;
      
      public var _UpgradeOnTts_Text1:Text;
      
      public var _UpgradeOnTts_Text2:Text;
      
      public var _UpgradeOnTts_Text3:Text;
      
      private var _951530617content:VBox;
      
      private var _1268861541footer:VBox;
      
      private var _878760310txtLink:TextButton;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function UpgradeOnTts()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___UpgradeOnTts_Canvas1_creationComplete"},
            "stylesFactory":function():void
            {
               this.dropShadowEnabled = true;
            },
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "events":{"click":"___UpgradeOnTts_VBox1_click"},
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
                                    "id":"_UpgradeOnTts_Text1",
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
                                    "id":"_UpgradeOnTts_Text2",
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
                                    "id":"_UpgradeOnTts_Button1",
                                    "events":{"click":"___UpgradeOnTts_Button1_click"},
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
                           "type":VBox,
                           "id":"footer",
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
                                    "id":"_UpgradeOnTts_Text3",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontSize = 10;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":TextButton,
                                    "id":"txtLink",
                                    "events":{"click":"__txtLink_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "txtSize":10,
                                          "color":16777215,
                                          "textDecoration":"underline",
                                          "buttonMode":true
                                       };
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":IconTextButton,
                  "events":{"click":"___UpgradeOnTts_IconTextButton1_click"},
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
         var bindings:Array = this._UpgradeOnTts_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_popups_UpgradeOnTtsWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return UpgradeOnTts[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___UpgradeOnTts_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         UpgradeOnTts._watcherSetupUtil = param1;
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
         UtilNavigate.toUpgradePage("extra_tts");
         this.onClose();
      }
      
      private function init() : void
      {
         this.draw();
         this.txtLink.txt.setStyle("color",16777215);
      }
      
      private function draw() : void
      {
         this.content.graphics.beginFill(16777215);
         this.content.graphics.drawRoundRectComplex(0,0,this.content.width,this.content.height,10,10,0,0);
         this.content.graphics.endFill();
         this.footer.graphics.beginFill(3355443);
         this.footer.graphics.drawRoundRectComplex(0,0,this.footer.width,this.footer.height,0,0,10,10);
         this.footer.graphics.endFill();
      }
      
      public function ___UpgradeOnTts_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___UpgradeOnTts_VBox1_click(param1:MouseEvent) : void
      {
         this.onClick();
      }
      
      public function ___UpgradeOnTts_Button1_click(param1:MouseEvent) : void
      {
         this.onUpgradeBtnClick();
      }
      
      public function __txtLink_click(param1:MouseEvent) : void
      {
         this.onUpgradeBtnClick();
      }
      
      public function ___UpgradeOnTts_IconTextButton1_click(param1:MouseEvent) : void
      {
         this.onClose();
      }
      
      private function _UpgradeOnTts_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Increase your monthly Text-to-Voice quota");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_UpgradeOnTts_Text1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Sign up to GoPlus to get 200 monthly Text-to-Voice credits instead of 50 and make tons of super cool cartoons!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_UpgradeOnTts_Text2.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Upgrade to GoPlus");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_UpgradeOnTts_Button1.label");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Other GoPlus features include: Free export to YouTube, Free bonus GoBucks on sign up and lots more.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_UpgradeOnTts_Text3.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Check out all GoPlus features");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"txtLink.label");
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
      
      [Bindable(event="propertyChange")]
      public function get footer() : VBox
      {
         return this._1268861541footer;
      }
      
      public function set footer(param1:VBox) : void
      {
         var _loc2_:Object = this._1268861541footer;
         if(_loc2_ !== param1)
         {
            this._1268861541footer = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"footer",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtLink() : TextButton
      {
         return this._878760310txtLink;
      }
      
      public function set txtLink(param1:TextButton) : void
      {
         var _loc2_:Object = this._878760310txtLink;
         if(_loc2_ !== param1)
         {
            this._878760310txtLink = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtLink",_loc2_,param1));
            }
         }
      }
   }
}
