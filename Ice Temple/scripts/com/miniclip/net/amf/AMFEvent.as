package com.miniclip.net.amf
{
   import flash.events.Event;
   
   public class AMFEvent extends Event
   {
      
      public static const DATA:String = "data";
      
      public static const TIMEOUT:String = "timeout";
      
      public static const ERROR:String = "error";
       
      
      protected var _data:Object;
      
      public function AMFEvent(param1:String, param2:Object)
      {
         super(param1);
         _data = param2;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      override public function toString() : String
      {
         var _loc1_:* = "[AMFEvent: " + super.type + "[data: null ]]";
         if(_data != null)
         {
            _loc1_ = "[AMFEvent: " + super.type + "[data:" + _data.toString() + "]]";
         }
         return _loc1_;
      }
      
      override public function clone() : Event
      {
         return new AMFEvent(type,data);
      }
   }
}
