package com.miniclip.events
{
   import flash.events.Event;
   
   public class ComponentEvent extends Event
   {
      
      public static const ON_SHOWING:String = "on_showing";
      
      public static const ON_INIT_COMPLETE:String = "init_complete";
       
      
      public function ComponentEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
