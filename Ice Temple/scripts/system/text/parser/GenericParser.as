package system.text.parser
{
   public class GenericParser
   {
       
      
      private var _source:String;
      
      public var ch:String;
      
      public var pos:uint;
      
      public function GenericParser(param1:String)
      {
         super();
         _source = param1;
         pos = 0;
         ch = "";
      }
      
      public static function isAlpha(param1:String) : Boolean
      {
         return "A" <= param1 && param1 <= "Z" || "a" <= param1 && param1 <= "z";
      }
      
      public static function isASCII(param1:String) : Boolean
      {
         return param1.charCodeAt(0) <= 255;
      }
      
      public static function isDigit(param1:String) : Boolean
      {
         return "0" <= param1 && param1 <= "9";
      }
      
      public static function isHexDigit(param1:String) : Boolean
      {
         return isDigit(param1) || "A" <= param1 && param1 <= "F" || "a" <= param1 && param1 <= "f";
      }
      
      public static function isUnicode(param1:String) : Boolean
      {
         return param1.charCodeAt(0) > 255;
      }
      
      public function get source() : String
      {
         return _source;
      }
      
      public function getChar() : String
      {
         return source.charAt(pos);
      }
      
      public function getCharAt(param1:uint) : String
      {
         return source.charAt(param1);
      }
      
      public function next() : String
      {
         ch = getChar();
         ++pos;
         return ch;
      }
      
      public function hasMoreChar() : Boolean
      {
         return pos <= source.length - 1;
      }
   }
}
