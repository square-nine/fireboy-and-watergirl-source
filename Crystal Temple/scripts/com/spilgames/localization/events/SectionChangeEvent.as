package com.spilgames.localization.events
{
   import flash.events.Event;
   
   public class SectionChangeEvent extends Event
   {
      
      public static const CHANGE:String = "change";
       
      
      public function SectionChangeEvent(param1:String, param2:Boolean = true, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
   }
}
