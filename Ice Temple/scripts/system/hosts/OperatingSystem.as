package system.hosts
{
   import system.Version;
   
   public class OperatingSystem
   {
       
      
      private var _platform:PlatformID;
      
      private var _version:Version;
      
      private var _signature:String;
      
      public function OperatingSystem(param1:PlatformID, param2:Version, param3:String = "")
      {
         super();
         _platform = param1;
         _version = param2;
         _signature = param3;
      }
      
      public function get platform() : PlatformID
      {
         return _platform;
      }
      
      public function get version() : Version
      {
         return _version;
      }
      
      public function get signature() : String
      {
         return _signature;
      }
      
      public function toString() : String
      {
         return platform.toString();
      }
   }
}
