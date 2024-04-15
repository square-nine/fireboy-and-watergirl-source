package com.miniclip.loggers
{
   public class EmptyLogger implements Logger
   {
       
      
      private var _name:String;
      
      private var _level:LoggingLevel;
      
      private var _empty:Array;
      
      public function EmptyLogger(param1:String = "EmptyLogger")
      {
         super();
         _name = param1;
         _level = LoggingLevel.nothing;
         _empty = [];
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get level() : LoggingLevel
      {
         return _level;
      }
      
      public function set level(param1:LoggingLevel) : void
      {
      }
      
      public function get length() : uint
      {
         return 0;
      }
      
      public function get list() : Array
      {
         return _empty;
      }
      
      public function get listByName() : Array
      {
         return _empty;
      }
      
      public function log(param1:String) : void
      {
      }
      
      public function info(param1:String) : void
      {
      }
      
      public function debug(param1:String) : void
      {
      }
      
      public function warn(param1:String) : void
      {
      }
      
      public function error(param1:String) : void
      {
      }
      
      public function add(... rest) : void
      {
      }
      
      public function remove(... rest) : void
      {
      }
      
      public function removeByName(... rest) : void
      {
      }
      
      public function removeAll() : void
      {
      }
   }
}
