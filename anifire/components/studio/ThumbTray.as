package anifire.components.studio
{
   import anifire.banner.LoadingImage;
   import anifire.color.SelectedColor;
   import anifire.command.AddSceneTemplateCommand;
   import anifire.command.ICommand;
   import anifire.component.GoAlert;
   import anifire.component.IconTextButton;
   import anifire.components.containers.SoundTileCell;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.components.studio.cn.GameAchievementLock;
   import anifire.components.studio.cn.SchoolSpecialLock;
   import anifire.constant.AnimeConstants;
   import anifire.constant.LicenseConstants;
   import anifire.constant.ServerConstants;
   import anifire.constant.ThemeConstants;
   import anifire.containers.GradientCanvas;
   import anifire.core.BackgroundThumb;
   import anifire.core.BubbleThumb;
   import anifire.core.CharThumb;
   import anifire.core.Console;
   import anifire.core.EffectThumb;
   import anifire.core.PropThumb;
   import anifire.core.SoundThumb;
   import anifire.core.TemplateThumb;
   import anifire.core.Theme;
   import anifire.core.Thumb;
   import anifire.core.VideoPropThumb;
   import anifire.core.sound.SoundPlaybackManager;
   import anifire.event.CoreEvent;
   import anifire.event.LazyHelperEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.events.AssetPurchasedEvent;
   import anifire.events.ThemeChosenEvent;
   import anifire.interfaces.IProductThumb;
   import anifire.managers.*;
   import anifire.popups.CommunityStuffWarning;
   import anifire.products.view.CharProductThumb;
   import anifire.products.view.ProductThumb;
   import anifire.products.view.ProductThumbFactory;
   import anifire.tutorial.*;
   import anifire.util.*;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import flexlib.containers.FlowBox;
   import mx.binding.*;
   import mx.containers.Accordion;
   import mx.containers.Canvas;
   import mx.containers.Form;
   import mx.containers.HBox;
   import mx.containers.Panel;
   import mx.containers.TabNavigator;
   import mx.containers.Tile;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Menu;
   import mx.controls.PopUpButton;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.controls.ToggleButtonBar;
   import mx.core.Container;
   import mx.core.FlexGlobals;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModuleFactory;
   import mx.core.Repeater;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Move;
   import mx.effects.Resize;
   import mx.events.ChildExistenceChangedEvent;
   import mx.events.EffectEvent;
   import mx.events.FlexEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.ItemClickEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ScrollEvent;
   import mx.managers.PopUpManager;
   import mx.states.RemoveChild;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   import mx.utils.StringUtil;
   
   use namespace mx_internal;
   
   public class ThumbTray extends Canvas implements IBindingClient
   {
      
      public static const TRAY_MAX_HEIGHT:Number = 800;
      
      public static const COMMON_THEME:String = "GoAnimateGoodies";
      
      public static const USER_THEME:String = "MyGoodies";
      
      public static const COMMUNITY_THEME:String = "CommunityGoodies";
      
      public static const MOVIE_THEME:String = "MovieGoodies";
      
      public static const STYLE_SOUND_TILE_1:String = "bgSoundCell1";
      
      public static const STYLE_SOUND_TILE_2:String = "bgSoundCell2";
      
      public static const THEME_ID_CUSTOM_WORLD:String = "custom";
      
      public static const DEFAULT_THEME_ID:String = "politic";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _10971153VSThumbTray:ViewStack;
      
      private var _1500074747_ThumbTray_Accordion1:Accordion;
      
      public var _ThumbTray_Button1:Button;
      
      public var _ThumbTray_Button2:Button;
      
      public var _ThumbTray_Button3:Array;
      
      public var _ThumbTray_Canvas23:Canvas;
      
      public var _ThumbTray_Canvas7:Array;
      
      public var _ThumbTray_Form1:Form;
      
      public var _ThumbTray_Label1:Label;
      
      public var _ThumbTray_RemoveChild1:RemoveChild;
      
      public var _ThumbTray_RemoveChild2:RemoveChild;
      
      public var _ThumbTray_RemoveChild3:RemoveChild;
      
      public var _ThumbTray_RemoveChild4:RemoveChild;
      
      public var _ThumbTray_RemoveChild5:RemoveChild;
      
      public var _ThumbTray_RemoveChild6:RemoveChild;
      
      public var _ThumbTray_RemoveChild7:RemoveChild;
      
      public var _ThumbTray_RemoveChild8:RemoveChild;
      
      public var _ThumbTray_SetProperty1:SetProperty;
      
      public var _ThumbTray_SetProperty2:SetProperty;
      
      public var _ThumbTray_Text1:Text;
      
      public var _ThumbTray_Text3:Text;
      
      public var _ThumbTray_VBox1:VBox;
      
      private var _658818924_assetTrayBg:Canvas;
      
      private var _1487788737_ccThemeModel:XML;
      
      private var _1491038559_effectMove:Move;
      
      private var _1764850564_effectResize:Resize;
      
      private var _1600092163_loading:Canvas;
      
      private var _1992358882_themeSelection:ThemeSelection;
      
      private var _1583312434_tipsArrow:Canvas;
      
      private var _1634482541_tipsSceneSet:Canvas;
      
      private var _1550854338_uiBgThemes:Accordion;
      
      private var _1282723535_uiBtnSearch:Button;
      
      private var _1174842373_uiCanvasBgUser:Canvas;
      
      private var _769621044_uiCanvasCharUser:Canvas;
      
      private var _1122273858_uiCanvasCommunity:VBox;
      
      private var _71803449_uiCanvasEffectUser:Canvas;
      
      private var _304564347_uiCanvasMovie:Canvas;
      
      private var _1096140121_uiCanvasPropUser:Canvas;
      
      private var _298324450_uiCanvasTheme:Canvas;
      
      private var _425225002_uiCanvasUser:Canvas;
      
      private var _121879230_uiCanvasVideoPropUser:Canvas;
      
      private var _167520028_uiCharMovieViewStack:ViewStack;
      
      private var _1939118856_uiCharThemeAccordion:Accordion;
      
      private var _2109846365_uiCharThemeViewStack:ViewStack;
      
      private var _1147366545_uiLabelBgUser:Label;
      
      private var _1785122530_uiLabelCharUser:Label;
      
      private var _644083601_uiLabelPropUser:Label;
      
      private var _876679832_uiLabelVideoPropUser:Label;
      
      private var _586953306_uiLblCommunity:Label;
      
      private var _991343744_uiLblResult:Label;
      
      private var _1969718778_uiLblTheme:Label;
      
      private var _1737616366_uiLblUser:Label;
      
      private var _18631945_uiMaskCanvas:Canvas;
      
      private var _1629274085_uiNavigatorCommunity:TabNavigator;
      
      private var _253022932_uiNavigatorMovie:TabNavigator;
      
      private var _939660622_uiNavigatorThemes:TabNavigator;
      
      private var _1809035697_uiNavigatorUser:TabNavigator;
      
      private var _682645850_uiPopBtnSearch:PopUpButton;
      
      private var _1688070042_uiPropMovie:Accordion;
      
      private var _984000672_uiPropThemes:Accordion;
      
      private var _175298967_uiSceneMovie:Accordion;
      
      private var _767428474_uiSoundThemes:Accordion;
      
      private var _725974475_uiThemeButtonBar:ToggleButtonBar;
      
      private var _391719453_uiTileBgCommunity:Tile;
      
      private var _394530262_uiTileBgMovie:Tile;
      
      private var _847900688_uiTileBgThemes:Tile;
      
      private var _957346193_uiTileBgUser:Tile;
      
      private var _375869079_uiTileBubbleThemes:Tile;
      
      private var _1953398322_uiTileCharCommunity:Tile;
      
      private var _632677895_uiTileCharMovie:Tile;
      
      private var _2055258657_uiTileCharThemes:Tile;
      
      private var _435809310_uiTileCharUser:Tile;
      
      private var _1921952448_uiTileCharYourChar:FlowBox;
      
      private var _2107238039_uiTileEffectCommunity:Tile;
      
      private var _497320738_uiTileEffectMovie:Tile;
      
      private var _1956363228_uiTileEffectThemes:Tile;
      
      private var _1401274275_uiTileEffectUser:Tile;
      
      private var _435498181_uiTilePropCommunity:Tile;
      
      private var _1816505304_uiTilePropHandHeldMovie:Tile;
      
      private var _283652654_uiTilePropHandHeldThemes:Tile;
      
      private var _1680222732_uiTilePropHeadMovie:Tile;
      
      private var _740734062_uiTilePropHeadThemes:Tile;
      
      private var _1847179392_uiTilePropMaskMovie:Tile;
      
      private var _1621423226_uiTilePropMaskThemes:Tile;
      
      private var _940353372_uiTilePropOtherMovie:Tile;
      
      private var _1107253462_uiTilePropOtherThemes:Tile;
      
      private var _1429951855_uiTilePropUser:Tile;
      
      private var _1191025918_uiTileSoundEffectsThemes:Tile;
      
      private var _905402271_uiTileSoundMusicThemes:Tile;
      
      private var _949674326_uiTileSoundTribeThemes:Tile;
      
      private var _1186357291_uiTileTemplateMovie:Tile;
      
      private var _2071066565_uiTileTemplateThemes:Tile;
      
      private var _2044905576_uiTileVideoPropUser:Tile;
      
      private var _45803963_uiTxtSearch:TextInput;
      
      private var _87478335_userSoundNotUploadableNotice:Canvas;
      
      private var _258023566_userSoundNotUploadableNoticeText:Text;
      
      private var _1693645137_userSoundThemes:Accordion;
      
      private var _596357074_userTileSoundEffectThemes:Tile;
      
      private var _644843432_userTileSoundMusicThemes:Tile;
      
      private var _1950667355_userTileSoundVoiceThemes:Tile;
      
      private var _1698757981_vbTribe:VBox;
      
      private var _1014053963backToThemeBtn:IconTextButton;
      
      private var _694738696btnCreateCc:Canvas;
      
      private var _62063046btnCreateCc2:Canvas;
      
      private var _300853537btnImport:Button;
      
      private var _579312420btnSearch:Button;
      
      private var _3199dc:Canvas;
      
      private var _520893529goPropPanel:VBox;
      
      private var _1700543726pnlShadow:Panel;
      
      private var _157138125productSearchPanel:ProductSearchPanel;
      
      private var _553648836searchPanel:Canvas;
      
      private var _446225527templateCharacterRepeater:Repeater;
      
      private var _17045986themeIcon:ProductThemeIcon;
      
      private var _859632177txtKey:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _themeCbLastSelectedIndex:int = 0;
      
      private var _assetTheme:String = "GoAnimateGoodies";
      
      private var _themeId:String;
      
      private var _soundTileCellArr:Array;
      
      private var _searchSoundTileCellArr:Array;
      
      private var _fullReady:Boolean = false;
      
      private var _userAssetsReady:Boolean = false;
      
      private var _userCharReady:Boolean = false;
      
      private var _userBgReady:Boolean = false;
      
      private var _userPropReady:Boolean = false;
      
      private var _userSoundReady:Boolean = false;
      
      private var _userEffectReady:Boolean = false;
      
      private var _userVideoPropReady:Boolean = false;
      
      private var _userTemplateReady:Boolean = false;
      
      private var _communityAssetsReady:Boolean = false;
      
      private var _communityCharReady:Boolean = false;
      
      private var _communityBgReady:Boolean = false;
      
      private var _communityPropReady:Boolean = false;
      
      private var _communitySoundReady:Boolean = false;
      
      private var _communityEffectReady:Boolean = false;
      
      private var _movieAssetsReady:Boolean = false;
      
      private var _movieCharReady:Boolean = false;
      
      private var _movieBgReady:Boolean = false;
      
      private var _moviePropReady:Boolean = false;
      
      private var _movieSoundReady:Boolean = false;
      
      private var _movieEffectReady:Boolean = false;
      
      private var _userAssetType:String = "prop";
      
      private var _searchType:String = "prop";
      
      private var _uiTileSearch:Tile;
      
      private var _uiMenuSearchType:Menu;
      
      private var _active:Boolean = true;
      
      private var _hidable:Boolean = true;
      
      private var _switchTheme:Boolean = false;
      
      private var mouseOverSoundBtn:Boolean = false;
      
      private var _showTip:Boolean = false;
      
      private var _isCurrentThemeShouldLoadChar:Boolean = false;
      
      private var _shouldShowCharTabOnCcLoaded:Boolean = false;
      
      private var _uiTileCharYourChar_lazyHelper:UtilLazyHelper;
      
      private var _lazyHelpers:Object;
      
      private var _lastLoadedPropThumbIndex:Array;
      
      private var _lastLoadedCommonPropThumbIndex:Array;
      
      private var _lastLoadedBgThumbIndex:Number = 0;
      
      private var _lastLoadedCommonBgThumbIndex:Number = 0;
      
      private var _lastLoadedMovieBgThumbIndex:Number = 0;
      
      private var _canDoPremium:Boolean = false;
      
      private var _unlockedItems:Object;
      
      private var _oldMouseDown:Point;
      
      private var _assetStageOffset:int = -10;
      
      private var _updatable:Boolean = false;
      
      private var _uploadedSoundThumb:Thumb;
      
      private var _gettingAssets:Boolean = false;
      
      private var _oldThemeId:String;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function ThumbTray()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "preinitialize":"___ThumbTray_Canvas1_preinitialize",
               "creationComplete":"___ThumbTray_Canvas1_creationComplete"
            },
            "propertiesFactory":function():Object
            {
               return {
                  "width":310,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":GradientCanvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"thumbTray"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Panel,
                     "id":"pnlShadow",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":15,
                           "width":306,
                           "height":30,
                           "layout":"absolute",
                           "styleName":"pnlTheaterShadow"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"dc",
                     "events":{"click":"__dc_click"},
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16777215;
                        this.cornerRadius = 8;
                        this.borderStyle = "solid";
                        this.borderThickness = 3;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":15,
                           "width":306,
                           "height":30,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "id":"_ThumbTray_VBox1",
                     "stylesFactory":function():void
                     {
                        this.paddingBottom = 5;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":4,
                           "y":47,
                           "width":302,
                           "percentHeight":100,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":ViewStack,
                              "id":"VSThumbTray",
                              "events":{"click":"__VSThumbTray_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "creationPolicy":"all",
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_uiCanvasTheme",
                                       "stylesFactory":function():void
                                       {
                                          this.backgroundColor = 16711680;
                                          this.cornerRadius = 8;
                                          this.borderStyle = "solid";
                                          this.borderThickness = 3;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"_assetTrayBg",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":0,
                                                      "y":52,
                                                      "width":300,
                                                      "height":377,
                                                      "styleName":"assetTrayBg"
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":TabNavigator,
                                                "id":"_uiNavigatorThemes",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "styleName":"navigatorThums",
                                                      "mouseEnabled":false,
                                                      "buttonMode":true,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":ViewStack,
                                                         "id":"_uiCharThemeViewStack",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "creationPolicy":"all",
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileCharThemes",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"charTileContainer"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Accordion,
                                                                  "id":"_uiCharThemeAccordion",
                                                                  "events":{"change":"___uiCharThemeAccordion_change"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.headerStyleName = "goaccordionHeader";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"goAccordion",
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":FlowBox,
                                                                           "id":"_uiTileCharYourChar",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "percentWidth":100,
                                                                                 "percentHeight":100,
                                                                                 "direction":"horizontal",
                                                                                 "horizontalScrollPolicy":"off",
                                                                                 "styleName":"charTileContainer",
                                                                                 "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "id":"btnCreateCc2",
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {"childDescriptors":[new UIComponentDescriptor({
                                                                                          "type":Button,
                                                                                          "id":"_ThumbTray_Button1",
                                                                                          "events":{"click":"___ThumbTray_Button1_click"},
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {
                                                                                                "verticalCenter":0,
                                                                                                "horizontalCenter":0,
                                                                                                "styleName":"btnCreateNewCcCharRect"
                                                                                             };
                                                                                          }
                                                                                       })]};
                                                                                    }
                                                                                 }),new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "id":"btnCreateCc",
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {
                                                                                          "width":270,
                                                                                          "childDescriptors":[new UIComponentDescriptor({
                                                                                             "type":Button,
                                                                                             "id":"_ThumbTray_Button2",
                                                                                             "events":{"click":"___ThumbTray_Button2_click"},
                                                                                             "propertiesFactory":function():Object
                                                                                             {
                                                                                                return {
                                                                                                   "buttonMode":true,
                                                                                                   "verticalCenter":0,
                                                                                                   "horizontalCenter":0,
                                                                                                   "width":260,
                                                                                                   "height":60,
                                                                                                   "styleName":"btnCreateNewCcChar"
                                                                                                };
                                                                                             }
                                                                                          })]
                                                                                       };
                                                                                    }
                                                                                 })]
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Repeater,
                                                                           "id":"templateCharacterRepeater",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {"childDescriptors":[new UIComponentDescriptor({
                                                                                 "type":FlowBox,
                                                                                 "propertiesFactory":function():Object
                                                                                 {
                                                                                    return {
                                                                                       "percentWidth":100,
                                                                                       "percentHeight":100,
                                                                                       "styleName":"charTileContainer",
                                                                                       "horizontalScrollPolicy":"off",
                                                                                       "childDescriptors":[new UIComponentDescriptor({
                                                                                          "type":Canvas,
                                                                                          "id":"_ThumbTray_Canvas7",
                                                                                          "events":{"creationComplete":"___ThumbTray_Canvas7_creationComplete"},
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {
                                                                                                "width":270,
                                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                                   "type":Button,
                                                                                                   "id":"_ThumbTray_Button3",
                                                                                                   "events":{"click":"___ThumbTray_Button3_click"},
                                                                                                   "propertiesFactory":function():Object
                                                                                                   {
                                                                                                      return {
                                                                                                         "buttonMode":true,
                                                                                                         "verticalCenter":0,
                                                                                                         "horizontalCenter":0,
                                                                                                         "width":260,
                                                                                                         "height":60,
                                                                                                         "styleName":"btnCreateNewCcChar"
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
                                                                        })]
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"_uiTileBubbleThemes",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"bubbleTileContainer"
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Accordion,
                                                         "id":"_uiBgThemes",
                                                         "events":{"change":"___uiBgThemes_change"},
                                                         "stylesFactory":function():void
                                                         {
                                                            this.headerStyleName = "goaccordionHeader";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"goAccordion",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileBgThemes",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"bgTileContainer"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileTemplateThemes",
                                                                  "events":{"show":"___uiTileTemplateThemes_show"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"bgTileContainer"
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":VBox,
                                                         "id":"goPropPanel",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Form,
                                                                  "id":"_ThumbTray_Form1",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingBottom = 5;
                                                                     this.paddingLeft = 5;
                                                                     this.paddingRight = 5;
                                                                     this.paddingTop = 5;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "childDescriptors":[new UIComponentDescriptor({
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
                                                                                    "type":TextInput,
                                                                                    "id":"txtKey",
                                                                                    "events":{
                                                                                       "click":"__txtKey_click",
                                                                                       "focusOut":"__txtKey_focusOut"
                                                                                    },
                                                                                    "stylesFactory":function():void
                                                                                    {
                                                                                       this.color = 10066329;
                                                                                       this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {"percentWidth":100};
                                                                                    }
                                                                                 }),new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"btnSearch",
                                                                                    "events":{"click":"__btnSearch_click"},
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {
                                                                                          "styleName":"btnSearch",
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
                                                                  "type":Accordion,
                                                                  "id":"_uiPropThemes",
                                                                  "events":{
                                                                     "show":"___uiPropThemes_show",
                                                                     "change":"___uiPropThemes_change"
                                                                  },
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.headerStyleName = "goaccordionHeader";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"goAccordion",
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":Tile,
                                                                           "id":"_uiTilePropHandHeldThemes",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "percentWidth":100,
                                                                                 "percentHeight":100,
                                                                                 "styleName":"propTileContainer"
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Tile,
                                                                           "id":"_uiTilePropMaskThemes",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "percentWidth":100,
                                                                                 "percentHeight":100,
                                                                                 "styleName":"propTileContainer"
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Tile,
                                                                           "id":"_uiTilePropHeadThemes",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "percentWidth":100,
                                                                                 "percentHeight":100,
                                                                                 "styleName":"propTileContainer"
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Tile,
                                                                           "id":"_uiTilePropOtherThemes",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "percentWidth":100,
                                                                                 "percentHeight":100,
                                                                                 "styleName":"propTileContainer"
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Accordion,
                                                         "id":"_uiSoundThemes",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.headerStyleName = "goaccordionHeader";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"goAccordion",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileSoundMusicThemes",
                                                                  "events":{"scroll":"___uiTileSoundMusicThemes_scroll"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.verticalGap = 0;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "horizontalScrollPolicy":"off"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileSoundEffectsThemes",
                                                                  "events":{"scroll":"___uiTileSoundEffectsThemes_scroll"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.verticalGap = 0;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "horizontalScrollPolicy":"off"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":VBox,
                                                                  "id":"_vbTribe",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingBottom = 10;
                                                                     this.horizontalAlign = "center";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "horizontalScrollPolicy":"off",
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":Tile,
                                                                           "id":"_uiTileSoundTribeThemes",
                                                                           "events":{"scroll":"___uiTileSoundTribeThemes_scroll"},
                                                                           "stylesFactory":function():void
                                                                           {
                                                                              this.verticalGap = 0;
                                                                           },
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "percentWidth":100,
                                                                                 "percentHeight":100,
                                                                                 "horizontalScrollPolicy":"off"
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Button,
                                                                           "events":{"click":"___ThumbTray_Button5_click"},
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {"styleName":"btnTribeOfNoise"};
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"_uiTileEffectThemes",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"effectTileContainer",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Canvas,
                                                                  "id":"_tipsSceneSet",
                                                                  "events":{
                                                                     "creationComplete":"___tipsSceneSet_creationComplete",
                                                                     "click":"___tipsSceneSet_click"
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "width":270,
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":HBox,
                                                                           "stylesFactory":function():void
                                                                           {
                                                                              this.verticalAlign = "middle";
                                                                           },
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "percentHeight":100,
                                                                                 "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_ThumbTray_Label1",
                                                                                    "stylesFactory":function():void
                                                                                    {
                                                                                       this.fontSize = 16;
                                                                                    }
                                                                                 }),new UIComponentDescriptor({
                                                                                    "type":Text,
                                                                                    "id":"_ThumbTray_Text1",
                                                                                    "stylesFactory":function():void
                                                                                    {
                                                                                       this.fontSize = 11;
                                                                                       this.color = 16777215;
                                                                                    },
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {
                                                                                          "width":200,
                                                                                          "selectable":false,
                                                                                          "mouseEnabled":false,
                                                                                          "mouseChildren":false
                                                                                       };
                                                                                    }
                                                                                 }),new UIComponentDescriptor({
                                                                                    "type":Canvas,
                                                                                    "id":"_tipsArrow",
                                                                                    "propertiesFactory":function():Object
                                                                                    {
                                                                                       return {"width":10};
                                                                                    }
                                                                                 })]
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({"type":Spacer}),new UIComponentDescriptor({"type":Spacer}),new UIComponentDescriptor({"type":Spacer})]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_uiLblTheme",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontWeight = "bold";
                                                   this.fontSize = 20;
                                                   this.textAlign = "center";
                                                   this.color = 5460819;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":0,
                                                      "y":430,
                                                      "width":300,
                                                      "height":35
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"_loading",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":0,
                                                      "y":0,
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "visible":false,
                                                      "childDescriptors":[new UIComponentDescriptor({"type":LoadingImage})]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_uiCanvasUser",
                                       "stylesFactory":function():void
                                       {
                                          this.backgroundColor = 16777215;
                                          this.cornerRadius = 8;
                                          this.borderStyle = "solid";
                                          this.borderThickness = 3;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_uiLblUser",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontWeight = "bold";
                                                   this.fontSize = 20;
                                                   this.textAlign = "center";
                                                   this.color = 5460819;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":0,
                                                      "y":430,
                                                      "width":300,
                                                      "height":35
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":TabNavigator,
                                                "id":"_uiNavigatorUser",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "styleName":"navigatorThums",
                                                      "mouseEnabled":false,
                                                      "buttonMode":true,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "id":"_uiCanvasPropUser",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTilePropUser",
                                                                  "events":{
                                                                     "childAdd":"___uiTilePropUser_childAdd",
                                                                     "childRemove":"___uiTilePropUser_childRemove",
                                                                     "scroll":"___uiTilePropUser_scroll"
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"propTileContainer"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_uiLabelPropUser",
                                                                  "events":{"click":"___uiLabelPropUser_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.fontWeight = "bold";
                                                                     this.fontSize = 20;
                                                                     this.textAlign = "center";
                                                                     this.color = 5460819;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "useHandCursor":true,
                                                                        "mouseChildren":false,
                                                                        "visible":false,
                                                                        "buttonMode":true,
                                                                        "x":0,
                                                                        "y":90,
                                                                        "width":300,
                                                                        "height":35
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Accordion,
                                                         "id":"_uiSceneMovie",
                                                         "events":{
                                                            "show":"___uiSceneMovie_show",
                                                            "change":"___uiSceneMovie_change"
                                                         },
                                                         "stylesFactory":function():void
                                                         {
                                                            this.headerStyleName = "goaccordionHeader";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"goAccordion",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileTemplateMovie",
                                                                  "events":{"scroll":"___uiTileTemplateMovie_scroll"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"bgTileContainer"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Canvas,
                                                                  "id":"_uiCanvasBgUser",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "horizontalScrollPolicy":"off",
                                                                        "verticalScrollPolicy":"off",
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":Tile,
                                                                           "id":"_uiTileBgUser",
                                                                           "events":{
                                                                              "childAdd":"___uiTileBgUser_childAdd",
                                                                              "childRemove":"___uiTileBgUser_childRemove",
                                                                              "scroll":"___uiTileBgUser_scroll"
                                                                           },
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "percentWidth":100,
                                                                                 "percentHeight":100,
                                                                                 "styleName":"bgTileContainer"
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Label,
                                                                           "id":"_uiLabelBgUser",
                                                                           "events":{"click":"___uiLabelBgUser_click"},
                                                                           "stylesFactory":function():void
                                                                           {
                                                                              this.fontWeight = "bold";
                                                                              this.fontSize = 20;
                                                                              this.textAlign = "center";
                                                                              this.color = 5460819;
                                                                           },
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "useHandCursor":true,
                                                                                 "mouseChildren":false,
                                                                                 "visible":false,
                                                                                 "buttonMode":true,
                                                                                 "x":0,
                                                                                 "y":90,
                                                                                 "width":300,
                                                                                 "height":35
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Accordion,
                                                         "id":"_userSoundThemes",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.headerStyleName = "goaccordionHeader";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"goAccordion",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_userTileSoundMusicThemes",
                                                                  "events":{"scroll":"___userTileSoundMusicThemes_scroll"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.verticalGap = 0;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "horizontalScrollPolicy":"off"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_userTileSoundEffectThemes",
                                                                  "events":{"scroll":"___userTileSoundEffectThemes_scroll"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.verticalGap = 0;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "horizontalScrollPolicy":"off"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_userTileSoundVoiceThemes",
                                                                  "events":{"scroll":"___userTileSoundVoiceThemes_scroll"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.verticalGap = 0;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "horizontalScrollPolicy":"off"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Canvas,
                                                                  "id":"_userSoundNotUploadableNotice",
                                                                  "events":{"render":"___userSoundNotUploadableNotice_render"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "visible":false,
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "horizontalScrollPolicy":"off",
                                                                        "verticalScrollPolicy":"off",
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":Text,
                                                                           "id":"_userSoundNotUploadableNoticeText",
                                                                           "stylesFactory":function():void
                                                                           {
                                                                              this.textAlign = "center";
                                                                              this.color = 14904329;
                                                                              this.fontSize = 22;
                                                                           },
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "width":280,
                                                                                 "height":169,
                                                                                 "verticalCenter":0,
                                                                                 "horizontalCenter":0
                                                                              };
                                                                           }
                                                                        }),new UIComponentDescriptor({
                                                                           "type":Text,
                                                                           "id":"_ThumbTray_Text3",
                                                                           "stylesFactory":function():void
                                                                           {
                                                                              this.textAlign = "right";
                                                                              this.fontSize = 14;
                                                                              this.color = 8289918;
                                                                           },
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "y":270,
                                                                                 "horizontalCenter":0,
                                                                                 "width":210,
                                                                                 "height":60
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "id":"_uiCanvasCharUser",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileCharUser",
                                                                  "events":{
                                                                     "childAdd":"___uiTileCharUser_childAdd",
                                                                     "childRemove":"___uiTileCharUser_childRemove",
                                                                     "scroll":"___uiTileCharUser_scroll"
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"charTileContainer"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_uiLabelCharUser",
                                                                  "events":{"click":"___uiLabelCharUser_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.fontWeight = "bold";
                                                                     this.fontSize = 20;
                                                                     this.textAlign = "center";
                                                                     this.color = 5460819;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "useHandCursor":true,
                                                                        "mouseChildren":false,
                                                                        "visible":false,
                                                                        "buttonMode":true,
                                                                        "x":0,
                                                                        "y":90,
                                                                        "width":300,
                                                                        "height":35
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "id":"_uiCanvasEffectUser",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileEffectUser",
                                                                  "events":{
                                                                     "childAdd":"___uiTileEffectUser_childAdd",
                                                                     "childRemove":"___uiTileEffectUser_childRemove",
                                                                     "scroll":"___uiTileEffectUser_scroll"
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"effectTileContainer"
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Canvas,
                                                         "id":"_uiCanvasVideoPropUser",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "horizontalScrollPolicy":"off",
                                                               "verticalScrollPolicy":"off",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileVideoPropUser",
                                                                  "events":{
                                                                     "childAdd":"___uiTileVideoPropUser_childAdd",
                                                                     "childRemove":"___uiTileVideoPropUser_childRemove",
                                                                     "scroll":"___uiTileVideoPropUser_scroll"
                                                                  },
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingLeft = 10;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_uiLabelVideoPropUser",
                                                                  "events":{"click":"___uiLabelVideoPropUser_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.fontWeight = "bold";
                                                                     this.fontSize = 20;
                                                                     this.textAlign = "center";
                                                                     this.color = 5460819;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "useHandCursor":true,
                                                                        "mouseChildren":false,
                                                                        "visible":false,
                                                                        "buttonMode":true,
                                                                        "x":0,
                                                                        "y":90,
                                                                        "width":300,
                                                                        "height":35
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
                                    }),new UIComponentDescriptor({
                                       "type":VBox,
                                       "id":"_uiCanvasCommunity",
                                       "stylesFactory":function():void
                                       {
                                          this.backgroundColor = 16777215;
                                          this.cornerRadius = 8;
                                          this.borderStyle = "solid";
                                          this.borderThickness = 3;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_uiLblResult",
                                                "stylesFactory":function():void
                                                {
                                                   this.fontSize = 14;
                                                   this.color = 10066329;
                                                   this.fontWeight = "bold";
                                                   this.textAlign = "right";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "right":0,
                                                      "width":280,
                                                      "height":21
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":TabNavigator,
                                                "id":"_uiNavigatorCommunity",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":30,
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "styleName":"navigatorThums",
                                                      "mouseEnabled":false,
                                                      "buttonMode":true,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"_uiTilePropCommunity",
                                                         "events":{"scroll":"___uiTilePropCommunity_scroll"},
                                                         "stylesFactory":function():void
                                                         {
                                                            this.paddingLeft = 10;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"_uiTileBgCommunity",
                                                         "events":{"scroll":"___uiTileBgCommunity_scroll"},
                                                         "stylesFactory":function():void
                                                         {
                                                            this.paddingLeft = 10;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"_uiTileCharCommunity",
                                                         "events":{"scroll":"___uiTileCharCommunity_scroll"},
                                                         "stylesFactory":function():void
                                                         {
                                                            this.paddingLeft = 10;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"_uiTileEffectCommunity",
                                                         "events":{"scroll":"___uiTileEffectCommunity_scroll"},
                                                         "stylesFactory":function():void
                                                         {
                                                            this.paddingLeft = 10;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100
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
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Button,
                                                         "id":"_uiBtnSearch",
                                                         "events":{"click":"___uiBtnSearch_click"},
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "bottom":2,
                                                               "right":2,
                                                               "height":22.6,
                                                               "width":101.2,
                                                               "styleName":"btnImport",
                                                               "buttonMode":true
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":PopUpButton,
                                                         "id":"_uiPopBtnSearch",
                                                         "events":{
                                                            "click":"___uiPopBtnSearch_click",
                                                            "creationComplete":"___uiPopBtnSearch_creationComplete"
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "bottom":2,
                                                               "right":2,
                                                               "height":22.6,
                                                               "width":101.2,
                                                               "styleName":"btnImport",
                                                               "visible":false,
                                                               "buttonMode":true
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":TextInput,
                                                         "id":"_uiTxtSearch",
                                                         "events":{
                                                            "mouseDown":"___uiTxtSearch_mouseDown",
                                                            "focusIn":"___uiTxtSearch_focusIn",
                                                            "focusOut":"___uiTxtSearch_focusOut",
                                                            "keyDown":"___uiTxtSearch_keyDown"
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "left":2,
                                                               "bottom":2,
                                                               "maxChars":50
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Label,
                                                         "id":"_uiLblCommunity",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.fontWeight = "bold";
                                                            this.fontSize = 20;
                                                            this.textAlign = "center";
                                                            this.color = 5460819;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "width":300,
                                                               "height":35
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_uiCanvasMovie",
                                       "stylesFactory":function():void
                                       {
                                          this.backgroundColor = 16777215;
                                          this.cornerRadius = 8;
                                          this.borderStyle = "solid";
                                          this.borderThickness = 3;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "x":0,
                                                      "y":52,
                                                      "width":300,
                                                      "height":377,
                                                      "styleName":"assetTrayBg"
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":TabNavigator,
                                                "id":"_uiNavigatorMovie",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "styleName":"navigatorThums",
                                                      "mouseEnabled":false,
                                                      "buttonMode":true,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":ViewStack,
                                                         "id":"_uiCharMovieViewStack",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "creationPolicy":"all",
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTileCharMovie",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"charTileContainer"
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"_uiTileBgMovie",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"bgTileContainer"
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Accordion,
                                                         "id":"_uiPropMovie",
                                                         "events":{
                                                            "show":"___uiPropMovie_show",
                                                            "change":"___uiPropMovie_change"
                                                         },
                                                         "stylesFactory":function():void
                                                         {
                                                            this.headerStyleName = "goaccordionHeader";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"goAccordion",
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTilePropHandHeldMovie",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"propTileContainer"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTilePropMaskMovie",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"propTileContainer"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTilePropHeadMovie",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"propTileContainer"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Tile,
                                                                  "id":"_uiTilePropOtherMovie",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "percentHeight":100,
                                                                        "styleName":"propTileContainer"
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Tile,
                                                         "id":"_uiTileEffectMovie",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "styleName":"effectTileContainer"
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"searchPanel",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "stylesFactory":function():void
                                                {
                                                   this.backgroundColor = 10066329;
                                                   this.borderColor = 10066329;
                                                   this.cornerRadius = 5;
                                                   this.borderStyle = "solid";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "percentHeight":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "events":{"click":"___ThumbTray_HBox3_click"},
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalAlign = "middle";
                                                            this.horizontalGap = 0;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "buttonMode":true,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":IconTextButton,
                                                                  "id":"backToThemeBtn",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.color = 3355443;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"styleName":"btnImport"};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":ProductThemeIcon,
                                                                  "id":"themeIcon"
                                                               })]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             }),new UIComponentDescriptor({
                                                "type":ProductSearchPanel,
                                                "id":"productSearchPanel",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":30,
                                                      "percentWidth":100,
                                                      "percentHeight":100
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
                  }),new UIComponentDescriptor({
                     "type":ToggleButtonBar,
                     "id":"_uiThemeButtonBar",
                     "stylesFactory":function():void
                     {
                        this.textAlign = "center";
                        this.verticalAlign = "top";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":24,
                           "y":0,
                           "dataProvider":"VSThumbTray",
                           "styleName":"themeButtons",
                           "direction":"horizontal",
                           "autoLayout":true,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"btnImport",
                     "events":{"click":"__btnImport_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":215,
                           "y":11,
                           "styleName":"btnImport",
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ThemeSelection,
                     "id":"_themeSelection",
                     "events":{"theme_chosen":"___themeSelection_theme_chosen"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":4,
                           "y":4
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_ThumbTray_Canvas23",
                     "events":{"creationComplete":"___ThumbTray_Canvas23_creationComplete"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "width":302,
                           "height":45
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_uiMaskCanvas",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 16711680;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":0,
                           "visible":false,
                           "width":310,
                           "alpha":0,
                           "percentHeight":100
                        };
                     }
                  })]
               };
            }
         });
         this._soundTileCellArr = new Array();
         this._searchSoundTileCellArr = new Array();
         this._uiTileCharYourChar_lazyHelper = new UtilLazyHelper();
         this._lazyHelpers = {};
         this._lastLoadedPropThumbIndex = new Array();
         this._lastLoadedCommonPropThumbIndex = new Array();
         this._unlockedItems = {};
         this._oldMouseDown = new Point();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._ThumbTray_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_ThumbTrayWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return ThumbTray[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 310;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.clipContent = false;
         this.cacheAsBitmap = true;
         this.states = [this._ThumbTray_State1_c(),this._ThumbTray_State2_c(),this._ThumbTray_State3_c(),this._ThumbTray_State4_c(),this._ThumbTray_State5_c(),this._ThumbTray_State6_c(),this._ThumbTray_State7_c(),this._ThumbTray_State8_c()];
         this._ThumbTray_XML1_i();
         this._ThumbTray_Move1_i();
         this._ThumbTray_Resize1_i();
         this.addEventListener("preinitialize",this.___ThumbTray_Canvas1_preinitialize);
         this.addEventListener("creationComplete",this.___ThumbTray_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         ThumbTray._watcherSetupUtil = param1;
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
      
      public function set isTutorialOn(param1:Boolean) : void
      {
         this.btnCreateCc2.visible = this.btnCreateCc2.includeInLayout = this.btnCreateCc.visible = this.btnCreateCc.includeInLayout = !param1 && FeatureManager.shouldCreateCcButtonBeShown;
      }
      
      private function set createCcButtonVisible(param1:Boolean) : void
      {
         this.btnCreateCc2.visible = this.btnCreateCc2.includeInLayout = this.btnCreateCc.visible = this.btnCreateCc.includeInLayout = param1 && FeatureManager.shouldCreateCcButtonBeShown;
      }
      
      private function getLazyHelper(param1:String) : UtilLazyHelper
      {
         return this._lazyHelpers[param1];
      }
      
      private function setIsCurrentThemeShouldLoadChar(param1:Boolean) : void
      {
         this._isCurrentThemeShouldLoadChar = param1;
      }
      
      private function getIsUiTilePropHandHeldThemesEmpty() : Boolean
      {
         var _loc1_:int = 0;
         if(this._uiTilePropHandHeldThemes.numChildren + this._uiTilePropMaskThemes.numChildren + this._uiTilePropHeadThemes.numChildren + this._uiTilePropOtherThemes.numChildren == 0)
         {
            return true;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTilePropHandHeldThemes.numChildren)
         {
            if(this._uiTilePropHandHeldThemes.getChildAt(_loc1_) is IProductThumb)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTilePropMaskThemes.numChildren)
         {
            if(this._uiTilePropMaskThemes.getChildAt(_loc1_) is IProductThumb)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTilePropHeadThemes.numChildren)
         {
            if(this._uiTilePropHeadThemes.getChildAt(_loc1_) is IProductThumb)
            {
               return false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._uiTilePropOtherThemes.numChildren)
         {
            if(this._uiTilePropOtherThemes.getChildAt(_loc1_) is IProductThumb)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function getIsUiTileCharThemesEmpty() : Boolean
      {
         return this._uiCharThemeAccordion.getChildren().concat(this._uiTileCharThemes).every(function(param1:*, param2:int, param3:Array):Boolean
         {
            var item:* = param1;
            var index:int = param2;
            var array:Array = param3;
            return (item as Container).getChildren().every(function(param1:*, param2:int, param3:Array):Boolean
            {
               return !(param1 is IProductThumb);
            });
         });
      }
      
      public function getIsCurrentThemeShouldLoadChar() : Boolean
      {
         if(this._assetTheme == COMMON_THEME)
         {
            return this._isCurrentThemeShouldLoadChar;
         }
         return false;
      }
      
      [Bindable(event="propertyChange")]
      public function get themeId() : String
      {
         return this._themeId;
      }
      
      private function set _1349701436themeId(param1:String) : void
      {
         this._themeId = param1;
      }
      
      public function fullReady() : Boolean
      {
         return this._fullReady;
      }
      
      public function get userAssetsReady() : Boolean
      {
         return this._userAssetsReady;
      }
      
      public function get communityAssetsReady() : Boolean
      {
         return this._communityAssetsReady;
      }
      
      public function get movieAssetsReady() : Boolean
      {
         return this._movieAssetsReady;
      }
      
      public function get assetTheme() : String
      {
         return this._assetTheme;
      }
      
      public function get userAssetType() : String
      {
         return this._userAssetType;
      }
      
      public function set assetTheme(param1:String) : void
      {
         this._assetTheme = param1;
      }
      
      public function registerShouldShowCharTabOnCcLoaded(param1:Boolean) : void
      {
         this._shouldShowCharTabOnCcLoaded = param1;
      }
      
      public function setLoadingStatus(param1:Boolean) : void
      {
         this.active = !param1;
         this._uiMaskCanvas.visible = param1;
      }
      
      public function changeToFullSize(param1:Boolean = true) : void
      {
         this.pnlShadow.visible = false;
         this.dc.visible = false;
         this._uiCanvasTheme.visible = false;
         this._uiCanvasUser.visible = false;
         this._uiCanvasCommunity.visible = false;
         this._uiCanvasTheme.setStyle("backgroundAlpha",0);
         this._uiCanvasTheme.setStyle("borderStyle","none");
         if(!param1)
         {
         }
         this._uiLblTheme.visible = false;
         this._uiCanvasUser.setStyle("backgroundAlpha",0);
         this._uiCanvasUser.setStyle("borderStyle","none");
         if(!param1)
         {
         }
         this._uiLblUser.visible = false;
         this._uiCanvasCommunity.setStyle("backgroundAlpha",0);
         this._uiCanvasCommunity.setStyle("borderStyle","none");
         this._uiCanvasMovie.setStyle("backgroundAlpha",0);
         this._uiCanvasMovie.setStyle("borderStyle","none");
         if(!param1)
         {
         }
         this._uiLblCommunity.visible = false;
         this._uiTxtSearch.x = 5;
         this._uiTxtSearch.width += 15;
         this._uiPopBtnSearch.x += 5;
         this._uiBtnSearch.x += 5;
         this.height += 9 - 16;
         this._uiThemeButtonBar.invalidateDisplayList();
         this._uiThemeButtonBar.invalidateSize();
         if(param1)
         {
            this._uiThemeButtonBar.styleName = "themeButtonsFull";
         }
         this._uiThemeButtonBar.x = 0;
         this._uiThemeButtonBar.height = 38;
         this._uiThemeButtonBar.width = 300;
         if(param1)
         {
            this.btnImport.width = 80;
            this.btnImport.height = 22.6;
         }
         this._uiThemeButtonBar.visible = false;
      }
      
      public function changeToMessageMode() : void
      {
         this.changeToFullSize(false);
         currentState = "emessage";
         this._uiThemeButtonBar.visible = true;
         this._uiThemeButtonBar.styleName = "themeButtonsMessage";
         this._uiThemeButtonBar.x = -130;
         this._uiThemeButtonBar.height = 38;
         this._uiThemeButtonBar.width = 380;
         this._uiThemeButtonBar.graphics.lineStyle(0,0,0);
         this._uiThemeButtonBar.graphics.beginFill(16777215);
         this._uiThemeButtonBar.graphics.drawRect(250,this._uiThemeButtonBar.height - 5,10,5);
         this._uiThemeButtonBar.graphics.endFill();
         this._uiCanvasTheme.visible = false;
         this.VSThumbTray.selectedChild = this._uiCanvasUser;
         this.gotoSpecifiedTabInMyGoodies(AnimeConstants.ASSET_TYPE_PROP);
         this._uiNavigatorUser.styleName = "containerBlue";
         this._uiCanvasUser.setStyle("cornerRadius",0);
         this._uiCanvasUser.setStyle("borderThickness",10);
         this._uiNavigatorCommunity.styleName = "containerBlue";
         this._uiLabelPropUser.x = 600;
         this._uiLabelPropUser.alpha = 0;
         this._uiBtnSearch.visible = false;
         this._uiTxtSearch.visible = false;
         this.btnImport.label = UtilDict.toDisplay("go","thumbtray_importhead");
         this.btnImport.styleName = "btnBlue";
         this.btnImport.x = 2;
         this.btnImport.y = 348;
         this._themeSelection.visible = false;
         this.setStyle("backgroundAlpha","0");
      }
      
      public function set searchType(param1:String) : void
      {
         this._searchType = param1;
         if(this._uiPopBtnSearch != null)
         {
            if(param1 == AnimeConstants.ASSET_TYPE_BG)
            {
               this._uiMenuSearchType.dataProvider = [{
                  "label":UtilDict.toDisplay("go","thumbtray_prop"),
                  "value":"thumbtray_prop",
                  "type":"check"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_background"),
                  "value":"thumbtray_background",
                  "type":"check",
                  "toggled":"true"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_effect"),
                  "value":"thumbtray_effect",
                  "type":"check"
               }];
            }
            else if(param1 == AnimeConstants.ASSET_TYPE_PROP)
            {
               this._uiMenuSearchType.dataProvider = [{
                  "label":UtilDict.toDisplay("go","thumbtray_prop"),
                  "value":"thumbtray_prop",
                  "type":"check",
                  "toggled":"true"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_background"),
                  "value":"thumbtray_background",
                  "type":"check"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_effect"),
                  "value":"thumbtray_effect",
                  "type":"check"
               }];
            }
            else if(param1 == AnimeConstants.ASSET_TYPE_FX)
            {
               this._uiMenuSearchType.dataProvider = [{
                  "label":UtilDict.toDisplay("go","thumbtray_prop"),
                  "value":"thumbtray_prop",
                  "type":"check"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_background"),
                  "value":"thumbtray_background",
                  "type":"check"
               },{
                  "label":UtilDict.toDisplay("go","thumbtray_effect"),
                  "value":"thumbtray_effect",
                  "type":"check",
                  "toggled":"true"
               }];
            }
         }
      }
      
      public function get searchType() : String
      {
         return this._searchType;
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      public function set active(param1:Boolean) : void
      {
         this._active = param1;
      }
      
      public function get hidable() : Boolean
      {
         return this._hidable;
      }
      
      public function set hidable(param1:Boolean) : void
      {
         this._hidable = param1;
      }
      
      public function clearSearchResults() : void
      {
         if(this._uiTileSearch != null)
         {
            this._uiTileSearch.removeAllChildren();
            this._searchSoundTileCellArr.splice(0,this._searchSoundTileCellArr.length);
         }
      }
      
      public function stopAllSounds() : void
      {
         SoundPlaybackManager.stop();
      }
      
      public function show() : void
      {
         if(this.active)
         {
            if(this._effectMove.isPlaying)
            {
               return;
            }
            if(this.VSThumbTray.y != 0)
            {
               this._effectMove.yFrom = -456;
               this._effectMove.yTo = 0;
               this._effectMove.play();
               this._effectResize.heightFrom = 30;
               this._effectResize.heightTo = this.VSThumbTray.height;
               this._effectResize.addEventListener(EffectEvent.EFFECT_START,this.eventStartHandler);
               this._effectResize.play();
            }
         }
      }
      
      private function eventStartHandler(param1:EffectEvent) : void
      {
         this._effectResize.removeEventListener(EffectEvent.EFFECT_START,this.eventStartHandler);
         dispatchEvent(new Event("TrayOpen"));
      }
      
      public function hide(param1:MouseEvent, param2:Boolean = false) : void
      {
         if(param2 || !(param1.stageX >= this.x && param1.stageX <= this.x + this.width + 15 && param1.stageY >= this.y && param1.stageY <= this.y + this.height - 3))
         {
            if(this.hidable && this.active)
            {
               if(this._effectMove.isPlaying)
               {
                  return;
               }
               if(this.VSThumbTray.y != -456)
               {
                  dispatchEvent(new Event("TrayClose"));
                  this._effectMove.yFrom = -15;
                  this._effectMove.yTo = -456;
                  this._effectMove.play();
                  this._effectResize.heightFrom = 471;
                  this._effectResize.heightTo = 30;
                  if(this._effectResize.hasEventListener(EffectEvent.EFFECT_START))
                  {
                     this._effectResize.removeEventListener(EffectEvent.EFFECT_START,this.eventStartHandler);
                  }
                  this._effectResize.play();
               }
            }
         }
      }
      
      public function showUserGoodies(param1:String, param2:String = null) : void
      {
         this._assetTheme = ThumbTray.USER_THEME;
         this._themeSelection.setThemeById("User");
         this._uiThemeButtonBar.selectedIndex = 1;
         if(param1 == AnimeConstants.ASSET_TYPE_BG)
         {
            this._uiNavigatorUser.selectedChild = this._uiSceneMovie;
            this._uiSceneMovie.selectedChild = this._uiCanvasBgUser;
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_TEMPLATE)
         {
            this._uiNavigatorUser.selectedChild = this._uiSceneMovie;
            this._uiSceneMovie.selectedChild = this._uiTileTemplateMovie;
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP || param1 == AnimeConstants.ASSET_TYPE_PROP_HEAD || param1 == AnimeConstants.ASSET_TYPE_PROP_HELD_BY_CHAR || param1 == AnimeConstants.ASSET_TYPE_PROP_PLACEABLE)
         {
            if(this._uiNavigatorUser.selectedChild != this._uiCanvasPropUser)
            {
               this._uiNavigatorUser.selectedChild = this._uiCanvasPropUser;
            }
            else
            {
               this.onUserAssetTileChange(null);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_CHAR)
         {
            if(this._uiNavigatorUser.selectedChild != this._uiCanvasCharUser)
            {
               this._uiNavigatorUser.selectedChild = this._uiCanvasCharUser;
            }
            else
            {
               this.onUserAssetTileChange(null);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_SOUND || param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC || param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT || param1 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            if(this._uiNavigatorUser.selectedChild != this._userSoundThemes)
            {
               this._uiNavigatorUser.selectedChild = this._userSoundThemes;
            }
            else
            {
               this.onUserAssetTileChange(null);
            }
            if(param2)
            {
               switch(param2)
               {
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC:
                     this._userSoundThemes.selectedChild = this._userTileSoundMusicThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT:
                     this._userSoundThemes.selectedChild = this._userTileSoundEffectThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER:
                     this._userSoundThemes.selectedChild = this._userTileSoundVoiceThemes;
               }
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            if(this._uiNavigatorUser.selectedChild != this._uiCanvasVideoPropUser)
            {
               this._uiNavigatorUser.selectedChild = this._uiCanvasVideoPropUser;
            }
            else
            {
               this.onUserAssetTileChange(null);
            }
         }
      }
      
      public function updateSearchCount(param1:int) : void
      {
         this._uiLblResult.text = StringUtil.substitute(UtilDict.toDisplay("go","{0} asset(s) found."),param1.toString());
      }
      
      public function loadThumbs(param1:Theme, param2:Boolean = false, param3:Tile = null, param4:Boolean = false) : void
      {
         this._canDoPremium = Console.getConsole().premiumEnabled();
         var _loc5_:UtilLoadMgr;
         (_loc5_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadAllThumbsComplete);
         if(CommunityStuffManager.instance.isSearching)
         {
            if(this.searchType == AnimeConstants.ASSET_TYPE_BG)
            {
               this._uiTileSearch.tileWidth = AnimeConstants.TILE_BACKGROUND_WIDTH;
               this._uiTileSearch.tileHeight = AnimeConstants.TILE_BACKGROUND_HEIGHT;
               this.loadBackgroundThumbs(param1,_loc5_);
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_PROP)
            {
               this._uiTileSearch.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
               this._uiTileSearch.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
               this.loadPropThumbs(param1,_loc5_);
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               this._uiTileSearch.tileWidth = AnimeConstants.TILE_CHAR_WIDTH;
               this._uiTileSearch.tileHeight = AnimeConstants.TILE_CHAR_HEIGHT;
               this.loadCharThumbs(param1,_loc5_);
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               this._uiTileSearch.tileWidth = Number.NaN;
               this._uiTileSearch.tileHeight = Number.NaN;
               this.loadSoundThumbs(param1);
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_FX)
            {
               this._uiTileSearch.tileWidth = AnimeConstants.TILE_BUBBLE_WIDTH;
               this._uiTileSearch.tileHeight = AnimeConstants.TILE_BUBBLE_HEIGHT;
               this.loadEffectThumbs(param1,_loc5_);
            }
         }
         else
         {
            if(this._assetTheme == COMMON_THEME && !this.getIsCurrentThemeShouldLoadChar())
            {
               this._fullReady = false;
               if(Console.getConsole().isCommonThemeLoadded)
               {
                  this.onCommonAssetTileChange(null,true);
               }
               else
               {
                  this.onCommonAssetTileChange(null,false);
               }
            }
            else if(this._assetTheme == USER_THEME)
            {
               this._userAssetsReady = false;
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               this._communityAssetsReady = false;
            }
            if(this._assetTheme == MOVIE_THEME || this._assetTheme == USER_THEME || this._assetTheme == COMMUNITY_THEME || this.getIsCurrentThemeShouldLoadChar())
            {
               this.loadCharThumbs(param1,_loc5_);
               if(!param2)
               {
                  this.loadEffectThumbs(param1,_loc5_);
                  this.loadPropThumbs(param1,_loc5_,param3,param4);
                  this.loadVideoPropThumbs(param1,_loc5_,param3,param4);
                  this.loadBackgroundThumbs(param1,_loc5_,param4);
                  if(param1.id != "common" || UtilLicense.isCommonSoundShouldBeShown(ThemeManager.instance.currentTheme.id))
                  {
                     this.loadSoundThumbs(param1);
                  }
                  this.loadTemplateThumbs(param1,_loc5_,param3,param4);
               }
            }
         }
         if(this._assetTheme == COMMON_THEME && !this.getIsCurrentThemeShouldLoadChar())
         {
            this.onLoadAllThumbsComplete();
         }
         else
         {
            _loc5_.commit();
         }
      }
      
      private function onLoadAllThumbsComplete(param1:LoadMgrEvent = null) : void
      {
         Console.getConsole().requestLoadStatus(false,true);
         if(this._assetTheme == COMMON_THEME)
         {
            this._fullReady = true;
            if(!(!this._switchTheme && Console.getConsole().isCommonThemeLoadded))
            {
               this.show();
            }
         }
         else if(this._assetTheme == USER_THEME)
         {
            if(this._userAssetType == AnimeConstants.ASSET_TYPE_TEMPLATE)
            {
               this._userTemplateReady = true;
            }
            else
            {
               this._userAssetsReady = true;
               if(this._userAssetType == AnimeConstants.ASSET_TYPE_BG)
               {
                  this._userBgReady = true;
               }
               else if(this._userAssetType == AnimeConstants.ASSET_TYPE_PROP)
               {
                  this._userPropReady = true;
               }
               else if(this._userAssetType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  this._userCharReady = true;
               }
               else if(this._userAssetType == AnimeConstants.ASSET_TYPE_SOUND)
               {
                  this._userSoundReady = true;
               }
            }
            if(this._gettingAssets)
            {
               this._gettingAssets = false;
            }
         }
         else if(this._assetTheme == COMMUNITY_THEME)
         {
            this._communityAssetsReady = true;
            if(this.searchType == AnimeConstants.ASSET_TYPE_BG)
            {
               this._communityBgReady = true;
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_PROP)
            {
               this._communityPropReady = true;
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_CHAR)
            {
               this._communityCharReady = true;
            }
            else if(this.searchType == AnimeConstants.ASSET_TYPE_SOUND)
            {
               this._communitySoundReady = true;
            }
            if(this._gettingAssets)
            {
               this._gettingAssets = false;
            }
         }
         else if(this._assetTheme == MOVIE_THEME)
         {
            this._movieAssetsReady = true;
            if(UserStuffManager.instance.hasMoreUserTemplate)
            {
               this.addThumbLoadingCanvas("movie","movie");
            }
         }
         if(!Console.getConsole().isLoaddingCommonTheme && (this._assetTheme != MOVIE_THEME && this._assetTheme != USER_THEME && this._assetTheme != COMMUNITY_THEME))
         {
            Console.getConsole().loadCommonTheme();
         }
         else
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this));
         }
      }
      
      public function initThumbTrayDefaultTab(param1:Boolean) : void
      {
         this.startListenToUserTileChange();
         if(UtilLicense.getDefaultUserGoodiesTab(param1) == AnimeConstants.ASSET_TYPE_CHAR)
         {
         }
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            this._uiNavigatorUser.getTabAt(0).visible = false;
            this._uiNavigatorUser.getTabAt(0).includeInLayout = false;
            this._uiNavigatorUser.getTabAt(1).visible = false;
            this._uiNavigatorUser.getTabAt(1).includeInLayout = false;
            this._uiNavigatorUser.getTabAt(3).visible = false;
            this._uiNavigatorUser.getTabAt(3).includeInLayout = false;
            this._uiNavigatorUser.getTabAt(4).visible = false;
            this._uiNavigatorUser.getTabAt(4).includeInLayout = false;
            this._uiNavigatorUser.getTabAt(5).visible = false;
            this._uiNavigatorUser.getTabAt(5).includeInLayout = false;
            this._uiNavigatorCommunity.getTabAt(3).visible = false;
            this._uiNavigatorCommunity.getTabAt(3).includeInLayout = false;
         }
         else if(UtilUser.userType == UtilUser.PLUS_USER)
         {
            this._uiNavigatorUser.getTabAt(4).visible = false;
            this._uiNavigatorUser.getTabAt(4).includeInLayout = false;
            this._uiNavigatorCommunity.getTabAt(3).visible = false;
            this._uiNavigatorCommunity.getTabAt(3).includeInLayout = false;
         }
      }
      
      private function earlyInit() : void
      {
         this.addEventListener(CoreEvent.UNLOCK_ASSET,function(param1:CoreEvent):void
         {
            var assetId:String = null;
            var ctr:Container = null;
            var e:CoreEvent = param1;
            var assetType:String = String(e.getData().type);
            assetId = String(e.getData().id);
            _unlockedItems[[assetType,assetId].join("|")] = 1;
            var selected:IProductThumb = null;
            for each(ctr in [getAccordianPart("_uiTileCharRegularChars"),_uiTileCharThemes])
            {
               if(ctr && ctr.getChildren().some(function(param1:DisplayObject, param2:int, param3:Array):Boolean
               {
                  var _loc4_:* = undefined;
                  if(param1 is IProductThumb)
                  {
                     if(_loc4_ = IProductThumb(param1).product.id == assetId)
                     {
                        selected = IProductThumb(param1);
                     }
                     return _loc4_;
                  }
                  return false;
               }))
               {
                  return;
               }
            }
         });
      }
      
      public function resetTabIcon() : void
      {
         var _loc1_:CSSStyleDeclaration = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".thumbTrayIcon");
         var _loc2_:Class = _loc1_.getStyle("iconChar") as Class;
         var _loc3_:Class = _loc1_.getStyle("iconBubble") as Class;
         var _loc4_:Class = _loc1_.getStyle("iconBackground") as Class;
         var _loc5_:Class = _loc1_.getStyle("iconProp") as Class;
         var _loc6_:Class = _loc1_.getStyle("iconSound") as Class;
         var _loc7_:Class = _loc1_.getStyle("iconEffect") as Class;
         var _loc8_:Class = _loc1_.getStyle("iconVideo") as Class;
         var _loc9_:Class = _loc1_.getStyle("iconTribe") as Class;
         this._uiCharThemeViewStack.icon = this._uiCanvasCharUser.icon = this._uiTileCharCommunity.icon = this._uiCharMovieViewStack.icon = _loc2_;
         this._uiTileBubbleThemes.icon = _loc3_;
         this._uiTileBgCommunity.icon = this._uiBgThemes.icon = this._uiSceneMovie.icon = this._uiTileBgMovie.icon = _loc4_;
         this._uiTilePropCommunity.icon = this._uiCanvasPropUser.icon = this.goPropPanel.icon = this._uiPropMovie.icon = _loc5_;
         this._uiCanvasVideoPropUser.icon = _loc8_;
         this._uiSoundThemes.icon = this._userSoundThemes.icon = _loc6_;
         this._uiTileEffectCommunity.icon = this._uiTileEffectThemes.icon = this._uiCanvasEffectUser.icon = this._uiTileEffectMovie.icon = _loc7_;
         this._vbTribe.icon = _loc9_;
      }
      
      private function initThumbTray() : void
      {
         this.resetTabIcon();
         this._uiTileCharThemes.tileWidth = AnimeConstants.TILE_CHAR_WIDTH;
         this._uiTileCharThemes.tileHeight = AnimeConstants.TILE_CHAR_HEIGHT;
         this._uiTileBubbleThemes.tileWidth = AnimeConstants.TILE_BUBBLE_WIDTH;
         this._uiTileBubbleThemes.tileHeight = AnimeConstants.TILE_BUBBLE_HEIGHT;
         this._uiTilePropHandHeldThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
         this._uiTilePropHandHeldThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         this._uiTilePropMaskThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
         this._uiTilePropMaskThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         this._uiTilePropHeadThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
         this._uiTilePropHeadThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         this._uiTilePropOtherThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
         this._uiTilePropOtherThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         this._uiTileBgThemes.tileWidth = AnimeConstants.TILE_BACKGROUND_WIDTH;
         this._uiTileBgThemes.tileHeight = AnimeConstants.TILE_BACKGROUND_HEIGHT;
         this._uiThemeButtonBar.addEventListener(ItemClickEvent.ITEM_CLICK,this.onClickThemeButton);
         this.templateCharacterRepeater.addEventListener(FlexEvent.REPEAT_END,function(param1:FlexEvent):void
         {
            var _loc2_:* = null;
            var _loc3_:Container = null;
            for(_loc2_ in _lazyHelpers)
            {
               _loc3_ = getAccordianPart(_loc2_);
               getLazyHelper(_loc2_).registerScrollBarEventDispatcher(_loc3_,_uiCharThemeAccordion,_uiCharThemeViewStack,AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT);
               getLazyHelper(_loc2_).addEventListener(LazyHelperEvent.SCROLLED_TO_THE_END,doLazyLoadCharThumbs);
               getLazyHelper(_loc2_).addEventListener(LazyHelperEvent.CONTAINER_BEING_FIRST_SHOWN,doLazyLoadCharThumbs);
            }
         });
         this._uiCharThemeAccordion.addEventListener(ChildExistenceChangedEvent.CHILD_ADD,function(param1:ChildExistenceChangedEvent):void
         {
            var _loc3_:String = null;
            var _loc2_:DisplayObject = param1.relatedObject;
            if(_loc2_ is FlowBox && UIComponent(_loc2_).getRepeaterItem())
            {
               _loc3_ = String(UIComponent(_loc2_).getRepeaterItem().id);
               FlowBox(_loc2_).name = _loc3_;
               FlowBox(_loc2_).label = UtilDict.toDisplay("go",String(UIComponent(_loc2_).getRepeaterItem().label));
               _lazyHelpers[_loc3_] = new UtilLazyHelper();
            }
         });
         this._uiTileCharYourChar_lazyHelper.registerScrollBarEventDispatcher(this._uiTileCharYourChar,this._uiCharThemeAccordion,this._uiCharThemeViewStack,AnimeConstants.TILE_CHAR_WIDTH,AnimeConstants.TILE_CHAR_HEIGHT);
         this._uiTileCharYourChar_lazyHelper.addEventListener(LazyHelperEvent.SCROLLED_TO_THE_END,this.doLazyLoadCharThumbs);
         this._uiTileCharYourChar_lazyHelper.addEventListener(LazyHelperEvent.CONTAINER_BEING_FIRST_SHOWN,this.doLazyLoadCharThumbs);
         this._uiTileCharYourChar.addEventListener(ScrollEvent.SCROLL,this.onCcTrayScroll);
         this._uiTilePropHandHeldThemes.addEventListener(ScrollEvent.SCROLL,this.onPropTrayScroll);
         this._uiTilePropMaskThemes.addEventListener(ScrollEvent.SCROLL,this.onPropTrayScroll);
         this._uiTilePropHeadThemes.addEventListener(ScrollEvent.SCROLL,this.onPropTrayScroll);
         this._uiTilePropOtherThemes.addEventListener(ScrollEvent.SCROLL,this.onPropTrayScroll);
         this._lastLoadedPropThumbIndex["handheld"] = 0;
         this._lastLoadedPropThumbIndex["others"] = 0;
         this._lastLoadedPropThumbIndex["headgear"] = 0;
         this._lastLoadedPropThumbIndex["head"] = 0;
         this._lastLoadedCommonPropThumbIndex["handheld"] = 0;
         this._lastLoadedCommonPropThumbIndex["others"] = 0;
         this._lastLoadedCommonPropThumbIndex["headgear"] = 0;
         this._lastLoadedCommonPropThumbIndex["head"] = 0;
         this._uiTileBgThemes.addEventListener(ScrollEvent.SCROLL,this.onBgTrayScroll);
         if(!UtilLicense.isSoundUploadable)
         {
            this.showSoundNonUploadableNotice();
         }
         else
         {
            this.destroySoundNonUploadableNotice();
         }
         if(!UtilUser.hasPlusFeatures())
         {
            if(this._uiSceneMovie.getChildIndex(this._uiTileTemplateMovie) > -1)
            {
               this._uiSceneMovie.removeChild(this._uiTileTemplateMovie);
            }
         }
         if(!UtilUser.hasAdminFeatures && !UtilSite.isDevelopmentSite)
         {
            if(this._uiBgThemes.getChildIndex(this._uiTileTemplateThemes) > -1)
            {
               this._uiBgThemes.removeChild(this._uiTileTemplateThemes);
            }
         }
         this.addNavChangeListener();
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            this.currentState = "youtube";
         }
         else if(UtilSite.siteId == UtilSite.SKOLETUBE)
         {
            this.currentState = "skoletube";
         }
         else if(UtilLicense.getCurrentLicenseId() == "13")
         {
            this.currentState = "business";
         }
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this._oldMouseDown.x = param1.stageX;
         this._oldMouseDown.y = param1.stageY;
         this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Thumb = null;
         var _loc3_:String = null;
         var _loc4_:Point = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:ICommand = null;
         this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         if(Math.abs(this._oldMouseDown.x - param1.stageX) < 5 && Math.abs(this._oldMouseDown.y - param1.stageY) < 5)
         {
            if(Console.getConsole().currDragSource && Console.getConsole().currentScene)
            {
               _loc2_ = Thumb(Console.getConsole().currDragSource.dataForFormat("thumb"));
               _loc3_ = "";
               if(Console.getConsole().currDragSource.hasFormat("colorSetId"))
               {
                  _loc3_ = String(Console.getConsole().currDragSource.dataForFormat("colorSetId"));
               }
               _loc4_ = Console.getConsole().mainStage.zoomContainer.viewCenter;
               _loc5_ = Console.getConsole().stageScale;
               this._assetStageOffset += 10;
               if(this._assetStageOffset > 10)
               {
                  this._assetStageOffset = -10;
               }
               _loc6_ = _loc4_.x - AnimeConstants.STAGE_PADDING + this._assetStageOffset / _loc5_;
               _loc7_ = _loc4_.y - AnimeConstants.STAGE_PADDING;
               _loc6_ = Math.max(_loc6_,AnimeConstants.SCREEN_X);
               _loc6_ = Math.min(_loc6_,AnimeConstants.STAGE_WIDTH - AnimeConstants.SCREEN_X);
               _loc7_ = Math.max(_loc7_,AnimeConstants.SCREEN_Y);
               _loc7_ = Math.min(_loc7_,AnimeConstants.STAGE_HEIGHT - AnimeConstants.SCREEN_Y);
               if(_loc2_ is TemplateThumb)
               {
                  (_loc8_ = new AddSceneTemplateCommand(Console.getConsole().movie,_loc2_ as TemplateThumb,Console.getConsole().currentSceneIndex + 1,Console.getConsole().timeline)).execute();
               }
               else
               {
                  Console.getConsole().currentScene.doCreateAsset(_loc2_,_loc6_,_loc7_,_loc3_);
               }
            }
         }
         Console.getConsole().currDragSource = null;
      }
      
      private function onCcTrayScroll(param1:ScrollEvent) : void
      {
         if(param1.position >= Container(param1.currentTarget).maxVerticalScrollPosition - 20)
         {
            UserStuffManager.instance.addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.doLoadCcCharThumb);
            UserStuffManager.instance.loadCcChar();
         }
      }
      
      private function onPropTrayScroll(param1:ScrollEvent) : void
      {
         if(param1.position >= Container(param1.currentTarget).maxVerticalScrollPosition - 20)
         {
            this.loadPropThumbs(ThemeManager.instance.currentTheme,new UtilLoadMgr(),Tile(param1.currentTarget));
            if(UtilLicense.isCommonPropShouldBeShown(ThemeManager.instance.currentTheme.id))
            {
               this.loadPropThumbs(ThemeManager.instance.getTheme("common"),new UtilLoadMgr(),Tile(param1.currentTarget));
            }
         }
      }
      
      private function onBgTrayScroll(param1:ScrollEvent) : void
      {
         if(param1.position >= Container(param1.currentTarget).maxVerticalScrollPosition - 20)
         {
            this.loadBackgroundThumbs(ThemeManager.instance.currentTheme,new UtilLoadMgr());
            if(UtilLicense.isCommonBackgroundShouldBeShown(ThemeManager.instance.currentTheme.id))
            {
               this.loadBackgroundThumbs(ThemeManager.instance.getTheme("common"),new UtilLoadMgr());
            }
         }
      }
      
      private function doStartListenToMovieTileChange(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doStartListenToMovieTileChange);
         this.startListenToMovieTileChange();
      }
      
      private function startListenToMovieTileChange() : void
      {
         this.doNotListenToMovieTileChange();
         this._uiNavigatorMovie.addEventListener(IndexChangedEvent.CHANGE,this.onMovieAssetTileChange);
      }
      
      private function doNotListenToMovieTileChange() : void
      {
         this._uiNavigatorMovie.removeEventListener(IndexChangedEvent.CHANGE,this.onMovieAssetTileChange);
      }
      
      private function doStartListenToUserTileChange(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doStartListenToUserTileChange);
         this.startListenToUserTileChange();
      }
      
      private function startListenToUserTileChange() : void
      {
         this.doNotListenToUserTileChange();
         this._uiNavigatorUser.addEventListener(IndexChangedEvent.CHANGE,this.onUserAssetTileChange);
      }
      
      private function doNotListenToUserTileChange() : void
      {
         this._uiNavigatorUser.removeEventListener(IndexChangedEvent.CHANGE,this.onUserAssetTileChange);
      }
      
      private function doUpdateSoundNonUploadableNotice(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doUpdateSoundNonUploadableNotice);
         this._userSoundNotUploadableNoticeText.text = UtilDict.toDisplay("go",AnimeConstants.SOUND_NON_UPLOADABLE_MSG) + " " + Console.getConsole().currentLicensorName;
      }
      
      private function destroySoundNonUploadableNotice() : void
      {
         this._userSoundThemes.removeChild(this._userSoundNotUploadableNotice);
      }
      
      private function showSoundNonUploadableNotice() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         this._userSoundNotUploadableNotice.visible;
         this._userSoundThemes.selectedChild = this._userSoundNotUploadableNotice;
         _loc1_ = 0;
         while(_loc1_ < this._userSoundThemes.numChildren)
         {
            _loc2_ = this._userSoundThemes.getChildAt(_loc1_);
            if(_loc2_ != this._userSoundNotUploadableNotice)
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._userSoundThemes.numChildren)
         {
            this._userTileSoundMusicThemes.enabled = false;
            this._userTileSoundEffectThemes.enabled = false;
            this._userTileSoundVoiceThemes.enabled = false;
            _loc1_++;
         }
         this._userSoundThemes.styleName = "accordionDestroyed";
         this._userSoundThemes.mouseEnabled = this._userSoundThemes.mouseChildren = false;
      }
      
      private function get updatable() : Boolean
      {
         return this._updatable;
      }
      
      private function set updatable(param1:Boolean) : void
      {
         this._updatable = param1;
         this.btnImport.enabled = param1;
         this.btnImport.mouseEnabled = param1;
         this.btnImport.mouseChildren = param1;
         Console.getConsole().mainStage.updatable = param1;
      }
      
      public function onClickThemeButton(param1:ItemClickEvent) : void
      {
         if(param1.index == 0)
         {
            this.switchTheme(COMMON_THEME);
         }
         else if(param1.index == 1)
         {
            this.switchTheme(USER_THEME);
         }
         else if(param1.index == 2)
         {
            this.switchTheme(COMMUNITY_THEME);
         }
         Console.getConsole().showOverTray(false);
      }
      
      public function switchTheme(param1:String, param2:String = "prop") : void
      {
         this.stopAllSounds();
         this.show();
         this._assetTheme = param1;
         if(param1 == COMMON_THEME)
         {
            Util.gaTracking("/gostudio/" + param1 + "/loaded",this.stage);
         }
         else if(param1 == USER_THEME)
         {
            if(!this.userAssetsReady)
            {
               Util.gaTracking("/gostudio/" + param1 + "/loading",this.stage);
               Util.gaTracking("/gostudio/" + param1 + "/loading/" + this._userAssetType,this.stage);
               this._userAssetType = param2;
               UserStuffManager.instance.addEventListener(CoreEvent.LOAD_USER_ASSET_COMPLETE,this.doDispatchSwitchCompleteEvent);
               UserStuffManager.instance.loadStuff(this._userAssetType);
            }
            else
            {
               this.doDispatchSwitchCompleteEvent(null);
               Util.gaTracking("/gostudio/" + this._assetTheme + "/loaded",this.stage);
            }
         }
         else if(param1 == COMMUNITY_THEME)
         {
            if(!this.communityAssetsReady)
            {
               Util.gaTracking("/gostudio/" + param1 + "/loading",this.stage);
               Util.gaTracking("/gostudio/" + param1 + "/loading/" + this.searchType,this.stage);
               CommunityStuffManager.instance.addEventListener(CoreEvent.LOAD_COMMUNITY_ASSET_COMPLETE,this.doDispatchSwitchCompleteEvent);
               CommunityStuffManager.instance.loadStuff(this.searchType);
            }
            else
            {
               this.doDispatchSwitchCompleteEvent(null);
               Util.gaTracking("/gostudio/" + param1 + "/loaded",this.stage);
            }
         }
         else if(param1 == MOVIE_THEME)
         {
            if(!this.movieAssetsReady)
            {
               this.loadThumbs(ThemeManager.instance.movieTheme);
               this._movieAssetsReady = true;
            }
            this.doDispatchSwitchCompleteEvent(null);
         }
      }
      
      private function doDispatchSwitchCompleteEvent(param1:Event) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doDispatchSwitchCompleteEvent);
            Util.gaTracking("/gostudio/" + this._assetTheme + "/complete",this.stage);
         }
         if(this._assetTheme == USER_THEME)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SWITCH_TO_USER_THEME_COMPLETE,this));
         }
         else if(this._assetTheme == COMMUNITY_THEME)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SWITCH_TO_COMMUNITY_THEME_COMPLETE,this));
         }
         else if(this._assetTheme == MOVIE_THEME)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.SWITCH_TO_MOVIE_THEME_COMPLETE,this));
         }
      }
      
      public function loadCharThumbs(param1:Theme, param2:UtilLoadMgr) : void
      {
         var _loc4_:UtilLazyHelper = null;
         var _loc6_:CharThumb = null;
         if(this._assetTheme == USER_THEME)
         {
            this._uiLabelCharUser.visible = ThemeManager.instance.userTheme.charThumbs.length < 3 && UtilUser.hasBetaFeatures();
         }
         else if(this._assetTheme == COMMON_THEME && param1.id != "common")
         {
         }
         var _loc3_:Dictionary = new Dictionary();
         var _loc5_:int = 0;
         for(; _loc5_ < param1.charThumbs.length; _loc5_++)
         {
            if((_loc6_ = param1.charThumbs.getValueByIndex(_loc5_) as CharThumb).isCC && (this._assetTheme == COMMON_THEME || this.getIsCurrentThemeShouldLoadChar()))
            {
               if(_loc6_.xml.@cc_theme_id == ThemeManager.instance.currentTheme.cc_theme_id)
               {
                  _loc4_ = this.getLazyHelperThatCharThumbShouldBelongTo(_loc6_);
                  if(_loc6_.tags.search("_category_professions") >= 0)
                  {
                     _loc6_.tileContainer = this._uiTileCharProfessions;
                     if(this._uiCharThemeAccordion.selectedChild == this._uiTileCharYourChar)
                     {
                        continue;
                     }
                  }
                  else if(_loc6_.tags.search("_category_celebrities") >= 0)
                  {
                     _loc6_.tileContainer = this._uiTileCharCelebrities;
                     if(this._uiCharThemeAccordion.selectedChild == this._uiTileCharYourChar)
                     {
                        continue;
                     }
                  }
                  else
                  {
                     _loc6_.tileContainer = this._uiTileCharYourChar;
                  }
                  if(ThemeManager.instance.currentTheme.cc_theme_id == "cc2" && _loc6_.tags.search("_domain_studio") >= 0)
                  {
                     _loc6_.tileContainer = this._uiTileCharProfessions;
                     _loc4_ = this.getLazyHelper("_uiTileCharProfessions");
                  }
                  if(_loc4_)
                  {
                     this.loadSingleCharThumbs(_loc5_,_loc6_,param2,true);
                  }
               }
            }
            else
            {
               this.loadSingleCharThumbs(_loc5_,_loc6_,param2,true);
            }
         }
      }
      
      private function shuffleArray(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc2_:Number = param1.length - 1;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = Math.round(Math.random() * _loc2_);
            _loc5_ = param1[_loc3_];
            param1[_loc3_] = param1[_loc4_];
            param1[_loc4_] = _loc5_;
            _loc3_++;
         }
      }
      
      private function doLazyLoadCharThumbs(param1:LazyHelperEvent) : void
      {
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:CharThumb = null;
         var _loc2_:UtilLazyHelper = param1.target as UtilLazyHelper;
         var _loc3_:UtilHashArray = _loc2_.getAttachedTempData() as UtilHashArray;
         var _loc4_:Number = 9;
         if(param1.type == LazyHelperEvent.CONTAINER_BEING_FIRST_SHOWN)
         {
            _loc4_ = 3 * Math.ceil((TRAY_MAX_HEIGHT - 20) / AnimeConstants.TILE_CHAR_HEIGHT);
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_.length <= 0)
            {
               break;
            }
            _loc6_ = _loc3_.getValueByIndex(0);
            _loc3_.remove(0,1);
            _loc7_ = _loc6_["i"] as int;
            _loc8_ = _loc6_["currentCharThumb"] as CharThumb;
            this.loadSingleCharThumbs(_loc7_,_loc8_,null,true);
            _loc5_++;
         }
      }
      
      public function loadSingleCharThumbs(param1:int, param2:Thumb, param3:UtilLoadMgr, param4:Boolean) : void
      {
         var _loc6_:int = 0;
         if(!param2.enable)
         {
            return;
         }
         var _loc5_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < param2.colorRef.length)
         {
            if(param2.colorRef.getValueByIndex(_loc6_).@enable == "Y")
            {
               _loc5_ = true;
               break;
            }
            _loc6_++;
         }
         if(_loc5_)
         {
            _loc6_ = 0;
            while(_loc6_ < param2.colorRef.length)
            {
               this.addCharThumbToTheme(param1,param2,param3,null,param2.colorRef.getKey(_loc6_),param4);
               _loc6_++;
            }
         }
         else
         {
            this.addCharThumbToTheme(param1,param2,param3,null,"",param4);
         }
      }
      
      private function addCharThumbToTheme(param1:int, param2:Thumb, param3:UtilLoadMgr = null, param4:Tile = null, param5:String = "", param6:Boolean = true) : void
      {
         var targetContainer:DisplayObjectContainer = null;
         var xx:uint = 0;
         var ss:uint = 0;
         var c:XMLList = null;
         var i:int = param1;
         var thumb:Thumb = param2;
         var loadMgr:UtilLoadMgr = param3;
         var targetTile:Tile = param4;
         var colorNumId:String = param5;
         var isAddAtEndInsteadOfBegin:Boolean = param6;
         var tmNS:Namespace = XML(this._ccThemeModel).namespace("tm");
         var id:String = thumb.uid + colorNumId + this._assetTheme;
         var productThumb:IProductThumb = null;
         if(productThumb == null)
         {
            productThumb = ProductThumbFactory.createThumb(thumb);
            if(productThumb is ProductThumb)
            {
               ProductThumb(productThumb).colorSetId = colorNumId;
            }
            productThumb.product = thumb;
         }
         var thumbnailCanvas:DisplayObject = DisplayObject(productThumb);
         productThumb.addEventListener(AssetPurchasedEvent.ASSET_PURCHASED,this.doLoadNewPurchasedChar);
         productThumb.editable = this._assetTheme == USER_THEME;
         if(productThumb is CharProductThumb)
         {
            CharProductThumb(productThumb).copyable = CharThumb(thumb).copyable && (this._assetTheme == MOVIE_THEME && UtilUser.hasAdminFeatures && thumb.isCC || thumb.isCC && UtilUser.loggedIn && FeatureManager.shouldCcCharacterBeCopyable);
         }
         if(CommunityStuffManager.instance.isSearching)
         {
            this._uiTileSearch.addChildAt(thumbnailCanvas,!!isAddAtEndInsteadOfBegin ? int(this._uiTileSearch.numChildren) : 0);
         }
         else
         {
            xx = 0;
            ss = 0;
            if(targetTile)
            {
               targetContainer = targetTile;
            }
            else if(this._assetTheme == COMMON_THEME || this.getIsCurrentThemeShouldLoadChar())
            {
               if(thumb.theme.id == "ugc" && thumb.isCC)
               {
                  targetContainer = this._uiTileCharYourChar;
               }
               else if(Console.getConsole().isThemeCcRelated(thumb.theme.id) && thumb.isCC)
               {
                  targetContainer = CharThumb(thumb).tileContainer;
               }
               else if(this._uiCharThemeViewStack.selectedChild == this._uiCharThemeAccordion)
               {
                  c = this._ccThemeModel.tmNS::theme.(@id == thumb.theme.id).tmNS::accordian.(@containsCCTemplates == "N");
                  if(c.length() > 0)
                  {
                     targetContainer = this.getAccordianPart(String(c[0].@id));
                  }
               }
               else
               {
                  targetContainer = this._uiTileCharThemes;
               }
               if(targetContainer != null)
               {
                  if(targetContainer != this._uiTileCharThemes)
                  {
                     xx = 1;
                     ss = 0;
                     if(this._uiCharThemeViewStack.selectedChild == this._uiCharThemeAccordion)
                     {
                        if(c && c.length() > 0 && c[0].@addCharButton == "N")
                        {
                           xx = 0;
                        }
                     }
                     if(targetContainer == this._uiTileCharYourChar)
                     {
                        ss = 1;
                     }
                  }
               }
            }
            else if(this._assetTheme == USER_THEME)
            {
               targetContainer = this._uiTileCharUser;
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               targetContainer = this._uiTileCharCommunity;
            }
            else if(this._assetTheme == MOVIE_THEME)
            {
               targetContainer = this._uiTileCharMovie;
            }
            if(targetContainer)
            {
               targetContainer.addChildAt(thumbnailCanvas,!!isAddAtEndInsteadOfBegin ? int(targetContainer.numChildren - xx) : int(ss));
            }
         }
      }
      
      private function getTileThatCharThumbShouldBelongTo(param1:CharThumb) : Container
      {
         if(param1.theme.id == "ugc")
         {
            return this._uiTileCharYourChar;
         }
         if(param1.tags.search("_category_professions") >= 0)
         {
            return this._uiTileCharProfessions;
         }
         if(param1.tags.search("_category_celebrities") >= 0)
         {
            return this._uiTileCharCelebrities;
         }
         return this._uiTileCharCelebrities;
      }
      
      private function getLazyHelperThatCharThumbShouldBelongTo(param1:CharThumb) : UtilLazyHelper
      {
         if(param1.theme.id == "ugc")
         {
            return this._uiTileCharYourChar_lazyHelper;
         }
         if(param1.tags.search("professions") >= 0)
         {
            return this.getLazyHelper("_uiTileCharProfessions");
         }
         if(param1.tags.search("celebrities") >= 0)
         {
            return this.getLazyHelper("_uiTileCharCelebrities");
         }
         return this.getLazyHelper("_uiTileCharProfessions");
      }
      
      private function clearAllCharThumbs() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Container = null;
         this._uiTileCharThemes.removeAllChildren();
         _loc2_ = this._uiTileCharYourChar.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this._uiTileCharYourChar.getChildAt(_loc2_);
            if(_loc1_ is IProductThumb)
            {
               this._uiTileCharYourChar.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
         for(_loc3_ in this._lazyHelpers)
         {
            if(_loc4_ = this.getAccordianPart(_loc3_))
            {
               _loc2_ = _loc4_.numChildren - 1;
               while(_loc2_ >= 0)
               {
                  _loc1_ = _loc4_.getChildAt(_loc2_);
                  if(_loc1_ is IProductThumb)
                  {
                     _loc4_.removeChildAt(_loc2_);
                  }
                  _loc2_--;
               }
               UtilLazyHelper(this._lazyHelpers[_loc3_]).clear();
            }
         }
         this._uiTileCharYourChar_lazyHelper.clear();
      }
      
      private function loadBubbleThumbs(param1:Theme) : void
      {
         var _loc3_:BubbleThumb = null;
         var _loc4_:String = null;
         var _loc5_:IProductThumb = null;
         var _loc6_:DisplayObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.bubbleThumbs.length)
         {
            _loc3_ = BubbleThumb(param1.bubbleThumbs.getValueByIndex(_loc2_));
            if(_loc3_.enable)
            {
               _loc4_ = _loc3_.uid;
               if((_loc5_ = null) == null)
               {
                  (_loc5_ = ProductThumbFactory.createThumb(_loc3_)).product = _loc3_;
               }
               _loc6_ = DisplayObject(_loc5_);
               this._uiTileBubbleThemes.addChild(_loc6_);
            }
            _loc2_++;
         }
      }
      
      private function clearAllBubbleThumbs() : void
      {
         this._uiTileBubbleThemes.removeAllChildren();
      }
      
      private function feedPropLoaderAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:PropThumb = _loc3_[1] as PropThumb;
         _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadPropThumbsComplete);
         _loc4_.loadBytes(ByteArray(_loc5_.imageData));
      }
      
      public function loadPropThumbs(param1:Theme, param2:UtilLoadMgr, param3:Tile = null, param4:Boolean = false) : void
      {
         var _loc5_:String = null;
         var _loc10_:Thumb = null;
         var _loc11_:Boolean = false;
         var _loc12_:int = 0;
         if(this._assetTheme == USER_THEME)
         {
            this._uiLabelPropUser.visible = ThemeManager.instance.userTheme.propThumbs.length < 3 && UtilUser.userType != UtilUser.BASIC_USER;
         }
         if(param1.id != "ugc")
         {
            if(param1.id == MOVIE_THEME)
            {
               param3 = Tile(this._uiPropMovie.selectedChild);
               _loc5_ = "handheld";
               if(param3 == this._uiTilePropHandHeldMovie)
               {
                  _loc5_ = "handheld";
               }
               else if(param3 == this._uiTilePropMaskMovie)
               {
                  _loc5_ = "headgear";
               }
               else if(param3 == this._uiTilePropHeadMovie)
               {
                  _loc5_ = "head";
               }
               else if(param3 == this._uiTilePropOtherMovie)
               {
                  _loc5_ = "others";
               }
            }
            else
            {
               param3 = Tile(this._uiPropThemes.selectedChild);
               _loc5_ = "handheld";
               if(param3 == this._uiTilePropHandHeldThemes)
               {
                  _loc5_ = "handheld";
               }
               else if(param3 == this._uiTilePropMaskThemes)
               {
                  _loc5_ = "headgear";
               }
               else if(param3 == this._uiTilePropHeadThemes)
               {
                  _loc5_ = "head";
               }
               else if(param3 == this._uiTilePropOtherThemes)
               {
                  _loc5_ = "others";
               }
            }
         }
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(param1.id == "common")
         {
            if(this._lastLoadedPropThumbIndex[_loc5_] < ThemeManager.instance.currentTheme.propThumbs.length)
            {
               return;
            }
            _loc7_ = this._lastLoadedCommonPropThumbIndex[_loc5_];
         }
         else if(param1.id == ThemeManager.instance.currentTheme.id)
         {
            _loc7_ = this._lastLoadedPropThumbIndex[_loc5_];
         }
         var _loc8_:uint = 12;
         if(_loc7_ == 0)
         {
            _loc8_ = 4 * Math.ceil((TRAY_MAX_HEIGHT - 100) / AnimeConstants.TILE_PROP_HEIGHT);
         }
         var _loc9_:int = _loc7_;
         for(; _loc9_ < param1.propThumbs.length; _loc9_++)
         {
            if(_loc6_ == _loc8_)
            {
               break;
            }
            if((_loc10_ = param1.propThumbs.getValueByIndex(_loc9_) as Thumb).enable)
            {
               if(param1.id != "ugc")
               {
                  if(_loc10_ is PropThumb && PropThumb(_loc10_).holdable)
                  {
                     if(_loc5_ != "handheld")
                     {
                        continue;
                     }
                  }
                  else if(_loc10_ is PropThumb && PropThumb(_loc10_).wearable)
                  {
                     if(_loc5_ != "headgear")
                     {
                        continue;
                     }
                  }
                  else if(_loc10_ is PropThumb && PropThumb(_loc10_).headable)
                  {
                     if(_loc5_ != "head")
                     {
                        continue;
                     }
                  }
                  else if(_loc5_ != "others")
                  {
                     continue;
                  }
               }
               _loc6_++;
               _loc11_ = false;
               _loc12_ = 0;
               while(_loc12_ < _loc10_.colorRef.length)
               {
                  if(_loc10_.colorRef.getValueByIndex(_loc12_).@enable == "Y")
                  {
                     _loc11_ = true;
                     break;
                  }
                  _loc12_++;
               }
               if(!(_loc10_ is VideoPropThumb))
               {
                  if(_loc11_)
                  {
                     _loc12_ = 0;
                     while(_loc12_ < _loc10_.colorRef.length)
                     {
                        if(_loc10_.colorRef.getValueByIndex(_loc12_).@enable == "Y")
                        {
                           this.addPropThumbToTheme(_loc9_,_loc10_,param2,param3,_loc10_.colorRef.getKey(_loc12_),param4);
                        }
                        _loc12_++;
                     }
                  }
                  else
                  {
                     this.addPropThumbToTheme(_loc9_,_loc10_,param2,param3,"",param4);
                  }
               }
            }
         }
         if(param1.id == "common")
         {
            this._lastLoadedCommonPropThumbIndex[_loc5_] = _loc9_;
         }
         else if(param1.id == ThemeManager.instance.currentTheme.id)
         {
            this._lastLoadedPropThumbIndex[_loc5_] = _loc9_;
         }
         this.onShowPropTray();
      }
      
      public function loadVideoPropThumbs(param1:Theme, param2:UtilLoadMgr, param3:Tile = null, param4:Boolean = false) : void
      {
         var _loc6_:Thumb = null;
         var _loc5_:int = 0;
         while(_loc5_ < param1.propThumbs.length)
         {
            if((_loc6_ = param1.propThumbs.getValueByIndex(_loc5_) as Thumb).enable)
            {
               if(_loc6_ is VideoPropThumb)
               {
                  this.addPropThumbToTheme(_loc5_,_loc6_,param2,this._uiTileVideoPropUser,"",param4);
               }
            }
            _loc5_++;
         }
         this.onShowPropTray();
      }
      
      private function addPropThumbToTheme(param1:int, param2:Thumb, param3:UtilLoadMgr, param4:Tile, param5:String = "", param6:Boolean = false) : void
      {
         var _loc7_:Tile = null;
         var _loc9_:IProductThumb = null;
         if(param2 is VideoPropThumb)
         {
            this.addVideoThumbToTheme(param1,param2,param3,param4,param5,param6);
            return;
         }
         if(param4 == null)
         {
            if(CommunityStuffManager.instance.isSearching)
            {
               _loc7_ = this._uiTileSearch;
            }
            else if(this._assetTheme == COMMON_THEME)
            {
               if(PropThumb(param2).holdable)
               {
                  _loc7_ = this._uiTilePropHandHeldThemes;
               }
               else if(PropThumb(param2).wearable)
               {
                  _loc7_ = this._uiTilePropMaskThemes;
               }
               else if(PropThumb(param2).headable)
               {
                  _loc7_ = this._uiTilePropHeadThemes;
               }
               else
               {
                  _loc7_ = this._uiTilePropOtherThemes;
               }
            }
            else if(this._assetTheme == USER_THEME)
            {
               _loc7_ = this._uiTilePropUser;
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               _loc7_ = this._uiTilePropCommunity;
            }
            else if(this._assetTheme == MOVIE_THEME)
            {
            }
         }
         else
         {
            _loc7_ = param4;
         }
         var _loc8_:String = param2.uid;
         if(_loc9_ == null)
         {
            if((_loc9_ = ProductThumbFactory.createThumb(param2)) is ProductThumb)
            {
               ProductThumb(_loc9_).colorSetId = param5;
            }
            _loc9_.product = param2;
         }
         _loc9_.editable = this._assetTheme == USER_THEME;
         var _loc10_:DisplayObject = DisplayObject(_loc9_);
         if(param6)
         {
            _loc7_.addChildAt(_loc10_,0);
         }
         else
         {
            _loc7_.addChild(_loc10_);
         }
      }
      
      private function addVideoThumbToTheme(param1:int, param2:Thumb, param3:UtilLoadMgr, param4:Tile, param5:String = "", param6:Boolean = false) : void
      {
         var updateTarget:ThumbnailCanvas = null;
         var destTile:Tile = null;
         var fileLock:FileErrorLock = null;
         var loader:Loader = null;
         var callBack:Function = null;
         var loadMngr:UtilLoadMgr = null;
         var params:Array = null;
         var thumbnailSymbol:DisplayObject = null;
         var width:Number = NaN;
         var height:Number = NaN;
         var thumbnailCanvas:ThumbnailCanvas = null;
         var tmNS:Namespace = null;
         var tc:XMLList = null;
         var lockType:ILock = null;
         var i:int = param1;
         var thumb:Thumb = param2;
         var loadMgr:UtilLoadMgr = param3;
         var targetTile:Tile = param4;
         var colorNumId:String = param5;
         var toTop:Boolean = param6;
         var update:Boolean = false;
         if(targetTile == null)
         {
            if(CommunityStuffManager.instance.isSearching)
            {
               destTile = this._uiTileSearch;
            }
            else if(this._assetTheme == COMMON_THEME)
            {
               if(PropThumb(thumb).holdable)
               {
                  destTile = this._uiTilePropHandHeldThemes;
               }
               else if(PropThumb(thumb).wearable)
               {
                  destTile = this._uiTilePropMaskThemes;
               }
               else if(PropThumb(thumb).headable)
               {
                  destTile = this._uiTilePropHeadThemes;
               }
               else
               {
                  destTile = this._uiTilePropOtherThemes;
               }
            }
            else if(this._assetTheme == USER_THEME)
            {
               destTile = this._uiTilePropUser;
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               destTile = this._uiTilePropCommunity;
            }
            else if(this._assetTheme == MOVIE_THEME)
            {
            }
         }
         else
         {
            destTile = targetTile;
         }
         var num:Number = destTile.numChildren;
         if(num > 0)
         {
            i = 0;
            while(i < num)
            {
               if(destTile.getChildAt(i) is ThumbnailCanvas && ThumbnailCanvas(destTile.getChildAt(i)).thumb.id == thumb.id && ThumbnailCanvas(destTile.getChildAt(i)).thumb.theme.id == thumb.theme.id)
               {
                  updateTarget = ThumbnailCanvas(destTile.getChildAt(i));
                  update = true;
                  break;
               }
               i++;
            }
         }
         var image:Image = new Image();
         var videoInProgress:Boolean = false;
         if(!(thumb is VideoPropThumb) || thumb is VideoPropThumb && thumb.imageData != null && VideoPropThumb(thumb).videoHeight > 0 && VideoPropThumb(thumb).videoWidth > 0)
         {
            loader = new Loader();
            loader.name = AnimeConstants.LOADER_NAME + i;
            if(thumb.imageData != null)
            {
               if(UtilFileFormat.checkByteArrayMatchItsExt(PropThumb(thumb).states.length > 0 ? PropThumb(thumb).defaultState.id : thumb.id,thumb.imageData as ByteArray))
               {
                  if(thumb is VideoPropThumb)
                  {
                     callBack = this.loadVideoPropThumbsComplete;
                  }
                  else
                  {
                     callBack = this.loadPropThumbsComplete;
                  }
                  loadMgr.addEventDispatcher(loader.contentLoaderInfo,Event.COMPLETE);
                  loader.contentLoaderInfo.addEventListener(Event.COMPLETE,callBack);
                  loader.loadBytes(ByteArray(thumb.imageData));
               }
               else
               {
                  fileLock = new FileErrorLock();
               }
            }
            else
            {
               loadMngr = new UtilLoadMgr();
               params = new Array();
               params.push(loader);
               params.push(thumb);
               loadMngr.setExtraData(params);
               loadMngr.addEventDispatcher(thumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
               loadMngr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedPropLoaderAgain);
               loadMngr.commit();
               this.callLater(thumb.loadImageData);
            }
            image.addChild(loader);
         }
         else
         {
            thumbnailSymbol = VideoPropThumb(thumb).loadThumbnail();
            image.addChild(thumbnailSymbol);
            videoInProgress = true;
         }
         image.addEventListener(MouseEvent.MOUSE_DOWN,thumb.doDrag);
         if(UtilLicense.shouldShowToolTipForCurrentLicensor())
         {
            image.toolTip = thumb.name;
         }
         if(update)
         {
            if(thumb is VideoPropThumb)
            {
               VideoPropThumb(updateTarget.thumb).videoHeight = VideoPropThumb(thumb).videoHeight;
               VideoPropThumb(updateTarget.thumb).videoWidth = VideoPropThumb(thumb).videoWidth;
            }
            updateTarget.updateDisplayObject(image,videoInProgress);
         }
         else
         {
            if(thumb is VideoPropThumb)
            {
               width = AnimeConstants.TILE_BACKGROUND_WIDTH;
               height = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            }
            else
            {
               width = AnimeConstants.TILE_PROP_WIDTH;
               height = AnimeConstants.TILE_PROP_HEIGHT;
            }
            thumbnailCanvas = new ThumbnailCanvas(width,height,image,thumb,this._assetTheme == USER_THEME ? true : false,false,this._canDoPremium,colorNumId,true,0,true);
            thumbnailCanvas.showId = LicenseConstants.isThumbnailTestHost() && this._assetTheme == COMMON_THEME;
            if(UtilLicense.getCurrentLicenseId() == "8")
            {
               if(this._unlockedItems["prop|" + thumb.id])
               {
                  thumbnailCanvas.locked = null;
               }
               else
               {
                  tmNS = XML(this._ccThemeModel).namespace("tm");
                  tc = this._ccThemeModel.tmNS::theme.(@id == thumb.theme.id).tmNS::asset.(@id == thumb.id);
                  if(tc.length() > 0 && !LicenseConstants.isTestHost() && Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_ADMIN) != "1")
                  {
                     lockType = new GameAchievementLock();
                     if(tc[0].@lockType && String(tc[0].@lockType) == "special")
                     {
                        lockType = new SchoolSpecialLock();
                     }
                     thumbnailCanvas.locked = lockType;
                  }
               }
            }
            if(fileLock)
            {
               thumbnailCanvas.locked = fileLock;
            }
            if(toTop)
            {
               destTile.addChildAt(thumbnailCanvas,0);
            }
            else
            {
               destTile.addChild(thumbnailCanvas);
            }
         }
         if(thumb is VideoPropThumb && VideoPropThumb(thumb).videoHeight <= 0 && VideoPropThumb(thumb).videoWidth <= 0)
         {
            image.removeEventListener(MouseEvent.MOUSE_DOWN,thumb.doDrag);
         }
      }
      
      private function clearThemePropThumbs() : void
      {
         this._uiTilePropHandHeldThemes.removeAllChildren();
         this._uiTilePropMaskThemes.removeAllChildren();
         this._uiTilePropHeadThemes.removeAllChildren();
         this._uiTilePropOtherThemes.removeAllChildren();
         this._lastLoadedPropThumbIndex["handheld"] = 0;
         this._lastLoadedPropThumbIndex["others"] = 0;
         this._lastLoadedPropThumbIndex["headgear"] = 0;
         this._lastLoadedPropThumbIndex["head"] = 0;
         this._lastLoadedCommonPropThumbIndex["handheld"] = 0;
         this._lastLoadedCommonPropThumbIndex["others"] = 0;
         this._lastLoadedCommonPropThumbIndex["headgear"] = 0;
         this._lastLoadedCommonPropThumbIndex["head"] = 0;
      }
      
      private function addThumbLoadingCanvas(param1:String, param2:String) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Tile = null;
         var _loc7_:int = 0;
         if(param2 == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc3_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
            _loc4_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            _loc5_ = "tileBackground";
            if(param1 == "user")
            {
               _loc6_ = this._uiTileBgUser;
            }
            else if(param1 == "community")
            {
               _loc6_ = this._uiTileBgCommunity;
            }
            _loc7_ = 18;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_TEMPLATE)
         {
            _loc3_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
            _loc4_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            _loc5_ = "tileBackground";
            if(param1 == "movie")
            {
               _loc6_ = this._uiTileTemplateMovie;
            }
            _loc7_ = 18;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            _loc3_ = AnimeConstants.TILE_BACKGROUND_WIDTH;
            _loc4_ = AnimeConstants.TILE_BACKGROUND_HEIGHT;
            _loc5_ = "tileBackground";
            if(param1 == "user")
            {
               _loc6_ = this._uiTileVideoPropUser;
            }
            _loc7_ = 18;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc3_ = AnimeConstants.TILE_PROP_WIDTH;
            _loc4_ = AnimeConstants.TILE_PROP_HEIGHT;
            _loc5_ = "tileProp";
            if(param1 == "user")
            {
               _loc6_ = this._uiTilePropUser;
            }
            else if(param1 == "community")
            {
               _loc6_ = this._uiTilePropCommunity;
            }
            _loc7_ = 10;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_CHAR)
         {
            _loc3_ = AnimeConstants.TILE_CHAR_WIDTH;
            _loc4_ = AnimeConstants.TILE_CHAR_HEIGHT;
            _loc5_ = "tileChar";
            if(param1 == "user")
            {
               _loc6_ = this._uiTileCharUser;
            }
            else if(param1 == "community")
            {
               _loc6_ = this._uiTileCharCommunity;
            }
            _loc7_ = 10;
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_FX)
         {
            _loc3_ = AnimeConstants.TILE_CHAR_WIDTH;
            _loc4_ = AnimeConstants.TILE_CHAR_HEIGHT;
            _loc5_ = "tileEffect";
            if(param1 == "user")
            {
               _loc6_ = this._uiTileEffectUser;
            }
            else if(param1 == "community")
            {
               _loc6_ = this._uiTileEffectCommunity;
            }
            _loc7_ = 10;
         }
         var _loc8_:Canvas;
         (_loc8_ = new Canvas()).buttonMode = true;
         _loc8_.width = _loc3_;
         _loc8_.height = _loc4_;
         _loc8_.styleName = _loc5_;
         _loc8_.scrollRect = new Rectangle(0,0,_loc8_.width,_loc8_.height);
         _loc8_.name = "helperCanvas";
         var _loc9_:Label;
         (_loc9_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_loading");
         _loc9_.setStyle("fontWeight","bold");
         _loc9_.setStyle("fontSize",_loc7_);
         _loc8_.addChild(_loc9_);
         _loc9_.y = _loc8_.height / 2 - 10;
         if(_loc6_ != null && _loc6_.getChildByName("helperCanvas") == null)
         {
            _loc6_.addChild(_loc8_);
         }
      }
      
      public function removeLoadingCanvas(param1:String) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1 == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc2_ = this._uiTileBgCommunity.getChildByName("helperCanvas");
            if(_loc2_ != null)
            {
               this._uiTileBgCommunity.removeChild(_loc2_);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc2_ = this._uiTilePropCommunity.getChildByName("helperCanvas");
            if(_loc2_ != null)
            {
               this._uiTilePropCommunity.removeChild(_loc2_);
            }
         }
         else if(param1 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            _loc2_ = this._uiTileVideoPropUser.getChildByName("helperCanvas");
            if(_loc2_ != null)
            {
               this._uiTileVideoPropUser.removeChild(_loc2_);
            }
         }
      }
      
      private function addTemplateThumbToTheme(param1:int, param2:Thumb, param3:UtilLoadMgr, param4:Tile, param5:Boolean = false) : void
      {
         var _loc6_:Loader;
         (_loc6_ = new Loader()).name = AnimeConstants.LOADER_NAME;
         param3.addEventDispatcher(_loc6_.contentLoaderInfo,Event.COMPLETE);
         if(param2.thumbImageData != null)
         {
            _loc6_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadBackgroundThumbsComplete);
            _loc6_.loadBytes(ByteArray(param2.thumbImageData));
         }
         var _loc7_:Image;
         (_loc7_ = new Image()).smoothBitmapContent = true;
         _loc7_.addChild(_loc6_);
         if(UtilLicense.shouldShowToolTipForCurrentLicensor())
         {
            _loc7_.toolTip = param2.name;
         }
         _loc7_.addEventListener(MouseEvent.MOUSE_DOWN,param2.doDrag);
         var _loc8_:ThumbnailCanvas;
         (_loc8_ = new ThumbnailCanvas(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT,_loc7_,param2,true,false,this._canDoPremium)).showId = UtilUser.hasAdminFeatures;
         _loc8_.editable = this._assetTheme == USER_THEME;
         if(param5)
         {
            param4.addChildAt(_loc8_,0);
         }
         else
         {
            param4.addChild(_loc8_);
         }
      }
      
      public function loadTemplateThumbs(param1:Theme, param2:UtilLoadMgr, param3:Tile, param4:Boolean = false) : void
      {
         var _loc9_:Thumb = null;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:uint = 2 * Math.ceil((TRAY_MAX_HEIGHT - 60) / AnimeConstants.TILE_BACKGROUND_HEIGHT);
         var _loc8_:int = _loc6_;
         while(_loc8_ < param1.templateThumbs.length)
         {
            if(_loc5_ == _loc7_)
            {
               break;
            }
            if((_loc9_ = param1.templateThumbs.getValueByIndex(_loc8_) as Thumb).enable)
            {
               _loc5_++;
               this.addTemplateThumbToTheme(_loc8_,_loc9_,param2,param3,param4);
            }
            _loc8_++;
         }
      }
      
      public function loadBackgroundThumbs(param1:Theme, param2:UtilLoadMgr, param3:Boolean = false) : void
      {
         var _loc8_:Thumb = null;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         if(this._assetTheme == USER_THEME)
         {
            this._uiLabelBgUser.visible = param1.backgroundThumbs.length < 3 && UtilUser.userType != UtilUser.BASIC_USER;
         }
         else if(this._assetTheme == COMMON_THEME && param1.id != "common")
         {
         }
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         if(param1.id == "common")
         {
            if(this._lastLoadedBgThumbIndex < ThemeManager.instance.currentTheme.backgroundThumbs.length)
            {
               return;
            }
            _loc5_ = this._lastLoadedCommonBgThumbIndex;
         }
         else if(param1.id == MOVIE_THEME)
         {
            _loc5_ = this._lastLoadedMovieBgThumbIndex;
         }
         else if(param1.id != "ugc")
         {
            _loc5_ = this._lastLoadedBgThumbIndex;
         }
         var _loc6_:uint = 6;
         if(_loc5_ == 0)
         {
            _loc6_ = 2 * Math.ceil((TRAY_MAX_HEIGHT - 60) / AnimeConstants.TILE_BACKGROUND_HEIGHT);
         }
         var _loc7_:int = _loc5_;
         while(_loc7_ < param1.backgroundThumbs.length)
         {
            if(param1.id != "ugc" && _loc4_ == _loc6_)
            {
               break;
            }
            if((_loc8_ = param1.backgroundThumbs.getValueByIndex(_loc7_) as Thumb).enable)
            {
               _loc4_++;
               _loc9_ = false;
               _loc10_ = 0;
               while(_loc10_ < _loc8_.colorRef.length)
               {
                  if(_loc8_.colorRef.getValueByIndex(_loc10_).@enable == "Y")
                  {
                     _loc9_ = true;
                     break;
                  }
                  _loc10_++;
               }
               if(_loc9_)
               {
                  _loc10_ = 0;
                  while(_loc10_ < _loc8_.colorRef.length)
                  {
                     this.addBackgroundThumbToTheme(_loc7_,_loc8_,param2,null,_loc8_.colorRef.getKey(_loc10_),param3);
                     _loc10_++;
                  }
               }
               else
               {
                  this.addBackgroundThumbToTheme(_loc7_,_loc8_,param2,null,"",param3);
               }
            }
            _loc7_++;
         }
         if(param1.id == "common")
         {
            this._lastLoadedCommonBgThumbIndex = _loc7_;
         }
         else if(param1.id == MOVIE_THEME)
         {
            this._lastLoadedMovieBgThumbIndex = _loc7_;
         }
         else if(param1.id != "ugc")
         {
            this._lastLoadedBgThumbIndex = _loc7_;
         }
      }
      
      private function addBackgroundThumbToTheme(param1:int, param2:Thumb, param3:UtilLoadMgr, param4:Tile, param5:String = "", param6:Boolean = false) : void
      {
         var _loc8_:IProductThumb = null;
         var _loc10_:DisplayObjectContainer = null;
         var _loc7_:String = param2.uid;
         if(_loc8_ == null)
         {
            if((_loc8_ = ProductThumbFactory.createThumb(param2)) is ProductThumb)
            {
               ProductThumb(_loc8_).colorSetId = param5;
            }
            _loc8_.product = param2;
         }
         _loc8_.editable = this._assetTheme == USER_THEME;
         var _loc9_:DisplayObject = DisplayObject(_loc8_);
         if(CommunityStuffManager.instance.isSearching)
         {
            this._uiTileSearch.addChild(_loc9_);
         }
         else
         {
            if(param4)
            {
               _loc10_ = param4;
            }
            else if(this._assetTheme == COMMON_THEME)
            {
               _loc10_ = this._uiTileBgThemes;
            }
            else if(this._assetTheme == USER_THEME)
            {
               _loc10_ = this._uiTileBgUser;
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               _loc10_ = this._uiTileBgCommunity;
            }
            else if(this._assetTheme == MOVIE_THEME)
            {
               _loc10_ = this._uiTileBgMovie;
            }
            if(param6)
            {
               _loc10_.addChildAt(_loc9_,0);
            }
            else
            {
               _loc10_.addChild(_loc9_);
            }
         }
      }
      
      private function f(param1:Thumb, param2:Thumb) : int
      {
         if(param1.name > param2.name)
         {
            return 1;
         }
         if(param1.name < param2.name)
         {
            return -1;
         }
         return 0;
      }
      
      private function loadSoundThumbs(param1:Theme) : void
      {
         var _loc4_:SoundThumb = null;
         var _loc2_:Vector.<Thumb> = param1.soundThumbs.clone().getVector();
         _loc2_.sort(this.f);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if((_loc4_ = _loc2_[_loc3_] as SoundThumb).enable)
            {
               this.addSoundTileCell(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function loadEffectThumbs(param1:Theme, param2:UtilLoadMgr) : void
      {
         var _loc4_:EffectThumb = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1.effectThumbs.length)
         {
            if((_loc4_ = EffectThumb(param1.effectThumbs.getValueByIndex(_loc3_))).enable)
            {
               this.addEffectThumbToTheme(_loc3_,_loc4_,param2,null);
            }
            _loc3_++;
         }
      }
      
      private function addEffectThumbToTheme(param1:int, param2:EffectThumb, param3:UtilLoadMgr, param4:Tile) : void
      {
         var _loc6_:IProductThumb = null;
         var _loc8_:DisplayObjectContainer = null;
         var _loc5_:String = param2.uid;
         if(_loc6_ == null)
         {
            (_loc6_ = ProductThumbFactory.createThumb(param2)).product = param2;
         }
         var _loc7_:DisplayObject = DisplayObject(_loc6_);
         if(param2.invisibleFX)
         {
            return;
         }
         if(CommunityStuffManager.instance.isSearching)
         {
            this._uiTileSearch.addChild(_loc7_);
         }
         else
         {
            if(param4)
            {
               _loc8_ = param4;
            }
            else if(this._assetTheme == COMMON_THEME)
            {
               _loc8_ = this._uiTileEffectThemes;
            }
            else if(this._assetTheme == USER_THEME)
            {
               _loc8_ = this._uiTileEffectUser;
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               _loc8_ = this._uiTileEffectCommunity;
            }
            else if(this._assetTheme == MOVIE_THEME)
            {
               _loc8_ = this._uiTileEffectMovie;
            }
            _loc8_.addChild(_loc7_);
         }
      }
      
      private function clearAllEffectThumbs() : void
      {
         while(this._uiTileEffectThemes.numChildren > 4)
         {
            this._uiTileEffectThemes.removeChildAt(4);
         }
      }
      
      private function updateThumbColor(param1:Image, param2:DisplayObject) : void
      {
         var _loc3_:int = 0;
         var _loc4_:XML = null;
         var _loc5_:UtilHashArray = null;
         var _loc6_:int = 0;
         var _loc7_:SelectedColor = null;
         if(param1.parent != null && ThumbnailCanvas(param1.parent).colorSetId != "" && !ThumbnailCanvas(param1.parent).thumb.isCC)
         {
            _loc4_ = ThumbnailCanvas(param1.parent).thumb.colorRef.getValueByKey(ThumbnailCanvas(param1.parent).colorSetId);
            _loc5_ = new UtilHashArray();
            _loc6_ = 0;
            while(_loc6_ < _loc4_.color.length())
            {
               _loc7_ = new SelectedColor(_loc4_.color[_loc6_].@r,_loc4_.color[_loc6_].attribute("oc").length() == 0 ? uint(uint.MAX_VALUE) : uint(_loc4_.color[_loc6_].@oc),uint(_loc4_.color[_loc6_]));
               _loc5_.push(_loc4_.color[_loc6_].@r,_loc7_);
               _loc6_++;
            }
            if(_loc5_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc5_.length)
               {
                  UtilColor.setAssetPartColor(param2,_loc5_.getKey(_loc3_),SelectedColor(_loc5_.getValueByIndex(_loc3_)).dstColor);
                  _loc3_++;
               }
            }
         }
      }
      
      private function loadPropThumbsComplete(param1:Event) : void
      {
         var _loc9_:DisplayObject = null;
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Number = _loc2_.content.width;
         var _loc4_:Number = _loc2_.content.height;
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_PROP_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_PROP_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc3_ <= _loc6_ && _loc4_ <= _loc7_))
         {
            if(_loc3_ > _loc6_ && _loc4_ <= _loc7_)
            {
               _loc5_ = _loc6_ / _loc3_;
               _loc2_.content.width = _loc6_;
               _loc2_.content.height *= _loc5_;
            }
            else if(_loc3_ <= _loc6_ && _loc4_ > _loc7_)
            {
               _loc5_ = _loc7_ / _loc4_;
               _loc2_.content.width *= _loc5_;
               _loc2_.content.height = _loc7_;
            }
            else
            {
               _loc5_ = _loc6_ / _loc3_;
               if(_loc4_ * _loc5_ > _loc7_)
               {
                  _loc5_ = _loc7_ / _loc4_;
                  _loc2_.content.width *= _loc5_;
                  _loc2_.content.height = _loc7_;
               }
               else
               {
                  _loc2_.content.width = _loc6_;
                  _loc2_.content.height *= _loc5_;
               }
            }
         }
         var _loc8_:Rectangle = _loc2_.getBounds(_loc2_);
         _loc2_.x = (AnimeConstants.TILE_PROP_WIDTH - _loc2_.content.width) / 2;
         _loc2_.y = (AnimeConstants.TILE_PROP_HEIGHT - _loc2_.content.height) / 2;
         _loc2_.x -= _loc8_.left;
         _loc2_.y -= _loc8_.top;
         if(_loc2_.content is MovieClip)
         {
            _loc9_ = DisplayObject(_loc2_.content);
            UtilPlain.stopFamily(_loc9_);
         }
         var _loc10_:Image = Image(_loc2_.parent);
         var _loc11_:Canvas;
         if((_loc11_ = Canvas(_loc10_.parent)) != null)
         {
            _loc10_.graphics.beginFill(0,0);
            _loc10_.drawRoundRect(0,0,_loc11_.width,_loc11_.height);
            _loc10_.graphics.endFill();
         }
         this.updateThumbColor(_loc10_,_loc9_);
      }
      
      private function loadVideoPropThumbsComplete(param1:Event) : void
      {
         var _loc9_:DisplayObject = null;
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Number = _loc2_.content.width;
         var _loc4_:Number = _loc2_.content.height;
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc3_ <= _loc6_ && _loc4_ <= _loc7_))
         {
            if(_loc3_ > _loc6_ && _loc4_ <= _loc7_)
            {
               _loc5_ = _loc6_ / _loc3_;
               _loc2_.content.width = _loc6_;
               _loc2_.content.height *= _loc5_;
            }
            else if(_loc3_ <= _loc6_ && _loc4_ > _loc7_)
            {
               _loc5_ = _loc7_ / _loc4_;
               _loc2_.content.width *= _loc5_;
               _loc2_.content.height = _loc7_;
            }
            else
            {
               _loc5_ = _loc6_ / _loc3_;
               if(_loc4_ * _loc5_ > _loc7_)
               {
                  _loc5_ = _loc7_ / _loc4_;
                  _loc2_.content.width *= _loc5_;
                  _loc2_.content.height = _loc7_;
               }
               else
               {
                  _loc2_.content.width = _loc6_;
                  _loc2_.content.height *= _loc5_;
               }
            }
         }
         var _loc8_:Rectangle = _loc2_.getBounds(_loc2_);
         _loc2_.x = (AnimeConstants.TILE_BACKGROUND_WIDTH - _loc2_.content.width) / 2;
         _loc2_.y = (AnimeConstants.TILE_BACKGROUND_HEIGHT - _loc2_.content.height) / 2;
         _loc2_.x -= _loc8_.left;
         _loc2_.y -= _loc8_.top;
         if(_loc2_.content is MovieClip)
         {
            _loc9_ = DisplayObject(_loc2_.content);
            UtilPlain.stopFamily(_loc9_);
         }
         var _loc10_:Image = Image(_loc2_.parent);
         var _loc11_:Canvas;
         if((_loc11_ = Canvas(_loc10_.parent)) != null)
         {
            _loc10_.graphics.beginFill(0,0);
            _loc10_.drawRoundRect(0,0,_loc11_.width,_loc11_.height);
            _loc10_.graphics.endFill();
         }
      }
      
      private function loadBackgroundThumbsComplete(param1:Event) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:Bitmap = null;
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Image = Image(_loc2_.parent);
         var _loc4_:DisplayObject = DisplayObject(_loc2_.content);
         this.updateThumbColor(_loc3_,_loc4_);
         if(_loc2_.contentLoaderInfo.content is Bitmap)
         {
            (_loc6_ = Bitmap(_loc2_.contentLoaderInfo.content)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc6_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         }
         else
         {
            _loc5_ = Util.capturePicture(_loc2_,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
            (_loc6_ = new Bitmap(_loc5_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            _loc6_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         }
         if(_loc3_.getChildByName("imageLoader"))
         {
            _loc3_.removeChild(_loc3_.getChildByName("imageLoader"));
         }
         _loc6_.smoothing = true;
         _loc3_.addChild(_loc6_);
         _loc6_.x = AnimeConstants.TILE_INSETS;
         _loc6_.y = AnimeConstants.TILE_INSETS;
         var _loc7_:Canvas = Canvas(_loc3_.parent);
         _loc3_.graphics.beginFill(0,0);
         _loc3_.drawRoundRect(0,0,_loc7_.width,_loc7_.height);
         _loc3_.graphics.endFill();
      }
      
      private function clearThemeBackgroundThumbs() : void
      {
         this._uiTileBgThemes.removeAllChildren();
         this._lastLoadedBgThumbIndex = 0;
         this._lastLoadedCommonBgThumbIndex = 0;
         this._lastLoadedMovieBgThumbIndex = 0;
      }
      
      private function loadUserAssetBackgroundThumbsComplete(param1:Event) : void
      {
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:BitmapData = Util.capturePicture(_loc2_,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
         var _loc4_:Bitmap;
         (_loc4_ = new Bitmap(_loc3_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
         _loc4_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         var _loc5_:Image = Image(_loc2_.parent);
         _loc5_.removeChild(_loc5_.getChildByName("imageLoader"));
         _loc5_.addChild(_loc4_);
         var _loc6_:Canvas;
         (_loc6_ = new Canvas()).width = AnimeConstants.TILE_BACKGROUND_WIDTH;
         _loc6_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT;
         _loc6_.scrollRect = new Rectangle(0,0,_loc6_.width,_loc6_.height);
         _loc6_.styleName = "tileBackground";
         _loc6_.addChild(_loc5_);
         this._uiTileBgUser.addChild(_loc6_);
         _loc4_.x = AnimeConstants.TILE_INSETS;
         _loc4_.y = AnimeConstants.TILE_INSETS;
         _loc5_.graphics.beginFill(0,0);
         _loc5_.drawRoundRect(0,0,_loc6_.width,_loc6_.height);
         _loc5_.graphics.endFill();
      }
      
      private function loadSoundThumbsComplete(param1:DisplayObject) : void
      {
         param1.width = this._uiSoundThemes.width;
      }
      
      public function set uploadedSoundThumb(param1:SoundThumb) : void
      {
         this._uploadedSoundThumb = param1;
      }
      
      public function addSoundTileCell(param1:SoundThumb, param2:Boolean = true, param3:Tile = null) : void
      {
         if(param1.aid == "11087" || param1.aid == "11093" || param1.aid == "11081" || param1.aid == "11099" || param1.aid == "11084" || param1.aid == "11101" || param1.aid == "11095" || param1.aid == "11097" || param1.aid == "11090")
         {
            return;
         }
         if(this._uploadedSoundThumb && param1 && param1.id == this._uploadedSoundThumb.id)
         {
            return;
         }
         var _loc4_:SoundTileCell;
         (_loc4_ = param1.getTileCell()).buttonMode = true;
         var _loc5_:DisplayObjectContainer = this._userTileSoundVoiceThemes;
         if(CommunityStuffManager.instance.isSearching)
         {
            this._searchSoundTileCellArr.push(_loc4_);
            _loc5_ = this._uiTileSearch;
         }
         else
         {
            this._soundTileCellArr.push(_loc4_);
            if(param3)
            {
               _loc5_ = param3;
            }
            else if(this._assetTheme == USER_THEME || param1.themeId == "ugc")
            {
               if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  _loc5_ = this._userTileSoundMusicThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  _loc5_ = this._userTileSoundEffectThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  _loc5_ = this._userTileSoundVoiceThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  _loc5_ = this._userTileSoundVoiceThemes;
               }
               _loc4_.addEventListener("mouseOverSoundBtnEvent",this.mouseOverSoundBtnHandler);
               _loc4_.addEventListener("mouseOutSoundBtnEvent",this.mouseOutSoundBtnHandler);
            }
            else if(this._assetTheme == COMMON_THEME)
            {
               if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  _loc5_ = this._uiTileSoundMusicThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  _loc5_ = this._uiTileSoundEffectsThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  _loc5_ = this._userTileSoundVoiceThemes;
               }
               else if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TRIBE_OF_NOISE)
               {
                  _loc5_ = this._uiTileSoundTribeThemes;
               }
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               if(param1.subType != AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  if(param1.subType != AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
                  {
                     if(param1.subType != AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
                     {
                        if(param1.subType == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
                        {
                        }
                     }
                  }
               }
            }
         }
         var _loc6_:ThumbnailCanvas = new ThumbnailCanvas(_loc4_.width,_loc4_.height,_loc4_,param1,this._assetTheme == USER_THEME ? true : false,false,this._canDoPremium);
         if(param2)
         {
            _loc5_.addChild(_loc6_);
         }
         else
         {
            _loc5_.addChildAt(_loc6_,0);
         }
         if(_loc5_.numChildren % 2 != 0)
         {
            _loc4_.styleName = STYLE_SOUND_TILE_1;
         }
         else
         {
            _loc4_.styleName = STYLE_SOUND_TILE_2;
         }
      }
      
      private function clearThemeSoundThumbs() : void
      {
         this._uiTileSoundMusicThemes.removeAllChildren();
         this._uiTileSoundEffectsThemes.removeAllChildren();
         this._uiTileSoundTribeThemes.removeAllChildren();
      }
      
      public function clearTheme() : void
      {
         this.clearAllBubbleThumbs();
         this.clearAllCharThumbs();
         this.clearAllEffectThumbs();
         this.clearThemeBackgroundThumbs();
         this.clearThemePropThumbs();
         this.clearThemeSoundThumbs();
      }
      
      public function get uploadType() : String
      {
         if(this._uiNavigatorUser.selectedChild == this._uiSceneMovie)
         {
            return AnimeConstants.ASSET_TYPE_BG;
         }
         if(this._uiNavigatorUser.selectedChild == this._uiCanvasPropUser)
         {
            return AnimeConstants.ASSET_TYPE_PROP_HEAD;
         }
         if(this._uiNavigatorUser.selectedChild == this._uiCanvasCharUser)
         {
            return AnimeConstants.ASSET_TYPE_CHAR;
         }
         if(this._uiNavigatorUser.selectedChild == this._userSoundThemes)
         {
            if(this._userSoundThemes.selectedChild == this._userTileSoundMusicThemes)
            {
               return AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC;
            }
            if(this._userSoundThemes.selectedChild == this._userTileSoundEffectThemes)
            {
               return AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT;
            }
            if(this._userSoundThemes.selectedChild == this._userTileSoundVoiceThemes)
            {
               return AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER;
            }
         }
         return AnimeConstants.ASSET_TYPE_BG;
      }
      
      private function mouseOverSoundBtnHandler(param1:Event) : void
      {
         this.mouseOverSoundBtn = true;
      }
      
      private function mouseOutSoundBtnHandler(param1:Event) : void
      {
         this.mouseOverSoundBtn = false;
      }
      
      public function reloadAllCC() : void
      {
         this.initThemeChosenById("action");
      }
      
      private function showImporterWindow() : void
      {
         var _loc1_:GoAlert = null;
         if(Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            _loc1_ = GoAlert(PopUpManager.createPopUp(this,GoAlert,true));
            _loc1_._lblConfirm.text = "";
            _loc1_._txtDelete.text = "To import your own graphics, please use goanimate.com";
            _loc1_._btnDelete.visible = false;
            _loc1_._btnCancel.label = "OK";
            _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
            _loc1_.y = 100;
            return;
         }
         if(this._uiNavigatorUser.selectedChild == this._uiSceneMovie)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_BG);
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasPropUser)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_PROP_HEAD);
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasCharUser)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_CHAR);
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasEffectUser)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_FX);
         }
         else if(this._uiNavigatorUser.selectedChild == this._userSoundThemes)
         {
            if(this._userSoundThemes.selectedChild == this._userTileSoundMusicThemes)
            {
               Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC);
            }
            else if(this._userSoundThemes.selectedChild == this._userTileSoundEffectThemes)
            {
               Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT);
            }
            else if(this._userSoundThemes.selectedChild == this._userTileSoundVoiceThemes)
            {
               Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER);
            }
            else
            {
               Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasVideoPropUser)
         {
            Console.getConsole().showImporterWindow(AnimeConstants.ASSET_TYPE_PROP_VIDEO);
         }
      }
      
      public function gotoSpecifiedTabInMovieGoodies(param1:String) : void
      {
         this.VSThumbTray.selectedChild = this._uiCanvasMovie;
         if(param1 as String == AnimeConstants.ASSET_TYPE_BG)
         {
            this._uiNavigatorMovie.selectedChild = this._uiTileBgMovie;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_CHAR)
         {
            this._uiNavigatorMovie.selectedChild = this._uiCharMovieViewStack;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_PROP)
         {
            this._uiNavigatorMovie.selectedChild = this._uiPropMovie;
         }
         else if(param1 as String != AnimeConstants.ASSET_TYPE_SOUND)
         {
            if(param1 as String == AnimeConstants.ASSET_TYPE_FX)
            {
               this._uiNavigatorMovie.selectedChild = this._uiTileEffectMovie;
            }
            else if(param1 as String == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
            {
            }
         }
      }
      
      public function gotoSpecifiedTabInMyGoodies(param1:String) : void
      {
         if(param1 as String == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._userSoundThemes;
            this._userSoundThemes.selectedChild = this._userTileSoundVoiceThemes;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_BG)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiSceneMovie;
            this._uiSceneMovie.selectedChild = this._uiCanvasBgUser;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_TEMPLATE)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiSceneMovie;
            this._uiSceneMovie.selectedChild = this._uiTileTemplateMovie;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_CHAR)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasCharUser;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_PROP)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasPropUser;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_SOUND)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._userSoundThemes;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_FX)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasEffectUser;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            this._uiNavigatorUser.selectedChild = this._uiCanvasVideoPropUser;
         }
      }
      
      public function gotoSpecifiedTabInCommunityGoodies(param1:Object) : void
      {
         if(param1 as String == AnimeConstants.ASSET_TYPE_BG)
         {
            this.searchType = AnimeConstants.ASSET_TYPE_BG;
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            this._uiNavigatorCommunity.selectedChild = this._uiTileBgCommunity;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_CHAR)
         {
            this.searchType = AnimeConstants.ASSET_TYPE_CHAR;
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            this._uiNavigatorCommunity.selectedChild = this._uiTileCharCommunity;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_PROP)
         {
            this.searchType = AnimeConstants.ASSET_TYPE_PROP;
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            this._uiNavigatorCommunity.selectedChild = this._uiTilePropCommunity;
         }
         else if(param1 as String == AnimeConstants.ASSET_TYPE_FX)
         {
            this.searchType = AnimeConstants.ASSET_TYPE_FX;
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            this._uiNavigatorCommunity.selectedChild = this._uiTileEffectCommunity;
         }
      }
      
      public function popMaskImage(param1:Object, param2:Number, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:MaskImage;
         (_loc6_ = MaskImage(PopUpManager.createPopUp(this,MaskImage,true))).addEventListener(FlexEvent.CREATION_COMPLETE,this.doCenterMaskImage);
         if(Console.getConsole().studioType == Console.MESSAGE_STUDIO)
         {
            _loc6_.addEventListener(Event.REMOVED_FROM_STAGE,this.doCloseImporter);
         }
         _loc6_.x = 5;
         _loc6_.y = 5;
         _loc6_.placeable = param3;
         _loc6_.holdable = param4;
         _loc6_.headable = param5;
         _loc6_.editImage = param1;
         _loc6_.assetId = param2;
         Console.getConsole().currentScene.stopScene();
      }
      
      private function doCenterMaskImage(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doCenterMaskImage);
         var _loc2_:MaskImage = param1.target as MaskImage;
         var _loc3_:DisplayObject = _loc2_.parent;
         var _loc4_:Point = _loc3_.localToGlobal(new Point(_loc3_.x + _loc3_.width / 2));
         _loc2_.x = _loc2_.globalToLocal(_loc4_).x - _loc2_.width / 2;
      }
      
      private function doCloseImporter(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doCloseImporter);
         Console.getConsole().closeImporter();
      }
      
      private function searchAsset() : void
      {
         if(StringUtil.trim(this._uiTxtSearch.text).length > 0)
         {
            this.clearSearchResults();
            if(this._uiTileSearch == null)
            {
               this._uiTileSearch = new Tile();
               this._uiTileSearch.addEventListener(ScrollEvent.SCROLL,this.doSearchAssetPaging);
               this._uiTileSearch.label = UtilDict.toDisplay("go","thumbtray_result");
               this._uiTileSearch.name = "searchTile";
               this._uiTileSearch.buttonMode = true;
               this._uiTileSearch.horizontalScrollPolicy = ScrollPolicy.OFF;
            }
            if(this._uiNavigatorCommunity.getChildByName("searchTile") == null)
            {
               this._uiNavigatorCommunity.addChild(this._uiTileSearch);
            }
            this._uiNavigatorCommunity.selectedChild = this._uiTileSearch;
            CommunityStuffManager.instance.searchStuff(StringUtil.trim(this._uiTxtSearch.text),this.searchType,true);
         }
         else
         {
            Alert.show(UtilDict.toDisplay("go","thumbtray_nokey"),UtilDict.toDisplay("go","thumbtray_nokeytitle"));
         }
      }
      
      private function doSearchAssetPaging(param1:Event) : void
      {
         if(this._uiTileSearch.verticalScrollPosition >= this._uiTileSearch.maxVerticalScrollPosition - this._uiTileSearch.tileHeight)
         {
            CommunityStuffManager.instance.searchStuff(StringUtil.trim(this._uiTxtSearch.text));
         }
      }
      
      private function onMovieAssetTileChange(param1:Event) : void
      {
      }
      
      private function onUserAssetTileChange(param1:Event) : void
      {
         this._assetTheme = ThumbTray.USER_THEME;
         if(this._uiNavigatorUser.selectedChild == this._uiCanvasCharUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_CHAR;
            if(!this._userCharReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               UserStuffManager.instance.loadStuff(this._userAssetType);
            }
            else
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiSceneMovie)
         {
            if(this._uiSceneMovie.selectedChild == this._uiTileTemplateMovie)
            {
               this._userAssetType = AnimeConstants.ASSET_TYPE_TEMPLATE;
               if(!this._userTemplateReady)
               {
                  UserStuffManager.instance.loadUserTemplate();
               }
            }
            else
            {
               this._userAssetType = AnimeConstants.ASSET_TYPE_BG;
               if(!this._userBgReady)
               {
                  Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
                  UserStuffManager.instance.loadStuff(this._userAssetType);
               }
               else
               {
                  this._uiLabelBgUser.visible = this._uiTileBgUser.numChildren < 3 && UtilUser.userType != UtilUser.BASIC_USER;
                  Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
               }
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasPropUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_PROP;
            if(!this._userPropReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               UserStuffManager.instance.loadStuff(this._userAssetType);
            }
            else
            {
               this._uiLabelPropUser.visible = this._uiTilePropUser.numChildren < 3 && UtilUser.userType != UtilUser.BASIC_USER;
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasCharUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_CHAR;
            if(!this._userCharReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               UserStuffManager.instance.loadStuff(AnimeConstants.ASSET_TYPE_CHAR);
            }
            else
            {
               this._uiLabelCharUser.visible = this._uiTileCharUser.numChildren < 3 && UtilUser.hasBetaFeatures();
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._userSoundThemes)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_SOUND;
            if(!this._userSoundReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               UserStuffManager.instance.loadStuff(this._userAssetType);
            }
            else
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasEffectUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_FX;
            if(!this._userEffectReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               UserStuffManager.instance.loadStuff(this._userAssetType);
            }
            else
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
         else if(this._uiNavigatorUser.selectedChild == this._uiCanvasVideoPropUser)
         {
            this._userAssetType = AnimeConstants.ASSET_TYPE_PROP_VIDEO;
            if(!this._userVideoPropReady)
            {
               Util.gaTracking("/gostudio/" + USER_THEME + "/loading/" + this._userAssetType,this.stage);
               UserStuffManager.instance.loadStuff(this._userAssetType);
            }
            else
            {
               this._uiLabelVideoPropUser.visible = this._uiTileVideoPropUser.numChildren < 3;
               Util.gaTracking("/gostudio/" + USER_THEME + "/loaded/" + this._userAssetType,this.stage);
            }
         }
      }
      
      private function initTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget);
         _loc2_.init(15790320);
         var _loc3_:Canvas = new Canvas();
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_._title.height = 20;
         _loc3_.graphics.beginFill(15897884);
         _loc3_.graphics.drawRoundRectComplex(0,0,_loc3_.width,_loc3_.height,10,10,0,0);
         _loc3_.graphics.endFill();
         var _loc4_:Label;
         (_loc4_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_colortitle");
         _loc4_.setStyle("color",16777215);
         _loc4_.setStyle("fontSize",13);
         _loc4_.x = 5;
         _loc4_.y = 2;
         _loc3_.addChild(_loc4_);
         _loc2_.setTitle(_loc3_);
         var _loc5_:VBox;
         (_loc5_ = new VBox()).setStyle("verticalGap",0);
         _loc5_.setStyle("horizontalAlign","center");
         _loc5_.setStyle("horizontalCenter","1");
         var _loc6_:Text;
         (_loc6_ = new Text()).maxWidth = _loc2_.width * 0.95;
         _loc6_.text = UtilDict.toDisplay("go","thumbtray_colorsubtitle");
         _loc6_.setStyle("fontSize",15);
         var _loc7_:Canvas;
         (_loc7_ = new Canvas()).width = 207;
         _loc7_.height = 110;
         _loc7_.styleName = "imgBunnyArrow";
         var _loc8_:Label;
         (_loc8_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_coloricon");
         _loc8_.setStyle("fontSize",11);
         _loc8_.x = 96;
         _loc8_.y = 20;
         _loc7_.addChild(_loc8_);
         _loc5_.addChild(_loc6_);
         _loc5_.addChild(_loc7_);
         _loc2_._content.height = 170;
         _loc2_.setContent(_loc5_);
         var _loc9_:Canvas;
         (_loc9_ = new Canvas()).width = _loc2_.width;
         _loc9_.setStyle("horizontalCenter","1");
         _loc9_.buttonMode = true;
         var _loc10_:Label;
         (_loc10_ = new Label()).text = UtilDict.toDisplay("go","thumbtray_colorclose");
         _loc10_.buttonMode = true;
         _loc10_.useHandCursor = true;
         _loc10_.mouseChildren = false;
         _loc10_.x = (_loc9_.width - 80) / 2;
         _loc10_.setStyle("fontSize",14);
         _loc10_.addEventListener(MouseEvent.CLICK,this.closeTip);
         _loc9_.addChild(_loc10_);
         _loc2_.setClose(_loc9_);
      }
      
      private function closeTip(param1:Event) : void
      {
         var _loc2_:TipWindow = TipWindow(param1.currentTarget.parent.parent.parent.parent);
         this.removeChild(_loc2_);
      }
      
      private function showTip() : void
      {
         var _loc1_:TipWindow = null;
         var _loc2_:GlowFilter = null;
         var _loc3_:Array = null;
         if(!this._showTip && this.themeId == "bunny" && Console.getConsole().studioType != Console.MESSAGE_STUDIO)
         {
            _loc1_ = new TipWindow();
            _loc1_.width = 216;
            _loc1_.height = 222;
            _loc1_.x = 46;
            _loc1_.y = 163;
            _loc2_ = new GlowFilter(3355443,1,6,6);
            _loc3_ = new Array();
            _loc3_.push(_loc2_);
            _loc1_.filters = _loc3_;
            _loc1_.addEventListener(Event.COMPLETE,this.initTip);
            this.addChild(_loc1_);
            this._showTip = true;
         }
      }
      
      private function onCommonAssetTileChange(param1:Event = null, param2:Boolean = true) : void
      {
         var _loc3_:String = Util.getFlashVar().getValueByKey(ServerConstants.PARAM_COMMONITEM);
         if(this._uiNavigatorThemes.selectedChild == this._uiCharThemeViewStack)
         {
            if(Console.getConsole().isThemeCcRelated(ThemeManager.instance.currentTheme.id))
            {
               this._uiCharThemeViewStack.selectedChild = this._uiCharThemeAccordion;
            }
            else
            {
               this._uiCharThemeViewStack.selectedChild = this._uiTileCharThemes;
            }
            if(this.getIsUiTileCharThemesEmpty())
            {
               this.loadCharThumbs(ThemeManager.instance.currentTheme,new UtilLoadMgr());
               if(param2)
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadCharThumbs(ThemeManager.instance.getTheme("common"),new UtilLoadMgr());
                  }
               }
            }
            Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_TAB_SELECTED,this));
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiTileBubbleThemes)
         {
            if(this._uiTileBubbleThemes.numChildren == 0)
            {
               this.loadBubbleThumbs(ThemeManager.instance.currentTheme);
               if(param2)
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadBubbleThumbs(ThemeManager.instance.getTheme("common"));
                  }
               }
            }
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiBgThemes)
         {
            Console.getConsole().onOpenBgTab();
            if(this._uiTileBgThemes.numChildren == 0)
            {
               this.loadBackgroundThumbs(ThemeManager.instance.currentTheme,new UtilLoadMgr());
               if(param2 && UtilLicense.isCommonBackgroundShouldBeShown(ThemeManager.instance.currentTheme.id))
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadBackgroundThumbs(ThemeManager.instance.getTheme("common"),new UtilLoadMgr());
                  }
               }
            }
            Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.BG_TAB_SELECTED,this));
         }
         else if(this._uiNavigatorThemes.selectedChild == this.goPropPanel)
         {
            if(this.getIsUiTilePropHandHeldThemesEmpty())
            {
               this.loadPropThumbs(ThemeManager.instance.currentTheme,new UtilLoadMgr());
               if(param2 && UtilLicense.isCommonPropShouldBeShown(ThemeManager.instance.currentTheme.id))
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadPropThumbs(ThemeManager.instance.getTheme("common"),new UtilLoadMgr());
                  }
               }
            }
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiSoundThemes)
         {
            if(this._uiTileSoundEffectsThemes.numChildren + this._uiTileSoundMusicThemes.numChildren == 0)
            {
               if(ThemeManager.instance.currentTheme.id != "common" || ThemeManager.instance.currentTheme.id == "common" && UtilLicense.isCommonSoundShouldBeShown(ThemeManager.instance.currentTheme.id))
               {
                  this.loadSoundThumbs(ThemeManager.instance.currentTheme);
                  if(param2 && UtilLicense.isCommonSoundShouldBeShown(ThemeManager.instance.currentTheme.id))
                  {
                     if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                     {
                        this.loadSoundThumbs(ThemeManager.instance.getTheme("common"));
                     }
                  }
               }
            }
         }
         else if(this._uiNavigatorThemes.selectedChild == this._uiTileEffectThemes)
         {
            if(this._uiTileEffectThemes.numChildren == 4)
            {
               this.loadEffectThumbs(ThemeManager.instance.currentTheme,new UtilLoadMgr());
               if(param2)
               {
                  if(_loc3_ == null || _loc3_.charAt(this._uiNavigatorThemes.selectedIndex) != "0")
                  {
                     this.loadEffectThumbs(ThemeManager.instance.getTheme("common"),new UtilLoadMgr());
                  }
               }
            }
         }
         else
         {
            Util.gaTracking("/gostudio/" + COMMON_THEME + "/loaded/" + Container(this._uiNavigatorThemes.selectedChild).id,this.stage);
         }
      }
      
      private function onCommunityTileChange(param1:Event = null) : void
      {
         if(this._uiNavigatorCommunity.selectedChild == this._uiTileSearch)
         {
            this._uiLblResult.visible = true;
            this._uiBtnSearch.visible = false;
            this._uiPopBtnSearch.visible = true;
         }
         else
         {
            this._uiLblResult.visible = false;
            this._uiBtnSearch.visible = true;
            this._uiPopBtnSearch.visible = false;
            if(this._uiNavigatorCommunity.selectedChild == this._uiTileBgCommunity)
            {
               this.searchType = AnimeConstants.ASSET_TYPE_BG;
               if(!this._communityBgReady)
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loading/" + this.searchType,this.stage);
                  CommunityStuffManager.instance.loadStuff(AnimeConstants.ASSET_TYPE_BG);
               }
               else
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loaded/" + this.searchType,this.stage);
               }
            }
            else if(this._uiNavigatorCommunity.selectedChild == this._uiTilePropCommunity)
            {
               this.searchType = AnimeConstants.ASSET_TYPE_PROP;
               if(!this._communityPropReady)
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loading/" + this.searchType,this.stage);
                  CommunityStuffManager.instance.loadStuff(AnimeConstants.ASSET_TYPE_PROP);
               }
               else
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loaded/" + this.searchType,this.stage);
               }
            }
            else if(this._uiNavigatorCommunity.selectedChild == this._uiTileCharCommunity)
            {
               this.searchType = AnimeConstants.ASSET_TYPE_CHAR;
               if(!this._communityCharReady)
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loading/" + this.searchType,this.stage);
                  CommunityStuffManager.instance.loadStuff(AnimeConstants.ASSET_TYPE_CHAR);
               }
               else
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loaded/" + this.searchType,this.stage);
               }
            }
            else if(this._uiNavigatorCommunity.selectedChild == this._uiTileEffectCommunity)
            {
               this.searchType = AnimeConstants.ASSET_TYPE_FX;
               if(!this._communityEffectReady)
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loading/" + this.searchType,this.stage);
                  CommunityStuffManager.instance.loadStuff(AnimeConstants.ASSET_TYPE_FX);
               }
               else
               {
                  Util.gaTracking("/gostudio/" + COMMUNITY_THEME + "/loaded/" + this.searchType,this.stage);
               }
            }
         }
      }
      
      private function onSearchFocusIn(param1:Event) : void
      {
         Console.getConsole().currentScene.selectedAsset = null;
         this.active = false;
      }
      
      private function onSearchFocusOut(param1:Event) : void
      {
         this.active = true;
      }
      
      private function onInputFinish(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.searchAsset();
         }
      }
      
      private function initSearchTypeMenu() : void
      {
         this._uiMenuSearchType = new Menu();
         var _loc1_:Object = [{
            "label":UtilDict.toDisplay("go","thumbtray_prop"),
            "value":"thumbtray_prop",
            "type":"check"
         },{
            "label":UtilDict.toDisplay("go","thumbtray_background"),
            "value":"thumbtray_background",
            "type":"check",
            "toggled":"true"
         },{
            "label":UtilDict.toDisplay("go","thumbtray_effect"),
            "value":"thumbtray_effect",
            "type":"check"
         }];
         this._uiMenuSearchType.dataProvider = _loc1_;
         this._uiMenuSearchType.addEventListener("itemClick",this.itemClickHandler);
         this._uiPopBtnSearch.popUp = this._uiMenuSearchType;
      }
      
      private function itemClickHandler(param1:MenuEvent) : void
      {
         var _loc2_:String = param1.item.value;
         if(_loc2_ == "thumbtray_background")
         {
            this.searchType = AnimeConstants.ASSET_TYPE_BG;
         }
         else if(_loc2_ == "thumbtray_prop")
         {
            this.searchType = AnimeConstants.ASSET_TYPE_PROP;
         }
         else if(_loc2_ == "thumbtray_char")
         {
            this.searchType = AnimeConstants.ASSET_TYPE_CHAR;
         }
         else if(_loc2_ == "thumbtray_effect")
         {
            this.searchType = AnimeConstants.ASSET_TYPE_FX;
         }
         this._uiPopBtnSearch.close();
      }
      
      private function onMouseEventHandler(param1:MouseEvent) : void
      {
         if(!this.mouseOverSoundBtn)
         {
            this.showImporterWindow();
         }
      }
      
      private function tileChangeHandler(param1:ChildExistenceChangedEvent) : void
      {
         var _loc2_:Tile = Tile(param1.currentTarget);
         var _loc3_:* = _loc2_.numChildren < 3;
         if(_loc2_ == this._uiTilePropUser)
         {
            this._uiLabelPropUser.visible = _loc3_ && UtilUser.userType != UtilUser.BASIC_USER;
         }
         else if(_loc2_ == this._uiTileBgUser)
         {
            this._uiLabelBgUser.visible = _loc3_ && UtilUser.userType != UtilUser.BASIC_USER;
         }
         else if(_loc2_ == this._uiTileBgUser)
         {
            this._uiLabelCharUser.visible = _loc3_ && UtilUser.hasBetaFeatures();
         }
      }
      
      public function initThemeDropdown(param1:String) : void
      {
         var _loc2_:Number = NaN;
         var _loc8_:XML = null;
         var _loc9_:UtilHashArray = null;
         var _loc3_:XML = Console.getConsole().themeListXML;
         var _loc4_:Array = new Array();
         var _loc5_:UtilHashArray = new UtilHashArray();
         var _loc6_:int = 0;
         var _loc7_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < _loc3_.child("theme").length())
         {
            _loc8_ = _loc3_.child("theme")[_loc2_];
            if(!UtilLicense.isThemeBlocked(String(_loc8_.@id),UtilLicense.getCurrentLicenseId()))
            {
               if(_loc8_.attribute("id") != "common")
               {
                  if(_loc8_.hasOwnProperty("@cc_theme_id") && _loc8_.@cc_theme_id != "")
                  {
                     _loc4_.unshift({
                        "label":_loc8_.attribute("name"),
                        "data":_loc8_.attribute("id")
                     });
                     (_loc9_ = new UtilHashArray()).push(_loc8_.attribute("id"),_loc8_.attribute("name"));
                     _loc5_.insert(0,_loc9_);
                     _loc6_++;
                  }
                  else
                  {
                     _loc4_.push({
                        "label":_loc8_.attribute("name"),
                        "data":_loc8_.attribute("id")
                     });
                     _loc5_.push(_loc8_.attribute("id"),_loc8_.attribute("name"));
                  }
                  _loc7_.push({
                     "id":String(_loc8_.attribute("id")),
                     "label":String(_loc8_.attribute("name"))
                  });
               }
            }
            _loc2_++;
         }
         if(Console.getConsole().boxMode && _loc4_.length <= 1)
         {
         }
         if(UtilLicense.getCurrentLicenseId() == "7" || UtilLicense.getCurrentLicenseId() == "8" || UtilLicense.isBoxEnvironment())
         {
            this._themeSelection.buildMenu(_loc5_,_loc6_,false,false);
         }
         else
         {
            this._themeSelection.buildMenu(_loc5_,_loc6_,UtilUser.loggedIn,FeatureManager.shouldCommunityStuffBeShown);
         }
         this.productSearchPanel.init(_loc7_);
         ThemeManager.instance.themeList = _loc7_;
      }
      
      public function loadCcTheme(param1:String) : void
      {
         this._uiThemeButtonBar.selectedIndex = 0;
         this._themeSelection.setThemeById(param1);
         this.setIsCurrentThemeShouldLoadChar(false);
         this.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doLoadMyChar);
         Console.getConsole().loadTheme(param1);
      }
      
      public function getCurrentThemeId() : String
      {
         return this._themeSelection.currentThemeId;
      }
      
      private function doLoadMyChar(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadMyChar);
         setTimeout(this.doFinishLoadingChar,1000);
      }
      
      private function doFinishLoadingChar() : void
      {
         this.setIsCurrentThemeShouldLoadChar(true);
         if(this._shouldShowCharTabOnCcLoaded)
         {
            this._uiNavigatorThemes.selectedChild = this._uiCharThemeViewStack;
            this._uiCharThemeViewStack.selectedChild = this._uiCharThemeAccordion;
         }
         UserStuffManager.instance.addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.doLoadCcCharThumb);
         UserStuffManager.instance.loadCcChar();
      }
      
      private function doLoadCcCharThumb(param1:CoreEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadCcCharThumb);
         var _loc2_:Theme = ThemeManager.instance.lastLoaddedTheme;
         if(_loc2_)
         {
            this.addEventListener(CoreEvent.LOAD_ALL_THUMBS_COMPLETE,this.doLoadThumbForCurrentTab);
            this.loadThumbs(_loc2_,true);
         }
      }
      
      private function doLoadNewPurchasedChar(param1:AssetPurchasedEvent) : void
      {
         UserStuffManager.instance.addEventListener(CoreEvent.LOAD_CC_CHAR_COMPLETE,this.doLoadSingleCcCharThumb);
         UserStuffManager.instance.loadSingleCcChar(param1.assetId);
      }
      
      public function doLoadSingleCcCharThumb(param1:CoreEvent) : void
      {
         var _loc7_:String = null;
         var _loc8_:CharThumb = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadSingleCcCharThumb);
         var _loc2_:Object = param1.getData();
         var _loc3_:Theme = _loc2_["lastLoadedTheme"] as Theme;
         var _loc4_:Array = _loc2_["newCharIdArray"] as Array;
         var _loc5_:UtilLoadMgr = new UtilLoadMgr();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc7_ = _loc4_[_loc6_] as String;
            _loc8_ = _loc3_.getCharThumbById(_loc7_);
            this.loadSingleCharThumbs(_loc3_.charThumbs.getIndex(_loc7_),_loc8_,_loc5_,false);
            _loc6_++;
         }
         _loc5_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doShowTheNewCharToUser);
         _loc5_.commit();
      }
      
      private function doShowTheNewCharToUser(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doShowTheNewCharToUser);
         this._uiCharThemeAccordion.selectedChild = this._uiTileCharYourChar;
         this._uiNavigatorThemes.selectedChild = this._uiCharThemeViewStack;
         this._uiTileCharYourChar.verticalScrollPosition = 0;
      }
      
      private function doLoadThumbForCurrentTab(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbForCurrentTab);
         if(this._uiNavigatorThemes.selectedChild != this._uiCharThemeViewStack)
         {
            this.onCommonAssetTileChange();
         }
      }
      
      private function scrollToGetAssets(param1:ScrollEvent, param2:String) : void
      {
         var _loc3_:Canvas = null;
         var _loc4_:* = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Tile = null;
         var _loc7_:Boolean = false;
         var _loc8_:Tile = null;
         var _loc9_:Boolean = false;
         var _loc10_:Tile = null;
         var _loc11_:Boolean = false;
         var _loc12_:Tile = null;
         var _loc13_:Boolean = false;
         var _loc14_:Tile = null;
         var _loc15_:Boolean = false;
         var _loc16_:Tile = null;
         var _loc17_:Boolean = false;
         var _loc18_:Tile = null;
         var _loc19_:Boolean = false;
         if(param2 == AnimeConstants.ASSET_TYPE_BG)
         {
            _loc6_ = this._assetTheme == USER_THEME ? this._uiTileBgUser : this._uiTileBgCommunity;
            if(_loc7_ = this._assetTheme == USER_THEME ? Boolean(UserStuffManager.instance.hasMoreUserBg) : Boolean(CommunityStuffManager.instance.hasMoreCommunityBg))
            {
               _loc4_ = (_loc4_ = int((_loc6_.numChildren - 1) / 2)) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc6_.verticalScrollPosition / _loc6_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc6_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc6_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  if(this.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     CommunityStuffManager.instance.loadStuff(param2);
                  }
                  else
                  {
                     UserStuffManager.instance.loadStuff(param2);
                  }
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_TEMPLATE)
         {
            _loc8_ = this._uiTileTemplateMovie;
            if(_loc9_ = UserStuffManager.instance.hasMoreUserTemplate)
            {
               _loc4_ = (_loc4_ = int((_loc8_.numChildren - 1) / 2)) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc8_.verticalScrollPosition / _loc8_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc8_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc8_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  UserStuffManager.instance.loadUserTemplate();
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
         {
            _loc10_ = this._uiTileVideoPropUser;
            if(_loc11_ = UserStuffManager.instance.hasMoreUserVideoProp)
            {
               _loc4_ = (_loc4_ = int((_loc10_.numChildren - 1) / 2)) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc10_.verticalScrollPosition / _loc10_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc10_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc10_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  if(this.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     CommunityStuffManager.instance.loadStuff(param2);
                  }
                  else
                  {
                     UserStuffManager.instance.loadStuff(param2);
                  }
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_PROP)
         {
            _loc12_ = this._assetTheme == USER_THEME ? this._uiTilePropUser : this._uiTilePropCommunity;
            if(_loc13_ = this._assetTheme == USER_THEME ? Boolean(UserStuffManager.instance.hasMoreUserProp) : Boolean(CommunityStuffManager.instance.hasMoreCommunityProp))
            {
               _loc4_ = (_loc4_ = int((_loc12_.numChildren - 1) / 4)) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc12_.verticalScrollPosition / _loc12_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc12_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc12_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  if(this.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     CommunityStuffManager.instance.loadStuff(param2);
                  }
                  else
                  {
                     UserStuffManager.instance.loadStuff(param2);
                  }
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_CHAR)
         {
            _loc14_ = this._assetTheme == USER_THEME ? this._uiTileCharUser : this._uiTileCharCommunity;
            if(_loc15_ = this._assetTheme == USER_THEME ? Boolean(UserStuffManager.instance.hasMoreUserChar) : Boolean(CommunityStuffManager.instance.hasMoreCommunityChar))
            {
               _loc4_ = (_loc4_ = int((_loc14_.numChildren - 1) / 4)) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc14_.verticalScrollPosition / _loc14_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc14_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc14_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  if(this.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     CommunityStuffManager.instance.loadStuff(param2);
                  }
                  else
                  {
                     UserStuffManager.instance.loadStuff(param2);
                  }
               }
            }
         }
         else if(param2 == AnimeConstants.ASSET_TYPE_FX)
         {
            _loc16_ = this._assetTheme == USER_THEME ? this._uiTileEffectUser : this._uiTileEffectCommunity;
            if(_loc17_ = this._assetTheme == USER_THEME ? Boolean(UserStuffManager.instance.hasMoreUserEffect) : Boolean(CommunityStuffManager.instance.hasMoreCommunityEffect))
            {
               _loc4_ = (_loc4_ = int((_loc16_.numChildren - 1) / 4)) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc16_.verticalScrollPosition / _loc16_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc16_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc16_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  if(this.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     CommunityStuffManager.instance.loadStuff(param2);
                  }
                  else
                  {
                     UserStuffManager.instance.loadStuff(param2);
                  }
               }
            }
         }
         else
         {
            if(this._assetTheme == USER_THEME)
            {
               if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  _loc18_ = this._userTileSoundMusicThemes;
                  _loc19_ = UserStuffManager.instance.hasMoreUserSoundMusic;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  _loc18_ = this._userTileSoundEffectThemes;
                  _loc19_ = UserStuffManager.instance.hasMoreUserSoundEffect;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  _loc18_ = this._userTileSoundVoiceThemes;
                  _loc19_ = UserStuffManager.instance.hasMoreUserSoundTTS;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  _loc18_ = this._userTileSoundVoiceThemes;
                  _loc19_ = UserStuffManager.instance.hasMoreUserSoundVoice;
               }
            }
            else if(this._assetTheme == COMMUNITY_THEME)
            {
               if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC)
               {
                  _loc19_ = CommunityStuffManager.instance.hasMoreCommunitySoundMusic;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT)
               {
                  _loc19_ = CommunityStuffManager.instance.hasMoreCommunitySoundEffect;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TTS)
               {
                  _loc19_ = CommunityStuffManager.instance.hasMoreCommunitySoundTTS;
               }
               else if(param2 == AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER)
               {
                  _loc19_ = CommunityStuffManager.instance.hasMoreCommunitySoundVoice;
               }
            }
            if(_loc19_)
            {
               _loc4_ = (_loc4_ = int((_loc18_.numChildren - 1) / 4)) + 1;
               _loc5_ = 1 - 1 / _loc4_;
               if(_loc18_.verticalScrollPosition / _loc18_.maxVerticalScrollPosition >= _loc5_ && !this._gettingAssets)
               {
                  _loc3_ = Canvas(_loc18_.getChildByName("helperCanvas"));
                  if(_loc3_ != null)
                  {
                     _loc18_.removeChild(_loc3_);
                  }
                  this._gettingAssets = true;
                  if(this.assetTheme == ThumbTray.COMMUNITY_THEME)
                  {
                     CommunityStuffManager.instance.loadStuff(param2);
                  }
                  else
                  {
                     UserStuffManager.instance.loadStuff(param2);
                  }
               }
            }
         }
      }
      
      public function disallowUploadedAssets() : void
      {
      }
      
      private function onShowPropTray() : void
      {
         var _loc2_:Text = null;
         var _loc1_:Boolean = true;
         if(Console.getConsole().siteId != "0")
         {
            _loc1_ = false;
         }
         if(Console.getConsole().isThemeCcRelated(this.getCurrentThemeId()))
         {
            _loc1_ = false;
         }
         if(this.getCurrentThemeId() == "business")
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            this._uiTilePropHeadThemes.tileWidth = AnimeConstants.TILE_PROP_WIDTH;
            this._uiTilePropHeadThemes.tileHeight = AnimeConstants.TILE_PROP_HEIGHT;
         }
         else
         {
            _loc2_ = new Text();
            _loc2_.text = UtilDict.toDisplay("go","thumbtray_headswapwarn");
            _loc2_.selectable = false;
            _loc2_.width = 250;
            _loc2_.horizontalCenter = 0;
            _loc2_.setStyle("textAlign","left");
            _loc2_.setStyle("color","0xcccccc");
            _loc2_.setStyle("fontSize","13");
            this._uiTilePropHeadThemes.removeAllChildren();
            this._uiTilePropHeadThemes.tileWidth = 306;
            this._uiTilePropHeadThemes.tileHeight = 100;
            if(this._assetTheme == COMMON_THEME)
            {
               this._uiTilePropHeadThemes.addChild(_loc2_);
            }
         }
      }
      
      private function onShowSceneTray() : void
      {
      }
      
      private function initClientThemeBanner(param1:Event) : void
      {
      }
      
      public function initThemeChosenById(param1:String) : void
      {
         this._uiThemeButtonBar.selectedIndex = 0;
         this._themeSelection.setThemeById(param1);
         this.doSwitchTheme(param1,AnimeConstants.ASSET_TYPE_CHAR);
      }
      
      private function onThemeChosen(param1:ThemeChosenEvent) : void
      {
         if(param1.themeId == "search")
         {
            this.showSearchPanel();
         }
         else
         {
            this.doSwitchTheme(param1.themeId,param1.assetType);
         }
      }
      
      private function showSearchPanel() : void
      {
         this.backToThemeBtn.label = "< " + StringUtil.substitute(UtilDict.toDisplay("go","Back to {0}"),ThemeManager.instance.getThemeLabel(this._oldThemeId));
         this.themeIcon.themeId = this._oldThemeId;
         Console.getConsole().loadAllThemes();
         this.VSThumbTray.selectedChild = this.searchPanel;
      }
      
      private function showWarningOnSwitchTheme(param1:String) : void
      {
      }
      
      public function doSwitchTheme(param1:String, param2:String = null) : void
      {
         var targetAssetType:String = null;
         var showHandProp:Boolean = false;
         var showHeadProp:Boolean = false;
         var showWearProp:Boolean = false;
         var showPublicTemplate:Boolean = false;
         var popup:IFlexDisplayObject = null;
         var helper:UtilLazyHelper = null;
         var model:Array = null;
         var tmNS:Namespace = null;
         var key:String = null;
         var acItem:XML = null;
         var themeId:String = param1;
         var productType:String = param2;
         this._switchTheme = true;
         this.setIsCurrentThemeShouldLoadChar(false);
         showHandProp = true;
         showHeadProp = true;
         showWearProp = true;
         showPublicTemplate = false;
         if(themeId == MOVIE_THEME)
         {
            this.VSThumbTray.selectedChild = this._uiCanvasMovie;
            targetAssetType = AnimeConstants.ASSET_TYPE_CHAR;
            if(productType != null)
            {
               targetAssetType = productType;
            }
            this.doNotListenToMovieTileChange();
            this.addEventListener(CoreEvent.SWITCH_TO_USER_THEME_COMPLETE,this.doStartListenToMovieTileChange);
            this.gotoSpecifiedTabInMovieGoodies(targetAssetType);
            this.switchTheme(MOVIE_THEME);
         }
         else if(themeId == "User")
         {
            this.VSThumbTray.selectedChild = this._uiCanvasUser;
            targetAssetType = AnimeConstants.ASSET_TYPE_SOUND;
            if(productType != null)
            {
               targetAssetType = productType;
               this.doNotListenToUserTileChange();
               this.addEventListener(CoreEvent.SWITCH_TO_USER_THEME_COMPLETE,this.doStartListenToUserTileChange);
               if(UtilUser.userType == UtilUser.BASIC_USER && productType == AnimeConstants.ASSET_TYPE_CHAR)
               {
                  targetAssetType = AnimeConstants.ASSET_TYPE_SOUND;
               }
            }
            this.gotoSpecifiedTabInMyGoodies(targetAssetType);
            if(targetAssetType == AnimeConstants.ASSET_TYPE_TEMPLATE)
            {
               this.assetTheme = USER_THEME;
               this._userAssetType = AnimeConstants.ASSET_TYPE_TEMPLATE;
               if(!this._userTemplateReady)
               {
                  UserStuffManager.instance.addEventListener(CoreEvent.LOAD_USER_ASSET_COMPLETE,this.doDispatchSwitchCompleteEvent);
                  UserStuffManager.instance.loadUserTemplate();
               }
               else
               {
                  this.doDispatchSwitchCompleteEvent(null);
               }
            }
            else
            {
               this.switchTheme(USER_THEME,targetAssetType);
            }
         }
         else if(themeId == "Comm")
         {
            popup = PopUpManager.createPopUp(FlexGlobals.topLevelApplication as DisplayObject,CommunityStuffWarning,true);
            PopUpManager.centerPopUp(popup);
            this.VSThumbTray.selectedChild = this._uiCanvasCommunity;
            if(productType != null)
            {
               this.doNotListenToCommunityTileChange();
               this.addEventListener(CoreEvent.SWITCH_TO_COMMUNITY_THEME_COMPLETE,this.doStartListenToCommunityTileChange);
               this.gotoSpecifiedTabInCommunityGoodies(productType);
            }
            this.switchTheme(COMMUNITY_THEME);
         }
         else if(Console.getConsole().isThemeCcRelated(themeId))
         {
            this.showWarningOnSwitchTheme(themeId);
            this._oldThemeId = themeId;
            this.assetTheme = COMMON_THEME;
            this.clearTheme();
            this.VSThumbTray.selectedChild = this._uiCanvasTheme;
            if(productType != null)
            {
               this._uiNavigatorThemes.removeEventListener(Event.CHANGE,this.onCommonAssetTileChange);
               switch(productType)
               {
                  case AnimeConstants.ASSET_TYPE_CHAR:
                     for(key in this._lazyHelpers)
                     {
                        helper = this._lazyHelpers[key];
                        helper.clear();
                        helper.removeEventListener(LazyHelperEvent.SCROLLED_TO_THE_END,this.doLazyLoadCharThumbs);
                        helper.removeEventListener(LazyHelperEvent.CONTAINER_BEING_FIRST_SHOWN,this.doLazyLoadCharThumbs);
                        delete this._lazyHelpers[key];
                     }
                     model = [];
                     tmNS = XML(this._ccThemeModel).namespace("tm");
                     for each(acItem in this._ccThemeModel.tmNS::theme.(@id == themeId).tmNS::accordian)
                     {
                        model.push(new ObjectProxy({
                           "id":String(acItem.@id),
                           "label":String(acItem.@label),
                           "state":(String(acItem.@addCharButton) == "Y" ? "" : "makeCharButtonHidden")
                        }));
                     }
                     if(FeatureManager.shouldTemplateCharacterBeShown)
                     {
                        this.templateCharacterRepeater.dataProvider = model;
                     }
                     this._uiNavigatorThemes.selectedChild = this._uiCharThemeViewStack;
                     this._uiCharThemeViewStack.selectedChild = this._uiCharThemeAccordion;
                     break;
                  case AnimeConstants.ASSET_TYPE_BUBBLE:
                     this._uiNavigatorThemes.selectedChild = this._uiTileBubbleThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_BG:
                     this._uiNavigatorThemes.selectedChild = this._uiTileBgThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_PROP:
                     this._uiNavigatorThemes.selectedChild = this.goPropPanel;
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND:
                     this._uiNavigatorThemes.selectedChild = this._uiSoundThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_FX:
                     this._uiNavigatorThemes.selectedChild = this._uiTileEffectThemes;
               }
               callLater(this.addNavChangeListener);
            }
            this.switchTheme(COMMON_THEME);
            this.loadCcTheme(themeId);
            this.createCcButtonVisible = themeId == ThemeConstants.COMEDY_WORLD_THEME_ID || themeId == ThemeConstants.LIL_PEEPZ_THEME_ID || themeId == ThemeConstants.CHIBI_THEME_ID || themeId == ThemeConstants.NINJA_THEME_ID || themeId == ThemeConstants.BUSINESS_THEME_ID || themeId == ThemeConstants.NINJAANIME_THEME_ID || themeId == ThemeConstants.ANIME_THEME_ID;
            if(UtilUser.isTrialAccount)
            {
               this.createCcButtonVisible = false;
            }
            showHeadProp = false;
            showWearProp = false;
         }
         else
         {
            this.showWarningOnSwitchTheme(themeId);
            this._oldThemeId = themeId;
            this.assetTheme = COMMON_THEME;
            this.clearTheme();
            this.VSThumbTray.selectedChild = this._uiCanvasTheme;
            if(productType != null)
            {
               this._uiNavigatorThemes.removeEventListener(Event.CHANGE,this.onCommonAssetTileChange);
               switch(productType)
               {
                  case AnimeConstants.ASSET_TYPE_CHAR:
                     this._uiNavigatorThemes.selectedChild = this._uiCharThemeViewStack;
                     this._uiCharThemeViewStack.selectedChild = this._uiTileCharThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_BUBBLE:
                     this._uiNavigatorThemes.selectedChild = this._uiTileBubbleThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_BG:
                     this._uiNavigatorThemes.selectedChild = this._uiTileBgThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_PROP:
                     this._uiNavigatorThemes.selectedChild = this.goPropPanel;
                     break;
                  case AnimeConstants.ASSET_TYPE_SOUND:
                     this._uiNavigatorThemes.selectedChild = this._uiSoundThemes;
                     break;
                  case AnimeConstants.ASSET_TYPE_FX:
                     this._uiNavigatorThemes.selectedChild = this._uiTileEffectThemes;
               }
               callLater(this.addNavChangeListener);
            }
            Console.getConsole().loadTheme(themeId);
         }
         if(UtilLicense.getCurrentLicenseId() == "8")
         {
            if(themeId == "toonadv")
            {
               this.showBackgroundTab();
            }
            else
            {
               this.hideBackgroundTab();
            }
         }
         if(themeId == ThemeConstants.POLITIC_2_THEME_ID || themeId == ThemeConstants.BUSINESS_THEME_ID || themeId == ThemeConstants.STICKLY_BIZ_THEME_ID || themeId == ThemeConstants.SPACE_CITIZEN_THEME_ID || themeId == ThemeConstants.BIZ_MODEL_THEME_ID)
         {
            showHeadProp = false;
            showWearProp = false;
         }
         if(!UtilLicense.isHeadSectionShouldBeShownInThumbtray(UtilLicense.getCurrentLicenseId()))
         {
            showHeadProp = false;
         }
         if(!UtilLicense.isHeadGearSectionShouldBeShownInThumbtray(UtilLicense.getCurrentLicenseId()))
         {
            showWearProp = false;
         }
         if(!UtilLicense.isHandGearSectionShouldBeShownInThumbtray(UtilLicense.getCurrentLicenseId()))
         {
            showHandProp = false;
         }
         if(themeId == ThemeConstants.BUSINESS_THEME_ID || themeId == ThemeConstants.STICKLY_BIZ_THEME_ID || themeId == ThemeConstants.BIZ_MODEL_THEME_ID)
         {
            showHandProp = false;
         }
         if(themeId == ThemeConstants.BUSINESS_THEME_ID)
         {
            showPublicTemplate = true;
         }
         if(showHandProp)
         {
            if(!this._uiPropThemes.contains(this._uiTilePropHandHeldThemes))
            {
               this._uiPropThemes.addChildAt(this._uiTilePropHandHeldThemes,1);
            }
         }
         else if(this._uiPropThemes.contains(this._uiTilePropHandHeldThemes))
         {
            this._uiPropThemes.removeChild(this._uiTilePropHandHeldThemes);
         }
         if(showWearProp)
         {
            if(!this._uiPropThemes.contains(this._uiTilePropMaskThemes))
            {
               this._uiPropThemes.addChildAt(this._uiTilePropMaskThemes,1);
            }
         }
         else if(this._uiPropThemes.contains(this._uiTilePropMaskThemes))
         {
            this._uiPropThemes.removeChild(this._uiTilePropMaskThemes);
         }
         if(showHeadProp)
         {
            if(!this._uiPropThemes.contains(this._uiTilePropHeadThemes))
            {
               this._uiPropThemes.addChildAt(this._uiTilePropHeadThemes,1);
            }
         }
         else if(this._uiPropThemes.contains(this._uiTilePropHeadThemes))
         {
            this._uiPropThemes.removeChild(this._uiTilePropHeadThemes);
         }
         if(showPublicTemplate)
         {
            if(!this._uiBgThemes.contains(this._uiTileTemplateThemes))
            {
               this._uiBgThemes.addChildAt(this._uiTileTemplateThemes,1);
            }
         }
         else if(this._uiBgThemes.contains(this._uiTileTemplateThemes))
         {
            this._uiBgThemes.removeChild(this._uiTileTemplateThemes);
         }
      }
      
      private function showBackgroundTab() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = this._uiNavigatorThemes.getChildIndex(this._uiTileBgThemes);
         this._uiNavigatorThemes.getTabAt(_loc1_).alpha = 1;
         this._uiNavigatorThemes.getTabAt(_loc1_).percentWidth = 1;
         this._uiTileBgThemes.enabled = true;
      }
      
      private function hideBackgroundTab() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = this._uiNavigatorThemes.getChildIndex(this._uiTileBgThemes);
         this._uiNavigatorThemes.getTabAt(_loc1_).alpha = 0;
         this._uiNavigatorThemes.getTabAt(_loc1_).width = 0;
         this._uiTileBgThemes.enabled = false;
      }
      
      private function addNavChangeListener() : void
      {
         this._uiNavigatorThemes.addEventListener(Event.CHANGE,this.onCommonAssetTileChange);
         this._uiNavigatorCommunity.addEventListener(Event.CHANGE,this.onCommunityTileChange);
      }
      
      private function doNotListenToCommunityTileChange() : void
      {
         this._uiNavigatorCommunity.removeEventListener(Event.CHANGE,this.onCommunityTileChange);
      }
      
      private function doStartListenToCommunityTileChange(param1:Event) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doStartListenToCommunityTileChange);
         }
         this.doNotListenToCommunityTileChange();
         this._uiNavigatorCommunity.addEventListener(Event.CHANGE,this.onCommunityTileChange);
      }
      
      private function onMyCharButtonClick() : void
      {
         this.doSwitchTheme(THEME_ID_CUSTOM_WORLD,AnimeConstants.ASSET_TYPE_CHAR);
      }
      
      private function getAccordianPart(param1:String) : Container
      {
         return Container(this._uiCharThemeAccordion.getChildByName(param1));
      }
      
      private function get _uiTileCharCelebrities() : Container
      {
         return this.getAccordianPart("_uiTileCharCelebrities");
      }
      
      private function get _uiTileCharProfessions() : Container
      {
         return this.getAccordianPart("_uiTileCharProfessions");
      }
      
      private function postInitCharButton(param1:FlexEvent) : void
      {
         var _loc2_:Object = null;
         _loc2_ = (param1.currentTarget as UIComponent).getRepeaterItem();
         if(_loc2_.state != "")
         {
            UIComponent(param1.currentTarget).visible = false;
         }
      }
      
      private function onTribeOfNoiseBtnClick() : void
      {
         try
         {
            UtilNavigate.toTribeOfNoisePage();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onBgAccordionChange(param1:Event) : void
      {
         Console.getConsole().dispatchEvent(new TutorialEvent(TutorialEvent.BG_ACC_SWITCHED));
      }
      
      private function onPropAccordionChange(param1:Event) : void
      {
         if(Container(this._uiPropThemes.selectedChild).numChildren == 0 && this._uiPropThemes.selectedChild is Tile)
         {
            this.loadPropThumbs(ThemeManager.instance.currentTheme,new UtilLoadMgr(),Tile(this._uiPropThemes.selectedChild));
            if(UtilLicense.isCommonPropShouldBeShown(ThemeManager.instance.currentTheme.id))
            {
               this.loadPropThumbs(ThemeManager.instance.getTheme("common"),new UtilLoadMgr(),Tile(this._uiPropThemes.selectedChild));
            }
         }
      }
      
      private function onMoviePropAccordionChange(param1:Event) : void
      {
         if(Container(this._uiPropMovie.selectedChild).numChildren == 0)
         {
            this.loadPropThumbs(ThemeManager.instance.movieTheme,new UtilLoadMgr());
         }
      }
      
      private function onMovieSceneAccordionChange(param1:Event = null) : void
      {
         this.onUserAssetTileChange(param1);
      }
      
      public function addThumbToMovieTray(param1:Thumb) : void
      {
         var _loc2_:Tile = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:IProductThumb = null;
         if(param1 is CharThumb)
         {
            _loc2_ = this._uiTileCharMovie;
         }
         else if(param1 is PropThumb)
         {
            if(PropThumb(param1).holdable)
            {
               _loc2_ = this._uiTilePropHandHeldMovie;
            }
            else if(PropThumb(param1).wearable)
            {
               _loc2_ = this._uiTilePropMaskMovie;
            }
            else if(PropThumb(param1).headable)
            {
               _loc2_ = this._uiTilePropHeadMovie;
            }
            else
            {
               _loc2_ = this._uiTilePropOtherMovie;
            }
         }
         else if(param1 is BackgroundThumb)
         {
            _loc2_ = this._uiTileBgMovie;
         }
         else if(param1 is EffectThumb)
         {
            _loc2_ = this._uiTileEffectMovie;
         }
         else if(param1 is SoundThumb)
         {
            switch(SoundThumb(param1).subType)
            {
               case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC:
               case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TRIBE_OF_NOISE:
                  break;
               case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT:
                  break;
               case AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER:
            }
         }
         if(_loc2_)
         {
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.numChildren)
            {
               if((_loc5_ = _loc2_.getChildAt(_loc4_) as IProductThumb).product.id == param1.id)
               {
                  _loc3_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc3_ && this.movieAssetsReady)
            {
               if(param1 is CharThumb)
               {
                  this.addCharThumbToTheme(0,param1,new UtilLoadMgr(),_loc2_);
               }
               else if(param1 is PropThumb)
               {
                  this.addPropThumbToTheme(0,param1,new UtilLoadMgr(),_loc2_);
               }
               else if(param1 is BackgroundThumb)
               {
                  this.addBackgroundThumbToTheme(0,param1,new UtilLoadMgr(),_loc2_);
               }
               else if(param1 is EffectThumb)
               {
                  this.addEffectThumbToTheme(0,param1 as EffectThumb,new UtilLoadMgr(),_loc2_);
               }
               else if(param1 is SoundThumb)
               {
               }
            }
         }
      }
      
      private function drawNoticeBg() : void
      {
         this._tipsSceneSet.graphics.clear();
         this._tipsSceneSet.graphics.beginFill(7904704);
         this._tipsSceneSet.graphics.drawRoundRect(0,0,this._tipsSceneSet.width,this._tipsSceneSet.height,10,10);
         this._tipsSceneSet.graphics.endFill();
         this._tipsArrow.graphics.clear();
         this._tipsArrow.graphics.beginFill(16777215);
         UtilDraw.drawPoly(this._tipsArrow,0,0,3,5);
         this._tipsArrow.graphics.endFill();
      }
      
      private function onClickOpenSceneSet() : void
      {
         Console.getConsole().showOverTray(true,Console.getConsole().currentScene);
      }
      
      private function onTextInputClick() : void
      {
         if(this.txtKey.text == UtilDict.toDisplay("go","Enter a keyword here"))
         {
            this.txtKey.text = "";
            this.txtKey.setStyle("color","0x000000");
         }
      }
      
      private function onTextInputFocusOut() : void
      {
         if(this.txtKey.text == "")
         {
            this.txtKey.text = UtilDict.toDisplay("go","Enter a keyword here");
            this.txtKey.setStyle("color","0x999999");
         }
      }
      
      private function onSearchBtnClick() : void
      {
         if(StringUtil.trim(this.txtKey.text) != "" && StringUtil.trim(this.txtKey.text) != UtilDict.toDisplay("go","Enter a keyword here"))
         {
            this._themeSelection.setThemeById("search");
            this.showSearchPanel();
            this.productSearchPanel.searchProduct(this.txtKey.text,this.themeId);
         }
      }
      
      private function onBackToThemeBtnClick() : void
      {
         if(this._oldThemeId)
         {
            this._themeSelection.setThemeById(this._oldThemeId);
            this.VSThumbTray.selectedChild = this._uiCanvasTheme;
         }
      }
      
      private function onShowTemplate() : void
      {
         if(this._uiTileTemplateThemes.numChildren == 0)
         {
            CommunityStuffManager.instance.loadPublicTemplate();
         }
         Console.getConsole().onShowTemplate();
      }
      
      public function showTrayLoading(param1:Boolean = false) : void
      {
         if(param1)
         {
            this._loading.visible = true;
         }
         else
         {
            this._loading.visible = false;
         }
         this._loading.mouseEnabled = false;
      }
      
      protected function onCharThemeAccordionChange(param1:IndexChangedEvent) : void
      {
         if(this._uiCharThemeAccordion.selectedChild != this._uiTileCharYourChar)
         {
            if(this._uiCharThemeAccordion.selectedChild is DisplayObjectContainer && (this._uiCharThemeAccordion.selectedChild as DisplayObjectContainer).numChildren <= 1)
            {
               this.loadCharThumbs(ThemeManager.instance.currentTheme,new UtilLoadMgr());
            }
         }
      }
      
      private function _ThumbTray_XML1_i() : XML
      {
         var _loc1_:XML = null;
         _loc1_ = <tm:themes xmlns:tm="http://goanimate.com/ns/theme/model"><tm:theme id="ben10" xmlns:tm="http://goanimate.com/ns/theme/model"><tm:asset id="highbreed" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="forever_knight" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="brainstorm" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="spidermonkey" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="bigchill" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset></tm:theme><tm:theme id="chowder" xmlns:tm="http://goanimate.com/ns/theme/model"><tm:asset id="endive" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="gazpacho" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="truffles" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset></tm:theme><tm:theme id="custom" xmlns:tm="http://goanimate.com/ns/theme/model"><tm:accordian id="_uiTileCharProfessions" addCharButton="Y" label="Professions" containsCCTemplates="Y" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:accordian><tm:accordian id="_uiTileCharCelebrities" addCharButton="Y" label="Celebrities" containsCCTemplates="Y" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:accordian></tm:theme><tm:theme id="action" xmlns:tm="http://goanimate.com/ns/theme/model"><tm:accordian id="_uiTileCharProfessions" addCharButton="Y" label="One-Click Characters" containsCCTemplates="Y" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:accordian></tm:theme><tm:theme id="toonadv" xmlns:tm="http://goanimate.com/ns/theme/model"><tm:accordian id="_uiTileCharRegularChars" addCharButton="N" label="Heroes and Villains" containsCCTemplates="N" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:accordian><tm:asset id="mojojojo" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="blossom" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="bubble" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="buttercup" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="cbg_sydney" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="elephant_ride.swf" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="command_module.swf" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="cbg_malaysia" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="cbg_space" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="cbg_evil_lair" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset><tm:asset id="weight.swf" lockType="special" xmlns:tm="http://goanimate.com/ns/theme/model"></tm:asset></tm:theme></tm:themes>;
         this._ccThemeModel = _loc1_;
         BindingManager.executeBindings(this,"_ccThemeModel",this._ccThemeModel);
         return _loc1_;
      }
      
      private function _ThumbTray_Move1_i() : Move
      {
         var _loc1_:Move = null;
         _loc1_ = new Move();
         _loc1_.duration = 500;
         this._effectMove = _loc1_;
         BindingManager.executeBindings(this,"_effectMove",this._effectMove);
         return _loc1_;
      }
      
      private function _ThumbTray_Resize1_i() : Resize
      {
         var _loc1_:Resize = null;
         _loc1_ = new Resize();
         _loc1_.duration = 500;
         this._effectResize = _loc1_;
         BindingManager.executeBindings(this,"_effectResize",this._effectResize);
         return _loc1_;
      }
      
      private function _ThumbTray_State1_c() : State
      {
         var _loc1_:State = null;
         _loc1_ = new State();
         _loc1_.name = "simple";
         _loc1_.overrides = [this._ThumbTray_RemoveChild1_i(),this._ThumbTray_RemoveChild2_i()];
         return _loc1_;
      }
      
      private function _ThumbTray_RemoveChild1_i() : RemoveChild
      {
         var _loc1_:RemoveChild = null;
         _loc1_ = new RemoveChild();
         this._ThumbTray_RemoveChild1 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_RemoveChild1",this._ThumbTray_RemoveChild1);
         return _loc1_;
      }
      
      private function _ThumbTray_RemoveChild2_i() : RemoveChild
      {
         var _loc1_:RemoveChild = null;
         _loc1_ = new RemoveChild();
         this._ThumbTray_RemoveChild2 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_RemoveChild2",this._ThumbTray_RemoveChild2);
         return _loc1_;
      }
      
      private function _ThumbTray_State2_c() : State
      {
         var _loc1_:State = null;
         _loc1_ = new State();
         _loc1_.name = "domo";
         _loc1_.basedOn = "simple";
         return _loc1_;
      }
      
      private function _ThumbTray_State3_c() : State
      {
         var _loc1_:State = null;
         _loc1_ = new State();
         _loc1_.name = "cn";
         _loc1_.basedOn = "simple";
         return _loc1_;
      }
      
      private function _ThumbTray_State4_c() : State
      {
         var _loc1_:State = null;
         _loc1_ = new State();
         _loc1_.name = "youtube";
         _loc1_.overrides = [this._ThumbTray_RemoveChild3_i()];
         return _loc1_;
      }
      
      private function _ThumbTray_RemoveChild3_i() : RemoveChild
      {
         var _loc1_:RemoveChild = null;
         _loc1_ = new RemoveChild();
         this._ThumbTray_RemoveChild3 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_RemoveChild3",this._ThumbTray_RemoveChild3);
         return _loc1_;
      }
      
      private function _ThumbTray_State5_c() : State
      {
         var _loc1_:State = null;
         _loc1_ = new State();
         _loc1_.name = "skoletube";
         _loc1_.overrides = [this._ThumbTray_RemoveChild4_i(),this._ThumbTray_RemoveChild5_i()];
         return _loc1_;
      }
      
      private function _ThumbTray_RemoveChild4_i() : RemoveChild
      {
         var _loc1_:RemoveChild = null;
         _loc1_ = new RemoveChild();
         this._ThumbTray_RemoveChild4 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_RemoveChild4",this._ThumbTray_RemoveChild4);
         return _loc1_;
      }
      
      private function _ThumbTray_RemoveChild5_i() : RemoveChild
      {
         var _loc1_:RemoveChild = null;
         _loc1_ = new RemoveChild();
         this._ThumbTray_RemoveChild5 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_RemoveChild5",this._ThumbTray_RemoveChild5);
         return _loc1_;
      }
      
      private function _ThumbTray_State6_c() : State
      {
         var _loc1_:State = null;
         _loc1_ = new State();
         _loc1_.name = "school";
         _loc1_.overrides = [this._ThumbTray_RemoveChild6_i()];
         return _loc1_;
      }
      
      private function _ThumbTray_RemoveChild6_i() : RemoveChild
      {
         var _loc1_:RemoveChild = null;
         _loc1_ = new RemoveChild();
         this._ThumbTray_RemoveChild6 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_RemoveChild6",this._ThumbTray_RemoveChild6);
         return _loc1_;
      }
      
      private function _ThumbTray_State7_c() : State
      {
         var _loc1_:State = null;
         _loc1_ = new State();
         _loc1_.name = "emessage";
         _loc1_.overrides = [this._ThumbTray_SetProperty1_i(),this._ThumbTray_SetProperty2_i()];
         return _loc1_;
      }
      
      private function _ThumbTray_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = null;
         _loc1_ = new SetProperty();
         _loc1_.name = "label";
         this._ThumbTray_SetProperty1 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_SetProperty1",this._ThumbTray_SetProperty1);
         return _loc1_;
      }
      
      private function _ThumbTray_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = null;
         _loc1_ = new SetProperty();
         _loc1_.name = "label";
         this._ThumbTray_SetProperty2 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_SetProperty2",this._ThumbTray_SetProperty2);
         return _loc1_;
      }
      
      private function _ThumbTray_State8_c() : State
      {
         var _loc1_:State = null;
         _loc1_ = new State();
         _loc1_.name = "business";
         _loc1_.overrides = [this._ThumbTray_RemoveChild7_i(),this._ThumbTray_RemoveChild8_i()];
         return _loc1_;
      }
      
      private function _ThumbTray_RemoveChild7_i() : RemoveChild
      {
         var _loc1_:RemoveChild = null;
         _loc1_ = new RemoveChild();
         this._ThumbTray_RemoveChild7 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_RemoveChild7",this._ThumbTray_RemoveChild7);
         return _loc1_;
      }
      
      private function _ThumbTray_RemoveChild8_i() : RemoveChild
      {
         var _loc1_:RemoveChild = null;
         _loc1_ = new RemoveChild();
         this._ThumbTray_RemoveChild8 = _loc1_;
         BindingManager.executeBindings(this,"_ThumbTray_RemoveChild8",this._ThumbTray_RemoveChild8);
         return _loc1_;
      }
      
      public function ___ThumbTray_Canvas1_preinitialize(param1:FlexEvent) : void
      {
         this.earlyInit();
      }
      
      public function ___ThumbTray_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initThumbTray();
      }
      
      public function __dc_click(param1:MouseEvent) : void
      {
         this.show();
      }
      
      public function __VSThumbTray_click(param1:MouseEvent) : void
      {
         this.show();
      }
      
      public function ___uiCharThemeAccordion_change(param1:IndexChangedEvent) : void
      {
         this.onCharThemeAccordionChange(param1);
      }
      
      public function ___ThumbTray_Button1_click(param1:MouseEvent) : void
      {
         Console.getConsole().goCreateCC();
      }
      
      public function ___ThumbTray_Button2_click(param1:MouseEvent) : void
      {
         Console.getConsole().goCreateCC();
      }
      
      public function ___ThumbTray_Canvas7_creationComplete(param1:FlexEvent) : void
      {
         this.postInitCharButton(param1);
      }
      
      public function ___ThumbTray_Button3_click(param1:MouseEvent) : void
      {
         Console.getConsole().goCreateCC();
      }
      
      public function ___uiBgThemes_change(param1:IndexChangedEvent) : void
      {
         this.onBgAccordionChange(param1);
      }
      
      public function ___uiTileTemplateThemes_show(param1:FlexEvent) : void
      {
         this.onShowTemplate();
      }
      
      public function __txtKey_click(param1:MouseEvent) : void
      {
         this.onTextInputClick();
      }
      
      public function __txtKey_focusOut(param1:FocusEvent) : void
      {
         this.onTextInputFocusOut();
      }
      
      public function __btnSearch_click(param1:MouseEvent) : void
      {
         this.onSearchBtnClick();
      }
      
      public function ___uiPropThemes_show(param1:FlexEvent) : void
      {
         this.onShowPropTray();
      }
      
      public function ___uiPropThemes_change(param1:IndexChangedEvent) : void
      {
         this.onPropAccordionChange(param1);
      }
      
      public function ___uiTileSoundMusicThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC);
      }
      
      public function ___uiTileSoundEffectsThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT);
      }
      
      public function ___uiTileSoundTribeThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_TRIBE_OF_NOISE);
      }
      
      public function ___ThumbTray_Button5_click(param1:MouseEvent) : void
      {
         this.onTribeOfNoiseBtnClick();
      }
      
      public function ___tipsSceneSet_creationComplete(param1:FlexEvent) : void
      {
         this.drawNoticeBg();
      }
      
      public function ___tipsSceneSet_click(param1:MouseEvent) : void
      {
         this.onClickOpenSceneSet();
      }
      
      public function ___uiTilePropUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTilePropUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTilePropUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"prop");
      }
      
      public function ___uiLabelPropUser_click(param1:MouseEvent) : void
      {
         this.onMouseEventHandler(param1);
      }
      
      public function ___uiSceneMovie_show(param1:FlexEvent) : void
      {
         this.onShowSceneTray();
      }
      
      public function ___uiSceneMovie_change(param1:IndexChangedEvent) : void
      {
         this.onMovieSceneAccordionChange(param1);
      }
      
      public function ___uiTileTemplateMovie_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"movie");
      }
      
      public function ___uiTileBgUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTileBgUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTileBgUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"bg");
      }
      
      public function ___uiLabelBgUser_click(param1:MouseEvent) : void
      {
         this.onMouseEventHandler(param1);
      }
      
      public function ___userTileSoundMusicThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_BG_MUSIC);
      }
      
      public function ___userTileSoundEffectThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_SOUND_EFFECT);
      }
      
      public function ___userTileSoundVoiceThemes_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_SOUND_SUBTYPE_VOICE_OVER);
      }
      
      public function ___userSoundNotUploadableNotice_render(param1:Event) : void
      {
         this.doUpdateSoundNonUploadableNotice(param1);
      }
      
      public function ___uiTileCharUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTileCharUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTileCharUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"char");
      }
      
      public function ___uiLabelCharUser_click(param1:MouseEvent) : void
      {
         this.onMouseEventHandler(param1);
      }
      
      public function ___uiTileEffectUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTileEffectUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTileEffectUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"effect");
      }
      
      public function ___uiTileVideoPropUser_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTileVideoPropUser_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.tileChangeHandler(param1);
      }
      
      public function ___uiTileVideoPropUser_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"video");
      }
      
      public function ___uiLabelVideoPropUser_click(param1:MouseEvent) : void
      {
         this.onMouseEventHandler(param1);
      }
      
      public function ___uiTilePropCommunity_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"prop");
      }
      
      public function ___uiTileBgCommunity_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"bg");
      }
      
      public function ___uiTileCharCommunity_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,AnimeConstants.ASSET_TYPE_CHAR);
      }
      
      public function ___uiTileEffectCommunity_scroll(param1:ScrollEvent) : void
      {
         this.scrollToGetAssets(param1,"effect");
      }
      
      public function ___uiBtnSearch_click(param1:MouseEvent) : void
      {
         this.searchAsset();
      }
      
      public function ___uiPopBtnSearch_click(param1:MouseEvent) : void
      {
         this.searchAsset();
      }
      
      public function ___uiPopBtnSearch_creationComplete(param1:FlexEvent) : void
      {
         this.initSearchTypeMenu();
      }
      
      public function ___uiTxtSearch_mouseDown(param1:MouseEvent) : void
      {
         this.onSearchFocusIn(param1);
      }
      
      public function ___uiTxtSearch_focusIn(param1:FocusEvent) : void
      {
         this.onSearchFocusIn(param1);
      }
      
      public function ___uiTxtSearch_focusOut(param1:FocusEvent) : void
      {
         this.onSearchFocusOut(param1);
      }
      
      public function ___uiTxtSearch_keyDown(param1:KeyboardEvent) : void
      {
         this.onInputFinish(param1);
      }
      
      public function ___uiPropMovie_show(param1:FlexEvent) : void
      {
         this.onShowPropTray();
      }
      
      public function ___uiPropMovie_change(param1:IndexChangedEvent) : void
      {
         this.onMoviePropAccordionChange(param1);
      }
      
      public function ___ThumbTray_HBox3_click(param1:MouseEvent) : void
      {
         this.onBackToThemeBtnClick();
      }
      
      public function __btnImport_click(param1:MouseEvent) : void
      {
         this.showImporterWindow();
      }
      
      public function ___themeSelection_theme_chosen(param1:ThemeChosenEvent) : void
      {
         this.onThemeChosen(param1);
      }
      
      public function ___ThumbTray_Canvas23_creationComplete(param1:FlexEvent) : void
      {
         this.initClientThemeBanner(param1);
      }
      
      private function _ThumbTray_bindingsSetup() : Array
      {
         var result:Array = null;
         result = [];
         result[0] = new Binding(this,function():Number
         {
            return TRAY_MAX_HEIGHT;
         },null,"_ThumbTray_VBox1.maxHeight");
         result[1] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },null,"_uiTileCharThemes.tileWidth");
         result[2] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },null,"_uiTileCharThemes.tileHeight");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Your Characters");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTileCharYourChar.label");
         result[4] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },null,"btnCreateCc2.width");
         result[5] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },null,"btnCreateCc2.height");
         result[6] = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldCreateCcButtonBeShown;
         },null,"btnCreateCc2.visible");
         result[7] = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldCreateCcButtonBeShown;
         },null,"btnCreateCc2.includeInLayout");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Create New");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_ThumbTray_Button1.label");
         result[9] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },null,"_ThumbTray_Button1.width");
         result[10] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },null,"_ThumbTray_Button1.height");
         result[11] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },null,"btnCreateCc.height");
         result[12] = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldCreateCcButtonBeShown;
         },null,"btnCreateCc.visible");
         result[13] = new Binding(this,function():Boolean
         {
            return FeatureManager.shouldCreateCcButtonBeShown;
         },null,"btnCreateCc.includeInLayout");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = "+ " + UtilDict.toDisplay("go","Create New Characters");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_ThumbTray_Button2.label");
         result[15] = new RepeatableBinding(this,function(param1:Array, param2:Array):Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },function(param1:Number, param2:Array):void
         {
            _ThumbTray_Canvas7[param2[0]].height = param1;
         },"_ThumbTray_Canvas7.height");
         result[16] = new RepeatableBinding(this,function(param1:Array, param2:Array):Boolean
         {
            return FeatureManager.shouldCreateCcButtonBeShown;
         },function(param1:Boolean, param2:Array):void
         {
            _ThumbTray_Canvas7[param2[0]].visible = param1;
         },"_ThumbTray_Canvas7.visible");
         result[17] = new RepeatableBinding(this,function(param1:Array, param2:Array):Boolean
         {
            return FeatureManager.shouldCreateCcButtonBeShown;
         },function(param1:Boolean, param2:Array):void
         {
            _ThumbTray_Canvas7[param2[0]].includeInLayout = param1;
         },"_ThumbTray_Canvas7.includeInLayout");
         result[18] = new RepeatableBinding(this,function(param1:Array, param2:Array):String
         {
            var _loc3_:* = undefined;
            _loc3_ = "+ " + UtilDict.toDisplay("go","Create New Characters");
            return _loc3_ == undefined ? null : String(_loc3_);
         },function(param1:String, param2:Array):void
         {
            _ThumbTray_Button3[param2[0]].label = param1;
         },"_ThumbTray_Button3.label");
         result[19] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },null,"_uiTileBubbleThemes.tileWidth");
         result[20] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },null,"_uiTileBubbleThemes.tileHeight");
         result[21] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Backgrounds");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTileBgThemes.label");
         result[22] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },null,"_uiTileBgThemes.tileWidth");
         result[23] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },null,"_uiTileBgThemes.tileHeight");
         result[24] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Templates");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTileTemplateThemes.label");
         result[25] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },null,"_uiTileTemplateThemes.tileWidth");
         result[26] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },null,"_uiTileTemplateThemes.tileHeight");
         result[27] = new Binding(this,null,null,"_ThumbTray_Form1.defaultButton","btnSearch");
         result[28] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Enter a keyword here");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"txtKey.text");
         result[29] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_handheld");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTilePropHandHeldThemes.label");
         result[30] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_headgear");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTilePropMaskThemes.label");
         result[31] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_head");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTilePropHeadThemes.label");
         result[32] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_others");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTilePropOtherThemes.label");
         result[33] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_music");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTileSoundMusicThemes.label");
         result[34] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_meffect");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTileSoundEffectsThemes.label");
         result[35] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },null,"_uiTileEffectThemes.tileWidth");
         result[36] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },null,"_uiTileEffectThemes.tileHeight");
         result[37] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },null,"_tipsSceneSet.height");
         result[38] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","New!");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_ThumbTray_Label1.text");
         result[39] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Add transitions like fades, dissolves and more with \'Scene Settings\'");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_ThumbTray_Text1.text");
         result[40] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiLblTheme.text");
         result[41] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiLblUser.text");
         result[42] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_PROP_WIDTH;
         },null,"_uiTilePropUser.tileWidth");
         result[43] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_PROP_HEIGHT;
         },null,"_uiTilePropUser.tileHeight");
         result[44] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Click here to upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiLabelPropUser.text");
         result[45] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Templates");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTileTemplateMovie.label");
         result[46] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },null,"_uiTileTemplateMovie.tileWidth");
         result[47] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },null,"_uiTileTemplateMovie.tileHeight");
         result[48] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Backgrounds");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiCanvasBgUser.label");
         result[49] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },null,"_uiTileBgUser.tileWidth");
         result[50] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },null,"_uiTileBgUser.tileHeight");
         result[51] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Click here to upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiLabelBgUser.text");
         result[52] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_music");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_userTileSoundMusicThemes.label");
         result[53] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_meffect");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_userTileSoundEffectThemes.label");
         result[54] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_mvo");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_userTileSoundVoiceThemes.label");
         result[55] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go",AnimeConstants.SOUND_UPLOADABLE_MSG);
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_ThumbTray_Text3.text");
         result[56] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },null,"_uiTileCharUser.tileWidth");
         result[57] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },null,"_uiTileCharUser.tileHeight");
         result[58] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Click here to upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiLabelCharUser.text");
         result[59] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },null,"_uiTileEffectUser.tileWidth");
         result[60] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },null,"_uiTileEffectUser.tileHeight");
         result[61] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },null,"_uiTileVideoPropUser.tileWidth");
         result[62] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },null,"_uiTileVideoPropUser.tileHeight");
         result[63] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Click here to upload");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiLabelVideoPropUser.text");
         result[64] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_PROP_WIDTH;
         },null,"_uiTilePropCommunity.tileWidth");
         result[65] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_PROP_HEIGHT;
         },null,"_uiTilePropCommunity.tileHeight");
         result[66] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },null,"_uiTileBgCommunity.tileWidth");
         result[67] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },null,"_uiTileBgCommunity.tileHeight");
         result[68] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },null,"_uiTileCharCommunity.tileWidth");
         result[69] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },null,"_uiTileCharCommunity.tileHeight");
         result[70] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },null,"_uiTileEffectCommunity.tileWidth");
         result[71] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },null,"_uiTileEffectCommunity.tileHeight");
         result[72] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_search");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiBtnSearch.label");
         result[73] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Search");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiPopBtnSearch.label");
         result[74] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_dragtip");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiLblCommunity.text");
         result[75] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_WIDTH;
         },null,"_uiTileCharMovie.tileWidth");
         result[76] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_CHAR_HEIGHT;
         },null,"_uiTileCharMovie.tileHeight");
         result[77] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_WIDTH;
         },null,"_uiTileBgMovie.tileWidth");
         result[78] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BACKGROUND_HEIGHT;
         },null,"_uiTileBgMovie.tileHeight");
         result[79] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_handheld");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTilePropHandHeldMovie.label");
         result[80] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_headgear");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTilePropMaskMovie.label");
         result[81] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_head");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTilePropHeadMovie.label");
         result[82] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","thumbtray_others");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_uiTilePropOtherMovie.label");
         result[83] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_WIDTH;
         },null,"_uiTileEffectMovie.tileWidth");
         result[84] = new Binding(this,function():Number
         {
            return AnimeConstants.TILE_BUBBLE_HEIGHT;
         },null,"_uiTileEffectMovie.tileHeight");
         result[85] = new Binding(this,function():String
         {
            var _loc1_:* = undefined;
            _loc1_ = UtilDict.toDisplay("go","Import");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"btnImport.label");
         result[86] = new Binding(this,function():Object
         {
            return UtilLicense.getCurrentLicensorThumbtrayBannerStyleName();
         },null,"_ThumbTray_Canvas23.styleName");
         result[87] = new Binding(this,null,null,"_ThumbTray_RemoveChild1.target","btnImport");
         result[88] = new Binding(this,null,null,"_ThumbTray_RemoveChild2.target","_vbTribe");
         result[89] = new Binding(this,null,null,"_ThumbTray_RemoveChild3.target","_vbTribe");
         result[90] = new Binding(this,null,null,"_ThumbTray_RemoveChild4.target","_vbTribe");
         result[91] = new Binding(this,null,null,"_ThumbTray_RemoveChild5.target","_uiCanvasVideoPropUser");
         result[92] = new Binding(this,null,null,"_ThumbTray_RemoveChild6.target","_vbTribe");
         result[93] = new Binding(this,null,null,"_ThumbTray_SetProperty1.target","_uiCanvasUser");
         result[94] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("emessage","Your Heads");
         },null,"_ThumbTray_SetProperty1.value");
         result[95] = new Binding(this,null,null,"_ThumbTray_SetProperty2.target","_uiCanvasCommunity");
         result[96] = new Binding(this,function():*
         {
            return UtilDict.toDisplay("emessage","Community Heads");
         },null,"_ThumbTray_SetProperty2.value");
         result[97] = new Binding(this,null,null,"_ThumbTray_RemoveChild7.target","_uiTilePropHandHeldMovie");
         result[98] = new Binding(this,null,null,"_ThumbTray_RemoveChild8.target","_uiTilePropMaskMovie");
         result[99] = new Binding(this,null,null,"_effectMove.target","VSThumbTray");
         result[100] = new Binding(this,null,null,"_effectResize.target","pnlShadow");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get VSThumbTray() : ViewStack
      {
         return this._10971153VSThumbTray;
      }
      
      public function set VSThumbTray(param1:ViewStack) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._10971153VSThumbTray;
         if(_loc2_ !== param1)
         {
            this._10971153VSThumbTray = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"VSThumbTray",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ThumbTray_Accordion1() : Accordion
      {
         return this._1500074747_ThumbTray_Accordion1;
      }
      
      public function set _ThumbTray_Accordion1(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1500074747_ThumbTray_Accordion1;
         if(_loc2_ !== param1)
         {
            this._1500074747_ThumbTray_Accordion1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ThumbTray_Accordion1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _assetTrayBg() : Canvas
      {
         return this._658818924_assetTrayBg;
      }
      
      public function set _assetTrayBg(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._658818924_assetTrayBg;
         if(_loc2_ !== param1)
         {
            this._658818924_assetTrayBg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_assetTrayBg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ccThemeModel() : XML
      {
         return this._1487788737_ccThemeModel;
      }
      
      public function set _ccThemeModel(param1:XML) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1487788737_ccThemeModel;
         if(_loc2_ !== param1)
         {
            this._1487788737_ccThemeModel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ccThemeModel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectMove() : Move
      {
         return this._1491038559_effectMove;
      }
      
      public function set _effectMove(param1:Move) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1491038559_effectMove;
         if(_loc2_ !== param1)
         {
            this._1491038559_effectMove = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectMove",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _effectResize() : Resize
      {
         return this._1764850564_effectResize;
      }
      
      public function set _effectResize(param1:Resize) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1764850564_effectResize;
         if(_loc2_ !== param1)
         {
            this._1764850564_effectResize = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effectResize",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _loading() : Canvas
      {
         return this._1600092163_loading;
      }
      
      public function set _loading(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1600092163_loading;
         if(_loc2_ !== param1)
         {
            this._1600092163_loading = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_loading",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _themeSelection() : ThemeSelection
      {
         return this._1992358882_themeSelection;
      }
      
      public function set _themeSelection(param1:ThemeSelection) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1992358882_themeSelection;
         if(_loc2_ !== param1)
         {
            this._1992358882_themeSelection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_themeSelection",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tipsArrow() : Canvas
      {
         return this._1583312434_tipsArrow;
      }
      
      public function set _tipsArrow(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1583312434_tipsArrow;
         if(_loc2_ !== param1)
         {
            this._1583312434_tipsArrow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tipsArrow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tipsSceneSet() : Canvas
      {
         return this._1634482541_tipsSceneSet;
      }
      
      public function set _tipsSceneSet(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1634482541_tipsSceneSet;
         if(_loc2_ !== param1)
         {
            this._1634482541_tipsSceneSet = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tipsSceneSet",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiBgThemes() : Accordion
      {
         return this._1550854338_uiBgThemes;
      }
      
      public function set _uiBgThemes(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1550854338_uiBgThemes;
         if(_loc2_ !== param1)
         {
            this._1550854338_uiBgThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiBgThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiBtnSearch() : Button
      {
         return this._1282723535_uiBtnSearch;
      }
      
      public function set _uiBtnSearch(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1282723535_uiBtnSearch;
         if(_loc2_ !== param1)
         {
            this._1282723535_uiBtnSearch = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiBtnSearch",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasBgUser() : Canvas
      {
         return this._1174842373_uiCanvasBgUser;
      }
      
      public function set _uiCanvasBgUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1174842373_uiCanvasBgUser;
         if(_loc2_ !== param1)
         {
            this._1174842373_uiCanvasBgUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasBgUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasCharUser() : Canvas
      {
         return this._769621044_uiCanvasCharUser;
      }
      
      public function set _uiCanvasCharUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._769621044_uiCanvasCharUser;
         if(_loc2_ !== param1)
         {
            this._769621044_uiCanvasCharUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasCharUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasCommunity() : VBox
      {
         return this._1122273858_uiCanvasCommunity;
      }
      
      public function set _uiCanvasCommunity(param1:VBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1122273858_uiCanvasCommunity;
         if(_loc2_ !== param1)
         {
            this._1122273858_uiCanvasCommunity = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasCommunity",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasEffectUser() : Canvas
      {
         return this._71803449_uiCanvasEffectUser;
      }
      
      public function set _uiCanvasEffectUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._71803449_uiCanvasEffectUser;
         if(_loc2_ !== param1)
         {
            this._71803449_uiCanvasEffectUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasEffectUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasMovie() : Canvas
      {
         return this._304564347_uiCanvasMovie;
      }
      
      public function set _uiCanvasMovie(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._304564347_uiCanvasMovie;
         if(_loc2_ !== param1)
         {
            this._304564347_uiCanvasMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasPropUser() : Canvas
      {
         return this._1096140121_uiCanvasPropUser;
      }
      
      public function set _uiCanvasPropUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1096140121_uiCanvasPropUser;
         if(_loc2_ !== param1)
         {
            this._1096140121_uiCanvasPropUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasPropUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasTheme() : Canvas
      {
         return this._298324450_uiCanvasTheme;
      }
      
      public function set _uiCanvasTheme(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._298324450_uiCanvasTheme;
         if(_loc2_ !== param1)
         {
            this._298324450_uiCanvasTheme = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasTheme",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasUser() : Canvas
      {
         return this._425225002_uiCanvasUser;
      }
      
      public function set _uiCanvasUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._425225002_uiCanvasUser;
         if(_loc2_ !== param1)
         {
            this._425225002_uiCanvasUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasVideoPropUser() : Canvas
      {
         return this._121879230_uiCanvasVideoPropUser;
      }
      
      public function set _uiCanvasVideoPropUser(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._121879230_uiCanvasVideoPropUser;
         if(_loc2_ !== param1)
         {
            this._121879230_uiCanvasVideoPropUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasVideoPropUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCharMovieViewStack() : ViewStack
      {
         return this._167520028_uiCharMovieViewStack;
      }
      
      public function set _uiCharMovieViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._167520028_uiCharMovieViewStack;
         if(_loc2_ !== param1)
         {
            this._167520028_uiCharMovieViewStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCharMovieViewStack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCharThemeAccordion() : Accordion
      {
         return this._1939118856_uiCharThemeAccordion;
      }
      
      public function set _uiCharThemeAccordion(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1939118856_uiCharThemeAccordion;
         if(_loc2_ !== param1)
         {
            this._1939118856_uiCharThemeAccordion = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCharThemeAccordion",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCharThemeViewStack() : ViewStack
      {
         return this._2109846365_uiCharThemeViewStack;
      }
      
      public function set _uiCharThemeViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2109846365_uiCharThemeViewStack;
         if(_loc2_ !== param1)
         {
            this._2109846365_uiCharThemeViewStack = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCharThemeViewStack",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLabelBgUser() : Label
      {
         return this._1147366545_uiLabelBgUser;
      }
      
      public function set _uiLabelBgUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1147366545_uiLabelBgUser;
         if(_loc2_ !== param1)
         {
            this._1147366545_uiLabelBgUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLabelBgUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLabelCharUser() : Label
      {
         return this._1785122530_uiLabelCharUser;
      }
      
      public function set _uiLabelCharUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1785122530_uiLabelCharUser;
         if(_loc2_ !== param1)
         {
            this._1785122530_uiLabelCharUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLabelCharUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLabelPropUser() : Label
      {
         return this._644083601_uiLabelPropUser;
      }
      
      public function set _uiLabelPropUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._644083601_uiLabelPropUser;
         if(_loc2_ !== param1)
         {
            this._644083601_uiLabelPropUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLabelPropUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLabelVideoPropUser() : Label
      {
         return this._876679832_uiLabelVideoPropUser;
      }
      
      public function set _uiLabelVideoPropUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._876679832_uiLabelVideoPropUser;
         if(_loc2_ !== param1)
         {
            this._876679832_uiLabelVideoPropUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLabelVideoPropUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblCommunity() : Label
      {
         return this._586953306_uiLblCommunity;
      }
      
      public function set _uiLblCommunity(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._586953306_uiLblCommunity;
         if(_loc2_ !== param1)
         {
            this._586953306_uiLblCommunity = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblCommunity",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblResult() : Label
      {
         return this._991343744_uiLblResult;
      }
      
      public function set _uiLblResult(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._991343744_uiLblResult;
         if(_loc2_ !== param1)
         {
            this._991343744_uiLblResult = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblResult",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblTheme() : Label
      {
         return this._1969718778_uiLblTheme;
      }
      
      public function set _uiLblTheme(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1969718778_uiLblTheme;
         if(_loc2_ !== param1)
         {
            this._1969718778_uiLblTheme = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblTheme",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiLblUser() : Label
      {
         return this._1737616366_uiLblUser;
      }
      
      public function set _uiLblUser(param1:Label) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1737616366_uiLblUser;
         if(_loc2_ !== param1)
         {
            this._1737616366_uiLblUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiLblUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiMaskCanvas() : Canvas
      {
         return this._18631945_uiMaskCanvas;
      }
      
      public function set _uiMaskCanvas(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._18631945_uiMaskCanvas;
         if(_loc2_ !== param1)
         {
            this._18631945_uiMaskCanvas = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiMaskCanvas",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiNavigatorCommunity() : TabNavigator
      {
         return this._1629274085_uiNavigatorCommunity;
      }
      
      public function set _uiNavigatorCommunity(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1629274085_uiNavigatorCommunity;
         if(_loc2_ !== param1)
         {
            this._1629274085_uiNavigatorCommunity = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiNavigatorCommunity",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiNavigatorMovie() : TabNavigator
      {
         return this._253022932_uiNavigatorMovie;
      }
      
      public function set _uiNavigatorMovie(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._253022932_uiNavigatorMovie;
         if(_loc2_ !== param1)
         {
            this._253022932_uiNavigatorMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiNavigatorMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiNavigatorThemes() : TabNavigator
      {
         return this._939660622_uiNavigatorThemes;
      }
      
      public function set _uiNavigatorThemes(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._939660622_uiNavigatorThemes;
         if(_loc2_ !== param1)
         {
            this._939660622_uiNavigatorThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiNavigatorThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiNavigatorUser() : TabNavigator
      {
         return this._1809035697_uiNavigatorUser;
      }
      
      public function set _uiNavigatorUser(param1:TabNavigator) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1809035697_uiNavigatorUser;
         if(_loc2_ !== param1)
         {
            this._1809035697_uiNavigatorUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiNavigatorUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiPopBtnSearch() : PopUpButton
      {
         return this._682645850_uiPopBtnSearch;
      }
      
      public function set _uiPopBtnSearch(param1:PopUpButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._682645850_uiPopBtnSearch;
         if(_loc2_ !== param1)
         {
            this._682645850_uiPopBtnSearch = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiPopBtnSearch",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiPropMovie() : Accordion
      {
         return this._1688070042_uiPropMovie;
      }
      
      public function set _uiPropMovie(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1688070042_uiPropMovie;
         if(_loc2_ !== param1)
         {
            this._1688070042_uiPropMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiPropMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiPropThemes() : Accordion
      {
         return this._984000672_uiPropThemes;
      }
      
      public function set _uiPropThemes(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._984000672_uiPropThemes;
         if(_loc2_ !== param1)
         {
            this._984000672_uiPropThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiPropThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiSceneMovie() : Accordion
      {
         return this._175298967_uiSceneMovie;
      }
      
      public function set _uiSceneMovie(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._175298967_uiSceneMovie;
         if(_loc2_ !== param1)
         {
            this._175298967_uiSceneMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiSceneMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiSoundThemes() : Accordion
      {
         return this._767428474_uiSoundThemes;
      }
      
      public function set _uiSoundThemes(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._767428474_uiSoundThemes;
         if(_loc2_ !== param1)
         {
            this._767428474_uiSoundThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiSoundThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiThemeButtonBar() : ToggleButtonBar
      {
         return this._725974475_uiThemeButtonBar;
      }
      
      public function set _uiThemeButtonBar(param1:ToggleButtonBar) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._725974475_uiThemeButtonBar;
         if(_loc2_ !== param1)
         {
            this._725974475_uiThemeButtonBar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiThemeButtonBar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBgCommunity() : Tile
      {
         return this._391719453_uiTileBgCommunity;
      }
      
      public function set _uiTileBgCommunity(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._391719453_uiTileBgCommunity;
         if(_loc2_ !== param1)
         {
            this._391719453_uiTileBgCommunity = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBgCommunity",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBgMovie() : Tile
      {
         return this._394530262_uiTileBgMovie;
      }
      
      public function set _uiTileBgMovie(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._394530262_uiTileBgMovie;
         if(_loc2_ !== param1)
         {
            this._394530262_uiTileBgMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBgMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBgThemes() : Tile
      {
         return this._847900688_uiTileBgThemes;
      }
      
      public function set _uiTileBgThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._847900688_uiTileBgThemes;
         if(_loc2_ !== param1)
         {
            this._847900688_uiTileBgThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBgThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBgUser() : Tile
      {
         return this._957346193_uiTileBgUser;
      }
      
      public function set _uiTileBgUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._957346193_uiTileBgUser;
         if(_loc2_ !== param1)
         {
            this._957346193_uiTileBgUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBgUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileBubbleThemes() : Tile
      {
         return this._375869079_uiTileBubbleThemes;
      }
      
      public function set _uiTileBubbleThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._375869079_uiTileBubbleThemes;
         if(_loc2_ !== param1)
         {
            this._375869079_uiTileBubbleThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileBubbleThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharCommunity() : Tile
      {
         return this._1953398322_uiTileCharCommunity;
      }
      
      public function set _uiTileCharCommunity(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1953398322_uiTileCharCommunity;
         if(_loc2_ !== param1)
         {
            this._1953398322_uiTileCharCommunity = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharCommunity",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharMovie() : Tile
      {
         return this._632677895_uiTileCharMovie;
      }
      
      public function set _uiTileCharMovie(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._632677895_uiTileCharMovie;
         if(_loc2_ !== param1)
         {
            this._632677895_uiTileCharMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharThemes() : Tile
      {
         return this._2055258657_uiTileCharThemes;
      }
      
      public function set _uiTileCharThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2055258657_uiTileCharThemes;
         if(_loc2_ !== param1)
         {
            this._2055258657_uiTileCharThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharUser() : Tile
      {
         return this._435809310_uiTileCharUser;
      }
      
      public function set _uiTileCharUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._435809310_uiTileCharUser;
         if(_loc2_ !== param1)
         {
            this._435809310_uiTileCharUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileCharYourChar() : FlowBox
      {
         return this._1921952448_uiTileCharYourChar;
      }
      
      public function set _uiTileCharYourChar(param1:FlowBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1921952448_uiTileCharYourChar;
         if(_loc2_ !== param1)
         {
            this._1921952448_uiTileCharYourChar = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileCharYourChar",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileEffectCommunity() : Tile
      {
         return this._2107238039_uiTileEffectCommunity;
      }
      
      public function set _uiTileEffectCommunity(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2107238039_uiTileEffectCommunity;
         if(_loc2_ !== param1)
         {
            this._2107238039_uiTileEffectCommunity = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileEffectCommunity",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileEffectMovie() : Tile
      {
         return this._497320738_uiTileEffectMovie;
      }
      
      public function set _uiTileEffectMovie(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._497320738_uiTileEffectMovie;
         if(_loc2_ !== param1)
         {
            this._497320738_uiTileEffectMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileEffectMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileEffectThemes() : Tile
      {
         return this._1956363228_uiTileEffectThemes;
      }
      
      public function set _uiTileEffectThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1956363228_uiTileEffectThemes;
         if(_loc2_ !== param1)
         {
            this._1956363228_uiTileEffectThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileEffectThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileEffectUser() : Tile
      {
         return this._1401274275_uiTileEffectUser;
      }
      
      public function set _uiTileEffectUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1401274275_uiTileEffectUser;
         if(_loc2_ !== param1)
         {
            this._1401274275_uiTileEffectUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileEffectUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropCommunity() : Tile
      {
         return this._435498181_uiTilePropCommunity;
      }
      
      public function set _uiTilePropCommunity(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._435498181_uiTilePropCommunity;
         if(_loc2_ !== param1)
         {
            this._435498181_uiTilePropCommunity = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropCommunity",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropHandHeldMovie() : Tile
      {
         return this._1816505304_uiTilePropHandHeldMovie;
      }
      
      public function set _uiTilePropHandHeldMovie(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1816505304_uiTilePropHandHeldMovie;
         if(_loc2_ !== param1)
         {
            this._1816505304_uiTilePropHandHeldMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropHandHeldMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropHandHeldThemes() : Tile
      {
         return this._283652654_uiTilePropHandHeldThemes;
      }
      
      public function set _uiTilePropHandHeldThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._283652654_uiTilePropHandHeldThemes;
         if(_loc2_ !== param1)
         {
            this._283652654_uiTilePropHandHeldThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropHandHeldThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropHeadMovie() : Tile
      {
         return this._1680222732_uiTilePropHeadMovie;
      }
      
      public function set _uiTilePropHeadMovie(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1680222732_uiTilePropHeadMovie;
         if(_loc2_ !== param1)
         {
            this._1680222732_uiTilePropHeadMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropHeadMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropHeadThemes() : Tile
      {
         return this._740734062_uiTilePropHeadThemes;
      }
      
      public function set _uiTilePropHeadThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._740734062_uiTilePropHeadThemes;
         if(_loc2_ !== param1)
         {
            this._740734062_uiTilePropHeadThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropHeadThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropMaskMovie() : Tile
      {
         return this._1847179392_uiTilePropMaskMovie;
      }
      
      public function set _uiTilePropMaskMovie(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1847179392_uiTilePropMaskMovie;
         if(_loc2_ !== param1)
         {
            this._1847179392_uiTilePropMaskMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropMaskMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropMaskThemes() : Tile
      {
         return this._1621423226_uiTilePropMaskThemes;
      }
      
      public function set _uiTilePropMaskThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1621423226_uiTilePropMaskThemes;
         if(_loc2_ !== param1)
         {
            this._1621423226_uiTilePropMaskThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropMaskThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropOtherMovie() : Tile
      {
         return this._940353372_uiTilePropOtherMovie;
      }
      
      public function set _uiTilePropOtherMovie(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._940353372_uiTilePropOtherMovie;
         if(_loc2_ !== param1)
         {
            this._940353372_uiTilePropOtherMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropOtherMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropOtherThemes() : Tile
      {
         return this._1107253462_uiTilePropOtherThemes;
      }
      
      public function set _uiTilePropOtherThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1107253462_uiTilePropOtherThemes;
         if(_loc2_ !== param1)
         {
            this._1107253462_uiTilePropOtherThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropOtherThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTilePropUser() : Tile
      {
         return this._1429951855_uiTilePropUser;
      }
      
      public function set _uiTilePropUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1429951855_uiTilePropUser;
         if(_loc2_ !== param1)
         {
            this._1429951855_uiTilePropUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTilePropUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileSoundEffectsThemes() : Tile
      {
         return this._1191025918_uiTileSoundEffectsThemes;
      }
      
      public function set _uiTileSoundEffectsThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1191025918_uiTileSoundEffectsThemes;
         if(_loc2_ !== param1)
         {
            this._1191025918_uiTileSoundEffectsThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileSoundEffectsThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileSoundMusicThemes() : Tile
      {
         return this._905402271_uiTileSoundMusicThemes;
      }
      
      public function set _uiTileSoundMusicThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._905402271_uiTileSoundMusicThemes;
         if(_loc2_ !== param1)
         {
            this._905402271_uiTileSoundMusicThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileSoundMusicThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileSoundTribeThemes() : Tile
      {
         return this._949674326_uiTileSoundTribeThemes;
      }
      
      public function set _uiTileSoundTribeThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._949674326_uiTileSoundTribeThemes;
         if(_loc2_ !== param1)
         {
            this._949674326_uiTileSoundTribeThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileSoundTribeThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileTemplateMovie() : Tile
      {
         return this._1186357291_uiTileTemplateMovie;
      }
      
      public function set _uiTileTemplateMovie(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1186357291_uiTileTemplateMovie;
         if(_loc2_ !== param1)
         {
            this._1186357291_uiTileTemplateMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileTemplateMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileTemplateThemes() : Tile
      {
         return this._2071066565_uiTileTemplateThemes;
      }
      
      public function set _uiTileTemplateThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2071066565_uiTileTemplateThemes;
         if(_loc2_ !== param1)
         {
            this._2071066565_uiTileTemplateThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileTemplateThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTileVideoPropUser() : Tile
      {
         return this._2044905576_uiTileVideoPropUser;
      }
      
      public function set _uiTileVideoPropUser(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2044905576_uiTileVideoPropUser;
         if(_loc2_ !== param1)
         {
            this._2044905576_uiTileVideoPropUser = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTileVideoPropUser",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiTxtSearch() : TextInput
      {
         return this._45803963_uiTxtSearch;
      }
      
      public function set _uiTxtSearch(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._45803963_uiTxtSearch;
         if(_loc2_ !== param1)
         {
            this._45803963_uiTxtSearch = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiTxtSearch",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userSoundNotUploadableNotice() : Canvas
      {
         return this._87478335_userSoundNotUploadableNotice;
      }
      
      public function set _userSoundNotUploadableNotice(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._87478335_userSoundNotUploadableNotice;
         if(_loc2_ !== param1)
         {
            this._87478335_userSoundNotUploadableNotice = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userSoundNotUploadableNotice",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userSoundNotUploadableNoticeText() : Text
      {
         return this._258023566_userSoundNotUploadableNoticeText;
      }
      
      public function set _userSoundNotUploadableNoticeText(param1:Text) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._258023566_userSoundNotUploadableNoticeText;
         if(_loc2_ !== param1)
         {
            this._258023566_userSoundNotUploadableNoticeText = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userSoundNotUploadableNoticeText",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userSoundThemes() : Accordion
      {
         return this._1693645137_userSoundThemes;
      }
      
      public function set _userSoundThemes(param1:Accordion) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1693645137_userSoundThemes;
         if(_loc2_ !== param1)
         {
            this._1693645137_userSoundThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userSoundThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userTileSoundEffectThemes() : Tile
      {
         return this._596357074_userTileSoundEffectThemes;
      }
      
      public function set _userTileSoundEffectThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._596357074_userTileSoundEffectThemes;
         if(_loc2_ !== param1)
         {
            this._596357074_userTileSoundEffectThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userTileSoundEffectThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userTileSoundMusicThemes() : Tile
      {
         return this._644843432_userTileSoundMusicThemes;
      }
      
      public function set _userTileSoundMusicThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._644843432_userTileSoundMusicThemes;
         if(_loc2_ !== param1)
         {
            this._644843432_userTileSoundMusicThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userTileSoundMusicThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _userTileSoundVoiceThemes() : Tile
      {
         return this._1950667355_userTileSoundVoiceThemes;
      }
      
      public function set _userTileSoundVoiceThemes(param1:Tile) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1950667355_userTileSoundVoiceThemes;
         if(_loc2_ !== param1)
         {
            this._1950667355_userTileSoundVoiceThemes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_userTileSoundVoiceThemes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vbTribe() : VBox
      {
         return this._1698757981_vbTribe;
      }
      
      public function set _vbTribe(param1:VBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1698757981_vbTribe;
         if(_loc2_ !== param1)
         {
            this._1698757981_vbTribe = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vbTribe",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get backToThemeBtn() : IconTextButton
      {
         return this._1014053963backToThemeBtn;
      }
      
      public function set backToThemeBtn(param1:IconTextButton) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1014053963backToThemeBtn;
         if(_loc2_ !== param1)
         {
            this._1014053963backToThemeBtn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"backToThemeBtn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnCreateCc() : Canvas
      {
         return this._694738696btnCreateCc;
      }
      
      public function set btnCreateCc(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._694738696btnCreateCc;
         if(_loc2_ !== param1)
         {
            this._694738696btnCreateCc = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnCreateCc",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnCreateCc2() : Canvas
      {
         return this._62063046btnCreateCc2;
      }
      
      public function set btnCreateCc2(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._62063046btnCreateCc2;
         if(_loc2_ !== param1)
         {
            this._62063046btnCreateCc2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnCreateCc2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnImport() : Button
      {
         return this._300853537btnImport;
      }
      
      public function set btnImport(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._300853537btnImport;
         if(_loc2_ !== param1)
         {
            this._300853537btnImport = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnImport",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSearch() : Button
      {
         return this._579312420btnSearch;
      }
      
      public function set btnSearch(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._579312420btnSearch;
         if(_loc2_ !== param1)
         {
            this._579312420btnSearch = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSearch",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dc() : Canvas
      {
         return this._3199dc;
      }
      
      public function set dc(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._3199dc;
         if(_loc2_ !== param1)
         {
            this._3199dc = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dc",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get goPropPanel() : VBox
      {
         return this._520893529goPropPanel;
      }
      
      public function set goPropPanel(param1:VBox) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._520893529goPropPanel;
         if(_loc2_ !== param1)
         {
            this._520893529goPropPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"goPropPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get pnlShadow() : Panel
      {
         return this._1700543726pnlShadow;
      }
      
      public function set pnlShadow(param1:Panel) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1700543726pnlShadow;
         if(_loc2_ !== param1)
         {
            this._1700543726pnlShadow = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pnlShadow",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get productSearchPanel() : ProductSearchPanel
      {
         return this._157138125productSearchPanel;
      }
      
      public function set productSearchPanel(param1:ProductSearchPanel) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._157138125productSearchPanel;
         if(_loc2_ !== param1)
         {
            this._157138125productSearchPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"productSearchPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get searchPanel() : Canvas
      {
         return this._553648836searchPanel;
      }
      
      public function set searchPanel(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._553648836searchPanel;
         if(_loc2_ !== param1)
         {
            this._553648836searchPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"searchPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get templateCharacterRepeater() : Repeater
      {
         return this._446225527templateCharacterRepeater;
      }
      
      public function set templateCharacterRepeater(param1:Repeater) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._446225527templateCharacterRepeater;
         if(_loc2_ !== param1)
         {
            this._446225527templateCharacterRepeater = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"templateCharacterRepeater",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get themeIcon() : ProductThemeIcon
      {
         return this._17045986themeIcon;
      }
      
      public function set themeIcon(param1:ProductThemeIcon) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._17045986themeIcon;
         if(_loc2_ !== param1)
         {
            this._17045986themeIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeIcon",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtKey() : TextInput
      {
         return this._859632177txtKey;
      }
      
      public function set txtKey(param1:TextInput) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._859632177txtKey;
         if(_loc2_ !== param1)
         {
            this._859632177txtKey = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtKey",_loc2_,param1));
            }
         }
      }
      
      public function set themeId(param1:String) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this.themeId;
         if(_loc2_ !== param1)
         {
            this._1349701436themeId = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeId",_loc2_,param1));
            }
         }
      }
   }
}
