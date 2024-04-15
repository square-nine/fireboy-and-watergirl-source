package com.miniclip.events
{
   import flash.events.Event;
   
   public class AlertboxEvent extends Event
   {
      
      public static const CLOSE:String = "alertbox_close";
      
      public static const YES:String = "alertbox_yes";
      
      public static const NO:String = "alertbox_no";
       
      
      private var _data:*;
      
      public function AlertboxEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
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
         return new AlertboxEvent(type,data,bubbles,cancelable);
      }
   }
}
