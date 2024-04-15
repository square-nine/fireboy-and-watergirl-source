package com.miniclip.gamemanager
{
   import com.miniclip.gamemanager.lobby.MultiplayerClient;
   import com.miniclip.logger;
   import flash.display.Sprite;
   
   public class MiniclipLobby extends Sprite implements GameLobby
   {
       
      
      private var _client:MultiplayerClient;
      
      private var _features:int;
      
      public function MiniclipLobby()
      {
         super();
         logger.log("MiniclipLobby ctor");
      }
      
      public function connect(param1:String = null) : void
      {
         logger.log("MiniclipLobby.connect( " + param1 + " )");
      }
      
      public function disconnect() : void
      {
         logger.log("MiniclipLobby.disconnect()");
      }
      
      public function showLobby(param1:String = null) : void
      {
         logger.log("MiniclipLobby.showLobby( " + param1 + " )");
      }
      
      public function hideLobby() : void
      {
         logger.log("MiniclipLobby.hideLobby()");
      }
      
      public function startGame(param1:MultiplayerClient, param2:Object) : void
      {
         _client = param1;
         logger.log("MiniclipLobby.startGame( " + param1 + ", " + param2 + " )");
      }
      
      public function endGame(param1:Object) : void
      {
         logger.log("MiniclipLobby.endGame( " + param1 + " )");
      }
      
      public function updateGame(param1:Object) : void
      {
         logger.log("MiniclipLobby.updateGame( " + param1 + " )");
      }
      
      public function updateStatistics(param1:Object) : void
      {
         logger.log("MiniclipLobby.updateStatistics( " + param1 + " )");
      }
      
      public function playerLeft(param1:Object) : void
      {
         logger.log("MiniclipLobby.playerLeft( " + param1 + " )");
      }
      
      public function track(param1:String, param2:Object = null) : void
      {
         logger.log("MiniclipLobby.track( " + param1 + ", " + param2 + ")");
      }
      
      public function sendChatMessage(param1:String) : void
      {
         logger.log("MiniclipLobby.sendChatMessage(" + param1 + ")");
      }
      
      public function get client() : MultiplayerClient
      {
         logger.log("MiniclipLobby.client = " + _client + " )");
         return _client;
      }
      
      public function setFeatures(param1:int) : void
      {
         logger.log("MiniclipLobby.setFeatures( " + param1 + ")");
         _features = param1;
      }
      
      public function getFeatures() : int
      {
         logger.log("MiniclipLobby.getFeatures()");
         return _features;
      }
      
      public function joinQueue() : void
      {
         logger.log("MiniclipLobby.joinQueue()");
      }
      
      public function leaveQueue() : void
      {
         logger.log("MiniclipLobby.leaveQueue()");
      }
   }
}
