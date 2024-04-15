package com.miniclip.events
{
   import flash.events.Event;
   
   public class GameChatEvent extends Event
   {
      
      public static const LOADED:String = "chat_loaded";
      
      public static const LOAD_ERROR:String = "chat_loaderror";
      
      public static const LOAD_PROGRESS:String = "chat_loadprogress";
      
      public static const SUBMITTED:String = "chat_submitted";
      
      public static const SUBMIT_ERROR:String = "chat_submiterror";
       
      
      public function GameChatEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new GameChatEvent(type,bubbles,cancelable);
      }
   }
}
