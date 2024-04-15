package system.reflection
{
   public class _TypeInfo implements TypeInfo
   {
       
      
      protected var type:*;
      
      public function _TypeInfo(param1:*)
      {
         super();
         type = param1;
      }
      
      public function canConvertTo(param1:Class) : Boolean
      {
         return type as param1 != null;
      }
      
      public function isSubtypeOf(param1:Class) : Boolean
      {
         return type is param1;
      }
      
      public function toString() : String
      {
         return "[TypeInfo]";
      }
   }
}
