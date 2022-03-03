package anifire.managers
{
   import mx.core.DragSource;
   import mx.core.IFlexDisplayObject;
   
   public class StudioDragManager
   {
      
      public static const DRAG_IMAGE:String = "dragImage";
      
      private static var _dragSource:DragSource;
       
      
      public function StudioDragManager()
      {
         super();
      }
      
      public static function get dragSource() : DragSource
      {
         return _dragSource;
      }
      
      public static function set dragSource(param1:DragSource) : void
      {
         _dragSource = param1;
      }
      
      public static function getDragImage(param1:DragSource) : IFlexDisplayObject
      {
         if(param1.hasFormat(StudioDragManager.DRAG_IMAGE))
         {
            return param1.dataForFormat(StudioDragManager.DRAG_IMAGE) as IFlexDisplayObject;
         }
         return null;
      }
   }
}
