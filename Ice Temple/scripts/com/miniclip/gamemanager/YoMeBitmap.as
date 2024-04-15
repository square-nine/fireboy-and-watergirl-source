package com.miniclip.gamemanager
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.events.AvatarEvent;
   import com.miniclip.events.BlackBoxEvent;
   import com.miniclip.gamemanager.avatars.AvatarBitmapType;
   import com.miniclip.logger;
   import core.uri;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import system.Strings;
   
   public class YoMeBitmap extends Sprite
   {
       
      
      private var _blackbox:BlackBox;
      
      private var _loader:Loader;
      
      private var _context:LoaderContext;
      
      private var _request:URLRequest;
      
      private var _id:uint;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _type:AvatarBitmapType;
      
      private var _loaded:Boolean;
      
      private var _ready:Boolean;
      
      private var _bitmap:Bitmap;
      
      public function YoMeBitmap(param1:BlackBox, param2:uint, param3:Number = 200, param4:Number = 200, param5:AvatarBitmapType = null)
      {
         super();
         if(!param5)
         {
            param5 = AvatarBitmapType.cropped;
         }
         _blackbox = param1;
         _id = param2;
         _width = param3;
         _height = param4;
         _type = param5;
         _loader = new Loader();
         _loaded = false;
         _ready = false;
         _hookEvents();
         if(_blackbox.ready)
         {
            onReady();
         }
         else
         {
            _blackbox.addEventListener(BlackBoxEvent.READY,onReady);
         }
      }
      
      private function _hookEvents() : void
      {
         _loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
         _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
      }
      
      private function _unhookEvents() : void
      {
         _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
         _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
      }
      
      private function _buildURL() : String
      {
         var _loc1_:Object = {
            "id":_id,
            "width":_width,
            "height":_height,
            "type":_type.valueOf()
         };
         var _loc2_:uri = new uri(_blackbox.moduleURL);
         if(_loc2_.host == BlackBox.developerServer || Strings.endsWith(_loc2_.host,"." + BlackBox.developerServer))
         {
            _loc2_.host = BlackBox.productionServer;
         }
         var _loc3_:uri = new uri(Strings.format(strings.avatarBitmapFormat,_loc1_));
         _loc3_.scheme = _loc2_.scheme;
         _loc3_.host = _loc2_.host;
         return _loc3_.toString();
      }
      
      private function onReady(param1:BlackBoxEvent = null) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:ApplicationDomain = null;
         _blackbox.removeEventListener(BlackBoxEvent.READY,onReady);
         if(ready)
         {
            dispatchEvent(new AvatarEvent(AvatarEvent.READY,this));
            return;
         }
         if(_blackbox.isLocal())
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = SecurityDomain.currentDomain;
         }
         _loc3_ = ApplicationDomain.currentDomain;
         _context = new LoaderContext(false,_loc3_,_loc2_);
         _request = new URLRequest(_buildURL());
         _loader.load(_request,_context);
         addChild(_loader);
      }
      
      private function onComplete(param1:Event) : void
      {
         _bitmap = Bitmap(_loader.content);
         _loaded = true;
         onBitmapComplete();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         logger.error("Could not load " + _request);
      }
      
      private function onBitmapComplete(param1:Event = null) : void
      {
         _unhookEvents();
         _ready = true;
         dispatchEvent(new AvatarEvent(AvatarEvent.READY,this));
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get ready() : Boolean
      {
         return _ready;
      }
      
      public function get bitmap() : Bitmap
      {
         if(!_loaded)
         {
            return null;
         }
         return new Bitmap(_bitmap.bitmapData.clone());
      }
   }
}
