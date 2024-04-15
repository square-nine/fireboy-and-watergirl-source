package com.miniclip.gamemanager
{
   import flash.events.IEventDispatcher;
   
   public interface GameStorage extends IEventDispatcher
   {
       
      
      function get notifications() : Boolean;
      
      function set notifications(param1:Boolean) : void;
      
      function get data() : Object;
      
      function get limit() : uint;
      
      function load() : void;
      
      function save() : void;
   }
}
