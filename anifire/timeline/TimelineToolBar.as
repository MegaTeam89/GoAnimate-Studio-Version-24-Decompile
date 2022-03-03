package anifire.timeline
{
   import anifire.containers.GradientCanvas;
   import anifire.core.Console;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.CSSStyleDeclaration;
   
   public class TimelineToolBar extends Canvas
   {
       
      
      private var _1147726377btnCollapse:Button;
      
      private var _1910947399btnWaveform:Button;
      
      private var _1751684952speechIcons:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      mx_internal var _TimelineToolBar_StylesInit_done:Boolean = false;
      
      private var _embed_css_image_btn_waveform_off_png__1621450067_436284867:Class;
      
      private var _embed_mxml_image_icon_voiceover_png_617168823:Class;
      
      private var _embed_css_image_btn_waveform_over_png__1672948500_121813984:Class;
      
      private var _embed_mxml_image_icon_scene_png_796956499:Class;
      
      private var _embed_mxml_image_icon_bgmusic_png_226966331:Class;
      
      private var _embed_css_image_btn_waveform_on_png__1986184265_1542014757:Class;
      
      public function TimelineToolBar()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "events":{"creationComplete":"___TimelineToolBar_Canvas1_creationComplete"},
            "propertiesFactory":function():Object
            {
               return {
                  "width":72,
                  "height":182,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":GradientCanvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":17,
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"sceneTimelineLabel",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Image,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "source":_embed_mxml_image_icon_scene_png_796956499,
                                    "y":20,
                                    "horizontalCenter":0
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Image,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "source":_embed_mxml_image_icon_voiceover_png_617168823,
                                    "y":50,
                                    "horizontalCenter":0
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "id":"speechIcons",
                              "stylesFactory":function():void
                              {
                                 this.verticalGap = 0;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "top":72,
                                    "horizontalCenter":0,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Image,
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "source":_embed_mxml_image_icon_bgmusic_png_226966331,
                                             "height":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Image,
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "source":_embed_mxml_image_icon_bgmusic_png_226966331,
                                             "height":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Image,
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "source":_embed_mxml_image_icon_bgmusic_png_226966331,
                                             "height":20
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Image,
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "source":_embed_mxml_image_icon_bgmusic_png_226966331,
                                             "height":20
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
                     "stylesFactory":function():void
                     {
                        this.dropShadowEnabled = true;
                        this.borderStyle = "solid";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":17,
                           "alpha":0.2
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":GradientCanvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":17,
                           "styleName":"timelineToolBar"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":17,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":GradientCanvas,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":17,
                                    "height":17,
                                    "styleName":"timelineToolBar",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Button,
                                       "id":"btnCollapse",
                                       "events":{"click":"__btnCollapse_click"},
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "horizontalCenter":0,
                                             "verticalCenter":0,
                                             "width":17,
                                             "height":17,
                                             "styleName":"timelineCollapseBtnStyle",
                                             "buttonMode":true,
                                             "toggle":true
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnWaveform",
                              "events":{"click":"__btnWaveform_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":24,
                                    "y":2,
                                    "styleName":"timelineWaveFormBtnStyle",
                                    "buttonMode":true,
                                    "toggle":true
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._embed_css_image_btn_waveform_off_png__1621450067_436284867 = _class_embed_css_image_btn_waveform_off_png__1621450067_436284867;
         this._embed_mxml_image_icon_voiceover_png_617168823 = TimelineToolBar__embed_mxml_image_icon_voiceover_png_617168823;
         this._embed_css_image_btn_waveform_over_png__1672948500_121813984 = _class_embed_css_image_btn_waveform_over_png__1672948500_121813984;
         this._embed_mxml_image_icon_scene_png_796956499 = TimelineToolBar__embed_mxml_image_icon_scene_png_796956499;
         this._embed_mxml_image_icon_bgmusic_png_226966331 = TimelineToolBar__embed_mxml_image_icon_bgmusic_png_226966331;
         this._embed_css_image_btn_waveform_on_png__1986184265_1542014757 = _class_embed_css_image_btn_waveform_on_png__1986184265_1542014757;
         super();
         mx_internal::_document = this;
         this.width = 72;
         this.height = 182;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___TimelineToolBar_Canvas1_creationComplete);
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_TimelineToolBar_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      protected function onCreationComplete(param1:FlexEvent) : void
      {
      }
      
      protected function onCollapseBtnClick(param1:MouseEvent) : void
      {
         Console.getConsole().timeline.triggerAllSoundTrackSize();
      }
      
      protected function onWaveFormBtnClick(param1:MouseEvent) : void
      {
         Console.getConsole().timeline.triggerAllSoundWaveFormDisplay();
      }
      
      public function collapse() : void
      {
         this.height = 103;
         this.btnCollapse.selected = true;
         this.speechIcons.visible = this.speechIcons.includeInLayout = false;
      }
      
      public function expand() : void
      {
         this.height = 182;
         this.btnCollapse.selected = false;
         this.speechIcons.visible = this.speechIcons.includeInLayout = true;
      }
      
      public function ___TimelineToolBar_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
      
      public function __btnCollapse_click(param1:MouseEvent) : void
      {
         this.onCollapseBtnClick(param1);
      }
      
      public function __btnWaveform_click(param1:MouseEvent) : void
      {
         this.onWaveFormBtnClick(param1);
      }
      
      mx_internal function _TimelineToolBar_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_TimelineToolBar_StylesInit_done)
         {
            return;
         }
         mx_internal::_TimelineToolBar_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".timelineWaveFormBtnStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".timelineWaveFormBtnStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.upSkin = _embed_css_image_btn_waveform_off_png__1621450067_436284867;
               this.selectedDownSkin = _embed_css_image_btn_waveform_on_png__1986184265_1542014757;
               this.downSkin = _embed_css_image_btn_waveform_off_png__1621450067_436284867;
               this.overSkin = _embed_css_image_btn_waveform_over_png__1672948500_121813984;
               this.selectedUpSkin = _embed_css_image_btn_waveform_on_png__1986184265_1542014757;
               this.selectedOverSkin = _embed_css_image_btn_waveform_over_png__1672948500_121813984;
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnCollapse() : Button
      {
         return this._1147726377btnCollapse;
      }
      
      public function set btnCollapse(param1:Button) : void
      {
         var _loc2_:Object = this._1147726377btnCollapse;
         if(_loc2_ !== param1)
         {
            this._1147726377btnCollapse = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnCollapse",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnWaveform() : Button
      {
         return this._1910947399btnWaveform;
      }
      
      public function set btnWaveform(param1:Button) : void
      {
         var _loc2_:Object = this._1910947399btnWaveform;
         if(_loc2_ !== param1)
         {
            this._1910947399btnWaveform = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnWaveform",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get speechIcons() : VBox
      {
         return this._1751684952speechIcons;
      }
      
      public function set speechIcons(param1:VBox) : void
      {
         var _loc2_:Object = this._1751684952speechIcons;
         if(_loc2_ !== param1)
         {
            this._1751684952speechIcons = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"speechIcons",_loc2_,param1));
            }
         }
      }
   }
}
