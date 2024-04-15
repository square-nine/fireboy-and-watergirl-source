package system.hosts
{
   import flash.system.Capabilities;
   import system.Version;
   
   public class Host
   {
       
      
      private var _id:HostID;
      
      private var _version:Version;
      
      public function Host(param1:HostID, param2:Version)
      {
         super();
         _id = param1;
         _version = param2;
      }
      
      public function get id() : HostID
      {
         return _id;
      }
      
      public function get version() : Version
      {
         return _version;
      }
      
      public function isDebug() : Boolean
      {
         return Capabilities.isDebugger;
      }
      
      public function toString() : String
      {
         return id.toString() + " " + version.toString(4);
      }
   }
}
