package com.miniclip.gamemanager
{
   import com.miniclip.events.GameChatEvent;
   import flash.events.EventDispatcher;
   
   public class MiniclipChat extends EventDispatcher implements GameChat
   {
       
      
      public function MiniclipChat()
      {
         super();
      }
      
      public function init() : void
      {
         dispatchEvent(new GameChatEvent(GameChatEvent.LOADED));
      }
      
      public function getWordsBeginning(param1:String) : Array
      {
         var _loc2_:Array = new Array();
         _loc2_.push(param1);
         return _loc2_;
      }
      
      public function getFirstWordBeginning(param1:String) : String
      {
         return param1;
      }
      
      public function checkPhraseAcceptable(param1:String) : Boolean
      {
         return true;
      }
      
      public function submitBadPhrase(param1:int, param2:Array) : void
      {
         dispatchEvent(new GameChatEvent(GameChatEvent.SUBMITTED));
      }
   }
}
