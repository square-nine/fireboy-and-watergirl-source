package com.miniclip.events
{
   import flash.events.Event;
   
   public class HighscoreEvent extends Event
   {
      
      public static const CLOSE:String = "highscore_close";
       
      
      public function HighscoreEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new HighscoreEvent(type,bubbles,cancelable);
      }
   }
}
