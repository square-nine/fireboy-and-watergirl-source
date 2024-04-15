package com.miniclip.gamemanager
{
   import com.miniclip.logger;
   import flash.events.EventDispatcher;
   
   public class MiniclipStorage extends EventDispatcher implements GameStorage
   {
       
      
      private var _data:Object;
      
      private var _notifications:Boolean;
      
      public function MiniclipStorage()
      {
         super();
         _data = {};
         _notifications = false;
      }
      
      public function get notifications() : Boolean
      {
         return _notifications;
      }
      
      public function set notifications(param1:Boolean) : void
      {
         _notifications = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get limit() : uint
      {
         return 1024;
      }
      
      public function load() : void
      {
         logger.log("storage.load()");
      }
      
      public function save() : void
      {
         logger.log("storage.save()");
      }
   }
}
