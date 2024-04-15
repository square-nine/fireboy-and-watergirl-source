package system
{
   import flash.system.Capabilities;
   import system.hosts.Host;
   import system.hosts.HostID;
   import system.hosts.OperatingSystem;
   import system.hosts.PlatformID;
   
   public class _Environment
   {
       
      
      private var _host:Host = null;
      
      private var _os:OperatingSystem = null;
      
      public function _Environment()
      {
         super();
      }
      
      private function _getHostID() : HostID
      {
         var _loc1_:String = Capabilities.playerType;
         switch(_loc1_)
         {
            case "ActiveX":
            case "External":
            case "PlugIn":
            case "StandAlone":
               return HostID.Flash;
            case "Desktop":
               return HostID.Air;
            case "RedTamarin":
               return HostID.RedTamarin;
            case "AVMPlus":
               return HostID.Tamarin;
            default:
               return HostID.Unknown;
         }
      }
      
      private function _getHostVersion() : Version
      {
         var _loc1_:String = Strings.trimStart(Capabilities.version,"WINMACUNIX ".split(""));
         _loc1_ = _loc1_.split(",").join(".");
         return Version.fromString(_loc1_);
      }
      
      private function _getPlatformID() : PlatformID
      {
         var _loc1_:String = Capabilities.os;
         if(Strings.indexOfAny(_loc1_,["Windows","WIN","win32"]) > -1)
         {
            return PlatformID.Windows;
         }
         if(Strings.indexOfAny(_loc1_,["Macintosh","MAC","Mac OS","MacOS"]) > -1)
         {
            return PlatformID.Macintosh;
         }
         if(Strings.indexOfAny(_loc1_,["Linux","UNIX","unix"]) > -1)
         {
            return PlatformID.Unix;
         }
         if(Strings.indexOfAny(_loc1_,["arm"]) > -1)
         {
            return PlatformID.Arm;
         }
         if(Strings.indexOfAny(_loc1_,["web"]) > -1)
         {
            return PlatformID.Web;
         }
         return PlatformID.Unknown;
      }
      
      public function get host() : Host
      {
         if(_host)
         {
            return _host;
         }
         var _loc1_:HostID = _getHostID();
         var _loc2_:Version = _getHostVersion();
         _host = new Host(_loc1_,_loc2_);
         return _host;
      }
      
      public function get os() : OperatingSystem
      {
         if(_os)
         {
            return _os;
         }
         var _loc1_:PlatformID = _getPlatformID();
         var _loc2_:Version = new Version();
         var _loc3_:String = Capabilities.os;
         if(_loc1_ == PlatformID.Web)
         {
            _loc2_ = new Version(2,0);
         }
         _os = new OperatingSystem(_loc1_,_loc2_,_loc3_);
         return _os;
      }
      
      public function get newLine() : String
      {
         return "\n";
      }
   }
}
