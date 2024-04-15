package com.miniclip.events
{
   import flash.events.Event;
   
   public class DataEvent extends Event
   {
      
      public static const READ:String = "read";
      
      public static const WRITE:String = "write";
      
      public static const DELETE:String = "delete";
       
      
      private var _name:String;
      
      public function DataEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _name = param2;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      override public function clone() : Event
      {
         return new DataEvent(type,name,bubbles,cancelable);
      }
   }
}
