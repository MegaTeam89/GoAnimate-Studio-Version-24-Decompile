package anifire.components.publish
{
   import anifire.component.IconTextButton;
   import anifire.util.UtilDict;
   import anifire.util.UtilPopUp;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TileList;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class WatermarkChoosingPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _WatermarkChoosingPanel_Button1:Button;
      
      public var _WatermarkChoosingPanel_IconTextButton1:IconTextButton;
      
      public var _WatermarkChoosingPanel_Label1:Label;
      
      public var _WatermarkChoosingPanel_Label2:Label;
      
      public var _WatermarkChoosingPanel_Text1:Text;
      
      private var _2106232724tileList:TileList;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _selectedWatermark:WatermarkData;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function WatermarkChoosingPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___WatermarkChoosingPanel_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 20;
                     this.paddingBottom = 10;
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
                              this.verticalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_WatermarkChoosingPanel_Label1",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"styleName":"publishWindowTitleStyle"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_WatermarkChoosingPanel_Label2",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"styleName":"publishWindowSubtitleStyle"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Text,
                                 "id":"_WatermarkChoosingPanel_Text1",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"styleName":"publishWindowSubtitleStyle"};
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.verticalGap = 20;
                              this.paddingLeft = 20;
                              this.paddingRight = 20;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":TileList,
                                    "id":"tileList",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "columnCount":5,
                                          "styleName":"publishWindowWhiteBoxStyle",
                                          "itemRenderer":_WatermarkChoosingPanel_ClassFactory1_c()
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalAlign = "center";
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_WatermarkChoosingPanel_Button1",
                                             "events":{"click":"___WatermarkChoosingPanel_Button1_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"publishWindowMajorBtnStyle",
                                                   "height":32,
                                                   "buttonMode":true
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Spacer,
                                             "propertiesFactory":function():Object
                                             {
                                                return {"width":10};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":IconTextButton,
                                             "id":"_WatermarkChoosingPanel_IconTextButton1",
                                             "events":{"click":"___WatermarkChoosingPanel_IconTextButton1_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"publishWindowBtnStyle",
                                                   "height":32,
                                                   "buttonMode":true
                                                };
                                             }
                                          })]
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
         this._selectedWatermark = new WatermarkData();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._WatermarkChoosingPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_publish_WatermarkChoosingPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return WatermarkChoosingPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___WatermarkChoosingPanel_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         WatermarkChoosingPanel._watcherSetupUtil = param1;
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
      
      public function get selectedWatermark() : WatermarkData
      {
         return this._selectedWatermark;
      }
      
      public function set selectedWatermark(param1:WatermarkData) : void
      {
         this._selectedWatermark = param1;
         this.tileList.selectedItem = param1;
      }
      
      private function onCancelBtnClick() : void
      {
         this.dispatchEvent(new Event("cancel"));
      }
      
      private function onUpdateBtnClick() : void
      {
         var _loc1_:WatermarkData = this.tileList.selectedItem as WatermarkData;
         if(_loc1_)
         {
            this._selectedWatermark = _loc1_;
            this.dispatchEvent(new Event("watermarkUpdated"));
         }
         else
         {
            UtilPopUp.alert("Please select a watermark.");
         }
      }
      
      private function onCreationComplete() : void
      {
      }
      
      public function loadAllWatermarks(param1:Array) : void
      {
         if(param1)
         {
            this.tileList.dataProvider = param1;
         }
      }
      
      public function ___WatermarkChoosingPanel_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete();
      }
      
      private function _WatermarkChoosingPanel_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = WatermarkItemRenderer;
         return _loc1_;
      }
      
      public function ___WatermarkChoosingPanel_Button1_click(param1:MouseEvent) : void
      {
         this.onUpdateBtnClick();
      }
      
      public function ___WatermarkChoosingPanel_IconTextButton1_click(param1:MouseEvent) : void
      {
         this.onCancelBtnClick();
      }
      
      private function _WatermarkChoosingPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Switch the watermark for this Video");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_WatermarkChoosingPanel_Label1.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Want to use a brand new watermark?");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_WatermarkChoosingPanel_Label2.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Send us the image by email at sales@goanimate.com");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_WatermarkChoosingPanel_Text1.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Update watermark");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_WatermarkChoosingPanel_Button1.label");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Cancel");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_WatermarkChoosingPanel_IconTextButton1.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get tileList() : TileList
      {
         return this._2106232724tileList;
      }
      
      public function set tileList(param1:TileList) : void
      {
         var _loc2_:Object = this._2106232724tileList;
         if(_loc2_ !== param1)
         {
            this._2106232724tileList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tileList",_loc2_,param1));
            }
         }
      }
   }
}
