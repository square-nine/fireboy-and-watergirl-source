package com.miniclip.events
{
   import flash.events.Event;
   
   public class BlackBoxEvent extends Event
   {
      
      public static const READY:String = "blackbox_ready";
      
      public static const LOCAL_INFO:String = "blackbox_local_info";
       
      
      public function BlackBoxEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new BlackBoxEvent(type,bubbles,cancelable);
      }
   }
}
