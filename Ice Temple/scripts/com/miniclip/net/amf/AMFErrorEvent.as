package com.miniclip.net.amf
{
   import flash.events.Event;
   
   public class AMFErrorEvent extends AMFEvent
   {
       
      
      private var _code:String;
      
      private var _description:String;
      
      public function AMFErrorEvent(param1:Object)
      {
         super(ERROR,param1);
         if(param1 != null)
         {
            if(param1.code != null)
            {
               _code = param1.code;
            }
            if(param1.description != null)
            {
               _description = param1.description;
            }
         }
      }
      
      public function get code() : Object
      {
         return _code;
      }
      
      public function get description() : Object
      {
         return _description;
      }
      
      override public function toString() : String
      {
         var _loc2_:String = null;
         var _loc1_:Array = new Array();
         for(_loc2_ in _data)
         {
            _loc1_.push(_loc2_ + ": " + _data[_loc2_]);
         }
         return "[ AMFErrorEvent: " + _loc1_.join(", ") + " ]";
      }
      
      override public function clone() : Event
      {
         return new AMFErrorEvent({
            "code":_code,
            "description":_description
         });
      }
   }
}
