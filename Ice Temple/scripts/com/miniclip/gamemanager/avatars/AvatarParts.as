package com.miniclip.gamemanager.avatars
{
   public class AvatarParts
   {
      
      public static const everything:AvatarParts = new AvatarParts(0,"everything");
      
      public static const body:AvatarParts = new AvatarParts(16,"body");
      
      public static const skin:AvatarParts = new AvatarParts(17,"skin");
      
      public static const top:AvatarParts = new AvatarParts(18,"top");
      
      public static const bottom:AvatarParts = new AvatarParts(19,"bottom");
      
      public static const shoes:AvatarParts = new AvatarParts(20,"shoes");
      
      public static const head:AvatarParts = new AvatarParts(32,"head");
      
      public static const mouth:AvatarParts = new AvatarParts(33,"mouth");
      
      public static const eyes:AvatarParts = new AvatarParts(34,"eyes");
      
      public static const hair:AvatarParts = new AvatarParts(35,"hair");
      
      public static const glasses:AvatarParts = new AvatarParts(36,"glasses");
      
      public static const pet:AvatarParts = new AvatarParts(48,"pet");
      
      public static const extras:AvatarParts = new AvatarParts(64,"extras");
      
      public static const background:AvatarParts = new AvatarParts(80,"background");
       
      
      private var _value:uint;
      
      private var _name:String;
      
      public function AvatarParts(param1:uint, param2:String)
      {
         super();
         _value = param1;
         _name = param2;
      }
      
      public function toString() : String
      {
         return "AvatarParts." + _name;
      }
      
      public function valueOf() : uint
      {
         return _value;
      }
   }
}
