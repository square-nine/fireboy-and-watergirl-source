package system.serializers.eden
{
   import system.Serializable;
   import system.Serializer;
   
   public class EdenSerializer implements Serializer, Serializable
   {
       
      
      private var _prettyIndent:int = 0;
      
      private var _prettyPrinting:Boolean = false;
      
      private var _indentor:String = "    ";
      
      public function EdenSerializer()
      {
         super();
      }
      
      public function get prettyIndent() : int
      {
         return _prettyIndent;
      }
      
      public function get indentor() : String
      {
         return _indentor;
      }
      
      public function set indentor(param1:String) : void
      {
         _indentor = param1;
      }
      
      public function set prettyIndent(param1:int) : void
      {
         _prettyIndent = param1;
      }
      
      public function get prettyPrinting() : Boolean
      {
         return _prettyPrinting;
      }
      
      public function set prettyPrinting(param1:Boolean) : void
      {
         _prettyPrinting = param1;
      }
      
      public function addAuthorized(... rest) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = config.authorized as Array;
         if(_loc2_ != null)
         {
            _loc3_ = int(rest.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(!_loc2_.indexOf(rest[_loc4_]) > -1)
               {
                  _loc2_.push(rest[_loc4_]);
               }
               _loc4_++;
            }
            return;
         }
         throw new Error(this + " addAuthorized failed with a null \'authorized\' Array to configurate the eden parser.");
      }
      
      public function deserialize(param1:String) : *
      {
         return ECMAScript.evaluate(param1);
      }
      
      public function removeAuthorized(... rest) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         _loc2_ = [].concat(rest);
         var _loc5_:int = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if((_loc4_ = config.authorized.indexOf(_loc2_[_loc3_])) > -1)
            {
               config.authorized.splice(_loc4_,1);
            }
            _loc3_++;
         }
      }
      
      public function serialize(param1:*) : String
      {
         if(param1 === undefined)
         {
            return "undefined";
         }
         if(param1 === null)
         {
            return "null";
         }
         if(param1 is Serializable)
         {
            return param1.toSource(prettyIndent);
         }
         if(param1 is String)
         {
            return BuiltinSerializer.emitString(param1);
         }
         if(param1 is Boolean)
         {
            return !!param1 ? "true" : "false";
         }
         if(param1 is Number)
         {
            return param1.toString();
         }
         if(param1 is Date)
         {
            return BuiltinSerializer.emitDate(param1);
         }
         if(param1 is Array)
         {
            return BuiltinSerializer.emitArray(param1);
         }
         if(param1 is Object)
         {
            return BuiltinSerializer.emitObject(param1);
         }
         return "<unknown>";
      }
      
      public function toSource(param1:int = 0) : String
      {
         return info(false,false);
      }
   }
}
