package anifire.assets.transition.view
{
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
   
   public class TransitionNumberWarning extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _TransitionNumberWarning_Text1:Text;
      
      public var _TransitionNumberWarning_Text2:Text;
      
      private var _1481128871_btnOk:Button;
      
      private var _18423959_filterShadow:DropShadowFilter;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _TransitionNumberWarning_StylesInit_done:Boolean = false;
      
      private var _embed_mxml_warning_swf_34046369:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function TransitionNumberWarning()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___TransitionNumberWarning_Canvas1_creationComplete"},
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
                                    return {"source":_embed_mxml_warning_swf_34046369};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Text,
                                 "id":"_TransitionNumberWarning_Text1",
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
                           "id":"_TransitionNumberWarning_Text2",
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
                           "type":Canvas,
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
                                       "buttonMode":true,
                                       "minWidth":150,
                                       "styleName":"btnProceed"
                                    };
                                 }
                              })]};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this._embed_mxml_warning_swf_34046369 = TransitionNumberWarning__embed_mxml_warning_swf_34046369;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._TransitionNumberWarning_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_assets_transition_view_TransitionNumberWarningWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return TransitionNumberWarning[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.minWidth = 500;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._TransitionNumberWarning_DropShadowFilter1_i();
         this.addEventListener("creationComplete",this.___TransitionNumberWarning_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         TransitionNumberWarning._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_TransitionNumberWarning_StylesInit();
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
      
      private function _TransitionNumberWarning_DropShadowFilter1_i() : DropShadowFilter
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
      
      public function ___TransitionNumberWarning_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___btnOk_click(param1:MouseEvent) : void
      {
         this.onOkClick();
      }
      
      private function _TransitionNumberWarning_bindingsSetup() : Array
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
         },null,"_TransitionNumberWarning_Text1.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Adding too many enter and exit transitions in one scene may adversely affect your video playback performance. It may also affect exporting your video. We recommend using fewer than 10 in each scene. If your video does not play smoothly, check how many enter and exits transitions you have on each scene.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_TransitionNumberWarning_Text2.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","OK, I understand");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnOk.label");
         return result;
      }
      
      mx_internal function _TransitionNumberWarning_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_TransitionNumberWarning_StylesInit_done)
         {
            return;
         }
         mx_internal::_TransitionNumberWarning_StylesInit_done = true;
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
