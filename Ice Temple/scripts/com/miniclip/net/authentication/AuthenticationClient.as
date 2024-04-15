package com.miniclip.net.authentication
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.events.AuthenticationEvent;
   import com.miniclip.logger;
   import com.miniclip.net.amf.AMFClient;
   import com.miniclip.net.amf.AMFDataEvent;
   import com.miniclip.net.amf.AMFErrorEvent;
   import com.miniclip.net.amf.AMFEvent;
   import com.miniclip.net.amf.AMFTimeoutEvent;
   import com.miniclip.net.config;
   import flash.events.EventDispatcher;
   import flash.net.ObjectEncoding;
   import flash.net.SharedObject;
   
   public class AuthenticationClient extends EventDispatcher
   {
      
      private static var _sessionID:String;
       
      
      private var _cookieName:String;
      
      private var _lastCall:uint = 0;
      
      private var _amf:AMFClient;
      
      public function AuthenticationClient(param1:String = null, param2:String = null)
      {
         _cookieName = config.AuthSOName;
         super();
         if(param1 == null)
         {
            param1 = BlackBox.current.gatewayURL;
         }
         _amf = new AMFClient(param1,param2);
         _hookEvents();
      }
      
      public static function get defaultGateway() : String
      {
         return AMFClient.defaultGateway;
      }
      
      public static function set defaultGateway(param1:String) : void
      {
         AMFClient.defaultGateway = param1;
      }
      
      public static function get defaultServiceName() : String
      {
         return AMFClient.defaultServiceName;
      }
      
      public static function set defaultServiceName(param1:String) : void
      {
         AMFClient.defaultServiceName = param1;
      }
      
      public static function get sessionID() : String
      {
         return _sessionID;
      }
      
      public static function set sessionID(param1:String) : void
      {
         _sessionID = param1;
      }
      
      public static function bindUserDetails(param1:Object) : UserDetails
      {
         var _loc2_:UserDetails = null;
         var _loc3_:Object = null;
         if(param1 != null)
         {
            _loc3_ = new Object();
            if(param1.avatar)
            {
               _loc3_.avatar = param1.avatar;
            }
            else if(param1.avatar_string)
            {
               _loc3_.avatar = param1.avatar_string.length > 0;
            }
            _loc3_.challenges = param1.challenges_won;
            _loc3_.email = param1.username;
            _loc3_.friends = param1.friend_count;
            _loc3_.id = param1.id;
            _loc3_.sid = param1.sid;
            _loc3_.location = param1.location;
            _loc3_.nickname = param1.nickname;
            _loc3_.worldRank = param1.world_rank;
            _loc3_.starRank = param1.star_rank;
            _loc3_.playerAvatarURL = param1.player_avatar_url;
            _loc3_.playerPageURL = param1.player_page_url;
            _loc2_ = new UserDetails(_loc3_);
         }
         return _loc2_;
      }
      
      private function _hookEvents() : void
      {
         _amf.addEventListener(AMFEvent.ERROR,handleError,false,0,true);
         _amf.addEventListener(AMFEvent.TIMEOUT,handleTimeout,false,0,true);
      }
      
      public function getCookieUserCredentials() : UserCredentials
      {
         var _loc1_:UserCredentials = null;
         relocateSharedObject();
         var _loc2_:SharedObject = getLocalSharedObject();
         if(_loc2_.data.userCredentials != null)
         {
            _loc1_ = new UserCredentials(_loc2_.data.userCredentials);
         }
         _loc2_.flush();
         return _loc1_;
      }
      
      public function setCookieUserCredentials(param1:UserCredentials) : void
      {
         var _loc2_:SharedObject = getLocalSharedObject();
         _loc2_.data.userCredentials = param1;
         _loc2_.flush();
      }
      
      public function deleteCookieUserData() : void
      {
         var _loc1_:SharedObject = getLocalSharedObject();
         delete _loc1_.data.userCredentials;
         _loc1_.flush();
      }
      
      public function deleteCookieUserCredentials() : void
      {
         var _loc1_:SharedObject = getLocalSharedObject();
         delete _loc1_.data.userCredentials;
         _loc1_.flush();
      }
      
      public function deleteCookieUserPassword() : void
      {
         var _loc1_:SharedObject = getLocalSharedObject();
         if(_loc1_.data.userCredentials)
         {
            _loc1_.data.userCredentials.password = null;
            _loc1_.data.userCredentials.hashedPwd = null;
         }
         _loc1_.flush();
      }
      
      public function checkLoggedIn(param1:Boolean = true) : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleGetMemberDetailsForCheckLoggedIn);
         _lastCall = 1;
         _amf.call("getMemberDetailsExtended");
      }
      
      public function getMemberDetails() : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleGetMemberDetails,false,0,true);
         _lastCall = 1;
         _amf.call("getMemberDetailsExtended");
      }
      
      public function login(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleLogin,false,0,true);
         _lastCall = 2;
         _amf.call("login",param1,param2,param3,param4);
      }
      
      public function logout() : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleLogout,false,0,true);
         _lastCall = 3;
         _amf.call("logout");
      }
      
      public function usernameExists(param1:String) : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleUsernameExists,false,0,true);
         _lastCall = 4;
         _amf.call("usernameExists",param1);
      }
      
      public function nicknameExists(param1:String) : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleNicknameExists,false,0,true);
         _lastCall = 5;
         _amf.call("nicknameExists",param1);
      }
      
      public function signup(param1:String, param2:String, param3:String, param4:Date) : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleSignup,false,0,true);
         var _loc5_:String = param4.getFullYear() + "-" + String(param4.getMonth() + 1) + "-" + param4.getDate();
         _lastCall = 6;
         _amf.call("signup",param1,param2,param3,_loc5_);
      }
      
      public function resetPassword(param1:String) : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleResetPassword,false,0,true);
         _lastCall = 7;
         _amf.call("remindPassword",param1);
      }
      
      public function getGameStats(param1:uint) : void
      {
         _amf.addEventListener(AMFEvent.DATA,handleGameStats,false,0,true);
         _lastCall = 8;
         _amf.call("getGameStats",param1);
      }
      
      private function getLocalSharedObject() : SharedObject
      {
         var _loc1_:SharedObject = SharedObject.getLocal(_cookieName,"/");
         _loc1_.objectEncoding = ObjectEncoding.AMF0;
         return _loc1_;
      }
      
      private function handleGetMemberDetailsForCheckLoggedIn(param1:AMFEvent) : void
      {
         var _loc2_:UserDetails = null;
         _amf.removeEventListener(AMFEvent.DATA,handleGetMemberDetailsForCheckLoggedIn);
         var _loc3_:Boolean = false;
         if(param1.data != null && param1.data.id && param1.data.id > 0)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc2_ = bindUserDetails(param1.data);
            _sessionID = _loc2_.sessionid;
         }
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.USER_DETAILS,_loc2_));
      }
      
      protected function handleGetMemberDetails(param1:AMFDataEvent) : void
      {
         var _loc2_:UserDetails = null;
         _amf.removeEventListener(AMFEvent.DATA,handleGetMemberDetails);
         var _loc3_:Boolean = false;
         if(param1.data != null && param1.data.id && param1.data.id > 0)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc2_ = bindUserDetails(param1.data);
            _sessionID = _loc2_.sessionid;
         }
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.USER_DETAILS,_loc2_));
      }
      
      protected function handleLogin(param1:AMFDataEvent) : void
      {
         var _loc2_:UserDetails = null;
         _amf.removeEventListener(AMFEvent.DATA,handleLogin);
         if(param1.data.success)
         {
            _loc2_ = bindUserDetails(param1.data.result);
            _sessionID = _loc2_.sessionid;
            dispatchEvent(new AuthenticationEvent(AuthenticationEvent.LOGIN,_loc2_));
         }
         else
         {
            switch(param1.data.result)
            {
               case -1:
                  dispatchEvent(new AuthenticationEvent(AuthenticationEvent.LOGIN_FAILED_USERNAME,null));
                  break;
               case -2:
                  dispatchEvent(new AuthenticationEvent(AuthenticationEvent.LOGIN_FAILED_PASSWORD,null));
                  break;
               case -3:
                  dispatchEvent(new AuthenticationEvent(AuthenticationEvent.LOGIN_FAILED_USER_BANNED,null));
            }
         }
      }
      
      protected function handleLogout(param1:AMFDataEvent) : void
      {
         _amf.removeEventListener(AMFEvent.DATA,handleLogout);
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.LOGOUT,null));
      }
      
      protected function handleUsernameExists(param1:AMFDataEvent) : void
      {
         _amf.removeEventListener(AMFEvent.DATA,handleUsernameExists);
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.USERNAME_EXISTS,param1.data));
      }
      
      protected function handleNicknameExists(param1:AMFDataEvent) : void
      {
         _amf.removeEventListener(AMFEvent.DATA,handleNicknameExists);
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.NICKNAME_EXISTS,param1.data));
      }
      
      protected function handleSignup(param1:AMFDataEvent) : void
      {
         var _loc2_:UserDetails = null;
         _amf.removeEventListener(AMFEvent.DATA,handleSignup);
         if(param1.data.success)
         {
            _loc2_ = bindUserDetails(param1.data.result);
            _sessionID = _loc2_.sessionid;
            dispatchEvent(new AuthenticationEvent(AuthenticationEvent.SIGNUP,_loc2_));
         }
         else
         {
            dispatchEvent(new AuthenticationEvent(AuthenticationEvent.SIGNUP_FAILED,param1.data.result));
         }
      }
      
      protected function handleResetPassword(param1:AMFDataEvent) : void
      {
         _amf.removeEventListener(AMFEvent.DATA,handleResetPassword);
         if(param1.data.success)
         {
            dispatchEvent(new AuthenticationEvent(AuthenticationEvent.PASSWORD_RESET,param1.data.result));
         }
         else
         {
            dispatchEvent(new AuthenticationEvent(AuthenticationEvent.PASSWORD_RESET_FAILED,param1.data.result));
         }
      }
      
      protected function handleGameStats(param1:AMFDataEvent) : void
      {
         _amf.removeEventListener(AMFEvent.DATA,handleGameStats);
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.GAME_STATS,param1.data));
      }
      
      protected function handleError(param1:AMFErrorEvent) : void
      {
         if(param1.code != "NetConnection.Connect.Closed")
         {
            logger.error("error: " + String(param1.description));
            dispatchEvent(new AuthenticationEvent(AuthenticationEvent.ERROR,_lastCall));
         }
      }
      
      protected function handleTimeout(param1:AMFTimeoutEvent) : void
      {
         logger.error("timeout: " + String(param1.data));
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.ERROR,9));
      }
      
      private function relocateSharedObject() : void
      {
         var _loc1_:SharedObject = getLocalSharedObject();
         var _loc2_:SharedObject = SharedObject.getLocal(_cookieName);
         if(!_loc1_.data.userCredentials && Boolean(_loc2_.data.userCredentials))
         {
            _loc1_.data.userCredentials = _loc2_.data.userCredentials;
            delete _loc2_.data.userCredentials;
            delete _loc2_.data.userDetails;
         }
         _loc1_.flush();
      }
   }
}
