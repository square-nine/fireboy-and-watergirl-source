package com.spilgames.api
{
   import flash.display.MovieClip;
   
   public class DataService extends MovieClip
   {
      
      private static const DATASERVICE:String = "Data";
      
      private static const TITLE:String = "title";
      
      private static const DESCRIPTION:String = "description";
      
      private static var callbackIndex:Object = {};
       
      
      public function DataService()
      {
         super();
      }
      
      public static function saveData(param1:XML, param2:Object = null, param3:Function = null) : int
      {
         if(!param1)
         {
            throw new Error("No XML data found to save.");
         }
         if(!param2)
         {
            param2 = {};
         }
         param2.title = param2.hasOwnProperty(TITLE) ? param2.title : "";
         param2.description = param2.hasOwnProperty(DESCRIPTION) ? param2.description : "";
         return SpilGamesServices.getInstance().send(DATASERVICE,"saveData",param3,{
            "userName":User.getUserName(),
            "userHash":User.getUserHash(),
            "data":param1,
            "options":param2
         });
      }
      
      public static function loadData(param1:int, param2:Function) : int
      {
         return SpilGamesServices.getInstance().send(DATASERVICE,"loadData",param2,{"dataID":param1});
      }
      
      public static function loadFriendsData(param1:Function) : int
      {
         var _loc2_:int = SpilGamesServices.getInstance().send(DATASERVICE,"loadFriendsData",loadFriendsDataCallback,{
            "userName":User.getUserName(),
            "userHash":User.getUserHash()
         });
         callbackIndex[_loc2_] = {"callbackFunc":param1};
         return _loc2_;
      }
      
      private static function loadFriendsDataCallback(param1:int, param2:Object) : void
      {
         var _loc3_:XMLList = null;
         var _loc4_:uint = 0;
         if(callbackIndex[param1])
         {
            if(param2.success)
            {
               param2.friendsData = [];
               _loc3_ = param2.xml.result;
               while(_loc4_ < _loc3_.length())
               {
                  param2.friendsData.push(new UserData(_loc3_[_loc4_]));
                  _loc4_++;
               }
            }
            callbackIndex[param1].callbackFunc(param1,param2);
            delete callbackIndex[param1];
         }
      }
      
      public static function getDataID(param1:Function, param2:String = "") : int
      {
         return SpilGamesServices.getInstance().send(DATASERVICE,"getDataID",param1,{
            "userName":User.getUserName(),
            "userHash":User.getUserHash(),
            "targetUser":param2
         });
      }
      
      public static function isAvailable() : Boolean
      {
         return SpilGamesServices.getInstance().isServiceAvailable(DATASERVICE);
      }
   }
}
