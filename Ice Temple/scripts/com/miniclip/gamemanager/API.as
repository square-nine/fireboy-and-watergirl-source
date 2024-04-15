package com.miniclip.gamemanager
{
   import core.version;
   
   public class API
   {
      
      public static var version:* = new core.version();
      
      {
         version.major = 3;
         version.minor = 8;
         version.build = 17;
         version.revision = "$Rev: 329 $ ".split(" ")[1];
      }
      
      public function API()
      {
         super();
      }
   }
}
