package com.spilgames.api
{
   public class BuildVersion
   {
      
      public static const BUILD_NUMBER:String = getBuildNumber();
      
      public static const VERSION_MAJOR:int = 1;
      
      public static const VERSION_MINOR:int = 3;
      
      public static const VERSION_BUILD:int = 1;
       
      
      public function BuildVersion()
      {
         super();
      }
      
      private static function getBuildNumber() : String
      {
         return VERSION_MAJOR + "." + VERSION_MINOR + "." + VERSION_BUILD;
      }
   }
}
