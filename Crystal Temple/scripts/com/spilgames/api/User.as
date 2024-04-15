package com.spilgames.api
{
   import flash.display.DisplayObject;
   
   public class User
   {
       
      
      public function User()
      {
         super();
      }
      
      public static function isGuest() : Boolean
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:Object = null;
         var _loc1_:Boolean = true;
         var _loc2_:* = SpilGamesServices.getInstance().connection;
         if(_loc2_ != null)
         {
            _loc1_ = Boolean(_loc2_.isGuest());
         }
         else
         {
            _loc3_ = SpilGamesServices.getInstance().root;
            if(Boolean(_loc3_) && Boolean(_loc3_.loaderInfo))
            {
               _loc1_ = !(_loc4_ = _loc3_.loaderInfo.parameters).username || _loc4_.username == "" || !_loc4_.hash || _loc4_.hash == "";
            }
            else
            {
               _loc1_ = false;
            }
         }
         return _loc1_;
      }
      
      public static function isLoggedIn() : Boolean
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:Object = null;
         var _loc1_:Boolean = false;
         var _loc2_:* = SpilGamesServices.getInstance().connection;
         if(_loc2_ != null)
         {
            _loc1_ = Boolean(_loc2_.isLoggedIn());
         }
         else
         {
            _loc3_ = SpilGamesServices.getInstance().root;
            if(Boolean(_loc3_) && Boolean(_loc3_.loaderInfo))
            {
               _loc1_ = Boolean((_loc4_ = _loc3_.loaderInfo.parameters).username) && Boolean(_loc4_.hash);
            }
            else
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public static function getUserName() : String
      {
         var _loc1_:String = "";
         var _loc2_:* = SpilGamesServices.getInstance().connection;
         if(_loc2_ != null)
         {
            _loc1_ = String(_loc2_.getUserName());
         }
         return _loc1_;
      }
      
      public static function getUserHash() : String
      {
         var _loc1_:String = "";
         var _loc2_:* = SpilGamesServices.getInstance().connection;
         if(_loc2_ != null)
         {
            _loc1_ = String(_loc2_.getUserHash());
         }
         return _loc1_;
      }
      
      public static function isAvailable() : Boolean
      {
         return Boolean(SpilGamesServices.getInstance().root) && Boolean(SpilGamesServices.getInstance().root.loaderInfo);
      }
   }
}
