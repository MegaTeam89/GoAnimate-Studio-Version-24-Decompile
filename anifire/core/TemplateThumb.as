package anifire.core
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.interfaces.ITheme;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import mx.controls.Image;
   import mx.core.DragSource;
   import mx.managers.DragManager;
   
   public class TemplateThumb extends Thumb
   {
      
      public static const XML_NODE_NAME:String = "movie";
      
      public static const DRAG_DATA_FORMAT:String = "TemplateThumb";
       
      
      private var _numScene:int = 0;
      
      private var _templateXml:XML;
      
      public function TemplateThumb()
      {
         super();
      }
      
      public function get numScene() : int
      {
         return this._numScene;
      }
      
      public function set numScene(param1:int) : void
      {
         this._numScene = param1;
      }
      
      override public function deSerialize(param1:XML, param2:ITheme, param3:Boolean = false) : void
      {
         this.id = param1.@id;
         this.aid = param1.@id;
         this.numScene = param1.@numScene;
         this.name = param1.@title;
         this.theme = param2;
         if(this.theme.id == "ugc")
         {
            this.setFileName(param1.@path);
         }
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = Image(param1.currentTarget);
         var _loc3_:DragSource = new DragSource();
         _loc3_.addData(this,TemplateThumb.DRAG_DATA_FORMAT);
         _loc3_.addData(this,"thumb");
         var _loc4_:Image = new Image();
         var _loc5_:BitmapData;
         (_loc5_ = new BitmapData(AnimeConstants.TILE_BACKGROUND_WIDTH,AnimeConstants.TILE_BACKGROUND_HEIGHT)).draw(ThumbnailCanvas(_loc2_.parent).displayObj);
         var _loc6_:Bitmap = new Bitmap(_loc5_);
         _loc4_.addChild(_loc6_);
         DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
         Console.getConsole().currDragSource = _loc3_;
      }
      
      public function get templateXml() : XML
      {
         return this._templateXml;
      }
      
      public function set templateXml(param1:XML) : void
      {
         this._templateXml = param1;
      }
   }
}
