package Playtomic
{
   public final class Parse
   {
      
      private static var SECTION:String;
      
      private static var SAVE:String;
      
      private static var DELETE:String;
      
      private static var LOAD:String;
      
      private static var FIND:String;
       
      
      public function Parse()
      {
         super();
      }
      
      internal static function Initialise(param1:String) : void
      {
         SECTION = Encode.MD5("parse-" + param1);
         SAVE = Encode.MD5("parse-save-" + param1);
         DELETE = Encode.MD5("parse-delete-" + param1);
         LOAD = Encode.MD5("parse-load-" + param1);
         FIND = Encode.MD5("parse-find-" + param1);
      }
      
      public static function Save(param1:PFObject, param2:Function = null) : void
      {
         PRequest.Load(SECTION,SAVE,SaveComplete,param2,ObjectPostData(param1));
      }
      
      private static function SaveComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         var _loc8_:String = null;
         var _loc9_:XMLList = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:XMLList;
         var _loc6_:XML = (_loc5_ = param3["object"])[0];
         var _loc7_:PFObject;
         (_loc7_ = new PFObject()).ObjectId = _loc6_["id"];
         _loc7_.ClassName = param2["classname"];
         _loc7_.Password = param2["password"];
         for(_loc8_ in param2)
         {
            if(_loc8_.indexOf("data") == 0)
            {
               _loc7_.Data[_loc8_.substring(4)] = param2[_loc8_];
            }
         }
         if(param4.Success)
         {
            _loc9_ = param3["object"];
            _loc7_.CreatedAt = DateParse(_loc9_["created"]);
            _loc7_.UpdatedAt = DateParse(_loc9_["created"]);
         }
         param1(_loc7_,param4);
      }
      
      public static function Delete(param1:PFObject, param2:Function = null) : void
      {
         PRequest.Load(SECTION,DELETE,DeleteComplete,param2,ObjectPostData(param1));
      }
      
      private static function DeleteComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1(param4);
         param3 = param3;
         param2 = param2;
      }
      
      public static function Load(param1:String, param2:String, param3:Function = null) : void
      {
         var _loc4_:PFObject;
         (_loc4_ = new PFObject()).ObjectId = param1;
         _loc4_.ClassName = param2;
         PRequest.Load(SECTION,LOAD,LoadComplete,param3,ObjectPostData(_loc4_));
      }
      
      private static function LoadComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         var _loc6_:XMLList = null;
         var _loc7_:XMLList = null;
         var _loc8_:XML = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:PFObject;
         (_loc5_ = new PFObject()).ObjectId = param2["objectid"];
         _loc5_.ClassName = param2["classname"];
         if(param4.Success)
         {
            _loc6_ = param3["object"];
            _loc5_.CreatedAt = DateParse(_loc6_["created"]);
            _loc5_.UpdatedAt = DateParse(_loc6_["updated"]);
            if(_loc6_.contains("fields"))
            {
               _loc7_ = _loc6_["fields"];
               for each(_loc8_ in _loc7_.children())
               {
                  _loc5_[_loc8_.name] = _loc8_.text();
               }
            }
         }
         param1(_loc5_,param4);
      }
      
      public static function Find(param1:PFQuery, param2:Function = null) : void
      {
         var _loc4_:String = null;
         var _loc3_:Object = new Object();
         _loc3_["classname"] = param1.ClassName;
         _loc3_["limit"] = param1.Limit;
         _loc3_["order"] = param1.Order != null && param1.Order != "" ? param1.Order : "created_at";
         for(_loc4_ in param1.WhereData)
         {
            _loc3_["data" + _loc4_] = param1.WhereData[_loc4_];
         }
         PRequest.Load(SECTION,FIND,FindComplete,param2,_loc3_);
      }
      
      private static function FindComplete(param1:Function, param2:Object, param3:XML = null, param4:Response = null) : void
      {
         var _loc6_:XMLList = null;
         var _loc7_:XML = null;
         var _loc8_:PFObject = null;
         var _loc9_:XMLList = null;
         var _loc10_:XML = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Array = new Array();
         if(param4.Success)
         {
            _loc6_ = param3["objects"];
            for each(_loc7_ in _loc6_.children())
            {
               (_loc8_ = new PFObject()).ObjectId = _loc7_["id"];
               _loc8_.CreatedAt = DateParse(_loc7_["created"]);
               _loc8_.UpdatedAt = DateParse(_loc7_["updated"]);
               if(_loc7_.contains("fields"))
               {
                  _loc9_ = _loc7_["fields"];
                  for each(_loc10_ in _loc9_.children())
                  {
                     _loc8_[_loc10_.name] = _loc10_.text();
                  }
               }
               _loc5_.push(_loc8_);
            }
         }
         param1(_loc5_,param4);
         param2 = param2;
      }
      
      private static function ObjectPostData(param1:PFObject) : Object
      {
         var _loc3_:String = null;
         var _loc2_:Object = new Object();
         _loc2_["classname"] = param1.ClassName;
         _loc2_["id"] = param1.ObjectId == null ? "" : param1.ObjectId;
         _loc2_["password"] = param1.Password == null ? "" : param1.Password;
         for(_loc3_ in param1.Data)
         {
            _loc2_["data" + _loc3_] = param1.Data[_loc3_];
         }
         return _loc2_;
      }
      
      private static function DateParse(param1:String) : Date
      {
         var _loc2_:Array = param1.split(" ");
         var _loc3_:Array = (_loc2_[0] as String).split("/");
         var _loc4_:Array = (_loc2_[1] as String).split(":");
         var _loc5_:int = int(_loc3_[1]);
         var _loc6_:int = int(_loc3_[0]);
         var _loc7_:int = int(_loc3_[2]);
         var _loc8_:int = int(_loc4_[0]);
         var _loc9_:int = int(_loc4_[1]);
         var _loc10_:int = int(_loc4_[2]);
         return new Date(Date.UTC(_loc7_,_loc6_,_loc5_,_loc8_,_loc9_,_loc10_));
      }
   }
}
