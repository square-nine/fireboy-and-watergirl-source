package system
{
   public class Char
   {
      
      private static var _ch:Char = new Char("");
      
      private static var _alphabetic:String = "abcdefghijklmnopqrstuvwxyz";
      
      public static const NUL:Char = new Char("\x00");
      
      public static const SOH:Char = new Char("\x01");
      
      public static const STX:Char = new Char("\x02");
      
      public static const ETX:Char = new Char("\x03");
      
      public static const EOT:Char = new Char("\x04");
      
      public static const ENQ:Char = new Char("\x05");
      
      public static const ACK:Char = new Char("\x06");
      
      public static const BEL:Char = new Char("\x07");
      
      public static const BS:Char = new Char("\b");
      
      public static const TAB:Char = new Char("\t");
      
      public static const LF:Char = new Char("\n");
      
      public static const VT:Char = new Char("\x0b");
      
      public static const FF:Char = new Char("\f");
      
      public static const CR:Char = new Char("\r");
      
      public static const SO:Char = new Char("\x0e");
      
      public static const SI:Char = new Char("\x0f");
      
      public static const DLE:Char = new Char("\x10");
      
      public static const DC1:Char = new Char("\x11");
      
      public static const DC2:Char = new Char("\x12");
      
      public static const DC3:Char = new Char("\x13");
      
      public static const DC4:Char = new Char("\x14");
      
      public static const NAK:Char = new Char("\x15");
      
      public static const SYN:Char = new Char("\x16");
      
      public static const ETB:Char = new Char("\x17");
      
      public static const CAN:Char = new Char("\x18");
      
      public static const EM:Char = new Char("\x19");
      
      public static const SUB:Char = new Char("\x1a");
      
      public static const ESC:Char = new Char("\x1b");
      
      public static const FS:Char = new Char("\x1c");
      
      public static const GS:Char = new Char("\x1d");
      
      public static const RS:Char = new Char("\x1e");
      
      public static const US:Char = new Char("\x1f");
      
      public static const DEL:Char = new Char("");
      
      public static const space:Char = new Char(" ");
      
      public static const exclamationPoint:Char = new Char("!");
      
      public static const quotationMarks:Char = new Char("\"");
      
      public static const numberSign:Char = new Char("#");
      
      public static const dollarSign:Char = new Char("$");
      
      public static const percent:Char = new Char("%");
      
      public static const ampersand:Char = new Char("&");
      
      public static const apostrophe:Char = new Char("\'");
      
      public static const openingParenthesis:Char = new Char("(");
      
      public static const closingParenthesis:Char = new Char(")");
      
      public static const asterisk:Char = new Char("*");
      
      public static const plus:Char = new Char("+");
      
      public static const comma:Char = new Char(",");
      
      public static const minus:Char = new Char("-");
      
      public static const period:Char = new Char(".");
      
      public static const slash:Char = new Char("/");
      
      public static const colon:Char = new Char(":");
      
      public static const semiColon:Char = new Char(";");
      
      public static const lessThan:Char = new Char("<");
      
      public static const equals:Char = new Char("=");
      
      public static const greaterThen:Char = new Char(">");
      
      public static const questionMark:Char = new Char("?");
      
      public static const commercialAt:Char = new Char("@");
      
      public static const openingBracket:Char = new Char("[");
      
      public static const backslash:Char = new Char("\\");
      
      public static const closingBracket:Char = new Char("]");
      
      public static const circumflex:Char = new Char("^");
      
      public static const underline:Char = new Char("_");
      
      public static const graveAccent:Char = new Char("`");
      
      public static const openingBrace:Char = new Char("{");
      
      public static const pipe:Char = new Char("|");
      
      public static const closingBrace:Char = new Char("}");
      
      public static const tilde:Char = new Char("~");
      
      public static var controls:Array = [NUL,SOH,STX,ETX,EOT,ENQ,ACK,BEL,BS,TAB,LF,VT,FF,CR,SO,SI,DLE,DC1,DC2,DC3,DC4,NAK,SYN,ETB,CAN,EM,SUB,ESC,FS,GS,RS,US,DEL];
      
      public static var symbols:Array = [space,exclamationPoint,quotationMarks,numberSign,dollarSign,percent,ampersand,apostrophe,openingParenthesis,closingParenthesis,asterisk,plus,comma,minus,period,slash,colon,semiColon,lessThan,equals,greaterThen,questionMark,commercialAt,openingBracket,backslash,closingBracket,circumflex,underline,graveAccent,openingBrace,pipe,closingBrace,tilde];
      
      private static var _alphabetics:Array;
      
      private static var _alphabeticsUpper:Array;
       
      
      private var _c:String;
      
      public function Char(param1:String = "", param2:uint = 0)
      {
         super();
         _c = param1.charAt(param2);
      }
      
      public static function get alphabetics() : Array
      {
         if(_alphabetics)
         {
            return _alphabetics;
         }
         _alphabetics = Strings.splitToChars(_alphabetic);
         return _alphabetics;
      }
      
      public static function get alphabeticsUpper() : Array
      {
         if(_alphabeticsUpper)
         {
            return _alphabeticsUpper;
         }
         _alphabeticsUpper = Strings.splitToChars(_alphabetic,"toUpperCase");
         return _alphabeticsUpper;
      }
      
      public static function fromNumber(param1:Number) : Char
      {
         return new Char(String.fromCharCode(param1));
      }
      
      public static function isASCII(param1:String, param2:uint = 0, param3:Boolean = false) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isASCII(param3);
      }
      
      public static function isContained(param1:String, param2:uint = 0, param3:String = "") : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isContained(param3);
      }
      
      public static function isControl(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isControl();
      }
      
      public static function isDigit(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isDigit();
      }
      
      public static function isHexDigit(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isHexDigit();
      }
      
      public static function isLetter(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isLetter();
      }
      
      public static function isLetterOrDigit(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isLetterOrDigit();
      }
      
      public static function isLower(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isLower();
      }
      
      public static function isSymbol(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isSymbol();
      }
      
      public static function isUnicode(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isUnicode();
      }
      
      public static function isUpper(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isUpper();
      }
      
      public static function isWhiteSpace(param1:String, param2:uint = 0) : Boolean
      {
         _ch.value = param1.charAt(param2);
         return _ch.isWhiteSpace();
      }
      
      public function get code() : Number
      {
         return _c.charCodeAt(0);
      }
      
      public function set code(param1:Number) : void
      {
         _c = String.fromCharCode(param1);
      }
      
      public function get value() : String
      {
         return _c;
      }
      
      public function set value(param1:String) : void
      {
         _c = param1.charAt(0);
      }
      
      public function isASCII(param1:Boolean = false) : Boolean
      {
         var _loc2_:uint = 128;
         if(param1)
         {
            _loc2_ = 255;
         }
         return code < _loc2_;
      }
      
      public function isContained(param1:String) : Boolean
      {
         if(param1 == null || param1.length == 0)
         {
            return false;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(_c == param1.charAt(_loc2_))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isControl() : Boolean
      {
         var _loc1_:int = int(controls.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(_c == controls[_loc2_].toString())
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isDigit() : Boolean
      {
         return "0" <= _c && _c <= "9";
      }
      
      public function isHexDigit() : Boolean
      {
         return isDigit() || "A" <= _c && _c <= "F" || "a" <= _c && _c <= "f";
      }
      
      public function isLetter() : Boolean
      {
         return isUpper() || isLower();
      }
      
      public function isLetterOrDigit() : Boolean
      {
         return isLetter() || isDigit();
      }
      
      public function isLower() : Boolean
      {
         return "a" <= _c && _c <= "z";
      }
      
      public function isSymbol() : Boolean
      {
         var _loc1_:int = int(symbols.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(_c == symbols[_loc2_].toString())
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isUnicode() : Boolean
      {
         return _c.charCodeAt(0) > 255;
      }
      
      public function isUpper() : Boolean
      {
         return "A" <= _c && _c <= "Z";
      }
      
      public function isWhiteSpace() : Boolean
      {
         var _loc1_:Array = Strings.whiteSpaceChars;
         var _loc2_:int = int(_loc1_.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(_c == _loc1_[_loc3_])
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function toNumber() : Number
      {
         return code;
      }
      
      public function toHexadecimal() : String
      {
         var _loc1_:String = code.toString(16);
         return _loc1_.length == 1 ? "0" + _loc1_ : _loc1_;
      }
      
      public function toOctal() : String
      {
         var _loc1_:String = code.toString(8);
         while(_loc1_.length < 3)
         {
            _loc1_ = "0" + _loc1_;
         }
         return _loc1_;
      }
      
      public function toLower() : Char
      {
         return new Char(_c.toLowerCase());
      }
      
      public function toUpper() : Char
      {
         return new Char(_c.toUpperCase());
      }
      
      public function toString() : String
      {
         return _c;
      }
      
      public function valueOf() : String
      {
         return _c;
      }
   }
}
