package system
{
   import system.comparators.StringComparator;
   import system.evaluators.EdenEvaluator;
   import system.evaluators.MultiEvaluator;
   
   public class Strings
   {
      
      private static var _sComparator:StringComparator = new StringComparator();
      
      public static var evaluators:Object = {};
      
      private static var _hiddenIndex:uint = 100;
      
      public static const whiteSpaceChars:Array = ["\t","\n","\x0b","\f","\r"," "," "," ","᠎"," "," "," "," "," "," "," "," "," "," "," ","​"," "," "," "," ","　"];
       
      
      public function Strings()
      {
         super();
      }
      
      private static function _padHelper(param1:String, param2:int, param3:String = " ", param4:Boolean = true) : String
      {
         if(param2 < param1.length || param2 < 0)
         {
            return param1;
         }
         if(param3.length > 1)
         {
            param3 = param3.charAt(0);
         }
         while(param1.length != param2)
         {
            if(param4 == true)
            {
               param1 += param3;
            }
            else
            {
               param1 = param3 + param1;
            }
         }
         return param1;
      }
      
      private static function _trimHelper(param1:String, param2:Array, param3:Boolean = false, param4:Boolean = false) : String
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param3)
         {
            _loc5_ = 0;
            while(_loc5_ < param1.length && param2.indexOf(param1.charAt(_loc5_)) > -1)
            {
               _loc5_++;
            }
            param1 = param1.substr(_loc5_);
         }
         if(param4)
         {
            _loc6_ = param1.length - 1;
            while(_loc6_ >= 0 && param2.indexOf(param1.charAt(_loc6_)) > -1)
            {
               _loc6_--;
            }
            param1 = param1.substring(0,_loc6_ + 1);
         }
         return param1;
      }
      
      public static function center(param1:String, param2:uint = 0, param3:String = " ") : String
      {
         var _loc4_:uint = uint(param1.length);
         if(param2 <= _loc4_)
         {
            return param1;
         }
         var _loc5_:int = Math.floor((param2 - _loc4_) / 2);
         return repeat(param3,_loc5_) + param1 + repeat(param3,param2 - _loc4_ - _loc5_);
      }
      
      public static function compare(param1:String, param2:String, param3:Boolean = false) : int
      {
         return _sComparator.compare(param1,param2,!param3);
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         if(param1 == null || param2 == null || param1.length < param2.length)
         {
            return false;
         }
         return compare(param1.substr(param1.length - param2.length),param2) == 0;
      }
      
      private static function _evaluate(param1:String) : Object
      {
         var defaultEvaluator:EdenEvaluator;
         var evaluators:MultiEvaluator;
         var evalSequence:String;
         var evalString:String;
         var inBetween:String;
         var isValidChar:Function;
         var isValid:Function;
         var pos1:int = 0;
         var pos2:int = 0;
         var lpos:int = 0;
         var tmp:String = null;
         var evaluatorsAlias:Array = null;
         var l:int = 0;
         var i:uint = 0;
         var value:String = param1;
         var obj:Object = {};
         obj.format = "";
         obj.indexes = [];
         defaultEvaluator = new EdenEvaluator();
         evaluators = new MultiEvaluator();
         evalSequence = "";
         evalString = "";
         inBetween = "";
         isValidChar = function(param1:String):Boolean
         {
            if("a" <= param1 && param1 <= "z" || "0" <= param1 && param1 <= "9" || param1 == ",")
            {
               return true;
            }
            return false;
         };
         isValid = function(param1:String):Boolean
         {
            if(param1 == "")
            {
               return true;
            }
            var _loc2_:Array = param1.split("");
            var _loc3_:int = int(_loc2_.length);
            var _loc4_:int = 0;
            while(_loc4_ < _loc3_)
            {
               if(!isValidChar(_loc2_[_loc4_]))
               {
                  return false;
               }
               _loc4_++;
            }
            return true;
         };
         while(value.indexOf("${") > -1)
         {
            pos1 = value.indexOf("${");
            pos2 = value.indexOf("$",pos1 + 2);
            if(pos2 == -1)
            {
               throw new Error("malformed evaluator, could not find [$] after [}].");
            }
            evalSequence = value.slice(pos1 + 2,pos2);
            lpos = evalSequence.lastIndexOf("}");
            inBetween = evalSequence.substring(lpos + 1);
            while(!isValid(inBetween))
            {
               pos2 = value.indexOf("$",pos1 + 2 + pos2);
               if(pos2 == -1)
               {
                  throw new Error("malformed evaluator, could not find [$] after [}].");
               }
               evalSequence = value.slice(pos1 + 2,pos2);
               lpos = evalSequence.lastIndexOf("}");
               inBetween = evalSequence.substring(lpos + 1);
            }
            if(lpos != evalSequence.length - 1)
            {
               tmp = evalSequence.substring(lpos + 1);
               if(tmp.indexOf(",") > -1)
               {
                  evaluatorsAlias = tmp.split(",");
               }
               else
               {
                  evaluatorsAlias = [tmp];
               }
               l = int(evaluatorsAlias.length);
               i = 0;
               while(i < l)
               {
                  if(Strings.evaluators[evaluatorsAlias[i]])
                  {
                     evaluators.add(Strings.evaluators[evaluatorsAlias[i]]);
                  }
                  else
                  {
                     trace("## Warning: \"" + evaluatorsAlias[i] + "\" is not a valid evaluator ##");
                  }
                  i++;
               }
            }
            if(evaluators.size() == 0)
            {
               evaluators.add(defaultEvaluator);
            }
            evalString = evalSequence.substring(0,lpos);
            obj.indexes.push(evaluators.eval(evalString));
            value = value.split("${" + evalSequence + "$").join("{" + (_hiddenIndex + (obj.indexes.length - 1)) + "}");
         }
         obj.format = value;
         return obj;
      }
      
      private static function _format(param1:String, param2:Array, param3:Object, param4:String = " ") : String
      {
         var ch:String = null;
         var pos:int = 0;
         var stringvalue:String = param1;
         var indexed:Array = param2;
         var named:Object = param3;
         var paddingChar:String = param4;
         var parseExpression:Function = function(param1:String):String
         {
            var _loc7_:int = 0;
            var _loc8_:int = 0;
            var _loc2_:String = "";
            var _loc3_:int = 0;
            var _loc4_:Boolean = false;
            var _loc5_:String = paddingChar;
            if(indexOfAny(param1,[",",":"]) > -1)
            {
               if((_loc7_ = param1.indexOf(",")) == -1)
               {
                  throw new Error("malformed format, could not find [,] before [:].");
               }
               if((_loc8_ = param1.indexOf(":")) == -1)
               {
                  _loc3_ = int(param1.substr(_loc7_ + 1));
               }
               else
               {
                  _loc3_ = int(param1.substring(_loc7_ + 1,_loc8_));
                  _loc5_ = param1.substr(_loc8_ + 1);
               }
               _loc4_ = true;
               param1 = param1.substring(0,_loc7_);
            }
            var _loc6_:String = String(param1.split("")[0]);
            if("A" <= _loc6_ && _loc6_ <= "Z" || "a" <= _loc6_ && _loc6_ <= "z")
            {
               _loc2_ = String(named[param1]);
            }
            else if("0" <= _loc6_ && _loc6_ <= "9")
            {
               _loc2_ = String(indexed[int(param1)]);
            }
            if(_loc4_)
            {
               if(_loc3_ > 0 && _loc2_.length < _loc3_)
               {
                  _loc2_ = padLeft(_loc2_,_loc3_,_loc5_);
               }
               else if(_loc3_ < -_loc2_.length)
               {
                  _loc2_ = padRight(_loc2_,-_loc3_,_loc5_);
               }
            }
            return _loc2_;
         };
         var expression:String = "";
         var formated:String = "";
         ch = "";
         pos = 0;
         var len:int = stringvalue.length;
         var next:Function = function():String
         {
            ch = stringvalue.charAt(pos);
            ++pos;
            return ch;
         };
         while(pos < len)
         {
            next();
            if(ch == "{")
            {
               expression = next();
               while(next() != "}")
               {
                  expression += ch;
               }
               formated += parseExpression(expression);
            }
            else
            {
               formated += ch;
            }
         }
         return formated;
      }
      
      public static function format(param1:String, ... rest) : String
      {
         var _loc11_:String = null;
         var _loc3_:Array = [];
         var _loc4_:Object = {};
         if(param1 == "")
         {
            return param1;
         }
         var _loc5_:Object;
         if((_loc5_ = _evaluate(param1)) != null && _loc5_.indexes.length == 0 && (rest == null || rest.length == 0))
         {
            return param1;
         }
         param1 = String(_loc5_.format);
         if(rest.length >= 1)
         {
            if(rest[0] is Array)
            {
               _loc3_ = _loc3_.concat(rest[0]);
               rest.shift();
            }
            else if(rest[0] is Object && String(rest[0]) == "[object Object]")
            {
               for(_loc11_ in rest[0])
               {
                  _loc4_[_loc11_] = rest[0][_loc11_];
               }
               rest.shift();
            }
         }
         _loc3_ = _loc3_.concat(rest);
         if(_loc3_.length - 1 >= _hiddenIndex)
         {
            trace("## Warning : indexed tokens are too big ##");
         }
         var _loc6_:int = int(_loc5_.indexes.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc3_[_hiddenIndex + _loc7_] = _loc5_.indexes[_loc7_];
            _loc7_++;
         }
         if(indexOfAny(param1,["{{","}}"]) > -1)
         {
            param1 = param1.split("{{{").join("￼" + "{");
            param1 = param1.split("{{").join("￼");
            param1 = param1.split("}}}").join("}" + "�");
            param1 = param1.split("}}").join("�");
         }
         var _loc10_:String = _format(param1,_loc3_,_loc4_);
         if(indexOfAny(param1,["￼","�"]) > -1)
         {
            _loc10_ = (_loc10_ = _loc10_.split("￼").join("{")).split("�").join("}");
         }
         return _loc10_;
      }
      
      public static function indexOfAny(param1:String, param2:Array, param3:int = 0, param4:int = -1) : int
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 == null || param1 == "")
         {
            return -1;
         }
         if(param3 < 0)
         {
            param3 = 0;
         }
         if(param4 < 0 || param4 > param2.length - param3)
         {
            _loc6_ = int(param2.length - 1);
         }
         else
         {
            _loc6_ = param3 + param4 - 1;
         }
         _loc5_ = param3;
         while(_loc5_ <= _loc6_)
         {
            if(param1.indexOf(param2[_loc5_]) > -1)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }
      
      public static function insert(param1:String, param2:int, param3:String) : String
      {
         var _loc4_:String = "";
         var _loc5_:String = "";
         if(param2 == 0)
         {
            return param3 + param1;
         }
         if(param2 == param1.length)
         {
            return param1 + param3;
         }
         _loc4_ = param1.substr(0,param2);
         _loc5_ = param1.substr(param2);
         return _loc4_ + param3 + _loc5_;
      }
      
      public static function lastIndexOfAny(param1:String, param2:Array, param3:int = 2147483647, param4:int = 2147483647) : int
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param2 == null)
         {
            throw new ArgumentError("Strings.lastIndexOfAny failed with an empty \'anyOf\' Array.");
         }
         if(param1 == null || param1.length == 0)
         {
            return -1;
         }
         if(isNaN(param4) || param4 < 0)
         {
            param4 = 2147483647;
         }
         if(isNaN(param3) || param3 > param1.length)
         {
            param3 = param1.length;
         }
         else if(param3 < 0)
         {
            return -1;
         }
         var _loc7_:int;
         if((_loc7_ = param3 - param4 + 1) < 0)
         {
            _loc7_ = 0;
         }
         param1 = param1.slice(_loc7_,param3 + 1);
         var _loc8_:uint = param2.length;
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            if((_loc6_ = param1.lastIndexOf(param2[_loc5_],param3)) > -1)
            {
               return _loc6_ + _loc7_;
            }
            _loc5_++;
         }
         return -1;
      }
      
      public static function padLeft(param1:String, param2:int, param3:String = " ") : String
      {
         var _loc4_:Boolean = false;
         if(param2 < 0)
         {
            param2 = -param2;
            _loc4_ = true;
         }
         return _padHelper(param1,param2,param3,_loc4_);
      }
      
      public static function padRight(param1:String, param2:int, param3:String = " ") : String
      {
         var _loc4_:Boolean = true;
         if(param2 < 0)
         {
            param2 = -param2;
            _loc4_ = false;
         }
         return _padHelper(param1,param2,param3,_loc4_);
      }
      
      public static function repeat(param1:String = "", param2:uint = 0) : String
      {
         var _loc4_:uint = 0;
         var _loc3_:String = "";
         if(param2 > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < param2)
            {
               _loc3_ = _loc3_.concat(param1);
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = param1;
         }
         return _loc3_;
      }
      
      public static function startsWith(param1:String, param2:String) : Boolean
      {
         if(param2 == "" && param1 != null)
         {
            return true;
         }
         if(param1 == "" || param1 == null || param2 == null || param1.length < param2.length)
         {
            return false;
         }
         if(param1.charAt(0) != param2.charAt(0))
         {
            return false;
         }
         return compare(param1.substr(0,param2.length),param2) == 0;
      }
      
      public static function splitToChars(param1:String, param2:String = "toString") : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.push(new Char(param1[param2](),_loc4_));
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function trim(param1:String, param2:Array = null) : String
      {
         if(param2 == null)
         {
            param2 = whiteSpaceChars;
         }
         return _trimHelper(param1,param2,true,true);
      }
      
      public static function trimEnd(param1:String, param2:Array = null) : String
      {
         if(param2 == null)
         {
            param2 = whiteSpaceChars;
         }
         return _trimHelper(param1,param2,false,true);
      }
      
      public static function trimStart(param1:String, param2:Array = null) : String
      {
         if(param2 == null)
         {
            param2 = whiteSpaceChars;
         }
         return _trimHelper(param1,param2,true,false);
      }
   }
}
