package system
{
   import flash.system.ApplicationDomain;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   import system.reflection.ClassInfo;
   import system.reflection.FilterType;
   import system.reflection.TypeInfo;
   import system.reflection._ClassInfo;
   import system.reflection._TypeInfo;
   
   public class Reflection
   {
       
      
      public function Reflection()
      {
         super();
      }
      
      private static function _formatName(param1:String) : String
      {
         var _loc2_:Array = param1.split(".");
         return _loc2_.length > 1 ? _loc2_.pop() : param1;
      }
      
      private static function _formatPackage(param1:String) : String
      {
         var _loc2_:Array = param1.split(".");
         if(_loc2_.length > 1)
         {
            _loc2_.pop();
            return _loc2_.join(".");
         }
         return null;
      }
      
      private static function _formatPath(param1:String) : String
      {
         return param1.split("::").join(".");
      }
      
      public static function getClassByName(param1:String) : Class
      {
         param1 = _formatPath(param1);
         return ApplicationDomain.currentDomain.getDefinition(param1) as Class;
      }
      
      public static function getClassInfo(param1:*, ... rest) : ClassInfo
      {
         var _loc4_:* = 0;
         var _loc6_:int = 0;
         var _loc3_:FilterType = FilterType.none;
         var _loc5_:int = int(rest.length);
         while(_loc6_ < _loc5_)
         {
            _loc4_ |= int(rest[_loc6_]);
            _loc6_++;
         }
         if(_loc4_ > 0)
         {
            _loc3_ = new FilterType(_loc4_);
         }
         return new _ClassInfo(param1,_loc3_);
      }
      
      public static function getClassMethods(param1:*, param2:Boolean = false) : Array
      {
         var _loc6_:XML = null;
         var _loc3_:XML = describeType(param1);
         var _loc4_:String = getClassName(param1,true);
         var _loc5_:Array = [];
         for each(_loc6_ in _loc3_.method)
         {
            if(param2)
            {
               _loc5_.push(String(_loc6_.@name));
            }
            else if(String(_loc6_.@declaredBy) == _loc4_)
            {
               _loc5_.push(String(_loc6_.@name));
            }
         }
         return _loc5_;
      }
      
      public static function getClassName(param1:*, param2:Boolean = false) : String
      {
         return param2 == true ? getQualifiedClassName(param1) : _formatName(getClassPath(param1));
      }
      
      public static function getClassPackage(param1:*) : String
      {
         return _formatPackage(getClassPath(param1));
      }
      
      public static function getClassPath(param1:*) : String
      {
         return _formatPath(getQualifiedClassName(param1));
      }
      
      public static function getDefinitionByName(param1:String) : Object
      {
         return ApplicationDomain.currentDomain.getDefinition(param1);
      }
      
      public static function getMethodByName(param1:*, param2:String) : Function
      {
         var _loc3_:Array = getClassMethods(param1);
         if(_loc3_.indexOf(param2) > -1)
         {
            return param1[param2] as Function;
         }
         return null;
      }
      
      public static function getSuperClassName(param1:*) : String
      {
         return _formatName(getSuperClassPath(param1));
      }
      
      public static function getSuperClassPackage(param1:*) : String
      {
         return _formatPackage(getSuperClassPath(param1));
      }
      
      public static function getSuperClassPath(param1:*) : String
      {
         return _formatPath(getQualifiedSuperclassName(param1));
      }
      
      public static function getTypeInfo(param1:*) : TypeInfo
      {
         return new _TypeInfo(param1);
      }
      
      public static function hasClassByName(param1:String) : Boolean
      {
         var c:Class = null;
         var name:String = param1;
         try
         {
            c = getClassByName(name);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public static function invokeClass(param1:Class, param2:Array = null) : *
      {
         var _loc3_:Array = null;
         if(param2 != null && param2.length > 0)
         {
            _loc3_ = param2;
            switch(_loc3_.length)
            {
               case 1:
                  return new param1(_loc3_[0]);
               case 2:
                  return new param1(_loc3_[0],_loc3_[1]);
               case 3:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2]);
               case 4:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3]);
               case 5:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4]);
               case 6:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5]);
               case 7:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6]);
               case 8:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7]);
               case 9:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8]);
               case 10:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9]);
               case 11:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10]);
               case 12:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11]);
               case 13:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12]);
               case 14:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13]);
               case 15:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14]);
               case 16:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15]);
               case 17:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16]);
               case 18:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17]);
               case 19:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18]);
               case 20:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19]);
               case 21:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20]);
               case 22:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21]);
               case 23:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22]);
               case 24:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23]);
               case 25:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23],_loc3_[24]);
               case 26:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23],_loc3_[24],_loc3_[25]);
               case 27:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23],_loc3_[24],_loc3_[25],_loc3_[26]);
               case 28:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23],_loc3_[24],_loc3_[25],_loc3_[26],_loc3_[27]);
               case 29:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23],_loc3_[24],_loc3_[25],_loc3_[26],_loc3_[27],_loc3_[28]);
               case 30:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23],_loc3_[24],_loc3_[25],_loc3_[26],_loc3_[27],_loc3_[28],_loc3_[29]);
               case 31:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23],_loc3_[24],_loc3_[25],_loc3_[26],_loc3_[27],_loc3_[28],_loc3_[29],_loc3_[30]);
               case 32:
                  return new param1(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3],_loc3_[4],_loc3_[5],_loc3_[6],_loc3_[7],_loc3_[8],_loc3_[9],_loc3_[10],_loc3_[11],_loc3_[12],_loc3_[13],_loc3_[14],_loc3_[15],_loc3_[16],_loc3_[17],_loc3_[18],_loc3_[19],_loc3_[20],_loc3_[21],_loc3_[22],_loc3_[23],_loc3_[24],_loc3_[25],_loc3_[26],_loc3_[27],_loc3_[28],_loc3_[29],_loc3_[30],_loc3_[31]);
               default:
                  throw new ArgumentError("Reflection.invokeClass() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.");
            }
         }
         else
         {
            return new param1();
         }
      }
   }
}
