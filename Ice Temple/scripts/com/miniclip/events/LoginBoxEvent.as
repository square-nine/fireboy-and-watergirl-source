package com.miniclip.events
{
   import flash.events.Event;
   
   public class LoginBoxEvent extends Event
   {
      
      public static const READY:String = "ready";
      
      public static const ERROR:String = "error";
       
      
      public function LoginBoxEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new LoginBoxEvent(type,bubbles,cancelable);
      }
   }
}
