package com.miniclip.events
{
   import flash.events.Event;
   
   public class LobbyEvent extends Event
   {
      
      public static const LOADED:String = "lobby_Loaded";
      
      public static const COMPLETE:String = "lobby_Complete";
      
      public static const CONNECTED:String = "lobby_connected";
      
      public static const DISCONNECTED:String = "lobby_disconnected";
      
      public static const SHOW:String = "lobby_Show";
      
      public static const PLAYER_JOINED_QUEUE:String = "lobby_playerJoinedQueue";
      
      public static const PLAYER_LEFT_QUEUE:String = "lobby_playerLeftQueue";
      
      public static const GAME_START:String = "lobby_GameStart";
      
      public static const GAME_END:String = "lobby_GameEnd";
      
      public static const PLAYER_LEFT:String = "lobby_PlayerLeft";
      
      public static const PLAYER_JOINED:String = "lobby_PlayerJoined";
      
      public static const PLAYER_RATING_UPDATED:String = "lobby_PlayerRatingUpdated";
      
      public static const PLAYER_STATISTICS_UPDATED:String = "lobby_PlayerStatisticsUpdated";
      
      public static const CHAT_MESSAGE_RECEIVED:String = "lobby_ChatMessageReceived";
      
      public static const ZONE_JOINED:String = "lobby_zoneJoined";
       
      
      private var _data:*;
      
      public function LobbyEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new LobbyEvent(type,data,bubbles,cancelable);
      }
   }
}
