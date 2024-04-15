package system.hosts
{
   import system.Enum;
   
   public class PlatformID extends Enum
   {
      
      public static const Unknown:PlatformID = new PlatformID(0,"Unknown");
      
      public static const Web:PlatformID = new PlatformID(1,"Web");
      
      public static const Windows:PlatformID = new PlatformID(2,"Windows");
      
      public static const Macintosh:PlatformID = new PlatformID(3,"Macintosh");
      
      public static const Unix:PlatformID = new PlatformID(4,"Unix");
      
      public static const Arm:PlatformID = new PlatformID(5,"Arm");
       
      
      public function PlatformID(param1:int, param2:String)
      {
         super(param1,param2);
      }
   }
}
