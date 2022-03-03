package anifire.core
{
   import anifire.bubble.BubbleMgr;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.CoreEvent;
   import anifire.interfaces.IBubbleProduct;
   import anifire.interfaces.ITheme;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   import mx.core.DragSource;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   
   public class BubbleThumb extends Thumb implements IBubbleProduct
   {
      
      private static var _logger:ILogger = Log.getLogger("core.BubbleThumb");
      
      public static const XML_NODE_NAME:String = "bubble";
       
      
      private var _type:String;
      
      private var _isShowMsg:Boolean;
      
      private var _colorStyle:int = 1;
      
      private var _thumbnailImageData:ByteArray;
      
      public function BubbleThumb()
      {
         super();
      }
      
      public function get colorStyle() : int
      {
         return this._colorStyle;
      }
      
      public function set colorStyle(param1:int) : void
      {
         this._colorStyle = param1;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get isShowMsg() : Boolean
      {
         return this._isShowMsg;
      }
      
      public function set isShowMsg(param1:Boolean) : void
      {
         this._isShowMsg = param1;
      }
      
      override public function loadImageData() : void
      {
         var _loc1_:URLRequest = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.getFileName(),ServerConstants.PARAM_BUBBLE);
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
         _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc2_.load(_loc1_);
      }
      
      override public function loadImageDataComplete(param1:Event) : void
      {
         var _loc4_:UtilCrypto = null;
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:ByteArray = _loc2_.data;
         this.thumbImageData = _loc3_;
         if(this.theme.id != "ugc")
         {
            (_loc4_ = new UtilCrypto()).decrypt(ByteArray(this.thumbImageData));
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      override public function deSerialize(param1:XML, param2:ITheme, param3:Boolean = false) : void
      {
         this.imageData = param1.copy();
         this.id = param1.@id;
         this.aid = param1.@aid;
         this.premium = param1.@is_premium == "Y" ? true : false;
         this.theme = param2;
         this.type = param1.@type;
         this.enable = param1.@enable == "N" ? false : true;
         this.isShowMsg = param1.@isShowMsg == "Y" ? true : false;
         this.colorStyle = param1.@colorStyle.length() > 0 ? int(param1.@colorStyle) : 1;
         this.setFileName(param1.@thumb);
      }
      
      private function doPositionProxyImage(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doPositionProxyImage);
         var _loc2_:Loader = param1.target.loader as Loader;
         var _loc3_:Rectangle = new Rectangle(0,0,AnimeConstants.TILE_BUBBLE_WIDTH,AnimeConstants.TILE_BUBBLE_HEIGHT);
         UtilPlain.centerAlignObj(_loc2_,_loc3_,true);
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = Image(param1.currentTarget);
         var _loc3_:DragSource = new DragSource();
         _loc3_.addData(this,"thumb");
         var _loc4_:Image = new Image();
         var _loc5_:BitmapData;
         (_loc5_ = new BitmapData(AnimeConstants.TILE_BUBBLE_WIDTH,AnimeConstants.TILE_BUBBLE_HEIGHT)).draw(DisplayObject(_loc2_));
         var _loc6_:Bitmap = new Bitmap(_loc5_);
         _loc4_.addChild(_loc6_);
         DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
         Console.getConsole().currDragSource = _loc3_;
      }
      
      override public function get shouldBeCopyToNextScene() : Boolean
      {
         return this.type == BubbleMgr.BLANK;
      }
   }
}
