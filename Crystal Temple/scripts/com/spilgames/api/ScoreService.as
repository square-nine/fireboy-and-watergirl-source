package com.spilgames.api
{
   import flash.display.MovieClip;
   
   public class ScoreService extends MovieClip
   {
      
      private static const SCORE:String = "Score";
       
      
      public function ScoreService()
      {
         super();
      }
      
      public static function submitScore(param1:Object, param2:Function = null) : int
      {
         return SpilGamesServices.getInstance().send(SCORE,"submitScore",param2,{
            "score":param1,
            "userName":User.getUserName(),
            "userHash":User.getUserHash()
         });
      }
      
      public static function isAvailable() : Boolean
      {
         return SpilGamesServices.getInstance().isServiceAvailable(SCORE);
      }
   }
}
