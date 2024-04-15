package com.miniclip.utils
{
   public class StringUtil
   {
       
      
      public function StringUtil()
      {
         super();
      }
      
      public static function isEmail(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
         return _loc2_.test(param1);
      }
      
      public static function getDomainName(param1:String) : String
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc2_:String = "";
         var _loc3_:Number = param1.indexOf("://");
         if(_loc3_ > 0)
         {
            if((_loc5_ = (_loc4_ = param1.substr(_loc3_ + 3)).split("/")).length > 0)
            {
               _loc2_ = String(_loc5_[0]);
            }
         }
         return _loc2_;
      }
      
      public static function getHTTPServer(param1:String) : String
      {
         var _loc2_:String = getDomainName(param1);
         var _loc3_:Number = param1.indexOf("://");
         var _loc4_:String;
         return (_loc4_ = param1.substr(0,_loc3_)) == "http" || _loc4_ == "https" ? _loc4_ + "://" + _loc2_ : "";
      }
      
      public static function format(param1:String, ... rest) : String
      {
         if(param1 == null || param1 == "")
         {
            return "";
         }
         var _loc3_:uint = uint(rest.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            param1 = param1.replace(new RegExp("\\{" + _loc4_ + "\\}","g"),rest[_loc4_]);
            _loc4_++;
         }
         return param1;
      }
   }
}
