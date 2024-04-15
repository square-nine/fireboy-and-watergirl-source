package com.miniclip.gamemanager.avatars
{
   public class AvatarBitmapType
   {
      
      public static const cropped:AvatarBitmapType = new AvatarBitmapType(2,"cropped");
      
      public static const fullbody:AvatarBitmapType = new AvatarBitmapType(1,"fullbody");
       
      
      private var _value:uint;
      
      private var _name:String;
      
      public function AvatarBitmapType(param1:uint, param2:String)
      {
         super();
         _value = param1;
         _name = param2;
      }
      
      public function toString() : String
      {
         return "AvatarBitmapType." + _name;
      }
      
      public function valueOf() : uint
      {
         return _value;
      }
   }
}
