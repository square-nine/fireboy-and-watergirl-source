package com.miniclip.gamemanager
{
   import com.miniclip.gamemanager.player.LoginScreens;
   import com.miniclip.logger;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class MiniclipPlayer extends EventDispatcher implements GamePlayer
   {
       
      
      private var _storage:GameStorage;
      
      public function MiniclipPlayer(param1:GameStorage)
      {
         super();
         _storage = param1;
      }
      
      public function get storage() : GameStorage
      {
         return _storage;
      }
      
      public function isAlreadyLoggedIn() : Boolean
      {
         logger.info("player.isAlreadyLoggedIn()");
         return false;
      }
      
      public function logout() : void
      {
         logger.info("player.logout()");
      }
      
      public function login(param1:Boolean = false, param2:Boolean = true, param3:Boolean = true, param4:LoginScreens = null, param5:Point = null) : LoginBoxScreen
      {
         logger.info("player.login()");
         return null;
      }
      
      public function editYoMe(param1:Boolean = true, param2:Boolean = false, param3:Point = null) : YoMeEditorScreen
      {
         logger.info("player.editYoMe()");
         return null;
      }
   }
}
