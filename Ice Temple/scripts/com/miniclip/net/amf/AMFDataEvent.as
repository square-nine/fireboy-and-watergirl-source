package com.miniclip.net.amf
{
   public class AMFDataEvent extends AMFEvent
   {
       
      
      public function AMFDataEvent(param1:Object)
      {
         super(DATA,param1);
      }
      
      override public function toString() : String
      {
         var _loc1_:* = "[AMFDataEvent: " + super.type + "[data: null ]]";
         if(_data != null)
         {
            _loc1_ = "[AMFDataEvent: " + super.type + "[data:" + _data.toString() + "]]";
         }
         return _loc1_;
      }
   }
}
