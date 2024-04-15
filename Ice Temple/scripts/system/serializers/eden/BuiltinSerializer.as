package system.serializers.eden
{
   import system.Arrays;
   import system.Environment;
   import system.eden;
   
   public class BuiltinSerializer
   {
       
      
      public function BuiltinSerializer()
      {
         super();
      }
      
      public static function emitArray(param1:Array) : String
      {
         var _loc2_:Array = [];
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_] === undefined)
            {
               _loc2_.push("undefined");
            }
            else if(param1[_loc4_] === null)
            {
               _loc2_.push("null");
            }
            else
            {
               ++eden.prettyIndent;
               _loc2_.push(eden.serialize(param1[_loc4_]));
               --eden.prettyIndent;
            }
            _loc4_++;
         }
         if(!eden.prettyPrinting)
         {
            return "[" + _loc2_.join(",") + "]";
         }
         var _loc5_:String;
         return (_loc5_ = Environment.newLine + Arrays.initialize(eden.prettyIndent,eden.indentor).join("")) + "[" + _loc5_ + _loc2_.join("," + _loc5_) + _loc5_ + "]";
      }
      
      public static function emitDate(param1:Date) : String
      {
         var _loc2_:Array = null;
         var _loc3_:Number = param1.getFullYear();
         var _loc4_:Number = param1.getMonth();
         var _loc5_:Number = param1.getDate();
         var _loc6_:Number = param1.getHours();
         var _loc7_:Number = param1.getMinutes();
         var _loc8_:Number = param1.getSeconds();
         var _loc9_:Number = param1.getMilliseconds();
         _loc2_ = [_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_];
         _loc2_.reverse();
         while(_loc2_[0] == 0)
         {
            _loc2_.splice(0,1);
         }
         _loc2_.reverse();
         return "new Date(" + _loc2_.join(",") + ")";
      }
      
      public static function emitObject(param1:Object) : String
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            if(param1.hasOwnProperty(_loc3_))
            {
               if(param1[_loc3_] === undefined)
               {
                  _loc2_.push(_loc3_ + ":" + "undefined");
               }
               else if(param1[_loc3_] === null)
               {
                  _loc2_.push(_loc3_ + ":" + "null");
               }
               else
               {
                  ++eden.prettyIndent;
                  _loc2_.push(_loc3_ + ":" + eden.serialize(param1[_loc3_]));
                  --eden.prettyIndent;
               }
            }
         }
         if(!eden.prettyPrinting)
         {
            return "{" + _loc2_.join(",") + "}";
         }
         var _loc4_:String;
         return (_loc4_ = Environment.newLine + Arrays.initialize(eden.prettyIndent,eden.indentor).join("")) + "{" + _loc4_ + _loc2_.join("," + _loc4_) + _loc4_ + "}";
      }
      
      public static function emitString(param1:String) : String
      {
         var code:int = 0;
         var value:String = param1;
         var quote:String = "\"";
         var str:String = "";
         var ch:String = "";
         var pos:int = 0;
         var _toUnicodeNotation:Function = function(param1:int):String
         {
            var _loc2_:String = param1.toString(16);
            while(_loc2_.length < 4)
            {
               _loc2_ = "0" + _loc2_;
            }
            return _loc2_;
         };
         while(pos < value.length)
         {
            ch = value.charAt(pos);
            code = value.charCodeAt(pos);
            if(code > 255)
            {
               str += "\\u" + _toUnicodeNotation(code);
               pos++;
            }
            else
            {
               switch(ch)
               {
                  case "\b":
                     str += "\\b";
                     break;
                  case "\t":
                     str += "\\t";
                     break;
                  case "\n":
                     str += "\\n";
                     break;
                  case "\x0b":
                     str += "\\v";
                     break;
                  case "\f":
                     str += "\\f";
                     break;
                  case "\r":
                     str += "\\r";
                     break;
                  case "\"":
                     str += "\\\"";
                     break;
                  case "\'":
                     str += "\\\'";
                     break;
                  case "\\":
                     str += "\\\\";
                     break;
                  default:
                     str += ch;
               }
               pos++;
            }
         }
         return quote + str + quote;
      }
   }
}
