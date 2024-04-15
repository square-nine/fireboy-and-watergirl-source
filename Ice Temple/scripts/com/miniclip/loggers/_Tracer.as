package com.miniclip.loggers
{
   import flash.utils.getTimer;
   
   public class _Tracer implements Loggable
   {
       
      
      private var _name:String;
      
      public var useTimestamp:Boolean = false;
      
      public function _Tracer(param1:String)
      {
         super();
         _name = param1;
      }
      
      protected function trace(param1:String) : void
      {
         if(useTimestamp)
         {
            param1 = getTimer() + " @ " + param1;
         }
         trace(param1);
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function log(param1:String) : void
      {
         trace(param1);
      }
      
      public function info(param1:String) : void
      {
         trace("(" + param1 + ")");
      }
      
      public function debug(param1:String) : void
      {
         trace("[" + param1 + "]");
      }
      
      public function warn(param1:String) : void
      {
         trace("!! " + param1 + " !!");
      }
      
      public function error(param1:String) : void
      {
         trace("## " + param1 + " ##");
      }
   }
}
