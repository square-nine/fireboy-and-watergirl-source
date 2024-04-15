package com.miniclip.gamemanager
{
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   
   public class MiniclipTracking implements GameTracking
   {
       
      
      private var _uniqueID:uint;
      
      public function MiniclipTracking()
      {
         super();
         _uniqueID = _generate32bitRandom();
      }
      
      private function _generate32bitRandom() : int
      {
         return Math.round(Math.random() * 2147483647);
      }
      
      public function get uniqueID() : uint
      {
         return _uniqueID;
      }
      
      public function get sessionID() : String
      {
         return "thisisafazkesession";
      }
      
      public function get gameID() : uint
      {
         return 1808;
      }
      
      public function get userID() : uint
      {
         return 0;
      }
      
      public function get time() : int
      {
         return getTimer();
      }
      
      public function get timeStamp() : Number
      {
         var _loc1_:Date = new Date();
         return Math.round(_loc1_.time / 1000);
      }
      
      public function get locale() : String
      {
         return Capabilities.language;
      }
   }
}
