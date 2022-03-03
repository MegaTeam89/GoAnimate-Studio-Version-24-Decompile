package anifire.core
{
   import anifire.constant.ServerConstants;
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   
   public class GroupController
   {
       
      
      private var _groups:Array;
      
      private var _currentGroup:Group;
      
      private var _tempCurrentGroup:Group;
      
      private var _schoolId:String = "-1";
      
      private var _categoryList:XMLList = null;
      
      private var _category:String;
      
      public function GroupController()
      {
         this._currentGroup = new Group();
         super();
         this._groups = new Array();
      }
      
      public function get currentGroup() : Group
      {
         return this._currentGroup;
      }
      
      public function set currentGroup(param1:Group) : void
      {
         this._currentGroup = param1;
      }
      
      public function get tempCurrentGroup() : Group
      {
         return this._tempCurrentGroup;
      }
      
      public function set tempCurrentGroup(param1:Group) : void
      {
         this._tempCurrentGroup = param1;
      }
      
      private function get groups() : Array
      {
         return this._groups;
      }
      
      public function set schoolId(param1:String) : void
      {
         this._schoolId = param1;
      }
      
      public function get schoolId() : String
      {
         return this._schoolId;
      }
      
      public function getGroups() : Array
      {
         return this.groups.concat();
      }
      
      public function addGroup(param1:Group) : void
      {
         this.groups.push(param1);
      }
      
      public function removeGroup(param1:Group) : void
      {
      }
      
      public function get isSchoolProject() : Boolean
      {
         if(this.schoolId != "-1")
         {
            return true;
         }
         return false;
      }
      
      public function get isTeacher() : Boolean
      {
         var _loc1_:UtilHashArray = Util.getFlashVar();
         var _loc2_:String = _loc1_.getValueByKey(ServerConstants.PARAM_ROLE);
         return !!_loc2_ ? _loc2_ == "teacher" : false;
      }
      
      public function get category() : String
      {
         var _loc1_:UtilHashArray = null;
         if(this._category == null)
         {
            _loc1_ = Util.getFlashVar();
            this._category = _loc1_.getValueByKey(ServerConstants.PARAM_CATEGORY);
         }
         return this._category;
      }
      
      public function set category(param1:String) : void
      {
         this._category = param1;
      }
      
      public function set categoryList(param1:XMLList) : void
      {
         this._categoryList = param1;
      }
      
      public function get categoryList() : XMLList
      {
         return !!this._categoryList ? this._categoryList.copy() : null;
      }
   }
}
