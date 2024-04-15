package com.miniclip.blackbox
{
   public class Module
   {
      
      public static const DEFAULT_NAME:String = "Unknown";
      
      public static const DEFAULT_DESCRIPTION:String = "";
      
      public static const DEFAULT_FILE:String = "*.swf";
      
      public static const DEFAULT:String = "";
       
      
      private var _config:ModuleConfigurator;
      
      public function Module(param1:ModuleConfigurator)
      {
         super();
         if(param1 === null)
         {
            throw new ArgumentError("config can not be null");
         }
         _config = param1;
      }
      
      public function get config() : ModuleConfigurator
      {
         return _config;
      }
      
      public function get localconfig() : Object
      {
         if(!_config.config)
         {
            _config.config = {};
         }
         return _config.config;
      }
      
      public function get name() : String
      {
         if(_config.name)
         {
            return _config.name;
         }
         return DEFAULT_NAME;
      }
      
      public function get description() : String
      {
         if(_config.description)
         {
            return _config.description;
         }
         return DEFAULT_DESCRIPTION;
      }
      
      public function get file() : String
      {
         if(_config.file)
         {
            return _config.file;
         }
         return DEFAULT_FILE;
      }
      
      public function get path() : String
      {
         if(_config.path)
         {
            return _config.path;
         }
         return DEFAULT;
      }
      
      public function get alternatefile() : String
      {
         if(_config.alternatefile)
         {
            return _config.alternatefile;
         }
         return DEFAULT;
      }
      
      public function get debugfile() : String
      {
         if(_config.debugfile)
         {
            return _config.debugfile;
         }
         return DEFAULT;
      }
      
      public function get configfile() : String
      {
         if(_config.configfile)
         {
            return _config.configfile;
         }
         return DEFAULT;
      }
      
      public function get gatewaypath() : String
      {
         if(_config.gatewaypath)
         {
            return _config.gatewaypath;
         }
         return DEFAULT;
      }
      
      public function toString() : String
      {
         var _loc1_:* = "";
         _loc1_ += "[";
         _loc1_ += name;
         _loc1_ += " path:";
         if(path != "")
         {
            _loc1_ += path;
         }
         _loc1_ += file;
         _loc1_ += "]";
         if(Boolean(description) && description != "")
         {
            _loc1_ += " (";
            _loc1_ += description;
            _loc1_ += ")";
         }
         return _loc1_;
      }
   }
}
