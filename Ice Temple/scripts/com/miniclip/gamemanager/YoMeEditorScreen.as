package com.miniclip.gamemanager
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.events.BlackBoxEvent;
   import com.miniclip.events.YoMeEditorEvent;
   import com.miniclip.logger;
   import core.uri;
   import flash.display.Loader;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import system.Strings;
   
   public class YoMeEditorScreen extends EventDispatcher
   {
       
      
      private var _blackbox:BlackBox;
      
      private var _loader:Loader;
      
      private var _context:LoaderContext;
      
      private var _loaded:Boolean;
      
      private var _ready:Boolean;
      
      private var _showBackground:Boolean;
      
      private var _showCloseButton:Boolean;
      
      private var _position:Point;
      
      private var _stage:Stage;
      
      private var _UI:*;
      
      public function YoMeEditorScreen(param1:BlackBox, param2:Boolean = true, param3:Boolean = false, param4:Point = null)
      {
         super();
         _blackbox = param1;
         _showBackground = param2;
         _showCloseButton = param3;
         _position = param4;
         _loader = new Loader();
         _loaded = false;
         _ready = false;
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
         if(_loader)
         {
            _loader.contentLoaderInfo.sharedEvents.removeEventListener(Event.CHANGE,onYoMeEditorChange);
            _loader.contentLoaderInfo.sharedEvents.removeEventListener(Event.CLOSE,onYoMeEditorClose);
            _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
            _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
         }
      }
      
      private function _factory() : void
      {
         _stage = _blackbox.stage;
         _load();
      }
      
      private function _alignCenter() : void
      {
         x = Math.floor((_stage.stageWidth - width) / 2);
         y = Math.floor((_stage.stageHeight - height) / 2);
      }
      
      private function _load() : void
      {
         var _loc4_:String = null;
         var _loc1_:URLVariables = new URLVariables();
         if(_showBackground)
         {
            _loc1_["bg"] = 1;
         }
         else
         {
            _loc1_["bg"] = 0;
         }
         if(_showCloseButton)
         {
            _loc1_["close_btn"] = 1;
         }
         else
         {
            _loc1_["close_btn"] = 0;
         }
         _hookEvents();
         var _loc2_:uri = new uri(_blackbox.moduleURL);
         if(_loc2_.host == BlackBox.developerServer || Strings.endsWith(_loc2_.host,"." + BlackBox.developerServer))
         {
            _loc4_ = _loc2_.host.split("." + BlackBox.developerServer).join("");
            _loc1_["devname"] = _loc4_;
            logger.log("devname: " + _loc4_);
         }
         _loc2_.query = "";
         _loc2_.fragment = "";
         var _loc3_:URLRequest = new URLRequest(_loc2_.toString());
         _loc3_.data = _loc1_;
         _loader.contentLoaderInfo.sharedEvents.addEventListener(Event.CHANGE,onYoMeEditorChange,false,0,true);
         _loader.contentLoaderInfo.sharedEvents.addEventListener(Event.CLOSE,onYoMeEditorClose,false,0,true);
         _loader.load(_loc3_,_context);
      }
      
      private function _unload() : void
      {
         _unhookEvents();
         _ready = false;
         _loaded = false;
         _stage.removeChild(_loader);
         _loader.unload();
         _loader = null;
         _blackbox.localinfo = null;
         _UI = null;
      }
      
      private function onYoMeEditorChange(param1:Event) : void
      {
         dispatchEvent(new YoMeEditorEvent(YoMeEditorEvent.CHANGE));
      }
      
      private function onYoMeEditorClose(param1:Event) : void
      {
         dispatchEvent(new YoMeEditorEvent(YoMeEditorEvent.CLOSE));
      }
      
      private function onReady(param1:BlackBoxEvent = null) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:ApplicationDomain = null;
         _blackbox.removeEventListener(BlackBoxEvent.READY,onReady);
         if(_blackbox.isLocal())
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = SecurityDomain.currentDomain;
         }
         _loc3_ = new ApplicationDomain(null);
         _context = new LoaderContext(false,_loc3_,_loc2_);
         _factory();
      }
      
      private function onComplete(param1:Event) : void
      {
         _unhookEvents();
         _loaded = true;
         _ready = true;
         _UI = _loader;
         _stage.addChild(_UI);
         if(_position)
         {
            this.x = _position.x;
            this.y = _position.y;
         }
         else
         {
            _alignCenter();
         }
         dispatchEvent(new YoMeEditorEvent(YoMeEditorEvent.READY));
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         _unhookEvents();
         logger.error("YoMeEditorScreen load fail: " + param1.text);
         dispatchEvent(new YoMeEditorEvent(YoMeEditorEvent.ERROR));
      }
      
      public function get x() : Number
      {
         if(!ready)
         {
            return 0;
         }
         return _UI.x;
      }
      
      public function set x(param1:Number) : void
      {
         if(!ready)
         {
            return;
         }
         _UI.x = param1;
      }
      
      public function get y() : Number
      {
         if(!ready)
         {
            return 0;
         }
         return _UI.y;
      }
      
      public function set y(param1:Number) : void
      {
         if(!ready)
         {
            return;
         }
         _UI.y = param1;
      }
      
      public function get width() : Number
      {
         return 590;
      }
      
      public function get height() : Number
      {
         return 400;
      }
      
      public function get ready() : Boolean
      {
         return _ready;
      }
      
      public function close() : void
      {
         _unhookEvents();
         if(!_loaded || !_ready)
         {
            return;
         }
         _unload();
      }
   }
}
