package com.miniclip.events
{
   import flash.events.Event;
   
   public class CreditsEvent extends Event
   {
      
      public static const TOPUP_WINDOW_OPENED:String = "topup_window_opened";
      
      public static const TOPUP_WINDOW_CLOSED:String = "topup_window_closed";
      
      public static const BALANCE:String = "credits_balance";
      
      public static const PURCHASED:String = "credits_purchased";
      
      public static const PURCHASE_FAILED:String = "credits_purchase_failed";
      
      public static const ITEM_QTY_DECREMENTED:String = "credits_itemqnt_decremented";
      
      public static const PURCHASE_CANCELLED_BY_USER:String = "credits_purchase_cancelled";
      
      public static const PURCHASE_ACCEPTED_BY_USER:String = "credits_purchase_accepted";
      
      public static const GET_PRODUCT_BY_ID:String = "credits_product_byid";
      
      public static const GET_PRODUCT_BY_GAME_ID:String = "credits_product_by_gameid";
      
      public static const ITEM_INFO:String = "credits_i_info";
      
      public static const ITEM_TOTAL_USER_BALANCE:String = "credits_item_toal_u_balance";
      
      public static const USER_ITEMS_BY_GAME_ID:String = "credits_user_items_by_gameid";
      
      public static const ERROR:String = "credits_error";
       
      
      private var _data:*;
      
      public function CreditsEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new CreditsEvent(type,data,bubbles,cancelable);
      }
   }
}
