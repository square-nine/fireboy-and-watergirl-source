package com.miniclip.media
{
   import com.miniclip.events.MiniclipMediaEvent;
   import com.miniclip.gamemanager.IMiniclipMediaPlayer;
   import flash.events.Event;
   
   public class MediaController implements IMiniclipMediaPlayer
   {
       
      
      private var _mediaPlayer:IMiniclipMediaPlayer;
      
      private var eventsAdded:Object;
      
      public function MediaController(param1:IMiniclipMediaPlayer)
      {
         super();
         _mediaPlayer = param1;
         _mediaPlayer.addEventListener(MiniclipMediaEvent.PLAYER_DESTROYED,_onPlayerDestroyed);
         eventsAdded = new Object();
      }
      
      public function destroy() : void
      {
         if(_mediaPlayer)
         {
            _mediaPlayer.destroy();
         }
      }
      
      public function muteOn() : void
      {
         if(_mediaPlayer)
         {
            _mediaPlayer.muteOn();
         }
      }
      
      public function muteOff() : void
      {
         if(_mediaPlayer)
         {
            _mediaPlayer.muteOff();
         }
      }
      
      public function get playbackType() : String
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.playbackType;
         }
         return PlaybackType.NOT_SET;
      }
      
      public function get contentType() : String
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.contentType;
         }
         return ContentType.NOT_SET;
      }
      
      public function get muteStatus() : String
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.muteStatus;
         }
         return MuteStatus.NO_VALID_SOUND;
      }
      
      public function playMedia() : void
      {
         if(_mediaPlayer)
         {
            _mediaPlayer.playMedia();
         }
      }
      
      public function pouseMedia() : void
      {
         if(_mediaPlayer)
         {
            _mediaPlayer.pouseMedia();
         }
      }
      
      public function stopMedia() : void
      {
         if(_mediaPlayer)
         {
            _mediaPlayer.stopMedia();
         }
      }
      
      public function get contentReady() : Boolean
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.contentReady;
         }
         return false;
      }
      
      public function get mediaDuration() : Number
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.mediaDuration;
         }
         return -1;
      }
      
      public function get mediaProgress() : int
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.mediaProgress;
         }
         return -1;
      }
      
      public function get mediaTime() : Number
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.mediaTime;
         }
         return -1;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(_mediaPlayer)
         {
            _mediaPlayer.addEventListener(param1,param2,param3,param4,true);
            recordEvents(param1,param2);
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(_mediaPlayer)
         {
            _mediaPlayer.removeEventListener(param1,param2,param3);
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.hasEventListener(param1);
         }
         return false;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         if(_mediaPlayer)
         {
            return _mediaPlayer.willTrigger(param1);
         }
         return false;
      }
      
      private function _onPlayerDestroyed(param1:MiniclipMediaEvent) : void
      {
         clearAllEvents();
         this._mediaPlayer = null;
      }
      
      private function recordEvents(param1:String, param2:Function) : void
      {
         if(!eventsAdded[param1])
         {
            eventsAdded[param1] = new Array();
         }
         eventsAdded[param1]["push"](param2);
      }
      
      private function clearAllEvents() : void
      {
         var _loc1_:String = null;
         var _loc2_:Function = null;
         for(_loc1_ in eventsAdded)
         {
            for each(_loc2_ in eventsAdded[_loc1_])
            {
               removeEventListener(_loc1_,_loc2_,false);
            }
            eventsAdded[_loc1_] = null;
         }
         eventsAdded = null;
      }
   }
}
