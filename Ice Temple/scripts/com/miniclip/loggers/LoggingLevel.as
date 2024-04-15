package com.miniclip.loggers
{
   public class LoggingLevel
   {
      
      public static const nothing:LoggingLevel = new LoggingLevel(0,"nothing");
      
      public static const errors:LoggingLevel = new LoggingLevel(1,"errors");
      
      public static const warnings:LoggingLevel = new LoggingLevel(2,"warnings");
      
      public static const infos:LoggingLevel = new LoggingLevel(3,"infos");
      
      public static const debugging:LoggingLevel = new LoggingLevel(4,"debugging");
      
      public static const everything:LoggingLevel = new LoggingLevel(5,"everything");
       
      
      private var _value:int;
      
      private var _name:String;
      
      public function LoggingLevel(param1:int = 0, param2:String = "")
      {
         super();
         _value = param1;
         _name = param2;
      }
      
      public function toString() : String
      {
         return _name;
      }
      
      public function valueOf() : int
      {
         return _value;
      }
   }
}
