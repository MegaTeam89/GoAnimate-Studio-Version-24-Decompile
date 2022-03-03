package anifire.assets.panel
{
   import anifire.color.SelectedColor;
   import anifire.command.ColorAssetCommand;
   import anifire.command.ICommand;
   import anifire.core.Asset;
   import anifire.core.Character;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IColorable;
   import anifire.util.UtilArray;
   import anifire.util.UtilDict;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil2;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.ColorPicker;
   import mx.controls.Label;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ColorPickerEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class AssetViewColorPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil2;
       
      
      public var _AssetViewColorPanel_Button1:Button;
      
      private var _1275269217colorPanel:VBox;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _asset:Asset;
      
      private var _view:IAssetView;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      public function AssetViewColorPanel()
      {
         var target:Object = null;
         var watcherSetupUtilClass:Object = null;
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "id":"colorPanel",
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 15;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"_AssetViewColorPanel_Button1",
                  "events":{"click":"___AssetViewColorPanel_Button1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "bottom":0,
                        "styleName":"btnSidePanel",
                        "maxWidth":150,
                        "buttonMode":true
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         var bindings:Array = this._AssetViewColorPanel_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_assets_panel_AssetViewColorPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },function(param1:String):*
         {
            return AssetViewColorPanel[param1];
         },bindings,watchers);
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         this.percentWidth = 100;
         this.percentHeight = 100;
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
      {
         AssetViewColorPanel._watcherSetupUtil = param1;
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
         this._view = null;
         if(param1 is IAssetView)
         {
            this._view = param1 as IAssetView;
            param1 = this._view.asset as Asset;
         }
         if(this._asset)
         {
            this._asset.removeEventListener(AssetEvent.STATE_CHANGE,this.onAssetStateChange);
         }
         if(param1 is Asset)
         {
            this._asset = param1 as Asset;
            this._asset.addEventListener(AssetEvent.STATE_CHANGE,this.onAssetStateChange);
         }
         else
         {
            this._asset = null;
         }
         this.updateColorPanel();
      }
      
      private function onAssetStateChange(param1:AssetEvent) : void
      {
         this.updateColorPanel();
      }
      
      private function updateColorPanel() : void
      {
         var _loc1_:HBox = null;
         var _loc2_:Label = null;
         var _loc3_:Array = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc6_:ColorPicker = null;
         var _loc7_:Array = null;
         this.colorPanel.removeAllChildren();
         if(this._asset)
         {
            _loc3_ = this._asset.getColorArea();
            if(this._view)
            {
               if((_loc4_ = this._view.assetImage) is IColorable)
               {
                  _loc3_ = _loc3_.concat(IColorable(_loc4_).colorableArea);
               }
            }
            _loc3_ = UtilArray.removeDuplicates(_loc3_,true);
            if(_loc3_)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  _loc1_ = new HBox();
                  _loc2_ = new Label();
                  _loc2_.maxWidth = 200;
                  _loc2_.text = UtilDict.toDisplay("store",_loc3_[_loc5_]) + ":";
                  (_loc6_ = new ColorPicker()).id = _loc3_[_loc5_];
                  _loc6_.buttonMode = true;
                  if(this._asset.customColor.getValueByKey(_loc3_[_loc5_]) != null)
                  {
                     _loc6_.selectedColor = SelectedColor(this._asset.customColor.getValueByKey(_loc3_[_loc5_])).dstColor;
                  }
                  else
                  {
                     _loc6_.selectedColor = 0;
                  }
                  if(this._asset.thumb.colorRef.getValueByKey(_loc3_[_loc5_]) != null)
                  {
                     _loc7_ = String(this._asset.thumb.colorRef.getValueByKey(_loc3_[_loc5_])).split(",");
                     _loc6_.dataProvider = _loc7_;
                  }
                  _loc6_.addEventListener(ColorPickerEvent.CHANGE,this.updateColor,false,0,true);
                  _loc1_.addChild(_loc2_);
                  _loc1_.addChild(_loc6_);
                  this.colorPanel.addChild(_loc1_);
                  _loc5_++;
               }
            }
         }
      }
      
      private function updateColor(param1:ColorPickerEvent) : void
      {
         var _loc2_:ICommand = null;
         if(this._asset)
         {
            _loc2_ = new ColorAssetCommand(this._asset.id,ColorPicker(param1.currentTarget).id);
            _loc2_.execute();
            this._asset.doChangeColor(ColorPicker(param1.currentTarget).id,param1.color);
         }
      }
      
      private function onRestoreBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:ICommand = null;
         var _loc3_:Array = null;
         if(this._asset)
         {
            _loc2_ = new ColorAssetCommand(this._asset.id);
            _loc2_.execute();
            this._asset.restoreColor();
            this.updateColorPanel();
         }
         if(this._asset is Character)
         {
            _loc3_ = this._asset.getColorArea();
            Character(this._asset).restoreColorById(_loc3_);
         }
      }
      
      public function ___AssetViewColorPanel_Button1_click(param1:MouseEvent) : void
      {
         this.onRestoreBtnClick(param1);
      }
      
      private function _AssetViewColorPanel_bindingsSetup() : Array
      {
         var result:Array = [];
         result[0] = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","propwin_restore");
            return _loc1_ == undefined ? null : String(_loc1_);
         },null,"_AssetViewColorPanel_Button1.label");
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get colorPanel() : VBox
      {
         return this._1275269217colorPanel;
      }
      
      public function set colorPanel(param1:VBox) : void
      {
         var _loc2_:Object = this._1275269217colorPanel;
         if(_loc2_ !== param1)
         {
            this._1275269217colorPanel = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colorPanel",_loc2_,param1));
            }
         }
      }
   }
}
