package anifire.components.containers
{
   import anifire.component.GoAlert;
   import anifire.components.studio.ILock;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.core.BackgroundThumb;
   import anifire.core.CharThumb;
   import anifire.core.EffectThumb;
   import anifire.core.PropThumb;
   import anifire.core.SoundThumb;
   import anifire.core.TemplateThumb;
   import anifire.core.Thumb;
   import anifire.core.VideoPropThumb;
   import anifire.event.CoreEvent;
   import anifire.events.AssetPurchasedEvent;
   import anifire.events.CopyThumbEvent;
   import anifire.events.ProductEvent;
   import anifire.interfaces.IProduct;
   import anifire.interfaces.IProductThumb;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.FlexGlobals;
   import mx.core.MovieClipLoaderAsset;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.events.FlexEvent;
   import mx.managers.PopUpManager;
   import mx.styles.CSSStyleDeclaration;
   
   public class ThumbnailCanvas extends Canvas
   {
      
      private static var OVERLAY:String = "OVERLAY";
      
      private static var _thumbnails:UtilHashArray = new UtilHashArray();
       
      
      private const BUTTON_WIDTH:Number = 20;
      
      private const BUTTON_HEIGHT:Number = 20;
      
      private var _thumb:Thumb;
      
      private var _btnCopy:Button;
      
      private var _btnDelete:Button;
      
      private var _btnInfo:Button;
      
      private var _btnPlay:Button;
      
      private var _btnStop:Button;
      
      private var _btnTemplateInfo:Button;
      
      private var _editable:Boolean;
      
      private var _locked:ILock;
      
      private var _displayObj:DisplayObject;
      
      private var _playButtonShowable:Boolean = true;
      
      private var _buyButtonShowable:Boolean = true;
      
      private var _allowPremium:Boolean;
      
      private var _colorSetId:String;
      
      private var _soundButtonStyle:Number = 0;
      
      private var _useSmallButton:Boolean = false;
      
      private var _copyable:Boolean = false;
      
      private var PremiumIcon:Class;
      
      private var PremiumIconB:Class;
      
      private var BuyBucksIcon:Class;
      
      private var BuyPointsIcon:Class;
      
      private var SmallBuyPointsIcon:Class;
      
      private var _premIcon:UIComponent;
      
      private var _btnBuy:Canvas;
      
      private var _displayId:Boolean = false;
      
      public var closeWindow:Function;
      
      private var _maskCanvas:Canvas = null;
      
      private var _idDisplay:Canvas = null;
      
      public function ThumbnailCanvas(param1:Number, param2:Number, param3:DisplayObject, param4:IProduct, param5:Boolean, param6:Boolean, param7:Boolean, param8:String = "", param9:Boolean = true, param10:Number = 0, param11:Boolean = false, param12:Boolean = false)
      {
         var _loc14_:DropShadowFilter = null;
         var _loc15_:Array = null;
         var _loc16_:MovieClipLoaderAsset = null;
         this.PremiumIcon = ThumbnailCanvas_PremiumIcon;
         this.PremiumIconB = ThumbnailCanvas_PremiumIconB;
         this.BuyBucksIcon = ThumbnailCanvas_BuyBucksIcon;
         this.BuyPointsIcon = ThumbnailCanvas_BuyPointsIcon;
         this.SmallBuyPointsIcon = ThumbnailCanvas_SmallBuyPointsIcon;
         super();
         var _loc13_:Thumb = param4 as Thumb;
         this.buttonMode = true;
         this._allowPremium = param7;
         this._buyButtonShowable = param7 && _loc13_.premium;
         this.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.verticalScrollPolicy = ScrollPolicy.OFF;
         this.width = param1;
         this.height = param2;
         this.scrollRect = new Rectangle(0,0,this.width,this.height);
         this._useSmallButton = param11;
         this._thumb = _loc13_;
         this.colorSetId = param8;
         if(_loc13_ is VideoPropThumb)
         {
            this.styleName = "tileBackground";
            this.name = "cellUserBackground";
         }
         else if(_loc13_ is PropThumb)
         {
            this.styleName = "tileProp";
            this.name = "cellUserProp";
            if(PropThumb(_loc13_).getStateNum() > 0)
            {
               _loc14_ = new DropShadowFilter(2,45,6710886,1,0,0);
               (_loc15_ = new Array()).push(_loc14_);
               filters = _loc15_;
            }
         }
         else if(_loc13_ is BackgroundThumb || _loc13_ is TemplateThumb)
         {
            this.styleName = "tileBackground";
            this.name = "cellUserBackground";
         }
         else if(_loc13_ is CharThumb)
         {
            this.styleName = "tileChar";
            this.name = "cellUserCharacter";
         }
         else if(_loc13_ is SoundThumb)
         {
            this.name = "cellUserSound";
         }
         else if(_loc13_ is EffectThumb)
         {
            this.styleName = "tileBubble";
            this.name = "cellUserEffect";
         }
         this._editable = param5;
         this._copyable = param6;
         this._soundButtonStyle = param10;
         this.updateDisplayObject(param3,param12);
         if(param9)
         {
            this.addButtons();
         }
         if(param7 && _loc13_.premium)
         {
            if(Number(_loc13_.cost[0]) > 0)
            {
               _loc16_ = new this.PremiumIcon();
            }
            else
            {
               _loc16_ = new this.PremiumIconB();
            }
            _loc16_.y = param2 - _loc16_.height * 0.85;
            _loc16_.width *= 0.85;
            _loc16_.height *= 0.85;
            this._premIcon = new UIComponent();
            this._premIcon.addChild(_loc16_);
            if(_loc13_.purchased)
            {
               this.addToPremiumThumbTray();
               this.addSelfListeners();
               this.addChild(this._premIcon);
            }
         }
         else
         {
            this.addSelfListeners();
         }
         _loc13_.addEventListener(ProductEvent.PRODUCT_PURCHASED,this.onProductPurchased);
      }
      
      public static function getThumbnail(param1:Number, param2:Number, param3:DisplayObject, param4:Thumb, param5:Boolean, param6:Boolean, param7:Boolean, param8:String = "", param9:Boolean = true, param10:Number = 0, param11:Boolean = false, param12:Boolean = false) : ThumbnailCanvas
      {
         var _loc13_:ThumbnailCanvas = _thumbnails.getValueByKey(param4.id);
         return new ThumbnailCanvas(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function get displayObj() : DisplayObject
      {
         return this._displayObj;
      }
      
      public function get showId() : Boolean
      {
         return this._displayId;
      }
      
      public function set showId(param1:Boolean) : void
      {
         this._displayId = param1;
      }
      
      public function get colorSetId() : String
      {
         return this._colorSetId;
      }
      
      public function set colorSetId(param1:String) : void
      {
         this._colorSetId = param1;
      }
      
      private function onProductPurchased(param1:ProductEvent) : void
      {
         IEventDispatcher(param1.target).removeEventListener(param1.type,this.onProductPurchased);
         this.changeToPurchased();
      }
      
      public function updateDisplayObject(param1:DisplayObject, param2:Boolean = false) : void
      {
         var _loc3_:DisplayObject = this.getChildByName(AnimeConstants.IMAGE_OBJECT_NAME);
         if(_loc3_ != null)
         {
            this.removeChild(_loc3_);
         }
         this._displayObj = param1;
         this._displayObj.name = AnimeConstants.IMAGE_OBJECT_NAME;
         this._displayObj.blendMode = BlendMode.LAYER;
         this.addChildAt(this._displayObj,0);
      }
      
      private function addToPremiumThumbTray() : void
      {
      }
      
      public function changeToPurchased() : void
      {
         this._buyButtonShowable = false;
         this._btnBuy.visible = false;
         this.addToPremiumThumbTray();
         this._displayObj.filters = null;
         this.addSelfListeners();
         this._thumb.purchase();
         this.addChild(this._premIcon);
      }
      
      public function get thumb() : Thumb
      {
         return this._thumb;
      }
      
      public function set thumbnailName(param1:String) : void
      {
         this.thumb.name = param1;
         if(this._displayObj is Image)
         {
            Image(this._displayObj).toolTip = param1;
         }
         else if(this._displayObj is SoundTileCell)
         {
            SoundTileCell(this._displayObj).tileLabel = param1;
         }
      }
      
      public function get locked() : ILock
      {
         return this._locked;
      }
      
      public function set locked(param1:ILock) : void
      {
         var _loc2_:* = this._locked != param1;
         this._locked = param1;
         if(_loc2_)
         {
            invalidateDisplayList();
         }
      }
      
      public function get editable() : Boolean
      {
         return this._editable;
      }
      
      public function get copyable() : Boolean
      {
         return this._copyable;
      }
      
      public function set editable(param1:Boolean) : void
      {
         this._editable = param1;
      }
      
      public function set copyable(param1:Boolean) : void
      {
         this._copyable = param1;
         if(param1)
         {
            this._btnDelete.x = this.BUTTON_WIDTH + 8;
            this._btnInfo.x = 2 * this.BUTTON_WIDTH + 8;
         }
         else
         {
            this._btnDelete.x = 0;
            this._btnInfo.x = 0;
         }
      }
      
      public function deleteThumbnail(param1:Boolean = true) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:URLVariables = null;
         var _loc4_:URLStream = null;
         if(this._displayObj is SoundTileCell)
         {
            (this._displayObj as SoundTileCell).stopSound();
         }
         if(this.parent is IProductThumb)
         {
            if(this.parent.parent)
            {
               this.parent.parent.removeChild(this.parent);
            }
         }
         else
         {
            this.parent.removeChild(this);
         }
         if(param1)
         {
            _loc3_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc3_);
            if(this.thumb is TemplateThumb)
            {
               _loc3_["templateId"] = this.thumb.id;
               _loc2_ = new URLRequest(ServerConstants.ACTION_DELETE_TEMPLATE);
            }
            else
            {
               _loc3_["assetId"] = this.thumb.id;
               _loc2_ = new URLRequest(ServerConstants.ACTION_DELETE_ASSET);
            }
            _loc2_.method = URLRequestMethod.POST;
            _loc2_.data = _loc3_;
            (_loc4_ = new URLStream()).load(_loc2_);
         }
      }
      
      public function hideStopButton(param1:Event) : void
      {
         if(this._btnStop != null)
         {
            this._btnStop.visible = false;
         }
         this.playButtonShowable = true;
      }
      
      private function showDeleteConfirmWindow(param1:Event) : void
      {
         var _loc2_:GoAlert = GoAlert(PopUpManager.createPopUp(this,GoAlert,true));
         if(this.thumb is PropThumb)
         {
            _loc2_.assetType = "Prop";
         }
         else if(this.thumb is BackgroundThumb)
         {
            _loc2_.assetType = "Background";
         }
         else if(this.thumb is SoundThumb)
         {
            _loc2_.assetType = "Sound";
         }
         else if(this.thumb is CharThumb)
         {
            _loc2_.assetType = "Character";
         }
         else if(this.thumb is EffectThumb)
         {
            _loc2_.assetType = "Effect";
         }
         else if(this.thumb is TemplateThumb)
         {
            _loc2_.assetType = AnimeConstants.ASSET_TYPE_TEMPLATE;
         }
         _loc2_.thumbnailCanvas = this;
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
      }
      
      private function get playButtonShowable() : Boolean
      {
         return this._playButtonShowable;
      }
      
      private function get buyButtonShowable() : Boolean
      {
         return this._buyButtonShowable;
      }
      
      private function set playButtonShowable(param1:Boolean) : void
      {
         this._playButtonShowable = param1;
      }
      
      private function showEditPanel(param1:MouseEvent) : void
      {
         var _loc2_:UtilHashArray = Util.getFlashVar();
         var _loc3_:String = _loc2_.getValueByKey("uplp");
         var _loc4_:AssetInfoWindow;
         (_loc4_ = AssetInfoWindow(PopUpManager.createPopUp(this,AssetInfoWindow,true))).thumb = this.thumb;
         _loc4_.thumbnailCanvas = this;
         _loc4_.x = (_loc4_.stage.width - _loc4_.width) / 2;
         _loc4_.y = 100;
         _loc4_.assetId = this.thumb.id;
         _loc4_.assetTitle = this.thumb.name;
         _loc4_.tags = this.thumb.tags;
         _loc4_.isPublished = this.thumb.isPublished;
         _loc4_.allowPublish = this.isAllowPublish();
         if(UtilLicense.isSchoolEnvironment())
         {
            _loc4_.allowPublish = _loc3_ && _loc3_ == "1";
         }
      }
      
      private function showEditTemplatePanel(param1:MouseEvent) : void
      {
         var _loc2_:TemplateInfoWindow = TemplateInfoWindow(PopUpManager.createPopUp(this,TemplateInfoWindow,true));
         _loc2_.thumb = this.thumb;
         _loc2_.thumbnailCanvas = this;
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
         _loc2_.movieId = this.thumb.id;
      }
      
      private function isAllowPublish() : Boolean
      {
         if(this.thumb is VideoPropThumb)
         {
            return false;
         }
         return true;
      }
      
      private function doDispatchAssetPurchasedEvent(param1:AssetPurchasedEvent) : void
      {
         this.dispatchEvent(param1.clone());
      }
      
      private function showBuyPanel(param1:MouseEvent) : void
      {
         var buyWindow:AssetPurchaseWindow = null;
         var event:MouseEvent = param1;
         buyWindow = AssetPurchaseWindow(PopUpManager.createPopUp(this,AssetPurchaseWindow,true));
         buyWindow.loggedIn = UtilUser.loggedIn;
         buyWindow.addEventListener(AssetPurchasedEvent.ASSET_PURCHASED,this.doDispatchAssetPurchasedEvent);
         var buyButton:Button = new Button();
         buyWindow.thumbnailCanvas = this;
         buyWindow.x = (buyWindow.stage.width - buyWindow.width) / 2;
         buyWindow.y = 200;
         buyWindow.aid = this.thumb.aid;
         buyWindow.theme_id = this.thumb.theme.id;
         buyWindow.assetTitle = UtilDict.toDisplay("store",this.thumb.name);
         if(!UtilUser.loggedIn)
         {
            buyWindow.switchBuyButtonToNonLogin();
         }
         else if(Number(this.thumb.cost[0]) > 0)
         {
            buyWindow.switchBuyButtonToBuyMe();
         }
         else
         {
            buyWindow.switchBuyButtonToAddMe();
         }
         this.closeWindow = function():void
         {
            PopUpManager.removePopUp(buyWindow);
         };
         buyWindow.thumb = this.thumb;
      }
      
      public function clickPlay(param1:MouseEvent = null) : void
      {
         if(this._displayObj != null && this._displayObj is SoundTileCell)
         {
            this._displayObj.addEventListener(CoreEvent.PLAY_SOUND_COMPLETE,this.hideStopButton);
            SoundTileCell(this._displayObj).playSound();
            this._displayObj.dispatchEvent(new Event(SoundTileCell.EVENT_PLAY_BUT_CLICK));
         }
         if(this._btnStop != null)
         {
            this._btnStop.visible = true;
            this.playButtonShowable = false;
         }
      }
      
      public function clickStop(param1:MouseEvent = null) : void
      {
         if(this._displayObj != null && this._displayObj is SoundTileCell)
         {
            SoundTileCell(this._displayObj).stopSound();
         }
         this._btnStop.visible = false;
         if(this._btnPlay != null)
         {
            this._btnPlay.visible = true;
         }
         this.playButtonShowable = true;
      }
      
      private function showButtons(param1:MouseEvent) : void
      {
         var _loc2_:Canvas = null;
         if(this._btnCopy != null)
         {
            this._btnCopy.visible = this._copyable;
         }
         if(this._btnDelete != null)
         {
            this._btnDelete.visible = this._editable;
         }
         if(this._btnInfo != null)
         {
            this._btnInfo.visible = this._editable;
         }
         if(this._btnTemplateInfo != null)
         {
            this._btnTemplateInfo.visible = true;
         }
         if(this._btnPlay != null && this.playButtonShowable)
         {
            this._btnPlay.visible = true;
         }
         if(this._btnBuy != null && this.buyButtonShowable)
         {
         }
         if(this.thumb is TemplateThumb && this.getChildByName(OVERLAY))
         {
            _loc2_ = Canvas(this.getChildByName(OVERLAY));
            _loc2_.visible = true;
         }
      }
      
      private function hideButtons(param1:MouseEvent) : void
      {
         var _loc2_:Canvas = null;
         if(this._btnCopy != null)
         {
            this._btnCopy.visible = false;
         }
         if(this._btnDelete != null)
         {
            this._btnDelete.visible = false;
         }
         if(this._btnInfo != null)
         {
            this._btnInfo.visible = false;
         }
         if(this._btnTemplateInfo != null)
         {
            this._btnTemplateInfo.visible = false;
         }
         if(this._btnPlay != null)
         {
            this._btnPlay.visible = false;
         }
         if(this._btnBuy != null)
         {
         }
         if(this.thumb is TemplateThumb && this.getChildByName(OVERLAY))
         {
            _loc2_ = Canvas(this.getChildByName(OVERLAY));
            _loc2_.visible = false;
         }
      }
      
      private function doDispatchUserWantToCopyThumbEvent(param1:Event) : void
      {
         var _loc2_:CopyThumbEvent = new CopyThumbEvent(CopyThumbEvent.USER_WANT_TO_COPY_THUMB,this);
         _loc2_.thumb = this.thumb;
         this.dispatchEvent(_loc2_);
      }
      
      private function addButtons() : void
      {
         var overlay:Canvas = null;
         var text:TextArea = null;
         var btnPlayX:Number = NaN;
         var btnPlayY:Number = NaN;
         var temp:Image = null;
         var costLabel:Label = null;
         var iconCls:Class = null;
         var panelHeight:int = 0;
         var cssRule:CSSStyleDeclaration = null;
         var snInfo:Canvas = null;
         var label:Label = null;
         if(this.thumb is TemplateThumb)
         {
            overlay = new Canvas();
            overlay.setStyle("backgroundColor","0x000000");
            overlay.setStyle("backgroundAlpha",0.5);
            overlay.x = AnimeConstants.TILE_INSETS;
            overlay.y = AnimeConstants.TILE_INSETS;
            overlay.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
            overlay.width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
            overlay.mouseChildren = false;
            overlay.mouseEnabled = false;
            overlay.focusEnabled = false;
            text = new TextArea();
            text.percentWidth = 100;
            text.height = 40;
            text.editable = false;
            text.selectable = false;
            text.setStyle("backgroundAlpha",0);
            text.setStyle("borderThickness",0);
            text.setStyle("color",16777215);
            text.text = UtilDict.toDisplay("go","Drag to insert\nafter scene");
            text.y = 18;
            overlay.addChild(text);
            overlay.name = OVERLAY;
            overlay.visible = false;
            this.addChild(overlay);
         }
         if(this.thumb is SoundThumb)
         {
            btnPlayX = this.width - this.BUTTON_WIDTH * 2;
            btnPlayY = (this.height - this.BUTTON_HEIGHT) / 2;
            this._btnPlay = new Button();
            this._btnPlay.styleName = "btnPlaySmall";
            this._btnPlay.x = btnPlayX;
            this._btnPlay.y = btnPlayY;
            this._btnStop = new Button();
            this._btnStop.styleName = "btnStopSmall";
            this._btnStop.x = btnPlayX;
            this._btnStop.y = btnPlayY;
            if(this._soundButtonStyle != 0)
            {
               if(this._soundButtonStyle == 1)
               {
                  this._btnPlay.alpha = 0;
                  this._btnStop.alpha = 0;
               }
            }
            this._btnPlay.visible = false;
            this._btnPlay.addEventListener(MouseEvent.CLICK,this.clickPlay);
            this.addChild(this._btnPlay);
            this._btnStop.visible = false;
            this._btnStop.addEventListener(MouseEvent.CLICK,this.clickStop);
            this.addChild(this._btnStop);
         }
         if(this.buyButtonShowable && !this.thumb.purchased)
         {
            temp = new Image();
            costLabel = new Label();
            if(Number(this.thumb.cost[0]) > 0)
            {
               cssRule = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".thumbTrayBuyBucksIcon" + this.width);
               iconCls = Class(cssRule.getStyle("source"));
               panelHeight = int(cssRule.getStyle("panelHeight"));
               costLabel.text = this.thumb.cost[0];
            }
            else
            {
               cssRule = FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".thumbTrayBuyPointsIcon" + this.width);
               iconCls = Class(cssRule.getStyle("source"));
               panelHeight = int(cssRule.getStyle("panelHeight"));
               costLabel.text = this.thumb.cost[1];
            }
            temp.source = new iconCls();
            temp.autoLoad = true;
            temp.visible = true;
            this._btnBuy = new Canvas();
            this._btnBuy.toolTip = this.thumb.name;
            if(UtilSite.isDevelopmentSite)
            {
               this._btnBuy.toolTip = this.thumb.toString();
            }
            this._btnBuy.clipContent = false;
            this._btnBuy.height = this.height;
            this._btnBuy.addChild(temp);
            this._btnBuy.addChild(costLabel);
            this.addChild(this._btnBuy);
            temp.setStyle("bottom",0);
            costLabel.styleName = "thumbTrayPremiumCost";
            costLabel.x = this.width / 2;
            temp.addEventListener(FlexEvent.UPDATE_COMPLETE,function(param1:Event):void
            {
               costLabel.setStyle("bottom",(panelHeight - costLabel.height) / 2);
            });
            this._btnBuy.graphics.beginFill(16711680,0);
            this._btnBuy.graphics.drawRect(0,0,this.width,this.height);
            this._btnBuy.graphics.endFill();
            this._btnBuy.addEventListener(MouseEvent.MOUSE_DOWN,this.showBuyPanel);
            this._btnBuy.addEventListener(MouseEvent.ROLL_OVER,function():void
            {
               _displayObj.filters = null;
            });
         }
         if(this.thumb is TemplateThumb)
         {
            snInfo = new Canvas();
            snInfo.autoLayout = true;
            snInfo.width = 27;
            snInfo.height = 18;
            snInfo.name = "snInfo";
            label = new Label();
            label.bottom = -1;
            label.right = 1;
            label.text = "x" + TemplateThumb(this.thumb).numScene;
            snInfo.addChild(label);
            this.updateSnInfoBg(snInfo);
            snInfo.bottom = 0;
            snInfo.right = 0;
            this.addChild(snInfo);
         }
         var btnCopyX:Number = 3;
         var btnCopyY:Number = 0;
         var btnDeleteX:Number = 0;
         var btnDeleteY:Number = 0;
         if(this.copyable)
         {
            btnDeleteX = btnCopyX + this.BUTTON_WIDTH + 3;
         }
         this._btnCopy = new Button();
         this._btnCopy.styleName = "btnCopySmall";
         this._btnCopy.visible = false;
         this._btnCopy.x = btnCopyX;
         this._btnCopy.addEventListener(MouseEvent.CLICK,this.doDispatchUserWantToCopyThumbEvent);
         this.addChild(this._btnCopy);
         this._btnCopy.toolTip = UtilDict.toDisplay("go","copy_char_tooltip");
         var btnInfoX:Number = btnDeleteX + this.BUTTON_WIDTH;
         var btnInfoY:Number = 0;
         if(this.thumb is SoundThumb)
         {
            btnDeleteX = this.width - this.BUTTON_WIDTH * 3;
            btnInfoX = btnDeleteX - this.BUTTON_WIDTH;
            btnDeleteY = btnInfoY = Number((this.height - this.BUTTON_HEIGHT) / 2);
         }
         this._btnDelete = new Button();
         this._btnDelete.styleName = "btnDeleteSmall";
         this._btnDelete.x = btnDeleteX;
         this._btnDelete.y = btnDeleteY;
         this._btnDelete.visible = false;
         this._btnDelete.addEventListener(MouseEvent.CLICK,this.showDeleteConfirmWindow);
         this.addChild(this._btnDelete);
         if(!(this.thumb is TemplateThumb))
         {
            this._btnInfo = new Button();
            this._btnInfo.styleName = "btnInfoSmall";
            this._btnInfo.x = btnInfoX;
            this._btnInfo.y = btnInfoY;
            this._btnInfo.visible = false;
            this._btnInfo.addEventListener(MouseEvent.CLICK,this.showEditPanel);
            this.addChild(this._btnInfo);
         }
         if(this.thumb is TemplateThumb && UtilUser.hasAdminFeatures)
         {
            this._btnTemplateInfo = new Button();
            this._btnTemplateInfo.styleName = "btnInfoSmall";
            this._btnTemplateInfo.x = btnDeleteX;
            this._btnTemplateInfo.y = btnDeleteY;
            this._btnTemplateInfo.visible = false;
            this._btnTemplateInfo.addEventListener(MouseEvent.CLICK,this.showEditTemplatePanel);
            this.addChild(this._btnTemplateInfo);
         }
      }
      
      private function updateSnInfoBg(param1:Canvas) : void
      {
         var _loc2_:uint = uint(FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".tileBackground").getStyle("backgroundColor"));
         param1.graphics.beginFill(_loc2_);
         param1.graphics.drawRoundRectComplex(0,0,param1.width,param1.height,5,0,0,5);
         param1.graphics.endFill();
      }
      
      private function addSelfListeners() : void
      {
         this.addEventListener(MouseEvent.ROLL_OVER,this.showButtons);
         this.addEventListener(MouseEvent.ROLL_OUT,this.hideButtons);
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc4_:Array = null;
         var _loc5_:ColorMatrixFilter = null;
         var _loc6_:Canvas = null;
         var _loc7_:Image = null;
         var _loc8_:Text = null;
         super.updateDisplayList(param1,param2);
         if(this.locked)
         {
            _loc4_ = [0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0,0,0,1,0];
            _loc5_ = new ColorMatrixFilter(_loc4_);
            this._displayObj.filters = [_loc5_];
            if(!this._maskCanvas)
            {
               this._maskCanvas = new Canvas();
               this._maskCanvas.clipContent = false;
               this._maskCanvas.height = param2;
               this._maskCanvas.width = param1;
               this._maskCanvas.toolTip = UtilDict.toDisplay("go",this.locked.hint);
               (_loc6_ = new Canvas()).styleName = "thumbBlurCanvas";
               _loc6_.width = param1;
               _loc6_.height = param2;
               (_loc7_ = new Image()).source = Class(FlexGlobals.topLevelApplication.styleManager.getStyleDeclaration(".thumbIconLocked").getStyle("upIcon"));
               _loc7_.styleName = "thumbIconLocked";
               this._maskCanvas.addChild(_loc6_);
               this._maskCanvas.addChild(_loc7_);
               addChild(this._maskCanvas);
            }
         }
         else
         {
            this._displayObj.filters = [];
         }
         if(this._maskCanvas)
         {
            this._maskCanvas.visible = this.locked != null;
         }
         if(this.showId)
         {
            if(!this._idDisplay)
            {
               this._idDisplay = new Canvas();
               this._idDisplay.styleName = "thumbnailIdBackdrop";
               this._idDisplay.width = param1;
               this._idDisplay.horizontalScrollPolicy = ScrollPolicy.OFF;
               this._idDisplay.x = this._idDisplay.y = 0;
               (_loc8_ = new Text()).text = this._thumb.id;
               _loc8_.toolTip = _loc8_.text;
               _loc8_.percentWidth = 100;
               _loc8_.styleName = "thumbnailId";
               this._idDisplay.addChild(_loc8_);
               addChild(this._idDisplay);
            }
         }
         var _loc3_:Canvas = this.getChildByName("snInfo") as Canvas;
         if(_loc3_)
         {
            this.updateSnInfoBg(_loc3_);
         }
      }
   }
}
