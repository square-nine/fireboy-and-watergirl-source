package Playtomic
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.net.SharedObject;
   
   public final class PlayerLevels
   {
      
      public static const NEWEST:String = "newest";
      
      public static const POPULAR:String = "popular";
      
      private static var KongAPI:* = null;
      
      private static var KongLevelReceiver:Function;
      
      private static var SECTION:String;
      
      private static var SAVE:String;
      
      private static var LIST:String;
      
      private static var LOAD:String;
      
      private static var RATE:String;
       
      
      public function PlayerLevels()
      {
         super();
      }
      
      internal static function Initialise(param1:String) : void
      {
         SECTION = Encode.MD5("playerlevels-" + param1);
         RATE = Encode.MD5("playerlevels-rate-" + param1);
         LIST = Encode.MD5("playerlevels-list-" + param1);
         SAVE = Encode.MD5("playerlevels-save-" + param1);
         LOAD = Encode.MD5("playerlevels-load-" + param1);
      }
      
      public static function DeferToKongregate(param1:*, param2:Function) : void
      {
         KongLevelReceiver = param2;
         KongAPI = param1;
         KongAPI.sharedContent.addLoadListener("level",KongLevelLoaded);
      }
      
      public static function LogStart(param1:String) : void
      {
         Log.PlayerLevelStart(param1);
      }
      
      public static function LogWin(param1:String) : void
      {
         Log.PlayerLevelWin(param1);
      }
      
      public static function LogQuit(param1:String) : void
      {
         Log.PlayerLevelQuit(param1);
      }
      
      public static function LogRetry(param1:String) : void
      {
         Log.PlayerLevelRetry(param1);
      }
      
      public static function Flag(param1:String) : void
      {
         Log.PlayerLevelFlag(param1);
      }
      
      public static function Rate(param1:String, param2:int, param3:Function = null) : void
      {
         var _loc4_:SharedObject;
         if((_loc4_ = SharedObject.getLocal("ratings")).data[param1] != null)
         {
            if(param3 != null)
            {
               param3(new Response(0,402));
            }
            return;
         }
         if(param2 < 0 || param2 > 10)
         {
            if(param3 != null)
            {
               param3(new Response(0,401));
            }
            return;
         }
         var _loc5_:Object;
         (_loc5_ = new Object())["levelid"] = param1;
         _loc5_["rating"] = param2;
         _loc4_.data[param1] = param2;
         PRequest.Load(SECTION,RATE,RateComplete,param3,_loc5_);
      }
      
      private static function RateComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1(param4);
         param3 = param3;
         param2 = param2;
      }
      
      public static function Load(param1:String, param2:Function = null) : void
      {
         var _loc3_:Object = new Object();
         _loc3_["levelid"] = param1;
         PRequest.Load(SECTION,LOAD,LoadComplete,param2,_loc3_);
      }
      
      private static function LoadComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:XMLList = null;
         var _loc12_:XML = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:PlayerLevel = null;
         if(param4.Success)
         {
            _loc7_ = (_loc6_ = XML(param3["level"]))["sdate"];
            _loc8_ = int(_loc7_.substring(_loc7_.lastIndexOf("/") + 1));
            _loc9_ = int(_loc7_.substring(0,_loc7_.indexOf("/")));
            _loc10_ = int(_loc7_.substring(_loc7_.indexOf("/") + 1).substring(0,2));
            (_loc5_ = new PlayerLevel()).LevelId = _loc6_["levelid"];
            _loc5_.PlayerName = _loc6_["playername"];
            _loc5_.PlayerId = _loc6_["playerid"];
            _loc5_.Name = _loc6_["name"];
            _loc5_.Score = _loc6_["score"];
            _loc5_.Votes = _loc6_["votes"];
            _loc5_.Rating = _loc6_["rating"];
            _loc5_.Data = _loc6_["data"];
            _loc5_.Wins = _loc6_["wins"];
            _loc5_.Starts = _loc6_["starts"];
            _loc5_.Retries = _loc6_["retries"];
            _loc5_.Quits = _loc6_["quits"];
            _loc5_.Flags = _loc6_["flags"];
            _loc5_.SDate = new Date(_loc8_,_loc9_ - 1,_loc10_);
            _loc5_.RDate = _loc6_["rdate"];
            _loc5_.SetThumb(_loc6_["thumb"]);
            if(_loc6_["custom"])
            {
               _loc11_ = _loc6_["custom"];
               for each(_loc12_ in _loc11_.children())
               {
                  _loc5_.CustomData[_loc12_.name()] = _loc12_.text();
               }
            }
         }
         param1(_loc5_,param4);
         param2 = param2;
      }
      
      public static function List(param1:Function = null, param2:Object = null) : void
      {
         var _loc13_:String = null;
         if(param2 == null)
         {
            param2 = new Object();
         }
         var _loc3_:String = param2.hasOwnProperty("mode") ? String(param2["mode"]) : "popular";
         var _loc4_:int = param2.hasOwnProperty("page") ? int(param2["page"]) : 1;
         var _loc5_:int = param2.hasOwnProperty("perpage") ? int(param2["perpage"]) : 20;
         var _loc6_:String = param2.hasOwnProperty("datemin") ? String(param2["datemin"]) : "";
         var _loc7_:String = param2.hasOwnProperty("datemax") ? String(param2["datemax"]) : "";
         var _loc8_:Boolean = param2.hasOwnProperty("data") ? Boolean(param2["data"]) : false;
         var _loc9_:Boolean = param2.hasOwnProperty("thumbs") ? Boolean(param2["thumbs"]) : false;
         var _loc10_:Object = param2.hasOwnProperty("customfilters") ? param2["customfilters"] : {};
         if(KongAPI != null)
         {
            if(_loc3_ == "popular")
            {
               KongAPI.sharedContent.browse("level",KongAPI.sharedContent.BY_RATING);
            }
            else
            {
               KongAPI.sharedContent.browse("level",KongAPI.sharedContent.BY_NEWEST);
            }
            return;
         }
         var _loc11_:Object;
         (_loc11_ = new Object())["mode"] = _loc3_;
         _loc11_["page"] = _loc4_;
         _loc11_["perpage"] = _loc5_;
         _loc11_["data"] = _loc8_ ? "y" : "n";
         _loc11_["thumbs"] = _loc9_ ? "y" : "n";
         _loc11_["datemin"] = _loc6_;
         _loc11_["datemax"] = _loc7_;
         var _loc12_:int = 0;
         if(_loc10_ != null)
         {
            for(_loc13_ in _loc10_)
            {
               _loc11_["ckey" + _loc12_] = _loc13_;
               _loc11_["cdata" + _loc12_] = _loc10_[_loc13_];
               _loc12_++;
            }
         }
         _loc11_["filters"] = _loc12_;
         PRequest.Load(SECTION,LIST,ListComplete,param1,_loc11_);
      }
      
      private static function ListComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         var _loc7_:XMLList = null;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:XML = null;
         var _loc14_:PlayerLevel = null;
         var _loc15_:XMLList = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         if(param4.Success)
         {
            _loc7_ = param3["level"];
            _loc6_ = int(param3["numresults"]);
            for each(_loc13_ in _loc7_)
            {
               _loc9_ = String(_loc13_["sdate"]);
               _loc10_ = int(_loc9_.substring(_loc9_.lastIndexOf("/") + 1));
               _loc11_ = int(_loc9_.substring(0,_loc9_.indexOf("/")));
               _loc12_ = int(_loc9_.substring(_loc9_.indexOf("/") + 1).substring(0,2));
               (_loc14_ = new PlayerLevel()).LevelId = _loc13_["levelid"];
               _loc14_.PlayerId = _loc13_["playerid"];
               _loc14_.PlayerName = _loc13_["playername"];
               _loc14_.Name = _loc13_["name"];
               _loc14_.Score = _loc13_["score"];
               _loc14_.Rating = _loc13_["rating"];
               _loc14_.Votes = _loc13_["votes"];
               _loc14_.Wins = _loc13_["wins"];
               _loc14_.Starts = _loc13_["starts"];
               _loc14_.Retries = _loc13_["retries"];
               _loc14_.Quits = _loc13_["quits"];
               _loc14_.Flags = _loc13_["flags"];
               _loc14_.SDate = new Date(_loc10_,_loc11_ - 1,_loc12_);
               _loc14_.RDate = _loc13_["rdate"];
               if(_loc13_["data"])
               {
                  _loc14_.Data = _loc13_["data"];
               }
               _loc14_.SetThumb(_loc13_["thumb"]);
               if((_loc15_ = _loc13_["custom"]) != null)
               {
                  for each(_loc8_ in _loc15_.children())
                  {
                     _loc14_.CustomData[_loc8_.name()] = _loc8_.text();
                  }
               }
               _loc5_.push(_loc14_);
            }
         }
         param1(_loc5_,_loc6_,param4);
         param2 = param2;
      }
      
      public static function Save(param1:PlayerLevel, param2:DisplayObject = null, param3:Function = null) : void
      {
         var postdata:Object;
         var customfields:int;
         var kcallback:Function = null;
         var scale:Number = NaN;
         var w:int = 0;
         var h:int = 0;
         var scaler:Matrix = null;
         var image:BitmapData = null;
         var key:String = null;
         var level:PlayerLevel = param1;
         var thumb:DisplayObject = param2;
         var callback:Function = param3;
         if(KongAPI != null)
         {
            kcallback = function(param1:Object):void
            {
               level.LevelId = param1["id"];
               level.Permalink = param1["permalink"];
               level.Name = param1["name"];
               if(callback != null)
               {
                  callback(level,new Response(!!param1["success"] ? 1 : 0,0));
               }
            };
            KongAPI.sharedContent.save("level",level.Data,kcallback,thumb,level.Name);
            return;
         }
         postdata = new Object();
         postdata["data"] = level.Data;
         postdata["playerid"] = level.PlayerId;
         postdata["playersource"] = level.PlayerSource;
         postdata["playername"] = level.PlayerName;
         postdata["name"] = level.Name;
         if(thumb != null)
         {
            scale = 1;
            w = thumb.width;
            h = thumb.height;
            if(thumb.width > 100 || thumb.height > 100)
            {
               if(thumb.width >= thumb.height)
               {
                  scale = 100 / thumb.width;
                  w = 100;
                  h = Math.ceil(scale * thumb.height);
               }
               else if(thumb.height > thumb.width)
               {
                  scale = 100 / thumb.height;
                  w = Math.ceil(scale * thumb.width);
                  h = 100;
               }
            }
            scaler = new Matrix();
            scaler.scale(scale,scale);
            image = new BitmapData(w,h,true,0);
            image.draw(thumb,scaler,null,null,null,true);
            postdata["image"] = Encode.Base64(Encode.PNG(image));
            postdata["arrp"] = RandomSample(image);
            postdata["hash"] = Encode.MD5(postdata["image"] + postdata["arrp"]);
         }
         else
         {
            postdata["nothumb"] = "y";
         }
         customfields = 0;
         if(level.CustomData != null)
         {
            for(key in level.CustomData)
            {
               postdata["ckey" + customfields] = key;
               postdata["cdata" + customfields] = level.CustomData[key];
               customfields++;
            }
         }
         postdata["customfields"] = customfields;
         PRequest.Load(SECTION,SAVE,SaveComplete,callback,postdata);
      }
      
      private static function SaveComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:PlayerLevel;
         (_loc5_ = new PlayerLevel()).Data = param2["data"];
         _loc5_.PlayerId = param2["playerid"];
         _loc5_.PlayerSource = param2["playersource"];
         _loc5_.PlayerName = param2["playername"];
         _loc5_.Name = param2["name"];
         for(_loc6_ in param2)
         {
            if(_loc6_.indexOf("ckey") == 0)
            {
               _loc7_ = _loc6_.substring(4);
               _loc8_ = String(param2["ckey" + _loc7_]);
               _loc9_ = String(param2["cdata" + _loc7_]);
               _loc5_.CustomData[_loc8_] = _loc9_;
            }
         }
         param2["data"] = _loc5_.Data;
         param2["playerid"] = _loc5_.PlayerId;
         param2["playersource"] = _loc5_.PlayerSource;
         param2["playername"] = _loc5_.PlayerName;
         param2["name"] = _loc5_.Name;
         if(param4.Success || param4.ErrorCode == 406)
         {
            _loc5_.LevelId = param3["levelid"];
            _loc5_.SDate = new Date();
            _loc5_.RDate = "Just now";
         }
         param1(_loc5_,param4);
      }
      
      private static function KongLevelLoaded(param1:Object) : void
      {
         var _loc2_:PlayerLevel = new PlayerLevel();
         _loc2_.Data = param1["content"];
         _loc2_.Permalink = param1["permalink"];
         _loc2_.Name = param1["name"];
         _loc2_.LevelId = param1["id"];
         if(KongLevelReceiver != null)
         {
            KongLevelReceiver(_loc2_);
         }
      }
      
      private static function RandomSample(param1:BitmapData) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc2_:Array = new Array();
         while(_loc2_.length < 10)
         {
            _loc3_ = Math.random() * param1.width;
            _loc4_ = Math.random() * param1.height;
            _loc5_ = param1.getPixel32(_loc3_,_loc4_).toString(16);
            while(_loc5_.length < 6)
            {
               _loc5_ = "0" + _loc5_;
            }
            _loc2_.push(_loc3_ + "/" + _loc4_ + "/" + _loc5_);
         }
         return _loc2_.join(",");
      }
   }
}
