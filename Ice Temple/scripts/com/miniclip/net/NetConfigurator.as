package com.miniclip.net
{
   import system.Configurator;
   
   public class NetConfigurator extends Configurator
   {
       
      
      public function NetConfigurator(param1:Object)
      {
         super(param1);
      }
      
      public function get AMFVerbose() : Boolean
      {
         return _config.AMFVerbose;
      }
      
      public function set AMFVerbose(param1:Boolean) : void
      {
         _config.AMFVerbose = param1;
      }
      
      public function get AMFEncoding() : uint
      {
         return _config.AMFEncoding;
      }
      
      public function set AMFEncoding(param1:uint) : void
      {
         _config.AMFEncoding = param1;
      }
      
      public function get AMFDefaultGateway() : String
      {
         return _config.AMFDefaultGateway;
      }
      
      public function set AMFDefaultGateway(param1:String) : void
      {
         _config.AMFDefaultGateway = param1;
      }
      
      public function get AMFDefaultServiceName() : String
      {
         return _config.AMFDefaultServiceName;
      }
      
      public function set AMFDefaultServiceName(param1:String) : void
      {
         _config.AMFDefaultServiceName = param1;
      }
      
      public function get AMFDefaultTimeout() : uint
      {
         return _config.AMFDefaultTimeout;
      }
      
      public function set AMFDefaultTimeout(param1:uint) : void
      {
         _config.AMFDefaultTimeout = param1;
      }
      
      public function get AuthSOName() : String
      {
         return _config.AuthSOName;
      }
      
      public function set AuthSOName(param1:String) : void
      {
         _config.AuthSOName = param1;
      }
   }
}
