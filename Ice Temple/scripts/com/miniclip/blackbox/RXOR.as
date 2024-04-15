package com.miniclip.blackbox
{
   public function RXOR(param1:String, param2:uint = 4660):String
   {
      var i:uint = 0;
      var text:String = param1;
      var k:uint = param2;
      k &= 65535;
      var rotbit:Function = function(param1:uint):uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = uint(param1.toString(16).length);
         var _loc4_:uint;
         var _loc5_:uint = uint(~(_loc4_ = uint(15 << 4 * (_loc3_ - 1))));
         _loc2_ = uint((param1 & _loc4_) >>> 4 * (_loc3_ - 1));
         return uint((param1 & _loc5_) << 4 | _loc2_);
      };
      var c:Array = text.split("");
      i = 0;
      while(i < c.length)
      {
         c[i] = c[i].charCodeAt(0);
         c[i] ^= k;
         c[i] = String.fromCharCode(c[i]);
         k = rotbit(k);
         i++;
      }
      return c.join("");
   }}
