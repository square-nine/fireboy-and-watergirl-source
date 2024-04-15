package mochi.as3
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.Timer;
   
   public class MochiServices
   {
      
      public static const CONNECTED:String = "onConnected";
      
      private static var _id:String;
      
      private static var _container:Object;
      
      private static var _clip:MovieClip;
      
      private static var _loader:Loader;
      
      private static var _timer:Timer;
      
      private static var _preserved:Object;
      
      private static var _servURL:String = "http://www.mochiads.com/static/lib/services/";
      
      private static var _services:String = "services.swf";
      
      private static var _mochiLC:String = "MochiLC.swf";
      
      private static var _swfVersion:String;
      
      private static var _listenChannelName:String = "__ms_";
      
      private static var _sendChannel:LocalConnection;
      
      private static var _sendChannelName:String;
      
      private static var _connecting:Boolean = false;
      
      private static var _connected:Boolean = false;
      
      public static var netup:Boolean = true;
      
      public static var netupAttempted:Boolean = false;
      
      public static var onError:Object;
      
      public static var widget:Boolean = false;
      
      private static var _mochiLocalConnection:MovieClip;
      
      private static var _queue:Array;
      
      private static var _nextCallbackID:Number;
      
      private static var _callbacks:Object;
      
      private static var _dispatcher:MochiEventDispatcher = new MochiEventDispatcher();
       
      
      public function MochiServices()
      {
         super();
      }
      
      public static function get id() : String
      {
         return _id;
      }
      
      public static function get clip() : Object
      {
         return _container;
      }
      
      public static function get childClip() : Object
      {
         return _clip;
      }
      
      public static function getVersion() : String
      {
         return "3.9.4 as3";
      }
      
      public static function allowDomains(param1:String) : String
      {
         var _loc2_:String = null;
         if(Security.sandboxType != "application")
         {
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
         }
         if(param1.indexOf("http://") != -1)
         {
            _loc2_ = String(param1.split("/")[2].split(":")[0]);
            if(Security.sandboxType != "application")
            {
               Security.allowDomain(_loc2_);
               Security.allowInsecureDomain(_loc2_);
            }
         }
         return _loc2_;
      }
      
      public static function isNetworkAvailable() : Boolean
      {
         return Security.sandboxType != "localWithFile";
      }
      
      public static function set comChannelName(param1:String) : void
      {
         if(param1 != null)
         {
            if(param1.length > 3)
            {
               _sendChannelName = param1 + "_fromgame";
               initComChannels();
            }
         }
      }
      
      public static function get connected() : Boolean
      {
         return _connected;
      }
      
      public static function warnID(param1:String, param2:Boolean) : void
      {
         param1 = param1.toLowerCase();
         if(param1.length != 16)
         {
            trace("WARNING: " + (param2 ? "board" : "game") + " ID is not the appropriate length");
            return;
         }
         if(param1 == "1e113c7239048b3f")
         {
            if(param2)
            {
               trace("WARNING: Using testing board ID");
            }
            else
            {
               trace("WARNING: Using testing board ID as game ID");
            }
            return;
         }
         if(param1 == "84993a1de4031cd8")
         {
            if(param2)
            {
               trace("WARNING: Using testing game ID as board ID");
            }
            else
            {
               trace("WARNING: Using testing game ID");
            }
            return;
         }
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            switch(param1.charAt(_loc3_))
            {
               case "0":
               case "1":
               case "2":
               case "3":
               case "4":
               case "5":
               case "6":
               case "7":
               case "8":
               case "9":
               case "a":
               case "b":
               case "c":
               case "d":
               case "e":
               case "f":
                  break;
               default:
                  trace("WARNING: Board ID contains illegal characters: " + param1);
                  return;
            }
            _loc3_++;
         }
      }
      
      public static function connect(param1:String, param2:Object, param3:Object = null) : void
      {
         var id:String = param1;
         var clip:Object = param2;
         var onError:Object = param3;
         warnID(id,false);
         if(onError != null)
         {
            MochiServices.onError = onError;
         }
         else if(MochiServices.onError == null)
         {
            MochiServices.onError = function(param1:String):void
            {
               trace(param1);
            };
         }
         if(clip is DisplayObject)
         {
            if(clip.stage == null)
            {
               trace("MochiServices connect requires the containing clip be attached to the stage");
            }
            if(!_connected && _clip == null)
            {
               trace("MochiServices Connecting...");
               _connecting = true;
               init(id,clip);
            }
         }
         else
         {
            trace("Error, MochiServices requires a Sprite, Movieclip or instance of the stage.");
         }
      }
      
      public static function disconnect() : void
      {
         if(_connected || _connecting)
         {
            if(_clip != null)
            {
               if(_clip.parent != null)
               {
                  if(_clip.parent is Sprite)
                  {
                     Sprite(_clip.parent).removeChild(_clip);
                     _clip = null;
                  }
               }
            }
            _connecting = _connected = false;
            flush(true);
            try
            {
               _mochiLocalConnection.close();
            }
            catch(error:Error)
            {
            }
         }
         if(_timer != null)
         {
            try
            {
               _timer.stop();
               _timer.removeEventListener(TimerEvent.TIMER,connectWait);
               _timer = null;
            }
            catch(error:Error)
            {
            }
         }
      }
      
      public static function stayOnTop() : void
      {
         _container.addEventListener(Event.ENTER_FRAME,MochiServices.bringToTop,false,0,true);
         if(_clip != null)
         {
            _clip.visible = true;
         }
      }
      
      public static function doClose() : void
      {
         _container.removeEventListener(Event.ENTER_FRAME,MochiServices.bringToTop);
      }
      
      public static function bringToTop(param1:Event = null) : void
      {
         var e:Event = param1;
         if(MochiServices.clip != null && MochiServices.childClip != null)
         {
            try
            {
               if(MochiServices.clip.numChildren > 1)
               {
                  MochiServices.clip.setChildIndex(MochiServices.childClip,MochiServices.clip.numChildren - 1);
               }
            }
            catch(errorObject:Error)
            {
               trace("Warning: Depth sort error.");
               _container.removeEventListener(Event.ENTER_FRAME,MochiServices.bringToTop);
            }
         }
      }
      
      private static function init(param1:String, param2:Object) : void
      {
         _id = param1;
         if(param2 != null)
         {
            _container = param2;
            loadCommunicator(param1,_container);
         }
      }
      
      public static function setContainer(param1:Object = null, param2:Boolean = true) : void
      {
         if(_clip.parent)
         {
            _clip.parent.removeChild(_clip);
         }
         if(param1 != null)
         {
            if(param1 is DisplayObjectContainer)
            {
               _container = param1;
            }
         }
         if(param2)
         {
            if(_container is DisplayObjectContainer)
            {
               DisplayObjectContainer(_container).addChild(_clip);
            }
         }
      }
      
      private static function loadCommunicator(param1:String, param2:Object) : MovieClip
      {
         if(_clip != null)
         {
            return _clip;
         }
         if(!MochiServices.isNetworkAvailable())
         {
            MochiServices.onError("NotConnected");
            return null;
         }
         if(urlOptions(param2).servURL)
         {
            _servURL = urlOptions(param2).servURL;
         }
         var _loc3_:String = _servURL + _services;
         if(urlOptions(param2).servicesURL)
         {
            _loc3_ = String(urlOptions(param2).servicesURL);
         }
         _listenChannelName += Math.floor(new Date().time) + "_" + Math.floor(Math.random() * 99999);
         MochiServices.allowDomains(_loc3_);
         _clip = new MovieClip();
         loadLCBridge(_clip);
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener(Event.COMPLETE,detach);
         _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,detach);
         _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadError);
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         var _loc5_:URLVariables;
         (_loc5_ = new URLVariables()).listenLC = _listenChannelName;
         _loc5_.mochiad_options = param2.loaderInfo.parameters.mochiad_options;
         _loc5_.api_version = getVersion();
         if(widget)
         {
            _loc5_.widget = true;
         }
         _loc4_.data = _loc5_;
         _loader.load(_loc4_);
         _clip.addChild(_loader);
         _sendChannel = new LocalConnection();
         _queue = [];
         _nextCallbackID = 0;
         _callbacks = {};
         _timer = new Timer(10000,1);
         _timer.addEventListener(TimerEvent.TIMER,connectWait);
         _timer.start();
         return _clip;
      }
      
      private static function detach(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.target);
         _loc2_.removeEventListener(Event.COMPLETE,detach);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,detach);
         _loc2_.removeEventListener(Event.COMPLETE,loadLCBridgeComplete);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
      }
      
      private static function loadLCBridge(param1:Object) : void
      {
         var _loc2_:Loader = new Loader();
         var _loc3_:String = _servURL + _mochiLC;
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,detach);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,detach);
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,loadLCBridgeComplete);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadError);
         _loc2_.load(_loc4_);
         param1.addChild(_loc2_);
      }
      
      private static function loadLCBridgeComplete(param1:Event) : void
      {
         var _loc2_:Loader = LoaderInfo(param1.target).loader;
         _mochiLocalConnection = MovieClip(_loc2_.content);
         listen();
      }
      
      private static function loadError(param1:Object) : void
      {
         _clip._mochiad_ctr_failed = true;
         trace("MochiServices could not load.");
         MochiServices.disconnect();
         MochiServices.onError("IOError");
      }
      
      public static function connectWait(param1:TimerEvent) : void
      {
         if(!_connected)
         {
            _clip._mochiad_ctr_failed = true;
            trace("MochiServices could not load. (timeout)");
            MochiServices.disconnect();
            MochiServices.onError("IOError");
         }
         else
         {
            _timer.stop();
            _timer.removeEventListener(TimerEvent.TIMER,connectWait);
            _timer = null;
         }
      }
      
      private static function listen() : void
      {
         _mochiLocalConnection.connect(_listenChannelName);
         _clip.handshake = function(param1:Object):void
         {
            MochiServices.comChannelName = param1.newChannel;
         };
         trace("Waiting for MochiAds services to connect...");
      }
      
      private static function initComChannels() : void
      {
         if(!_connected)
         {
            trace("[SERVICES_API] connected!");
            _connecting = false;
            _connected = true;
            _mochiLocalConnection.send(_sendChannelName,"onReceive",{"methodName":"handshakeDone"});
            _mochiLocalConnection.send(_sendChannelName,"onReceive",{
               "methodName":"registerGame",
               "preserved":_preserved,
               "id":_id,
               "version":getVersion(),
               "parentURL":_container.loaderInfo.loaderURL
            });
            _clip.onReceive = onReceive;
            _clip.onEvent = onEvent;
            _clip.onError = function():void
            {
               MochiServices.onError("IOError");
            };
            while(_queue.length > 0)
            {
               _mochiLocalConnection.send(_sendChannelName,"onReceive",_queue.shift());
            }
         }
      }
      
      private static function onReceive(param1:Object) : void
      {
         var method:*;
         var obj:Object;
         var methodName:String = null;
         var pkg:Object = param1;
         var cb:String = String(pkg.callbackID);
         var cblst:Object = _callbacks[cb];
         if(!cblst)
         {
            return;
         }
         method = cblst.callbackMethod;
         methodName = "";
         obj = cblst.callbackObject;
         if(Boolean(obj) && typeof method == "string")
         {
            methodName = method;
            if(obj[method] != null)
            {
               method = obj[method];
            }
            else
            {
               trace("Error: Method  " + method + " does not exist.");
            }
         }
         if(method != undefined)
         {
            try
            {
               method.apply(obj,pkg.args);
            }
            catch(error:Error)
            {
               trace("Error invoking callback method \'" + methodName + "\': " + error.toString());
            }
         }
         else if(obj != null)
         {
            try
            {
               obj(pkg.args);
            }
            catch(error:Error)
            {
               trace("Error invoking method on object: " + error.toString());
            }
         }
         delete _callbacks[cb];
      }
      
      private static function onEvent(param1:Object) : void
      {
         var _loc2_:String = String(param1.target);
         var _loc3_:String = String(param1.event);
         switch(_loc2_)
         {
            case "services":
               MochiServices.triggerEvent(param1.event,param1.args);
               break;
            case "events":
               MochiEvents.triggerEvent(param1.event,param1.args);
               break;
            case "coins":
               MochiCoins.triggerEvent(param1.event,param1.args);
               break;
            case "social":
               MochiSocial.triggerEvent(param1.event,param1.args);
         }
      }
      
      private static function flush(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         if(Boolean(_clip) && Boolean(_queue))
         {
            while(_queue.length > 0)
            {
               _loc2_ = _queue.shift();
               _loc3_ = null;
               if(_loc2_ != null)
               {
                  if(_loc2_.callbackID != null)
                  {
                     _loc3_ = _callbacks[_loc2_.callbackID];
                  }
                  delete _callbacks[_loc2_.callbackID];
                  if(param1 && _loc3_ != null)
                  {
                     handleError(_loc2_.args,_loc3_.callbackObject,_loc3_.callbackMethod);
                  }
               }
            }
         }
      }
      
      private static function handleError(param1:Object, param2:Object, param3:Object) : void
      {
         if(param1 != null)
         {
            if(param1.onError != null)
            {
               param1.onError("NotConnected");
            }
            if(param1.options != null && param1.options.onError != null)
            {
               param1.options.onError("NotConnected");
            }
         }
         if(param3 != null)
         {
            param1 = {};
            param1.error = true;
            param1.errorCode = "NotConnected";
            if(param2 != null && param3 is String)
            {
               try
               {
                  param2[param3](param1);
               }
               catch(error:Error)
               {
               }
            }
            else if(param3 != null)
            {
               try
               {
                  param3.apply(param1);
               }
               catch(error:Error)
               {
               }
            }
         }
      }
      
      public static function send(param1:String, param2:Object = null, param3:Object = null, param4:Object = null) : void
      {
         if(_connected)
         {
            _mochiLocalConnection.send(_sendChannelName,"onReceive",{
               "methodName":param1,
               "args":param2,
               "callbackID":_nextCallbackID
            });
         }
         else
         {
            if(_clip == null || !_connecting)
            {
               trace("Error: MochiServices not connected.   Please call MochiServices.connect().  Function: " + param1);
               handleError(param2,param3,param4);
               flush(true);
               return;
            }
            _queue.push({
               "methodName":param1,
               "args":param2,
               "callbackID":_nextCallbackID
            });
         }
         if(_clip != null)
         {
            if(_callbacks != null)
            {
               _callbacks[_nextCallbackID] = {
                  "callbackObject":param3,
                  "callbackMethod":param4
               };
               ++_nextCallbackID;
            }
         }
      }
      
      private static function urlOptions(param1:Object) : Object
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc6_:Array = null;
         var _loc2_:Object = {};
         if(param1.stage)
         {
            _loc3_ = String(param1.stage.loaderInfo.parameters.mochiad_options);
         }
         else
         {
            _loc3_ = String(param1.loaderInfo.parameters.mochiad_options);
         }
         if(_loc3_)
         {
            _loc4_ = _loc3_.split("&");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_].split("=");
               _loc2_[unescape(_loc6_[0])] = unescape(_loc6_[1]);
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      public static function addLinkEvent(param1:String, param2:String, param3:DisplayObjectContainer, param4:Function = null) : void
      {
         var s:String;
         var i:Number;
         var avm1Click:DisplayObject = null;
         var x:String = null;
         var req:URLRequest = null;
         var loader:Loader = null;
         var setURL:Function = null;
         var err:Function = null;
         var complete:Function = null;
         var url:String = param1;
         var burl:String = param2;
         var btn:DisplayObjectContainer = param3;
         var onClick:Function = param4;
         var vars:Object = new Object();
         vars["mav"] = getVersion();
         vars["swfv"] = "9";
         vars["swfurl"] = btn.loaderInfo.loaderURL;
         vars["fv"] = Capabilities.version;
         vars["os"] = Capabilities.os;
         vars["lang"] = Capabilities.language;
         vars["scres"] = Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY;
         s = "?";
         i = 0;
         for(x in vars)
         {
            if(i != 0)
            {
               s += "&";
            }
            i++;
            s = s + x + "=" + escape(vars[x]);
         }
         req = new URLRequest("http://link.mochiads.com/linkping.swf");
         loader = new Loader();
         setURL = function(param1:String):void
         {
            if(avm1Click)
            {
               btn.removeChild(avm1Click);
            }
            avm1Click = clickMovie(param1,onClick);
            var _loc2_:Rectangle = btn.getBounds(btn);
            btn.addChild(avm1Click);
            avm1Click.x = _loc2_.x;
            avm1Click.y = _loc2_.y;
            avm1Click.scaleX = 0.01 * _loc2_.width;
            avm1Click.scaleY = 0.01 * _loc2_.height;
         };
         err = function(param1:Object):void
         {
            netup = false;
            param1.target.removeEventListener(param1.type,arguments.callee);
            setURL(burl);
         };
         complete = function(param1:Object):void
         {
            param1.target.removeEventListener(param1.type,arguments.callee);
         };
         if(netup)
         {
            setURL(url + s);
         }
         else
         {
            setURL(burl);
         }
         if(!(netupAttempted || _connected))
         {
            netupAttempted = true;
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,err);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,complete);
            loader.load(req);
         }
      }
      
      private static function clickMovie(param1:String, param2:Function) : MovieClip
      {
         var _loc4_:int = 0;
         var _loc14_:Loader = null;
         var _loc3_:Array = [150,21,0,7,1,0,0,0,0,98,116,110,0,7,2,0,0,0,0,116,104,105,115,0,28,150,22,0,0,99,114,101,97,116,101,69,109,112,116,121,77,111,118,105,101,67,108,105,112,0,82,135,1,0,0,23,150,13,0,4,0,0,111,110,82,101,108,101,97,115,101,0,142,8,0,0,0,0,2,42,0,114,0,150,17,0,0,32,0,7,1,0,0,0,8,0,0,115,112,108,105,116,0,82,135,1,0,1,23,150,7,0,4,1,7,0,0,0,0,78,150,8,0,0,95,98,108,97,110,107,0,154,1,0,0,150,7,0,0,99,108,105,99,107,0,150,7,0,4,1,7,1,0,0,0,78,150,27,0,7,2,0,0,0,7,0,0,0,0,0,76,111,99,97,108,67,111,110,110,101,99,116,105,111,110,0,64,150,6,0,0,115,101,110,100,0,82,79,150,15,0,4,0,0,95,97,108,112,104,97,0,7,0,0,0,0,79,150,23,0,7,255,0,255,0,7,1,0,0,0,4,0,0,98,101,103,105,110,70,105,108,108,0,82,23,150,25,0,7,0,0,0,0,7,0,0,0,0,7,2,0,0,0,4,0,0,109,111,118,101,84,111,0,82,23,150,25,0,7,100,0,0,0,7,0,0,0,0,7,2,0,0,0,4,0,0,108,105,110,101,84,111,0,82,23,150,25,0,7,100,0,0,0,7,100,0,0,0,7,2,0,0,0,4,0,0,108,105,110,101,84,111,0,82,23,150,25,0,7,0,0,0,0,7,100,0,0,0,7,2,0,0,0,4,0,0,108,105,110,101,84,111,0,82,23,150,25,0,7,0,0,0,0,7,0,0,0,0,7,2,0,0,0,4,0,0,108,105,110,101,84,111,0,82,23,150,16,0,7,0,0,0,0,4,0,0,101,110,100,70,105,108,108,0,82,23];
         var _loc5_:Array = [104,0,31,64,0,7,208,0,0,12,1,0,67,2,255,255,255,63,3];
         var _loc6_:Array = [0,64,0,0,0];
         var _loc7_:MovieClip = new MovieClip();
         var _loc8_:LocalConnection = new LocalConnection();
         var _loc9_:String = "_click_" + Math.floor(Math.random() * 999999) + "_" + Math.floor(new Date().time);
         _loc8_ = new LocalConnection();
         _loc7_.lc = _loc8_;
         _loc7_.click = param2;
         _loc8_.client = _loc7_;
         _loc8_.connect(_loc9_);
         var _loc10_:ByteArray = new ByteArray();
         var _loc11_:ByteArray;
         (_loc11_ = new ByteArray()).endian = Endian.LITTLE_ENDIAN;
         _loc11_.writeShort(1);
         _loc11_.writeUTFBytes(param1 + " " + _loc9_);
         _loc11_.writeByte(0);
         var _loc12_:uint;
         var _loc13_:uint = uint((_loc12_ = uint(_loc3_.length + _loc11_.length + 4)) + 35);
         _loc10_.endian = Endian.LITTLE_ENDIAN;
         _loc10_.writeUTFBytes("FWS");
         _loc10_.writeByte(8);
         _loc10_.writeUnsignedInt(_loc13_);
         for each(_loc4_ in _loc5_)
         {
            _loc10_.writeByte(_loc4_);
         }
         _loc10_.writeUnsignedInt(_loc12_);
         _loc10_.writeByte(136);
         _loc10_.writeShort(_loc11_.length);
         _loc10_.writeBytes(_loc11_);
         for each(_loc4_ in _loc3_)
         {
            _loc10_.writeByte(_loc4_);
         }
         for each(_loc4_ in _loc6_)
         {
            _loc10_.writeByte(_loc4_);
         }
         (_loc14_ = new Loader()).loadBytes(_loc10_);
         _loc7_.addChild(_loc14_);
         return _loc7_;
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.addEventListener(param1,param2);
      }
      
      public static function triggerEvent(param1:String, param2:Object) : void
      {
         _dispatcher.triggerEvent(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.removeEventListener(param1,param2);
      }
   }
}
