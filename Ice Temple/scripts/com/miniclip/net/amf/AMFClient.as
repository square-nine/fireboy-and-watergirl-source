package com.miniclip.net.amf
{
   import com.miniclip.logger;
   import com.miniclip.net.config;
   import com.miniclip.utils.StringUtil;
   import core.uri;
   import flash.events.AsyncErrorEvent;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.NetConnection;
   import flash.net.Responder;
   import flash.utils.Timer;
   import system.Strings;
   
   public class AMFClient extends EventDispatcher
   {
       
      
      private var _gateway:String;
      
      private var _serviceName:String;
      
      private var _timeOut:uint;
      
      private var _timedOut:Boolean = false;
      
      private var _connection:NetConnection;
      
      private var _responder:Responder;
      
      private var _timer:Timer;
      
      private var _busy:Boolean = false;
      
      private var errorGateway:String = "the gateway \"{0}\" is not valid";
      
      public function AMFClient(param1:String = null, param2:String = null, param3:uint = 0)
      {
         super();
         if(param1 != null)
         {
            _gateway = param1;
         }
         else
         {
            _gateway = defaultGateway;
         }
         if(param2 != null)
         {
            _serviceName = param2;
         }
         else
         {
            _serviceName = defaultServiceName;
         }
         if(param3 != 0)
         {
            _timeOut = param3;
         }
         else
         {
            _timeOut = defaultTimeout;
         }
         var _loc4_:String = "";
         if(_gateway == null || _gateway == "")
         {
            _loc4_ = "AMFClient Error! gateway or defaultGateway not specified.";
            logger.error(_loc4_);
            throw new Error(_loc4_);
         }
         if(_serviceName == null || _serviceName == "")
         {
            _loc4_ = "AMFClient Error! serviceName or defaultServicename not specified.";
            logger.error(_loc4_);
            throw new Error(_loc4_);
         }
         if(!_verifyGateway(_gateway))
         {
            throw new Error(StringUtil.format(errorGateway,_gateway));
         }
         _factory();
      }
      
      public static function get verbose() : Boolean
      {
         return config.AMFVerbose;
      }
      
      public static function set verbose(param1:Boolean) : void
      {
         config.AMFVerbose = param1;
      }
      
      public static function set defaultGateway(param1:String) : void
      {
         config.AMFDefaultGateway = param1;
      }
      
      public static function get defaultGateway() : String
      {
         return config.AMFDefaultGateway;
      }
      
      public static function set defaultServiceName(param1:String) : void
      {
         config.AMFDefaultServiceName = param1;
      }
      
      public static function get defaultServiceName() : String
      {
         return config.AMFDefaultServiceName;
      }
      
      public static function get defaultTimeout() : uint
      {
         return config.AMFDefaultTimeout;
      }
      
      public static function set defaultTimeout(param1:uint) : void
      {
         config.AMFDefaultTimeout = param1;
      }
      
      private function _hookEvents() : void
      {
         _connection.addEventListener(NetStatusEvent.NET_STATUS,onNetStatusEvent);
         _connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onAsyncError);
         _connection.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
      }
      
      private function _unhookEvents() : void
      {
         _connection.removeEventListener(NetStatusEvent.NET_STATUS,onNetStatusEvent);
         _connection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,onAsyncError);
         _connection.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
         _connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
      }
      
      private function _log(param1:String) : void
      {
         if(verbose)
         {
            logger.log(param1);
         }
      }
      
      private function _factory() : void
      {
         _connection = new NetConnection();
         _connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR,_onAsyncError,false,0,true);
         _connection.addEventListener(IOErrorEvent.IO_ERROR,_onIOError,false,0,true);
         _connection.addEventListener(NetStatusEvent.NET_STATUS,_onNetStatus,false,0,true);
         _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_onSecurytyError,false,0,true);
         _connection.objectEncoding = config.AMFEncoding;
         _responder = new Responder(_responses,_faults);
         _timer = new Timer(_timeOut,1);
      }
      
      private function _onAsyncError(param1:AsyncErrorEvent) : void
      {
      }
      
      private function _onIOError(param1:IOErrorEvent) : void
      {
      }
      
      private function _onNetStatus(param1:NetStatusEvent) : void
      {
      }
      
      private function _onSecurytyError(param1:SecurityErrorEvent) : void
      {
      }
      
      private function _verifyGateway(param1:String) : Boolean
      {
         var _loc2_:uri = new uri(param1);
         _loc2_.query = "";
         _loc2_.fragment = "";
         if(Strings.startsWith(_loc2_.toString(),"http") && Strings.endsWith(_loc2_.toString(),"gateway.php"))
         {
            return true;
         }
         return false;
      }
      
      private function _connect() : void
      {
         if(!_verifyGateway(_gateway))
         {
            logger.error(StringUtil.format(errorGateway,_gateway));
         }
         _hookEvents();
         try
         {
            _connection.connect(_gateway);
         }
         catch(e:ArgumentError)
         {
            logger.error("The URI \"" + _gateway + "\" passed to the command parameter is improperly formatted.");
         }
      }
      
      private function _responses(param1:Object) : void
      {
         if(!_timedOut)
         {
            _stopTimer();
            dispatchEvent(new AMFDataEvent(param1));
         }
      }
      
      private function _faults(param1:Object) : void
      {
         _stopTimer();
         dispatchEvent(new AMFErrorEvent(param1));
      }
      
      private function _startTimer() : void
      {
         _timedOut = false;
         _timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeout);
         _timer.start();
      }
      
      private function _stopTimer() : void
      {
         _timedOut = false;
         _timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeout);
         _timer.stop();
         _timer.reset();
      }
      
      private function onNetStatusEvent(param1:NetStatusEvent) : void
      {
         _unhookEvents();
         _stopTimer();
         dispatchEvent(new AMFErrorEvent(param1.info));
      }
      
      private function onAsyncError(param1:AsyncErrorEvent) : void
      {
         _unhookEvents();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         _unhookEvents();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         _unhookEvents();
      }
      
      private function onTimeout(param1:TimerEvent) : void
      {
         _timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeout);
         _unhookEvents();
         _timedOut = true;
         dispatchEvent(new AMFTimeoutEvent());
      }
      
      public function call(param1:String, ... rest) : void
      {
         _connect();
         var _loc3_:String = _serviceName + "." + param1;
         var _loc4_:Function = _connection.call;
         rest.unshift(_responder);
         rest.unshift(_loc3_);
         _startTimer();
         _loc4_.apply(null,rest);
      }
   }
}
