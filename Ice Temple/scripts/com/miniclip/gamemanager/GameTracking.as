package com.miniclip.gamemanager
{
   public interface GameTracking
   {
       
      
      function get uniqueID() : uint;
      
      function get sessionID() : String;
      
      function get gameID() : uint;
      
      function get userID() : uint;
      
      function get time() : int;
      
      function get timeStamp() : Number;
      
      function get locale() : String;
   }
}
