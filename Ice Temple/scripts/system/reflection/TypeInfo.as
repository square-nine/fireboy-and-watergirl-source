package system.reflection
{
   public interface TypeInfo
   {
       
      
      function canConvertTo(param1:Class) : Boolean;
      
      function isSubtypeOf(param1:Class) : Boolean;
   }
}
