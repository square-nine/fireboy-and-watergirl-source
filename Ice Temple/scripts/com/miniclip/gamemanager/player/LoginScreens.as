package com.miniclip.gamemanager.player
{
   import com.miniclip.hack;
   
   use namespace hack;
   
   public class LoginScreens
   {
      
      public static const login:LoginScreens = new LoginScreens(0,"login");
      
      public static const signup:LoginScreens = new LoginScreens(1,"signup");
      
      hack static const player:LoginScreens = new LoginScreens(2,"player");
      
      hack static const game:LoginScreens = new LoginScreens(3,"game");
      
      hack static const external:LoginScreens = new LoginScreens(4,"external");
      
      hack static const signupad:LoginScreens = new LoginScreens(5,"signupad");
       
      
      private var _value:uint;
      
      private var _name:String;
      
      public function LoginScreens(param1:uint, param2:String)
      {
         super();
         _value = param1;
         _name = param2;
      }
      
      public function toString() : String
      {
         return _name;
      }
      
      public function valueOf() : uint
      {
         return _value;
      }
   }
}
