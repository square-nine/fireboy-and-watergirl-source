package com.spilgames.api
{
   import com.spilgames.bs.BrandingManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.SecurityDomain;
   import flash.utils.*;
   
   public class SpilGamesServices extends MovieClip
   {
      
      public static const LOCALE_CHANGED:String = "localeChanged";
      
      public static const DEFAULT_CONFIG_ID:String = "f91d4382c704d7e567a5a58246e939d5";
      
      public static const INVALID_ITEM_ID:String = "";
      
      public static const INVALID_ID:int = 0;
      
      public static const INVALID_DOMAIN:String = "invalidDomain";
      
      public static const CONFIGURATION_FAILED:String = "configurationFailure";
      
      public static const INITIALIZATION_FAILED:String = "initializationFailed";
      
      public static const COMPONENTS_READY:String = "componentsReady";
      
      public static const COMPONENTS_FAILED:String = "componentsFailed";
      
      public static const SERVICES_READY:String = "servicesReady";
      
      public static const SERVICE_ERROR:String = "serviceError";
      
      private static const PORTALSERVICE:String = "portalservice";
      
      private static const CONFIG_QUERY_STRING:String = "?type=live&nocache=" + String(int(Math.random() * 1000));
      
      private static const CONFIG_URL:String = "http://api.configar.org/cf/pb/1/settings";
      
      private static var _instance:SpilGamesServices = null;
      
      private static const MAX_CONNECTION_LOAD_RETRIES:uint = 1;
       
      
      private var _flashVars:Object;
      
      private const DEFAULT_CONNECTION_LOCATION:String = "../../../../sdk/spilapi/" + BuildVersion.BUILD_NUMBER + "/ServicesConnection.swf";
      
      private const FALLBACK_CONNECTION_LOCATION:String = "http://www8.agame.com/sdk/spilapi/1.3.1/ServicesConnection.swf";
      
      private var _fallbackState:int = 0;
      
      private var _servicesConnection:* = null;
      
      private var _debugMode:Boolean = false;
      
      private var _options:Object = null;
      
      private var _loader:Loader;
      
      private var _request:URLRequest;
      
      private var _connecting:Boolean = false;
      
      private var _connected:Boolean = false;
      
      private var _numConnectionLoadTries:uint = 0;
      
      private var _embeddedLocalizationPack:*;
      
      private var _configXML:XML;
      
      private var _configID:String;
      
      private var _alwaysInFront:Boolean = false;
      
      private var _context:LoaderContext;
      
      private var currentDelay:Number = 0;
      
      private var previousFrameTime:Number;
      
      public function SpilGamesServices(param1:Private = null)
      {
         super();
         this.initConstructor(param1);
      }
      
      public static function getInstance() : SpilGamesServices
      {
         if(!_instance)
         {
            _instance = new SpilGamesServices(new Private());
         }
         return _instance;
      }
      
      public function get configXML() : XML
      {
         return this._configXML;
      }
      
      public function get version() : String
      {
         return BuildVersion.BUILD_NUMBER;
      }
      
      public function get connecting() : Boolean
      {
         return this._connecting;
      }
      
      public function get connected() : Boolean
      {
         return this._connected;
      }
      
      public function get connection() : *
      {
         return this._servicesConnection;
      }
      
      public function set alwaysInFront(param1:Boolean) : void
      {
         if(this._alwaysInFront != param1)
         {
            this._alwaysInFront = param1;
            if(this._alwaysInFront)
            {
               addEventListener(Event.ENTER_FRAME,this.bringToFront);
            }
            else
            {
               removeEventListener(Event.ENTER_FRAME,this.bringToFront);
            }
         }
      }
      
      public function get alwaysInFront() : Boolean
      {
         return this._alwaysInFront;
      }
      
      private function loadAPI(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:String = null;
         var _loc4_:URLVariables = null;
         var _loc5_:Date = null;
         if(!this._connecting && !this._connected)
         {
            if(this.parent)
            {
               this.validateOptions(this.parent,this._configID);
            }
            this._connecting = true;
            BrandingManager.getInstance();
            addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
            if(param1 != "")
            {
               _loc3_ = param1;
            }
            else if(Boolean(root.loaderInfo.parameters["servicesLoc"]) && root.loaderInfo.parameters["servicesLoc"].length > 0)
            {
               _loc3_ = String(root.loaderInfo.parameters["servicesLoc"]);
            }
            else
            {
               _loc3_ = this.DEFAULT_CONNECTION_LOCATION;
               _loc4_ = new URLVariables();
               _loc5_ = new Date();
               _loc4_.nocache = _loc5_.milliseconds;
               _loc4_.useDraft = param2;
               this._request = new URLRequest(_loc3_);
               this._request.data = _loc4_;
            }
            this.allowDomain();
            if(!this._request)
            {
               this._request = new URLRequest(_loc3_);
            }
            this._context = new LoaderContext(false,ApplicationDomain.currentDomain);
            if(Security.sandboxType == Security.REMOTE)
            {
               this._context.securityDomain = SecurityDomain.currentDomain;
            }
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.INIT,this.onLoadComplete);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._loader.load(this._request,this._context);
         }
      }
      
      public function connect(param1:DisplayObject, param2:String, param3:Boolean = false, param4:* = null) : void
      {
         var _loc5_:String = null;
         var _loc6_:URLLoader = null;
         param1.stage.addChild(this);
         this.getFlashVars();
         if(param2 == null)
         {
            throw new TypeError("You must supply a configID");
         }
         this._embeddedLocalizationPack = param4;
         if(!param3)
         {
            if(!this._flashVars.channelID)
            {
               this._flashVars.channelID = "0";
            }
            if(!this._flashVars.siteID)
            {
               this._flashVars.siteID = "0";
            }
            _loc5_ = CONFIG_URL + "/" + this._flashVars.channelID + "/" + this._flashVars.siteID + "/" + param2 + CONFIG_QUERY_STRING;
            (_loc6_ = new URLLoader()).addEventListener(Event.COMPLETE,this.onConfigurationLoaded);
            _loc6_.load(new URLRequest(_loc5_));
         }
         else
         {
            this._debugMode = true;
         }
      }
      
      private function onConfigurationLoaded(param1:Event) : void
      {
         var config:String = null;
         var regExp:RegExp = null;
         var configurator:XMLList = null;
         var apiLocation:String = null;
         var evt:Event = param1;
         config = String(evt.currentTarget.data);
         regExp = /(\t|\n|\s{2,})/g;
         config = config.replace(regExp,"");
         this._configXML = new XML(config);
         configurator = this._configXML..component.(@name == "Configurator");
         apiLocation = String(configurator..property.(@name == "apiLocation").@value.toString());
         this.loadAPI(apiLocation);
      }
      
      public function disconnect() : void
      {
         if(this._servicesConnection)
         {
            this._servicesConnection.removeEventListener(Event.COMPLETE,this.onServicesReady);
            this._servicesConnection.removeEventListener(ErrorEvent.ERROR,this.onInitializationError);
            this._servicesConnection.removeEventListener("serviceError",this.onServiceError);
            this._servicesConnection.removeEventListener(COMPONENTS_READY,this.onComponentsReady);
            if(this._connected)
            {
               this._servicesConnection.disconnect();
            }
            removeChild(this._servicesConnection);
         }
         this._servicesConnection = null;
         if(this._loader)
         {
            try
            {
               this._loader.close();
            }
            catch(e:Error)
            {
            }
            finally
            {
               this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadComplete);
               this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            }
            this._loader = null;
         }
         removeEventListener(Event.ENTER_FRAME,this.bringToFront);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         if(parent)
         {
            parent.removeChild(this);
         }
         this._connected = this._connecting = false;
         if(this.isDebugMode())
         {
         }
      }
      
      public function getChannelID() : int
      {
         var _loc1_:int = INVALID_ID;
         if(this._servicesConnection != null)
         {
            _loc1_ = int(this._servicesConnection.getChannelID());
         }
         if(this.isDebugMode())
         {
            return 0;
         }
         return _loc1_;
      }
      
      public function getSiteID() : int
      {
         var _loc1_:int = INVALID_ID;
         if(this._servicesConnection != null)
         {
            _loc1_ = int(this._servicesConnection.getSiteID());
         }
         if(this.isDebugMode())
         {
            return 0;
         }
         return _loc1_;
      }
      
      public function getItemID() : String
      {
         var _loc1_:String = INVALID_ITEM_ID;
         if(this._servicesConnection != null)
         {
            _loc1_ = String(this._servicesConnection.getItemID());
         }
         if(this.isDebugMode())
         {
            return INVALID_ITEM_ID;
         }
         return _loc1_;
      }
      
      public function isReady() : Boolean
      {
         if(this.isDebugMode())
         {
            return true;
         }
         return this._servicesConnection != null && Boolean(this._servicesConnection.isReady());
      }
      
      public function isDomainAllowed() : Boolean
      {
         if(this.isDebugMode())
         {
            return true;
         }
         return this._servicesConnection != null && Boolean(this._servicesConnection.isDomainValid());
      }
      
      public function isServiceAvailable(param1:String) : Boolean
      {
         if(this.isDebugMode())
         {
            return true;
         }
         return this.isReady() && Boolean(this._servicesConnection.isServiceAvailable(param1));
      }
      
      public function isDebugMode() : Boolean
      {
         return this._debugMode;
      }
      
      public function send(param1:String, param2:String, param3:Function, param4:Object = null) : int
      {
         var _loc5_:int = INVALID_ID;
         if(this.isReady() && !this.isDebugMode())
         {
            _loc5_ = int(this._servicesConnection.send(param1,param2,param3,param4));
         }
         return _loc5_;
      }
      
      public function callPortalMethod(param1:String, param2:Function = null, param3:Object = null) : int
      {
         return this.send(PORTALSERVICE,param1,param2,param3);
      }
      
      public function getProperty(param1:String, param2:String, param3:*) : *
      {
         var _loc4_:* = param3;
         if(this.isReady() && this._servicesConnection.hasOwnProperty("getProperty") && !this.isDebugMode())
         {
            _loc4_ = this._servicesConnection.getProperty(param1,param2,param3);
         }
         else
         {
            (_loc4_ = new Object()).serviceID = 0;
            _loc4_.propertyName = "DebugObject";
            _loc4_.defaultValue = 0;
         }
         return _loc4_;
      }
      
      public function allowDomain(param1:String = "*") : void
      {
         Security.allowDomain(param1);
         Security.allowInsecureDomain(param1);
      }
      
      private function initConstructor(param1:Private) : void
      {
         if(!param1)
         {
            throw new Error("Cannot instantiate this class directly, " + "use SpilGamesServices.getInstance() instead.");
         }
      }
      
      private function validateOptions(param1:DisplayObjectContainer, param2:String) : void
      {
         if(!param1)
         {
            throw new Error("The \'clip\' parameter cannot be null");
         }
         if(!param1.stage)
         {
            throw new Error("The given clip must be present in the " + "display list (added to stage)");
         }
         this._options = new Object();
         this._options.configID = param2;
         this._options.hostApplicationDomain = ApplicationDomain.currentDomain;
         this._options.embeddedLocalizationPack = this._embeddedLocalizationPack;
      }
      
      public function bringToFront(param1:Event = null) : void
      {
         var event:Event = param1;
         if(parent)
         {
            try
            {
               parent.setChildIndex(this,parent.numChildren - 1);
            }
            catch(error:Error)
            {
               removeEventListener(Event.ENTER_FRAME,bringToFront);
            }
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._servicesConnection = LoaderInfo(param1.target).content;
         this._servicesConnection.addEventListener(Event.COMPLETE,this.onServicesReady);
         this._servicesConnection.addEventListener(ErrorEvent.ERROR,this.onInitializationError);
         this._servicesConnection.addEventListener("serviceError",this.onServiceError);
         this._servicesConnection.addEventListener(COMPONENTS_READY,this.onComponentsReady);
         this._servicesConnection.addEventListener(LOCALE_CHANGED,this.onLocaleChanged);
         if(this._servicesConnection.hasOwnProperty("setOptions"))
         {
            this._servicesConnection.setOptions(this._options);
         }
         addChild(this._servicesConnection);
         this._servicesConnection.setConfig(this._configXML,this._embeddedLocalizationPack);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         ++this._numConnectionLoadTries;
         if(this._numConnectionLoadTries > MAX_CONNECTION_LOAD_RETRIES)
         {
            this._request = null;
            this._connecting = false;
            switch(this._fallbackState)
            {
               case 0:
                  this.retryConnection(this.DEFAULT_CONNECTION_LOCATION);
                  break;
               case 1:
                  this.retryConnection(this.FALLBACK_CONNECTION_LOCATION);
                  break;
               case 2:
                  this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadComplete);
                  this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
                  if(hasEventListener(param1.type))
                  {
                     dispatchEvent(param1);
                  }
            }
         }
         else
         {
            this.previousFrameTime = getTimer();
            addEventListener(Event.ENTER_FRAME,this.updateConnectionRetry);
         }
      }
      
      private function retryConnection(param1:String) : void
      {
         ++this._fallbackState;
         this._numConnectionLoadTries = 0;
         this.loadAPI(param1);
      }
      
      private function updateConnectionRetry(param1:Event) : void
      {
         var _loc2_:Number = getTimer();
         var _loc3_:Number = (_loc2_ - this.previousFrameTime) / 1000;
         this.currentDelay += _loc3_;
         if(this.currentDelay >= 2)
         {
            this._loader.load(this._request,this._context);
            removeEventListener(Event.ENTER_FRAME,this.updateConnectionRetry);
            this.currentDelay = 0;
         }
         this.previousFrameTime = _loc2_;
      }
      
      private function onServicesReady(param1:Event) : void
      {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._connected = true;
         this._connecting = false;
         dispatchEvent(new Event(SERVICES_READY));
      }
      
      private function onInitializationError(param1:ErrorEvent) : void
      {
         this._servicesConnection.removeEventListener(Event.COMPLETE,this.onServicesReady);
         this._servicesConnection.removeEventListener(ErrorEvent.ERROR,this.onInitializationError);
         this._servicesConnection.removeEventListener("serviceError",this.onServiceError);
         this._servicesConnection.removeEventListener(COMPONENTS_READY,this.onComponentsReady);
         this._connecting = false;
         if(hasEventListener(INITIALIZATION_FAILED))
         {
            dispatchEvent(new ErrorEvent(INITIALIZATION_FAILED,false,false,param1.text));
         }
      }
      
      private function onServiceError(param1:Event) : void
      {
         var _loc2_:String = null;
         if(hasEventListener(SERVICE_ERROR))
         {
            _loc2_ = "";
            if(param1 is ErrorEvent)
            {
               _loc2_ = ErrorEvent(param1).text;
            }
            else
            {
               _loc2_ = param1.toString();
            }
            dispatchEvent(new ErrorEvent(SERVICE_ERROR,false,false,_loc2_));
         }
      }
      
      private function onComponentsReady(param1:Event) : void
      {
         this._servicesConnection.removeEventListener(COMPONENTS_READY,this.onComponentsReady);
         if(hasEventListener(COMPONENTS_READY))
         {
            dispatchEvent(new Event(COMPONENTS_READY));
         }
      }
      
      private function onLocaleChanged(param1:Event) : void
      {
         if(hasEventListener(LOCALE_CHANGED))
         {
            dispatchEvent(new Event(LOCALE_CHANGED));
         }
      }
      
      public function get flashVars() : Object
      {
         if(!this._flashVars)
         {
            this.getFlashVars();
         }
         return this._flashVars;
      }
      
      private function getFlashVars() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         this._flashVars = new Object();
         if(Boolean(parent) && Boolean(parent.loaderInfo))
         {
            _loc1_ = parent.loaderInfo.parameters;
            _loc2_ = this.loaderInfo.parameters;
            this._flashVars.userName = _loc1_.username != null ? _loc1_.username : "";
            this._flashVars.userHash = _loc1_.hash != null ? _loc1_.hash : "";
            this._flashVars.channelID = _loc1_.c;
            this._flashVars.siteID = _loc1_.s;
            this._flashVars.itemID = _loc1_.id;
            this._flashVars.scoreDomain = _loc1_.scoreDomain;
            this._flashVars.debugMode = _loc2_.debugMode == "false" ? false : true;
            this._flashVars.serviceOverwriteMask = _loc1_.som != null ? _loc1_.som : 4294967295;
            this._flashVars.serviceEnvironmentOverwriteID = _loc1_.dev != null ? _loc1_.dev : "UNKNOWN";
         }
      }
   }
}

class Private
{
    
   
   public function Private()
   {
      super();
   }
}
