package anifire.components.containers
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.event.CoreEvent;
   import anifire.managers.CommunityStuffManager;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.Grid;
   import mx.containers.GridItem;
   import mx.containers.GridRow;
   import mx.containers.Tile;
   import mx.containers.TitleWindow;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class TemplateInfoWindow extends TitleWindow implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1370988937_btnCancel:Button;
      
      private var _842110778_btnUpdate:Button;
      
      private var _401318921_canEditInfo:Canvas;
      
      private var _1598053662_labels:Label;
      
      private var _1962596944_lblTags:Label;
      
      private var _710712415_lblTitle:Label;
      
      private var _1479694698_txtTags:TextInput;
      
      private var _1373853913_txtTitle:TextInput;
      
      private var _713047211_txtWarning:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _movieId:String;
      
      private var _1087376665_assetTitle:String;
      
      private var _91286776_tags:String;
      
      private var _thumbnailCanvas:ThumbnailCanvas;
      
      private var _thumb:Object;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function TemplateInfoWindow()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "events":{"creationComplete":"___TemplateInfoWindow_TitleWindow1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":380,
                  "height":240,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "stylesFactory":function():void
                     {
                        this.backgroundSize = "100%";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"popupAssetInfoWindow"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_canEditInfo",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":true,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Grid,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":38,
                                    "y":48,
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":GridRow,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"childDescriptors":[new UIComponentDescriptor({
                                             "type":GridItem,
                                             "propertiesFactory":function():Object
                                             {
                                                return {"childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"_lblTitle",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.fontSize = 18;
                                                   }
                                                })]};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":GridItem,
                                             "propertiesFactory":function():Object
                                             {
                                                return {"childDescriptors":[new UIComponentDescriptor({
                                                   "type":TextInput,
                                                   "id":"_txtTitle",
                                                   "events":{"change":"___txtTitle_change"},
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "maxChars":50,
                                                         "width":250
                                                      };
                                                   }
                                                })]};
                                             }
                                          })]};
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":GridRow,
                                       "propertiesFactory":function():Object
                                       {
                                          return {"childDescriptors":[new UIComponentDescriptor({
                                             "type":GridItem,
                                             "propertiesFactory":function():Object
                                             {
                                                return {"childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"_lblTags",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.fontSize = 18;
                                                   }
                                                })]};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":GridItem,
                                             "propertiesFactory":function():Object
                                             {
                                                return {"childDescriptors":[new UIComponentDescriptor({
                                                   "type":TextInput,
                                                   "id":"_txtTags",
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "maxChars":50,
                                                         "width":250
                                                      };
                                                   }
                                                })]};
                                             }
                                          })]};
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "bottom":15,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Tile,
                              "stylesFactory":function():void
                              {
                                 this.horizontalGap = 10;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "direction":"horizontal",
                                    "horizontalCenter":0,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnUpdate",
                                       "events":{"click":"___btnUpdate_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnBlack",
                                             "buttonMode":true,
                                             "percentWidth":100
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"_btnCancel",
                                       "events":{"click":"___btnCancel_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "styleName":"btnBlack",
                                             "buttonMode":true,
                                             "percentWidth":100
                                          };
                                       }
                                    })]
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Text,
                     "id":"_txtWarning",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 14;
                        this.textAlign = "center";
                        this.fontWeight = "bold";
                        this.color = 13707528;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":35,
                           "y":158,
                           "visible":false,
                           "width":227
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Label,
                     "id":"_labels",
                     "stylesFactory":function():void
                     {
                        this.fontSize = 22;
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":7,
                           "y":8,
                           "text":""
                        };
                     }
                  })]
               };
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._TemplateInfoWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_TemplateInfoWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return TemplateInfoWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.layout = "absolute";
         this.width = 380;
         this.height = 240;
         this.styleName = "popupWindow";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___TemplateInfoWindow_TitleWindow1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         TemplateInfoWindow._watcherSetupUtil = param1;
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
      
      private function onLoadXML(param1:Event) : void
      {
         var _loc4_:XML = null;
         var _loc5_:XMLList = null;
         var _loc6_:String = null;
         var _loc7_:XML = null;
         var _loc2_:String = String(URLLoader(param1.currentTarget).data);
         var _loc3_:String = _loc2_.substr(0,1);
         if(_loc3_ == "0")
         {
            _loc5_ = (_loc4_ = new XML(_loc2_.substr(1))).child("template") as XMLList;
            this.assetTitle = _loc5_.@title;
            this.tags = _loc5_.@tags;
         }
         else
         {
            _loc6_ = "";
            try
            {
               _loc6_ = (_loc7_ = new XML(_loc2_.substr(1))).child("code");
            }
            catch(e:Error)
            {
            }
            if(_loc6_ == ServerConstants.ERROR_CODE_UNSUPPORTED_IMAGE_FORMAT)
            {
               Alert.show("The image format is not supported.");
            }
            else
            {
               Alert.show("Error occur during the upload process. Let\'s try again later.","Checkcode " + _loc3_);
            }
         }
      }
      
      public function loadInfo(param1:String) : void
      {
         var _loc3_:URLRequest = null;
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc3_ = new URLRequest(ServerConstants.ACTION_GET_TEMPLATE_INFO);
         _loc2_["movieId"] = param1;
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = _loc2_;
         var _loc4_:URLLoader;
         (_loc4_ = new URLLoader()).dataFormat = URLLoaderDataFormat.TEXT;
         _loc4_.addEventListener(Event.COMPLETE,this.onLoadXML);
         _loc4_.load(_loc3_);
      }
      
      public function set movieId(param1:String) : void
      {
         this._movieId = param1;
         this.loadInfo(param1);
      }
      
      public function get movieId() : String
      {
         return this._movieId;
      }
      
      public function set assetTitle(param1:String) : void
      {
         this._assetTitle = param1;
      }
      
      public function get assetTitle() : String
      {
         return this._assetTitle;
      }
      
      public function set tags(param1:String) : void
      {
         this._tags = param1;
      }
      
      public function get tags() : String
      {
         return this._tags;
      }
      
      public function set thumbnailCanvas(param1:ThumbnailCanvas) : void
      {
         this._thumbnailCanvas = param1;
      }
      
      public function get thumbnailCanvas() : ThumbnailCanvas
      {
         return this._thumbnailCanvas;
      }
      
      private function init() : void
      {
         CommunityStuffManager.instance.addEventListener(CoreEvent.UPDATE_ASSET_COMPLETE,this.closeWindow);
         this.defaultButton = this._btnCancel;
         if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_ADMIN) == "1")
         {
            this._txtTags.maxChars = 500;
         }
      }
      
      private function closeWindow(param1:Event) : void
      {
         PopUpManager.removePopUp(this);
      }
      
      public function set thumb(param1:Object) : void
      {
         this._thumb = param1;
      }
      
      private function updateAsset(param1:Event) : void
      {
         var event:Event = param1;
         var hasOverlyLongTags:Boolean = this._txtTags.text.split(/\s*,\s*/).some(function(param1:*, param2:int, param3:Array):Boolean
         {
            return String(param1).length > 50;
         });
         if(hasOverlyLongTags)
         {
            this._txtWarning.text = UtilDict.toDisplay("go","Each tag is limited to a maximum of 50 characters.");
            this._txtWarning.visible = true;
            this._txtTags.setFocus();
            return;
         }
         var badwordfilter:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         if(badwordfilter.containsBadword(this._txtTitle.text))
         {
            this._txtWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._txtWarning.visible = true;
            this._txtTitle.setFocus();
            return;
         }
         if(badwordfilter.containsBadword(this._txtTags.text))
         {
            this._txtWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BAD);
            this._txtWarning.visible = true;
            this._txtTags.setFocus();
            return;
         }
         this.thumbnailCanvas.thumbnailName = this._txtTitle.text;
         this.thumbnailCanvas.thumb.tags = this._txtTags.text;
         this._txtWarning.visible = false;
         CommunityStuffManager.instance.updateTemplate(this._movieId,this._txtTitle.text,this._txtTags.text);
      }
      
      private function onTitleChange() : void
      {
         if(this._txtTitle.length < 1)
         {
            this._txtWarning.text = UtilDict.toDisplay("go",AnimeConstants.ERR_BLANK);
            this._txtWarning.visible = true;
            this._btnUpdate.enabled = false;
         }
         else
         {
            this._txtWarning.visible = false;
            this._btnUpdate.enabled = true;
         }
      }
      
      private function getBitmapData(param1:UIComponent) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Matrix = null;
         try
         {
            _loc2_ = new BitmapData(param1.width,param1.height);
            _loc3_ = new Matrix();
            _loc2_.draw(param1,_loc3_);
            return _loc2_;
         }
         catch(exp:Error)
         {
            return null;
         }
      }
      
      public function ___TemplateInfoWindow_TitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___txtTitle_change(param1:Event) : void
      {
         this.onTitleChange();
      }
      
      public function ___btnUpdate_click(param1:MouseEvent) : void
      {
         this.updateAsset(param1);
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      private function _TemplateInfoWindow_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_name");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_lblTitle.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = _assetTitle;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtTitle.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_tags");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_lblTags.text");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = _tags;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtTags.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_update");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnUpdate.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_cancel");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCancel.label");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_warning");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtWarning.text");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCancel() : Button
      {
         return this._1370988937_btnCancel;
      }
      
      public function set _btnCancel(param1:Button) : void
      {
         var _loc2_:Object = this._1370988937_btnCancel;
         if(_loc2_ !== param1)
         {
            this._1370988937_btnCancel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCancel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnUpdate() : Button
      {
         return this._842110778_btnUpdate;
      }
      
      public function set _btnUpdate(param1:Button) : void
      {
         var _loc2_:Object = this._842110778_btnUpdate;
         if(_loc2_ !== param1)
         {
            this._842110778_btnUpdate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnUpdate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canEditInfo() : Canvas
      {
         return this._401318921_canEditInfo;
      }
      
      public function set _canEditInfo(param1:Canvas) : void
      {
         var _loc2_:Object = this._401318921_canEditInfo;
         if(_loc2_ !== param1)
         {
            this._401318921_canEditInfo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEditInfo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _labels() : Label
      {
         return this._1598053662_labels;
      }
      
      public function set _labels(param1:Label) : void
      {
         var _loc2_:Object = this._1598053662_labels;
         if(_loc2_ !== param1)
         {
            this._1598053662_labels = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_labels",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblTags() : Label
      {
         return this._1962596944_lblTags;
      }
      
      public function set _lblTags(param1:Label) : void
      {
         var _loc2_:Object = this._1962596944_lblTags;
         if(_loc2_ !== param1)
         {
            this._1962596944_lblTags = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblTags",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblTitle() : Label
      {
         return this._710712415_lblTitle;
      }
      
      public function set _lblTitle(param1:Label) : void
      {
         var _loc2_:Object = this._710712415_lblTitle;
         if(_loc2_ !== param1)
         {
            this._710712415_lblTitle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblTitle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTags() : TextInput
      {
         return this._1479694698_txtTags;
      }
      
      public function set _txtTags(param1:TextInput) : void
      {
         var _loc2_:Object = this._1479694698_txtTags;
         if(_loc2_ !== param1)
         {
            this._1479694698_txtTags = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTags",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtTitle() : TextInput
      {
         return this._1373853913_txtTitle;
      }
      
      public function set _txtTitle(param1:TextInput) : void
      {
         var _loc2_:Object = this._1373853913_txtTitle;
         if(_loc2_ !== param1)
         {
            this._1373853913_txtTitle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtTitle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtWarning() : Text
      {
         return this._713047211_txtWarning;
      }
      
      public function set _txtWarning(param1:Text) : void
      {
         var _loc2_:Object = this._713047211_txtWarning;
         if(_loc2_ !== param1)
         {
            this._713047211_txtWarning = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtWarning",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _assetTitle() : String
      {
         return this._1087376665_assetTitle;
      }
      
      private function set _assetTitle(param1:String) : void
      {
         var _loc2_:Object = this._1087376665_assetTitle;
         if(_loc2_ !== param1)
         {
            this._1087376665_assetTitle = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_assetTitle",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _tags() : String
      {
         return this._91286776_tags;
      }
      
      private function set _tags(param1:String) : void
      {
         var _loc2_:Object = this._91286776_tags;
         if(_loc2_ !== param1)
         {
            this._91286776_tags = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tags",_loc2_,param1));
            }
         }
      }
   }
}
