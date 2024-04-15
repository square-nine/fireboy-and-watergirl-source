package com.miniclip.gamemanager
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.gamemanager.avatars.AvatarBitmapType;
   import com.miniclip.logger;
   import flash.events.EventDispatcher;
   
   public class MiniclipAvatars extends EventDispatcher implements GameAvatars
   {
       
      
      private var _blackbox:BlackBox;
      
      private var _debugMarkers:Boolean;
      
      private var _allowDuplicates:Boolean;
      
      private var _list:Array;
      
      public function MiniclipAvatars(param1:BlackBox)
      {
         super();
         _blackbox = param1;
         _debugMarkers = false;
         _allowDuplicates = true;
         _list = [];
      }
      
      public function get debugMarkers() : Boolean
      {
         return _debugMarkers;
      }
      
      public function set debugMarkers(param1:Boolean) : void
      {
         _debugMarkers = param1;
      }
      
      public function get allowDuplicates() : Boolean
      {
         return _allowDuplicates;
      }
      
      public function set allowDuplicates(param1:Boolean) : void
      {
         _allowDuplicates = param1;
      }
      
      public function load(param1:uint, param2:Boolean = true, param3:Boolean = false, param4:Boolean = false) : YoMe
      {
         var _loc6_:uint = 0;
         logger.log("MiniclipAvatars.load()");
         var _loc5_:* = "";
         if(allowDuplicates)
         {
            _loc5_ = param1 + "_";
            _loc6_ = 1;
            while(_list[_loc5_ + _loc6_])
            {
               _loc6_++;
            }
            _loc5_ += _loc6_;
         }
         else
         {
            _loc5_ = String(param1);
         }
         logger.info("YoMe refid: " + _loc5_);
         if(!_list[_loc5_])
         {
            _list[_loc5_] = new YoMe(_blackbox,param1,param2,param3,param4,debugMarkers);
         }
         else
         {
            logger.log("YoMe id=" + _loc5_ + " was already loaded before, we return the same reference object");
         }
         return _list[_loc5_];
      }
      
      public function loadBitmap(param1:uint, param2:Number = 200, param3:Number = 200, param4:AvatarBitmapType = null) : YoMeBitmap
      {
         return new YoMeBitmap(_blackbox,param1,param2,param3,param4);
      }
   }
}
