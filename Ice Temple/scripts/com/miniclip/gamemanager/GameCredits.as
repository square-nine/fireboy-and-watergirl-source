package com.miniclip.gamemanager
{
   import flash.events.IEventDispatcher;
   
   public interface GameCredits extends IEventDispatcher
   {
       
      
      function topupCredits() : void;
      
      function getBalance(param1:Boolean = false) : void;
      
      function getUserItemsByGameId(param1:Boolean = false) : void;
      
      function getTotalUserItemBalance(param1:int, param2:Boolean = false) : void;
      
      function getItemInfo(param1:int) : void;
      
      function decrementUserItemQuantity(param1:int, param2:int) : void;
      
      function purchaseProduct(param1:int, param2:int, param3:String = null, param4:Boolean = false) : void;
      
      function getProductsByGameId(param1:Boolean = true) : void;
      
      function getProductById(param1:int) : void;
   }
}
