package com.miniclip.gamemanager
{
   import com.miniclip.events.CreditsEvent;
   import flash.events.EventDispatcher;
   
   public class MiniclipCredits extends EventDispatcher implements GameCredits
   {
       
      
      public function MiniclipCredits()
      {
         super();
      }
      
      public function topupCredits() : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.TOPUP_WINDOW_OPENED,null));
         dispatchEvent(new CreditsEvent(CreditsEvent.TOPUP_WINDOW_CLOSED,{
            "success":true,
            "result":1000,
            "description":""
         }));
      }
      
      public function getBalance(param1:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.BALANCE,{
            "success":true,
            "result":0
         }));
      }
      
      public function getUserItemsByGameId(param1:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.USER_ITEMS_BY_GAME_ID,{
            "success":true,
            "result":null
         }));
      }
      
      public function getTotalUserItemBalance(param1:int, param2:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.ITEM_TOTAL_USER_BALANCE,{
            "success":true,
            "result":0
         }));
      }
      
      public function getItemInfo(param1:int) : void
      {
         var _loc2_:Object = {
            "description":"A test widget",
            "enabled":"1",
            "game_id":"0",
            "id":"0",
            "max_qty":"0",
            "name":"Widget"
         };
         dispatchEvent(new CreditsEvent(CreditsEvent.ITEM_INFO,{
            "success":true,
            "result":_loc2_
         }));
      }
      
      public function decrementUserItemQuantity(param1:int, param2:int) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.ITEM_QTY_DECREMENTED,{
            "success":false,
            "result":113
         }));
      }
      
      public function purchaseProduct(param1:int, param2:int, param3:String = null, param4:Boolean = false) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.PURCHASE_FAILED,{
            "success":false,
            "result":100
         }));
      }
      
      public function getProductsByGameId(param1:Boolean = true) : void
      {
         dispatchEvent(new CreditsEvent(CreditsEvent.GET_PRODUCT_BY_GAME_ID,{
            "success":false,
            "result":117
         }));
      }
      
      public function getProductById(param1:int) : void
      {
         var _loc2_:Object = {
            "credit_cost":"0",
            "description":"test product",
            "enabled":"1",
            "game_id":"0",
            "id":"0",
            "items":[{
               "enabled":1,
               "game_id":0,
               "item_id":0,
               "lifetime":0,
               "max_qty":0,
               "name":"Widget",
               "qty":"1",
               "name":"Test name"
            }]
         };
         dispatchEvent(new CreditsEvent(CreditsEvent.GET_PRODUCT_BY_ID,{
            "success":true,
            "result":_loc2_
         }));
      }
   }
}
