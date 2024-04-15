package Playtomic
{
   public final class Data
   {
      
      private static var SECTION:String;
      
      private static var VIEWS:String;
      
      private static var PLAYS:String;
      
      private static var PLAYTIME:String;
      
      private static var CUSTOMMETRIC:String;
      
      private static var LEVELCOUNTERMETRIC:String;
      
      private static var LEVELRANGEDMETRIC:String;
      
      private static var LEVELAVERAGEMETRIC:String;
       
      
      public function Data()
      {
         super();
      }
      
      internal static function Initialise(param1:String) : void
      {
         SECTION = Encode.MD5("data-" + param1);
         VIEWS = Encode.MD5("data-views-" + param1);
         PLAYS = Encode.MD5("data-plays-" + param1);
         PLAYTIME = Encode.MD5("data-playtime-" + param1);
         CUSTOMMETRIC = Encode.MD5("data-custommetric-" + param1);
         LEVELCOUNTERMETRIC = Encode.MD5("data-levelcountermetric-" + param1);
         LEVELRANGEDMETRIC = Encode.MD5("data-levelrangedmetric-" + param1);
         LEVELAVERAGEMETRIC = Encode.MD5("data-levelaveragemetric-" + param1);
      }
      
      public static function Views(param1:Function, param2:Object = null) : void
      {
         General(VIEWS,"Views",param1,param2);
      }
      
      public static function Plays(param1:Function, param2:Object = null) : void
      {
         General(PLAYS,"Plays",param1,param2);
      }
      
      public static function PlayTime(param1:Function, param2:Object = null) : void
      {
         General(PLAYTIME,"Playtime",param1,param2);
      }
      
      private static function General(param1:String, param2:String, param3:Function, param4:Object) : void
      {
         if(param4 == null)
         {
            param4 = new Object();
         }
         var _loc5_:Object;
         (_loc5_ = new Object())["type"] = param2;
         _loc5_["day"] = param4.hasOwnProperty("day") ? param4["day"] : 0;
         _loc5_["month"] = param4.hasOwnProperty("month") ? param4["month"] : 0;
         _loc5_["year"] = param4.hasOwnProperty("year") ? param4["year"] : 0;
         PRequest.Load(SECTION,param1,GeneralComplete,param3,_loc5_);
      }
      
      private static function GeneralComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Object = new Object();
         if(param4.Success == 1)
         {
            _loc5_["Name"] = param2["type"];
            _loc5_["Day"] = param2["day"];
            _loc5_["Month"] = param2["month"];
            _loc5_["Year"] = param2["year"];
            _loc5_["Value"] = int(param3["value"]);
         }
         param1(_loc5_,param4);
      }
      
      public static function CustomMetric(param1:String, param2:Function, param3:Object = null) : void
      {
         if(param3 == null)
         {
            param3 = new Object();
         }
         var _loc4_:Object;
         (_loc4_ = new Object())["metric"] = param1;
         _loc4_["day"] = param3.hasOwnProperty("day") ? param3["day"] : 0;
         _loc4_["month"] = param3.hasOwnProperty("month") ? param3["month"] : 0;
         _loc4_["year"] = param3.hasOwnProperty("year") ? param3["year"] : 0;
         PRequest.Load(SECTION,CUSTOMMETRIC,CustomMetricComplete,param2,_loc4_);
      }
      
      private static function CustomMetricComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Object = new Object();
         if(param4.Success)
         {
            _loc5_["Name"] = "CustomMetric";
            _loc5_["Metric"] = param2["metric"];
            _loc5_["Day"] = param2["day"];
            _loc5_["Month"] = param2["month"];
            _loc5_["Year"] = param2["year"];
            _loc5_["Value"] = int(param3["value"]);
         }
         param1(_loc5_,param4);
      }
      
      public static function LevelCounterMetric(param1:String, param2:*, param3:Function, param4:Object = null) : void
      {
         LevelMetric(LEVELCOUNTERMETRIC,param1,param2,LevelCounterMetricComplete,param3,param4);
      }
      
      private static function LevelCounterMetricComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Object = new Object();
         if(param4.Success)
         {
            _loc5_["Name"] = "LevelAverageMetric";
            _loc5_["Metric"] = param2["metric"];
            _loc5_["Level"] = param2["level"];
            _loc5_["Day"] = param2["day"];
            _loc5_["Month"] = param2["month"];
            _loc5_["Year"] = param2["year"];
            _loc5_["Value"] = int(param3["value"]);
         }
         param1(_loc5_,param4);
      }
      
      public static function LevelRangedMetric(param1:String, param2:*, param3:Function, param4:Object = null) : void
      {
         LevelMetric(LEVELRANGEDMETRIC,param1,param2,LevelRangedMetricComplete,param3,param4);
      }
      
      private static function LevelRangedMetricComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         var _loc6_:Array = null;
         var _loc7_:XMLList = null;
         var _loc8_:XML = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Object = new Object();
         if(param4.Success)
         {
            _loc5_["Name"] = "LevelAverageMetric";
            _loc5_["Metric"] = param2["metric"];
            _loc5_["Level"] = param2["level"];
            _loc5_["Day"] = param2["day"];
            _loc5_["Month"] = param2["month"];
            _loc5_["Year"] = param2["year"];
            _loc6_ = new Array();
            _loc7_ = param3["value"];
            for each(_loc8_ in _loc7_)
            {
               _loc6_.push({
                  "TrackValue":int(_loc8_.@trackvalue),
                  "Value":int(_loc8_)
               });
            }
            _loc5_["Values"] = _loc6_;
         }
         param1(_loc5_,param4);
      }
      
      public static function LevelAverageMetric(param1:String, param2:*, param3:Function, param4:Object = null) : void
      {
         LevelMetric(LEVELAVERAGEMETRIC,param1,param2,LevelAverageMetricComplete,param3,param4);
      }
      
      private static function LevelAverageMetricComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Object = new Object();
         if(param4.Success)
         {
            _loc5_["Name"] = "LevelAverageMetric";
            _loc5_["Metric"] = param2["metric"];
            _loc5_["Level"] = param2["level"];
            _loc5_["Day"] = param2["day"];
            _loc5_["Month"] = param2["month"];
            _loc5_["Year"] = param2["year"];
            _loc5_["Min"] = int(param3["min"]);
            _loc5_["Max"] = int(param3["max"]);
            _loc5_["Average"] = int(param3["average"]);
            _loc5_["Total"] = Number(param3["total"]);
         }
         param1(_loc5_,param4);
      }
      
      private static function LevelMetric(param1:String, param2:String, param3:String, param4:Function, param5:Function, param6:Object) : void
      {
         if(param6 == null)
         {
            param6 = new Object();
         }
         var _loc7_:Object;
         (_loc7_ = new Object())["metric"] = param2;
         _loc7_["level"] = param3;
         _loc7_["day"] = param6.hasOwnProperty("day") ? param6["day"] : 0;
         _loc7_["month"] = param6.hasOwnProperty("month") ? param6["month"] : 0;
         _loc7_["year"] = param6.hasOwnProperty("year") ? param6["year"] : 0;
         PRequest.Load(SECTION,param1,param4,param5,_loc7_);
      }
   }
}
