package com.miniclip.loggers
{
   public interface Loggable
   {
       
      
      function get name() : String;
      
      function error(param1:String) : void;
      
      function warn(param1:String) : void;
      
      function info(param1:String) : void;
      
      function debug(param1:String) : void;
      
      function log(param1:String) : void;
   }
}
