package com.miniclip.gamemanager
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.events.AvatarEvent;
   import com.miniclip.events.BlackBoxEvent;
   import com.miniclip.gamemanager.avatars.AvatarRegistration;
   import com.miniclip.hack;
   import com.miniclip.logger;
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   
   use namespace hack;
   
   public class YoMe extends Sprite implements GameAvatar
   {
       
      
      private var _blackbox:BlackBox;
      
      private var _userID:uint;
      
      private var _context:LoaderContext;
      
      private var _loader:Loader;
      
      private var _loaded:Boolean;
      
      private var _ready:Boolean;
      
      private var _avatar:*;
      
      private var _container:*;
      
      private var _UI:Sprite;
      
      private var _debugMarker:Boolean;
      
      private var _RPmarker:Sprite;
      
      private var _ORImarker:Sprite;
      
      public function YoMe(param1:BlackBox, param2:uint, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false)
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         super();
         _blackbox = param1;
         _userID = param2;
         _loader = new Loader();
         _loaded = false;
         _ready = false;
         _debugMarker = param6;
         if(_debugMarker)
         {
            _RPmarker = _createDebugMarker();
            _ORImarker = _createDebugMarker(16711680);
         }
         if(param3)
         {
            _loc7_ = "1";
         }
         else
         {
            _loc7_ = "0";
         }
         if(param4)
         {
            _loc8_ = "1";
         }
         else
         {
            _loc8_ = "0";
         }
         _blackbox.variables["userid"] = String(_userID);
         _blackbox.variables["glow"] = _loc7_;
         _blackbox.variables["loader"] = _loc8_;
         if(!param5)
         {
            _blackbox.variables["rnd"] = String(Math.random() * 10000);
         }
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
      
      private function _createDebugMarker(param1:Number = 16763904, param2:Number = 1) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Graphics;
         (_loc4_ = _loc3_.graphics).clear();
         _loc4_.beginFill(param1,param2);
         _loc4_.drawRect(-5,-5,10,10);
         _loc4_.endFill();
         _loc4_.lineStyle(1,0);
         _loc4_.moveTo(0,-12);
         _loc4_.lineTo(0,12);
         _loc4_.moveTo(-12,0);
         _loc4_.lineTo(12,0);
         _loc4_.endFill();
         return _loc3_;
      }
      
      private function _updateDebugMarker() : void
      {
         if(Boolean(_ORImarker) && !contains(_ORImarker))
         {
            addChild(_ORImarker);
         }
         _ORImarker.x = _loader.x;
         _ORImarker.y = _loader.y;
         if(Boolean(_RPmarker) && !contains(_RPmarker))
         {
            addChild(_RPmarker);
         }
         setChildIndex(_RPmarker,numChildren - 1);
         _RPmarker.x = 0;
         _RPmarker.y = 0;
      }
      
      private function _hookEvents() : void
      {
         _loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
         _loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS,onHTTPStatus);
         _loader.contentLoaderInfo.addEventListener(Event.INIT,onInit);
         _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _loader.contentLoaderInfo.addEventListener(Event.OPEN,onOpen);
         _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
         _loader.contentLoaderInfo.addEventListener(Event.UNLOAD,onUnload);
      }
      
      private function _unhookEvents() : void
      {
         _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
         _loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS,onHTTPStatus);
         _loader.contentLoaderInfo.removeEventListener(Event.INIT,onInit);
         _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _loader.contentLoaderInfo.removeEventListener(Event.OPEN,onOpen);
         _loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgress);
         _loader.contentLoaderInfo.removeEventListener(Event.UNLOAD,onUnload);
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
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(_blackbox.moduleURL)).data = _blackbox.variables;
         _loader.load(_loc4_,_context);
      }
      
      private function onComplete(param1:Event) : void
      {
         if(stage)
         {
            onAddedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
         }
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
         _UI = _loader.content as Sprite;
         _UI.addEventListener(Event.COMPLETE,onAvatarComplete);
         _UI.addEventListener(AvatarEvent.ERROR,onAvatarError);
         _avatar = _UI;
         _blackbox.localinfo = _loader.contentLoaderInfo;
         _loader.name = "container";
         addChild(_loader);
         _container = getChildByName("container");
         _loaded = true;
      }
      
      private function onHTTPStatus(param1:HTTPStatusEvent) : void
      {
      }
      
      private function onInit(param1:Event) : void
      {
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
      }
      
      private function onOpen(param1:Event) : void
      {
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
      }
      
      private function onUnload(param1:Event) : void
      {
      }
      
      private function onAvatarError(param1:AvatarEvent) : void
      {
         logger.error(param1.data);
         dispatchEvent(param1);
      }
      
      private function onAvatarComplete(param1:Event) : void
      {
         _UI.removeEventListener(Event.COMPLETE,onAvatarComplete);
         _UI.removeEventListener(AvatarEvent.ERROR,onAvatarError);
         _unhookEvents();
         if(_debugMarker)
         {
            _updateDebugMarker();
         }
         _ready = true;
         dispatchEvent(new AvatarEvent(AvatarEvent.READY,this));
      }
      
      hack function get skeleton() : *
      {
         return _container.content.skeleton;
      }
      
      public function get id() : uint
      {
         return _userID;
      }
      
      public function get ready() : Boolean
      {
         return _ready;
      }
      
      public function get version() : String
      {
         if(!ready)
         {
            return "";
         }
         return _avatar.version;
      }
      
      public function get registration() : Point
      {
         return new Point(_loader.x,_loader.y);
      }
      
      override public function get width() : Number
      {
         if(!ready)
         {
            return 0;
         }
         return _UI.width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(!ready)
         {
            return;
         }
         _UI.width = param1;
      }
      
      override public function get height() : Number
      {
         if(!ready)
         {
            return 0;
         }
         return _UI.height;
      }
      
      override public function set height(param1:Number) : void
      {
         if(!ready)
         {
            return;
         }
         _UI.height = param1;
      }
      
      public function get background() : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.background;
      }
      
      public function get bottom() : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.bottom;
      }
      
      public function get skin() : Sprite
      {
         return _avatar.skin;
      }
      
      public function get top() : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.top;
      }
      
      public function get shoes() : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.shoes;
      }
      
      public function get eyes() : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.eyes;
      }
      
      public function get mouth() : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.mouth;
      }
      
      public function get hair() : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.hair;
      }
      
      public function get glasses() : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.glasses;
      }
      
      public function get extra1() : Sprite
      {
         return _avatar.extra1;
      }
      
      public function get extra2() : Sprite
      {
         return _avatar.extra2;
      }
      
      public function get extra3() : Sprite
      {
         return _avatar.extra3;
      }
      
      public function get extra4() : Sprite
      {
         return _avatar.extra4;
      }
      
      public function get extra5() : Sprite
      {
         return _avatar.extra5;
      }
      
      public function get pet() : Sprite
      {
         return _avatar.pet;
      }
      
      public function getExtra(param1:uint) : Sprite
      {
         if(!ready)
         {
            return null;
         }
         return _avatar.getExtra(param1);
      }
      
      public function hide(... rest) : void
      {
         if(!ready)
         {
            return;
         }
         _avatar.hide.apply(_avatar,rest);
      }
      
      public function show(... rest) : void
      {
         if(!ready)
         {
            return;
         }
         _avatar.show.apply(_avatar,rest);
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         if(!ready)
         {
            return;
         }
         _avatar.setSize(param1,param2);
      }
      
      public function setRegistration(param1:*, param2:* = null) : void
      {
         var _loc3_:Point = null;
         if(param1 is AvatarRegistration)
         {
            _loc3_ = new Point(param1.x,param1.y);
         }
         else if(param1 is Point)
         {
            _loc3_ = param1;
         }
         else
         {
            if(!(param1 is Number && param2 is Number))
            {
               return;
            }
            _loc3_ = new Point(param1,param2);
         }
         _loader.x = -_loc3_.x;
         _loader.y = -_loc3_.y;
         if(_debugMarker)
         {
            _updateDebugMarker();
         }
      }
      
      public function destroy() : void
      {
         _ready = false;
         _avatar.destroy();
         _avatar = null;
         _UI = null;
         removeChild(_loader);
         if(_loader.hasOwnProperty("unloadAndStop"))
         {
            _loader["unloadAndStop"]();
         }
         else
         {
            _loader.unload();
         }
         if(Boolean(_ORImarker) && contains(_ORImarker))
         {
            removeChild(_ORImarker);
         }
         if(Boolean(_RPmarker) && contains(_RPmarker))
         {
            removeChild(_RPmarker);
         }
         _loader = null;
         _ORImarker = null;
         _RPmarker = null;
         _blackbox = null;
      }
   }
}
