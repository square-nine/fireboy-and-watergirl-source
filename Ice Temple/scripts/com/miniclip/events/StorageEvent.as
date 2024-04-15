package com.miniclip.events
{
   import flash.events.Event;
   
   public class StorageEvent extends Event
   {
      
      public static const LOADED:String = "loaded";
      
      public static const SAVED:String = "saved";
       
      
      public function StorageEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new StorageEvent(type,bubbles,cancelable);
      }
   }
}
