package com.miniclip.gamemanager
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.events.AlertboxEvent;
   import com.miniclip.events.AuthenticationEvent;
   import com.miniclip.events.AwardsEvent;
   import com.miniclip.events.GameLoaderEvent;
   import com.miniclip.events.HighscoreEvent;
   import com.miniclip.hack;
   import com.miniclip.logger;
   import com.miniclip.utils.Tea;
   import flash.events.EventDispatcher;
   
   use namespace hack;
   
   public class MiniclipServices extends EventDispatcher implements GameServices
   {
       
      
      private var _highscoresVisible:Boolean = false;
      
      private var _userDetails:Object = null;
      
      private var _key:String;
      
      private var _tea:Tea;
      
      private var _disableGameEvent:GameLoaderEvent;
      
      private var _enableGameEvent:GameLoaderEvent;
      
      public function MiniclipServices()
      {
         _disableGameEvent = new GameLoaderEvent(GameLoaderEvent.DISABLE_GAME);
         _enableGameEvent = new GameLoaderEvent(GameLoaderEvent.ENABLE_GAME);
         super();
         _key = "hello world";
         _tea = new Tea();
      }
      
      private function _displayHighscores(param1:* = NaN, param2:uint = 0) : void
      {
         _highscoresVisible = true;
      }
      
      private function onAwardResponse(param1:AwardsEvent) : void
      {
         logger.log("services.onAwardResponse( " + param1 + " )");
         dispatchEvent(param1.clone());
      }
      
      private function onCloseHighscore(param1:HighscoreEvent) : void
      {
         logger.log("services.onCloseHighscore( " + param1 + " )");
         dispatchEvent(param1.clone());
         _highscoresVisible = false;
      }
      
      private function onCloseAlertbox(param1:AlertboxEvent) : void
      {
         logger.log("services.onCloseAlertbox( " + param1 + " )");
         dispatchEvent(_enableGameEvent.clone());
         dispatchEvent(param1.clone());
      }
      
      private function onGetUserDetails(param1:AuthenticationEvent) : void
      {
         logger.log("services.onGetUserDetails( " + param1 + " )");
         _userDetails = param1.data;
         trace("before - DeveloperGameManager.onGetUserDetails()");
         dispatchEvent(param1.clone());
         trace(" after - DeveloperGameManager.onGetUserDetails()");
      }
      
      public function validateLocation() : Boolean
      {
         logger.info("services.validateLocation()");
         if(BlackBox.current.isLocal() || BlackBox.current.isAllowed())
         {
            return true;
         }
         return false;
      }
      
      public function showHighscores(param1:uint = 0) : void
      {
         logger.info("services.showHighscores( " + param1 + " )");
      }
      
      public function saveHighscore(param1:Number, param2:uint = 0) : void
      {
         logger.info("services.saveHighscore( " + param1 + ", " + param2 + " )");
      }
      
      public function giveAward(param1:uint) : void
      {
         logger.info("services.giveAward( " + param1 + " )");
         if(param1 > 0)
         {
            logger.log("Awards success (with awardID = " + param1 + ")");
            dispatchEvent(new AwardsEvent(AwardsEvent.SUCCESS));
         }
         else
         {
            logger.error("Awards fail (with awardID = " + param1 + ")");
            dispatchEvent(new AwardsEvent(AwardsEvent.FAIL));
         }
      }
      
      public function hasAward(param1:uint, param2:uint = 0) : void
      {
         logger.info("services.hasAward( " + param1 + ", " + param2 + " )");
         dispatchEvent(new AwardsEvent(AwardsEvent.STATUS,false));
      }
      
      public function trackAds(param1:String) : void
      {
         logger.info("services.trackAds( " + param1 + " )");
         if(param1 != "" && param1.length > 0)
         {
            logger.log("Ads Tracking success (with trackerID = " + param1 + ")");
         }
         else
         {
            logger.error("Ads Tracking fail (with trackerID = " + param1 + ")");
         }
      }
      
      public function getUserDetails(param1:Boolean = true) : void
      {
         logger.info("services.getUserDetails( " + param1 + " )");
      }
      
      public function isLoggedIn(param1:Boolean = true) : void
      {
         logger.info("services.isLoggedIn( " + param1 + " )");
      }
      
      public function showAlert(param1:String = "Alert!", param2:String = "OK") : void
      {
         logger.info("services.showAlert( " + param1 + ", " + param2 + " )");
         logger.log(param1);
      }
      
      public function encrypt(param1:String) : String
      {
         logger.info("services.encrypt( " + param1 + " )");
         return _tea.encrypt(param1,_key);
      }
      
      public function decrypt(param1:String) : String
      {
         logger.info("services.decrypt( " + param1 + " )");
         return _tea.decrypt(param1,_key);
      }
      
      public function get highscoresVisible() : Boolean
      {
         return _highscoresVisible;
      }
      
      public function get userDetails() : Object
      {
         return _userDetails;
      }
      
      public function get datacenterID() : String
      {
         return "";
      }
      
      hack function isWebmasterGame() : Boolean
      {
         return false;
      }
      
      public function trackData(param1:String, param2:String = "", param3:Object = null, param4:Boolean = false) : void
      {
         logger.info("services.trackData() Tag: " + param1 + " Group: " + param2 + " Object: " + (!!param3 ? "NOT " : "") + "NULL");
      }
      
      public function trackError(param1:String) : void
      {
         logger.info("services.trackError() ErrorCode: " + param1);
      }
      
      public function trackMappedError(param1:String) : void
      {
         logger.info("services.trackMappedError() ErrorCode: " + param1);
      }
   }
}
