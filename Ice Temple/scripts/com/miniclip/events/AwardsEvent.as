package com.miniclip.events
{
   import flash.events.Event;
   
   public class AwardsEvent extends Event
   {
      
      public static const SUCCESS:String = "awards_success";
      
      public static const STATUS:String = "awards_status";
      
      public static const FAIL:String = "awards_fail";
      
      public static const ERROR:String = "awards_error";
       
      
      private var _data:*;
      
      public function AwardsEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
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
         return new AwardsEvent(type,data,bubbles,cancelable);
      }
   }
}
