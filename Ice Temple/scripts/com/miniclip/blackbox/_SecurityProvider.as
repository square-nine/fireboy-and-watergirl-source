package com.miniclip.blackbox
{
   import flash.utils.getDefinitionByName;
   
   internal final class _SecurityProvider
   {
      
      private namespace authorization;
      
      private namespace protection;
       
      
      private var _authorized:Array;
      
      private var _default:String = "********";
      
      private var _empty:String = "";
      
      private var _reservedDomain:String;
      
      private var _localServer:String;
      
      private var _developerServer:String;
      
      private var _internalServer:String;
      
      private var _productionServer:String;
      
      private var _liveServer:String;
      
      private var _CDNServer:String;
      
      private var _salt1:String;
      
      private var _salt2:String;
      
      private var _storageKey:String;
      
      public function _SecurityProvider()
      {
         _authorized = [];
         super();
         _authorized.push("቗⌮㑿䄍቙⌨㑼䅊቗⌭㑻䅓ሚ⌣㑾䅂቗〉㑰䅌ቌ⍯㑐䅏ቕ⌢㑹䅡ቛ⌹");
         _authorized.push("቗⌮㑿䄍቙⌨㑼䅊቗⌭㑻䅓ሚ⌦㑳䅎ቑ⌬㑳䅍ቕ⌦㑷䅑ሚ⌌㑻䅍ቝ⌢㑾䅊ቄ⌒㑦䅌ቆ⌠㑵䅆");
         _authorized.push("቗⌮㑿䄍቙⌨㑼䅊቗⌭㑻䅓ሚ⌦㑳䅎ቑ⌬㑳䅍ቕ⌦㑷䅑ሚ⌲㑷䅑ቂ⌨㑱䅆ቇ⍯㑖䅂ቀ⌠㑂䅑ቛ⌹㑫");
         _reservedDomain = "቙⌨㑼䅊቗⌭㑻䅓ሚ⌢㑽䅎";
         _localServer = "ቘ⌮㑱䅂ቘ〈㑽䅐ቀ";
         _developerServer = "ቐ⌤㑤䅆ቘ⌮㑢䅆ቆ⌲㐼䅎ቝ⌯㑻䅀ቘ⌨㑢䄍቗⌮㑿";
         _internalServer = "ቐ⌤㑤䅀቙⌲㐼䅎ቝ⌯㑻䅀ቘ⌨㑢䄍቗⌮㑿";
         _productionServer = "቗⌬㑡䄍቙⌨㑼䅊቗⌭㑻䅓ሚ⌢㑽䅎";
         _liveServer = "ቃ⌶㑥䄍቙⌨㑼䅊቗⌭㑻䅓ሚ⌢㑽䅎";
         _CDNServer = "ቑ⍯㑿䅊ቚ⌨㑱䅏ቝ⌱㐼䅀ቛ⌬";
         _salt1 = "ቹ⍰㑼䄒";
         _salt2 = "ቷ⌭㐣䅓";
         _storageKey = "ሄ⌹㑓䄖ህ⌂";
      }
      
      public function getAuthorization(param1:*) : Namespace
      {
         var name:String = null;
         var authorized:Class = null;
         var instance:* = param1;
         for each(name in _authorized)
         {
            try
            {
               authorized = getDefinitionByName(RXOR(name)) as Class;
            }
            catch(e:Error)
            {
               return protection;
            }
            if(instance is authorized)
            {
               return authorization;
            }
         }
         return protection;
      }
      
      internal function get reservedDomain() : String
      {
         return RXOR(_reservedDomain);
      }
      
      internal function get localServer() : String
      {
         return RXOR(_localServer);
      }
      
      internal function get developerServer() : String
      {
         return RXOR(_developerServer);
      }
      
      internal function get internalServer() : String
      {
         return RXOR(_internalServer);
      }
      
      internal function get productionServer() : String
      {
         return RXOR(_productionServer);
      }
      
      internal function get liveServer() : String
      {
         return RXOR(_liveServer);
      }
      
      internal function get CDNServer() : String
      {
         return RXOR(_CDNServer);
      }
      
      internal function get salt1() : String
      {
         return RXOR(_salt1);
      }
      
      internal function get salt2() : String
      {
         return RXOR(_salt2);
      }
      
      internal function get storageKey() : uint
      {
         return parseInt(RXOR(_storageKey));
      }
      
      internal function get reservedDomain() : String
      {
         return _default;
      }
      
      public function get reservedDomain() : String
      {
         return _empty;
      }
      
      internal function get localServer() : String
      {
         return _default;
      }
      
      public function get localServer() : String
      {
         return _empty;
      }
      
      internal function get developerServer() : String
      {
         return _default;
      }
      
      public function get developerServer() : String
      {
         return _empty;
      }
      
      internal function get internalServer() : String
      {
         return _default;
      }
      
      public function get internalServer() : String
      {
         return _empty;
      }
      
      internal function get productionServer() : String
      {
         return _default;
      }
      
      public function get productionServer() : String
      {
         return _empty;
      }
      
      internal function get liveServer() : String
      {
         return _default;
      }
      
      public function get liveServer() : String
      {
         return _empty;
      }
      
      internal function get CDNServer() : String
      {
         return _default;
      }
      
      public function get CDNServer() : String
      {
         return _empty;
      }
      
      internal function get salt1() : String
      {
         return _default;
      }
      
      public function get salt1() : String
      {
         return _empty;
      }
      
      internal function get salt2() : String
      {
         return _default;
      }
      
      public function get salt2() : String
      {
         return _empty;
      }
      
      internal function get storageKey() : String
      {
         return _default;
      }
      
      public function get storageKey() : String
      {
         return _empty;
      }
   }
}
