package com.miniclip.events
{
   import flash.events.Event;
   
   public class AuthenticationEvent extends Event
   {
      
      public static const USER_DETAILS:String = "auth_user_details";
      
      public static const LOGIN:String = "auth_login";
      
      public static const LOGIN_CANCELLED:String = "auth_cancelled";
      
      public static const LOGIN_FAILED_USERNAME:String = "auth_login_failed_username";
      
      public static const LOGIN_FAILED_PASSWORD:String = "auth_login_failed_password";
      
      public static const LOGIN_FAILED_USER_BANNED:String = "auth_login_failed_user_banned";
      
      public static const LOGOUT:String = "auth_logout";
      
      public static const USERNAME_EXISTS:String = "auth_email_exists";
      
      public static const NICKNAME_EXISTS:String = "auth_nickname_exists";
      
      public static const SIGNUP:String = "auth_signup";
      
      public static const SIGNUP_FAILED:String = "auth_signup_failed";
      
      public static const PASSWORD_RESET:String = "auth_reset_password";
      
      public static const PASSWORD_RESET_FAILED:String = "auth_reset_password_failed";
      
      public static const GAME_STATS:String = "auth_game_stats";
      
      public static const ERROR:String = "auth_error";
       
      
      private var _data:*;
      
      public function AuthenticationEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new AuthenticationEvent(type,data,bubbles,cancelable);
      }
   }
}
