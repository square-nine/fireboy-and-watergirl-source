package com.miniclip
{
   public class LibraryModules
   {
      
      public static var componentconfig:Object = {
         "name":"GameManagerComponent",
         "configfile":"component.txt",
         "gatewaypath":"/php/amfphp/gateway.php"
      };
      
      public static var gameconfig:Object = {"name":"Game"};
      
      public static var avatarconfig:Object = {
         "name":"AvatarLoader",
         "path":"/swf/components/",
         "file":"avatarloader.swf",
         "debugfile":"avatarloader_d.swf",
         "configfile":"avatarloader.txt",
         "allowLocal":true,
         "forceSecureConnection":false
      };
      
      public static var lobbyconfig:Object = {"name":"Lobby"};
       
      
      public function LibraryModules()
      {
         super();
      }
   }
}
