package Playtomic
{
   import flash.display.LoaderInfo;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.system.Security;
   import flash.utils.Timer;
   
   public final class Log
   {
      
      private static var Enabled:Boolean = false;
      
      private static var Queue:Boolean = true;
      
      internal static var SWFID:int = 0;
      
      internal static var GUID:String = "";
      
      internal static var SourceUrl:String;
      
      internal static var BaseUrl:String;
      
      private static var Cookie:SharedObject;
      
      internal static var LogQueue:LogRequest;
      
      private static const PingF:Timer = new Timer(1000);
      
      private static var Pings:int = 0;
      
      private static var Plays:int = 0;
      
      private static var Frozen:Boolean = false;
      
      private static var FrozenQueue:Array = new Array();
      
      private static var Customs:Array = new Array();
      
      private static var LevelCounters:Array = new Array();
      
      private static var LevelAverages:Array = new Array();
      
      private static var LevelRangeds:Array = new Array();
      
      internal static var UseSSL:Boolean = false;
      
      internal static var PEventsEnabled:Boolean = false;
      
      internal static var PData:Object = {};
      
      internal static var PersistantParams:Object = {};
      
      internal static var PTime:int = 0;
       
      
      public function Log()
      {
         super();
      }
      
      public static function SetSSL() : void
      {
         UseSSL = true;
         trace("You are now using SSL for your api requests.  This feature is for premium users only, if your account is not premium the data you send will be ignored.");
      }
      
      public static function SetReferrer(param1:String) : void
      {
         PRequest.SendReferrer(param1);
      }
      
      public static function View(param1:int = 0, param2:String = "", param3:String = "", param4:LoaderInfo = null) : void
      {
         var _loc5_:String = null;
         if(!param4)
         {
            _loc5_ = param3;
            param3 = "";
            trace("Warning: It looks like you are using the Log.View method from the old version of the API.");
            trace("Please update your Log.View call to use the new structure: ");
            trace("Log.View(swfid, guid, apikey, root.loaderInfo.loaderURL);");
            trace("You can get or create your API key from your game\'s settings page");
         }
         if(SWFID > 0)
         {
            return;
         }
         SWFID = param1;
         GUID = param2;
         Enabled = true;
         if(SWFID == 0 || GUID == "")
         {
            Enabled = false;
            return;
         }
         _loc5_ = param4.loaderURL;
         SourceUrl = GetUrl(_loc5_);
         if(SourceUrl == null || SourceUrl == "")
         {
            Enabled = false;
            return;
         }
         BaseUrl = SourceUrl.split("://")[1];
         BaseUrl = BaseUrl.substring(0,BaseUrl.indexOf("/"));
         Parse.Initialise(param3);
         GeoIP.Initialise(param3);
         Data.Initialise(param3);
         Leaderboards.Initialise(param3);
         GameVars.Initialise(param3);
         PlayerLevels.Initialise(param3);
         PRequest.Initialise();
         LogQueue = LogRequest.Create();
         Cookie = SharedObject.getLocal("playtomic");
         Security.loadPolicyFile((UseSSL ? "https://g" : "http://g") + param2 + ".api.playtomic.com/crossdomain.xml");
         if(_loc5_.indexOf("http://") != 0 && _loc5_.indexOf("https://") != 0)
         {
            if(Security.sandboxType != "localWithNetwork" && Security.sandboxType != "localTrusted" && Security.sandboxType != "remote")
            {
               Enabled = false;
               return;
            }
         }
         var _loc6_:int = GetCookie("views");
         Send("v/" + (_loc6_ + 1),true);
         PingF.addEventListener(TimerEvent.TIMER,PingServer);
         PingF.start();
         if(!PEventsEnabled)
         {
            return;
         }
         PData.source = BaseUrl;
         PData.views = _loc6_ + 1;
         PData.time = 0;
         PData.eventnum = 0;
         PData.location = "initialize";
         PData.api = "flash";
         PData.apiversion = "3.48";
         PData.params = {};
         SetSession();
         SendPEvent();
      }
      
      private static function SetSessionInfo(param1:String = "", param2:String = "", param3:String = "") : void
      {
         if(param1 != null && param1 != "")
         {
            SaveCookieS("sessionid",param1);
            PData.sessionid = param1;
         }
         if(param2 != null && param2 != "")
         {
            SaveCookieS("referredby",param2);
            PData.referredby = param2;
         }
         if(param3 != null && param3 != "")
         {
            SaveCookieS("invitedby",param3);
            PData.invitedby = param3;
         }
      }
      
      private static function SetSession() : void
      {
         var _loc1_:String = null;
         if(!PData.session)
         {
            _loc1_ = GetCookieS("session");
            if(_loc1_ != "")
            {
               PData.session = _loc1_;
            }
            else
            {
               PData.session = Encode.MD5(SessionID.Create() + SessionID.Create());
               SaveCookieS("session",PData.session);
            }
         }
         if(!PData.invitedby)
         {
            PData.invitedby = GetCookieS("invitedby");
         }
         if(!PData.referredby)
         {
            PData.referredby = GetCookieS("referredby");
         }
      }
      
      private static function PEvent(param1:Object, param2:String = null) : void
      {
         if(param2 != null)
         {
            PData.locationbefore = PData.location;
            PData.location = param2;
         }
         PData.timebefore = PData.time;
         PData.time = PTime;
         ++PData.eventnum;
         PData.params = param1;
         SendPEvent();
      }
      
      private static function PTransaction(param1:Object, param2:String, param3:Array) : void
      {
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc4_:Object = {};
         for(_loc5_ in param1)
         {
            _loc4_[_loc5_] = param1[_loc5_];
         }
         _loc6_ = 0;
         _loc7_ = 0;
         while(_loc7_ < param3.length)
         {
            if(!param3[_loc7_].hasOwnProperty("item"))
            {
               trace("** PEVENT ERROR ** Transaction is missing \'item\'.\nThe transactions array must be {item: \'name\', quantity: int, price: number, ... }");
               return;
            }
            if(!param3[_loc7_].hasOwnProperty("quantity"))
            {
               trace("** PEVENT ERROR ** Transaction is missing \'quantity\'.\nThe transactions array must be {item: \'name\', quantity: int, price: number, ... }");
               return;
            }
            if(!param3[_loc7_].hasOwnProperty("price"))
            {
               trace("** PEVENT ERROR ** Transaction is missing \'price\'.\nThe transactions array must be {item: \'name\', quantity: int, price: number, ... }");
               return;
            }
            _loc6_ += param3[_loc7_].price;
            _loc7_++;
         }
         _loc4_.transactions = param3;
         _loc4_.total = _loc6_;
         PData.transaction = true;
         PEvent(_loc4_,param2);
         delete PData.transaction;
      }
      
      private static function PInvitation(param1:Object, param2:String, param3:Array) : void
      {
         var _loc5_:String = null;
         var _loc4_:Object = {};
         for(_loc5_ in param1)
         {
            _loc4_[_loc5_] = param1[_loc5_];
         }
         _loc4_.invitations = param3;
         _loc4_.total = param3.length;
         PData.invitation = true;
         PEvent(_loc4_,param2);
         delete PData.invitation;
      }
      
      private static function SendPEvent() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in PersistantParams)
         {
            PData.params[_loc1_] = PersistantParams[_loc1_];
         }
         PRequest.SendPEvent(PData);
      }
      
      internal static function IncreaseViews() : void
      {
         var _loc1_:int = GetCookie("views");
         _loc1_++;
         SaveCookie("views",_loc1_);
      }
      
      internal static function IncreasePlays() : void
      {
         ++Plays;
      }
      
      public static function Play() : void
      {
         if(!Enabled)
         {
            return;
         }
         LevelCounters = new Array();
         LevelAverages = new Array();
         LevelRangeds = new Array();
         Send("p/" + (Plays + 1),true);
      }
      
      private static function PingServer(param1:TimerEvent) : void
      {
         if(!Enabled)
         {
            return;
         }
         ++PTime;
         if(PTime == 60)
         {
            Pings = 1;
            Send("t/y/1",true);
         }
         else if(PTime > 60 && PTime % 30 == 0)
         {
            ++Pings;
            Send("t/n/" + Pings,true);
         }
      }
      
      public static function CustomMetric(param1:String, param2:String = null, param3:Boolean = false) : void
      {
         if(!Enabled)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = "";
         }
         if(param3)
         {
            if(Customs.indexOf(param1) > -1)
            {
               return;
            }
            Customs.push(param1);
         }
         Send("c/" + Clean(param1) + "/" + Clean(param2));
      }
      
      public static function LevelCounterMetric(param1:String, param2:*, param3:Boolean = false) : void
      {
         var _loc4_:String = null;
         if(!Enabled)
         {
            return;
         }
         if(param3)
         {
            _loc4_ = param1 + "." + String(param2);
            if(LevelCounters.indexOf(_loc4_) > -1)
            {
               return;
            }
            LevelCounters.push(_loc4_);
         }
         Send("lc/" + Clean(param1) + "/" + Clean(param2));
      }
      
      public static function LevelRangedMetric(param1:String, param2:*, param3:int, param4:Boolean = false) : void
      {
         var _loc5_:String = null;
         if(!Enabled)
         {
            return;
         }
         if(param4)
         {
            _loc5_ = param1 + "." + String(param2) + "." + param3.toString();
            if(LevelRangeds.indexOf(_loc5_) > -1)
            {
               return;
            }
            LevelRangeds.push(_loc5_);
         }
         Send("lr/" + Clean(param1) + "/" + Clean(param2) + "/" + param3);
      }
      
      public static function LevelAverageMetric(param1:String, param2:*, param3:int, param4:Boolean = false) : void
      {
         var _loc5_:String = null;
         if(!Enabled)
         {
            return;
         }
         if(param4)
         {
            _loc5_ = param1 + "." + String(param2);
            if(LevelAverages.indexOf(_loc5_) > -1)
            {
               return;
            }
            LevelAverages.push(_loc5_);
         }
         Send("la/" + Clean(param1) + "/" + Clean(param2) + "/" + param3);
      }
      
      internal static function Link(param1:String, param2:String, param3:String, param4:int, param5:int, param6:int) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("l/" + Clean(param2) + "/" + Clean(param3) + "/" + Clean(param1) + "/" + param4 + "/" + param5 + "/" + param6);
      }
      
      public static function Heatmap(param1:String, param2:String, param3:int, param4:int) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("h/" + Clean(param1) + "/" + Clean(param2) + "/" + param3 + "/" + param4);
      }
      
      internal static function Funnel(param1:String, param2:String, param3:int) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("f/" + Clean(param1) + "/" + Clean(param2) + "/" + param3);
      }
      
      internal static function PlayerLevelStart(param1:String) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("pls/" + param1);
      }
      
      internal static function PlayerLevelWin(param1:String) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("plw/" + param1);
      }
      
      internal static function PlayerLevelQuit(param1:String) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("plq/" + param1);
      }
      
      internal static function PlayerLevelFlag(param1:String) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("plf/" + param1);
      }
      
      internal static function PlayerLevelRetry(param1:String) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("plr/" + param1);
      }
      
      public static function Freeze() : void
      {
         Frozen = true;
      }
      
      public static function UnFreeze() : void
      {
         if(!Enabled)
         {
            return;
         }
         Frozen = false;
         LogQueue.MassQueue(FrozenQueue);
      }
      
      public static function ForceSend() : void
      {
         if(!Enabled)
         {
            return;
         }
         if(LogQueue == null)
         {
            LogQueue = LogRequest.Create();
         }
         LogQueue.Send();
         LogQueue = LogRequest.Create();
         if(FrozenQueue.length > 0)
         {
            LogQueue.MassQueue(FrozenQueue);
         }
      }
      
      private static function Send(param1:String, param2:Boolean = false) : void
      {
         if(Frozen)
         {
            FrozenQueue.push(param1);
            return;
         }
         LogQueue.Queue(param1);
         if(LogQueue.ready || param2 || !Queue)
         {
            LogQueue.Send();
            LogQueue = LogRequest.Create();
         }
      }
      
      private static function Clean(param1:String) : String
      {
         while(param1.indexOf("/") > -1)
         {
            param1 = param1.replace("/","\\");
         }
         while(param1.indexOf("~") > -1)
         {
            param1 = param1.replace("~","-");
         }
         return escape(param1);
      }
      
      private static function GetCookie(param1:String) : int
      {
         if(Cookie.data[param1] == undefined)
         {
            return 0;
         }
         return int(Cookie.data[param1]);
      }
      
      private static function GetCookieS(param1:String) : String
      {
         if(Cookie.data[param1] == undefined)
         {
            return "";
         }
         return Cookie.data[param1];
      }
      
      private static function SaveCookie(param1:String, param2:int) : void
      {
         Cookie.data[param1] = param2.toString();
         try
         {
            Cookie.flush();
         }
         catch(s:Error)
         {
         }
      }
      
      private static function SaveCookieS(param1:String, param2:String) : void
      {
         Cookie.data[param1] = param2.toString();
         try
         {
            Cookie.flush();
         }
         catch(s:Error)
         {
         }
      }
      
      private static function GetUrl(param1:String) : String
      {
         var url:String = null;
         var defaulturl:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               url = String(ExternalInterface.call("window.location.href.toString"));
            }
            catch(s:Error)
            {
               url = defaulturl;
            }
         }
         else if(defaulturl.indexOf("http://") == 0 || defaulturl.indexOf("https://") == 0)
         {
            url = defaulturl;
         }
         if(url == null || url == "" || url == "null")
         {
            url = "http://localhost/";
         }
         if(url.indexOf("http://") != 0 && url.indexOf("https://") != 0)
         {
            url = "http://localhost/";
         }
         return url;
      }
   }
}
