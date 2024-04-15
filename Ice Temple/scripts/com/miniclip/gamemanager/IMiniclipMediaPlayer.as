package com.miniclip.gamemanager
{
   import flash.events.IEventDispatcher;
   
   public interface IMiniclipMediaPlayer extends IEventDispatcher
   {
       
      
      function destroy() : void;
      
      function playMedia() : void;
      
      function pouseMedia() : void;
      
      function stopMedia() : void;
      
      function muteOn() : void;
      
      function muteOff() : void;
      
      function get muteStatus() : String;
      
      function get mediaDuration() : Number;
      
      function get mediaTime() : Number;
      
      function get mediaProgress() : int;
      
      function get contentReady() : Boolean;
      
      function get playbackType() : String;
      
      function get contentType() : String;
   }
}
