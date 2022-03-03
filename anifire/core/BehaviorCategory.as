package anifire.core
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class BehaviorCategory
   {
      
      private static var _logger:ILogger = Log.getLogger("core.BehaviorCategory");
       
      
      private var _name:String;
      
      private var _behaviors:Array;
      
      public function BehaviorCategory(param1:String)
      {
         super();
         this._name = param1;
         this._behaviors = new Array();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get behaviors() : Array
      {
         return this._behaviors;
      }
      
      public function getBehaviorByIndex(param1:int) : Behavior
      {
         return Behavior(this._behaviors[param1]);
      }
      
      public function addBehavior(param1:Behavior) : void
      {
         this._behaviors.push(param1);
         this._behaviors.sortOn("name",Array.CASEINSENSITIVE);
      }
   }
}
