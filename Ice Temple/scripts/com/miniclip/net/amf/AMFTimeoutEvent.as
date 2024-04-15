package com.miniclip.net.amf
{
   public class AMFTimeoutEvent extends AMFEvent
   {
       
      
      public function AMFTimeoutEvent()
      {
         super(TIMEOUT,null);
      }
      
      override public function toString() : String
      {
         return "[ AMFTimeoutEvent ]";
      }
   }
}
