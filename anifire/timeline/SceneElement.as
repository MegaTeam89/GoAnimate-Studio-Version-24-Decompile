package anifire.timeline
{
   import anifire.command.AddSceneTemplateCommand;
   import anifire.command.ChangeSceneDurationCommand;
   import anifire.command.ICommand;
   import anifire.components.containers.InputWindow;
   import anifire.constant.AnimeConstants;
   import anifire.containers.GradientCanvas;
   import anifire.core.AnimeScene;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Console;
   import anifire.core.SoundThumb;
   import anifire.core.TemplateThumb;
   import anifire.core.sound.ProgressiveSound;
   import anifire.core.sound.SoundEvent;
   import anifire.event.ExtraDataEvent;
   import anifire.events.InputWindowEvent;
   import anifire.events.SceneEvent;
   import anifire.scene.model.SceneManager;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilLicense;
   import anifire.util.UtilString;
   import anifire.util.UtilUnitConvert;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BevelFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Proxy;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Menu;
   import mx.controls.ToolTip;
   import mx.core.DragSource;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.DragEvent;
   import mx.events.FlexEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.managers.CursorManager;
   import mx.managers.DragManager;
   import mx.managers.PopUpManager;
   import mx.managers.ToolTipManager;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class SceneElement extends Canvas implements ITimelineElement, IBindingClient
   {
      
      private static const SELECTED:int = 0;
      
      private static const UNSELECTED:int = 1;
      
      private static const COLOR_SELECTED:String = "0x000000";
      
      private static const COLOR_UNSELECTED:String = "0xAAB3B3";
      
      private static const MENU_LABEL_SCENE_LENGTH:String = "timeline_duration";
      
      private static const MENU_LABEL_SCENE_LENGTH_1:String = "timeline_1sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_2:String = "timeline_2sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_3:String = "timeline_3sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_4:String = "timeline_4sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_6:String = "timeline_6sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_INPUT:String = "Custom";
      
      private static const MENU_LABEL_RESET_TTS:String = "Reset to length of speech";
      
      private static const MENU_LABEL_COPY:String = "timeline_copy";
      
      private static const MENU_LABEL_DELETE:String = "timeline_delete";
      
      private static const MENU_LABEL_CLEAR:String = "timeline_clear";
      
      private static const MENU_LABEL_PASTE_BEFORE:String = "timeline_insertbefore";
      
      private static const MENU_LABEL_PASTE_AFTER:String = "timeline_insertafter";
      
      private static const MENU_LABEL_PREVIEW_SCENE:String = "Preview from here";
      
      private static const FILTER_SELECTED:GlowFilter = new GlowFilter(16750899,1,3,3,5,1,false,false);
      
      private static const FILTER_UNSELECTED:GlowFilter = new GlowFilter(0,1,3,3,5,1,false,false);
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _SceneElement_GradientCanvas2:GradientCanvas;
      
      private var _94436_bg:Canvas;
      
      private var _738350834_boxSpeech:Canvas;
      
      private var _89648856_btnAddScene:GradientCanvas;
      
      private var _635756001_dropIndicator:Canvas;
      
      private var _1136560567_sceneThumb:Canvas;
      
      private var _91376600_wave:SoundWaveformRenderer;
      
      private var _1280011162arrow_cs:Canvas;
      
      private var _1386333250blinds:Image;
      
      private var _98309cce:Fade;
      
      private var _844601711cleanbrush:Image;
      
      private var _1274009032cleanhand:Image;
      
      private var _3135100fade:Image;
      
      private var _525805554fadedark:Image;
      
      private var _1722173355fesbadtransmission:Image;
      
      private var _932325865fesbrightsquares_11:Image;
      
      private var _932325863fesbrightsquares_13:Image;
      
      private var _1437798838fesdesertillusion:Image;
      
      private var _963072215fesdisc:Image;
      
      private var _229534177fesintersectingstripes_1:Image;
      
      private var _229534180fesintersectingstripes_4:Image;
      
      private var _2034205308feslightstripes:Image;
      
      private var _1830622772fessparkle_1:Image;
      
      private var _1830622775fessparkle_4:Image;
      
      private var _1213332216fesunpack_1:Image;
      
      private var _1213332217fesunpack_2:Image;
      
      private var _1213332223fesunpack_8:Image;
      
      private var _2087589298feszoomblur:Image;
      
      private var _101491fly:Image;
      
      private var _3240979iris:Image;
      
      private var _55443368left_cs:Canvas;
      
      private var _1081572386mainBg:GradientCanvas;
      
      private var _3521no:Image;
      
      private var _517012826overSceneBevelFilter:BevelFilter;
      
      private var _1101361396overVoiceBevelFilter:BevelFilter;
      
      private var _106642994photo:Image;
      
      private var _1264957687pixeldissolve:Image;
      
      private var _1436079757right_cs:Canvas;
      
      private var _925180581rotate:Image;
      
      private var _1675320218sceneBevelFilter:BevelFilter;
      
      private var _1914646001sceneBg:GradientCanvas;
      
      private var _1729673616scene_img:Image;
      
      private var _1729676163scene_lbl:Label;
      
      private var _1655455680selectedBg:GradientCanvas;
      
      private var _1906591009selectedSceneBevelFilter:BevelFilter;
      
      private var _1956980552shadowFilter:DropShadowFilter;
      
      private var _1754383154speechLabel:Label;
      
      private var _1965003230squeeze:Image;
      
      private var _1051791169transIcon:Canvas;
      
      private var _1280875879trans_cs:Canvas;
      
      private var _1090971648voiceBevelFilter:BevelFilter;
      
      private var _3649607wipe:Image;
      
      private var _1057426122wipehand:Image;
      
      private var _3744723zoom:Image;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _977672194ArrowIcon:Class;
      
      private var _indicator:ToolTip;
      
      private var _bitmapData:BitmapData;
      
      private var _focus:Boolean = false;
      
      private var _label:String = "Blank";
      
      private var _prop:Object;
      
      private var _scene:AnimeScene;
      
      private var _mouseDown:Boolean = false;
      
      private var _timelineControl:Timeline = null;
      
      private var _id:String;
      
      private var _motionTime:Number = 0;
      
      private var _transType:String = "";
      
      private var _transDur:Number = 0;
      
      private var _showWaveform:Boolean = false;
      
      public const LABEL_COLOR:Number = 0;
      
      private var E_Symbol:Class;
      
      private var cursorID:int;
      
      private var isResizing:Boolean = false;
      
      private var _animeSound:AnimeSound;
      
      mx_internal var _SceneElement_StylesInit_done:Boolean = false;
      
      private var _embed_mxml____icon_transitions_transition_stripes_vertical_png_847123798:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_clean_brush_png_193936948:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_blind_png_362199274:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_squeeze_png_27606968:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_tosolid_png_564399916:Class;
      
      private var _embed_mxml____icon_transitions_transition_circular_reveal__png_1283330380:Class;
      
      private var _embed_mxml____icon_transitions_transition_sparkles_vertical_png_135024182:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_iris_circle_png_273665172:Class;
      
      private var _embed_css_image_btn_addscene_over_png_1287719774_136525298:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_wipe_png_417577496:Class;
      
      private var _embed_mxml____icon_transitions_transition_blur_zooming_png_1362085302:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_fade_png_551789974:Class;
      
      private var _embed_mxml____icon_transitions_transition_stripes_blurry_png_2139474538:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_zoom_png_669753848:Class;
      
      private var _embed_mxml____icon_transitions_transition_split_vertical_png_1200065418:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_rotate_png_793790056:Class;
      
      private var _embed_mxml____icon_transitions_transition_bright_square_wave_png_1269229324:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_fly_png_1422815126:Class;
      
      private var _embed_mxml____icon_transitions_transition_sparkles_horizontal_png_1869166858:Class;
      
      private var _embed_mxml____icon_transitions_transition_unpack_png_1537234252:Class;
      
      private var _embed_mxml____icon_transitions_transition_desert_illusion_png_438953556:Class;
      
      private var _embed_mxml____icon_transitions_transition_bright_square_png_681967414:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_photo_png_1885980632:Class;
      
      private var _embed_mxml____icon_transitions_transition_split_horizontal_png_1008669718:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_no_png_576440996:Class;
      
      private var _embed_mxml____icon_transitions_transition_bad_transmission_png_983438900:Class;
      
      private var _embed_css_image_btn_addscene_init_png_1027061146_737562818:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_pixel_png_141903864:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_clean_hand_png_746530964:Class;
      
      private var _embed_mxml____icon_transitions_transition_thumb_wipe_hand_png_1003624586:Class;
      
      private var _embed_mxml____icon_transitions_transition_stripes_horizontal_png_1231747338:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SceneElement()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{
               "creationComplete":"___SceneElement_Canvas1_creationComplete",
               "dragEnter":"___SceneElement_Canvas1_dragEnter",
               "dragDrop":"___SceneElement_Canvas1_dragDrop",
               "dragOver":"___SceneElement_Canvas1_dragOver",
               "dragExit":"___SceneElement_Canvas1_dragExit"
            },
            "effects":["creationCompleteEffect"],
            "propertiesFactory":function():Object
            {
               return {
                  "width":300,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_bg",
                     "stylesFactory":function():void
                     {
                        this.backgroundSize = "100%";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"sceneTimelineOver",
                           "visible":false
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":GradientCanvas,
                     "id":"mainBg",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"bgStyle"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":GradientCanvas,
                     "id":"_SceneElement_GradientCanvas2",
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 12961221;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":52,
                           "percentWidth":100,
                           "height":18
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":GradientCanvas,
                     "id":"selectedBg",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"selectedBgStyle"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_sceneThumb",
                     "events":{
                        "mouseDown":"___sceneThumb_mouseDown",
                        "mouseUp":"___sceneThumb_mouseUp",
                        "mouseOver":"___sceneThumb_mouseOver",
                        "mouseOut":"___sceneThumb_mouseOut",
                        "rollOver":"___sceneThumb_rollOver",
                        "rollOut":"___sceneThumb_rollOut"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":52,
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off",
                           "horizontalCenter":0,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"left_cs",
                              "events":{"resize":"__left_cs_resize"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":50,
                                    "percentHeight":100,
                                    "left":2,
                                    "verticalCenter":0,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"right_cs",
                              "events":{"resize":"__right_cs_resize"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":50,
                                    "percentHeight":100,
                                    "right":2,
                                    "verticalCenter":0,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "events":{
                                 "mouseMove":"___SceneElement_Canvas6_mouseMove",
                                 "click":"___SceneElement_Canvas6_click"
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "verticalScrollPolicy":"off",
                                    "horizontalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":GradientCanvas,
                                       "id":"sceneBg",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Image,
                                       "id":"scene_img",
                                       "events":{"creationComplete":"__scene_img_creationComplete"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "horizontalCenter":0,
                                             "maintainAspectRatio":false,
                                             "width":76,
                                             "height":51,
                                             "verticalCenter":0
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"trans_cs",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":0,
                                             "percentHeight":100,
                                             "left":0,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"transIcon",
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "scaleX":0.5,
                                                      "scaleY":0.5,
                                                      "x":2,
                                                      "y":2,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"no",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_no_png_576440996};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"blinds",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_blind_png_362199274};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fade",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_fade_png_551789974};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fly",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_fly_png_1422815126};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"iris",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_iris_circle_png_273665172};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"photo",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_photo_png_1885980632};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"pixeldissolve",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_pixel_png_141903864};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"rotate",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_rotate_png_793790056};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"squeeze",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_squeeze_png_27606968};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"wipe",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_wipe_png_417577496};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"wipehand",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_wipe_hand_png_1003624586};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"zoom",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_zoom_png_669753848};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fadedark",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_tosolid_png_564399916};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"cleanhand",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_clean_hand_png_746530964};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"cleanbrush",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_thumb_clean_brush_png_193936948};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesbadtransmission",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_bad_transmission_png_983438900};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"feszoomblur",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_blur_zooming_png_1362085302};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesbrightsquares_13",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_bright_square_png_681967414};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesbrightsquares_11",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_bright_square_wave_png_1269229324};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesdesertillusion",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_desert_illusion_png_438953556};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fessparkle_1",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_sparkles_horizontal_png_1869166858};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fessparkle_4",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_sparkles_vertical_png_135024182};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesunpack_2",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_split_horizontal_png_1008669718};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesunpack_1",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_split_vertical_png_1200065418};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"feslightstripes",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_stripes_blurry_png_2139474538};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesintersectingstripes_4",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_stripes_horizontal_png_1231747338};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesintersectingstripes_1",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_stripes_vertical_png_847123798};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesunpack_8",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_unpack_png_1537234252};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":Image,
                                                         "id":"fesdisc",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"source":_embed_mxml____icon_transitions_transition_circular_reveal__png_1283330380};
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "stylesFactory":function():void
                                       {
                                          this.backgroundColor = 4411524;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "left":0,
                                             "bottom":0,
                                             "width":18,
                                             "height":18,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"scene_lbl",
                                                "events":{"creationComplete":"__scene_lbl_creationComplete"},
                                                "stylesFactory":function():void
                                                {
                                                   this.color = 11449547;
                                                   this.textAlign = "center";
                                                   this.fontWeight = "bold";
                                                   this.fontSize = 10;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "width":25,
                                                      "x":-4,
                                                      "y":1,
                                                      "selectable":false,
                                                      "buttonMode":true,
                                                      "useHandCursor":true,
                                                      "mouseChildren":false
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
                              "id":"arrow_cs",
                              "events":{
                                 "rollOver":"__arrow_cs_rollOver",
                                 "rollOut":"__arrow_cs_rollOut",
                                 "mouseDown":"__arrow_cs_mouseDown"
                              },
                              "stylesFactory":function():void
                              {
                                 this.backgroundColor = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "alpha":0,
                                    "width":10,
                                    "right":0,
                                    "percentHeight":100
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_boxSpeech",
                     "events":{
                        "rollOver":"___boxSpeech_rollOver",
                        "rollOut":"___boxSpeech_rollOut",
                        "click":"___boxSpeech_click"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":53,
                           "height":17,
                           "alpha":0.6,
                           "styleName":"voiceStyle",
                           "horizontalScrollPolicy":"off",
                           "visible":false,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "id":"speechLabel",
                              "stylesFactory":function():void
                              {
                                 this.color = 5592405;
                                 this.fontSize = 11;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":6,
                                    "percentHeight":100,
                                    "truncateToFit":true,
                                    "buttonMode":true,
                                    "useHandCursor":true,
                                    "mouseChildren":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":SoundWaveformRenderer,
                              "id":"_wave",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "visible":false,
                                    "percentWidth":100
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":GradientCanvas,
                     "id":"_btnAddScene",
                     "events":{"click":"___btnAddScene_click"},
                     "stylesFactory":function():void
                     {
                        this.backgroundColor = 11908533;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":100,
                           "percentHeight":100,
                           "visible":false,
                           "alpha":0.5,
                           "buttonMode":true,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Button,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "horizontalCenter":0,
                                    "y":7,
                                    "width":40,
                                    "height":40,
                                    "styleName":"btnAddSceneTimeline"
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_dropIndicator",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "mouseChildren":false
                        };
                     }
                  })]
               };
            }
         });
         this._977672194ArrowIcon = SceneElement_ArrowIcon;
         this.E_Symbol = SceneElement_E_Symbol;
         this._embed_mxml____icon_transitions_transition_stripes_vertical_png_847123798 = SceneElement__embed_mxml____icon_transitions_transition_stripes_vertical_png_847123798;
         this._embed_mxml____icon_transitions_transition_thumb_clean_brush_png_193936948 = SceneElement__embed_mxml____icon_transitions_transition_thumb_clean_brush_png_193936948;
         this._embed_mxml____icon_transitions_transition_thumb_blind_png_362199274 = SceneElement__embed_mxml____icon_transitions_transition_thumb_blind_png_362199274;
         this._embed_mxml____icon_transitions_transition_thumb_squeeze_png_27606968 = SceneElement__embed_mxml____icon_transitions_transition_thumb_squeeze_png_27606968;
         this._embed_mxml____icon_transitions_transition_thumb_tosolid_png_564399916 = SceneElement__embed_mxml____icon_transitions_transition_thumb_tosolid_png_564399916;
         this._embed_mxml____icon_transitions_transition_circular_reveal__png_1283330380 = SceneElement__embed_mxml____icon_transitions_transition_circular_reveal__png_1283330380;
         this._embed_mxml____icon_transitions_transition_sparkles_vertical_png_135024182 = SceneElement__embed_mxml____icon_transitions_transition_sparkles_vertical_png_135024182;
         this._embed_mxml____icon_transitions_transition_thumb_iris_circle_png_273665172 = SceneElement__embed_mxml____icon_transitions_transition_thumb_iris_circle_png_273665172;
         this._embed_css_image_btn_addscene_over_png_1287719774_136525298 = _class_embed_css_image_btn_addscene_over_png_1287719774_136525298;
         this._embed_mxml____icon_transitions_transition_thumb_wipe_png_417577496 = SceneElement__embed_mxml____icon_transitions_transition_thumb_wipe_png_417577496;
         this._embed_mxml____icon_transitions_transition_blur_zooming_png_1362085302 = SceneElement__embed_mxml____icon_transitions_transition_blur_zooming_png_1362085302;
         this._embed_mxml____icon_transitions_transition_thumb_fade_png_551789974 = SceneElement__embed_mxml____icon_transitions_transition_thumb_fade_png_551789974;
         this._embed_mxml____icon_transitions_transition_stripes_blurry_png_2139474538 = SceneElement__embed_mxml____icon_transitions_transition_stripes_blurry_png_2139474538;
         this._embed_mxml____icon_transitions_transition_thumb_zoom_png_669753848 = SceneElement__embed_mxml____icon_transitions_transition_thumb_zoom_png_669753848;
         this._embed_mxml____icon_transitions_transition_split_vertical_png_1200065418 = SceneElement__embed_mxml____icon_transitions_transition_split_vertical_png_1200065418;
         this._embed_mxml____icon_transitions_transition_thumb_rotate_png_793790056 = SceneElement__embed_mxml____icon_transitions_transition_thumb_rotate_png_793790056;
         this._embed_mxml____icon_transitions_transition_bright_square_wave_png_1269229324 = SceneElement__embed_mxml____icon_transitions_transition_bright_square_wave_png_1269229324;
         this._embed_mxml____icon_transitions_transition_thumb_fly_png_1422815126 = SceneElement__embed_mxml____icon_transitions_transition_thumb_fly_png_1422815126;
         this._embed_mxml____icon_transitions_transition_sparkles_horizontal_png_1869166858 = SceneElement__embed_mxml____icon_transitions_transition_sparkles_horizontal_png_1869166858;
         this._embed_mxml____icon_transitions_transition_unpack_png_1537234252 = SceneElement__embed_mxml____icon_transitions_transition_unpack_png_1537234252;
         this._embed_mxml____icon_transitions_transition_desert_illusion_png_438953556 = SceneElement__embed_mxml____icon_transitions_transition_desert_illusion_png_438953556;
         this._embed_mxml____icon_transitions_transition_bright_square_png_681967414 = SceneElement__embed_mxml____icon_transitions_transition_bright_square_png_681967414;
         this._embed_mxml____icon_transitions_transition_thumb_photo_png_1885980632 = SceneElement__embed_mxml____icon_transitions_transition_thumb_photo_png_1885980632;
         this._embed_mxml____icon_transitions_transition_split_horizontal_png_1008669718 = SceneElement__embed_mxml____icon_transitions_transition_split_horizontal_png_1008669718;
         this._embed_mxml____icon_transitions_transition_thumb_no_png_576440996 = SceneElement__embed_mxml____icon_transitions_transition_thumb_no_png_576440996;
         this._embed_mxml____icon_transitions_transition_bad_transmission_png_983438900 = SceneElement__embed_mxml____icon_transitions_transition_bad_transmission_png_983438900;
         this._embed_css_image_btn_addscene_init_png_1027061146_737562818 = _class_embed_css_image_btn_addscene_init_png_1027061146_737562818;
         this._embed_mxml____icon_transitions_transition_thumb_pixel_png_141903864 = SceneElement__embed_mxml____icon_transitions_transition_thumb_pixel_png_141903864;
         this._embed_mxml____icon_transitions_transition_thumb_clean_hand_png_746530964 = SceneElement__embed_mxml____icon_transitions_transition_thumb_clean_hand_png_746530964;
         this._embed_mxml____icon_transitions_transition_thumb_wipe_hand_png_1003624586 = SceneElement__embed_mxml____icon_transitions_transition_thumb_wipe_hand_png_1003624586;
         this._embed_mxml____icon_transitions_transition_stripes_horizontal_png_1231747338 = SceneElement__embed_mxml____icon_transitions_transition_stripes_horizontal_png_1231747338;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SceneElement_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SceneElementWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SceneElement[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.width = 300;
         this.percentHeight = 100;
         this.clipContent = false;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._SceneElement_Fade1_i();
         this._SceneElement_BevelFilter3_i();
         this._SceneElement_BevelFilter5_i();
         this._SceneElement_BevelFilter1_i();
         this._SceneElement_BevelFilter2_i();
         this._SceneElement_DropShadowFilter1_i();
         this._SceneElement_BevelFilter4_i();
         this.addEventListener("creationComplete",this.___SceneElement_Canvas1_creationComplete);
         this.addEventListener("dragEnter",this.___SceneElement_Canvas1_dragEnter);
         this.addEventListener("dragDrop",this.___SceneElement_Canvas1_dragDrop);
         this.addEventListener("dragOver",this.___SceneElement_Canvas1_dragOver);
         this.addEventListener("dragExit",this.___SceneElement_Canvas1_dragExit);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SceneElement._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_SceneElement_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function get transDur() : Number
      {
         return this._transDur;
      }
      
      public function set transDur(param1:Number) : void
      {
         if(this._transDur != param1)
         {
            this._transDur = param1;
            this.updateTransTag();
         }
      }
      
      public function get transType() : String
      {
         return this._transType;
      }
      
      public function set transType(param1:String) : void
      {
         if(this._transType != param1)
         {
            this._transType = param1;
            this.updateTransTag();
         }
      }
      
      private function initApp() : void
      {
         this._btnAddScene.graphics.lineStyle(1,11908533,1,true);
         this._btnAddScene.graphics.moveTo(this._btnAddScene.width - 2,0);
         this._btnAddScene.graphics.lineTo(this._btnAddScene.width - 2,this._btnAddScene.height);
      }
      
      override public function get id() : String
      {
         return this._id;
      }
      
      override public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function set scene(param1:AnimeScene) : void
      {
         this._scene = param1;
         if(this._scene)
         {
            this._scene.addEventListener(SceneEvent.DURATION_CHANGE,this.onSceneDurationChange);
            this._scene.addEventListener(SceneEvent.TRANSITION_CHANGE,this.onSceneTransitionChange);
         }
      }
      
      private function onSceneDurationChange(param1:Event) : void
      {
         var _loc2_:int = Console.getConsole().movie.getSceneIndex(this._scene);
         if(_loc2_ >= 0)
         {
            this._timelineControl.updateSceneLength(UtilUnitConvert.frameToPixel(this._scene.totalFrames),_loc2_,true);
         }
      }
      
      private function onSceneTransitionChange(param1:Event) : void
      {
         if(this._scene && this._scene.transition)
         {
            this.transDur = this._scene.transition.duration;
            this.transType = this._scene.transition.type;
         }
         else
         {
            this.transType = "";
         }
      }
      
      public function set focus(param1:Boolean) : void
      {
         var _loc2_:Number = NaN;
         if(this._focus != param1)
         {
            this._focus = param1;
            if(this._focus)
            {
               this.setState(SELECTED);
               this.sceneBg.styleName = "selectedSceneStyle";
               this.selectedBg.visible = true;
               this.sceneBg.filters = [this.selectedSceneBevelFilter];
            }
            else
            {
               this.setState(UNSELECTED);
               this.sceneBg.styleName = "sceneStyle";
               this.selectedBg.visible = false;
               this.sceneBg.filters = [this.sceneBevelFilter];
            }
            _loc2_ = Console.getConsole().movie.getSceneIndex(this._scene);
            if(Console.getConsole().scenes.length == _loc2_ + 1 && !Console.getConsole().isTutorialOn)
            {
               this._btnAddScene.visible = true;
            }
            else
            {
               this._btnAddScene.visible = false;
            }
         }
      }
      
      public function set showAddSceneBtn(param1:Boolean) : void
      {
         this._btnAddScene.visible = param1;
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      [Bindable(event="dataChange")]
      public function get source() : BitmapData
      {
         return this._bitmapData;
      }
      
      [Bindable(event="dataChange")]
      override public function get label() : String
      {
         return this._label;
      }
      
      [Bindable(event="dataChange")]
      public function get prop() : Object
      {
         return this._prop;
      }
      
      public function set source(param1:BitmapData) : void
      {
         this._bitmapData = param1;
         this.showImage();
         dispatchEvent(new Event("dataChange"));
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.showLabel();
         dispatchEvent(new Event("dataChange"));
      }
      
      public function set prop(param1:Object) : void
      {
         this._prop = param1;
         dispatchEvent(new Event("dataChange"));
      }
      
      public function get totalTime() : Number
      {
         return width;
      }
      
      public function get startTime() : Number
      {
         return x;
      }
      
      public function set motionTime(param1:Number) : void
      {
         this._motionTime = param1;
      }
      
      public function get motionTime() : Number
      {
         return this._motionTime;
      }
      
      public function get actionTime() : Number
      {
         return this.totalTime - this.motionTime;
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
      }
      
      public function updateImage(param1:BitmapData) : void
      {
         this.scene_img.source = new Bitmap(param1);
      }
      
      public function showIndicator(param1:Number = -1, param2:Number = -1) : void
      {
         var _loc3_:Point = this.getSceneGlobalPosition();
         if(this._indicator == null)
         {
            this._indicator = this.createIndicator(_loc3_.x,_loc3_.y);
         }
         this._indicator.x = _loc3_.x - 3;
         this._indicator.y = _loc3_.y - this._indicator.height - 17;
         this._indicator.text = this.getLabel(param1,param2);
      }
      
      public function removeIndicator() : void
      {
         if(this._indicator)
         {
            ToolTipManager.destroyToolTip(this._indicator);
            this._indicator = null;
         }
      }
      
      private function getSceneGlobalPosition() : Point
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         _loc1_ = parent.localToGlobal(new Point(x,y));
         if(this._timelineControl != null)
         {
            _loc2_ = this._timelineControl.scene_vb.localToGlobal(new Point(0,0));
            if(_loc1_.x <= _loc2_.x)
            {
               _loc1_.x = _loc2_.x;
            }
         }
         return _loc1_;
      }
      
      private function showImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:Matrix = null;
         try
         {
            if(this._bitmapData)
            {
               _loc1_ = new BitmapData(this.scene_img.width,this.scene_img.height,false,0);
               _loc2_ = new Matrix();
               _loc2_.scale(_loc1_.width / this._bitmapData.width,_loc1_.height / this._bitmapData.height);
               _loc1_.draw(this._bitmapData,_loc2_,null,null,null,true);
               this.scene_img.source = new Bitmap(_loc1_);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function showLabel() : void
      {
         try
         {
            this.scene_lbl.text = this._label;
         }
         catch(e:Error)
         {
         }
      }
      
      private function getLabel(param1:Number = -1, param2:Number = -1) : String
      {
         param1 = param1 < 0 ? Number(x) : Number(param1);
         param2 = param2 < 0 ? Number(width) : Number(param2);
         var _loc3_:Number = UtilUnitConvert.pixelToSec(param1);
         var _loc4_:Number = UtilUnitConvert.pixelToSec(param2);
         return "[" + UtilDict.toDisplay("go","timeline_starttime") + ": " + UtilString.secToTimeString(_loc3_) + ", " + UtilDict.toDisplay("go","timeline_duration") + ": " + UtilString.secToTimeString(_loc4_) + "]";
      }
      
      private function createIndicator(param1:Number, param2:Number) : ToolTip
      {
         var _loc3_:String = this.getLabel();
         var _loc4_:ToolTip;
         (_loc4_ = ToolTipManager.createToolTip(_loc3_,param1,param2) as ToolTip).setStyle("backgroundColor",16763904);
         return _loc4_;
      }
      
      private function drawArrow(param1:String) : void
      {
         var _loc2_:Canvas = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = height / 2;
         if(param1 == "left")
         {
            _loc2_ = this.left_cs;
            _loc3_ = 5;
            _loc4_ = 180;
         }
         else
         {
            _loc2_ = this.right_cs;
            _loc3_ = this.right_cs.width - 5;
            _loc4_ = 0;
         }
         _loc2_.graphics.clear();
         if(width > this.scene_img.width + 6)
         {
            _loc2_.graphics.beginFill(6710886);
            _loc2_.graphics.lineStyle(0,6710886);
            UtilDraw.drawPoly(_loc2_,_loc3_,_loc5_,3,5,_loc4_);
            _loc2_.graphics.moveTo(0,_loc5_);
            _loc2_.graphics.lineTo(_loc2_.width,_loc5_);
            _loc2_.graphics.endFill();
         }
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._focus)
         {
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         if(this._focus)
         {
         }
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this._mouseDown = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.showIndicator();
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         this._mouseDown = false;
         if(this.isResizing)
         {
            this.isResizing = false;
            CursorManager.removeCursor(this.cursorID);
         }
         if(stage != null)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
            this.removeIndicator();
         }
      }
      
      private function setState(param1:int) : void
      {
         if(param1 != SELECTED)
         {
            if(param1 == UNSELECTED)
            {
            }
         }
      }
      
      public function currentScenehasSpeech() : Boolean
      {
         var _loc1_:AnimeScene = Console.getConsole().currentScene;
         if(Console.getConsole().linkageController.getSpeechSoundIdByScene(_loc1_) != "")
         {
            return true;
         }
         return false;
      }
      
      private function showMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:Menu = null;
         if(Console.getConsole().isTutorialOn)
         {
            return;
         }
         var _loc3_:* = "";
         var _loc6_:String = !!SceneManager.copiedScene ? "true" : "false";
         var _loc7_:String = UtilLicense.getCurrentLicenseId();
         _loc3_ = "<root>";
         _loc3_ += "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_COPY) + "\" value=\"" + MENU_LABEL_COPY + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PASTE_BEFORE) + "\" value=\"" + MENU_LABEL_PASTE_BEFORE + "\" enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PASTE_AFTER) + "\" value=\"" + MENU_LABEL_PASTE_AFTER + "\" enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_DELETE) + "\" value=\"" + MENU_LABEL_DELETE + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_CLEAR) + "\" value=\"" + MENU_LABEL_CLEAR + "\" />" + "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go","Scene Settings") + "\" value=\"Scene Settings\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH + "\" >" + "<menuItem label=\"" + UtilDict.toDisplay("go","Fit to all scene content") + "\" value=\"Automatic\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go","Fit to speech duration") + "\" value=\"FitToSpeech\" />" + "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_1) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_1 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_2) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_2 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_4) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_4 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go","6 secs") + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_6 + "\" />";
         _loc3_ += "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_INPUT) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_INPUT + "\" />";
         _loc3_ += "</menuItem>";
         if(!(_loc7_ == "7" || _loc7_ == "8"))
         {
            _loc3_ += "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PREVIEW_SCENE) + "\" value=\"" + MENU_LABEL_PREVIEW_SCENE + "\" />";
         }
         _loc3_ += "</root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = Menu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         _loc8_ = 120;
         _loc9_ = 170;
         var _loc10_:Canvas;
         var _loc11_:Point = (_loc10_ = this.getSceneCanvas()).localToGlobal(new Point(0,0));
         var _loc12_:Number = param1;
         var _loc13_:Number = param2 - 90;
         if(_loc12_ + _loc8_ > _loc11_.x + _loc10_.width - 100)
         {
            _loc12_ = _loc11_.x + _loc10_.width - _loc8_ - 100;
         }
         if(_loc13_ + _loc9_ > _loc11_.y + _loc10_.height)
         {
            _loc13_ = _loc11_.y + _loc10_.height - _loc9_;
         }
         _loc5_.show(_loc12_,Console.getConsole().timeline.y - _loc9_);
         this._timelineControl.doPatchSceneResizeStart(int(this.id));
      }
      
      protected function getSceneCanvas() : Canvas
      {
         if(Console.getConsole().timeline == null)
         {
            return null;
         }
         return Canvas(Console.getConsole().timeline);
      }
      
      private function onWindowInput(param1:InputWindowEvent) : void
      {
         var _loc2_:ICommand = null;
         _loc2_ = new ChangeSceneDurationCommand(this._scene,Number(param1.inputValue) * AnimeConstants.FRAME_PER_SEC,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
         _loc2_.execute();
      }
      
      private function doMenuClick(param1:MenuEvent) : void
      {
         var _loc3_:ICommand = null;
         var _loc4_:InputWindow = null;
         var _loc5_:int = 0;
         var _loc2_:XML = XML(param1.item);
         switch(_loc2_.attribute("value").toString())
         {
            case MENU_LABEL_SCENE_LENGTH_1:
               _loc3_ = new ChangeSceneDurationCommand(this._scene,1 * AnimeConstants.FRAME_PER_SEC,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
               _loc3_.execute();
               break;
            case MENU_LABEL_SCENE_LENGTH_2:
               _loc3_ = new ChangeSceneDurationCommand(this._scene,2 * AnimeConstants.FRAME_PER_SEC,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
               _loc3_.execute();
               break;
            case MENU_LABEL_SCENE_LENGTH_4:
               _loc3_ = new ChangeSceneDurationCommand(this._scene,4 * AnimeConstants.FRAME_PER_SEC,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
               _loc3_.execute();
               break;
            case MENU_LABEL_SCENE_LENGTH_6:
               _loc3_ = new ChangeSceneDurationCommand(this._scene,6 * AnimeConstants.FRAME_PER_SEC,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
               _loc3_.execute();
               break;
            case "Automatic":
               _loc3_ = new ChangeSceneDurationCommand(this._scene,0,AnimeScene.DURATION_MODE_AUTO,Console.getConsole().timeline);
               _loc3_.execute();
               break;
            case "FitToSpeech":
               _loc3_ = new ChangeSceneDurationCommand(this._scene,0,AnimeScene.DURATION_MODE_SPEECH,Console.getConsole().timeline);
               _loc3_.execute();
               break;
            case MENU_LABEL_SCENE_LENGTH_INPUT:
               (_loc4_ = InputWindow(PopUpManager.createPopUp(this.getSceneCanvas(),InputWindow,true))).addEventListener(InputWindowEvent.INPUT_SUBMIT,this.onWindowInput);
               _loc4_.width = 490;
               _loc4_.height = 130;
               _loc4_.init(UtilDict.toDisplay("go","Scene Duration (sec):"),"popupWindow","slider",this._scene.duration,AnimeConstants.SCENE_DURATION_MINIMUM,20,0.125);
               break;
            case "duplicate":
               Console.getConsole().copyCurrentScene();
               Console.getConsole().pasteScene();
               break;
            case MENU_LABEL_COPY:
               Console.getConsole().copyCurrentScene();
               break;
            case MENU_LABEL_DELETE:
               Console.getConsole().deleteCurrentScene();
               break;
            case MENU_LABEL_CLEAR:
               Console.getConsole().clearCurrentScene();
               break;
            case MENU_LABEL_PASTE_BEFORE:
               Console.getConsole().pasteScene(false);
               break;
            case MENU_LABEL_PASTE_AFTER:
               Console.getConsole().pasteScene();
               break;
            case MENU_LABEL_PREVIEW_SCENE:
               Console.getConsole().preview(null,true);
               break;
            case MENU_LABEL_RESET_TTS:
               if((_loc5_ = Console.getConsole().speechManager.getSpeechTotalFrame(this._scene)) > 0)
               {
                  _loc3_ = new ChangeSceneDurationCommand(this._scene,_loc5_,AnimeScene.DURATION_MODE_CUSTOM,Console.getConsole().timeline);
                  _loc3_.execute();
               }
               break;
            case "Scene Settings":
               Console.getConsole().currentScene.selectedAsset = null;
               Console.getConsole().showOverTray(true,Console.getConsole().currentScene);
         }
      }
      
      public function resetTTSLength() : Number
      {
         var _loc1_:SoundThumb = null;
         var _loc2_:AnimeSound = null;
         var _loc3_:AnimeScene = Console.getConsole().currentScene;
         var _loc4_:String = Console.getConsole().linkageController.getSpeechSoundIdByScene(_loc3_);
         _loc2_ = Console.getConsole().speechManager.getValueByKey(_loc4_) as AnimeSound;
         if(_loc2_)
         {
            _loc1_ = _loc2_.soundThumb;
            return Util.cielNum(_loc1_.duration / 1000) * AnimeConstants.PIXEL_PER_SEC;
         }
         return -1;
      }
      
      private function changeArrowCurosr(param1:Boolean) : void
      {
         if(!this.isResizing)
         {
            if(param1)
            {
               this.cursorID = CursorManager.setCursor(this.ArrowIcon,3,-10.5,-6);
            }
            else
            {
               CursorManager.removeCursor(this.cursorID);
            }
         }
      }
      
      private function enableDragScene(param1:MouseEvent) : void
      {
         this.isResizing = true;
         this.dispatchEvent(new ExtraDataEvent("ArrowClick",this,param1));
      }
      
      public function get speechText() : String
      {
         return this.speechLabel.text;
      }
      
      public function updateSpeechComment(param1:String, param2:AnimeSound) : void
      {
         this._boxSpeech.visible = param1 != "";
         this.speechLabel.text = param1;
         if(this._animeSound != param2)
         {
            this._wave.reset();
            this._animeSound = param2;
            if(param2 && param2.soundThumb)
            {
               param2.soundThumb.addEventListener(SoundEvent.WAVEFORM_LOADED,this.onSoundWaveformLoaded);
            }
         }
         this.setWaveformVisible(this._showWaveform);
      }
      
      private function drawWaveform() : void
      {
         if(this._animeSound && this._animeSound.soundThumb)
         {
            if(this._animeSound.soundThumb.waveform)
            {
               this._wave.init(this._animeSound.soundThumb.waveform.samples,SoundWaveformRenderer.WAVEFORM_COLOR_VOICE,false);
            }
         }
      }
      
      private function onSoundWaveformLoaded(param1:Event) : void
      {
         this.drawWaveform();
      }
      
      private function onTextOver() : void
      {
      }
      
      private function onTextOut() : void
      {
      }
      
      private function onTextUp() : void
      {
         var _loc4_:Asset = null;
         var _loc1_:String = Console.getConsole().linkageController.getSpeechSoundIdByScene(Console.getConsole().currentScene);
         var _loc2_:String = Console.getConsole().linkageController.getTargetIdOfSpeech(_loc1_);
         var _loc3_:Array = _loc2_.split(AssetLinkage.LINK);
         if(_loc3_.length > 1)
         {
            if(_loc3_[1] != "")
            {
               _loc4_ = Console.getConsole().currentScene.getCharacterById(_loc3_[1]);
               Console.getConsole().sceneController.preselectAssetId = _loc3_[1];
               Console.getConsole().currentScene.selectedAsset = _loc4_;
               Console.getConsole().showControl();
            }
            else
            {
               Console.getConsole().currentScene.selectedAsset = null;
               Console.getConsole().showOverTray(true,Console.getConsole().currentScene);
            }
         }
         Console.getConsole().propertiesWindow.showSpeechPanel();
      }
      
      private function onAddSceneBtnClick() : void
      {
         Console.getConsole().addNextScene();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.showMenu(this.stage.mouseX,this.stage.mouseY - 79);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:DragSource = null;
         var _loc3_:Image = null;
         if(!this.isResizing && this._focus && this._mouseDown)
         {
            _loc2_ = new DragSource();
            _loc2_.addData(this,"SceneElement");
            _loc3_ = new Image();
            _loc3_.source = new Bitmap(this.source);
            _loc3_.height = this.scene_img.height;
            _loc3_.width = this.scene_img.width;
            DragManager.doDrag(this,_loc2_,param1,_loc3_,-param1.localX,-param1.localY);
         }
         this.removeIndicator();
      }
      
      private function dragEnterHandler(param1:DragEvent) : void
      {
         if(param1.dragSource.hasFormat(TemplateThumb.DRAG_DATA_FORMAT) || param1.dragSource.hasFormat("SceneElement") && param1.dragSource.dataForFormat("SceneElement") != this)
         {
            DragManager.acceptDragDrop(SceneElement(param1.currentTarget));
         }
      }
      
      private function dragDropHandler(param1:DragEvent) : void
      {
         var _loc3_:SceneElement = null;
         var _loc4_:Number = NaN;
         var _loc5_:TemplateThumb = null;
         var _loc6_:ICommand = null;
         this._dropIndicator.visible = false;
         var _loc2_:Number = Number(this.label) - 1;
         if(this.mouseX > this.width / 2 || this.isSkippingDragDrop(param1))
         {
            _loc2_++;
         }
         if(param1.dragSource.hasFormat("SceneElement"))
         {
            _loc3_ = SceneElement(param1.dragSource.dataForFormat("SceneElement"));
            if((_loc4_ = Number(_loc3_.label) - 1) != _loc2_ && _loc2_ - _loc4_ != 1)
            {
               Console.getConsole().moveScene(_loc4_,_loc2_);
            }
         }
         else if(param1.dragSource.hasFormat(TemplateThumb.DRAG_DATA_FORMAT))
         {
            _loc5_ = TemplateThumb(param1.dragSource.dataForFormat(TemplateThumb.DRAG_DATA_FORMAT));
            (_loc6_ = new AddSceneTemplateCommand(Console.getConsole().movie,_loc5_,_loc2_,Console.getConsole().timeline)).execute();
         }
      }
      
      private function isSkippingDragDrop(param1:DragEvent) : Boolean
      {
         return false;
      }
      
      private function dragOverHandler(param1:DragEvent) : void
      {
         if(param1.dragSource.hasFormat(TemplateThumb.DRAG_DATA_FORMAT) || param1.dragSource.hasFormat("SceneElement") && param1.dragSource.dataForFormat("SceneElement") != this)
         {
            if(!this._dropIndicator.visible)
            {
               this._dropIndicator.visible = true;
            }
            if(this.mouseX > this.width / 2 || this.isSkippingDragDrop(param1))
            {
               this._dropIndicator.styleName = "insertAfter";
            }
            else
            {
               this._dropIndicator.styleName = "insertBefore";
            }
         }
      }
      
      private function dragExitHandler(param1:DragEvent) : void
      {
         this._dropIndicator.visible = false;
      }
      
      public function showTransIndication() : void
      {
         this.trans_cs.visible = true;
      }
      
      public function hideTransIndication() : void
      {
         this.trans_cs.visible = false;
      }
      
      public function updateTransTag() : void
      {
         if(this.transType == "" || this.transDur <= 0)
         {
            this.trans_cs.visible = false;
         }
         else
         {
            this.trans_cs.visible = false;
            this.hideTransIcon();
            this.trans_cs.width = UtilUnitConvert.frameToPixel(this.transDur);
            this.trans_cs.graphics.clear();
            this.trans_cs.graphics.beginFill(6710886,0.5);
            this.trans_cs.graphics.drawRoundRectComplex(0,0,this.trans_cs.width,this.trans_cs.height,0,10,0,10);
            this.trans_cs.graphics.endFill();
            try
            {
               Image(this[this.transType.toLowerCase()]).visible = true;
            }
            catch(e:Error)
            {
            }
            this.trans_cs.scrollRect = new Rectangle(0,0,this.trans_cs.width,this.trans_cs.height);
            this.trans_cs.visible = true;
         }
      }
      
      private function hideTransIcon() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.transIcon.numChildren)
         {
            this.transIcon.getChildAt(_loc1_).visible = false;
            _loc1_++;
         }
      }
      
      protected function onSceneRollOut(param1:MouseEvent) : void
      {
         if(this._focus)
         {
            this.sceneBg.styleName = "selectedSceneStyle";
            this.sceneBg.filters = [this.selectedSceneBevelFilter];
         }
         else
         {
            this.sceneBg.styleName = "sceneStyle";
            this.sceneBg.filters = [this.sceneBevelFilter];
         }
      }
      
      protected function onSceneRollOver(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this.sceneBg.styleName = "selectedSceneStyle";
            this.sceneBg.filters = [this.selectedSceneBevelFilter];
         }
      }
      
      protected function _boxSpeech_rollOverHandler(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this._boxSpeech.alpha = 1;
         }
      }
      
      protected function _boxSpeech_rollOutHandler(param1:MouseEvent) : void
      {
         this._boxSpeech.alpha = 0.6;
      }
      
      public function setWaveformVisible(param1:Boolean) : void
      {
         this._showWaveform = param1;
         if(this._wave)
         {
            this._wave.visible = param1;
         }
         if(this.speechLabel)
         {
            this.speechLabel.visible = !param1;
         }
         if(param1)
         {
            this.drawWaveform();
            if(this._animeSound && this._animeSound.soundThumb)
            {
               if(!(this._animeSound.soundThumb.sound is ProgressiveSound))
               {
                  this._wave.showWarning();
               }
               this._animeSound.soundThumb.loadWaveform();
            }
         }
      }
      
      private function _SceneElement_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 300;
         this.cce = _loc1_;
         BindingManager.executeBindings(this,"cce",this.cce);
         return _loc1_;
      }
      
      private function _SceneElement_BevelFilter3_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 2;
         _loc1_.highlightColor = 14212072;
         _loc1_.shadowColor = 11514820;
         _loc1_.blurX = 2;
         _loc1_.blurY = 2;
         this.overSceneBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"overSceneBevelFilter",this.overSceneBevelFilter);
         return _loc1_;
      }
      
      private function _SceneElement_BevelFilter5_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 1;
         _loc1_.highlightColor = 13225440;
         _loc1_.shadowColor = 10330550;
         _loc1_.blurX = 0;
         _loc1_.blurY = 0;
         this.overVoiceBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"overVoiceBevelFilter",this.overVoiceBevelFilter);
         return _loc1_;
      }
      
      private function _SceneElement_BevelFilter1_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 2;
         _loc1_.highlightColor = 12567769;
         _loc1_.shadowColor = 9804723;
         _loc1_.blurX = 2;
         _loc1_.blurY = 2;
         this.sceneBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"sceneBevelFilter",this.sceneBevelFilter);
         return _loc1_;
      }
      
      private function _SceneElement_BevelFilter2_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 2;
         _loc1_.highlightColor = 7637984;
         _loc1_.shadowColor = 4414652;
         _loc1_.blurX = 2;
         _loc1_.blurY = 2;
         this.selectedSceneBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"selectedSceneBevelFilter",this.selectedSceneBevelFilter);
         return _loc1_;
      }
      
      private function _SceneElement_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.angle = 90;
         _loc1_.color = 6710886;
         _loc1_.distance = 2;
         this.shadowFilter = _loc1_;
         BindingManager.executeBindings(this,"shadowFilter",this.shadowFilter);
         return _loc1_;
      }
      
      private function _SceneElement_BevelFilter4_i() : BevelFilter
      {
         var _loc1_:BevelFilter = new BevelFilter();
         _loc1_.angle = 45;
         _loc1_.distance = 1;
         _loc1_.highlightColor = 11910879;
         _loc1_.shadowColor = 8950454;
         _loc1_.blurX = 0;
         _loc1_.blurY = 0;
         this.voiceBevelFilter = _loc1_;
         BindingManager.executeBindings(this,"voiceBevelFilter",this.voiceBevelFilter);
         return _loc1_;
      }
      
      public function ___SceneElement_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function ___SceneElement_Canvas1_dragEnter(param1:DragEvent) : void
      {
         this.dragEnterHandler(param1);
      }
      
      public function ___SceneElement_Canvas1_dragDrop(param1:DragEvent) : void
      {
         this.dragDropHandler(param1);
      }
      
      public function ___SceneElement_Canvas1_dragOver(param1:DragEvent) : void
      {
         this.dragOverHandler(param1);
      }
      
      public function ___SceneElement_Canvas1_dragExit(param1:DragEvent) : void
      {
         this.dragExitHandler(param1);
      }
      
      public function ___sceneThumb_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      public function ___sceneThumb_mouseUp(param1:MouseEvent) : void
      {
         this.onMouseUpHandler(param1);
      }
      
      public function ___sceneThumb_mouseOver(param1:MouseEvent) : void
      {
         this.onMouseOverHandler(param1);
      }
      
      public function ___sceneThumb_mouseOut(param1:MouseEvent) : void
      {
         this.onMouseOutHandler(param1);
      }
      
      public function ___sceneThumb_rollOver(param1:MouseEvent) : void
      {
         this.onSceneRollOver(param1);
      }
      
      public function ___sceneThumb_rollOut(param1:MouseEvent) : void
      {
         this.onSceneRollOut(param1);
      }
      
      public function __left_cs_resize(param1:ResizeEvent) : void
      {
         this.drawArrow("left");
      }
      
      public function __right_cs_resize(param1:ResizeEvent) : void
      {
         this.drawArrow("right");
      }
      
      public function ___SceneElement_Canvas6_mouseMove(param1:MouseEvent) : void
      {
         this.onMouseMove(param1);
      }
      
      public function ___SceneElement_Canvas6_click(param1:MouseEvent) : void
      {
         this.onClick(param1);
      }
      
      public function __scene_img_creationComplete(param1:FlexEvent) : void
      {
         this.showImage();
      }
      
      public function __scene_lbl_creationComplete(param1:FlexEvent) : void
      {
         this.showLabel();
      }
      
      public function __arrow_cs_rollOver(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(true);
      }
      
      public function __arrow_cs_rollOut(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(false);
      }
      
      public function __arrow_cs_mouseDown(param1:MouseEvent) : void
      {
         this.enableDragScene(param1);
      }
      
      public function ___boxSpeech_rollOver(param1:MouseEvent) : void
      {
         this._boxSpeech_rollOverHandler(param1);
      }
      
      public function ___boxSpeech_rollOut(param1:MouseEvent) : void
      {
         this._boxSpeech_rollOutHandler(param1);
      }
      
      public function ___boxSpeech_click(param1:MouseEvent) : void
      {
         this.onTextUp();
      }
      
      public function ___btnAddScene_click(param1:MouseEvent) : void
      {
         this.onAddSceneBtnClick();
      }
      
      private function _SceneElement_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,null,function(param1:*):void
         {
            this.setStyle("creationCompleteEffect",param1);
         },"this.creationCompleteEffect","cce");
         result[1] = new Binding(this,function():Array
         {
            var _loc1_:* = [7829367,12961221,12961221,12961221];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },function(param1:Array):void
         {
            _SceneElement_GradientCanvas2.setStyle("borderColors",param1);
         },"_SceneElement_GradientCanvas2.borderColors");
         result[2] = new Binding(this,function():Array
         {
            var _loc1_:* = [shadowFilter];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"_SceneElement_GradientCanvas2.filters");
         result[3] = new Binding(this,function():Array
         {
            var _loc1_:* = [sceneBevelFilter];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"sceneBg.filters");
         result[4] = new Binding(this,function():Number
         {
            return _bg.width;
         },null,"_boxSpeech.width");
         result[5] = new Binding(this,function():Array
         {
            var _loc1_:* = [voiceBevelFilter];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },null,"_boxSpeech.filters");
         result[6] = new Binding(this,function():Number
         {
            return _bg.width - 12;
         },null,"speechLabel.width");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = speechLabel.text;
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_wave.toolTip");
         result[8] = new Binding(this,function():Number
         {
            return _bg.width;
         },null,"_btnAddScene.x");
         result[9] = new Binding(this,function():Array
         {
            var _loc1_:* = [13421772,16777215,11908533,13421772];
            return _loc1_ == null || _loc1_ is Array || _loc1_ is Proxy ? _loc1_ : [_loc1_];
         },function(param1:Array):void
         {
            _btnAddScene.setStyle("borderColors",param1);
         },"_btnAddScene.borderColors");
         return result;
      }
      
      mx_internal function _SceneElement_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_SceneElement_StylesInit_done)
         {
            return;
         }
         mx_internal::_SceneElement_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".insertBefore");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".insertBefore",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderSides = "left";
               this.borderStyle = "solid";
               this.borderColor = 8602632;
               this.borderThickness = 4;
            };
         }
         style = styleManager.getStyleDeclaration(".insertAfter");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".insertAfter",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderSides = "right";
               this.borderStyle = "solid";
               this.borderColor = 8602632;
               this.borderThickness = 4;
            };
         }
         style = styleManager.getStyleDeclaration(".bgStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".bgStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 11908533;
               this.borderColors = [11908533,11053224,11908533,13421772];
               this.backgroundAlpha = 1;
            };
         }
         style = styleManager.getStyleDeclaration(".selectedBgStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".selectedBgStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 5141729;
               this.borderColors = [5141729,5141729,5141729,5141729];
               this.backgroundAlpha = 0.7;
            };
         }
         style = styleManager.getStyleDeclaration(".sceneStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".sceneStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 11384014;
            };
         }
         style = styleManager.getStyleDeclaration(".selectedSceneStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".selectedSceneStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 5139416;
            };
         }
         style = styleManager.getStyleDeclaration(".overSceneStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".overSceneStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 13422817;
            };
         }
         style = styleManager.getStyleDeclaration(".voiceStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".voiceStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 10792920;
            };
         }
         style = styleManager.getStyleDeclaration(".overVoiceStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".overVoiceStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.backgroundColor = 12436185;
            };
         }
         style = styleManager.getStyleDeclaration(".btnAddSceneTimeline");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".btnAddSceneTimeline",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.upSkin = _embed_css_image_btn_addscene_init_png_1027061146_737562818;
               this.downSkin = _embed_css_image_btn_addscene_init_png_1027061146_737562818;
               this.overSkin = _embed_css_image_btn_addscene_over_png_1287719774_136525298;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Canvas
      {
         return this._94436_bg;
      }
      
      public function set _bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxSpeech() : Canvas
      {
         return this._738350834_boxSpeech;
      }
      
      public function set _boxSpeech(param1:Canvas) : void
      {
         var _loc2_:Object = this._738350834_boxSpeech;
         if(_loc2_ !== param1)
         {
            this._738350834_boxSpeech = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxSpeech",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnAddScene() : GradientCanvas
      {
         return this._89648856_btnAddScene;
      }
      
      public function set _btnAddScene(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._89648856_btnAddScene;
         if(_loc2_ !== param1)
         {
            this._89648856_btnAddScene = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnAddScene",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _dropIndicator() : Canvas
      {
         return this._635756001_dropIndicator;
      }
      
      public function set _dropIndicator(param1:Canvas) : void
      {
         var _loc2_:Object = this._635756001_dropIndicator;
         if(_loc2_ !== param1)
         {
            this._635756001_dropIndicator = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_dropIndicator",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _sceneThumb() : Canvas
      {
         return this._1136560567_sceneThumb;
      }
      
      public function set _sceneThumb(param1:Canvas) : void
      {
         var _loc2_:Object = this._1136560567_sceneThumb;
         if(_loc2_ !== param1)
         {
            this._1136560567_sceneThumb = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sceneThumb",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _wave() : SoundWaveformRenderer
      {
         return this._91376600_wave;
      }
      
      public function set _wave(param1:SoundWaveformRenderer) : void
      {
         var _loc2_:Object = this._91376600_wave;
         if(_loc2_ !== param1)
         {
            this._91376600_wave = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_wave",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get arrow_cs() : Canvas
      {
         return this._1280011162arrow_cs;
      }
      
      public function set arrow_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1280011162arrow_cs;
         if(_loc2_ !== param1)
         {
            this._1280011162arrow_cs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"arrow_cs",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get blinds() : Image
      {
         return this._1386333250blinds;
      }
      
      public function set blinds(param1:Image) : void
      {
         var _loc2_:Object = this._1386333250blinds;
         if(_loc2_ !== param1)
         {
            this._1386333250blinds = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"blinds",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cce() : Fade
      {
         return this._98309cce;
      }
      
      public function set cce(param1:Fade) : void
      {
         var _loc2_:Object = this._98309cce;
         if(_loc2_ !== param1)
         {
            this._98309cce = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cce",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cleanbrush() : Image
      {
         return this._844601711cleanbrush;
      }
      
      public function set cleanbrush(param1:Image) : void
      {
         var _loc2_:Object = this._844601711cleanbrush;
         if(_loc2_ !== param1)
         {
            this._844601711cleanbrush = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cleanbrush",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cleanhand() : Image
      {
         return this._1274009032cleanhand;
      }
      
      public function set cleanhand(param1:Image) : void
      {
         var _loc2_:Object = this._1274009032cleanhand;
         if(_loc2_ !== param1)
         {
            this._1274009032cleanhand = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cleanhand",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fade() : Image
      {
         return this._3135100fade;
      }
      
      public function set fade(param1:Image) : void
      {
         var _loc2_:Object = this._3135100fade;
         if(_loc2_ !== param1)
         {
            this._3135100fade = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fade",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadedark() : Image
      {
         return this._525805554fadedark;
      }
      
      public function set fadedark(param1:Image) : void
      {
         var _loc2_:Object = this._525805554fadedark;
         if(_loc2_ !== param1)
         {
            this._525805554fadedark = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadedark",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesbadtransmission() : Image
      {
         return this._1722173355fesbadtransmission;
      }
      
      public function set fesbadtransmission(param1:Image) : void
      {
         var _loc2_:Object = this._1722173355fesbadtransmission;
         if(_loc2_ !== param1)
         {
            this._1722173355fesbadtransmission = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesbadtransmission",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesbrightsquares_11() : Image
      {
         return this._932325865fesbrightsquares_11;
      }
      
      public function set fesbrightsquares_11(param1:Image) : void
      {
         var _loc2_:Object = this._932325865fesbrightsquares_11;
         if(_loc2_ !== param1)
         {
            this._932325865fesbrightsquares_11 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesbrightsquares_11",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesbrightsquares_13() : Image
      {
         return this._932325863fesbrightsquares_13;
      }
      
      public function set fesbrightsquares_13(param1:Image) : void
      {
         var _loc2_:Object = this._932325863fesbrightsquares_13;
         if(_loc2_ !== param1)
         {
            this._932325863fesbrightsquares_13 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesbrightsquares_13",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesdesertillusion() : Image
      {
         return this._1437798838fesdesertillusion;
      }
      
      public function set fesdesertillusion(param1:Image) : void
      {
         var _loc2_:Object = this._1437798838fesdesertillusion;
         if(_loc2_ !== param1)
         {
            this._1437798838fesdesertillusion = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesdesertillusion",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesdisc() : Image
      {
         return this._963072215fesdisc;
      }
      
      public function set fesdisc(param1:Image) : void
      {
         var _loc2_:Object = this._963072215fesdisc;
         if(_loc2_ !== param1)
         {
            this._963072215fesdisc = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesdisc",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesintersectingstripes_1() : Image
      {
         return this._229534177fesintersectingstripes_1;
      }
      
      public function set fesintersectingstripes_1(param1:Image) : void
      {
         var _loc2_:Object = this._229534177fesintersectingstripes_1;
         if(_loc2_ !== param1)
         {
            this._229534177fesintersectingstripes_1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesintersectingstripes_1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesintersectingstripes_4() : Image
      {
         return this._229534180fesintersectingstripes_4;
      }
      
      public function set fesintersectingstripes_4(param1:Image) : void
      {
         var _loc2_:Object = this._229534180fesintersectingstripes_4;
         if(_loc2_ !== param1)
         {
            this._229534180fesintersectingstripes_4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesintersectingstripes_4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get feslightstripes() : Image
      {
         return this._2034205308feslightstripes;
      }
      
      public function set feslightstripes(param1:Image) : void
      {
         var _loc2_:Object = this._2034205308feslightstripes;
         if(_loc2_ !== param1)
         {
            this._2034205308feslightstripes = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"feslightstripes",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fessparkle_1() : Image
      {
         return this._1830622772fessparkle_1;
      }
      
      public function set fessparkle_1(param1:Image) : void
      {
         var _loc2_:Object = this._1830622772fessparkle_1;
         if(_loc2_ !== param1)
         {
            this._1830622772fessparkle_1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fessparkle_1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fessparkle_4() : Image
      {
         return this._1830622775fessparkle_4;
      }
      
      public function set fessparkle_4(param1:Image) : void
      {
         var _loc2_:Object = this._1830622775fessparkle_4;
         if(_loc2_ !== param1)
         {
            this._1830622775fessparkle_4 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fessparkle_4",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesunpack_1() : Image
      {
         return this._1213332216fesunpack_1;
      }
      
      public function set fesunpack_1(param1:Image) : void
      {
         var _loc2_:Object = this._1213332216fesunpack_1;
         if(_loc2_ !== param1)
         {
            this._1213332216fesunpack_1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesunpack_1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesunpack_2() : Image
      {
         return this._1213332217fesunpack_2;
      }
      
      public function set fesunpack_2(param1:Image) : void
      {
         var _loc2_:Object = this._1213332217fesunpack_2;
         if(_loc2_ !== param1)
         {
            this._1213332217fesunpack_2 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesunpack_2",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fesunpack_8() : Image
      {
         return this._1213332223fesunpack_8;
      }
      
      public function set fesunpack_8(param1:Image) : void
      {
         var _loc2_:Object = this._1213332223fesunpack_8;
         if(_loc2_ !== param1)
         {
            this._1213332223fesunpack_8 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fesunpack_8",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get feszoomblur() : Image
      {
         return this._2087589298feszoomblur;
      }
      
      public function set feszoomblur(param1:Image) : void
      {
         var _loc2_:Object = this._2087589298feszoomblur;
         if(_loc2_ !== param1)
         {
            this._2087589298feszoomblur = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"feszoomblur",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fly() : Image
      {
         return this._101491fly;
      }
      
      public function set fly(param1:Image) : void
      {
         var _loc2_:Object = this._101491fly;
         if(_loc2_ !== param1)
         {
            this._101491fly = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fly",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get iris() : Image
      {
         return this._3240979iris;
      }
      
      public function set iris(param1:Image) : void
      {
         var _loc2_:Object = this._3240979iris;
         if(_loc2_ !== param1)
         {
            this._3240979iris = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"iris",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get left_cs() : Canvas
      {
         return this._55443368left_cs;
      }
      
      public function set left_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._55443368left_cs;
         if(_loc2_ !== param1)
         {
            this._55443368left_cs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"left_cs",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mainBg() : GradientCanvas
      {
         return this._1081572386mainBg;
      }
      
      public function set mainBg(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._1081572386mainBg;
         if(_loc2_ !== param1)
         {
            this._1081572386mainBg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainBg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get no() : Image
      {
         return this._3521no;
      }
      
      public function set no(param1:Image) : void
      {
         var _loc2_:Object = this._3521no;
         if(_loc2_ !== param1)
         {
            this._3521no = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"no",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get overSceneBevelFilter() : BevelFilter
      {
         return this._517012826overSceneBevelFilter;
      }
      
      public function set overSceneBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._517012826overSceneBevelFilter;
         if(_loc2_ !== param1)
         {
            this._517012826overSceneBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"overSceneBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get overVoiceBevelFilter() : BevelFilter
      {
         return this._1101361396overVoiceBevelFilter;
      }
      
      public function set overVoiceBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._1101361396overVoiceBevelFilter;
         if(_loc2_ !== param1)
         {
            this._1101361396overVoiceBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"overVoiceBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get photo() : Image
      {
         return this._106642994photo;
      }
      
      public function set photo(param1:Image) : void
      {
         var _loc2_:Object = this._106642994photo;
         if(_loc2_ !== param1)
         {
            this._106642994photo = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"photo",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get pixeldissolve() : Image
      {
         return this._1264957687pixeldissolve;
      }
      
      public function set pixeldissolve(param1:Image) : void
      {
         var _loc2_:Object = this._1264957687pixeldissolve;
         if(_loc2_ !== param1)
         {
            this._1264957687pixeldissolve = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pixeldissolve",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get right_cs() : Canvas
      {
         return this._1436079757right_cs;
      }
      
      public function set right_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1436079757right_cs;
         if(_loc2_ !== param1)
         {
            this._1436079757right_cs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"right_cs",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rotate() : Image
      {
         return this._925180581rotate;
      }
      
      public function set rotate(param1:Image) : void
      {
         var _loc2_:Object = this._925180581rotate;
         if(_loc2_ !== param1)
         {
            this._925180581rotate = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rotate",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sceneBevelFilter() : BevelFilter
      {
         return this._1675320218sceneBevelFilter;
      }
      
      public function set sceneBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._1675320218sceneBevelFilter;
         if(_loc2_ !== param1)
         {
            this._1675320218sceneBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get sceneBg() : GradientCanvas
      {
         return this._1914646001sceneBg;
      }
      
      public function set sceneBg(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._1914646001sceneBg;
         if(_loc2_ !== param1)
         {
            this._1914646001sceneBg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneBg",_loc2_,param1));
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
      public function get selectedBg() : GradientCanvas
      {
         return this._1655455680selectedBg;
      }
      
      public function set selectedBg(param1:GradientCanvas) : void
      {
         var _loc2_:Object = this._1655455680selectedBg;
         if(_loc2_ !== param1)
         {
            this._1655455680selectedBg = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selectedBg",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get selectedSceneBevelFilter() : BevelFilter
      {
         return this._1906591009selectedSceneBevelFilter;
      }
      
      public function set selectedSceneBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._1906591009selectedSceneBevelFilter;
         if(_loc2_ !== param1)
         {
            this._1906591009selectedSceneBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selectedSceneBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shadowFilter() : DropShadowFilter
      {
         return this._1956980552shadowFilter;
      }
      
      public function set shadowFilter(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._1956980552shadowFilter;
         if(_loc2_ !== param1)
         {
            this._1956980552shadowFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shadowFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechLabel() : Label
      {
         return this._1754383154speechLabel;
      }
      
      public function set speechLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1754383154speechLabel;
         if(_loc2_ !== param1)
         {
            this._1754383154speechLabel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechLabel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get squeeze() : Image
      {
         return this._1965003230squeeze;
      }
      
      public function set squeeze(param1:Image) : void
      {
         var _loc2_:Object = this._1965003230squeeze;
         if(_loc2_ !== param1)
         {
            this._1965003230squeeze = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"squeeze",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get transIcon() : Canvas
      {
         return this._1051791169transIcon;
      }
      
      public function set transIcon(param1:Canvas) : void
      {
         var _loc2_:Object = this._1051791169transIcon;
         if(_loc2_ !== param1)
         {
            this._1051791169transIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"transIcon",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get trans_cs() : Canvas
      {
         return this._1280875879trans_cs;
      }
      
      public function set trans_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1280875879trans_cs;
         if(_loc2_ !== param1)
         {
            this._1280875879trans_cs = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"trans_cs",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get voiceBevelFilter() : BevelFilter
      {
         return this._1090971648voiceBevelFilter;
      }
      
      public function set voiceBevelFilter(param1:BevelFilter) : void
      {
         var _loc2_:Object = this._1090971648voiceBevelFilter;
         if(_loc2_ !== param1)
         {
            this._1090971648voiceBevelFilter = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"voiceBevelFilter",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wipe() : Image
      {
         return this._3649607wipe;
      }
      
      public function set wipe(param1:Image) : void
      {
         var _loc2_:Object = this._3649607wipe;
         if(_loc2_ !== param1)
         {
            this._3649607wipe = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wipe",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get wipehand() : Image
      {
         return this._1057426122wipehand;
      }
      
      public function set wipehand(param1:Image) : void
      {
         var _loc2_:Object = this._1057426122wipehand;
         if(_loc2_ !== param1)
         {
            this._1057426122wipehand = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"wipehand",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get zoom() : Image
      {
         return this._3744723zoom;
      }
      
      public function set zoom(param1:Image) : void
      {
         var _loc2_:Object = this._3744723zoom;
         if(_loc2_ !== param1)
         {
            this._3744723zoom = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"zoom",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get ArrowIcon() : Class
      {
         return this._977672194ArrowIcon;
      }
      
      private function set ArrowIcon(param1:Class) : void
      {
         var _loc2_:Object = this._977672194ArrowIcon;
         if(_loc2_ !== param1)
         {
            this._977672194ArrowIcon = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ArrowIcon",_loc2_,param1));
            }
         }
      }
   }
}
