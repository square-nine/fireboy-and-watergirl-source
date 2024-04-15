package com.miniclip.events
{
   import flash.events.Event;
   
   public class MiniclipMediaEvent extends Event
   {
      
      public static const PLAYER_READY:String = "mcplayerready";
      
      public static const PLAYER_ERROR:String = "mcplayererror";
      
      public static const PLAYBACK_START:String = "mcplaybackstart";
      
      public static const PLAYBACK_END:String = "mcplaybackend";
      
      public static const PLAYER_DESTROYED:String = "mcplayerdestroyed";
      
      public static const CONFIG_RECEIVED:String = "configreceived";
      
      public static const SOUND_STATUS_CHANGED:String = "soundchanged";
       
      
      private var _data:*;
      
      public function MiniclipMediaEvent(param1:String, param2:Object = null)
      {
         this._data = param2;
         super(param1,false,false);
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new MiniclipMediaEvent(super.type,this.data);
      }
   }
}
