package com.miniclip.loggers
{
   public interface Logger extends Loggable
   {
       
      
      function get level() : LoggingLevel;
      
      function set level(param1:LoggingLevel) : void;
      
      function get length() : uint;
      
      function get list() : Array;
      
      function get listByName() : Array;
      
      function add(... rest) : void;
      
      function remove(... rest) : void;
      
      function removeByName(... rest) : void;
      
      function removeAll() : void;
   }
}
