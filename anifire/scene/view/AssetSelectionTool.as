package anifire.scene.view
{
   import anifire.core.Console;
   import anifire.interfaces.IAssetCollection;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IIterator;
   import anifire.util.UtilMath;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mx.core.UIComponent;
   
   public class AssetSelectionTool extends UIComponent
   {
      
      private static const BORDER_COLOR:uint = 0;
      
      public static const BORDER_WIDTH:Number = 2;
      
      private static const BORDER_ALPHA:Number = 0.5;
       
      
      private var _editor:SceneEditor;
      
      private var _box:Sprite;
      
      private var _mousePos:Point;
      
      private var _borderWidth:Number = 2;
      
      public function AssetSelectionTool()
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._mousePos = new Point();
         this._box = new UIComponent();
         addChild(this._box);
      }
      
      public function set borderWidth(param1:Number) : void
      {
         if(param1 > 0)
         {
            this._borderWidth = param1;
         }
      }
      
      public function set canvas(param1:SceneEditor) : void
      {
         this._editor = param1;
      }
      
      public function activate() : void
      {
         if(this._editor)
         {
            this._editor.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }
      
      public function deactivate() : void
      {
         if(this._editor)
         {
            this._editor.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(Console.getConsole().isTutorialOn)
         {
            return;
         }
         this._mousePos = new Point(this._editor.mouseX,this._editor.mouseY);
         this._editor.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._editor.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(this._editor.mouseX,this._editor.mouseY);
         _loc2_.x = UtilMath.boundaryCheck(_loc2_.x,0,this._editor.width);
         _loc2_.y = UtilMath.boundaryCheck(_loc2_.y,0,this._editor.height);
         var _loc3_:Number = Math.min(_loc2_.x,this._mousePos.x);
         var _loc4_:Number = Math.min(_loc2_.y,this._mousePos.y);
         var _loc5_:Number = Math.abs(_loc2_.x - this._mousePos.x);
         var _loc6_:Number = Math.abs(_loc2_.y - this._mousePos.y);
         this._box.graphics.clear();
         this._box.graphics.lineStyle(this._borderWidth,BORDER_COLOR,BORDER_ALPHA);
         this._box.graphics.drawRect(_loc3_,_loc4_,_loc5_,_loc6_);
         this._box.graphics.endFill();
         param1.updateAfterEvent();
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         var _loc3_:IIterator = null;
         var _loc4_:Array = null;
         var _loc5_:IAssetCollection = null;
         this._editor.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._editor.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         var _loc2_:Point = new Point(this._editor.mouseX,this._editor.mouseY);
         if(Math.abs((this._mousePos.x - _loc2_.x) * (this._mousePos.y - _loc2_.y)) > 1000)
         {
            if(!param1.shiftKey)
            {
               this._editor.sceneModel.selection.clearCollection();
            }
            _loc3_ = this._editor.view.view.iterator("asset");
            _loc4_ = new Array();
            while(_loc3_.hasNext)
            {
               if((_loc5_ = _loc3_.next as IAssetCollection) && this.isCollided(this._box,_loc5_ as DisplayObject))
               {
                  _loc4_.push(IAssetView(_loc5_).asset);
               }
            }
            this._editor.sceneModel.selection.addAssets(_loc4_);
            this._editor.controller.showControl();
         }
         this._box.graphics.clear();
      }
      
      private function isCollided(param1:DisplayObject, param2:DisplayObject) : Boolean
      {
         if(param1 && param2)
         {
            return param1.hitTestObject(param2);
         }
         return false;
      }
   }
}
