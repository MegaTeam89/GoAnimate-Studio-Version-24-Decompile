package anifire.popups
{
   import anifire.component.TextButton;
   import anifire.util.UtilDict;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.utils.Proxy;
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
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class RemovingZoomWarning extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _RemovingZoomWarning_Text1:Text;
      
      public var _RemovingZoomWarning_Text2:Text;
      
      public var _RemovingZoomWarning_Text3:Text;
      
      public var _RemovingZoomWarning_TextButton1:TextButton;
      
      private var _1481128871_btnOk:Button;
      
      private var _18423959_filterShadow:DropShadowFilter;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _RemovingZoomWarning_StylesInit_done:Boolean = false;
      
      private var _embed_mxml_warning_swf_887799037:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function RemovingZoomWarning()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___RemovingZoomWarning_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalAlign = "center";
                     this.verticalAlign = "middle";
                     this.verticalGap = 10;
                     this.paddingTop = 30;
                     this.paddingBottom = 40;
                     this.paddingLeft = 30;
                     this.paddingRight = 30;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Image,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"source":_embed_mxml_warning_swf_887799037};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Text,
                                 "id":"_RemovingZoomWarning_Text1",
                                 "stylesFactory":function():void
                                 {
                                    this.color = 11684642;
                                    this.fontSize = 18;
                                    this.fontWeight = "bold";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "x":30,
                                       "y":3
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"_RemovingZoomWarning_Text2",
                           "stylesFactory":function():void
                           {
                              this.color = 3355443;
                              this.fontSize = 12;
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
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Canvas,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnOk",
                                       "events":{"click":"___btnOk_click"},
                                       "stylesFactory":function():void
                                       {
                                          this.paddingBottom = 15;
                                          this.paddingTop = 5;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "buttonMode":true,
                                             "minWidth":150,
                                             "styleName":"btnProceed"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Text,
                                       "id":"_RemovingZoomWarning_Text3",
                                       "stylesFactory":function():void
                                       {
                                          this.color = 5712403;
                                          this.fontSize = 12;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "mouseEnabled":false,
                                             "mouseChildren":false,
                                             "horizontalCenter":0,
                                             "bottom":3
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Spacer,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"width":100};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":TextButton,
                                 "id":"_RemovingZoomWarning_TextButton1",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"clickFunc":onCancelClick};
                                 }
                              })]};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._embed_mxml_warning_swf_887799037 = RemovingZoomWarning__embed_mxml_warning_swf_887799037;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._RemovingZoomWarning_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_popups_RemovingZoomWarningWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return RemovingZoomWarning[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.minWidth = 500;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._RemovingZoomWarning_DropShadowFilter1_i();
         this.addEventListener("creationComplete",this.___RemovingZoomWarning_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         RemovingZoomWarning._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_RemovingZoomWarning_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onOkClick() : void
      {
         PopUpManager.removePopUp(this);
         this.dispatchEvent(new Event("okClick"));
      }
      
      private function onCancelClick(param1:MouseEvent) : void
      {
         PopUpManager.removePopUp(this);
         this.dispatchEvent(new Event("cancelClick"));
      }
      
      private function init() : void
      {
         this.draw();
      }
      
      private function draw() : void
      {
         var _loc1_:Number = 10;
         this.graphics.beginFill(16777215,0.5);
         this.graphics.drawRoundRectComplex(0,0,this.width,this.height,10,10,10,10);
         this.graphics.beginFill(16777215,1);
         this.graphics.drawRoundRectComplex(_loc1_,_loc1_,this.width - _loc1_ * 2,this.height - _loc1_ * 2,10,10,10,10);
         this.graphics.endFill();
      }
      
      private function _RemovingZoomWarning_DropShadowFilter1_i() : DropShadowFilter
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
      
      public function ___RemovingZoomWarning_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___btnOk_click(param1:MouseEvent) : void
      {
         this.onOkClick();
      }
      
      private function _RemovingZoomWarning_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Array
         {
            var _loc1_:* = [_filterShadow];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"this.filters");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Warning");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RemovingZoomWarning_Text1.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","The template you are adding contains old camera FXs that are now retired. You can insert the template in your movie, but these FXs will be removed, requiring you to redo your shots.\n\nTo use this template with these camera FXs, please copy an older movie created before our composition tool was introduced.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RemovingZoomWarning_Text2.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Insert Template");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnOk.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = "(" + UtilDict.toDisplay("go","Without camera FXs") + ")";
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RemovingZoomWarning_Text3.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Cancel");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_RemovingZoomWarning_TextButton1.label");
         return result;
      }
      
      mx_internal function _RemovingZoomWarning_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_RemovingZoomWarning_StylesInit_done)
         {
            return;
         }
         mx_internal::_RemovingZoomWarning_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".btnProceed");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnProceed",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.fontWeight = "bold";
               this.borderColor = 14515767;
               this.color = 16777215;
               this.cornerRadius = 10;
               this.textRollOverColor = 16777215;
               this.highlightAlphas = [0,0];
               this.fontSize = 18;
               this.fillColors = [15566397,16211508,16226612,15566397];
               this.fillAlphas = [1,1,1,1];
               this.themeColor = 14515767;
               this.textSelectedColor = 16777215;
            };
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
