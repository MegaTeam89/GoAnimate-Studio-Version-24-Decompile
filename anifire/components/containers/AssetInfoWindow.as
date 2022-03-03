package anifire.components.containers
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.Behavior;
   import anifire.core.CharThumb;
   import anifire.core.Console;
   import anifire.core.SoundThumb;
   import anifire.core.Thumb;
   import anifire.core.VideoPropThumb;
   import anifire.event.CoreEvent;
   import anifire.managers.UserStuffManager;
   import anifire.timeline.SceneContainer;
   import anifire.timeline.SceneElement;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilUnitConvert;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
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
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.HSlider;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.controls.TileList;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.SliderEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class AssetInfoWindow extends TitleWindow implements IBindingClient
   {
      
      public static var TYPE_ZOOM:String = "ZOOM";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1354780629_actionTray:TileList;
      
      private var _1370988937_btnCancel:Button;
      
      private var _842110778_btnUpdate:Button;
      
      private var _401318921_canEditInfo:Canvas;
      
      private var _915136786_canEditLengths:Canvas;
      
      private var _1598053662_labels:Label;
      
      private var _992259101_lblEdTime:Label;
      
      private var _992074519_lblEdZoom:Label;
      
      private var _576674651_lblStTime:Label;
      
      private var _576490069_lblStZoom:Label;
      
      private var _1962596944_lblTags:Label;
      
      private var _710712415_lblTitle:Label;
      
      private var _557248335_lblTitle2:Label;
      
      private var _230640921_radioPrivate:RadioButton;
      
      private var _1113266043_radioPublic:RadioButton;
      
      private var _1366999227_sceneCanvas:Canvas;
      
      private var _1182073243_sliderBg:Canvas;
      
      private var _690965710_sliderStEd2:HSlider;
      
      private var _690965708_sliderStEd4:HSlider;
      
      private var _54900069_sliderStEdBg:Canvas;
      
      private var _54900193_sliderStEdFg:Canvas;
      
      private var _54900241_sliderStEdGx:Canvas;
      
      private var _1479694698_txtTags:TextInput;
      
      private var _1373853913_txtTitle:TextInput;
      
      private var _713047211_txtWarning:Text;
      
      private var _1729673616scene_img:Image;
      
      private var _1729676163scene_lbl:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      public var INFO_MODE:String = "info_mode";
      
      public var LEN_MODE:String = "length_mode";
      
      private var _assetId:String;
      
      private var _mode:String = "";
      
      private var _1087376665_assetTitle:String;
      
      private var _1355027053_actionList:Array;
      
      private var _91286776_tags:String;
      
      private var _isPublished:Boolean;
      
      private var _thumbnailCanvas:ThumbnailCanvas;
      
      private var _durscene:Number;
      
      private var _sttime:Number;
      
      private var _edtime:Number;
      
      private var _stzoom:Number = 0.5;
      
      private var _edzoom:Number = 0.5;
      
      private var _type:String = "";
      
      private var _zMode:Boolean = false;
      
      private var _firstThumbId:int;
      
      private var _secondThumbId:int;
      
      private var _sliderStEd:HSlider;
      
      private const _trHeight:Number = 25;
      
      private const MIN_INT:Number = 0.1;
      
      private var MIN_DIST:Number;
      
      private var _allowPublish:Boolean = true;
      
      private var _thumb:Object;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function AssetInfoWindow()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "events":{"creationComplete":"___AssetInfoWindow_TitleWindow1_creationComplete"},
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
                           "visible":false,
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
                           }),new UIComponentDescriptor({
                              "type":RadioButton,
                              "id":"_radioPublic",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 18;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":98.5,
                                    "y":122,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":RadioButton,
                              "id":"_radioPrivate",
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 18;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":193.5,
                                    "y":122,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TileList,
                              "id":"_actionTray",
                              "stylesFactory":function():void
                              {
                                 this.cornerRadius = 8;
                                 this.themeColor = 8960767;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "direction":"horizontal",
                                    "horizontalScrollPolicy":"off",
                                    "height":135,
                                    "width":358,
                                    "y":153,
                                    "visible":false,
                                    "itemRenderer":_AssetInfoWindow_ClassFactory1_c()
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_canEditLengths",
                     "propertiesFactory":function():Object
                     {
                        return {"childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.verticalGap = 1;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":20,
                                 "y":30,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_lblTitle2",
                                    "stylesFactory":function():void
                                    {
                                       this.fontSize = 12;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"text":""};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"height":15};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_sceneCanvas",
                                    "events":{"creationComplete":"___sceneCanvas_creationComplete"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalCenter":0,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "clipContent":false,
                                          "width":340,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Image,
                                             "id":"scene_img",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "y":1,
                                                   "maintainAspectRatio":false,
                                                   "width":76,
                                                   "height":51,
                                                   "horizontalCenter":0,
                                                   "verticalCenter":0
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"scene_lbl",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "center";
                                                this.fontWeight = "bold";
                                                this.fontSize = 40;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "text":"",
                                                   "percentWidth":100,
                                                   "horizontalCenter":0,
                                                   "bottom":4,
                                                   "selectable":false,
                                                   "verticalCenter":0
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_sliderBg",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "clipContent":false,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_sliderStEdGx"
                                          }),new UIComponentDescriptor({
                                             "type":HSlider,
                                             "id":"_sliderStEd2",
                                             "events":{
                                                "thumbDrag":"___sliderStEd2_thumbDrag",
                                                "creationComplete":"___sliderStEd2_creationComplete"
                                             },
                                             "stylesFactory":function():void
                                             {
                                                this.dataTipPlacement = "top";
                                                this.dataTipOffset = 3;
                                                this.showTrackHighlight = false;
                                                this.thumbOffset = -40;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "y":25,
                                                   "allowTrackClick":false,
                                                   "allowThumbOverlap":false,
                                                   "liveDragging":true,
                                                   "showDataTip":false,
                                                   "thumbCount":2,
                                                   "width":340,
                                                   "snapInterval":0.1,
                                                   "doubleClickEnabled":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HSlider,
                                             "id":"_sliderStEd4",
                                             "events":{
                                                "thumbDrag":"___sliderStEd4_thumbDrag",
                                                "creationComplete":"___sliderStEd4_creationComplete"
                                             },
                                             "stylesFactory":function():void
                                             {
                                                this.dataTipPlacement = "top";
                                                this.dataTipOffset = 3;
                                                this.showTrackHighlight = false;
                                                this.thumbOffset = -40;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "y":25,
                                                   "allowTrackClick":false,
                                                   "allowThumbOverlap":true,
                                                   "liveDragging":true,
                                                   "showDataTip":false,
                                                   "thumbCount":4,
                                                   "width":340,
                                                   "snapInterval":0.1,
                                                   "doubleClickEnabled":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_sliderStEdFg"
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_sliderStEdBg"
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_lblStTime",
                                             "stylesFactory":function():void
                                             {
                                                this.fontSize = 10;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"text":""};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_lblStZoom",
                                             "stylesFactory":function():void
                                             {
                                                this.fontSize = 10;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"text":""};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_lblEdTime",
                                             "stylesFactory":function():void
                                             {
                                                this.fontSize = 10;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"text":""};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_lblEdZoom",
                                             "stylesFactory":function():void
                                             {
                                                this.fontSize = 10;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"text":""};
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        })]};
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
         var bindings:Array = this._AssetInfoWindow_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_AssetInfoWindowWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return AssetInfoWindow[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.layout = "absolute";
         this.width = 380;
         this.height = 240;
         this.styleName = "popupWindow";
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___AssetInfoWindow_TitleWindow1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         AssetInfoWindow._watcherSetupUtil = param1;
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
      
      override protected function commitProperties() : void
      {
         if(this._radioPublic)
         {
            this._radioPublic.enabled = this.allowPublish;
            this._radioPrivate.enabled = this.allowPublish;
            if(!this.allowPublish)
            {
               this._radioPublic.visible = false;
               this._radioPrivate.visible = false;
            }
            if(!this.allowPublish && this.isPublished)
            {
               this._radioPrivate.selected = true;
            }
         }
      }
      
      public function set allowPublish(param1:Boolean) : void
      {
         this._allowPublish = param1;
         invalidateProperties();
      }
      
      public function get allowPublish() : Boolean
      {
         return this._allowPublish;
      }
      
      private function secToWidth(param1:Number) : Number
      {
         return param1 / (this._sliderStEd.maximum / (this._sliderStEd.width - this._sliderStEd.getThumbAt(0).width));
      }
      
      private function valueToPixel(param1:Number) : Number
      {
         return param1 * (this._sliderStEd.width - this._sliderStEd.getThumbAt(0).width) / this._sliderStEd.maximum;
      }
      
      public function set durscene(param1:Number) : void
      {
         this._durscene = param1;
         var _loc2_:Number = Math.round(UtilUnitConvert.frameToSec(this._durscene) * 10) / 10;
         this._sliderStEd.minimum = 0;
         this._sliderStEd.maximum = _loc2_;
         this._lblStTime.text = "0 s";
         this.sttime = 0;
         this.edtime = _loc2_;
         this._lblEdTime.text = Util.roundNum(_loc2_) + " s";
         this.MIN_DIST = this.secToWidth(this.MIN_INT);
      }
      
      public function set sttime(param1:Number) : void
      {
         if(param1 < this._sliderStEd.maximum)
         {
            this._sttime = param1;
         }
         else
         {
            this._sttime = 0;
         }
         this._sliderStEd.values[this._firstThumbId] = this._sttime;
         if(this._zMode)
         {
            if(this._sttime + 0.5 > this._sliderStEd.maximum - this.MIN_INT)
            {
               this._sliderStEd.values[this._firstThumbId + 1] = this._sttime + this.MIN_INT;
            }
            else
            {
               this._sliderStEd.values[this._firstThumbId + 1] = this._sttime + 0.5;
            }
         }
         this.updateSliderSZ();
         this.updateTags();
      }
      
      public function set stzoom(param1:Number) : void
      {
         if(this._zMode)
         {
            if(this._sttime + param1 >= this._sliderStEd.values[this._secondThumbId])
            {
               if(this._sliderStEd.values[this._secondThumbId] - this._sttime <= 0.5)
               {
                  this._stzoom = this._sliderStEd.values[this._secondThumbId] - this._sttime - this.MIN_INT;
               }
               else
               {
                  this._stzoom = this._sliderStEd.values[this._secondThumbId] - this._sttime - 0.5;
               }
            }
            else
            {
               this._stzoom = param1;
            }
            this._sliderStEd.values[this._firstThumbId + 1] = this._sttime + this._stzoom;
            this.updateSliderSZ();
         }
      }
      
      public function set edzoom(param1:Number) : void
      {
         if(this._zMode)
         {
            if(this._edtime + param1 > this._durscene)
            {
               this._edzoom = this._durscene - this._edtime;
            }
            else
            {
               this._edzoom = param1;
            }
            this._sliderStEd.values[this._secondThumbId + 1] = this._edtime + this._edzoom;
            this.updateSliderEZ();
         }
      }
      
      public function set edtime(param1:Number) : void
      {
         if(param1 <= this._sliderStEd.maximum)
         {
            this._edtime = param1;
         }
         else if(this._zMode)
         {
            this._edtime = this._sliderStEd.maximum;
         }
         else
         {
            this._edtime = this._sliderStEd.maximum;
         }
         this._sliderStEd.values[this._secondThumbId] = this._edtime;
         if(this._zMode)
         {
            this._sliderStEd.values[this._secondThumbId + 1] = this._edtime;
         }
         this.updateSliderEZ();
         this.updateTags();
      }
      
      public function set assetId(param1:String) : void
      {
         this._assetId = param1;
      }
      
      public function get assetId() : String
      {
         return this._assetId;
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
      
      public function set type(param1:String) : void
      {
         this._type = param1;
         this._sliderStEd2.visible = this._sliderStEd4.visible = false;
         if(this.type == TYPE_ZOOM)
         {
            this._sliderStEd4.visible = true;
            this._sliderStEd = this._sliderStEd4;
            this._sliderStEd.thumbCount = 4;
            this._firstThumbId = 0;
            this._secondThumbId = 2;
            this._lblStTime.y = this._lblEdZoom.y = this._trHeight + this._sliderStEd.y - 2;
            this._lblStZoom.y = this._lblEdTime.y = this._trHeight + this._sliderStEd.y - 14;
            this._zMode = true;
            this._labels.x = 20;
            this._labels.text = UtilDict.toDisplay("go","assetinfo_editzoomtitle");
            this._lblTitle2.text = UtilDict.toDisplay("go","assetinfo_editzoomsubtitle");
         }
         else
         {
            this._sliderStEd2.visible = true;
            this._sliderStEd = this._sliderStEd2;
            this._sliderStEd.thumbCount = 2;
            this._firstThumbId = 0;
            this._secondThumbId = 1;
            this._lblStZoom.visible = this._lblEdZoom.visible = false;
            this._lblStTime.y = this._lblEdTime.y = this._trHeight + this._sliderStEd.y - 2;
            this._labels.x = 20;
            this._labels.text = UtilDict.toDisplay("go","assetinfo_editassettitle");
            this._lblTitle2.text = UtilDict.toDisplay("go","assetinfo_editassetsubtitle");
         }
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set mode(param1:String) : void
      {
         this._mode = param1;
         if(this._mode == this.LEN_MODE)
         {
            this._canEditInfo.visible = false;
            this._canEditLengths.visible = true;
            this.height += 50;
         }
         else
         {
            this._canEditLengths.visible = false;
            this._canEditInfo.visible = true;
         }
      }
      
      public function get mode() : String
      {
         return this._mode;
      }
      
      public function set isPublished(param1:Boolean) : void
      {
         if(this._radioPublic.selected + this._radioPrivate.selected != 1)
         {
            this._isPublished = param1;
            this._radioPublic.selected = param1;
            this._radioPrivate.selected = !param1;
         }
      }
      
      public function get isPublished() : Boolean
      {
         return this._isPublished;
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
         UserStuffManager.instance.addEventListener(CoreEvent.UPDATE_ASSET_COMPLETE,this.closeWindow);
         this.defaultButton = this._btnCancel;
         if(this.mode == "")
         {
            this.mode = this.INFO_MODE;
         }
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
         if(param1 is CharThumb)
         {
            this.assetIsCharacter();
         }
         if(param1 is SoundThumb)
         {
            this.assetIsSound();
         }
         if(param1 is VideoPropThumb)
         {
            this.assetIsVideo();
         }
      }
      
      public function setAsDefault(param1:String) : void
      {
         (this._thumb as CharThumb).defaultAction = (this._thumb as CharThumb).getActionById(param1);
         var _loc2_:int = 0;
         while(_loc2_ < this._actionList.length)
         {
            if(this._actionList[_loc2_].id == param1)
            {
               break;
            }
            _loc2_++;
         }
         var _loc3_:String = this._actionList[0]["name"];
         var _loc4_:String = this._actionList[0]["id"];
         this._actionList[0]["id"] = param1;
         this._actionList[0]["name"] = this._actionList[_loc2_]["name"];
         this._actionList[_loc2_]["name"] = _loc3_;
         this._actionList[_loc2_]["id"] = _loc4_;
         this._actionTray.invalidateList();
         var _loc5_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc5_);
         if(_loc5_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
         {
            delete _loc5_[ServerConstants.PARAM_ASSET_ID];
         }
         _loc5_[ServerConstants.PARAM_ACTION_ID] = param1.substring(0,param1.length - 4);
         _loc5_["type"] = "char";
         _loc5_[ServerConstants.PARAM_ASSET_ID] = param1.substring(0,param1.length - 4);
         _loc5_[ServerConstants.PARAM_CHAR_ID] = (this._thumb as CharThumb).id;
         var _loc6_:URLRequest;
         (_loc6_ = new URLRequest(ServerConstants.ACTION_CHANGE_DEFAULT_ACTION)).method = URLRequestMethod.POST;
         _loc6_.data = _loc5_;
         var _loc7_:URLStream;
         (_loc7_ = new URLStream()).load(_loc6_);
      }
      
      private function deleteAction(param1:String) : void
      {
         (this._thumb as CharThumb).removeActionAndMenuItem((this._thumb as CharThumb).getActionById(param1));
         var _loc2_:int = 0;
         while(_loc2_ < this._actionList.length)
         {
            if(this._actionList[_loc2_].id == param1)
            {
               break;
            }
            _loc2_++;
         }
         this._actionList.splice(_loc2_,1);
         this._actionTray.invalidateList();
         var _loc3_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc3_);
         if(_loc3_.hasOwnProperty(ServerConstants.PARAM_ASSET_ID))
         {
            delete _loc3_[ServerConstants.PARAM_ASSET_ID];
         }
         _loc3_[ServerConstants.PARAM_ACTION_ID] = param1.substring(0,param1.length - 4);
         _loc3_["type"] = "char";
         _loc3_[ServerConstants.PARAM_ASSET_ID] = param1.substring(0,param1.length - 4);
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(ServerConstants.ACTION_DELETE_ASSET)).method = URLRequestMethod.POST;
         _loc4_.data = _loc3_;
         var _loc5_:URLStream;
         (_loc5_ = new URLStream()).load(_loc4_);
      }
      
      private function assetIsSound() : void
      {
         this.isPublished = false;
         this._radioPublic.enabled = this._radioPrivate.enabled = false;
      }
      
      private function assetIsVideo() : void
      {
         this._radioPublic.enabled = this._radioPrivate.enabled = false;
      }
      
      private function assetIsCharacter() : void
      {
         var _loc1_:Behavior = null;
         var _loc2_:int = 0;
         if((this._thumb as Thumb).isCC)
         {
            this._radioPrivate.enabled = false;
            this._radioPublic.enabled = false;
         }
         else
         {
            this.height = 340;
            this._actionTray.visible = true;
            this._actionList = new Array();
            if(this._thumb != null && this._thumb is CharThumb)
            {
               _loc1_ = (this._thumb as CharThumb).defaultAction as Behavior;
               this._actionList.push({
                  "name":_loc1_.name,
                  "id":_loc1_.id,
                  "notDefault":false,
                  "deleteFunction":this.deleteAction,
                  "defaultFunction":this.setAsDefault
               });
               _loc2_ = 0;
               while(_loc2_ < CharThumb(this._thumb).getActionNum())
               {
                  _loc1_ = CharThumb(this._thumb).getActionAt(_loc2_);
                  if((this._thumb as CharThumb).defaultAction != _loc1_)
                  {
                     this._actionList.push({
                        "name":_loc1_.name,
                        "id":_loc1_.id,
                        "notDefault":true,
                        "deleteFunction":this.deleteAction,
                        "defaultFunction":this.setAsDefault
                     });
                  }
                  _loc2_++;
               }
            }
         }
         this._btnCancel.label = UtilDict.toDisplay("go","assetinfo_done");
      }
      
      private function updateAsset(param1:Event) : void
      {
         var tempIspublished:Boolean = false;
         var hasOverlyLongTags:Boolean = false;
         var badwordfilter:BadwordFilter = null;
         var event:Event = param1;
         if(this.mode == this.INFO_MODE)
         {
            tempIspublished = !!this._radioPublic.selected ? true : false;
            hasOverlyLongTags = this._txtTags.text.split(/\s*,\s*/).some(function(param1:*, param2:int, param3:Array):Boolean
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
            badwordfilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
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
            this.thumbnailCanvas.thumb.isPublished = !!this._radioPublic.selected ? true : false;
            this.thumbnailCanvas.thumb.tags = this._txtTags.text;
            this._txtWarning.visible = false;
            UserStuffManager.instance.updateAsset(this._assetId,this._txtTitle.text,this._txtTags.text,!!this._radioPublic.selected ? true : false);
         }
         else if(this.mode == this.LEN_MODE)
         {
            if(!this._zMode)
            {
               Console.getConsole().updateAssetTime(this._assetId,this._sliderStEd.values[this._firstThumbId],this._sliderStEd.values[this._secondThumbId]);
            }
            else
            {
               Console.getConsole().updateAssetTime(this._assetId,this._sliderStEd.values[this._firstThumbId],this._sliderStEd.values[this._secondThumbId],this._sliderStEd.values[this._firstThumbId + 1] - this._sliderStEd.values[this._firstThumbId],this._sliderStEd.values[this._secondThumbId + 1] - this._sliderStEd.values[this._secondThumbId]);
            }
         }
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
      
      private function onSliding(param1:SliderEvent = null) : void
      {
         if(this._zMode && this.mode == this.LEN_MODE && param1 != null)
         {
            switch(param1.thumbIndex)
            {
               case this._firstThumbId:
                  if(this._sliderStEd.values[this._firstThumbId] > this._sliderStEd.values[this._firstThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId + 1).x = this._sliderStEd.getThumbAt(this._firstThumbId).x;
                     this._sliderStEd.values[this._firstThumbId + 1] = this._sliderStEd.values[this._firstThumbId];
                  }
                  if(this._sliderStEd.values[this._firstThumbId] + this.MIN_INT > this._sliderStEd.values[this._secondThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId).x = this._sliderStEd.getThumbAt(this._secondThumbId).x - this.MIN_DIST;
                     this._sliderStEd.values[this._firstThumbId] = this._sliderStEd.values[this._secondThumbId] - this.MIN_INT;
                     this._sliderStEd.getThumbAt(this._firstThumbId + 1).x = this._sliderStEd.getThumbAt(this._secondThumbId).x - this.MIN_DIST;
                     this._sliderStEd.values[this._firstThumbId + 1] = this._sliderStEd.values[this._secondThumbId] - this.MIN_INT;
                  }
                  break;
               case this._firstThumbId + 1:
                  if(this._sliderStEd.values[this._firstThumbId + 1] < this._sliderStEd.values[this._firstThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId).x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x;
                     this._sliderStEd.values[this._firstThumbId] = this._sliderStEd.values[this._firstThumbId + 1];
                  }
                  if(this._sliderStEd.values[this._firstThumbId + 1] + this.MIN_INT > this._sliderStEd.values[this._secondThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._firstThumbId + 1).x = this._sliderStEd.getThumbAt(this._secondThumbId).x - this.MIN_DIST;
                     this._sliderStEd.values[this._firstThumbId + 1] = this._sliderStEd.values[this._secondThumbId] - this.MIN_INT;
                  }
                  break;
               case this._secondThumbId:
                  if(this._sliderStEd.values[this._secondThumbId] - this.MIN_INT < this._sliderStEd.values[this._firstThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._secondThumbId).x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x + this.MIN_DIST;
                     this._sliderStEd.values[this._secondThumbId] = this._sliderStEd.values[this._firstThumbId + 1] + this.MIN_INT;
                  }
                  if(this._sliderStEd.values[this._secondThumbId] > this._sliderStEd.values[this._secondThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._secondThumbId + 1).x = this._sliderStEd.getThumbAt(this._secondThumbId).x;
                     this._sliderStEd.values[this._secondThumbId + 1] = this._sliderStEd.values[this._secondThumbId];
                  }
                  break;
               case this._secondThumbId + 1:
                  if(this._sliderStEd.values[this._secondThumbId + 1] < this._sliderStEd.values[this._secondThumbId])
                  {
                     this._sliderStEd.getThumbAt(this._secondThumbId).x = this._sliderStEd.getThumbAt(this._secondThumbId + 1).x;
                     this._sliderStEd.values[this._secondThumbId] = this._sliderStEd.values[this._secondThumbId + 1];
                  }
                  if(this._sliderStEd.values[this._secondThumbId + 1] - this.MIN_INT < this._sliderStEd.values[this._firstThumbId + 1])
                  {
                     this._sliderStEd.getThumbAt(this._secondThumbId).x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x + this.MIN_DIST;
                     this._sliderStEd.values[this._secondThumbId] = this._sliderStEd.values[this._firstThumbId + 1] + this.MIN_INT;
                     this._sliderStEd.getThumbAt(this._secondThumbId + 1).x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x + this.MIN_DIST;
                     this._sliderStEd.values[this._secondThumbId + 1] = this._sliderStEd.values[this._firstThumbId + 1] + this.MIN_INT;
                  }
            }
            this.updateSliderSZ();
            this.updateSliderEZ();
         }
         this.updateZoomDurGx();
         this.updateTags();
      }
      
      private function updateTags() : void
      {
         if(this._mode == this.LEN_MODE)
         {
            this._lblStTime.text = Util.roundNum(this._sliderStEd.values[this._firstThumbId]) + " s";
            this._lblEdTime.text = Util.roundNum(this._sliderStEd.values[this._secondThumbId]) + " s";
            this._lblStTime.x = this._sliderStEd.getThumbAt(this._firstThumbId).x + this._sliderStEd.getThumbAt(this._firstThumbId).width / 2 - this._lblStTime.width / 2;
            this._lblEdTime.x = this._sliderStEd.getThumbAt(this._secondThumbId).x + this._sliderStEd.getThumbAt(this._secondThumbId).width / 2 - this._lblEdTime.width / 2;
            if(this._zMode)
            {
               this._lblStZoom.text = Util.roundNum(this._sliderStEd.values[this._firstThumbId + 1]) + " s";
               this._lblEdZoom.text = Util.roundNum(this._sliderStEd.values[this._secondThumbId + 1]) + " s";
               this._lblStZoom.x = this._sliderStEd.getThumbAt(this._firstThumbId + 1).x + this._sliderStEd.getThumbAt(this._firstThumbId + 1).width / 2 - this._lblStZoom.width / 2;
               this._lblEdZoom.x = this._sliderStEd.getThumbAt(this._secondThumbId + 1).x + this._sliderStEd.getThumbAt(this._secondThumbId + 1).width / 2 - this._lblEdZoom.width / 2;
            }
         }
      }
      
      private function updateZoomDurGx(param1:FlexEvent = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         if(this._mode == this.LEN_MODE)
         {
            _loc2_ = this._sliderStEd.getThumbAt(this._firstThumbId).y;
            _loc3_ = this._sliderStEd.getThumbAt(this._firstThumbId).width / 2;
            _loc4_ = new Point(this.valueToPixel(Util.roundNum(this._sliderStEd.values[this._firstThumbId])) + _loc3_,_loc2_);
            _loc5_ = new Point(this.valueToPixel(Util.roundNum(this._sliderStEd.values[this._secondThumbId])) + _loc3_,_loc2_);
            if(this._zMode)
            {
               _loc9_ = new Point(this.valueToPixel(Util.roundNum(this._sliderStEd.values[this._firstThumbId + 1])) + _loc3_,_loc2_);
               _loc10_ = new Point(this.valueToPixel(Util.roundNum(this._sliderStEd.values[this._secondThumbId + 1])) + _loc3_,_loc2_);
            }
            _loc6_ = this._trHeight;
            _loc7_ = 5;
            _loc8_ = 0;
            this._sliderStEdBg.graphics.clear();
            this._sliderStEdGx.graphics.clear();
            this._sliderStEdGx.graphics.lineStyle(0,10066329,0);
            this._sliderStEdGx.graphics.beginFill(16226585);
            if(this._zMode)
            {
               this._sliderStEdGx.graphics.moveTo(_loc4_.x,this._sliderStEd.y + _loc6_);
               this._sliderStEdGx.graphics.lineTo(_loc9_.x,this._sliderStEd.y);
               this._sliderStEdGx.graphics.lineTo(_loc9_.x,this._sliderStEd.y + _loc6_);
               this._sliderStEdGx.graphics.lineTo(_loc4_.x,this._sliderStEd.y + _loc6_);
               this._sliderStEdGx.graphics.drawRect(_loc9_.x,this._sliderStEd.y,_loc5_.x - _loc9_.x,_loc6_);
               this._sliderStEdGx.graphics.moveTo(_loc5_.x,this._sliderStEd.y);
               this._sliderStEdGx.graphics.lineTo(_loc10_.x,this._sliderStEd.y + _loc6_);
               this._sliderStEdGx.graphics.lineTo(_loc5_.x,this._sliderStEd.y + _loc6_);
               this._sliderStEdGx.graphics.lineTo(_loc5_.x,this._sliderStEd.y);
            }
            else
            {
               this._sliderStEdGx.graphics.drawRect(_loc4_.x,this._sliderStEd.y,_loc5_.x - _loc4_.x,_loc6_);
            }
            this._sliderStEdGx.graphics.endFill();
            this._sliderStEdBg.graphics.lineStyle(0,10066329);
            UtilDraw.drawDashRect(this._sliderStEdBg,this._sliderStEd.x + _loc7_,this._sliderStEd.y + _loc8_,this._sliderStEd.width - _loc7_ * 2,_loc6_);
            UtilDraw.dashTo(this._sliderStEdBg,new Point(_loc4_.x,_loc4_.y + _loc6_ + this._sliderStEd.y),new Point(_loc4_.x,_loc4_.y + _loc6_));
            UtilDraw.dashTo(this._sliderStEdBg,new Point(_loc5_.x,_loc5_.y + _loc6_ + this._sliderStEd.y),new Point(_loc5_.x,_loc5_.y + _loc6_));
            if(this._zMode)
            {
               UtilDraw.dashTo(this._sliderStEdBg,new Point(_loc9_.x,_loc9_.y + _loc6_ + this._sliderStEd.y),new Point(_loc9_.x,_loc9_.y + _loc6_));
               UtilDraw.dashTo(this._sliderStEdBg,new Point(_loc10_.x,_loc10_.y + _loc6_ + this._sliderStEd.y),new Point(_loc10_.x,_loc10_.y + _loc6_));
            }
            this._sliderStEdBg.graphics.endFill();
         }
      }
      
      private function updateSliderSZ() : void
      {
      }
      
      private function updateSliderEZ() : void
      {
      }
      
      private function onSlidingZoom(param1:SliderEvent = null) : void
      {
      }
      
      private function initSlider(param1:FlexEvent) : void
      {
         if(this._mode == this.LEN_MODE)
         {
            (param1.currentTarget as HSlider).getThumbAt(0).buttonMode = true;
            if(param1.currentTarget == this._sliderStEd2 || param1.currentTarget == this._sliderStEd4)
            {
               (param1.currentTarget as HSlider).getThumbAt(1).buttonMode = true;
            }
            if(param1.currentTarget == this._sliderStEd4)
            {
               (param1.currentTarget as HSlider).getThumbAt(2).buttonMode = true;
               (param1.currentTarget as HSlider).getThumbAt(3).buttonMode = true;
            }
            if(param1.currentTarget == this._sliderStEd4 && (param1.currentTarget as HSlider).thumbCount > 2)
            {
               this.flipVertical((param1.currentTarget as HSlider).getThumbAt(1));
               this.flipVertical((param1.currentTarget as HSlider).getThumbAt(2));
               (param1.currentTarget as HSlider).getThumbAt(1).y = (param1.currentTarget as HSlider).getThumbAt(1).y - 12;
               (param1.currentTarget as HSlider).getThumbAt(2).y = (param1.currentTarget as HSlider).getThumbAt(2).y - 12;
            }
            else
            {
               this.flipVertical((param1.currentTarget as HSlider).getThumbAt(0));
               this.flipVertical((param1.currentTarget as HSlider).getThumbAt(1));
               (param1.currentTarget as HSlider).getThumbAt(0).y = (param1.currentTarget as HSlider).getThumbAt(0).y - 12;
               (param1.currentTarget as HSlider).getThumbAt(1).y = (param1.currentTarget as HSlider).getThumbAt(1).y - 12;
            }
         }
      }
      
      public function flipVertical(param1:DisplayObject) : void
      {
         var _loc2_:Matrix = param1.transform.matrix;
         _loc2_.d = -1;
         _loc2_.ty = param1.height + param1.y;
         param1.transform.matrix = _loc2_;
      }
      
      private function drawSceneCanvas(param1:FlexEvent) : void
      {
         var _loc2_:UIComponent = null;
         var _loc3_:BitmapData = null;
         var _loc4_:Number = NaN;
         if(this._mode == this.LEN_MODE)
         {
            this._sceneCanvas.graphics.clear();
            this._sceneCanvas.graphics.lineStyle(0,0);
            this._sceneCanvas.graphics.beginFill(15132390);
            this._sceneCanvas.graphics.drawRect(5,0,this._sliderStEd.width - 10,this._trHeight * 3);
            this._sceneCanvas.graphics.endFill();
            _loc2_ = ((Console.getConsole().timeline.scene_vb.getChildAt(0) as SceneContainer).getItemAt(Console.getConsole().currentSceneIndex) as SceneElement).scene_img;
            _loc3_ = this.getBitmapData(_loc2_);
            this.scene_img.addChild(new Bitmap(_loc3_));
            _loc4_ = (this._sceneCanvas.height - 2) / _loc3_.height;
            this.scene_img.scaleX = _loc4_;
            this.scene_img.scaleY = _loc4_;
            this.scene_lbl.text = (Console.getConsole().currentSceneIndex + 1).toString();
            this.scene_lbl.setStyle("color","0x000000");
            this.scene_lbl.filters = [new GlowFilter(16750899,1,3,3,5,1,false,false)];
            this.scene_lbl.setStyle("fontSize",54);
            this._sliderBg.graphics.clear();
            this._sliderBg.graphics.lineStyle(0,0,0);
            this._sliderBg.graphics.beginFill(16777215);
            this._sliderBg.graphics.drawRect(5,0,this._sliderStEd.width - 10,this._trHeight * 3);
            this._sliderBg.graphics.endFill();
            this._sliderStEdFg.graphics.clear();
            this._sliderStEdFg.graphics.beginFill(16777215,1);
            this._sliderStEdFg.graphics.drawRect(6,this._sliderStEd.y + this._sliderStEd.height - 4,this._sliderStEd.width - 11,4);
            this._sliderStEdFg.graphics.endFill();
            this._sliderBg.graphics.lineStyle(0,0,0);
            this._sliderBg.graphics.beginFill(16777215);
            this._sliderBg.graphics.drawRect(this._sliderStEd.x + 5,this._sliderStEd.y,this._sliderStEd.width - 10,this._trHeight);
            this._sliderBg.graphics.endFill();
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
      
      public function ___AssetInfoWindow_TitleWindow1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___txtTitle_change(param1:Event) : void
      {
         this.onTitleChange();
      }
      
      private function _AssetInfoWindow_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = AssetInfoWindowInnerClass0;
         _loc1_.properties = {"outerDocument":this};
         return _loc1_;
      }
      
      public function ___sceneCanvas_creationComplete(param1:FlexEvent) : void
      {
         this.drawSceneCanvas(param1);
      }
      
      public function ___sliderStEd2_thumbDrag(param1:SliderEvent) : void
      {
         this.onSliding(param1);
      }
      
      public function ___sliderStEd2_creationComplete(param1:FlexEvent) : void
      {
         this.updateZoomDurGx(param1);
         this.updateTags();
         this.initSlider(param1);
      }
      
      public function ___sliderStEd4_thumbDrag(param1:SliderEvent) : void
      {
         this.onSliding(param1);
      }
      
      public function ___sliderStEd4_creationComplete(param1:FlexEvent) : void
      {
         this.updateZoomDurGx(param1);
         this.updateTags();
         this.initSlider(param1);
      }
      
      public function ___btnUpdate_click(param1:MouseEvent) : void
      {
         this.updateAsset(param1);
      }
      
      public function ___btnCancel_click(param1:MouseEvent) : void
      {
         this.closeWindow(param1);
      }
      
      private function _AssetInfoWindow_bindingsSetup() : Array
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
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_public");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_radioPublic.label");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_private");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_radioPrivate.label");
         result[6] = new Binding(this,function():Object
         {
            return _actionList;
         },null,"_actionTray.dataProvider");
         result[7] = new Binding(this,function():Number
         {
            return _trHeight * 3;
         },null,"_sceneCanvas.height");
         result[8] = new Binding(this,function():Number
         {
            return _trHeight * 3;
         },null,"_sliderBg.y");
         result[9] = new Binding(this,function():Number
         {
            return _trHeight * 3;
         },null,"_sliderBg.height");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_update");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnUpdate.label");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_cancel");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCancel.label");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","assetinfo_warning");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_txtWarning.text");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _actionTray() : TileList
      {
         return this._1354780629_actionTray;
      }
      
      public function set _actionTray(param1:TileList) : void
      {
         var _loc2_:Object = this._1354780629_actionTray;
         if(_loc2_ !== param1)
         {
            this._1354780629_actionTray = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_actionTray",_loc2_,param1));
            }
         }
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
      public function get _canEditLengths() : Canvas
      {
         return this._915136786_canEditLengths;
      }
      
      public function set _canEditLengths(param1:Canvas) : void
      {
         var _loc2_:Object = this._915136786_canEditLengths;
         if(_loc2_ !== param1)
         {
            this._915136786_canEditLengths = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canEditLengths",_loc2_,param1));
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
      public function get _lblEdTime() : Label
      {
         return this._992259101_lblEdTime;
      }
      
      public function set _lblEdTime(param1:Label) : void
      {
         var _loc2_:Object = this._992259101_lblEdTime;
         if(_loc2_ !== param1)
         {
            this._992259101_lblEdTime = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblEdTime",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblEdZoom() : Label
      {
         return this._992074519_lblEdZoom;
      }
      
      public function set _lblEdZoom(param1:Label) : void
      {
         var _loc2_:Object = this._992074519_lblEdZoom;
         if(_loc2_ !== param1)
         {
            this._992074519_lblEdZoom = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblEdZoom",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblStTime() : Label
      {
         return this._576674651_lblStTime;
      }
      
      public function set _lblStTime(param1:Label) : void
      {
         var _loc2_:Object = this._576674651_lblStTime;
         if(_loc2_ !== param1)
         {
            this._576674651_lblStTime = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblStTime",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _lblStZoom() : Label
      {
         return this._576490069_lblStZoom;
      }
      
      public function set _lblStZoom(param1:Label) : void
      {
         var _loc2_:Object = this._576490069_lblStZoom;
         if(_loc2_ !== param1)
         {
            this._576490069_lblStZoom = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblStZoom",_loc2_,param1));
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
      public function get _lblTitle2() : Label
      {
         return this._557248335_lblTitle2;
      }
      
      public function set _lblTitle2(param1:Label) : void
      {
         var _loc2_:Object = this._557248335_lblTitle2;
         if(_loc2_ !== param1)
         {
            this._557248335_lblTitle2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lblTitle2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPrivate() : RadioButton
      {
         return this._230640921_radioPrivate;
      }
      
      public function set _radioPrivate(param1:RadioButton) : void
      {
         var _loc2_:Object = this._230640921_radioPrivate;
         if(_loc2_ !== param1)
         {
            this._230640921_radioPrivate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPrivate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _radioPublic() : RadioButton
      {
         return this._1113266043_radioPublic;
      }
      
      public function set _radioPublic(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1113266043_radioPublic;
         if(_loc2_ !== param1)
         {
            this._1113266043_radioPublic = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_radioPublic",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sceneCanvas() : Canvas
      {
         return this._1366999227_sceneCanvas;
      }
      
      public function set _sceneCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1366999227_sceneCanvas;
         if(_loc2_ !== param1)
         {
            this._1366999227_sceneCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sceneCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderBg() : Canvas
      {
         return this._1182073243_sliderBg;
      }
      
      public function set _sliderBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._1182073243_sliderBg;
         if(_loc2_ !== param1)
         {
            this._1182073243_sliderBg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderBg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderStEd2() : HSlider
      {
         return this._690965710_sliderStEd2;
      }
      
      public function set _sliderStEd2(param1:HSlider) : void
      {
         var _loc2_:Object = this._690965710_sliderStEd2;
         if(_loc2_ !== param1)
         {
            this._690965710_sliderStEd2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderStEd2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderStEd4() : HSlider
      {
         return this._690965708_sliderStEd4;
      }
      
      public function set _sliderStEd4(param1:HSlider) : void
      {
         var _loc2_:Object = this._690965708_sliderStEd4;
         if(_loc2_ !== param1)
         {
            this._690965708_sliderStEd4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderStEd4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderStEdBg() : Canvas
      {
         return this._54900069_sliderStEdBg;
      }
      
      public function set _sliderStEdBg(param1:Canvas) : void
      {
         var _loc2_:Object = this._54900069_sliderStEdBg;
         if(_loc2_ !== param1)
         {
            this._54900069_sliderStEdBg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderStEdBg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderStEdFg() : Canvas
      {
         return this._54900193_sliderStEdFg;
      }
      
      public function set _sliderStEdFg(param1:Canvas) : void
      {
         var _loc2_:Object = this._54900193_sliderStEdFg;
         if(_loc2_ !== param1)
         {
            this._54900193_sliderStEdFg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderStEdFg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sliderStEdGx() : Canvas
      {
         return this._54900241_sliderStEdGx;
      }
      
      public function set _sliderStEdGx(param1:Canvas) : void
      {
         var _loc2_:Object = this._54900241_sliderStEdGx;
         if(_loc2_ !== param1)
         {
            this._54900241_sliderStEdGx = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sliderStEdGx",_loc2_,param1));
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
      public function get scene_img() : Image
      {
         return this._1729673616scene_img;
      }
      
      public function set scene_img(param1:Image) : void
      {
         var _loc2_:Object = this._1729673616scene_img;
         if(_loc2_ !== param1)
         {
            this._1729673616scene_img = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scene_img",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scene_lbl() : Label
      {
         return this._1729676163scene_lbl;
      }
      
      public function set scene_lbl(param1:Label) : void
      {
         var _loc2_:Object = this._1729676163scene_lbl;
         if(_loc2_ !== param1)
         {
            this._1729676163scene_lbl = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scene_lbl",_loc2_,param1));
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
      private function get _actionList() : Array
      {
         return this._1355027053_actionList;
      }
      
      private function set _actionList(param1:Array) : void
      {
         var _loc2_:Object = this._1355027053_actionList;
         if(_loc2_ !== param1)
         {
            this._1355027053_actionList = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_actionList",_loc2_,param1));
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
