package com.miniclip.utils
{
   public class Tea
   {
       
      
      public const delta:Number = 2654435769;
      
      public function Tea()
      {
         super();
      }
      
      public function encrypt(param1:String, param2:String) : String
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc3_:Array = Convert.strToLongs(param1);
         var _loc4_:Array = Convert.strToLongs(param2);
         var _loc5_:Number;
         if((_loc5_ = _loc3_.length) == 0)
         {
            return "";
         }
         if(_loc5_ == 1)
         {
            var _loc13_:*;
            _loc3_[_loc13_ = _loc5_++] = 0;
         }
         var _loc6_:Number = Number(_loc3_[_loc5_ - 1]);
         var _loc7_:Number = Number(_loc3_[0]);
         var _loc10_:Number = Math.floor(6 + 52 / _loc5_);
         var _loc11_:Number = 0;
         while(_loc10_-- > 0)
         {
            _loc9_ = (_loc11_ += delta) >>> 2 & 3;
            _loc12_ = 0;
            while(_loc12_ < _loc5_ - 1)
            {
               _loc7_ = Number(_loc3_[_loc12_ + 1]);
               _loc8_ = (_loc6_ >>> 5 ^ _loc7_ << 2) + (_loc7_ >>> 3 ^ _loc6_ << 4) ^ (_loc11_ ^ _loc7_) + (_loc4_[_loc12_ & 3 ^ _loc9_] ^ _loc6_);
               _loc6_ = _loc3_[_loc12_] = _loc3_[_loc12_] + _loc8_;
               _loc12_++;
            }
            _loc7_ = Number(_loc3_[0]);
            _loc8_ = (_loc6_ >>> 5 ^ _loc7_ << 2) + (_loc7_ >>> 3 ^ _loc6_ << 4) ^ (_loc11_ ^ _loc7_) + (_loc4_[_loc12_ & 3 ^ _loc9_] ^ _loc6_);
            _loc6_ = _loc3_[_loc5_ - 1] = _loc3_[_loc5_ - 1] + _loc8_;
         }
         return Convert.longsToHex(_loc3_);
      }
      
      public function decrypt(param1:String, param2:String) : String
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc3_:Array = Convert.hexToLongs(param1);
         var _loc4_:Array = Convert.strToLongs(param2);
         var _loc5_:Number;
         if((_loc5_ = _loc3_.length) == 0)
         {
            return "";
         }
         var _loc6_:Number = Number(_loc3_[_loc5_ - 1]);
         var _loc7_:Number = Number(_loc3_[0]);
         var _loc10_:Number;
         var _loc11_:Number = (_loc10_ = Math.floor(6 + 52 / _loc5_)) * delta;
         while(_loc11_ != 0)
         {
            _loc9_ = _loc11_ >>> 2 & 3;
            _loc12_ = _loc5_ - 1;
            while(_loc12_ > 0)
            {
               _loc8_ = ((_loc6_ = Number(_loc3_[_loc12_ - 1])) >>> 5 ^ _loc7_ << 2) + (_loc7_ >>> 3 ^ _loc6_ << 4) ^ (_loc11_ ^ _loc7_) + (_loc4_[_loc12_ & 3 ^ _loc9_] ^ _loc6_);
               _loc7_ = _loc3_[_loc12_] = _loc3_[_loc12_] - _loc8_;
               _loc12_--;
            }
            _loc8_ = ((_loc6_ = Number(_loc3_[_loc5_ - 1])) >>> 5 ^ _loc7_ << 2) + (_loc7_ >>> 3 ^ _loc6_ << 4) ^ (_loc11_ ^ _loc7_) + (_loc4_[_loc12_ & 3 ^ _loc9_] ^ _loc6_);
            _loc7_ = _loc3_[0] = _loc3_[0] - _loc8_;
            _loc11_ -= delta;
         }
         return Convert.longsToStr(_loc3_);
      }
   }
}
