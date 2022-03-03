package anifire.components.studio
{
   import anifire.assets.controller.AssetCollectionController;
   import anifire.assets.interfaces.ISupportCircularMotion;
   import anifire.command.ChangeActionCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.component.DoubleStateButton;
   import anifire.core.AnimeScene;
   import anifire.core.Background;
   import anifire.core.BubbleAsset;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.ProgramEffectAsset;
   import anifire.core.Prop;
   import anifire.core.VideoProp;
   import anifire.effect.ZoomEffect;
   import anifire.events.AssetEvent;
   import anifire.interfaces.ISlidable;
   import anifire.scene.model.SceneManager;
   import anifire.util.UtilDict;
   import anifire.util.UtilUser;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class AssetButtonBar extends HBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      private var _1015222112_btnBackward:Button;
      
      private var _1147697068_btnCCLookAtCamera:Button;
      
      private var _946561915_btnCircularMotionCCW:Button;
      
      private var _108013094_btnCircularMotionCW:Button;
      
      private var _2122116432_btnClear:Button;
      
      private var _2122019898_btnColor:Button;
      
      private var _1731020110_btnCopy:Button;
      
      private var _1338722904_btnDelete:Button;
      
      private var _1730971321_btnEdit:Button;
      
      private var _1730933846_btnFlip:Button;
      
      private var _778345880_btnForward:Button;
      
      private var _2112775277_btnMovie:DoubleStateButton;
      
      private var _2110424330_btnPaste:Button;
      
      private var _419384469_btnPreview:Button;
      
      private var _2107336172_btnSlide:Button;
      
      private var _1730334960_btnZoom:Button;
      
      private var _1282133823fadeIn:Fade;
      
      private var _1091436750fadeOut:Fade;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _target:Object = null;
      
      private var _2091909055isFullVersion:Boolean = true;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function AssetButtonBar()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "effects":["showEffect"],
            "stylesFactory":function():void
            {
               this.verticalAlign = "middle";
            },
            "propertiesFactory":function():Object
            {
               return {
                  "height":34,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnSlide",
                     "events":{"click":"___btnSlide_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnSlide",
                           "focusEnabled":false,
                           "buttonMode":true,
                           "toggle":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnCircularMotionCW",
                     "events":{"click":"___btnCircularMotionCW_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnCircularMotionCW",
                           "focusEnabled":false,
                           "buttonMode":true,
                           "toggle":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnCircularMotionCCW",
                     "events":{"click":"___btnCircularMotionCCW_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnCircularMotionCCW",
                           "focusEnabled":false,
                           "buttonMode":true,
                           "toggle":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnCCLookAtCamera",
                     "events":{"click":"___btnCCLookAtCamera_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnLookAtCamera",
                           "toggle":true,
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnFlip",
                     "events":{"click":"___btnFlip_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnFlip",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnForward",
                     "events":{"click":"___btnForward_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnForward",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnBackward",
                     "events":{"click":"___btnBackward_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnBackward",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnZoom",
                     "events":{"click":"___btnZoom_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnZoomIn",
                           "focusEnabled":false,
                           "buttonMode":true,
                           "toggle":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnEdit",
                     "events":{"click":"___btnEdit_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnEdit",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnColor",
                     "events":{"click":"___btnColor_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnColor",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":DoubleStateButton,
                     "id":"_btnMovie",
                     "events":{
                        "But1Click":"___btnMovie_But1Click",
                        "But2Click":"___btnMovie_But2Click"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "but1StyleName":"btnFlip",
                           "but2StyleName":"btnFlip",
                           "toolTip":"play/pause movie",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnPreview",
                     "events":{"click":"___btnPreview_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnPreviewHere",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnCopy",
                     "events":{"click":"___btnCopy_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnCopyScene",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnPaste",
                     "events":{"click":"___btnPaste_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnPasteScene",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnClear",
                     "events":{"click":"___btnClear_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnClear",
                           "focusEnabled":false,
                           "buttonMode":true
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Button,
                     "id":"_btnDelete",
                     "events":{"click":"___btnDelete_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "includeInLayout":false,
                           "width":28,
                           "height":28,
                           "styleName":"btnDelete",
                           "focusEnabled":false,
                           "buttonMode":true
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
         var bindings:Array = this._AssetButtonBar_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_AssetButtonBarWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return AssetButtonBar[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.height = 34;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._AssetButtonBar_Fade1_i();
         this._AssetButtonBar_Fade2_i();
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         AssetButtonBar._watcherSetupUtil = param1;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory = factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.verticalAlign = "middle";
         };
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set target(param1:Object) : void
      {
         if(this._target != param1)
         {
            if(this._target && this._target is Character)
            {
               Character(this._target).removeEventListener(AssetEvent.ACTION_CHANGE,this.onCharActionChange);
            }
            if(this._target is IEventDispatcher)
            {
               IEventDispatcher(this._target).removeEventListener(AssetEvent.MOTION_CHANGE,this.onAssetMotionChange);
            }
            this._target = param1;
            this._btnBackward.visible = this._btnBackward.includeInLayout = false;
            this._btnCCLookAtCamera.visible = this._btnCCLookAtCamera.includeInLayout = false;
            this._btnColor.visible = this._btnColor.includeInLayout = false;
            this._btnDelete.visible = this._btnDelete.includeInLayout = false;
            this._btnEdit.visible = this._btnEdit.includeInLayout = false;
            this._btnFlip.visible = this._btnFlip.includeInLayout = false;
            this._btnForward.visible = this._btnForward.includeInLayout = false;
            this._btnMovie.visible = this._btnMovie.includeInLayout = false;
            this._btnSlide.visible = this._btnSlide.includeInLayout = false;
            this._btnZoom.visible = this._btnZoom.includeInLayout = false;
            this._btnPreview.visible = this._btnPreview.includeInLayout = false;
            this._btnCopy.visible = this._btnCopy.includeInLayout = false;
            this._btnPaste.visible = this._btnPaste.includeInLayout = false;
            this._btnClear.visible = this._btnClear.includeInLayout = false;
            if(param1)
            {
               if(param1 is Background)
               {
                  this._btnDelete.visible = this._btnDelete.includeInLayout = true;
                  if(UtilUser.hasAdminFeatures)
                  {
                     this._btnFlip.visible = this._btnFlip.includeInLayout = true;
                  }
               }
               else if(param1 is VideoProp)
               {
                  this._btnDelete.visible = this._btnDelete.includeInLayout = true;
                  this._btnBackward.visible = this._btnBackward.includeInLayout = true;
                  this._btnForward.visible = this._btnForward.includeInLayout = true;
                  this._btnFlip.visible = this._btnFlip.includeInLayout = true;
               }
               else if(param1 is Prop)
               {
                  this._btnDelete.visible = this._btnDelete.includeInLayout = true;
                  this._btnBackward.visible = this._btnBackward.includeInLayout = true;
                  this._btnForward.visible = this._btnForward.includeInLayout = true;
                  this._btnFlip.visible = this._btnFlip.includeInLayout = true;
               }
               else if(param1 is Character)
               {
                  this._btnDelete.visible = this._btnDelete.includeInLayout = true;
                  this._btnBackward.visible = this._btnBackward.includeInLayout = true;
                  this._btnForward.visible = this._btnForward.includeInLayout = true;
                  this._btnFlip.visible = this._btnFlip.includeInLayout = true;
                  Character(param1).addEventListener(AssetEvent.ACTION_CHANGE,this.onCharActionChange);
               }
               else if(param1 is BubbleAsset)
               {
                  this._btnDelete.visible = this._btnDelete.includeInLayout = true;
                  this._btnBackward.visible = this._btnBackward.includeInLayout = true;
                  this._btnForward.visible = this._btnForward.includeInLayout = true;
               }
               else if(param1 is EffectAsset && (Console.getConsole().metaData.mver <= 3 || !(param1 is ProgramEffectAsset)))
               {
                  if(Console.getConsole().metaData.mver <= 3)
                  {
                     this._btnDelete.visible = this._btnDelete.includeInLayout = true;
                  }
                  if(EffectAsset(param1).effect is ZoomEffect && this.isFullVersion)
                  {
                     this._btnZoom.visible = this._btnZoom.includeInLayout = true;
                     this._btnZoom.selected = Console.getConsole().mainStage.isCameraMode;
                  }
               }
               else if(param1 is AnimeScene || param1 is EffectAsset)
               {
                  this._btnPreview.visible = this._btnPreview.includeInLayout = true;
                  this._btnCopy.visible = this._btnCopy.includeInLayout = true;
                  this._btnClear.visible = this._btnClear.includeInLayout = true;
                  this._btnDelete.visible = this._btnDelete.includeInLayout = true;
                  if(SceneManager.copiedScene)
                  {
                     this._btnPaste.visible = this._btnPaste.includeInLayout = true;
                  }
                  if(param1 is EffectAsset)
                  {
                     this._target = EffectAsset(param1).scene;
                  }
               }
               else if(param1 is AssetCollectionController)
               {
                  this._btnDelete.visible = this._btnDelete.includeInLayout = true;
               }
            }
            this.updateMotionUI();
            if(this._target is IEventDispatcher)
            {
               IEventDispatcher(this._target).addEventListener(AssetEvent.MOTION_CHANGE,this.onAssetMotionChange);
            }
         }
      }
      
      private function onAssetMotionChange(param1:AssetEvent) : void
      {
         this.updateMotionUI();
      }
      
      private function updateMotionUI() : void
      {
         this._btnCircularMotionCW.visible = this._btnCircularMotionCW.includeInLayout = false;
         this._btnCircularMotionCCW.visible = this._btnCircularMotionCCW.includeInLayout = false;
         if(this._target is ISlidable && ISlidable(this._target).slideEnabled)
         {
            this._btnSlide.includeInLayout = this._btnSlide.visible = true;
            this._btnSlide.selected = ISlidable(this._target).isSliding;
         }
      }
      
      private function onCharActionChange(param1:AssetEvent) : void
      {
         this._btnSlide.selected = Character(this._target).isSliding;
      }
      
      private function onSlideBtnClick() : void
      {
         var _loc1_:ICommand = null;
         if(this._target is ISlidable)
         {
            if(this._btnSlide.selected)
            {
               _loc1_ = new ChangeActionCommand();
               _loc1_.execute();
               ISlidable(this._target).startSlideMotion();
            }
            else
            {
               _loc1_ = new RemoveMotionCommand();
               _loc1_.execute();
               ISlidable(this._target).removeSlideMotion();
            }
         }
      }
      
      private function onCircularMotionCWBtnClick() : void
      {
         var _loc1_:ICommand = null;
         if(this._target is ISupportCircularMotion)
         {
            if(ISupportCircularMotion(this._target).circularMotion)
            {
               if(ISupportCircularMotion(this._target).circularMotion.isCW)
               {
                  ISupportCircularMotion(this._target).removeCircularMotion();
               }
               else
               {
                  ISupportCircularMotion(this._target).circularMotion.isCW = true;
               }
            }
            else
            {
               ISupportCircularMotion(this._target).startCircularMotion();
            }
         }
      }
      
      private function onCircularMotionCCWBtnClick() : void
      {
         var _loc1_:ICommand = null;
         if(this._target is ISupportCircularMotion)
         {
            if(ISupportCircularMotion(this._target).circularMotion)
            {
               if(!ISupportCircularMotion(this._target).circularMotion.isCW)
               {
                  ISupportCircularMotion(this._target).removeCircularMotion();
               }
               else
               {
                  ISupportCircularMotion(this._target).circularMotion.isCW = false;
               }
            }
            else
            {
               ISupportCircularMotion(this._target).startCircularMotion(false);
            }
         }
      }
      
      private function onZoomBtnClick() : void
      {
         var _loc1_:MainStage = Console.getConsole().mainStage;
         if(_loc1_)
         {
            if(this._btnZoom.selected)
            {
               _loc1_.showCameraView();
               this._btnZoom.toolTip = UtilDict.toDisplay("go","ctrlbtnbar_lookout");
            }
            else
            {
               _loc1_.hideCameraView();
               this._btnZoom.toolTip = UtilDict.toDisplay("go","ctrlbtnbar_lookinto");
            }
         }
      }
      
      private function onClickCopyScene() : void
      {
         Console.getConsole().copyCurrentScene();
         this._btnPaste.visible = this._btnPaste.includeInLayout = true;
      }
      
      private function onClickDelete() : void
      {
         if(this._target is AnimeScene)
         {
            Console.getConsole().deleteCurrentScene();
         }
         else
         {
            Console.getConsole().deleteAsset();
         }
      }
      
      private function _AssetButtonBar_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         this.fadeIn = _loc1_;
         BindingManager.executeBindings(this,"fadeIn",this.fadeIn);
         return _loc1_;
      }
      
      private function _AssetButtonBar_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         this.fadeOut = _loc1_;
         BindingManager.executeBindings(this,"fadeOut",this.fadeOut);
         return _loc1_;
      }
      
      public function ___btnSlide_click(param1:MouseEvent) : void
      {
         this.onSlideBtnClick();
      }
      
      public function ___btnCircularMotionCW_click(param1:MouseEvent) : void
      {
         this.onCircularMotionCWBtnClick();
      }
      
      public function ___btnCircularMotionCCW_click(param1:MouseEvent) : void
      {
         this.onCircularMotionCCWBtnClick();
      }
      
      public function ___btnCCLookAtCamera_click(param1:MouseEvent) : void
      {
         Console.getConsole().flipCCLookAtCamera();
      }
      
      public function ___btnFlip_click(param1:MouseEvent) : void
      {
         Console.getConsole().flipAsset();
      }
      
      public function ___btnForward_click(param1:MouseEvent) : void
      {
         Console.getConsole().bringForward();
      }
      
      public function ___btnBackward_click(param1:MouseEvent) : void
      {
         Console.getConsole().sendBackward();
      }
      
      public function ___btnZoom_click(param1:MouseEvent) : void
      {
         this.onZoomBtnClick();
      }
      
      public function ___btnEdit_click(param1:MouseEvent) : void
      {
         Console.getConsole().editAsset();
      }
      
      public function ___btnColor_click(param1:MouseEvent) : void
      {
         Console.getConsole().showOverTray();
      }
      
      public function ___btnMovie_But1Click(param1:Event) : void
      {
         Console.getConsole().playMovie();
      }
      
      public function ___btnMovie_But2Click(param1:Event) : void
      {
         Console.getConsole().pauseMovie();
      }
      
      public function ___btnPreview_click(param1:MouseEvent) : void
      {
         Console.getConsole().preview(null,true);
      }
      
      public function ___btnCopy_click(param1:MouseEvent) : void
      {
         this.onClickCopyScene();
      }
      
      public function ___btnPaste_click(param1:MouseEvent) : void
      {
         Console.getConsole().pasteScene();
      }
      
      public function ___btnClear_click(param1:MouseEvent) : void
      {
         Console.getConsole().clearCurrentScene();
      }
      
      public function ___btnDelete_click(param1:MouseEvent) : void
      {
         this.onClickDelete();
      }
      
      private function _AssetButtonBar_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,null,function(param1:*):void
         {
            this.setStyle("showEffect",param1);
         },"this.showEffect","fadeIn");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Slide");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnSlide.toolTip");
         result[2] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Circular Motion (clockwise)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCircularMotionCW.toolTip");
         result[3] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Circular Motion (counter clockwise)");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCircularMotionCCW.toolTip");
         result[4] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Look at Camera");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCCLookAtCamera.toolTip");
         result[5] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_flip");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnFlip.toolTip");
         result[6] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_forward");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnForward.toolTip");
         result[7] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_backward");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnBackward.toolTip");
         result[8] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_lookinto");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnZoom.toolTip");
         result[9] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_edit");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnEdit.toolTip");
         result[10] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_color");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnColor.toolTip");
         result[11] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Preview from here");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnPreview.toolTip");
         result[12] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Copy Scene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnCopy.toolTip");
         result[13] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Paste Scene");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnPaste.toolTip");
         result[14] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Clear");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnClear.toolTip");
         result[15] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_delete");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_btnDelete.toolTip");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnBackward() : Button
      {
         return this._1015222112_btnBackward;
      }
      
      public function set _btnBackward(param1:Button) : void
      {
         var _loc2_:Object = this._1015222112_btnBackward;
         if(_loc2_ !== param1)
         {
            this._1015222112_btnBackward = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnBackward",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCCLookAtCamera() : Button
      {
         return this._1147697068_btnCCLookAtCamera;
      }
      
      public function set _btnCCLookAtCamera(param1:Button) : void
      {
         var _loc2_:Object = this._1147697068_btnCCLookAtCamera;
         if(_loc2_ !== param1)
         {
            this._1147697068_btnCCLookAtCamera = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCCLookAtCamera",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCircularMotionCCW() : Button
      {
         return this._946561915_btnCircularMotionCCW;
      }
      
      public function set _btnCircularMotionCCW(param1:Button) : void
      {
         var _loc2_:Object = this._946561915_btnCircularMotionCCW;
         if(_loc2_ !== param1)
         {
            this._946561915_btnCircularMotionCCW = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCircularMotionCCW",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCircularMotionCW() : Button
      {
         return this._108013094_btnCircularMotionCW;
      }
      
      public function set _btnCircularMotionCW(param1:Button) : void
      {
         var _loc2_:Object = this._108013094_btnCircularMotionCW;
         if(_loc2_ !== param1)
         {
            this._108013094_btnCircularMotionCW = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCircularMotionCW",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnClear() : Button
      {
         return this._2122116432_btnClear;
      }
      
      public function set _btnClear(param1:Button) : void
      {
         var _loc2_:Object = this._2122116432_btnClear;
         if(_loc2_ !== param1)
         {
            this._2122116432_btnClear = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnClear",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnColor() : Button
      {
         return this._2122019898_btnColor;
      }
      
      public function set _btnColor(param1:Button) : void
      {
         var _loc2_:Object = this._2122019898_btnColor;
         if(_loc2_ !== param1)
         {
            this._2122019898_btnColor = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnColor",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopy() : Button
      {
         return this._1731020110_btnCopy;
      }
      
      public function set _btnCopy(param1:Button) : void
      {
         var _loc2_:Object = this._1731020110_btnCopy;
         if(_loc2_ !== param1)
         {
            this._1731020110_btnCopy = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopy",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelete() : Button
      {
         return this._1338722904_btnDelete;
      }
      
      public function set _btnDelete(param1:Button) : void
      {
         var _loc2_:Object = this._1338722904_btnDelete;
         if(_loc2_ !== param1)
         {
            this._1338722904_btnDelete = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDelete",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnEdit() : Button
      {
         return this._1730971321_btnEdit;
      }
      
      public function set _btnEdit(param1:Button) : void
      {
         var _loc2_:Object = this._1730971321_btnEdit;
         if(_loc2_ !== param1)
         {
            this._1730971321_btnEdit = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnEdit",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnFlip() : Button
      {
         return this._1730933846_btnFlip;
      }
      
      public function set _btnFlip(param1:Button) : void
      {
         var _loc2_:Object = this._1730933846_btnFlip;
         if(_loc2_ !== param1)
         {
            this._1730933846_btnFlip = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnFlip",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnForward() : Button
      {
         return this._778345880_btnForward;
      }
      
      public function set _btnForward(param1:Button) : void
      {
         var _loc2_:Object = this._778345880_btnForward;
         if(_loc2_ !== param1)
         {
            this._778345880_btnForward = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnForward",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnMovie() : DoubleStateButton
      {
         return this._2112775277_btnMovie;
      }
      
      public function set _btnMovie(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._2112775277_btnMovie;
         if(_loc2_ !== param1)
         {
            this._2112775277_btnMovie = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnMovie",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPaste() : Button
      {
         return this._2110424330_btnPaste;
      }
      
      public function set _btnPaste(param1:Button) : void
      {
         var _loc2_:Object = this._2110424330_btnPaste;
         if(_loc2_ !== param1)
         {
            this._2110424330_btnPaste = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPaste",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPreview() : Button
      {
         return this._419384469_btnPreview;
      }
      
      public function set _btnPreview(param1:Button) : void
      {
         var _loc2_:Object = this._419384469_btnPreview;
         if(_loc2_ !== param1)
         {
            this._419384469_btnPreview = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPreview",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSlide() : Button
      {
         return this._2107336172_btnSlide;
      }
      
      public function set _btnSlide(param1:Button) : void
      {
         var _loc2_:Object = this._2107336172_btnSlide;
         if(_loc2_ !== param1)
         {
            this._2107336172_btnSlide = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSlide",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnZoom() : Button
      {
         return this._1730334960_btnZoom;
      }
      
      public function set _btnZoom(param1:Button) : void
      {
         var _loc2_:Object = this._1730334960_btnZoom;
         if(_loc2_ !== param1)
         {
            this._1730334960_btnZoom = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnZoom",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOut() : Fade
      {
         return this._1091436750fadeOut;
      }
      
      public function set fadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._1091436750fadeOut;
         if(_loc2_ !== param1)
         {
            this._1091436750fadeOut = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOut",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isFullVersion() : Boolean
      {
         return this._2091909055isFullVersion;
      }
      
      public function set isFullVersion(param1:Boolean) : void
      {
         var _loc2_:Object = this._2091909055isFullVersion;
         if(_loc2_ !== param1)
         {
            this._2091909055isFullVersion = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isFullVersion",_loc2_,param1));
            }
         }
      }
   }
}
