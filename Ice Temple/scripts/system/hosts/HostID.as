package system.hosts
{
   import system.Enum;
   
   public class HostID extends Enum
   {
      
      public static const Unknown:HostID = new HostID(0,"Unknown");
      
      public static const Flash:HostID = new HostID(1,"Flash");
      
      public static const Air:HostID = new HostID(2,"Air");
      
      public static const Tamarin:HostID = new HostID(3,"Tamarin");
      
      public static const RedTamarin:HostID = new HostID(4,"RedTamarin");
       
      
      public function HostID(param1:int, param2:String)
      {
         super(param1,param2);
      }
   }
}
