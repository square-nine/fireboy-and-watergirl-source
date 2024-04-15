package system.reflection
{
   import system.Enum;
   
   public class MemberType extends Enum
   {
      
      public static const variable:MemberType = new MemberType(1,"variable");
      
      public static const constant:MemberType = new MemberType(2,"constant");
      
      public static const accessor:MemberType = new MemberType(3,"accessor");
      
      public static const method:MemberType = new MemberType(4,"method");
       
      
      public function MemberType(param1:int = 0, param2:String = "")
      {
         super(param1,param2);
      }
   }
}
