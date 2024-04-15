package com.miniclip.net.authentication
{
   public class UserCredentials
   {
       
      
      public var userName:String = null;
      
      public var password:String = null;
      
      public var hashedPwd:String = null;
      
      public function UserCredentials(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.userName != null)
            {
               userName = param1.userName;
            }
            if(param1.password != null)
            {
               password = param1.password;
            }
            if(param1.hashedPwd != null)
            {
               hashedPwd = param1.hashedPwd;
            }
         }
      }
      
      public function toString() : String
      {
         var _loc1_:String = password != null ? "********" : "";
         var _loc2_:String = hashedPwd != null ? "########" : "";
         return "[" + userName + ":" + _loc1_ + "/" + _loc2_ + "]";
      }
   }
}
