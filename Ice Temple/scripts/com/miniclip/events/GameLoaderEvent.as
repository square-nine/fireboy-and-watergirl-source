package com.miniclip.events
{
   import flash.events.Event;
   
   public class GameLoaderEvent extends Event
   {
      
      public static const START_LOADING_GAME:String = "start_loading_game";
      
      public static const ENABLE_GAME:String = "gameloader_enable_game";
      
      public static const DISABLE_GAME:String = "gameloader_disable_game";
      
      public static const GAME_LOADED:String = "gameloader_game_loaded";
      
      public static const GAME_DISPLAY:String = "gameloader_game_display";
       
      
      public function GameLoaderEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new GameLoaderEvent(type,bubbles,cancelable);
      }
   }
}
