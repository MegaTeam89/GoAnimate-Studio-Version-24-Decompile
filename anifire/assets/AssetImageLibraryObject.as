package anifire.assets
{
   import flash.display.DisplayObject;
   
   public class AssetImageLibraryObject
   {
      
      public static const STATUS_AVAILABLE:String = "STATUS_AVAILABLE";
      
      public static const STATUS_CHECKED_OUT:String = "STATUS_CHECKED_OUT";
      
      public static const STATUS_ON_HOLD:String = "STATUS_ON_HOLD";
       
      
      private var _image:DisplayObject;
      
      private var _borrowerId:String;
      
      private var _status:String = "STATUS_AVAILABLE";
      
      private var _imageId:Number;
      
      public function AssetImageLibraryObject(param1:DisplayObject, param2:Number)
      {
         super();
         this._image = param1;
         this._imageId = param2;
      }
      
      public function get imageId() : Number
      {
         return this._imageId;
      }
      
      public function set borrowerId(param1:String) : void
      {
         this._borrowerId = param1;
      }
      
      public function get borrowerId() : String
      {
         return this._borrowerId;
      }
      
      public function set status(param1:String) : void
      {
         this._status = param1;
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function get image() : DisplayObject
      {
         return this._image;
      }
   }
}
