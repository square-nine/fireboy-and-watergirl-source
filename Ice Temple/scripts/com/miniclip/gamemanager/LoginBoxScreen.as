package com.miniclip.gamemanager
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.display.ModalTrap;
   import com.miniclip.events.AuthenticationEvent;
   import com.miniclip.events.BlackBoxEvent;
   import com.miniclip.events.LoginBoxEvent;
   import com.miniclip.gamemanager.player.LoginScreens;
   import com.miniclip.logger;
   import com.miniclip.net.authentication.AuthenticationClient;
   import core.uri;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
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
   
   public class LoginBoxScreen extends EventDispatcher
   {
       
      
      private var _blackbox:BlackBox;
      
      private var _authclient:AuthenticationClient;
      
      private var _loader:Loader;
      
      private var _context:LoaderContext;
      
      private var _info:LoaderInfo;
      
      private var _AuthEvent:Class;
      
      private var _loaded:Boolean;
      
      private var _ready:Boolean;
      
      private var _checkUserDetails:Boolean;
      
      private var _showBackground:Boolean;
      
      private var _showCancelButton:Boolean;
      
      private var _debug:Boolean;
      
      private var _screen:LoginScreens;
      
      private var _position:Point;
      
      private var _sessid:String;
      
      private var _stage:Stage;
      
      private var _UI:*;
      
      private var _modalTrap:ModalTrap;
      
      public function LoginBoxScreen(param1:BlackBox, param2:AuthenticationClient, param3:Boolean = true, param4:Boolean = true, param5:LoginScreens = null, param6:Point = null, param7:Boolean = false, param8:Boolean = false)
      {
         super();
         _blackbox = param1;
         _authclient = param2;
         _showBackground = param3;
         _showCancelButton = param4;
         _screen = param5;
         _position = param6;
         _loader = new Loader();
         _loaded = false;
         _ready = false;
         _checkUserDetails = param8;
         _debug = param7;
         _sessid = "";
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
            _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
            _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
         }
      }
      
      private function _hookModuleEvents() : void
      {
         _info.content.addEventListener(_AuthEvent.LOGIN,onLogin,false,0,true);
         _info.content.addEventListener(_AuthEvent.LOGIN_CANCELLED,onLoginCancel,false,0,true);
         _info.content.addEventListener(_AuthEvent.SIGNUP,onSignup,false,0,true);
      }
      
      private function _unhookModuleEvents() : void
      {
         if(_info)
         {
            _info.content.removeEventListener(_AuthEvent.LOGIN,onLogin);
            _info.content.removeEventListener(_AuthEvent.LOGIN_CANCELLED,onLoginCancel);
            _info.content.removeEventListener(_AuthEvent.SIGNUP,onSignup);
         }
      }
      
      private function _factory() : void
      {
         _stage = _blackbox.stage;
         _modalTrap = new ModalTrap(_blackbox.stage,16777215,0.5);
         _modalTrap.hide();
         if(_blackbox.variables["mc_sessid"])
         {
            _sessid = _blackbox.variables["mc_sessid"];
         }
         if(!_checkUserDetails)
         {
            _load();
         }
         else
         {
            _authclient.addEventListener(AuthenticationEvent.USER_DETAILS,onUserDetails,false,0,true);
            _authclient.getMemberDetails();
         }
      }
      
      private function _alignCenter() : void
      {
         x = Math.floor((_stage.stageWidth - width + 4) / 2);
         y = Math.floor((_stage.stageHeight - height + 4) / 2);
      }
      
      private function _load() : void
      {
         var _loc1_:Boolean = true;
         var _loc2_:URLVariables = new URLVariables();
         if(_blackbox.isLocal() || _blackbox.isAllowed())
         {
            _loc1_ = true;
            if(_blackbox.isLocal() && !_blackbox.globalconfig.showLoginBox)
            {
               _loc1_ = false;
            }
         }
         else
         {
            _loc1_ = false;
         }
         if(!_loc1_)
         {
            trace("WE ARE NOT ALLOWED TO LAUNCH THE LOGINBOX");
            return;
         }
         if(_sessid != "")
         {
            _loc2_["mc_sessid"] = _sessid;
         }
         if(Boolean(_blackbox.localconfig.signupad) && _blackbox.localconfig.signupad != "")
         {
            _loc2_["pushad"] = _blackbox.localconfig.signupad;
         }
         var _loc3_:Array = [];
         _loc3_.push("dont_notify");
         if(_showCancelButton)
         {
            _loc3_.push("cancel_btn");
         }
         _loc2_["cfg"] = _loc3_.join(",");
         _loc2_["screen"] = _screen.toString();
         _hookEvents();
         var _loc4_:uri = new uri(_blackbox.moduleURL);
         if(_blackbox.isLocal() || _loc4_.host == BlackBox.developerServer || Strings.endsWith(_loc4_.host,"." + BlackBox.developerServer))
         {
            _loc4_.host = BlackBox.productionServer;
         }
         _loc4_.query = "";
         _loc4_.fragment = "";
         var _loc5_:URLRequest;
         (_loc5_ = new URLRequest(_loc4_.toString())).data = _loc2_;
         _loader.load(_loc5_,_context);
      }
      
      private function _unload() : void
      {
         _unhookEvents();
         _ready = false;
         _loaded = false;
         _loader.unload();
         if(_showBackground)
         {
            _modalTrap.hide();
         }
         _stage.removeChild(_loader);
         _modalTrap.destroy();
         _blackbox.localinfo = null;
         _loader = null;
         _UI = null;
         _info = null;
         _AuthEvent = null;
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
         _info = _loader.contentLoaderInfo;
         _AuthEvent = _info.applicationDomain.getDefinition("com.miniclip.net.authentication.AuthenticationEvent") as Class;
         _hookModuleEvents();
         _loaded = true;
         _ready = true;
         _UI = _loader;
         _blackbox.localinfo = _loader.contentLoaderInfo;
         if(_showBackground)
         {
            _modalTrap.show();
         }
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
         dispatchEvent(new LoginBoxEvent(LoginBoxEvent.READY));
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         _unhookEvents();
         logger.error("LoginBoxScreen load fail: " + param1.text);
         dispatchEvent(new LoginBoxEvent(LoginBoxEvent.ERROR));
      }
      
      private function onLogin(param1:*) : void
      {
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.LOGIN,param1.data));
      }
      
      private function onLoginCancel(param1:*) : void
      {
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.LOGIN_CANCELLED));
      }
      
      private function onSignup(param1:*) : void
      {
         dispatchEvent(new AuthenticationEvent(AuthenticationEvent.SIGNUP));
      }
      
      private function onUserDetails(param1:AuthenticationEvent) : void
      {
         dispatchEvent(param1);
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
         return 328;
      }
      
      public function get height() : Number
      {
         return 204;
      }
      
      public function get visible() : Boolean
      {
         if(!ready)
         {
            return false;
         }
         return _UI.visible;
      }
      
      public function get ready() : Boolean
      {
         return _ready;
      }
      
      public function show() : void
      {
      }
      
      public function close() : void
      {
         _unhookEvents();
         _unhookModuleEvents();
         if(!_loaded || !_ready)
         {
            return;
         }
         _unload();
      }
   }
}
