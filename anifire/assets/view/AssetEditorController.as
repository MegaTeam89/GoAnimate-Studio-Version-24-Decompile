package anifire.assets.view
{
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.Prop;
   import anifire.core.PropThumb;
   import anifire.interfaces.IThumb;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import mx.events.DragEvent;
   import mx.managers.DragManager;
   
   public class AssetEditorController extends EventDispatcher
   {
       
      
      private var _assetEditor:AssetEditor;
      
      private var _glowFilter:GlowFilter;
      
      private var _freezeFilter:GlowFilter;
      
      public function AssetEditorController(param1:AssetEditor, param2:IEventDispatcher = null)
      {
         this._glowFilter = new GlowFilter(16742400,1,6,6,5);
         this._freezeFilter = new GlowFilter(3373311,1,6,6,5);
         super(param2);
         this._assetEditor = param1;
         this._assetEditor.addEventListener(MouseEvent.ROLL_OVER,this.onEditorRollOver);
         this._assetEditor.addEventListener(MouseEvent.ROLL_OUT,this.onEditorRollOut);
         this._assetEditor.addEventListener(MouseEvent.MOUSE_DOWN,this.onEditorMouseDown);
         this._assetEditor.addEventListener(MouseEvent.MOUSE_UP,this.onEditorMouseUp);
         this._assetEditor.addEventListener(DragEvent.DRAG_ENTER,this.onEditorDragEnter);
         this._assetEditor.addEventListener(DragEvent.DRAG_DROP,this.onEditorDragDrop);
         this._assetEditor.addEventListener(DragEvent.DRAG_EXIT,this.onEditorDragExit);
      }
      
      public function destroy() : void
      {
         this._assetEditor.removeEventListener(MouseEvent.ROLL_OVER,this.onEditorRollOver);
         this._assetEditor.removeEventListener(MouseEvent.ROLL_OUT,this.onEditorRollOut);
         this._assetEditor.removeEventListener(MouseEvent.MOUSE_DOWN,this.onEditorMouseDown);
         this._assetEditor.removeEventListener(MouseEvent.MOUSE_UP,this.onEditorMouseUp);
         this._assetEditor.removeEventListener(DragEvent.DRAG_ENTER,this.onEditorDragEnter);
         this._assetEditor.removeEventListener(DragEvent.DRAG_DROP,this.onEditorDragDrop);
         this._assetEditor.removeEventListener(DragEvent.DRAG_EXIT,this.onEditorDragExit);
         if(this._assetEditor.stage)
         {
            this._assetEditor.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         }
         this._assetEditor = null;
      }
      
      private function onEditorRollOver(param1:MouseEvent) : void
      {
         var _loc2_:IThumb = null;
         if(param1.buttonDown == false)
         {
            this._assetEditor.filters = [this._glowFilter];
         }
         if(this._assetEditor.asset is Character)
         {
            if(Console.getConsole().currDragObject is Prop)
            {
               _loc2_ = Prop(Console.getConsole().currDragObject).thumb;
               if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable == true || PropThumb(_loc2_).headable == true || PropThumb(_loc2_).wearable == true))
               {
                  this._assetEditor.filters = [this._glowFilter];
               }
            }
         }
      }
      
      private function onEditorRollOut(param1:MouseEvent) : void
      {
         if(param1.buttonDown == false)
         {
            this._assetEditor.filters = [];
         }
         if(this._assetEditor.asset is Character)
         {
            if(Console.getConsole().currDragObject is Prop)
            {
               this._assetEditor.filters = [];
            }
         }
      }
      
      private function onEditorMouseUp(param1:MouseEvent) : void
      {
         if(this._assetEditor.asset is Character)
         {
            Character(this._assetEditor.asset).doMouseUp(param1);
         }
      }
      
      private function onEditorMouseDown(param1:MouseEvent) : void
      {
         this._assetEditor.filters = [];
         if(this._assetEditor.asset is Prop)
         {
            this._assetEditor.mouseEnabled = false;
            Console.getConsole().currDragObject = this._assetEditor.asset as Prop;
            this._assetEditor.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         }
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         this._assetEditor.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
         this._assetEditor.mouseEnabled = true;
         Console.getConsole().currDragObject = null;
      }
      
      private function onEditorDragEnter(param1:DragEvent) : void
      {
         var _loc2_:Object = null;
         if(this._assetEditor.asset is Character)
         {
            _loc2_ = param1.dragSource.dataForFormat("thumb");
            if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable == true || PropThumb(_loc2_).headable == true || PropThumb(_loc2_).wearable == true))
            {
               DragManager.acceptDragDrop(this._assetEditor);
               this._assetEditor.filters = [this._glowFilter];
            }
         }
      }
      
      private function onEditorDragDrop(param1:DragEvent) : void
      {
         if(this._assetEditor.asset is Character)
         {
            Character(this._assetEditor.asset).addPropOnDragDrop(param1);
            this._assetEditor.filters = [];
         }
      }
      
      private function onEditorDragExit(param1:DragEvent) : void
      {
         this._assetEditor.filters = [];
      }
   }
}
