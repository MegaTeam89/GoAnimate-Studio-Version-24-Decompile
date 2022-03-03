package anifire.command
{
   import anifire.util.Util;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mx.core.FlexGlobals;
   
   public class CommandStack extends EventDispatcher
   {
      
      private static var _instance:CommandStack;
       
      
      private const MAX_STACK_SIZE:Number = 20;
      
      private var _commands:Array;
      
      private var _index:uint;
      
      public function CommandStack(param1:SingletonEnforcer)
      {
         super();
         this.reset();
      }
      
      public static function getInstance() : CommandStack
      {
         if(_instance == null)
         {
            _instance = new CommandStack(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function putCommand(param1:ICommand) : void
      {
         var _loc2_:* = this._index++;
         this._commands[_loc2_] = param1;
         this._commands.splice(this._index);
         if(this._commands.length > this.MAX_STACK_SIZE)
         {
            this._commands.splice(0,1);
            --this._index;
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function undo() : Boolean
      {
         var _loc1_:ICommand = null;
         try
         {
            if(this._index > 0)
            {
               _loc1_ = this._commands[--this._index];
               _loc1_.undo();
               dispatchEvent(new Event(Event.CHANGE));
               Util.gaTracking("/gostudio/undo/" + _loc1_.toString(),FlexGlobals.topLevelApplication as DisplayObject);
               return true;
            }
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function redo() : Boolean
      {
         var _loc1_:ICommand = null;
         try
         {
            if(this._index < this._commands.length)
            {
               _loc1_ = this._commands[this._index++];
               _loc1_.redo();
               dispatchEvent(new Event(Event.CHANGE));
               Util.gaTracking("/gostudio/redo/" + _loc1_.toString(),FlexGlobals.topLevelApplication as DisplayObject);
               return true;
            }
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function reset() : void
      {
         this._commands = new Array();
         this._index = 0;
      }
      
      public function get stack() : Array
      {
         return this._commands.concat();
      }
      
      public function get index() : Number
      {
         return this._index;
      }
      
      public function get size() : Number
      {
         return this._commands.length;
      }
   }
}

class SingletonEnforcer
{
    
   
   function SingletonEnforcer()
   {
      super();
   }
}
