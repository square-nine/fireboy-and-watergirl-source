package com.miniclip.gamemanager
{
   import com.miniclip.gamemanager.player.LoginScreens;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public interface GamePlayer extends IEventDispatcher
   {
       
      
      function get storage() : GameStorage;
      
      function isAlreadyLoggedIn() : Boolean;
      
      function logout() : void;
      
      function login(param1:Boolean = false, param2:Boolean = true, param3:Boolean = true, param4:LoginScreens = null, param5:Point = null) : LoginBoxScreen;
      
      function editYoMe(param1:Boolean = true, param2:Boolean = false, param3:Point = null) : YoMeEditorScreen;
   }
}
