package com.miniclip.blackbox
{
   import system.Configurator;
   
   public class ModuleConfigurator extends Configurator
   {
       
      
      public function ModuleConfigurator(param1:Object)
      {
         super(param1);
      }
      
      public function get name() : String
      {
         return _config.name;
      }
      
      public function set name(param1:String) : void
      {
         _config.name = param1;
      }
      
      public function get description() : String
      {
         return _config.description;
      }
      
      public function set description(param1:String) : void
      {
         _config.description = param1;
      }
      
      public function get file() : String
      {
         return _config.file;
      }
      
      public function set file(param1:String) : void
      {
         _config.file = param1;
      }
      
      public function get path() : String
      {
         return _config.path;
      }
      
      public function set path(param1:String) : void
      {
         _config.path = param1;
      }
      
      public function get config() : Object
      {
         return _config.config;
      }
      
      public function set config(param1:Object) : void
      {
         _config.config = param1;
      }
      
      public function get alternatefile() : String
      {
         return _config.alternatefile;
      }
      
      public function set alternatefile(param1:String) : void
      {
         _config.alternatefile = param1;
      }
      
      public function get debugfile() : String
      {
         return _config.debugfile;
      }
      
      public function set debugfile(param1:String) : void
      {
         _config.debugfile = param1;
      }
      
      public function get configfile() : String
      {
         return _config.configfile;
      }
      
      public function set configfile(param1:String) : void
      {
         _config.configfile = param1;
      }
      
      public function get gatewaypath() : String
      {
         return _config.gatewaypath;
      }
      
      public function set gatewaypath(param1:String) : void
      {
         _config.gatewaypath = param1;
      }
      
      public function get allowParametersInheritance() : Boolean
      {
         return _config.allowParametersInheritance;
      }
      
      public function set allowParametersInheritance(param1:Boolean) : void
      {
         _config.allowParametersInheritance = param1;
      }
      
      public function get allowModuleURLInheritance() : Boolean
      {
         return _config.allowModuleURLInheritance;
      }
      
      public function set allowModuleURLInheritance(param1:Boolean) : void
      {
         _config.allowModuleURLInheritance = param1;
      }
      
      public function get allowLocal() : Boolean
      {
         return _config.allowLocal;
      }
      
      public function set allowLocal(param1:Boolean) : void
      {
         _config.allowLocal = param1;
      }
      
      public function get allowFileProtocol() : Boolean
      {
         return _config.allowFileProtocol;
      }
      
      public function set allowFileProtocol(param1:Boolean) : void
      {
         _config.allowFileProtocol = param1;
      }
      
      public function get allowParentPath() : Boolean
      {
         return _config.allowParentPath;
      }
      
      public function set allowParentPath(param1:Boolean) : void
      {
         _config.allowParentPath = param1;
      }
      
      public function get forceSecureConnection() : Boolean
      {
         return _config.forceSecureConnection;
      }
      
      public function set forceSecureConnection(param1:Boolean) : void
      {
         _config.forceSecureConnection = param1;
      }
      
      public function get forceNonSecureConnection() : Boolean
      {
         return _config.forceNonSecureConnection;
      }
      
      public function set forceNonSecureConnection(param1:Boolean) : void
      {
         _config.forceNonSecureConnection = param1;
      }
      
      public function get blockLocalConfig() : Boolean
      {
         return _config.blockLocalConfig;
      }
      
      public function set blockLocalConfig(param1:Boolean) : void
      {
         _config.blockLocalConfig = param1;
      }
      
      public function get useLiveServices() : Boolean
      {
         return _config.useLiveServices;
      }
      
      public function set useLiveServices(param1:Boolean) : void
      {
         _config.useLiveServices = param1;
         _config.useBetaServices = !param1;
      }
      
      public function get useBetaServices() : Boolean
      {
         return _config.useBetaServices;
      }
      
      public function set useBetaServices(param1:Boolean) : void
      {
         _config.useBetaServices = param1;
         _config.useLiveServices = !param1;
      }
      
      public function get useAlternate() : Boolean
      {
         return _config.useAlternate;
      }
      
      public function set useAlternate(param1:Boolean) : void
      {
         _config.useAlternate = param1;
      }
   }
}
