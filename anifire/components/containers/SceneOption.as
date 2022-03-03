package anifire.components.containers
{
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.components.studio.TimeStepper;
   import anifire.core.AnimeScene;
   import anifire.core.GoTransition;
   import anifire.events.SceneEvent;
   import anifire.events.SceneOptionEvent;
   import anifire.interfaces.ISceneModel;
   import anifire.util.UtilDict;
   import anifire.util.UtilEffect;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilUnitConvert;
   import caurina.transitions.Tweener;
   import com.IconComboBox;
   import com.jumpeye.flashEff2.core.interfaces.IFlashEffSymbol;
   import com.jumpeye.flashEff2.symbol.brightSquares.FESBrightSquares;
   import fl.transitions.Transition;
   import fl.transitions.TransitionManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import flash.utils.setTimeout;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.ComboBox;
   import mx.controls.HRule;
   import mx.controls.Label;
   import mx.controls.NumericStepper;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.SWFLoader;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.DropdownEvent;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.NumericStepperEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class SceneOption extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _SceneOption_Label10:Label;
      
      public var _SceneOption_Label11:Label;
      
      public var _SceneOption_Label12:Label;
      
      public var _SceneOption_Label13:Label;
      
      public var _SceneOption_Label14:Label;
      
      public var _SceneOption_Label2:Label;
      
      public var _SceneOption_Label3:Label;
      
      public var _SceneOption_Label4:Label;
      
      public var _SceneOption_Label5:Label;
      
      public var _SceneOption_Label6:Label;
      
      public var _SceneOption_Label7:Label;
      
      public var _SceneOption_Label8:Label;
      
      public var _SceneOption_Label9:Label;
      
      private var _1649812428_oSizeStrips:HBox;
      
      private var _91139623_occw:HBox;
      
      private var _1815154999_odegrees:HBox;
      
      private var _344862858_odimension:HBox;
      
      private var _228520221_oninedirection:HBox;
      
      private var _1984503185_onumStrips:HBox;
      
      private var _1700739505_oshape:HBox;
      
      private var _595240418_oshiftPoint:HBox;
      
      private var _192671294_ostartPoint:HBox;
      
      private var _1524186722_otargetColor:HBox;
      
      private var _383439658_oxSections:HBox;
      
      private var _2104073175_oySections:HBox;
      
      private var _1956054803_vSizeStrips:ComboBox;
      
      private var _91348160_vccw:RadioButtonGroup;
      
      private var _1886238833_vccw_0:RadioButton;
      
      private var _1886238834_vccw_1:RadioButton;
      
      private var _1129925456_vdegrees:NumericStepper;
      
      private var _1720457393_vdimension:RadioButtonGroup;
      
      private var _202857280_vdimension_0:RadioButton;
      
      private var _202857281_vdimension_1:RadioButton;
      
      private var _984577142_vninedirection:IconComboBox;
      
      private var _608908650_vnumStrips:NumericStepper;
      
      private var _1901143562_vshape:RadioButtonGroup;
      
      private var _888375461_vshape_CIRCLE:RadioButton;
      
      private var _1353917682_vshape_SQUARE:RadioButton;
      
      private var _288998043_vshiftPoint:NumericStepper;
      
      private var _498913669_vstartPoint:NumericStepper;
      
      private var _1867201541_vtargetColor:ComboBox;
      
      private var _1759034193_vxSections:NumericStepper;
      
      private var _728478640_vySections:NumericStepper;
      
      private var _1368023827cbEase:ComboBox;
      
      private var _555276681cbTrans:IconComboBox;
      
      private var _99469dir:Label;
      
      private var _126232784durationPanel:SceneDurationPanel;
      
      private var _3365863myId:Label;
      
      private var _1249474914options:VBox;
      
      private var _1259656344preview_cleanbrush:SWFLoader;
      
      private var _1148850559preview_cleanhand:SWFLoader;
      
      private var _83557427preview_wipehand:SWFLoader;
      
      private var _3646rp:Label;
      
      private var _1893554479stepper:TimeStepper;
      
      private var _360200772transAnimation:Canvas;
      
      private var _167427072transPreview:Canvas;
      
      private var _1753389541transSquare:Canvas;
      
      private var _111964085vbDur:HBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _target:AnimeScene;
      
      private var _524296131_effects:Array;
      
      private var _1478918842_eases:Array;
      
      private var _selectedTrans:String;
      
      private var _selectedEase:String;
      
      private var _selectedDur:Number;
      
      private var _selectedParam:UtilHashArray;
      
      public const trans_null:Class = SceneOption_trans_null;
      
      public const trans_blinds:Class = SceneOption_trans_blinds;
      
      public const trans_fade:Class = SceneOption_trans_fade;
      
      public const trans_fadedark:Class = SceneOption_trans_fadedark;
      
      public const trans_fly:Class = SceneOption_trans_fly;
      
      public const trans_iris:Class = SceneOption_trans_iris;
      
      public const trans_photo:Class = SceneOption_trans_photo;
      
      public const trans_pixeldissolve:Class = SceneOption_trans_pixeldissolve;
      
      public const trans_rotate:Class = SceneOption_trans_rotate;
      
      public const trans_squeeze:Class = SceneOption_trans_squeeze;
      
      public const trans_wipe:Class = SceneOption_trans_wipe;
      
      public const trans_wipehand:Class = SceneOption_trans_wipehand;
      
      public const trans_zoom:Class = SceneOption_trans_zoom;
      
      public const trans_cleanhand:Class = SceneOption_trans_cleanhand;
      
      public const trans_cleanbrush:Class = SceneOption_trans_cleanbrush;
      
      public const trans_FESBadTransmission:Class = SceneOption_trans_FESBadTransmission;
      
      public const trans_FESZoomBlur:Class = SceneOption_trans_FESZoomBlur;
      
      public const trans_FESBrightSquares_11:Class = SceneOption_trans_FESBrightSquares_11;
      
      public const trans_FESBrightSquares_13:Class = SceneOption_trans_FESBrightSquares_13;
      
      public const trans_FESDesertIllusion:Class = SceneOption_trans_FESDesertIllusion;
      
      public const trans_FESSparkle_1:Class = SceneOption_trans_FESSparkle_1;
      
      public const trans_FESSparkle_4:Class = SceneOption_trans_FESSparkle_4;
      
      public const trans_FESUnpack_2:Class = SceneOption_trans_FESUnpack_2;
      
      public const trans_FESUnpack_1:Class = SceneOption_trans_FESUnpack_1;
      
      public const trans_FESLightStripes:Class = SceneOption_trans_FESLightStripes;
      
      public const trans_FESIntersectingStripes_4:Class = SceneOption_trans_FESIntersectingStripes_4;
      
      public const trans_FESIntersectingStripes_1:Class = SceneOption_trans_FESIntersectingStripes_1;
      
      public const trans_FESUnpack_8:Class = SceneOption_trans_FESUnpack_8;
      
      public const trans_FESDisc:Class = SceneOption_trans_FESDisc;
      
      public const arr_uppercenter:Class = SceneOption_arr_uppercenter;
      
      public const arr_upperright:Class = SceneOption_arr_upperright;
      
      public const arr_right:Class = SceneOption_arr_right;
      
      public const arr_lowerright:Class = SceneOption_arr_lowerright;
      
      public const arr_lowercenter:Class = SceneOption_arr_lowercenter;
      
      public const arr_lowerleft:Class = SceneOption_arr_lowerleft;
      
      public const arr_left:Class = SceneOption_arr_left;
      
      public const arr_upperleft:Class = SceneOption_arr_upperleft;
      
      public const arr_center:Class = SceneOption_arr_center;
      
      public const scr_a:Class = SceneOption_scr_a;
      
      private var _1150762943_directionArr:Array;
      
      private var myEffect:FlashEff2Flex;
      
      private var _embed_mxml__________styles_images_img_backdrop_png_647253625:Class;
      
      private var _embed_mxml__________styles_images_prev_clean_brush_swf_1264523655:Class;
      
      private var _embed_mxml__________styles_images_prev_clean_hand_swf_1406966255:Class;
      
      private var _embed_mxml__________styles_images_img_b_png_700051929:Class;
      
      private var _embed_mxml__________styles_images_prev_wipe_hand_swf_735812209:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function SceneOption()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___SceneOption_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 5;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "id":"myId",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "includeInLayout":false,
                                 "visible":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":SceneDurationPanel,
                           "id":"durationPanel"
                        }),new UIComponentDescriptor({
                           "type":HRule,
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_SceneOption_Label2"
                        }),new UIComponentDescriptor({
                           "type":IconComboBox,
                           "id":"cbTrans",
                           "events":{
                              "change":"__cbTrans_change",
                              "itemRollOver":"__cbTrans_itemRollOver",
                              "close":"__cbTrans_close",
                              "mouseOut":"__cbTrans_mouseOut"
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":200,
                                 "height":36,
                                 "dropdownWidth":180,
                                 "buttonMode":true,
                                 "styleName":"cbSidePanel",
                                 "iconFunction":geticon
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ComboBox,
                           "id":"cbEase",
                           "events":{"change":"__cbEase_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "buttonMode":true,
                                 "styleName":"cbSidePanel",
                                 "visible":false,
                                 "includeInLayout":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"vbDur",
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 4;
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SceneOption_Label3"
                                 }),new UIComponentDescriptor({
                                    "type":TimeStepper,
                                    "id":"stepper",
                                    "events":{"change":"__stepper_change"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "minimum":0.5,
                                          "maximum":10,
                                          "stepSize":0.5
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "id":"options",
                           "stylesFactory":function():void
                           {
                              this.verticalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_onumStrips",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label4"
                                    }),new UIComponentDescriptor({
                                       "type":NumericStepper,
                                       "id":"_vnumStrips",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "stepSize":5,
                                             "minimum":5,
                                             "visible":false,
                                             "includeInLayout":false,
                                             "styleName":"nsSidePanel"
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_oSizeStrips",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label5"
                                    }),new UIComponentDescriptor({
                                       "type":ComboBox,
                                       "id":"_vSizeStrips",
                                       "events":{
                                          "change":"___vSizeStrips_change",
                                          "creationComplete":"___vSizeStrips_creationComplete"
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {"styleName":"cbSidePanel"};
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_odimension",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label6"
                                    }),new UIComponentDescriptor({
                                       "type":RadioButton,
                                       "id":"_vdimension_0",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "groupName":"_vdimension",
                                             "value":0
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":RadioButton,
                                       "id":"_vdimension_1",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "groupName":"_vdimension",
                                             "value":1
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_ostartPoint",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label7"
                                    }),new UIComponentDescriptor({
                                       "type":NumericStepper,
                                       "id":"_vstartPoint",
                                       "events":{"change":"___vstartPoint_change"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "stepSize":1,
                                             "minimum":1,
                                             "maximum":9,
                                             "styleName":"nsSidePanel"
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_oshape",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label8"
                                    }),new UIComponentDescriptor({
                                       "type":RadioButton,
                                       "id":"_vshape_CIRCLE",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "groupName":"_vshape",
                                             "value":"CIRCLE"
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":RadioButton,
                                       "id":"_vshape_SQUARE",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "groupName":"_vshape",
                                             "value":"SQUARE"
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_occw",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label9"
                                    }),new UIComponentDescriptor({
                                       "type":RadioButton,
                                       "id":"_vccw_0",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "groupName":"_vccw",
                                             "value":0
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":RadioButton,
                                       "id":"_vccw_1",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "groupName":"_vccw",
                                             "value":1
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_odegrees",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label10"
                                    }),new UIComponentDescriptor({
                                       "type":NumericStepper,
                                       "id":"_vdegrees",
                                       "events":{"change":"___vdegrees_change"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "stepSize":10,
                                             "minimum":180,
                                             "maximum":720,
                                             "styleName":"nsSidePanel"
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_oxSections",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label11"
                                    }),new UIComponentDescriptor({
                                       "type":NumericStepper,
                                       "id":"_vxSections",
                                       "events":{"change":"___vxSections_change"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "stepSize":5,
                                             "maximum":50,
                                             "minimum":5,
                                             "styleName":"nsSidePanel"
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_oySections",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label12"
                                    }),new UIComponentDescriptor({
                                       "type":NumericStepper,
                                       "id":"_vySections",
                                       "events":{"change":"___vySections_change"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "stepSize":5,
                                             "maximum":50,
                                             "minimum":5,
                                             "styleName":"nsSidePanel"
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_oshiftPoint",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label13"
                                    }),new UIComponentDescriptor({
                                       "type":NumericStepper,
                                       "id":"_vshiftPoint",
                                       "events":{"change":"___vshiftPoint_change"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "stepSize":1,
                                             "minimum":1,
                                             "maximum":9,
                                             "styleName":"nsSidePanel"
                                          };
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_otargetColor",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"_SceneOption_Label14"
                                    }),new UIComponentDescriptor({
                                       "type":ComboBox,
                                       "id":"_vtargetColor",
                                       "events":{
                                          "change":"___vtargetColor_change",
                                          "creationComplete":"___vtargetColor_creationComplete"
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {"styleName":"cbSidePanel"};
                                       }
                                    })]};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HBox,
                                 "id":"_oninedirection",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalAlign = "middle";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {"childDescriptors":[new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"rp"
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"dir"
                                    }),new UIComponentDescriptor({
                                       "type":IconComboBox,
                                       "id":"_vninedirection",
                                       "events":{"change":"___vninedirection_change"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":150,
                                             "dropdownWidth":140,
                                             "buttonMode":true,
                                             "styleName":"cbSidePanel",
                                             "iconFunction":geticon
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
                  "type":Canvas,
                  "id":"transPreview",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":73,
                        "height":43,
                        "visible":false,
                        "clipContent":true,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":SWFLoader,
                           "propertiesFactory":function():Object
                           {
                              return {"source":_embed_mxml__________styles_images_img_backdrop_png_647253625};
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"transSquare",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":11.5,
                                 "y":2.5,
                                 "width":55,
                                 "height":38,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":SWFLoader,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"source":_embed_mxml__________styles_images_img_b_png_700051929};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"transAnimation",
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "x":11.5,
                                 "y":2.5,
                                 "width":55,
                                 "height":38,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":SWFLoader,
                                    "id":"preview_cleanhand",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "source":_embed_mxml__________styles_images_prev_clean_hand_swf_1406966255,
                                          "visible":false
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":SWFLoader,
                                    "id":"preview_cleanbrush",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "source":_embed_mxml__________styles_images_prev_clean_brush_swf_1264523655,
                                          "visible":false
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":SWFLoader,
                                    "id":"preview_wipehand",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "source":_embed_mxml__________styles_images_prev_wipe_hand_swf_735812209,
                                          "visible":false
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
         this.myEffect = new FlashEff2Flex();
         this._embed_mxml__________styles_images_img_backdrop_png_647253625 = SceneOption__embed_mxml__________styles_images_img_backdrop_png_647253625;
         this._embed_mxml__________styles_images_prev_clean_brush_swf_1264523655 = SceneOption__embed_mxml__________styles_images_prev_clean_brush_swf_1264523655;
         this._embed_mxml__________styles_images_prev_clean_hand_swf_1406966255 = SceneOption__embed_mxml__________styles_images_prev_clean_hand_swf_1406966255;
         this._embed_mxml__________styles_images_img_b_png_700051929 = SceneOption__embed_mxml__________styles_images_img_b_png_700051929;
         this._embed_mxml__________styles_images_prev_wipe_hand_swf_735812209 = SceneOption__embed_mxml__________styles_images_prev_wipe_hand_swf_735812209;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._SceneOption_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_containers_SceneOptionWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return SceneOption[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.styleName = "popupWindow";
         this.percentWidth = 100;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._SceneOption_RadioButtonGroup3_i();
         this._SceneOption_RadioButtonGroup1_i();
         this._SceneOption_RadioButtonGroup2_i();
         this.addEventListener("creationComplete",this.___SceneOption_Canvas1_creationComplete);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         SceneOption._watcherSetupUtil = param1;
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
      
      public function set target(param1:Object) : void
      {
         if(param1 is AnimeScene)
         {
            if(this._target)
            {
               this._target.removeEventListener(SceneEvent.TRANSITION_CHANGE,this.onSceneTransitionChange);
            }
            this._target = AnimeScene(param1);
            this.myId.text = this._target.id;
            this.updatePanel();
            if(this._target)
            {
               this._target.addEventListener(SceneEvent.TRANSITION_CHANGE,this.onSceneTransitionChange);
            }
         }
         this.durationPanel.sceneModel = param1 as ISceneModel;
      }
      
      private function onSceneTransitionChange(param1:Event) : void
      {
         if(this._target && this._target.transition)
         {
            this.stepper.value = UtilUnitConvert.frameToDuration(this._target.transition.duration);
         }
      }
      
      private function init() : void
      {
         this.updateDirectionArr();
      }
      
      private function updateDirectionArr(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true, param6:Boolean = true, param7:Boolean = true, param8:Boolean = true, param9:Boolean = true) : void
      {
         this._directionArr = new Array();
         if(param5)
         {
            this._directionArr.push({
               "id":"center",
               "label":UtilDict.toDisplay("go","Center"),
               "icon":"arr_center",
               "value":5
            });
         }
         if(param1)
         {
            this._directionArr.push({
               "id":"upperleft",
               "label":UtilDict.toDisplay("go","Upper Left"),
               "icon":"arr_upperleft",
               "value":1
            });
         }
         if(param2)
         {
            this._directionArr.push({
               "id":"uppercenter",
               "label":UtilDict.toDisplay("go","Upper Center"),
               "icon":"arr_uppercenter",
               "value":2
            });
         }
         if(param3)
         {
            this._directionArr.push({
               "id":"upperright",
               "label":UtilDict.toDisplay("go","Upper Right"),
               "icon":"arr_upperright",
               "value":3
            });
         }
         if(param4)
         {
            this._directionArr.push({
               "id":"left",
               "label":UtilDict.toDisplay("go","Middle Left"),
               "icon":"arr_left",
               "value":4
            });
         }
         if(param6)
         {
            this._directionArr.push({
               "id":"right",
               "label":UtilDict.toDisplay("go","Middle Right"),
               "icon":"arr_right",
               "value":6
            });
         }
         if(param7)
         {
            this._directionArr.push({
               "id":"lowerleft",
               "label":UtilDict.toDisplay("go","Lower Left"),
               "icon":"arr_lowerleft",
               "value":7
            });
         }
         if(param8)
         {
            this._directionArr.push({
               "id":"lowercenter",
               "label":UtilDict.toDisplay("go","Lower Center"),
               "icon":"arr_lowercenter",
               "value":8
            });
         }
         if(param9)
         {
            this._directionArr.push({
               "id":"lowerright",
               "label":UtilDict.toDisplay("go","Lower Right"),
               "icon":"arr_lowerright",
               "value":9
            });
         }
      }
      
      private function updatePanel() : void
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         if(!this._effects)
         {
            this._effects = new Array();
            _loc1_ = UtilEffect.getTransitions();
            for each(_loc2_ in _loc1_)
            {
               this._effects.push({
                  "id":String(_loc2_),
                  "label":UtilDict.toDisplay("go",UtilEffect.getLabelById(String(_loc2_))),
                  "icon":"trans_" + String(_loc2_)
               });
            }
            this._effects.sortOn("label");
            _loc3_ = new Array();
            _loc3_.push({
               "id":null,
               "label":UtilDict.toDisplay("go","No Transition"),
               "icon":"trans_null"
            });
            this._effects = _loc3_.concat(this._effects);
         }
         if(!this._eases)
         {
            this._eases = new Array();
            _loc1_ = UtilEffect.getEffects();
            for each(_loc2_ in _loc1_)
            {
               this._eases.push({
                  "id":String(_loc2_),
                  "label":UtilDict.toDisplay("go",String(_loc2_))
               });
            }
            this._eases.sortOn("id");
            (_loc4_ = new Array()).push({
               "id":"easeNone",
               "label":"easeNone"
            });
            this._eases = _loc4_.concat(this._eases);
         }
         this.onDurChange(false);
         setTimeout(this.onEaseChange,500,false);
         this.restoreSceneSelection();
         this.updateParamForm();
      }
      
      private function restoreParamValue() : void
      {
         switch(this._selectedTrans)
         {
            case "Fly":
            case "Wipe":
            case "Rotate":
               this.updateDirectionArr(true,true,true,true,false,true,true,true,true);
               break;
            case "Iris":
            case "Squeeze":
            case "Zoom":
               this.updateDirectionArr();
         }
         var _loc1_:UtilHashArray = UtilEffect.getTransitionParamByType(this._selectedTrans);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            switch(_loc1_.getKey(_loc2_))
            {
               case "dimension":
               case "shape":
               case "ccw":
                  RadioButtonGroup(this["_v" + _loc1_.getKey(_loc2_)]).selection = RadioButtonGroup(this["_v" + _loc1_.getKey(_loc2_)]).getRadioButtonAt(0);
                  break;
               case "targetColor":
                  ComboBox(this["_v" + _loc1_.getKey(_loc2_)]).selectedIndex = 0;
                  break;
               case "numStrips":
               case "xSections":
               case "ySections":
                  ComboBox(this._vSizeStrips).selectedIndex = 1;
                  NumericStepper(this["_v" + _loc1_.getKey(_loc2_)]).value = ComboBox(this._vSizeStrips).selectedItem.value;
                  break;
               case "startPoint":
               case "shiftPoint":
                  IconComboBox(this._vninedirection).selectedIndex = 0;
                  NumericStepper(this["_v" + _loc1_.getKey(_loc2_)]).value = IconComboBox(this._vninedirection).selectedItem.value;
                  break;
               default:
                  NumericStepper(this["_v" + _loc1_.getKey(_loc2_)]).value = NumericStepper(this["_v" + _loc1_.getKey(_loc2_)]).minimum;
                  break;
            }
            _loc2_++;
         }
      }
      
      private function getDirectionReplaced() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("startPoint");
         _loc1_.push("shiftPoint");
         return _loc1_;
      }
      
      private function updateParamForm() : void
      {
         var _loc3_:String = null;
         this.options.invalidateDisplayList();
         this.options.visible = false;
         var _loc1_:UtilHashArray = UtilEffect.getTransitionParamByType(this._selectedTrans);
         this.setOptionVisible("_onumStrips",false);
         this.setOptionVisible("_odimension",false);
         this.setOptionVisible("_ostartPoint",false);
         this.setOptionVisible("_oshape",false);
         this.setOptionVisible("_occw",false);
         this.setOptionVisible("_odegrees",false);
         this.setOptionVisible("_oxSections",false);
         this.setOptionVisible("_oySections",false);
         this.setOptionVisible("_oshiftPoint",false);
         this.setOptionVisible("_otargetColor",false);
         this.setOptionVisible("_oninedirection",false);
         this.setOptionVisible("_oSizeStrips",false);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_.getKey(_loc2_);
            if(this.getDirectionReplaced().indexOf(_loc3_) > -1)
            {
               _loc3_ = "ninedirection";
               if(this._selectedTrans == "Fly")
               {
                  this.rp.visible = this.rp.includeInLayout = false;
                  this.dir.visible = this.dir.includeInLayout = true;
               }
               else
               {
                  this.dir.visible = this.dir.includeInLayout = false;
                  this.rp.visible = this.rp.includeInLayout = true;
               }
            }
            else if(_loc3_ == "xSections" || _loc3_ == "numStrips")
            {
               _loc3_ = "SizeStrips";
            }
            this.setOptionVisible("_o" + _loc3_,true);
            _loc2_++;
         }
         this.setOptionVisible("_onumStrips",false);
         this.setOptionVisible("_odegrees",false);
         this.setOptionVisible("_oshiftPoint",false);
         this.setOptionVisible("_ostartPoint",false);
         this.setOptionVisible("_oxSections",false);
         this.setOptionVisible("_oySections",false);
         this.options.validateDisplayList();
         this.options.visible = true;
      }
      
      private function restoreSceneSelection() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ArrayCollection = null;
         var _loc3_:UtilHashArray = null;
         var _loc4_:RadioButtonGroup = null;
         var _loc5_:int = 0;
         if(this._target && this._target.transition)
         {
            _loc1_ = 0;
            while(_loc1_ < this._effects.length)
            {
               if(Object(this._effects[_loc1_]).id == this._target.transition.type)
               {
                  this.cbTrans.selectedIndex = _loc1_;
               }
               _loc1_++;
            }
            this.onTransitionChange(false);
            _loc1_ = 0;
            while(_loc1_ < this._eases.length)
            {
               if(Object(this._eases[_loc1_]).id == this._target.transition.ease)
               {
                  this.cbEase.selectedIndex = _loc1_;
               }
               _loc1_++;
            }
            this.onEaseChange(false);
            this.stepper.value = UtilUnitConvert.frameToDuration(this._target.transition.duration);
            this.onDurChange(false);
            _loc3_ = UtilEffect.getTransitionParamByType(this._target.transition.type);
            _loc1_ = 0;
            while(_loc1_ < _loc3_.length)
            {
               switch(_loc3_.getKey(_loc1_))
               {
                  case "dimension":
                  case "shape":
                  case "ccw":
                     _loc4_ = RadioButtonGroup(this["_v" + _loc3_.getKey(_loc1_)]);
                     _loc5_ = 0;
                     while(_loc5_ < _loc4_.numRadioButtons)
                     {
                        if(_loc4_.getRadioButtonAt(_loc5_).value == this._target.transition.params[_loc1_])
                        {
                           RadioButtonGroup(_loc4_).selection = _loc4_.getRadioButtonAt(_loc5_);
                        }
                        _loc5_++;
                     }
                     break;
                  case "targetColor":
                     _loc2_ = this._vtargetColor.dataProvider as ArrayCollection;
                     _loc5_ = 0;
                     while(_loc5_ < _loc2_.length)
                     {
                        if(Object(_loc2_[_loc5_]).value == this._target.transition.params[_loc1_])
                        {
                           ComboBox(this._vtargetColor).selectedIndex = _loc5_;
                        }
                        _loc5_++;
                     }
                     break;
                  case "numStrips":
                  case "xSections":
                  case "ySections":
                     NumericStepper(this["_v" + _loc3_.getKey(_loc1_)]).value = this._target.transition.params[_loc1_];
                     _loc2_ = this._vSizeStrips.dataProvider as ArrayCollection;
                     _loc5_ = 0;
                     while(_loc5_ < _loc2_.length)
                     {
                        if(Object(_loc2_[_loc5_]).value == NumericStepper(this["_v" + _loc3_.getKey(_loc1_)]).value)
                        {
                           ComboBox(this._vSizeStrips).selectedIndex = _loc5_;
                        }
                        _loc5_++;
                     }
                     break;
                  case "startPoint":
                  case "shiftPoint":
                     NumericStepper(this["_v" + _loc3_.getKey(_loc1_)]).value = this._target.transition.params[_loc1_];
                     _loc5_ = 0;
                     while(_loc5_ < this._directionArr.length)
                     {
                        if(Object(this._directionArr[_loc5_]).value == NumericStepper(this["_v" + _loc3_.getKey(_loc1_)]).value)
                        {
                           IconComboBox(this._vninedirection).selectedIndex = _loc5_;
                        }
                        _loc5_++;
                     }
                     break;
                  default:
                     NumericStepper(this["_v" + _loc3_.getKey(_loc1_)]).value = this._target.transition.params[_loc1_];
                     break;
               }
               _loc1_++;
            }
            this.onParamChange(true);
         }
         else
         {
            this.cbTrans.selectedIndex = 0;
            this._selectedTrans = "";
            this.cbEase.visible = false;
            this.vbDur.visible = false;
         }
      }
      
      private function setOptionVisible(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:DisplayObject = this.options.getChildByName(param1);
         if(_loc3_)
         {
            _loc3_.visible = param2;
            HBox(_loc3_).includeInLayout = param2;
         }
      }
      
      private function getDefaultTransLength(param1:String) : Number
      {
         switch(param1)
         {
            case "Blinds":
            case "Fly":
            case "Photo":
               return 0.5;
            case "WipeHand":
            case "FESBadTransmission":
            case "FESZoomBlur":
            case "Fade":
            case "Iris":
            case "Rotate":
               return 1;
            case "CleanHand":
            case "CleanBrush":
            case "FESBrightSquares_11":
            case "FESBrightSquares_13":
            case "FadeDark":
            case "PixelDissolve":
            case "FESSparkle_1":
            case "FESSparkle_4":
            case "FESDisc":
               return 1.5;
            case "FESDesertIllusion":
               return 2;
            default:
               return 1;
         }
      }
      
      private function onTransitionChange(param1:Boolean = true) : void
      {
         this._selectedTrans = this.cbTrans.selectedItem.id;
         if(this.cbTrans.selectedIndex == 0)
         {
            this._selectedTrans = "";
            this.cbEase.visible = false;
            this.vbDur.visible = false;
         }
         else
         {
            this.cbEase.visible = false;
            this.cbEase.selectedIndex = 0;
            this.vbDur.visible = true;
            this.stepper.value = this.getDefaultTransLength(this._selectedTrans);
            this.onDurChange(false);
         }
         this.restoreParamValue();
         this.updateParamForm();
         this.onParamChange(false);
         if(param1)
         {
            this.updateTarget();
         }
         var _loc2_:SceneOptionEvent = new SceneOptionEvent(SceneOptionEvent.TYPE_CHANGED);
         _loc2_.ttype = this._selectedTrans;
         _loc2_.duration = this._selectedDur;
         dispatchEvent(_loc2_);
      }
      
      private function onEaseChange(param1:Boolean = true) : void
      {
         if(this.cbEase.selectedItem)
         {
            this._selectedEase = this.cbEase.selectedItem.id;
            if(param1)
            {
               this.updateTarget();
            }
         }
      }
      
      private function onDurChange(param1:Boolean = true) : void
      {
         this._selectedDur = UtilUnitConvert.durationToFrame(this.stepper.value);
         if(param1)
         {
            this.updateTarget();
         }
         var _loc2_:SceneOptionEvent = new SceneOptionEvent(SceneOptionEvent.DURATION_CHANGED);
         _loc2_.ttype = this._selectedTrans;
         _loc2_.duration = this._selectedDur;
         dispatchEvent(_loc2_);
      }
      
      private function enableTiming() : void
      {
         this.stepper.enabled = true;
      }
      
      private function disableTiming() : void
      {
         this.stepper.enabled = false;
      }
      
      private function updateTarget() : void
      {
         var _loc1_:GoTransition = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(this._selectedTrans != "")
         {
            _loc1_ = new GoTransition();
            _loc1_.id = "GoTrans";
            _loc1_.type = this._selectedTrans;
            this.enableTiming();
            if(this._selectedTrans == "FadeDark")
            {
               _loc1_.pack = "anifire";
            }
            else if(this._selectedTrans == "WipeHand" || this._selectedTrans == "CleanHand" || this._selectedTrans == "CleanBrush")
            {
               _loc1_.pack = "animated";
               this.disableTiming();
            }
            else if(this._selectedTrans.indexOf("FES") == 0)
            {
               _loc1_.pack = "flashEff";
            }
            else
            {
               _loc1_.pack = "fl";
            }
            _loc1_.direction = "out";
            _loc1_.duration = this._selectedDur;
            _loc1_.ease = this._selectedEase;
            _loc1_.scene = this._target;
            _loc2_ = new Array();
            if(this._selectedParam)
            {
               _loc3_ = 0;
               while(_loc3_ < this._selectedParam.length)
               {
                  _loc2_.push(this._selectedParam.getValueByIndex(_loc3_));
                  _loc3_++;
               }
            }
            _loc1_.params = _loc2_;
            this._target.transition = _loc1_;
         }
         else
         {
            this._target.transition = null;
         }
      }
      
      private function onParamChange(param1:Boolean = true) : void
      {
         var _loc4_:Object = null;
         this._selectedParam = new UtilHashArray();
         var _loc2_:UtilHashArray = UtilEffect.getTransitionParamByType(this._selectedTrans);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            switch(_loc2_.getKey(_loc3_))
            {
               case "dimension":
               case "shape":
               case "ccw":
                  _loc4_ = RadioButtonGroup(this["_v" + _loc2_.getKey(_loc3_)]).selectedValue;
                  break;
               case "targetColor":
                  _loc4_ = ComboBox(this["_v" + _loc2_.getKey(_loc3_)]).selectedItem.value;
                  break;
               default:
                  _loc4_ = NumericStepper(this["_v" + _loc2_.getKey(_loc3_)]).value;
                  break;
            }
            this._selectedParam.push(_loc2_.getKey(_loc3_),_loc4_);
            _loc3_++;
         }
         if(param1)
         {
            this.updateTarget();
         }
      }
      
      private function onMouseOverEffect(param1:ListEvent) : void
      {
         this.showTransPreview(param1.rowIndex);
      }
      
      private function geticon(param1:Object) : Class
      {
         try
         {
            if(this[param1.icon])
            {
               return this[param1.icon];
            }
         }
         catch(e:Error)
         {
         }
         try
         {
            if(this[String(param1.icon).toLowerCase()])
            {
               return this[String(param1.icon).toLowerCase()];
            }
         }
         catch(e:Error)
         {
         }
         return this["trans_null"];
      }
      
      private function hideTransPreview() : void
      {
         this.transPreview.visible = false;
         this.transPreview.removeEventListener(Event.ENTER_FRAME,this.followMouse);
      }
      
      private function isTransitionAnimated(param1:String) : Boolean
      {
         if(param1 == "WipeHand" || param1 == "CleanHand" || param1 == "CleanBrush")
         {
            return true;
         }
         return false;
      }
      
      private function showTransPreview(param1:Number) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Bitmap = null;
         var _loc5_:UIComponent = null;
         var _loc6_:IFlashEffSymbol = null;
         var _loc2_:String = Object(this._effects[param1]).id;
         this.transSquare.visible = this.transAnimation.visible = false;
         if(this.isTransitionAnimated(_loc2_))
         {
            this.transAnimation.visible = true;
            this.preview_wipehand.visible = this.preview_cleanhand.visible = this.preview_cleanbrush.visible = false;
            switch(_loc2_)
            {
               case "WipeHand":
                  this.preview_wipehand.visible = true;
                  break;
               case "CleanHand":
                  this.preview_cleanhand.visible = true;
                  break;
               case "CleanBrush":
                  this.preview_cleanbrush.visible = true;
            }
         }
         else
         {
            while(this.transSquare.numChildren > 1)
            {
               this.transSquare.removeChildAt(1);
            }
            _loc3_ = new MovieClip();
            _loc4_ = new this.scr_a();
            _loc3_.addChild(_loc4_);
            (_loc5_ = new UIComponent()).addChild(_loc3_);
            this.transSquare.addChild(_loc5_);
            this.transSquare.visible = true;
            if(Object(this._effects[param1]).id == "Fly")
            {
               Tweener.addTween(_loc3_,{
                  "x":-_loc3_.width,
                  "time":2.5
               });
            }
            else if(Object(this._effects[param1]).id == "FadeDark")
            {
               Tweener.addTween(_loc3_,{
                  "_color":3355443,
                  "time":1.25
               });
               Tweener.addTween(_loc3_,{
                  "alpha":0,
                  "time":1.25,
                  "delay":1.25
               });
            }
            else if(String(Object(this._effects[param1]).id).indexOf("FES") == 0)
            {
               this.myEffect = new FlashEff2Flex();
               if((_loc6_ = AssetTransitionConstants.flashEffPlusParamById(Object(this._effects[param1]).id)) is FESBrightSquares)
               {
                  FESBrightSquares(_loc6_).squareWidth = 5;
                  FESBrightSquares(_loc6_).squareHeight = 5;
               }
               _loc6_.tweenDuration = 2.5;
               this.myEffect.hideTransition = _loc6_;
               this.myEffect.hideDelay = 0;
               this.myEffect.target = MovieClip(_loc3_);
               _loc5_.addChild(this.myEffect);
            }
            else
            {
               TransitionManager.start(MovieClip(_loc3_),{
                  "type":UtilEffect.getTransitionByName(Object(this._effects[param1]).id),
                  "direction":Transition.OUT,
                  "startPoint":5,
                  "duration":2.5
               });
            }
         }
         this.transPreview.addEventListener(Event.ENTER_FRAME,this.followMouse);
      }
      
      private function followMouse(param1:Event) : void
      {
         var _loc2_:Canvas = Canvas(param1.currentTarget);
         _loc2_.x = this.cbTrans.x + this.cbTrans.dropdownWidth;
         _loc2_.y = this.cbTrans.mouseY + this.cbTrans.y - 12;
         this.transPreview.visible = true;
      }
      
      private function initStripSizeCombo() : void
      {
         var _loc1_:Array = new Array({
            "label":UtilDict.toDisplay("go","Big"),
            "value":5
         },{
            "label":UtilDict.toDisplay("go","Medium"),
            "value":10
         },{
            "label":UtilDict.toDisplay("go","Small"),
            "value":20
         });
         this._vSizeStrips.dataProvider = _loc1_;
      }
      
      private function initColorCombo() : void
      {
         var _loc1_:Array = new Array({
            "label":UtilDict.toDisplay("go","Black"),
            "value":0
         },{
            "label":UtilDict.toDisplay("go","Grey"),
            "value":10066329
         },{
            "label":UtilDict.toDisplay("go","White"),
            "value":16777215
         });
         this._vtargetColor.dataProvider = _loc1_;
      }
      
      private function onColorChange() : void
      {
         this.onParamChange();
      }
      
      private function onStripSizeChange() : void
      {
         switch(this._selectedTrans)
         {
            case "Blinds":
               this._vnumStrips.value = this._vSizeStrips.selectedItem.value;
               break;
            case "PixelDissolve":
               this._vxSections.value = this._vSizeStrips.selectedItem.value;
               this._vySections.value = this._vSizeStrips.selectedItem.value;
         }
         this.onParamChange();
      }
      
      private function onDirectionChange() : void
      {
         switch(this._selectedTrans)
         {
            case "Fly":
            case "Iris":
            case "Wipe":
               this._vstartPoint.value = this._vninedirection.selectedItem.value;
               break;
            case "Rotate":
            case "Squeeze":
            case "Zoom":
               this._vshiftPoint.value = this._vninedirection.selectedItem.value;
         }
         this.onParamChange();
      }
      
      private function onStepperChange(param1:Event) : void
      {
         this._target.transition.duration = UtilUnitConvert.durationToFrame(this.stepper.value);
      }
      
      private function _SceneOption_RadioButtonGroup3_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.___vccw_change);
         _loc1_.initialized(this,"_vccw");
         this._vccw = _loc1_;
         BindingManager.executeBindings(this,"_vccw",this._vccw);
         return _loc1_;
      }
      
      public function ___vccw_change(param1:Event) : void
      {
         this.onParamChange();
      }
      
      private function _SceneOption_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.___vdimension_change);
         _loc1_.initialized(this,"_vdimension");
         this._vdimension = _loc1_;
         BindingManager.executeBindings(this,"_vdimension",this._vdimension);
         return _loc1_;
      }
      
      public function ___vdimension_change(param1:Event) : void
      {
         this.onParamChange();
      }
      
      private function _SceneOption_RadioButtonGroup2_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         _loc1_.addEventListener("change",this.___vshape_change);
         _loc1_.initialized(this,"_vshape");
         this._vshape = _loc1_;
         BindingManager.executeBindings(this,"_vshape",this._vshape);
         return _loc1_;
      }
      
      public function ___vshape_change(param1:Event) : void
      {
         this.onParamChange();
      }
      
      public function ___SceneOption_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function __cbTrans_change(param1:ListEvent) : void
      {
         this.onTransitionChange();
      }
      
      public function __cbTrans_itemRollOver(param1:ListEvent) : void
      {
         this.onMouseOverEffect(param1);
      }
      
      public function __cbTrans_close(param1:DropdownEvent) : void
      {
         this.hideTransPreview();
      }
      
      public function __cbTrans_mouseOut(param1:MouseEvent) : void
      {
         this.hideTransPreview();
      }
      
      public function __cbEase_change(param1:ListEvent) : void
      {
         this.onEaseChange();
      }
      
      public function __stepper_change(param1:Event) : void
      {
         this.onStepperChange(param1);
      }
      
      public function ___vSizeStrips_change(param1:ListEvent) : void
      {
         this.onStripSizeChange();
      }
      
      public function ___vSizeStrips_creationComplete(param1:FlexEvent) : void
      {
         this.initStripSizeCombo();
      }
      
      public function ___vstartPoint_change(param1:NumericStepperEvent) : void
      {
         this.onParamChange();
      }
      
      public function ___vdegrees_change(param1:NumericStepperEvent) : void
      {
         this.onParamChange();
      }
      
      public function ___vxSections_change(param1:NumericStepperEvent) : void
      {
         this.onParamChange();
      }
      
      public function ___vySections_change(param1:NumericStepperEvent) : void
      {
         this.onParamChange();
      }
      
      public function ___vshiftPoint_change(param1:NumericStepperEvent) : void
      {
         this.onParamChange();
      }
      
      public function ___vtargetColor_change(param1:ListEvent) : void
      {
         this.onColorChange();
      }
      
      public function ___vtargetColor_creationComplete(param1:FlexEvent) : void
      {
         this.initColorCombo();
      }
      
      public function ___vninedirection_change(param1:ListEvent) : void
      {
         this.onDirectionChange();
      }
      
      private function _SceneOption_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Transition from Previous Scene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label2.text");
         result[1] = new Binding(this,function():Object
         {
            return _effects;
         },null,"cbTrans.dataProvider");
         result[2] = new Binding(this,function():Object
         {
            return _eases;
         },null,"cbEase.dataProvider");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Transition Duration");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label3.text");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("numStrips"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label4.text");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("Size"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label5.text");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("dimension"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label6.text");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("horizontal"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vdimension_0.label");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("vertical"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vdimension_1.label");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("startPoint"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label7.text");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("shape"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label8.text");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("CIRCLE"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vshape_CIRCLE.label");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("SQUARE"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vshape_SQUARE.label");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("ccw"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label9.text");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("clockwise"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vccw_0.label");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("anti-clockwise"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_vccw_1.label");
         result[16] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("degrees"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label10.text");
         result[17] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("xSections"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label11.text");
         result[18] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("ySections"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label12.text");
         result[19] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("shiftPoint"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label13.text");
         result[20] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go",UtilEffect.getLabelById("targetColor"));
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_SceneOption_Label14.text");
         result[21] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Reference Point");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"rp.text");
         result[22] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Direction");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"dir.text");
         result[23] = new Binding(this,function():Object
         {
            return _directionArr;
         },null,"_vninedirection.dataProvider");
         result[24] = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,73,43);
         },null,"transPreview.scrollRect");
         result[25] = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,55,38);
         },null,"transSquare.scrollRect");
         result[26] = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,55,38);
         },null,"transAnimation.scrollRect");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _oSizeStrips() : HBox
      {
         return this._1649812428_oSizeStrips;
      }
      
      public function set _oSizeStrips(param1:HBox) : void
      {
         var _loc2_:Object = this._1649812428_oSizeStrips;
         if(_loc2_ !== param1)
         {
            this._1649812428_oSizeStrips = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_oSizeStrips",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _occw() : HBox
      {
         return this._91139623_occw;
      }
      
      public function set _occw(param1:HBox) : void
      {
         var _loc2_:Object = this._91139623_occw;
         if(_loc2_ !== param1)
         {
            this._91139623_occw = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_occw",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _odegrees() : HBox
      {
         return this._1815154999_odegrees;
      }
      
      public function set _odegrees(param1:HBox) : void
      {
         var _loc2_:Object = this._1815154999_odegrees;
         if(_loc2_ !== param1)
         {
            this._1815154999_odegrees = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_odegrees",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _odimension() : HBox
      {
         return this._344862858_odimension;
      }
      
      public function set _odimension(param1:HBox) : void
      {
         var _loc2_:Object = this._344862858_odimension;
         if(_loc2_ !== param1)
         {
            this._344862858_odimension = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_odimension",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _oninedirection() : HBox
      {
         return this._228520221_oninedirection;
      }
      
      public function set _oninedirection(param1:HBox) : void
      {
         var _loc2_:Object = this._228520221_oninedirection;
         if(_loc2_ !== param1)
         {
            this._228520221_oninedirection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_oninedirection",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _onumStrips() : HBox
      {
         return this._1984503185_onumStrips;
      }
      
      public function set _onumStrips(param1:HBox) : void
      {
         var _loc2_:Object = this._1984503185_onumStrips;
         if(_loc2_ !== param1)
         {
            this._1984503185_onumStrips = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_onumStrips",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _oshape() : HBox
      {
         return this._1700739505_oshape;
      }
      
      public function set _oshape(param1:HBox) : void
      {
         var _loc2_:Object = this._1700739505_oshape;
         if(_loc2_ !== param1)
         {
            this._1700739505_oshape = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_oshape",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _oshiftPoint() : HBox
      {
         return this._595240418_oshiftPoint;
      }
      
      public function set _oshiftPoint(param1:HBox) : void
      {
         var _loc2_:Object = this._595240418_oshiftPoint;
         if(_loc2_ !== param1)
         {
            this._595240418_oshiftPoint = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_oshiftPoint",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ostartPoint() : HBox
      {
         return this._192671294_ostartPoint;
      }
      
      public function set _ostartPoint(param1:HBox) : void
      {
         var _loc2_:Object = this._192671294_ostartPoint;
         if(_loc2_ !== param1)
         {
            this._192671294_ostartPoint = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ostartPoint",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _otargetColor() : HBox
      {
         return this._1524186722_otargetColor;
      }
      
      public function set _otargetColor(param1:HBox) : void
      {
         var _loc2_:Object = this._1524186722_otargetColor;
         if(_loc2_ !== param1)
         {
            this._1524186722_otargetColor = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_otargetColor",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _oxSections() : HBox
      {
         return this._383439658_oxSections;
      }
      
      public function set _oxSections(param1:HBox) : void
      {
         var _loc2_:Object = this._383439658_oxSections;
         if(_loc2_ !== param1)
         {
            this._383439658_oxSections = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_oxSections",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _oySections() : HBox
      {
         return this._2104073175_oySections;
      }
      
      public function set _oySections(param1:HBox) : void
      {
         var _loc2_:Object = this._2104073175_oySections;
         if(_loc2_ !== param1)
         {
            this._2104073175_oySections = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_oySections",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vSizeStrips() : ComboBox
      {
         return this._1956054803_vSizeStrips;
      }
      
      public function set _vSizeStrips(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1956054803_vSizeStrips;
         if(_loc2_ !== param1)
         {
            this._1956054803_vSizeStrips = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vSizeStrips",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vccw() : RadioButtonGroup
      {
         return this._91348160_vccw;
      }
      
      public function set _vccw(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._91348160_vccw;
         if(_loc2_ !== param1)
         {
            this._91348160_vccw = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vccw",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vccw_0() : RadioButton
      {
         return this._1886238833_vccw_0;
      }
      
      public function set _vccw_0(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1886238833_vccw_0;
         if(_loc2_ !== param1)
         {
            this._1886238833_vccw_0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vccw_0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vccw_1() : RadioButton
      {
         return this._1886238834_vccw_1;
      }
      
      public function set _vccw_1(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1886238834_vccw_1;
         if(_loc2_ !== param1)
         {
            this._1886238834_vccw_1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vccw_1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vdegrees() : NumericStepper
      {
         return this._1129925456_vdegrees;
      }
      
      public function set _vdegrees(param1:NumericStepper) : void
      {
         var _loc2_:Object = this._1129925456_vdegrees;
         if(_loc2_ !== param1)
         {
            this._1129925456_vdegrees = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vdegrees",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vdimension() : RadioButtonGroup
      {
         return this._1720457393_vdimension;
      }
      
      public function set _vdimension(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1720457393_vdimension;
         if(_loc2_ !== param1)
         {
            this._1720457393_vdimension = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vdimension",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vdimension_0() : RadioButton
      {
         return this._202857280_vdimension_0;
      }
      
      public function set _vdimension_0(param1:RadioButton) : void
      {
         var _loc2_:Object = this._202857280_vdimension_0;
         if(_loc2_ !== param1)
         {
            this._202857280_vdimension_0 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vdimension_0",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vdimension_1() : RadioButton
      {
         return this._202857281_vdimension_1;
      }
      
      public function set _vdimension_1(param1:RadioButton) : void
      {
         var _loc2_:Object = this._202857281_vdimension_1;
         if(_loc2_ !== param1)
         {
            this._202857281_vdimension_1 = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vdimension_1",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vninedirection() : IconComboBox
      {
         return this._984577142_vninedirection;
      }
      
      public function set _vninedirection(param1:IconComboBox) : void
      {
         var _loc2_:Object = this._984577142_vninedirection;
         if(_loc2_ !== param1)
         {
            this._984577142_vninedirection = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vninedirection",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vnumStrips() : NumericStepper
      {
         return this._608908650_vnumStrips;
      }
      
      public function set _vnumStrips(param1:NumericStepper) : void
      {
         var _loc2_:Object = this._608908650_vnumStrips;
         if(_loc2_ !== param1)
         {
            this._608908650_vnumStrips = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vnumStrips",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vshape() : RadioButtonGroup
      {
         return this._1901143562_vshape;
      }
      
      public function set _vshape(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = this._1901143562_vshape;
         if(_loc2_ !== param1)
         {
            this._1901143562_vshape = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vshape",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vshape_CIRCLE() : RadioButton
      {
         return this._888375461_vshape_CIRCLE;
      }
      
      public function set _vshape_CIRCLE(param1:RadioButton) : void
      {
         var _loc2_:Object = this._888375461_vshape_CIRCLE;
         if(_loc2_ !== param1)
         {
            this._888375461_vshape_CIRCLE = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vshape_CIRCLE",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vshape_SQUARE() : RadioButton
      {
         return this._1353917682_vshape_SQUARE;
      }
      
      public function set _vshape_SQUARE(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1353917682_vshape_SQUARE;
         if(_loc2_ !== param1)
         {
            this._1353917682_vshape_SQUARE = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vshape_SQUARE",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vshiftPoint() : NumericStepper
      {
         return this._288998043_vshiftPoint;
      }
      
      public function set _vshiftPoint(param1:NumericStepper) : void
      {
         var _loc2_:Object = this._288998043_vshiftPoint;
         if(_loc2_ !== param1)
         {
            this._288998043_vshiftPoint = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vshiftPoint",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vstartPoint() : NumericStepper
      {
         return this._498913669_vstartPoint;
      }
      
      public function set _vstartPoint(param1:NumericStepper) : void
      {
         var _loc2_:Object = this._498913669_vstartPoint;
         if(_loc2_ !== param1)
         {
            this._498913669_vstartPoint = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vstartPoint",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vtargetColor() : ComboBox
      {
         return this._1867201541_vtargetColor;
      }
      
      public function set _vtargetColor(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1867201541_vtargetColor;
         if(_loc2_ !== param1)
         {
            this._1867201541_vtargetColor = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vtargetColor",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vxSections() : NumericStepper
      {
         return this._1759034193_vxSections;
      }
      
      public function set _vxSections(param1:NumericStepper) : void
      {
         var _loc2_:Object = this._1759034193_vxSections;
         if(_loc2_ !== param1)
         {
            this._1759034193_vxSections = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vxSections",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _vySections() : NumericStepper
      {
         return this._728478640_vySections;
      }
      
      public function set _vySections(param1:NumericStepper) : void
      {
         var _loc2_:Object = this._728478640_vySections;
         if(_loc2_ !== param1)
         {
            this._728478640_vySections = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_vySections",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbEase() : ComboBox
      {
         return this._1368023827cbEase;
      }
      
      public function set cbEase(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1368023827cbEase;
         if(_loc2_ !== param1)
         {
            this._1368023827cbEase = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbEase",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cbTrans() : IconComboBox
      {
         return this._555276681cbTrans;
      }
      
      public function set cbTrans(param1:IconComboBox) : void
      {
         var _loc2_:Object = this._555276681cbTrans;
         if(_loc2_ !== param1)
         {
            this._555276681cbTrans = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cbTrans",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dir() : Label
      {
         return this._99469dir;
      }
      
      public function set dir(param1:Label) : void
      {
         var _loc2_:Object = this._99469dir;
         if(_loc2_ !== param1)
         {
            this._99469dir = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dir",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get durationPanel() : SceneDurationPanel
      {
         return this._126232784durationPanel;
      }
      
      public function set durationPanel(param1:SceneDurationPanel) : void
      {
         var _loc2_:Object = this._126232784durationPanel;
         if(_loc2_ !== param1)
         {
            this._126232784durationPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"durationPanel",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get myId() : Label
      {
         return this._3365863myId;
      }
      
      public function set myId(param1:Label) : void
      {
         var _loc2_:Object = this._3365863myId;
         if(_loc2_ !== param1)
         {
            this._3365863myId = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"myId",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get options() : VBox
      {
         return this._1249474914options;
      }
      
      public function set options(param1:VBox) : void
      {
         var _loc2_:Object = this._1249474914options;
         if(_loc2_ !== param1)
         {
            this._1249474914options = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"options",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get preview_cleanbrush() : SWFLoader
      {
         return this._1259656344preview_cleanbrush;
      }
      
      public function set preview_cleanbrush(param1:SWFLoader) : void
      {
         var _loc2_:Object = this._1259656344preview_cleanbrush;
         if(_loc2_ !== param1)
         {
            this._1259656344preview_cleanbrush = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"preview_cleanbrush",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get preview_cleanhand() : SWFLoader
      {
         return this._1148850559preview_cleanhand;
      }
      
      public function set preview_cleanhand(param1:SWFLoader) : void
      {
         var _loc2_:Object = this._1148850559preview_cleanhand;
         if(_loc2_ !== param1)
         {
            this._1148850559preview_cleanhand = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"preview_cleanhand",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get preview_wipehand() : SWFLoader
      {
         return this._83557427preview_wipehand;
      }
      
      public function set preview_wipehand(param1:SWFLoader) : void
      {
         var _loc2_:Object = this._83557427preview_wipehand;
         if(_loc2_ !== param1)
         {
            this._83557427preview_wipehand = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"preview_wipehand",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rp() : Label
      {
         return this._3646rp;
      }
      
      public function set rp(param1:Label) : void
      {
         var _loc2_:Object = this._3646rp;
         if(_loc2_ !== param1)
         {
            this._3646rp = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rp",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get stepper() : TimeStepper
      {
         return this._1893554479stepper;
      }
      
      public function set stepper(param1:TimeStepper) : void
      {
         var _loc2_:Object = this._1893554479stepper;
         if(_loc2_ !== param1)
         {
            this._1893554479stepper = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stepper",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get transAnimation() : Canvas
      {
         return this._360200772transAnimation;
      }
      
      public function set transAnimation(param1:Canvas) : void
      {
         var _loc2_:Object = this._360200772transAnimation;
         if(_loc2_ !== param1)
         {
            this._360200772transAnimation = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"transAnimation",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get transPreview() : Canvas
      {
         return this._167427072transPreview;
      }
      
      public function set transPreview(param1:Canvas) : void
      {
         var _loc2_:Object = this._167427072transPreview;
         if(_loc2_ !== param1)
         {
            this._167427072transPreview = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"transPreview",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get transSquare() : Canvas
      {
         return this._1753389541transSquare;
      }
      
      public function set transSquare(param1:Canvas) : void
      {
         var _loc2_:Object = this._1753389541transSquare;
         if(_loc2_ !== param1)
         {
            this._1753389541transSquare = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"transSquare",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get vbDur() : HBox
      {
         return this._111964085vbDur;
      }
      
      public function set vbDur(param1:HBox) : void
      {
         var _loc2_:Object = this._111964085vbDur;
         if(_loc2_ !== param1)
         {
            this._111964085vbDur = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vbDur",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _effects() : Array
      {
         return this._524296131_effects;
      }
      
      private function set _effects(param1:Array) : void
      {
         var _loc2_:Object = this._524296131_effects;
         if(_loc2_ !== param1)
         {
            this._524296131_effects = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_effects",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _eases() : Array
      {
         return this._1478918842_eases;
      }
      
      private function set _eases(param1:Array) : void
      {
         var _loc2_:Object = this._1478918842_eases;
         if(_loc2_ !== param1)
         {
            this._1478918842_eases = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_eases",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get _directionArr() : Array
      {
         return this._1150762943_directionArr;
      }
      
      private function set _directionArr(param1:Array) : void
      {
         var _loc2_:Object = this._1150762943_directionArr;
         if(_loc2_ !== param1)
         {
            this._1150762943_directionArr = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_directionArr",_loc2_,param1));
            }
         }
      }
   }
}
