package com.spilgames.api
{
   import flash.display.MovieClip;
   
   public class AwardsService extends MovieClip
   {
      
      private static const AWARDS:String = "Awards";
       
      
      public function AwardsService()
      {
         super();
      }
      
      public static function submitAward(param1:Object, param2:Function = null) : int
      {
         return SpilGamesServices.getInstance().send(AWARDS,"submitAward",param2,{
            "tag":param1,
            "userName":User.getUserName(),
            "userHash":User.getUserHash()
         });
      }
      
      public static function isAvailable() : Boolean
      {
         return SpilGamesServices.getInstance().isServiceAvailable(AWARDS);
      }
   }
}
