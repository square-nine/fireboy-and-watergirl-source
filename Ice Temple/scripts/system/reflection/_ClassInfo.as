package system.reflection
{
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import system.Reflection;
   
   public class _ClassInfo extends _TypeInfo implements ClassInfo
   {
       
      
      private var _class:XML;
      
      private var _filter:FilterType;
      
      public function _ClassInfo(param1:*, param2:FilterType)
      {
         super(param1);
         _class = describeType(param1);
         _filter = param2;
      }
      
      private function _getTraitMemberHelper(param1:MemberType) : Array
      {
         var _loc3_:XML = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:Array = [];
         var _loc4_:String = param1.toString();
         if(isInstance())
         {
            for(_loc5_ in _class[_loc4_])
            {
               _loc3_ = _class[_loc4_][_loc5_];
               if(!(!filter.showInherited && _loc3_.@declaredBy != undefined && !_isDeclaredLocaly(String(_loc3_.@declaredBy))))
               {
                  _loc2_.push(String(_loc3_.@name));
               }
            }
         }
         else
         {
            for(_loc6_ in _class.factory[_loc4_])
            {
               _loc3_ = _class.factory[_loc4_][_loc6_];
               if(!(!filter.showInherited && _loc3_.@declaredBy != undefined && !_isDeclaredLocaly(String(_loc3_.@declaredBy))))
               {
                  _loc2_.push(String(_loc3_.@name));
               }
            }
         }
         return _loc2_;
      }
      
      private function _hasInterface(param1:*) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:String = null;
         var _loc4_:XML = null;
         if(isInstance() && _class.hasOwnProperty("implementsInterface"))
         {
            _loc2_ = _class.implementsInterface;
         }
         else if(!isInstance() && _class.factory.hasOwnProperty("implementsInterface"))
         {
            _loc2_ = _class.factory.implementsInterface;
         }
         if(!(param1 is String))
         {
            param1 = getQualifiedClassName(param1);
         }
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = String(_loc4_.@type);
            if(_loc3_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function _inheritFrom(param1:*) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:String = null;
         var _loc4_:XML = null;
         if(isInstance() && _class.hasOwnProperty("extendsClass"))
         {
            _loc2_ = _class.extendsClass;
         }
         else if(!isInstance() && _class.factory.hasOwnProperty("extendsClass"))
         {
            _loc2_ = _class.factory.extendsClass;
         }
         if(!(param1 is String))
         {
            param1 = getQualifiedClassName(param1);
         }
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = String(_loc4_.@type);
            if(_loc3_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function _isDeclaredLocaly(param1:String) : Boolean
      {
         if(config.normalizePath)
         {
            param1 = _normalize(param1);
         }
         return name == param1;
      }
      
      private function _normalize(param1:String) : String
      {
         return param1.replace("::",".");
      }
      
      public function get accessors() : Array
      {
         return _getTraitMemberHelper(MemberType.accessor);
      }
      
      public function get constants() : Array
      {
         return _getTraitMemberHelper(MemberType.constant);
      }
      
      public function get filter() : FilterType
      {
         return _filter;
      }
      
      public function set filter(param1:FilterType) : void
      {
         _filter = param1;
      }
      
      public function get members() : Array
      {
         return null;
      }
      
      public function get methods() : Array
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:Array = [];
         if(filter.usePrototypeInfo)
         {
            if(isInstance())
            {
               for(_loc2_ in type)
               {
                  if(typeof type[_loc2_] == "function")
                  {
                     if(!(!filter.showInherited && (!type.hasOwnProperty(_loc2_) && !type.constructor.prototype.hasOwnProperty(_loc2_))))
                     {
                        _loc1_.push(_loc2_);
                     }
                  }
               }
            }
            else
            {
               for(_loc3_ in type.prototype)
               {
                  if(typeof type.prototype[_loc3_] == "function")
                  {
                     if(!(!filter.showInherited && !type.prototype.hasOwnProperty(_loc3_)))
                     {
                        _loc1_.push(_loc3_);
                     }
                  }
               }
            }
         }
         if(filter.useTraitInfo)
         {
            _loc1_ = _loc1_.concat(_getTraitMemberHelper(MemberType.method));
         }
         return _loc1_;
      }
      
      public function get name() : String
      {
         var _loc1_:String = _class.@name;
         if(config.normalizePath)
         {
            _loc1_ = _normalize(_loc1_);
         }
         return _loc1_;
      }
      
      public function get properties() : Array
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:Array = [];
         if(filter.usePrototypeInfo)
         {
            if(isInstance())
            {
               for(_loc2_ in type)
               {
                  if(typeof type[_loc2_] != "function")
                  {
                     if(!(!filter.showInherited && (!type.hasOwnProperty(_loc2_) && !type.constructor.prototype.hasOwnProperty(_loc2_))))
                     {
                        _loc1_.push(_loc2_);
                     }
                  }
               }
            }
            else
            {
               for(_loc3_ in type.prototype)
               {
                  if(typeof type.prototype[_loc3_] != "function")
                  {
                     if(!(!filter.showInherited && !type.prototype.hasOwnProperty(_loc3_)))
                     {
                        _loc1_.push(_loc3_);
                     }
                  }
               }
            }
         }
         if(filter.useTraitInfo)
         {
            _loc1_ = _loc1_.concat(variables);
            _loc1_ = _loc1_.concat(constants);
            _loc1_ = _loc1_.concat(accessors);
         }
         return _loc1_;
      }
      
      public function get superClass() : ClassInfo
      {
         var _loc2_:Class = null;
         var _loc1_:String = "";
         if(isInstance() && _class.hasOwnProperty("extendsClass"))
         {
            _loc1_ = _class.extendsClass[0].@type;
         }
         else if(!isInstance() && _class.factory.hasOwnProperty("extendsClass"))
         {
            _loc1_ = String(_class.factory.extendsClass[0].@type);
         }
         if(_loc1_ != "")
         {
            _loc2_ = Reflection.getClassByName(_loc1_);
            return new _ClassInfo(_loc2_,filter);
         }
         return null;
      }
      
      public function get variables() : Array
      {
         return _getTraitMemberHelper(MemberType.variable);
      }
      
      public function hasInterface(... rest) : Boolean
      {
         if(rest.length == 0)
         {
            return false;
         }
         var _loc2_:int = 0;
         while(_loc2_ < rest.length)
         {
            if(!_hasInterface(rest[_loc2_]))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function inheritFrom(... rest) : Boolean
      {
         if(rest.length == 0)
         {
            return false;
         }
         var _loc2_:int = 0;
         while(_loc2_ < rest.length)
         {
            if(!_inheritFrom(rest[_loc2_]))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function isDynamic() : Boolean
      {
         return _class.@isDynamic == "true";
      }
      
      public function isFinal() : Boolean
      {
         return _class.@isFinal == "true";
      }
      
      public function isInstance() : Boolean
      {
         return _class.@base != "Class";
      }
      
      public function isStatic() : Boolean
      {
         return _class.@isStatic == "true";
      }
      
      override public function toString() : String
      {
         return "[ClassInfo]";
      }
      
      public function toXML() : XML
      {
         return _class;
      }
   }
}
