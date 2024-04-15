package Playtomic
{
   public final class GameVars
   {
      
      private static var SECTION:String;
      
      private static var LOAD:String;
      
      private static var LOADSINGLE:String;
       
      
      public function GameVars()
      {
         super();
      }
      
      internal static function Initialise(param1:String) : void
      {
         SECTION = Encode.MD5("gamevars-" + param1);
         LOAD = Encode.MD5("gamevars-load-" + param1);
         LOADSINGLE = Encode.MD5("gamevars-loadsingle-" + param1);
      }
      
      public static function Load(param1:Function) : void
      {
         PRequest.Load(SECTION,LOAD,LoadComplete,param1,null);
      }
      
      public static function LoadSingle(param1:String, param2:Function) : void
      {
         var _loc3_:Object = new Object();
         _loc3_["name"] = param1;
         PRequest.Load(SECTION,LOADSINGLE,LoadComplete,param2,_loc3_);
      }
      
      private static function LoadComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         var _loc6_:XMLList = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:XML = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Object = new Object();
         if(param4.Success)
         {
            _loc6_ = param3["gamevar"];
            for each(_loc9_ in _loc6_)
            {
               _loc7_ = String(_loc9_["name"]);
               _loc8_ = _loc9_["value"];
               _loc5_[_loc7_] = _loc8_;
            }
         }
         param2 = param2;
         param1(_loc5_,param4);
      }
   }
}
