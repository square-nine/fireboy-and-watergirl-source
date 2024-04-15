package com.miniclip.utils
{
   public class Convert
   {
       
      
      public function Convert()
      {
         super();
      }
      
      public static function charsToLongs(param1:Array) : Array
      {
         var _loc3_:Number = NaN;
         var _loc2_:Array = new Array(Math.ceil(param1.length / 4));
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_] = param1[_loc3_ * 4] + (param1[_loc3_ * 4 + 1] << 8) + (param1[_loc3_ * 4 + 2] << 16) + (param1[_loc3_ * 4 + 3] << 24);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function longsToChars(param1:Array) : Array
      {
         var _loc3_:Number = NaN;
         var _loc2_:Array = new Array();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1[_loc3_] & 255,param1[_loc3_] >>> 8 & 255,param1[_loc3_] >>> 16 & 255,param1[_loc3_] >>> 24 & 255);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function longToChars(param1:Number) : Array
      {
         var _loc2_:Array = new Array();
         _loc2_.push(param1 & 255,param1 >>> 8 & 255,param1 >>> 16 & 255,param1 >>> 24 & 255);
         return _loc2_;
      }
      
      public static function charsToHex(param1:Array) : String
      {
         var _loc4_:Number = NaN;
         var _loc2_:String = "";
         var _loc3_:Array = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ += _loc3_[param1[_loc4_] >> 4] + _loc3_[param1[_loc4_] & 15];
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function hexToChars(param1:String) : Array
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Array = [];
         if(param1.substr(0,2) == "0x")
         {
            _loc4_ = 2;
         }
         else
         {
            _loc4_ = 0;
         }
         _loc3_ = _loc4_;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(parseInt(param1.substr(_loc3_,2),16));
            _loc3_ += 2;
         }
         return _loc2_;
      }
      
      public static function charsToStr(param1:Array) : String
      {
         var _loc3_:Number = NaN;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += String.fromCharCode(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function strToChars(param1:String) : Array
      {
         var _loc3_:Number = NaN;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1.charCodeAt(_loc3_));
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function strToLongs(param1:String) : Array
      {
         return charsToLongs(strToChars(param1));
      }
      
      public static function longsToStr(param1:Array) : String
      {
         return charsToStr(longsToChars(param1));
      }
      
      public static function hexToLongs(param1:String) : Array
      {
         return charsToLongs(hexToChars(param1));
      }
      
      public static function longsToHex(param1:Array) : String
      {
         return charsToHex(longsToChars(param1));
      }
   }
}
