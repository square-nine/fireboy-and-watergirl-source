package com.miniclip.gamemanager
{
   import com.miniclip.gamemanager.avatars.AvatarBitmapType;
   import flash.events.IEventDispatcher;
   
   public interface GameAvatars extends IEventDispatcher
   {
       
      
      function get debugMarkers() : Boolean;
      
      function set debugMarkers(param1:Boolean) : void;
      
      function get allowDuplicates() : Boolean;
      
      function set allowDuplicates(param1:Boolean) : void;
      
      function load(param1:uint, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : YoMe;
      
      function loadBitmap(param1:uint, param2:Number = 200, param3:Number = 200, param4:AvatarBitmapType = null) : YoMeBitmap;
   }
}
