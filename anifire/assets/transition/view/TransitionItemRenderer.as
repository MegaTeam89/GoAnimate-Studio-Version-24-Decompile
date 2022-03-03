package anifire.assets.transition.view
{
   import anifire.assets.panel.AssetThumbnail;
   import anifire.assets.transition.AssetTransitionConstants;
   import anifire.assets.transition.model.AssetTransition;
   import anifire.assets.transition.model.AssetTransitionEvent;
   import anifire.core.Console;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IIterator;
   import anifire.util.UtilDict;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class TransitionItemRenderer extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _TransitionItemRenderer_HBox1:HBox;
      
      private var _1724546052description:Label;
      
      private var _1992012396duration:Label;
      
      private var _1330532588thumbnail:AssetThumbnail;
      
      private var _3575610type:Label;
      
      private var _481045639warningSign:Image;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _transition:AssetTransition;
      
      private var _embed_mxml_img_warn_png_378185311:Class;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function TransitionItemRenderer()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":HBox,
                  "id":"_TransitionItemRenderer_HBox1",
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "middle";
                     this.backgroundColor = 2697513;
                     this.backgroundAlpha = 0;
                     this.paddingBottom = 3;
                     this.paddingLeft = 3;
                     this.paddingRight = 3;
                     this.paddingTop = 3;
                     this.borderStyle = "solid";
                     this.borderColor = 6710886;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.backgroundColor = 4473924;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"childDescriptors":[new UIComponentDescriptor({
                                 "type":AssetThumbnail,
                                 "id":"thumbnail",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "width":40,
                                       "height":40
                                    };
                                 }
                              })]};
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.verticalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"type",
                                    "stylesFactory":function():void
                                    {
                                       this.color = 16777215;
                                       this.fontWeight = "bold";
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"description",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 8947848;
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Spacer,
                                             "propertiesFactory":function():Object
                                             {
                                                return {"percentWidth":100};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"duration",
                                             "stylesFactory":function():void
                                             {
                                                this.color = 8947848;
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
                  "type":Image,
                  "id":"warningSign",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "source":_embed_mxml_img_warn_png_378185311,
                        "right":4,
                        "top":4
                     };
                  }
               })]};
            }
         });
         this._embed_mxml_img_warn_png_378185311 = TransitionItemRenderer__embed_mxml_img_warn_png_378185311;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._TransitionItemRenderer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_assets_transition_view_TransitionItemRendererWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return TransitionItemRenderer[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         TransitionItemRenderer._watcherSetupUtil = param1;
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
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         if(this._transition)
         {
            this._transition.removeEventListener(Event.CHANGE,this.onTransitionChange);
            this._transition.removeEventListener(AssetTransitionEvent.CONFLICT_CHANGE,this.onTransitionChange);
         }
         this._transition = param1 as AssetTransition;
         this.refreshUI();
         if(this._transition)
         {
            this._transition.addEventListener(Event.CHANGE,this.onTransitionChange);
            this._transition.addEventListener(AssetTransitionEvent.CONFLICT_CHANGE,this.onTransitionChange);
         }
      }
      
      private function onTransitionChange(param1:Event) : void
      {
         this.refreshUI();
      }
      
      private function refreshUI() : void
      {
         var _loc1_:IIterator = null;
         var _loc2_:IAssetView = null;
         if(this._transition && this.type)
         {
            this.type.text = AssetTransitionConstants.getDirectionLabel(this._transition.direction) + " > " + AssetTransitionConstants.getTypeLabel(this._transition.type);
            this.description.text = AssetTransitionConstants.getTimingLabel(this._transition.timing);
            this.duration.text = UtilUnitConvert.frameToDuration(this._transition.duration).toString() + "s";
            this.type.setStyle("color",this._transition.direction == AssetTransitionConstants.DIRECTION_IN ? 6737151 : 16211289);
            this.thumbnail.visible = false;
            _loc1_ = Console.getConsole().mainStage.sceneEditor.view.iterator();
            while(_loc1_.hasNext)
            {
               _loc2_ = _loc1_.next as IAssetView;
               if(_loc2_ && _loc2_.asset.id == this._transition.assetId)
               {
                  this.thumbnail.target = _loc2_;
                  this.thumbnail.visible = true;
                  break;
               }
            }
            this.warningSign.visible = this._transition.conflict;
         }
      }
      
      private function _TransitionItemRenderer_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():Number
         {
            return this.width - 2;
         },null,"_TransitionItemRenderer_HBox1.width");
         result[1] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","This motion cannot play as it overlaps with another motion with the same asset. Adjust the timing for better result.");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"warningSign.toolTip");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get description() : Label
      {
         return this._1724546052description;
      }
      
      public function set description(param1:Label) : void
      {
         var _loc2_:Object = this._1724546052description;
         if(_loc2_ !== param1)
         {
            this._1724546052description = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"description",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get duration() : Label
      {
         return this._1992012396duration;
      }
      
      public function set duration(param1:Label) : void
      {
         var _loc2_:Object = this._1992012396duration;
         if(_loc2_ !== param1)
         {
            this._1992012396duration = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"duration",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get thumbnail() : AssetThumbnail
      {
         return this._1330532588thumbnail;
      }
      
      public function set thumbnail(param1:AssetThumbnail) : void
      {
         var _loc2_:Object = this._1330532588thumbnail;
         if(_loc2_ !== param1)
         {
            this._1330532588thumbnail = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"thumbnail",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get type() : Label
      {
         return this._3575610type;
      }
      
      public function set type(param1:Label) : void
      {
         var _loc2_:Object = this._3575610type;
         if(_loc2_ !== param1)
         {
            this._3575610type = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"type",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get warningSign() : Image
      {
         return this._481045639warningSign;
      }
      
      public function set warningSign(param1:Image) : void
      {
         var _loc2_:Object = this._481045639warningSign;
         if(_loc2_ !== param1)
         {
            this._481045639warningSign = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"warningSign",_loc2_,param1));
            }
         }
      }
   }
}
