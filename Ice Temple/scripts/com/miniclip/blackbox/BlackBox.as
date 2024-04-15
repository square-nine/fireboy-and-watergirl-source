package com.miniclip.blackbox
{
   import com.miniclip.events.BlackBoxEvent;
   import com.miniclip.hack;
   import com.miniclip.logger;
   import core.uri;
   import flash.display.LoaderInfo;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import system.Strings;
   import system.eden;
   
   use namespace hack;
   
   public final class BlackBox extends EventDispatcher
   {
      
      private static var _current:BlackBox;
      
      private static var _reservedDomain:String;
      
      private static var _localServer:String;
      
      private static var _developerServer:String;
      
      private static var _internalServer:String;
      
      private static var _productionServer:String;
      
      private static var _liveServer:String;
      
      private static var _cdnserver:String;
      
      private static var _librarySignature:String;
      
      private static var _globalconfigSignature:String;
      
      private static var _flexSignature:String;
       
      
      private var _module:Module;
      
      private var _parent:BlackBox;
      
      private var _childs:Object;
      
      private var _developerName:String;
      
      private var _stage:Stage;
      
      private var _info:LoaderInfo;
      
      private var _localinfo:LoaderInfo;
      
      private var _config:URLLoader;
      
      private var _ready:Boolean;
      
      private var _configLoaded:Boolean;
      
      private var _imported:Boolean;
      
      private var _url:uri;
      
      private var _moduleURL:uri;
      
      private var _gatewayURL:uri;
      
      private var _variables:URLVariables;
      
      private var _usedAlternate:Boolean;
      
      private var _library:Boolean;
      
      private var _flex:Boolean;
      
      private var _globalconfig:Object;
      
      private var _logger:*;
      
      public function BlackBox(param1:Module, param2:BlackBox = null, param3:Stage = null, param4:String = null)
      {
         var _loc5_:Namespace = null;
         var _loc6_:String = null;
         _logger = logger;
         super();
         _ready = false;
         _configLoaded = false;
         _imported = false;
         _developerName = "";
         if(param4 == null)
         {
            param4 = "com.miniclip.gamemanager.config";
         }
         if(param2 == null)
         {
            _loc5_ = SecurityProvider.getAuthorization(this);
            _loc6_ = _getCustomDeveloperSubDomain(param3,SecurityProvider._loc5_::developerServer);
            _developerName = _loc6_;
            BlackBox.hack::defineReservedDomain(SecurityProvider._loc5_::reservedDomain);
            BlackBox.hack::defineLocalServer(SecurityProvider._loc5_::localServer);
            BlackBox.hack::defineDeveloperServer(_loc6_ + SecurityProvider._loc5_::developerServer);
            BlackBox.hack::defineInternalServer(SecurityProvider._loc5_::internalServer);
            BlackBox.hack::defineProductionServer(SecurityProvider._loc5_::productionServer);
            BlackBox.hack::defineLiveServer(SecurityProvider._loc5_::liveServer);
            BlackBox.hack::defineCDNServer(SecurityProvider._loc5_::CDNServer);
            BlackBox.hack::defineLibrarySignature("com.miniclip.GameManagerLibrary");
            BlackBox.hack::defineGlobalconfigSignature(param4);
            BlackBox.hack::defineFlexSignature("mx.core.Application");
         }
         _module = param1;
         _parent = param2;
         _childs = {};
         _stage = param3;
         if(param3)
         {
            _info = param3.loaderInfo;
         }
         else
         {
            _info = null;
         }
         _config = new URLLoader();
         _config.dataFormat = URLLoaderDataFormat.TEXT;
         if(_parent)
         {
            _imported = _parent.isImported();
            _developerName = _parent.developerName;
            _parent._registerChild(this);
            _updateURL(_parent.url.toString());
         }
         else if(_info)
         {
            _fromLoader(_info);
            _defineCurrent();
         }
         _config.addEventListener(Event.COMPLETE,onConfigLoaded);
         _config.addEventListener(IOErrorEvent.IO_ERROR,onConfigError);
      }
      
      public static function get current() : BlackBox
      {
         return _current;
      }
      
      public static function get reservedDomain() : String
      {
         return _reservedDomain;
      }
      
      public static function get localServer() : String
      {
         return _localServer;
      }
      
      public static function get developerServer() : String
      {
         return _developerServer;
      }
      
      public static function get internalServer() : String
      {
         return _internalServer;
      }
      
      public static function get productionServer() : String
      {
         return _productionServer;
      }
      
      public static function get liveServer() : String
      {
         return _liveServer;
      }
      
      public static function get CDNServer() : String
      {
         return _cdnserver;
      }
      
      public static function get librarySignature() : String
      {
         return _librarySignature;
      }
      
      public static function get globalconfigSignature() : String
      {
         return _globalconfigSignature;
      }
      
      public static function get flexSignature() : String
      {
         return _flexSignature;
      }
      
      hack static function defineCurrent(param1:BlackBox) : void
      {
         if(current == null)
         {
            _current = param1;
         }
      }
      
      hack static function defineReservedDomain(param1:String) : void
      {
         _reservedDomain = param1;
      }
      
      hack static function defineLocalServer(param1:String) : void
      {
         _localServer = param1;
      }
      
      hack static function defineDeveloperServer(param1:String) : void
      {
         _developerServer = param1;
      }
      
      hack static function defineInternalServer(param1:String) : void
      {
         _internalServer = param1;
      }
      
      hack static function defineProductionServer(param1:String) : void
      {
         _productionServer = param1;
      }
      
      hack static function defineLiveServer(param1:String) : void
      {
         _liveServer = param1;
      }
      
      hack static function defineCDNServer(param1:String) : void
      {
         _cdnserver = param1;
      }
      
      hack static function defineLibrarySignature(param1:String) : void
      {
         _librarySignature = param1;
      }
      
      hack static function defineGlobalconfigSignature(param1:String) : void
      {
         _globalconfigSignature = param1;
      }
      
      hack static function defineFlexSignature(param1:String) : void
      {
         _flexSignature = param1;
      }
      
      hack static function dumpinfo(param1:LoaderInfo) : void
      {
      }
      
      private function _getCustomDeveloperSubDomain(param1:Stage, param2:String) : String
      {
         var _loc3_:String = "";
         if(param1 == null)
         {
            return _loc3_;
         }
         var _loc4_:String = param1.loaderInfo.url;
         var _loc5_:uri;
         if((_loc5_ = new uri(_loc4_)).host.indexOf("." + param2) > -1)
         {
            _loc3_ = _loc5_.host.split("." + param2).join("");
         }
         return _loc3_;
      }
      
      private function _fromLoader(param1:LoaderInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:uri = null;
         var _loc4_:String = null;
         var _loc5_:URLVariables = null;
         if(param1.url.indexOf("[[IMPORT]]") > -1)
         {
            _imported = true;
            _loc2_ = _parseURLforIMPORT(param1.url,true);
            _loc3_ = new uri(_loc2_);
            _loc4_ = _loc3_.query;
            _loc5_ = new URLVariables(_loc4_);
            _variables = _loc5_;
            _loc3_.fragment = "";
            _loc3_.query = "";
            _updateURL(_loc3_.toString());
         }
         else
         {
            _imported = false;
            _updateURL(param1.url);
            _buildVariables(param1.parameters);
         }
      }
      
      private function _defineCurrent() : void
      {
         BlackBox.hack::defineCurrent(this);
      }
      
      private function _registerChild(param1:BlackBox) : void
      {
         if(!hasChild(param1))
         {
            _childs[param1.name.toLowerCase()] = param1;
         }
      }
      
      private function _hasChildByName(param1:String) : Boolean
      {
         if(_childs[param1])
         {
            return true;
         }
         return false;
      }
      
      private function _hasChildByReference(param1:BlackBox) : Boolean
      {
         var _loc2_:String = param1.name.toLowerCase();
         if(_hasChildByName(_loc2_))
         {
            if(_childs[_loc2_] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function _parseURLforIMPORT(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(param1.indexOf("[[IMPORT]]") > -1)
         {
            _loc3_ = param1.split("/[[IMPORT]]/");
            _loc4_ = String(_loc3_[0].substring(0,_loc3_[0].lastIndexOf("/") + 1));
            _loc5_ = String(_loc3_[1].substring(_loc3_[1].indexOf("/")));
            _loc6_ = String(_loc3_[0].substring(_loc3_[0].lastIndexOf("/") + 1));
            _loc7_ = String(_loc3_[1].substring(0,_loc3_[1].indexOf("/")));
            _loc8_ = _loc4_;
            if(param2)
            {
               _loc8_ += _loc7_;
            }
            else
            {
               _loc8_ += _loc6_;
            }
            param1 = _loc8_ += _loc5_;
         }
         return param1;
      }
      
      private function _updateURL(param1:String) : void
      {
         _url = new uri(param1);
         if(param1 != "")
         {
            _defineCurrent();
         }
         if(!_configLoaded && module.configfile != "" && param1 != "")
         {
            _loadConfig();
         }
         else
         {
            _run();
         }
      }
      
      private function _getConfigFileFullPath() : String
      {
         var _loc2_:uri = null;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc1_:String = "";
         if(isRoot())
         {
            _loc2_ = new uri(url.toString());
         }
         else
         {
            _loc2_ = new uri(parent.url.toString());
         }
         if(_loc2_.path != "")
         {
            _loc2_.query = "";
            _loc2_.fragment = "";
            _loc3_ = _loc2_.toString();
            if((_loc4_ = _loc3_.lastIndexOf("/")) > -1)
            {
               _loc1_ += _loc3_.substring(0,_loc4_ + 1);
            }
         }
         return _loc1_ + module.configfile;
      }
      
      private function _loadConfig() : void
      {
         if(!module.config.blockLocalConfig && (isLocal() || isAllowed()))
         {
            _config.load(new URLRequest(_getConfigFileFullPath()));
         }
         else
         {
            _run();
         }
      }
      
      private function _forceRebuildAfterConfigLoad() : void
      {
         if(_moduleURL)
         {
            _moduleURL = _buildModuleURL(_url.toString());
         }
         if(_gatewayURL)
         {
            _gatewayURL = _buildGatewayURL(_url.toString());
         }
      }
      
      private function _buildVariables(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc2_:URLVariables = new URLVariables();
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         _variables = _loc2_;
      }
      
      private function _run() : void
      {
         if(!isRoot() && module.config.allowParametersInheritance)
         {
            _variables = parent.variables;
         }
         _forceRebuildAfterConfigLoad();
         _ready = true;
         dispatchEvent(new BlackBoxEvent(BlackBoxEvent.READY));
      }
      
      private function _hasHTML(param1:String) : Boolean
      {
         if(param1.indexOf("<!DOCTYPE") > -1)
         {
            return true;
         }
         if(param1.indexOf("<html") > -1)
         {
            return true;
         }
         if(param1.indexOf("<body") > -1)
         {
            return true;
         }
         if(param1.indexOf("<script") > -1)
         {
            return true;
         }
         return false;
      }
      
      private function _findFile(param1:String = "swf") : String
      {
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc2_:String = url.path;
         var _loc3_:uint = uint(_loc2_.lastIndexOf("." + param1));
         if(_loc3_ > -1)
         {
            _loc4_ = "";
            if((_loc5_ = uint(_loc2_.lastIndexOf("/",_loc3_))) > -1)
            {
               _loc4_ = _loc2_.substring(_loc5_ + 1,_loc3_ + 1 + param1.length);
            }
            else
            {
               _loc4_ = _loc2_;
            }
            return _loc4_;
         }
         return _loc2_;
      }
      
      private function _getModulePath(param1:String) : String
      {
         var _loc2_:BlackBox = null;
         if(isRoot())
         {
            _loc2_ = this;
         }
         else
         {
            _loc2_ = parent;
         }
         if(isKnownFile())
         {
            if(isDebugFile())
            {
               param1 = param1.replace(_loc2_.module.debugfile,"");
            }
            else
            {
               param1 = param1.replace(_loc2_.module.file,"");
            }
         }
         else
         {
            param1 = param1.replace(_loc2_._findFile(),"");
         }
         if(param1 == "")
         {
            param1 = "/";
         }
         if(param1.indexOf(moduleFile) > 0)
         {
            param1 = param1.replace(moduleFile,"");
         }
         return param1;
      }
      
      private function _getModuleFile() : String
      {
         var _loc1_:String = "";
         if(module.alternatefile != "" && module.config.useAlternate)
         {
            return module.alternatefile;
         }
         if(isDebugFile())
         {
            if(module.debugfile != "")
            {
               _loc1_ = module.debugfile;
            }
            else
            {
               _loc1_ = module.file;
            }
         }
         else
         {
            _loc1_ = module.file;
         }
         return _loc1_;
      }
      
      private function _buildModuleURL(param1:String) : uri
      {
         var _loc2_:Boolean = false;
         var _loc3_:uri = new uri(param1);
         if(isRoot())
         {
            return _loc3_;
         }
         _loc3_ = new uri(parent.url.toString());
         if(isLocal())
         {
            if(module.config.allowLocal && module.config.allowFileProtocol)
            {
               _loc3_.path = _getModulePath(_loc3_.path);
               _loc3_.path += _getModuleFile();
            }
            else if(module.config.allowLocal)
            {
               _loc3_ = new uri("http://" + BlackBox.productionServer);
               _loc2_ = true;
            }
            else
            {
               _loc3_ = new uri("http://" + BlackBox.internalServer);
               _loc2_ = true;
            }
         }
         if(!isLocal() || _loc2_)
         {
            if(module.path == "")
            {
               if(module.config.allowParentPath)
               {
                  _loc3_.path = _getModulePath(_loc3_.path);
               }
               else
               {
                  _loc3_.path = "/";
               }
               _loc3_.path += _getModuleFile();
            }
            else
            {
               _loc3_.path = module.path;
               _loc3_.path += _getModuleFile();
            }
         }
         _loc3_.query = "";
         _loc3_.fragment = "";
         return _loc3_;
      }
      
      private function _buildGatewayURL(param1:String) : uri
      {
         var _loc2_:uri = new uri(param1);
         if(_loc2_.host == BlackBox.internalServer || _loc2_.host == BlackBox.developerServer || Strings.endsWith(_loc2_.host,"." + BlackBox.developerServer) || _loc2_.host == BlackBox.localServer || _loc2_.host == "")
         {
            globalconfig.AMFClientVerbose = true;
         }
         if(isRoot() || module.gatewaypath != "")
         {
            _loc2_.path = module.gatewaypath;
         }
         else
         {
            _loc2_.path = parent.module.gatewaypath;
         }
         if(isLocal())
         {
            _loc2_.scheme = "http";
            if(module.config.allowLocal && !globalconfig.forceConnectionToDEVCMS)
            {
               _loc2_.host = BlackBox.productionServer;
            }
            else
            {
               _loc2_.host = BlackBox.internalServer;
            }
         }
         else if(_loc2_.host == BlackBox.developerServer)
         {
            _loc2_.host = BlackBox.productionServer;
         }
         else if(Strings.endsWith(_loc2_.host,"." + BlackBox.developerServer))
         {
            _loc2_.host = BlackBox.productionServer;
         }
         else if(!isAllowed())
         {
            _loc2_.path = "/gateway.php";
         }
         return _loc2_;
      }
      
      private function onConfigLoaded(param1:Event) : void
      {
         var _loc2_:String = param1.target.data as String;
         if(_hasHTML(_loc2_))
         {
            _run();
            return;
         }
         var _loc3_:* = eden.deserialize(_loc2_);
         eden.prettyPrinting = true;
         module.config.load(_loc3_);
         _run();
      }
      
      private function onConfigError(param1:IOErrorEvent) : void
      {
         _run();
      }
      
      hack function set rawurl(param1:String) : void
      {
         _updateURL(param1);
      }
      
      hack function set rawstage(param1:Stage) : void
      {
         _stage = param1;
         if(param1)
         {
            _info = param1.loaderInfo;
         }
         else
         {
            _info = null;
         }
      }
      
      hack function set rawparameters(param1:Object) : void
      {
         if(param1 != null)
         {
            _buildVariables(param1);
         }
      }
      
      hack function get configFileFullPath() : String
      {
         return _getConfigFileFullPath();
      }
      
      public function get ready() : Boolean
      {
         return _ready;
      }
      
      public function get name() : String
      {
         return _module.name;
      }
      
      public function get developerName() : String
      {
         return _developerName;
      }
      
      public function get parent() : BlackBox
      {
         return _parent;
      }
      
      public function get childs() : Object
      {
         return _childs;
      }
      
      public function get childCount() : uint
      {
         var _loc2_:String = null;
         var _loc1_:uint = 0;
         for(_loc2_ in _childs)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function get module() : Module
      {
         return _module;
      }
      
      public function get moduleURL() : String
      {
         if(module.config.allowModuleURLInheritance)
         {
            _moduleURL = _url;
         }
         if(!_moduleURL || _usedAlternate && _usedAlternate != module.config.useAlternate)
         {
            _moduleURL = _buildModuleURL(_url.toString());
            _usedAlternate = module.config.useAlternate;
         }
         return _moduleURL.toString();
      }
      
      public function get modulePath() : String
      {
         return _getModulePath(url.path);
      }
      
      public function get moduleFile() : String
      {
         return _findFile();
      }
      
      public function get gatewayURL() : String
      {
         if(!_gatewayURL)
         {
            _gatewayURL = _buildGatewayURL(_url.toString());
         }
         return _gatewayURL.toString();
      }
      
      public function get url() : uri
      {
         return _url;
      }
      
      public function get info() : LoaderInfo
      {
         if(isRoot())
         {
            return _info;
         }
         return parent.info;
      }
      
      public function get localinfo() : LoaderInfo
      {
         if(isRoot())
         {
            return _info;
         }
         return _localinfo;
      }
      
      public function set localinfo(param1:LoaderInfo) : void
      {
         _localinfo = param1;
         dispatchEvent(new BlackBoxEvent(BlackBoxEvent.LOCAL_INFO));
      }
      
      public function hasDefinition(param1:String) : Boolean
      {
         if(localinfo)
         {
            return localinfo.applicationDomain.hasDefinition(param1);
         }
         return false;
      }
      
      public function getDefinition(param1:String) : Object
      {
         if(localinfo)
         {
            return localinfo.applicationDomain.getDefinition(param1);
         }
         return null;
      }
      
      public function get stage() : Stage
      {
         if(isRoot())
         {
            return _stage;
         }
         return parent.stage;
      }
      
      public function get variables() : URLVariables
      {
         if(!_variables)
         {
            if(info)
            {
               _buildVariables(info.parameters);
            }
            else
            {
               _buildVariables({});
            }
         }
         return _variables;
      }
      
      public function get localconfig() : Object
      {
         return module.localconfig;
      }
      
      public function get globalconfig() : Object
      {
         if(!_globalconfig)
         {
            if(stage)
            {
               _globalconfig = stage.loaderInfo.applicationDomain.getDefinition(BlackBox.globalconfigSignature);
            }
            else
            {
               _globalconfig = {};
            }
         }
         return _globalconfig;
      }
      
      public function addVariables(param1:*) : void
      {
         var _loc2_:String = null;
         if(param1 != null)
         {
            for(_loc2_ in param1)
            {
               variables[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function hasDomain(param1:String) : Boolean
      {
         if(url.host.indexOf(param1) > -1)
         {
            return true;
         }
         return false;
      }
      
      public function hasChilds() : Boolean
      {
         return childCount > 0;
      }
      
      public function hasChild(param1:*) : Boolean
      {
         if(param1 is String)
         {
            return _hasChildByName(param1);
         }
         if(param1 is BlackBox)
         {
            return _hasChildByReference(param1);
         }
         return false;
      }
      
      public function isRoot() : Boolean
      {
         if(parent === null)
         {
            return true;
         }
         return false;
      }
      
      public function isOwner() : Boolean
      {
         if(Boolean(stage) && Boolean(info))
         {
            if(!stage.quality)
            {
               return false;
            }
            return stage.loaderInfo.url == info.url;
         }
         return false;
      }
      
      public function isLocal() : Boolean
      {
         if(isAIR())
         {
            return true;
         }
         if(_url)
         {
            if(_url.scheme == "file" || _url.host == "localhost" || _url.host == "127.0.0.1")
            {
               return true;
            }
         }
         return false;
      }
      
      public function isImported() : Boolean
      {
         return true;
      }
      
      public function isAllowed() : Boolean
      {
         return hasDomain(BlackBox.reservedDomain);
      }
      
      public function isAIR() : Boolean
      {
         if(Capabilities.playerType == "Desktop")
         {
            return true;
         }
         return false;
      }
      
      public function isAndroid() : Boolean
      {
         if(Capabilities.version.substr(0,3).toUpperCase() == "AND")
         {
            return true;
         }
         return false;
      }
      
      public function isLibrary() : Boolean
      {
         if(!_library)
         {
            if(info)
            {
               _library = stage.loaderInfo.applicationDomain.hasDefinition(BlackBox.librarySignature);
            }
            else
            {
               _library = false;
            }
         }
         return _library;
      }
      
      public function isFlex() : Boolean
      {
         if(!_flex)
         {
            if(info)
            {
               _flex = stage.loaderInfo.applicationDomain.hasDefinition(BlackBox.flexSignature);
            }
            else
            {
               _flex = false;
            }
         }
         return _flex;
      }
      
      public function isSecure() : Boolean
      {
         return false;
      }
      
      public function isDebugFile() : Boolean
      {
         if(isRoot())
         {
            return url.toString().indexOf(module.debugfile) > -1;
         }
         return parent.url.toString().indexOf(parent.module.debugfile) > -1;
      }
      
      public function isKnownFile() : Boolean
      {
         if(isRoot())
         {
            if(url.toString().indexOf(module.file) > -1)
            {
               return true;
            }
            if(url.toString().indexOf(module.debugfile) > -1)
            {
               return true;
            }
            return false;
         }
         if(parent.url.toString().indexOf(parent.module.file) > -1)
         {
            return true;
         }
         if(parent.url.toString().indexOf(parent.module.debugfile) > -1)
         {
            return true;
         }
         return false;
      }
   }
}
