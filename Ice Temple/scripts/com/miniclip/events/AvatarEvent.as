package com.miniclip.events
{
   import flash.events.Event;
   
   public class AvatarEvent extends Event
   {
      
      public static const READY:String = "ready";
      
      public static const ERROR:String = "error";
       
      
      private var _data:*;
      
      public function AvatarEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new AvatarEvent(type,data,bubbles,cancelable);
      }
   }
}
