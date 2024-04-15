package com.miniclip.events
{
   import com.miniclip.gamemanager.lobby.MultiplayerClient;
   import flash.events.Event;
   
   public class LobbyDataEvent extends Event
   {
      
      public static const GAME_START:String = "lobby_GameStart";
      
      public static const GAME_END:String = "lobby_GameEnd";
       
      
      private var _client:MultiplayerClient;
      
      private var _game:Object;
      
      public function LobbyDataEvent(param1:String, param2:MultiplayerClient = null, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _client = param2;
         _game = param3;
      }
      
      public function get client() : MultiplayerClient
      {
         return _client;
      }
      
      public function get game() : Object
      {
         return _game;
      }
      
      override public function clone() : Event
      {
         return new LobbyDataEvent(type,client,game,bubbles,cancelable);
      }
   }
}
