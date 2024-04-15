package com.miniclip.events
{
   import flash.events.Event;
   
   public class StorageErrorEvent extends Event
   {
      
      public static const DATABASE:String = "database";
      
      public static const LOGIN:String = "login";
      
      public static const VALIDATION:String = "validation";
      
      public static const SERVICES:String = "services";
      
      public static const TIMEOUT:String = "timeout";
      
      public static const ERROR:String = "error";
       
      
      private var _message:String;
      
      public function StorageErrorEvent(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _message = param2;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      override public function clone() : Event
      {
         return new StorageErrorEvent(type,message,bubbles,cancelable);
      }
   }
}
