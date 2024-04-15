package com.miniclip.gamemanager
{
   import com.miniclip.gamemanager.lobby.MultiplayerClient;
   import flash.events.IEventDispatcher;
   
   public interface GameLobby extends IEventDispatcher
   {
       
      
      function connect(param1:String = null) : void;
      
      function disconnect() : void;
      
      function showLobby(param1:String = null) : void;
      
      function hideLobby() : void;
      
      function startGame(param1:MultiplayerClient, param2:Object) : void;
      
      function endGame(param1:Object) : void;
      
      function updateGame(param1:Object) : void;
      
      function updateStatistics(param1:Object) : void;
      
      function track(param1:String, param2:Object = null) : void;
      
      function sendChatMessage(param1:String) : void;
      
      function get client() : MultiplayerClient;
      
      function setFeatures(param1:int) : void;
      
      function getFeatures() : int;
      
      function joinQueue() : void;
      
      function leaveQueue() : void;
   }
}
