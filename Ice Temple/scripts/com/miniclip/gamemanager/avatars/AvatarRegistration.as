package com.miniclip.gamemanager.avatars
{
   public class AvatarRegistration
   {
      
      public static const origin:AvatarRegistration = new AvatarRegistration(0,"origin",0,0);
      
      public static const head:AvatarRegistration = new AvatarRegistration(1,"head",590 / 2,10);
      
      public static const neck:AvatarRegistration = new AvatarRegistration(2,"neck",590 / 2,84);
      
      public static const center:AvatarRegistration = new AvatarRegistration(3,"center",590 / 2,200 / 2);
      
      public static const feet:AvatarRegistration = new AvatarRegistration(4,"feet",590 / 2,200 - 10);
       
      
      private var _value:uint;
      
      private var _name:String;
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function AvatarRegistration(param1:uint, param2:String, param3:Number, param4:Number)
      {
         super();
         _value = param1;
         _name = param2;
         _x = param3;
         _y = param4;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function toString() : String
      {
         return "AvatarRegistration." + _name;
      }
      
      public function valueOf() : uint
      {
         return _value;
      }
   }
}
