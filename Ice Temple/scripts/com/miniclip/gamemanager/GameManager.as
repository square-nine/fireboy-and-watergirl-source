package com.miniclip.gamemanager
{
   import com.miniclip.loggers.Logger;
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   
   public interface GameManager extends IEventDispatcher
   {
       
      
      function init(param1:DisplayObjectContainer) : void;
      
      function get services() : GameServices;
      
      function get avatars() : GameAvatars;
      
      function get lobby() : GameLobby;
      
      function get player() : GamePlayer;
      
      function get tracking() : GameTracking;
      
      function get credits() : GameCredits;
      
      function get logger() : Logger;
      
      function get chat() : GameChat;
      
      function get version() : String;
      
      function get info() : String;
      
      function get ready() : Boolean;
      
      function get midRoll() : GameMidroll;
      
      function get sponsorship() : IMiniclipSponsorship;
   }
}
