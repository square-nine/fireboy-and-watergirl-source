package com.miniclip.gamemanager
{
   import flash.events.Event;
   
   public class GameSponsorship implements IMiniclipSponsorship
   {
       
      
      public function GameSponsorship()
      {
         super();
      }
      
      public function get completeData() : Object
      {
         return {
            "assets":null,
            "metadata":null
         };
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
   }
}
