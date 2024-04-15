package system.reflection
{
   import system.Enum;
   
   public class FilterType extends Enum
   {
      
      public static const none:FilterType = new FilterType(0,"none");
      
      public static const prototypeOnly:FilterType = new FilterType(1,"prototypeOnly");
      
      public static const traitOnly:FilterType = new FilterType(2,"traitOnly");
      
      public static const declaredOnly:FilterType = new FilterType(16,"declaredOnly");
      
      public static const includeStatic:FilterType = new FilterType(256,"includeStatic");
       
      
      public function FilterType(param1:int = 0, param2:String = "")
      {
         super(param1,param2);
      }
      
      public function get usePrototypeInfo() : Boolean
      {
         return (valueOf() & 15) < 2;
      }
      
      public function get useTraitInfo() : Boolean
      {
         return (valueOf() & 15) != 1;
      }
      
      public function get showDeclared() : Boolean
      {
         return (valueOf() & 240) >>> 4 <= 1;
      }
      
      public function get showInherited() : Boolean
      {
         return (valueOf() & 240) >>> 4 == 0;
      }
      
      public function get showStatic() : Boolean
      {
         return (valueOf() & 3840) >>> 8 != 0;
      }
   }
}
