package com.miniclip.loggers
{
   import com.miniclip.logger;
   import flash.external.ExternalInterface;
   
   public class _Firebug implements Loggable
   {
       
      
      private var _name:String;
      
      private var _lock:Boolean;
      
      public function _Firebug(param1:String)
      {
         var name:String = param1;
         super();
         _name = name;
         _lock = false;
         if(_isAvailable())
         {
            try
            {
               ExternalInterface.call("console.log","");
            }
            catch(e:SecurityError)
            {
               _lock = true;
               logger.removeByName(_name);
            }
         }
      }
      
      private function _isAvailable() : Boolean
      {
         return ExternalInterface.available;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function log(param1:String) : void
      {
         if(_isAvailable() && !_lock)
         {
            ExternalInterface.call("console.log",param1);
         }
      }
      
      public function info(param1:String) : void
      {
         if(_isAvailable() && !_lock)
         {
            ExternalInterface.call("console.info",param1);
         }
      }
      
      public function debug(param1:String) : void
      {
         if(_isAvailable() && !_lock)
         {
            ExternalInterface.call("console.debug",param1);
         }
      }
      
      public function warn(param1:String) : void
      {
         if(_isAvailable() && !_lock)
         {
            ExternalInterface.call("console.warn",param1);
         }
      }
      
      public function error(param1:String) : void
      {
         if(_isAvailable() && !_lock)
         {
            ExternalInterface.call("console.error",param1);
         }
      }
   }
}
