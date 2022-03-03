package anifire.popups
{
   import anifire.component.IconTextButton;
   import anifire.util.UtilDict;
   import anifire.util.UtilNavigate;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class BusinessPreviewUpgrade extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _BusinessPreviewUpgrade_Text1:Text;
      
      public var _BusinessPreviewUpgrade_Text2:Text;
      
      public var _BusinessPreviewUpgrade_Text3:Text;
      
      public var _BusinessPreviewUpgrade_Text4:Text;
      
      private var _2044384006_btnCloseTop:IconTextButton;
      
      private var _1481128871_btnOk:Button;
      
      private var _18423959_filterShadow:DropShadowFilter;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _BusinessPreviewUpgrade_StylesInit_done:Boolean = false;
      
      private var _embed_mxml_image_char_png_930302995:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function BusinessPreviewUpgrade()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___BusinessPreviewUpgrade_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "left";
                     this.verticalAlign = "middle";
                     this.verticalGap = 20;
                     this.paddingBottom = 30;
                     this.paddingLeft = 30;
                     this.paddingRight = 30;
                     this.paddingTop = 20;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":700,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Text,
                           "id":"_BusinessPreviewUpgrade_Text1",
                           "stylesFactory":function():void
                           {
                              this.color = 16777215;
                              this.fontSize = 14;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
                                    {
                                       this.verticalGap = 25;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_BusinessPreviewUpgrade_Text2",
                                             "stylesFactory":function():void
                                             {
                                                this.leading = 5;
                                                this.color = 6776679;
                                                this.fontSize = 22;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"percentWidth":100};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_BusinessPreviewUpgrade_Text3",
                                             "stylesFactory":function():void
                                             {
                                                this.leading = 7;
                                                this.color = 10066329;
                                                this.fontSize = 16;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"percentWidth":100};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_BusinessPreviewUpgrade_Text4",
                                             "stylesFactory":function():void
                                             {
                                                this.leading = 7;
                                                this.color = 10580281;
                                                this.fontSize = 16;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"percentWidth":100};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.verticalAlign = "middle";
                                                this.horizontalGap = 20;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"childDescriptors":[new UIComponentDescriptor({
                                                   "type":Button,
                                                   "id":"_btnOk",
                                                   "events":{"click":"___btnOk_click"},
                                                   "stylesFactory":function():void
                                                   {
                                                      this.paddingBottom = 5;
                                                      this.paddingTop = 5;
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "height":40,
                                                         "width":250,
                                                         "buttonMode":true,
                                                         "minWidth":150,
                                                         "styleName":"btnSignUpStyle"
                                                      };
                                                   }
                                                })]};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_image_char_png_930302995};
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":IconTextButton,
                  "id":"_btnCloseTop",
                  "events":{"click":"___btnCloseTop_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "right":20,
                        "top":20,
                        "styleName":"btnCloseTop",
                        "buttonMode":true,
                        "labelPlacement":"left"
                     };
                  }
               })]};
            }
         });
         this._embed_mxml_image_char_png_930302995 = BusinessPreviewUpgrade__embed_mxml_image_char_png_930302995;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._BusinessPreviewUpgrade_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_popups_BusinessPreviewUpgradeWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return BusinessPreviewUpgrade[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.minWidth = 500;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._BusinessPreviewUpgrade_DropShadowFilter1_i();
         this.addEventListener("creationComplete",this.___BusinessPreviewUpgrade_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         BusinessPreviewUpgrade._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_BusinessPreviewUpgrade_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onOkClick() : void
      {
         UtilNavigate.toBusinessPlanPage("biztrialoverlay");
         PopUpManager.removePopUp(this);
         this.dispatchEvent(new Event("okClick"));
      }
      
      private function onClose() : void
      {
         PopUpManager.removePopUp(this);
      }
      
      private function init() : void
      {
         this.draw();
      }
      
      private function draw() : void
      {
         var _loc1_:Number = 10;
         this.graphics.beginFill(10066329,0.5);
         this.graphics.drawRoundRectComplex(0,0,this.width,this.height,20,20,20,20);
         this.graphics.beginFill(15658734,1);
         this.graphics.drawRoundRectComplex(_loc1_,_loc1_,this.width - _loc1_ * 2,this.height - _loc1_ * 2,20,20,20,20);
         this.graphics.beginFill(3842223,1);
         this.graphics.drawRoundRectComplex(_loc1_,_loc1_,this.width - _loc1_ * 2,40,20,20,0,0);
         this.graphics.endFill();
      }
      
      private function onLearnClick() : void
      {
         UtilNavigate.toBusinessPage("studio","_blank");
         PopUpManager.removePopUp(this);
      }
      
      private function _BusinessPreviewUpgrade_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.distance = 0;
         _loc1_.blurX = 5;
         _loc1_.blurY = 5;
         _loc1_.angle = 45;
         _loc1_.color = 0;
         _loc1_.alpha = 0.75;
         this._filterShadow = _loc1_;
         BindingManager.executeBindings(this,"_filterShadow",this._filterShadow);
         return _loc1_;
      }
      
      public function ___BusinessPreviewUpgrade_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___btnOk_click(param1:MouseEvent) : void
      {
         this.onOkClick();
      }
      
      public function ___btnCloseTop_click(param1:MouseEvent) : void
      {
         this.onClose();
      }
      
      private function _BusinessPreviewUpgrade_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Sorry, this is a demo environment only. Videos created in this environment cannot be saved.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_BusinessPreviewUpgrade_Text1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Love GoAnimate for Business? Upgrade to a Business Account Now!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_BusinessPreviewUpgrade_Text2.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","GoAnimate business accounts offer unlimited video production, hosting, playback, downloads to mp4 -- and access to our growing collection of exclusive Video Makers, such as the ones you have been previewing.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_BusinessPreviewUpgrade_Text3.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","We offer different business account packages to fit your needs and budget. For just about $50/month.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_BusinessPreviewUpgrade_Text4.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Upgrade Now >");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnOk.label");
         return result;
      }
      
      mx_internal function _BusinessPreviewUpgrade_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_BusinessPreviewUpgrade_StylesInit_done)
         {
            return;
         }
         mx_internal::_BusinessPreviewUpgrade_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".btnSignUpStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnSignUpStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.color = 16777215;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontFamily = "TrebuchetMS1";
               this.fontSize = 20;
               this.fillColors = [5026021,3643081,8177647,5026021];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 5026021;
               this.textSelectedColor = 16777215;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCloseTop() : IconTextButton
      {
         return this._2044384006_btnCloseTop;
      }
      
      public function set _btnCloseTop(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2044384006_btnCloseTop;
         if(_loc2_ !== param1)
         {
            this._2044384006_btnCloseTop = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCloseTop",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnOk() : Button
      {
         return this._1481128871_btnOk;
      }
      
      public function set _btnOk(param1:Button) : void
      {
         var _loc2_:Object = this._1481128871_btnOk;
         if(_loc2_ !== param1)
         {
            this._1481128871_btnOk = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnOk",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _filterShadow() : DropShadowFilter
      {
         return this._18423959_filterShadow;
      }
      
      public function set _filterShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._18423959_filterShadow;
         if(_loc2_ !== param1)
         {
            this._18423959_filterShadow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_filterShadow",_loc2_,param1));
            }
         }
      }
   }
}
