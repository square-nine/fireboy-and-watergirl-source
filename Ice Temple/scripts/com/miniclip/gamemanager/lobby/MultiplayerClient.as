package com.miniclip.gamemanager.lobby
{
   import com.miniclip.logger;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.FileReference;
   
   public dynamic class MultiplayerClient implements IEventDispatcher, SmartFoxPro
   {
      
      public static const MODMSG_TO_USER:String = "u";
      
      public static const MODMSG_TO_ROOM:String = "r";
      
      public static const MODMSG_TO_ZONE:String = "z";
      
      public static const XTMSG_TYPE_XML:String = "xml";
      
      public static const XTMSG_TYPE_STR:String = "str";
      
      public static const XTMSG_TYPE_JSON:String = "json";
      
      public static const CONNECTION_MODE_DISCONNECTED:String = "disconnected";
      
      public static const CONNECTION_MODE_SOCKET:String = "socket";
      
      public static const CONNECTION_MODE_HTTP:String = "http";
       
      
      private var _client:*;
      
      private var _debug:Boolean;
      
      public function MultiplayerClient(param1:*, param2:Boolean = false)
      {
         super();
         _client = param1;
         _debug = param2;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(_debug)
         {
            logger.log("MultiplayerClient.addEventListener( " + arguments.join(",") + " )");
         }
         _client.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(_debug)
         {
            logger.log("MultiplayerClient.removeEventListener( " + arguments.join(",") + " )");
         }
         _client.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         if(_debug)
         {
            logger.log("MultiplayerClient.dispatchEvent( " + arguments.join(",") + " )");
         }
         return _client.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         if(_debug)
         {
            logger.log("MultiplayerClient.hasEventListener( " + arguments.join(",") + " )");
         }
         return _client.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         if(_debug)
         {
            logger.log("MultiplayerClient.willTrigger( " + arguments.join(",") + " )");
         }
         return _client.willTrigger(param1);
      }
      
      public function toString() : String
      {
         return "[object MultiplayerClient]";
      }
      
      public function valueOf() : *
      {
         return _client;
      }
      
      public function get activeRoomId() : int
      {
         return _client.activeRoomId;
      }
      
      public function set activeRoomId(param1:int) : void
      {
         _client.activeRoomId = param1;
      }
      
      public function get amIModerator() : Boolean
      {
         return _client.amIModerator;
      }
      
      public function get myUserId() : int
      {
         return _client.myUserId;
      }
      
      public function set myUserId(param1:int) : void
      {
         _client.myUserId = param1;
      }
      
      public function get myUserName() : String
      {
         return _client.myUserName;
      }
      
      public function set myUserName(param1:String) : void
      {
         _client.myUserName = param1;
      }
      
      public function get playerId() : int
      {
         return _client.playerId;
      }
      
      public function get buddyList() : Array
      {
         return _client.buddyList;
      }
      
      public function get httpPort() : int
      {
         return _client.httpPort;
      }
      
      public function get debug() : Boolean
      {
         return _client.debug;
      }
      
      public function set debug(param1:Boolean) : void
      {
         _client.debug = param1;
      }
      
      public function get isConnected() : Boolean
      {
         return _client.isConnected;
      }
      
      public function set isConnected(param1:Boolean) : void
      {
         _client.isConnected = param1;
      }
      
      public function autoJoin() : void
      {
         _client.autoJoin();
      }
      
      public function createRoom(param1:Object, param2:int = -1) : void
      {
         _client.createRoom(param1,param2);
      }
      
      public function disconnect() : void
      {
         _client.disconnect();
      }
      
      public function getActiveRoom() : *
      {
         return _client.getActiveRoom();
      }
      
      public function getAllRooms() : Array
      {
         return _client.getAllRooms();
      }
      
      public function getBuddyRoom(param1:Object) : void
      {
         _client.getBuddyRoom(param1);
      }
      
      public function getRoom(param1:int) : *
      {
         return _client.getRoom(param1);
      }
      
      public function getRoomByName(param1:String) : *
      {
         return _client.getRoomByName(param1);
      }
      
      public function getRoomList() : void
      {
         _client.getRoomList();
      }
      
      public function getVersion() : String
      {
         return _client.getVersion();
      }
      
      public function joinRoom(param1:*, param2:String = "", param3:Boolean = false, param4:Boolean = false, param5:int = -1) : void
      {
         _client.joinRoom(param1,param2,param3,param4,param5);
      }
      
      public function leaveRoom(param1:int) : void
      {
         _client.leaveRoom(param1);
      }
      
      public function loadBuddyList() : void
      {
         _client.loadBuddyList();
      }
      
      public function login(param1:String, param2:String, param3:String) : void
      {
         _client.login(param1,param2,param3);
      }
      
      public function logout() : void
      {
         _client.logout();
      }
      
      public function roundTripBench() : void
      {
         _client.roundTripBench();
      }
      
      public function sendObject(param1:Object, param2:int = -1) : void
      {
         _client.sendObject(param1,param2);
      }
      
      public function sendObjectToGroup(param1:Object, param2:Array, param3:int = -1) : void
      {
         _client.sendObjectToGroup(param1,param2,param3);
      }
      
      public function sendPrivateMessage(param1:String, param2:int, param3:int = -1) : void
      {
         _client.sendPrivateMessage(param1,param2,param3);
      }
      
      public function sendPublicMessage(param1:String, param2:int = -1) : void
      {
         _client.sendPublicMessage(param1,param2);
      }
      
      public function setRoomVariables(param1:Array, param2:int = -1, param3:Boolean = true) : void
      {
         _client.setRoomVariables(param1,param2,param3);
      }
      
      public function setUserVariables(param1:Object, param2:int = -1) : void
      {
         _client.setUserVariables(param1,param2);
      }
      
      public function switchSpectator(param1:int = -1) : void
      {
         _client.switchSpectator(param1);
      }
      
      public function sendModeratorMessage(param1:String, param2:String, param3:int = -1) : void
      {
         _client.sendModeratorMessage(param1,param2,param3);
      }
      
      public function getUploadPath() : String
      {
         return _client.getUploadPath();
      }
      
      public function uploadFile(param1:FileReference, param2:int = -1, param3:String = "", param4:int = -1) : void
      {
         _client.uploadFile(param1,param2,param3,param4);
      }
      
      public function addBuddy(param1:String) : void
      {
         _client.addBuddy(param1);
      }
      
      public function clearBuddyList() : void
      {
         _client.clearBuddyList();
      }
      
      public function connect(param1:String, param2:int = 9339) : void
      {
         _client.connect(param1,param2);
      }
      
      public function removeBuddy(param1:String) : void
      {
         _client.removeBuddy(param1);
      }
      
      public function setBuddyVariables(param1:Array) : void
      {
         _client.setBuddyVariables(param1);
      }
      
      public function get defaultZone() : String
      {
         return _client.defaultZone;
      }
      
      public function get ipAddress() : String
      {
         return _client.ipAddress;
      }
      
      public function get port() : int
      {
         return _client.port;
      }
      
      public function get blueBoxIpAddress() : String
      {
         return _client.blueBoxIpAddress;
      }
      
      public function get blueBoxPort() : Number
      {
         return _client.blueBoxPort;
      }
      
      public function get myBuddyVars() : Array
      {
         return _client.myBuddyVars;
      }
      
      public function get smartConnect() : Boolean
      {
         return _client.smartConnect;
      }
      
      public function get rawProtocolSeparator() : String
      {
         return _client.rawProtocolSeparator;
      }
      
      public function set rawProtocolSeparator(param1:String) : void
      {
         _client.rawProtocolSeparator = param1;
      }
      
      public function get httpPollSpeed() : int
      {
         return _client.httpPollSpeed;
      }
      
      public function set httpPollSpeed(param1:int) : void
      {
         _client.httpPollSpeed = param1;
      }
      
      public function getRandomKey() : void
      {
         _client.getRandomKey();
      }
      
      public function sendXtMessage(param1:String, param2:String, param3:*, param4:String = "xml", param5:int = -1) : void
      {
         if(_debug)
         {
            logger.log("MultiplayerClient.sendXtMessage( " + arguments.join(",") + " )");
         }
         _client.sendXtMessage(param1,param2,param3,param4,param5);
      }
      
      public function getBuddyById(param1:int) : Object
      {
         return _client.getBuddyById(param1);
      }
      
      public function getBuddyByName(param1:String) : Object
      {
         return _client.getBuddyByName(param1);
      }
      
      public function getConnectionMode() : String
      {
         return _client.getConnectionMode();
      }
      
      public function loadConfig(param1:String = "config.xml", param2:Boolean = true) : void
      {
         _client.loadConfig(param1,param2);
      }
      
      public function sendBuddyPermissionResponse(param1:Boolean, param2:String) : void
      {
         _client.sendBuddyPermissionResponse(param1,param2);
      }
      
      public function setBuddyBlockStatus(param1:String, param2:Boolean) : void
      {
         _client.setBuddyBlockStatus(param1,param2);
      }
   }
}
