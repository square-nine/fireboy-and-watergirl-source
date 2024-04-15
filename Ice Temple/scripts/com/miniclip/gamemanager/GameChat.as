package com.miniclip.gamemanager
{
   import flash.events.IEventDispatcher;
   
   public interface GameChat extends IEventDispatcher
   {
       
      
      function init() : void;
      
      function getWordsBeginning(param1:String) : Array;
      
      function getFirstWordBeginning(param1:String) : String;
      
      function checkPhraseAcceptable(param1:String) : Boolean;
      
      function submitBadPhrase(param1:int, param2:Array) : void;
   }
}
