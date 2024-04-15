package com.spilgames.localization.events
{
   import flash.events.Event;
   
   public class SelectionEvent extends Event
   {
      
      public static const SELECT:String = "select";
      
      public static const DESELECT:String = "deselect";
       
      
      public function SelectionEvent(param1:String, param2:Boolean = true, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
   }
}
