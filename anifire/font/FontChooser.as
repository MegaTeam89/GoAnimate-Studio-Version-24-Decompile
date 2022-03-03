package anifire.font
{
   import anifire.bubble.BlankBubble;
   import anifire.bubble.Bubble;
   import anifire.components.containers.HyperLinkWindow;
   import anifire.control.ControlEvent;
   import anifire.core.BubbleAsset;
   import anifire.core.BubbleThumb;
   import anifire.core.Console;
   import anifire.events.BubbleAssetEvent;
   import anifire.util.FontManager;
   import anifire.util.UtilDict;
   import anifire.util.UtilLicense;
   import anifire.util.UtilPopUp;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.utils.Proxy;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ColorPicker;
   import mx.controls.ComboBox;
   import mx.controls.HRule;
   import mx.controls.Image;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.ToggleButtonBar;
   import mx.controls.colorPickerClasses.WebSafePalette;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ColorPickerEvent;
   import mx.events.DropdownEvent;
   import mx.events.FlexEvent;
   import mx.events.ItemClickEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.PopUpManager;
   
   use namespace mx_internal;
   
   public class FontChooser extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _FontChooser_HRule3:HRule;
      
      public var _FontChooser_Spacer1:Spacer;
      
      private var _1755755767_bgPalette:GoPalette;
      
      private var _721006521_embedcb:CheckBox;
      
      private var _351132013_fontPalette:GoPalette;
      
      private var _671599503bgPaletteSection:HBox;
      
      private var _103471630bgcolor_cp:ColorPicker;
      
      private var _1912610210bold_btn:Button;
      
      private var _2080489993btnAlign:ToggleButtonBar;
      
      private var _1153419122busbgcolor_cp:ColorPicker;
      
      private var _1413366383cbFontSize:ComboBox;
      
      private var _628825399color_cp:ColorPicker;
      
      private var _1657931959fontSizeArray:ArrayCollection;
      
      private var _365952328font_cmb:FontFamilyComboBox;
      
      private var _592831722innerShadow:DropShadowFilter;
      
      private var _1412378710transparentBtn:Canvas;
      
      private var _860310292warningLanguage:Text;
      
      private var _1861368006warningRotation:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private const ALIGN_LIST:Array = [{"data":"left"},{"data":"center"},{"data":"right"}];
      
      private var _asset:Object;
      
      private var _90883374_font:String = "Entrails BB";
      
      private var _1480355228_color:Number = 0;
      
      private var _91265248_size:Number = 12;
      
      private var _1482294778_align:String = "center";
      
      private var _90764132_bold:Boolean = false;
      
      private var _1529689935_italic:Boolean = false;
      
      private var _1478577702_embed:Boolean = true;
      
      private var _1330229675_bubble:Bubble;
      
      private var _2946224_url:String = "";
      
      private var _2141602593_bgColor:Number = 16777215;
      
      private var _575958673_autoTextResize:Boolean = true;
      
      private var _click:Boolean = false;
      
      private var _fontMgr:FontManager;
      
      private var _bubbleAsset:BubbleAsset;
      
      private var _embed_mxml_image_icon_bg_swf_684882917:Class;
      
      private var _embed_mxml_image_icon_fontcolor_swf_1474137115:Class;
      
      private var _embed_mxml_image_ico_transparent_png_1821455333:Class;
      
      private var _embed_mxml_image_icon_fontsize_swf_1938158565:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function FontChooser()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___FontChooser_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 10;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"fontChooser",
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":FontFamilyComboBox,
                           "id":"font_cmb",
                           "events":{
                              "change":"__font_cmb_change",
                              "open":"__font_cmb_open",
                              "close":"__font_cmb_close"
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "height":30,
                                 "styleName":"cbSidePanel",
                                 "focusEnabled":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"warningRotation",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "visible":false,
                                 "includeInLayout":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"warningLanguage",
                           "stylesFactory":function():void
                           {
                              this.fontSize = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "visible":false,
                                 "includeInLayout":false
                              };
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
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_image_icon_fontsize_swf_1938158565};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"cbFontSize",
                                    "events":{"change":"__cbFontSize_change"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "buttonMode":true,
                                          "width":120,
                                          "rowCount":9,
                                          "dataProvider":_FontChooser_ArrayCollection1_i()
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"bold_btn",
                                    "events":{"click":"__bold_btn_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "toggle":true,
                                          "styleName":"btnBold",
                                          "focusEnabled":false,
                                          "buttonMode":true
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HRule,
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":ToggleButtonBar,
                                 "id":"btnAlign",
                                 "events":{"itemClick":"__btnAlign_itemClick"},
                                 "stylesFactory":function():void
                                 {
                                    this.horizontalGap = 10;
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"btnAlign",
                                       "selectedIndex":1,
                                       "buttonMode":true
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":HRule,
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                              this.horizontalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_image_icon_fontcolor_swf_1474137115};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":GoPalette,
                                    "id":"_fontPalette",
                                    "events":{"change":"___fontPalette_change"}
                                 }),new UIComponentDescriptor({
                                    "type":ColorPicker,
                                    "id":"color_cp",
                                    "events":{
                                       "change":"__color_cp_change",
                                       "open":"__color_cp_open",
                                       "close":"__color_cp_close"
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "focusEnabled":false,
                                          "buttonMode":true
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HRule,
                           "id":"_FontChooser_HRule3",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"bgPaletteSection",
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                              this.horizontalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml_image_icon_bg_swf_684882917};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"transparentBtn",
                                    "events":{"click":"__transparentBtn_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundColor = 16777215;
                                       this.cornerRadius = 2;
                                       this.borderColor = 16777215;
                                       this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "buttonMode":true,
                                          "width":18,
                                          "height":18,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Image,
                                             "propertiesFactory":function():Object
                                             {
                                                return {"source":_embed_mxml_image_ico_transparent_png_1821455333};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "id":"_FontChooser_Spacer1",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":4};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":GoPalette,
                                    "id":"_bgPalette",
                                    "events":{"change":"___bgPalette_change"}
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":ColorPicker,
                                          "id":"bgcolor_cp",
                                          "events":{
                                             "change":"__bgcolor_cp_change",
                                             "open":"__bgcolor_cp_open",
                                             "close":"__bgcolor_cp_close"
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "focusEnabled":false,
                                                "buttonMode":true
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":ColorPicker,
                                          "id":"busbgcolor_cp",
                                          "events":{
                                             "change":"__busbgcolor_cp_change",
                                             "open":"__busbgcolor_cp_open",
                                             "close":"__busbgcolor_cp_close"
                                          },
                                          "stylesFactory":function():void
                                          {
                                             this.swatchPanelStyleName = "goSwatch";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "focusEnabled":false,
                                                "buttonMode":true
                                             };
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
                  "type":CheckBox,
                  "id":"_embedcb",
                  "events":{"click":"___embedcb_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"EB",
                        "selected":true,
                        "visible":false
                     };
                  }
               })]};
            }
         });
         this._embed_mxml_image_icon_bg_swf_684882917 = FontChooser__embed_mxml_image_icon_bg_swf_684882917;
         this._embed_mxml_image_icon_fontcolor_swf_1474137115 = FontChooser__embed_mxml_image_icon_fontcolor_swf_1474137115;
         this._embed_mxml_image_ico_transparent_png_1821455333 = FontChooser__embed_mxml_image_ico_transparent_png_1821455333;
         this._embed_mxml_image_icon_fontsize_swf_1938158565 = FontChooser__embed_mxml_image_icon_fontsize_swf_1938158565;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._FontChooser_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_font_FontChooserWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return FontChooser[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.focusEnabled = false;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this._FontChooser_DropShadowFilter1_i();
         this.addEventListener("creationComplete",this.___FontChooser_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         FontChooser._watcherSetupUtil = param1;
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
      
      public function getChooser(param1:Object, param2:Object = null) : FontChooser
      {
         var _loc3_:FontChooser = new FontChooser();
         _loc3_.asset = param1;
         _loc3_.initParameters(param2);
         return _loc3_;
      }
      
      private function onBubbleTextSizeChange(param1:Event) : void
      {
         if(this._bubbleAsset.autoTextResize && this._bubbleAsset.scaleX == 1)
         {
            this.fontSizeArray[0].label = UtilDict.toDisplay("go","auto") + " (" + String(this._bubbleAsset.textSize) + "px)";
            this.fontSizeArray.refresh();
            this.cbFontSize.selectedIndex = 0;
         }
      }
      
      public function set target(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:WebSafePalette = null;
         if(param1 is BubbleAsset)
         {
            if(this._bubbleAsset)
            {
               this._bubbleAsset.removeEventListener(BubbleAssetEvent.TEXT_SIZE_CHANGE,this.onBubbleTextSizeChange);
            }
            this._bubbleAsset = BubbleAsset(param1);
            if(this._bubbleAsset)
            {
               this._bubbleAsset.addEventListener(BubbleAssetEvent.TEXT_SIZE_CHANGE,this.onBubbleTextSizeChange);
            }
            this._asset = this._bubbleAsset.bubble;
            this.initParameters(this._bubbleAsset.bubbleObject);
            this.initApp();
            if(BubbleThumb(BubbleAsset(param1).thumb).colorStyle == 2)
            {
               _loc2_ = ["0xFFFFFF","0xCCCCCC","0x999999","0x666666","0x333333","0xAEAEAE","0x808080","0x484848","0x262626","0x1A1A1A","0x111111"];
               _loc3_ = ["0xB0B8A5","0xC8D54D","0xF1F4CA","0xE8DE84","0xE1B040","0x98772C","0xB6DBAC","0x62714A","0x565521","0xDBF0E2","0x3CDDBC","0x4BAFAD","0x178A67","0x327871","0x36545A","0xF8C2C2","0xC07F85","0xC45582","0x93374A","0x9C4530","0xB54242","0x594040","0x99609F","0x4F507D","0x353843","0x767975","0x5C6761","0xFFFFFF","0xE9D9B8","0xD2D5CC","0xB1DED9","0xC6C9DB","0xC96969"];
               this.color_cp.dataProvider = _loc2_;
               this.busbgcolor_cp.dataProvider = _loc3_;
               this.busbgcolor_cp.visible = true;
               this.bgcolor_cp.visible = false;
            }
            else
            {
               _loc4_ = new WebSafePalette();
               this.color_cp.dataProvider = _loc4_.getList();
               this.bgcolor_cp.dataProvider = _loc4_.getList();
               this.busbgcolor_cp.visible = false;
               this.bgcolor_cp.visible = true;
            }
            this.transparentBtn.visible = this.transparentBtn.includeInLayout = this._asset is BlankBubble;
         }
      }
      
      public function get click() : Boolean
      {
         return this._click;
      }
      
      public function get asset() : Object
      {
         return this._asset;
      }
      
      public function set asset(param1:Object) : void
      {
         this._asset = param1;
      }
      
      public function set url(param1:String) : void
      {
         this._url = param1;
         if(this._bubble != null)
         {
            this._bubble.textURL = param1;
         }
      }
      
      public function initParameters(param1:Object = null) : void
      {
         if(param1 != null)
         {
            if(param1.font != null)
            {
               this._font = param1.font;
            }
            if(param1.size != null)
            {
               this._size = param1.size;
            }
            if(param1.color != null)
            {
               this._color = param1.color;
            }
            if(param1.align != null)
            {
               this._align = param1.align;
            }
            if(param1.bold != null)
            {
               this._bold = param1.bold;
            }
            if(param1.italic != null)
            {
               this._italic = param1.italic;
            }
            if(param1.embed != null)
            {
               this._embed = param1.embed;
            }
            if(param1.fillRgb != null)
            {
               this._bgColor = param1.fillRgb;
            }
            if(param1.bubble != null)
            {
               this._bubble = param1.bubble;
            }
            if(param1.url != null)
            {
               this._url = param1.url;
            }
            if(param1.autoTextResize != null)
            {
               this._autoTextResize = param1.autoTextResize;
            }
         }
      }
      
      private function initApp() : void
      {
         this.setupFontList();
         this.setupFontSizeList();
         this.setupAlignList();
         this.setupBold();
         this.setupItalic();
         this.setupEmbed();
         this.setupColor();
         this.setupBgcolor();
         this.url = this._url;
      }
      
      private function setupFontList() : void
      {
         this.font_cmb.selectFont(this._font);
         this.warningRotation.visible = this.warningRotation.includeInLayout = !this._bubbleAsset.textEmbed;
         this.warningLanguage.visible = this.warningLanguage.includeInLayout = this._bubbleAsset.textEmbed;
      }
      
      private function setupFontSizeList() : void
      {
         var _loc1_:uint = 0;
         if(this._autoTextResize)
         {
            this.cbFontSize.selectedIndex = 0;
            this.fontSizeArray[0].label = UtilDict.toDisplay("go","auto") + " (" + String(this._size) + "px)";
         }
         else
         {
            this.fontSizeArray[0].label = UtilDict.toDisplay("go","auto");
            _loc1_ = 0;
            while(_loc1_ < this.fontSizeArray.length)
            {
               if(this.fontSizeArray[_loc1_].data == String(this._size))
               {
                  this.cbFontSize.selectedIndex = _loc1_;
                  break;
               }
               _loc1_++;
            }
         }
         if(this._bubbleAsset.scaleX != 1)
         {
            this.cbFontSize.selectedIndex = -1;
         }
      }
      
      private function setupAlignList() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.ALIGN_LIST.length)
         {
            if(this.ALIGN_LIST[_loc1_].data == this._align)
            {
               this.btnAlign.selectedIndex = _loc1_;
               break;
            }
            _loc1_++;
         }
      }
      
      private function setupColor() : void
      {
         this.color_cp.selectedColor = this._color;
      }
      
      private function setupBgcolor() : void
      {
         this.bgcolor_cp.selectedColor = this._bgColor;
         this.busbgcolor_cp.selectedColor = this._bgColor;
      }
      
      private function setupBold() : void
      {
         this.bold_btn.selected = this._bold;
      }
      
      private function setupItalic() : void
      {
      }
      
      private function setupEmbed() : void
      {
         this._embedcb.selected = this._embed;
      }
      
      private function onFontChange() : void
      {
         var _loc1_:String = this.font_cmb.selectedItem.data as String;
         this._fontMgr = FontManager.getFontManager();
         if(this._fontMgr.isFontLoaded(_loc1_) || this.font_cmb.selectedItem.source == "system")
         {
            this._asset.textFont = _loc1_;
            this._bubbleAsset.textFont = _loc1_;
            switch(this.font_cmb.selectedItem.source)
            {
               case "ggoogle":
                  this._bubbleAsset.textEmbed = true;
                  this._asset.textEmbed = true;
                  break;
               case "go":
                  this._bubbleAsset.textEmbed = true;
                  this._asset.textEmbed = true;
                  break;
               case "system":
                  this._bubbleAsset.textEmbed = false;
                  this._asset.textEmbed = false;
            }
            this.checkFontSupport();
         }
         else
         {
            this._fontMgr.loadFont(_loc1_,this.onFontLoaded);
         }
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function checkFontSupport() : void
      {
         if(UtilLicense.isBubbleI18NPermitted() && Bubble(this._asset).textEmbed && !Bubble(this._asset).checkCharacterSupport())
         {
            Bubble(this._asset).textFont = FontFamilyComboBox.listFonts()[0].data;
            Bubble(this._asset).textEmbed = false;
            this._bubbleAsset.textFont = FontFamilyComboBox.listFonts()[0].data;
            this._bubbleAsset.textEmbed = false;
            UtilPopUp.alert("Oops, this font only supports English text.");
         }
         this.warningRotation.visible = this.warningRotation.includeInLayout = !this._bubbleAsset.textEmbed;
         this.warningLanguage.visible = this.warningLanguage.includeInLayout = this._bubbleAsset.textEmbed;
      }
      
      private function onFontLoaded(param1:Event = null, param2:String = "") : void
      {
         if(param2 != "")
         {
            this._bubbleAsset.textFont = param2;
            this._asset.textFont = param2;
            this._bubbleAsset.textEmbed = true;
            this._asset.textEmbed = true;
            this.checkFontSupport();
         }
      }
      
      private function onFillRgbChange(param1:Event) : void
      {
         this._bubbleAsset.bgAlpha = 1;
         this._bubbleAsset.bgColor = param1.target.selectedColor;
         this._asset.fillRgb = param1.target.selectedColor;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function onRgbChange() : void
      {
         this._bubbleAsset.textColor = this.color_cp.selectedColor;
         this._asset.textRgb = this.color_cp.selectedColor;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function onAlignBtnClick(param1:ItemClickEvent) : void
      {
         var _loc2_:String = null;
         if(param1.index >= 0)
         {
            _loc2_ = this.ALIGN_LIST[param1.index].data;
            this._asset.textAlign = _loc2_;
            this._bubbleAsset.textAlign = _loc2_;
            dispatchEvent(new ControlEvent(Event.CHANGE));
         }
      }
      
      private function onBoldChange() : void
      {
         this._asset.textBold = this.bold_btn.selected;
         this._bubbleAsset.textBold = this.bold_btn.selected;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function onItalicChange() : void
      {
      }
      
      private function onOpenHandler(param1:DropdownEvent) : void
      {
      }
      
      private function onCloseHandler(param1:DropdownEvent) : void
      {
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         this.stopDrag();
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
      }
      
      private function onCallLaterHandler() : void
      {
         dispatchEvent(new ControlEvent(ControlEvent.CALL_LATER));
      }
      
      private function onConvertHandler() : void
      {
         this.visible = false;
         Console.getConsole().showImporterWindow("",this._bubble.text);
      }
      
      private function onEmbedChange() : void
      {
         this._asset.textEmbed = this._embedcb.selected;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function onBubbleLink(param1:Event) : void
      {
         var _loc2_:HyperLinkWindow = HyperLinkWindow(PopUpManager.createPopUp(Console.getConsole().mainStage as DisplayObject,HyperLinkWindow,true));
         PopUpManager.centerPopUp(_loc2_);
         _loc2_.url = this._url;
         _loc2_.fontchooser = this;
      }
      
      protected function onFontSizeChange(param1:ListEvent) : void
      {
         var _loc2_:Number = Number(this.cbFontSize.selectedItem.data);
         if(_loc2_ == -1)
         {
            this._bubbleAsset.autoTextResize = true;
            this.fontSizeArray[0].label = UtilDict.toDisplay("go","auto") + " (" + String(this._bubbleAsset.textSize) + "px)";
            this.fontSizeArray.refresh();
         }
         else
         {
            this._bubbleAsset.autoTextResize = false;
            this._bubbleAsset.textSize = _loc2_;
            this.fontSizeArray[0].label = UtilDict.toDisplay("go","auto");
         }
      }
      
      private function onFontPaletteColorSelected() : void
      {
         this._bubbleAsset.textColor = this._fontPalette.selectedColor;
         this._asset.textRgb = this._fontPalette.selectedColor;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      private function onBgPaletteColorSelected() : void
      {
         this._bubbleAsset.bgAlpha = 1;
         this._bubbleAsset.bgColor = this._bgPalette.selectedColor;
         this._asset.fillRgb = this._bgPalette.selectedColor;
         dispatchEvent(new ControlEvent(Event.CHANGE));
      }
      
      protected function onCreationComplete(param1:FlexEvent) : void
      {
         this._fontPalette.init([15658734,2236962,2904888,3102888,1028531,16573194,16750848,13382451,7613227]);
         this._bgPalette.init([16777215,15000804,13690004,11910088,15586773,16776908,16040385,8763028,11659754]);
      }
      
      protected function onTransparentBtnClick(param1:MouseEvent) : void
      {
         this._bubbleAsset.bgAlpha = 0;
      }
      
      private function _FontChooser_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.inner = true;
         _loc1_.distance = 0.5;
         _loc1_.alpha = 0.5;
         _loc1_.blurX = 1;
         _loc1_.blurY = 1;
         this.innerShadow = _loc1_;
         BindingManager.executeBindings(this,"innerShadow",this.innerShadow);
         return _loc1_;
      }
      
      public function ___FontChooser_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      public function __font_cmb_change(param1:ListEvent) : void
      {
         this.onFontChange();
      }
      
      public function __font_cmb_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function __font_cmb_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      private function _FontChooser_ArrayCollection1_i() : ArrayCollection
      {
         var _loc1_:ArrayCollection = new ArrayCollection();
         _loc1_.source = [{
            "label":"auto",
            "data":-1
         },{
            "label":"10 px",
            "data":10
         },{
            "label":"12 px",
            "data":12
         },{
            "label":"14 px",
            "data":14
         },{
            "label":"18 px",
            "data":18
         },{
            "label":"24 px",
            "data":24
         },{
            "label":"32 px",
            "data":32
         },{
            "label":"48 px",
            "data":48
         },{
            "label":"72 px",
            "data":72
         }];
         _loc1_.initialized(this,"fontSizeArray");
         this.fontSizeArray = _loc1_;
         BindingManager.executeBindings(this,"fontSizeArray",this.fontSizeArray);
         return _loc1_;
      }
      
      public function __cbFontSize_change(param1:ListEvent) : void
      {
         this.onFontSizeChange(param1);
      }
      
      public function __bold_btn_click(param1:MouseEvent) : void
      {
         this.onBoldChange();
      }
      
      public function __btnAlign_itemClick(param1:ItemClickEvent) : void
      {
         this.onAlignBtnClick(param1);
      }
      
      public function ___fontPalette_change(param1:Event) : void
      {
         this.onFontPaletteColorSelected();
      }
      
      public function __color_cp_change(param1:ColorPickerEvent) : void
      {
         this.onRgbChange();
      }
      
      public function __color_cp_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function __color_cp_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      public function __transparentBtn_click(param1:MouseEvent) : void
      {
         this.onTransparentBtnClick(param1);
      }
      
      public function ___bgPalette_change(param1:Event) : void
      {
         this.onBgPaletteColorSelected();
      }
      
      public function __bgcolor_cp_change(param1:ColorPickerEvent) : void
      {
         this.onFillRgbChange(param1);
      }
      
      public function __bgcolor_cp_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function __bgcolor_cp_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      public function __busbgcolor_cp_change(param1:ColorPickerEvent) : void
      {
         this.onFillRgbChange(param1);
      }
      
      public function __busbgcolor_cp_open(param1:DropdownEvent) : void
      {
         this.onOpenHandler(param1);
      }
      
      public function __busbgcolor_cp_close(param1:DropdownEvent) : void
      {
         this.onCloseHandler(param1);
      }
      
      public function ___embedcb_click(param1:MouseEvent) : void
      {
         this.onEmbedChange();
      }
      
      private function _FontChooser_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","* This font does not support rotation, and advanced effects.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"warningRotation.text");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","* This font does not support international language");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"warningLanguage.text");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","auto");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"cbFontSize.prompt");
         result[3] = new Binding(this,function():Boolean
         {
            return _bold;
         },null,"bold_btn.selected");
         result[4] = new Binding(this,function():Object
         {
            return ALIGN_LIST;
         },null,"btnAlign.dataProvider");
         result[5] = new Binding(this,function():uint
         {
            return _color;
         },null,"color_cp.selectedColor");
         result[6] = new Binding(this,function():Boolean
         {
            return bgPaletteSection.includeInLayout;
         },null,"_FontChooser_HRule3.includeInLayout");
         result[7] = new Binding(this,function():Boolean
         {
            return bgPaletteSection.visible;
         },null,"_FontChooser_HRule3.visible");
         result[8] = new Binding(this,function():Array
         {
            var _loc1_:* = [innerShadow];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"transparentBtn.filters");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","transparent");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"transparentBtn.toolTip");
         result[10] = new Binding(this,function():Boolean
         {
            return transparentBtn.visible;
         },null,"_FontChooser_Spacer1.includeInLayout");
         result[11] = new Binding(this,function():Boolean
         {
            return transparentBtn.visible;
         },null,"_FontChooser_Spacer1.visible");
         result[12] = new Binding(this,function():uint
         {
            return _bgColor;
         },null,"bgcolor_cp.selectedColor");
         result[13] = new Binding(this,function():uint
         {
            return _bgColor;
         },null,"busbgcolor_cp.selectedColor");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bgPalette() : GoPalette
      {
         return this._1755755767_bgPalette;
      }
      
      public function set _bgPalette(param1:GoPalette) : void
      {
         var _loc2_:Object = this._1755755767_bgPalette;
         if(_loc2_ !== param1)
         {
            this._1755755767_bgPalette = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bgPalette",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _embedcb() : CheckBox
      {
         return this._721006521_embedcb;
      }
      
      public function set _embedcb(param1:CheckBox) : void
      {
         var _loc2_:Object = this._721006521_embedcb;
         if(_loc2_ !== param1)
         {
            this._721006521_embedcb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_embedcb",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _fontPalette() : GoPalette
      {
         return this._351132013_fontPalette;
      }
      
      public function set _fontPalette(param1:GoPalette) : void
      {
         var _loc2_:Object = this._351132013_fontPalette;
         if(_loc2_ !== param1)
         {
            this._351132013_fontPalette = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_fontPalette",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bgPaletteSection() : HBox
      {
         return this._671599503bgPaletteSection;
      }
      
      public function set bgPaletteSection(param1:HBox) : void
      {
         var _loc2_:Object = this._671599503bgPaletteSection;
         if(_loc2_ !== param1)
         {
            this._671599503bgPaletteSection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgPaletteSection",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bgcolor_cp() : ColorPicker
      {
         return this._103471630bgcolor_cp;
      }
      
      public function set bgcolor_cp(param1:ColorPicker) : void
      {
         var _loc2_:Object = this._103471630bgcolor_cp;
         if(_loc2_ !== param1)
         {
            this._103471630bgcolor_cp = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bgcolor_cp",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bold_btn() : Button
      {
         return this._1912610210bold_btn;
      }
      
      public function set bold_btn(param1:Button) : void
      {
         var _loc2_:Object = this._1912610210bold_btn;
         if(_loc2_ !== param1)
         {
            this._1912610210bold_btn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bold_btn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnAlign() : ToggleButtonBar
      {
         return this._2080489993btnAlign;
      }
      
      public function set btnAlign(param1:ToggleButtonBar) : void
      {
         var _loc2_:Object = this._2080489993btnAlign;
         if(_loc2_ !== param1)
         {
            this._2080489993btnAlign = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnAlign",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get busbgcolor_cp() : ColorPicker
      {
         return this._1153419122busbgcolor_cp;
      }
      
      public function set busbgcolor_cp(param1:ColorPicker) : void
      {
         var _loc2_:Object = this._1153419122busbgcolor_cp;
         if(_loc2_ !== param1)
         {
            this._1153419122busbgcolor_cp = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"busbgcolor_cp",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbFontSize() : ComboBox
      {
         return this._1413366383cbFontSize;
      }
      
      public function set cbFontSize(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1413366383cbFontSize;
         if(_loc2_ !== param1)
         {
            this._1413366383cbFontSize = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbFontSize",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get color_cp() : ColorPicker
      {
         return this._628825399color_cp;
      }
      
      public function set color_cp(param1:ColorPicker) : void
      {
         var _loc2_:Object = this._628825399color_cp;
         if(_loc2_ !== param1)
         {
            this._628825399color_cp = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"color_cp",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fontSizeArray() : ArrayCollection
      {
         return this._1657931959fontSizeArray;
      }
      
      public function set fontSizeArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1657931959fontSizeArray;
         if(_loc2_ !== param1)
         {
            this._1657931959fontSizeArray = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fontSizeArray",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get font_cmb() : FontFamilyComboBox
      {
         return this._365952328font_cmb;
      }
      
      public function set font_cmb(param1:FontFamilyComboBox) : void
      {
         var _loc2_:Object = this._365952328font_cmb;
         if(_loc2_ !== param1)
         {
            this._365952328font_cmb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"font_cmb",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get innerShadow() : DropShadowFilter
      {
         return this._592831722innerShadow;
      }
      
      public function set innerShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._592831722innerShadow;
         if(_loc2_ !== param1)
         {
            this._592831722innerShadow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"innerShadow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get transparentBtn() : Canvas
      {
         return this._1412378710transparentBtn;
      }
      
      public function set transparentBtn(param1:Canvas) : void
      {
         var _loc2_:Object = this._1412378710transparentBtn;
         if(_loc2_ !== param1)
         {
            this._1412378710transparentBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"transparentBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get warningLanguage() : Text
      {
         return this._860310292warningLanguage;
      }
      
      public function set warningLanguage(param1:Text) : void
      {
         var _loc2_:Object = this._860310292warningLanguage;
         if(_loc2_ !== param1)
         {
            this._860310292warningLanguage = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"warningLanguage",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get warningRotation() : Text
      {
         return this._1861368006warningRotation;
      }
      
      public function set warningRotation(param1:Text) : void
      {
         var _loc2_:Object = this._1861368006warningRotation;
         if(_loc2_ !== param1)
         {
            this._1861368006warningRotation = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"warningRotation",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _font() : String
      {
         return this._90883374_font;
      }
      
      private function set _font(param1:String) : void
      {
         var _loc2_:Object = this._90883374_font;
         if(_loc2_ !== param1)
         {
            this._90883374_font = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_font",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _color() : Number
      {
         return this._1480355228_color;
      }
      
      private function set _color(param1:Number) : void
      {
         var _loc2_:Object = this._1480355228_color;
         if(_loc2_ !== param1)
         {
            this._1480355228_color = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_color",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _size() : Number
      {
         return this._91265248_size;
      }
      
      private function set _size(param1:Number) : void
      {
         var _loc2_:Object = this._91265248_size;
         if(_loc2_ !== param1)
         {
            this._91265248_size = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_size",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _align() : String
      {
         return this._1482294778_align;
      }
      
      private function set _align(param1:String) : void
      {
         var _loc2_:Object = this._1482294778_align;
         if(_loc2_ !== param1)
         {
            this._1482294778_align = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_align",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _bold() : Boolean
      {
         return this._90764132_bold;
      }
      
      private function set _bold(param1:Boolean) : void
      {
         var _loc2_:Object = this._90764132_bold;
         if(_loc2_ !== param1)
         {
            this._90764132_bold = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bold",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _italic() : Boolean
      {
         return this._1529689935_italic;
      }
      
      private function set _italic(param1:Boolean) : void
      {
         var _loc2_:Object = this._1529689935_italic;
         if(_loc2_ !== param1)
         {
            this._1529689935_italic = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_italic",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _embed() : Boolean
      {
         return this._1478577702_embed;
      }
      
      private function set _embed(param1:Boolean) : void
      {
         var _loc2_:Object = this._1478577702_embed;
         if(_loc2_ !== param1)
         {
            this._1478577702_embed = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_embed",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _bubble() : Bubble
      {
         return this._1330229675_bubble;
      }
      
      private function set _bubble(param1:Bubble) : void
      {
         var _loc2_:Object = this._1330229675_bubble;
         if(_loc2_ !== param1)
         {
            this._1330229675_bubble = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bubble",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _url() : String
      {
         return this._2946224_url;
      }
      
      private function set _url(param1:String) : void
      {
         var _loc2_:Object = this._2946224_url;
         if(_loc2_ !== param1)
         {
            this._2946224_url = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_url",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _bgColor() : Number
      {
         return this._2141602593_bgColor;
      }
      
      private function set _bgColor(param1:Number) : void
      {
         var _loc2_:Object = this._2141602593_bgColor;
         if(_loc2_ !== param1)
         {
            this._2141602593_bgColor = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bgColor",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _autoTextResize() : Boolean
      {
         return this._575958673_autoTextResize;
      }
      
      private function set _autoTextResize(param1:Boolean) : void
      {
         var _loc2_:Object = this._575958673_autoTextResize;
         if(_loc2_ !== param1)
         {
            this._575958673_autoTextResize = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_autoTextResize",_loc2_,param1));
            }
         }
      }
   }
}
