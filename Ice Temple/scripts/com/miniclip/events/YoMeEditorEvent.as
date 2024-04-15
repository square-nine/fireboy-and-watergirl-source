package com.miniclip.events
{
   import flash.events.Event;
   
   public class YoMeEditorEvent extends Event
   {
      
      public static const READY:String = "ready";
      
      public static const CHANGE:String = "change";
      
      public static const CLOSE:String = "close";
      
      public static const ERROR:String = "error";
       
      
      public function YoMeEditorEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new YoMeEditorEvent(type,bubbles,cancelable);
      }
   }
}
