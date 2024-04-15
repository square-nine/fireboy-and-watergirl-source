package com.miniclip.gamemanager
{
   import flash.events.IEventDispatcher;
   
   public interface GameServices extends IEventDispatcher
   {
       
      
      function validateLocation() : Boolean;
      
      function showHighscores(param1:uint = 0) : void;
      
      function saveHighscore(param1:Number, param2:uint = 0) : void;
      
      function giveAward(param1:uint) : void;
      
      function hasAward(param1:uint, param2:uint = 0) : void;
      
      function trackAds(param1:String) : void;
      
      function getUserDetails(param1:Boolean = true) : void;
      
      function isLoggedIn(param1:Boolean = true) : void;
      
      function showAlert(param1:String = "Alert!", param2:String = "OK") : void;
      
      function encrypt(param1:String) : String;
      
      function decrypt(param1:String) : String;
      
      function get highscoresVisible() : Boolean;
      
      function get userDetails() : Object;
      
      function get datacenterID() : String;
      
      function trackData(param1:String, param2:String = "", param3:Object = null, param4:Boolean = false) : void;
      
      function trackError(param1:String) : void;
      
      function trackMappedError(param1:String) : void;
   }
}
