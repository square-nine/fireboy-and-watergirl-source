package system.comparators
{
   import system.Comparator;
   
   public class StringComparator implements Comparator
   {
      
      public static const comparator:StringComparator = new StringComparator(false);
      
      public static const ignoreCaseComparator:StringComparator = new StringComparator(true);
       
      
      public var ignoreCase:Boolean;
      
      public function StringComparator(param1:Boolean = false)
      {
         super();
         this.ignoreCase = param1;
      }
      
      public function compare(param1:*, param2:*, param3:* = null) : int
      {
         var _loc4_:Number = NaN;
         param1 = param1.toString();
         param2 = param2.toString();
         if(param3 is Boolean)
         {
            ignoreCase = param3;
         }
         if(ignoreCase)
         {
            param1 = param1.toLowerCase();
            param2 = param2.toLowerCase();
         }
         if(param1 == param2)
         {
            return 0;
         }
         if(param1.length == param2.length)
         {
            if((_loc4_ = Number(param1.localeCompare(param2))) == 0)
            {
               return 0;
            }
            if(_loc4_ < 0)
            {
               return 1;
            }
            return -1;
         }
         if(param1.length > param2.length)
         {
            return 1;
         }
         return -1;
      }
   }
}
