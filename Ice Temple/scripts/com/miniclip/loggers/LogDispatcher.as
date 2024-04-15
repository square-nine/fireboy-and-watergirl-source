package com.miniclip.loggers
{
   public class LogDispatcher implements Logger
   {
       
      
      private var _name:String;
      
      private var _level:LoggingLevel;
      
      private var _listeners:Array;
      
      public function LogDispatcher(param1:String, param2:LoggingLevel = null)
      {
         super();
         if(param2 == null)
         {
            param2 = LoggingLevel.everything;
         }
         _name = param1;
         _level = param2;
         removeAll();
      }
      
      private function _addListener(param1:Loggable) : void
      {
         var _loc2_:int = _listeners.indexOf(param1);
         if(_loc2_ == -1)
         {
            _listeners.push(param1);
         }
      }
      
      private function _removeListener(param1:Loggable) : void
      {
         var _loc2_:int = _listeners.indexOf(param1);
         if(_loc2_ > -1)
         {
            _listeners.splice(_loc2_,1);
         }
      }
      
      private function _removeListenerByName(param1:String) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Loggable = null;
         _loc2_ = 0;
         while(_loc2_ < _listeners.length)
         {
            _loc3_ = _listeners[_loc2_];
            if(_loc3_.name == param1)
            {
               _listeners.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      private function _callEvery(param1:String, param2:String = "") : void
      {
         var _loc3_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < _listeners.length)
         {
            _listeners[_loc3_][param1](param2);
            _loc3_++;
         }
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
         _level = param1;
      }
      
      public function get length() : uint
      {
         return _listeners.length;
      }
      
      public function get list() : Array
      {
         return _listeners;
      }
      
      public function get listByName() : Array
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _listeners.length)
         {
            _loc1_.push(_listeners[_loc2_].name);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function log(param1:String) : void
      {
         if(level == LoggingLevel.everything)
         {
            _callEvery("log",param1);
         }
      }
      
      public function info(param1:String) : void
      {
         if(level >= LoggingLevel.infos)
         {
            _callEvery("info",param1);
         }
      }
      
      public function debug(param1:String) : void
      {
         if(level >= LoggingLevel.debugging)
         {
            _callEvery("debug",param1);
         }
      }
      
      public function warn(param1:String) : void
      {
         if(level >= LoggingLevel.warnings)
         {
            _callEvery("warn",param1);
         }
      }
      
      public function error(param1:String) : void
      {
         if(level >= LoggingLevel.errors)
         {
            _callEvery("error",param1);
         }
      }
      
      public function add(... rest) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < rest.length)
         {
            _loc3_ = rest[_loc2_];
            if(_loc3_ is Loggable)
            {
               _addListener(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function remove(... rest) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < rest.length)
         {
            _loc3_ = rest[_loc2_];
            if(_loc3_ is Loggable)
            {
               _removeListener(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function removeByName(... rest) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < rest.length)
         {
            _loc3_ = rest[_loc2_];
            if(_loc3_ is String)
            {
               _removeListenerByName(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function removeAll() : void
      {
         _listeners = [];
      }
   }
}
