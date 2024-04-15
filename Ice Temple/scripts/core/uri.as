package core
{
   public class uri
   {
       
      
      private var _source:String = "";
      
      private var _scheme:String = "";
      
      private var _host:String = "";
      
      private var _username:String = "";
      
      private var _password:String = "";
      
      private var _port:int = -1;
      
      private var _path:String = "";
      
      private var _query:String = "";
      
      private var _fragment:String = "";
      
      private var _r:RegExp;
      
      public function uri(param1:String)
      {
         _r = /\\/g;
         super();
         _source = param1;
         _parse(param1);
      }
      
      private function _parseUnixAbsoluteFilePath(param1:String) : void
      {
         this.scheme = "file";
         _port = -1;
         _fragment = "";
         _query = "";
         _host = "";
         _path = "";
         if(param1.substr(0,2) == "//")
         {
            while(param1.charAt(0) == "/")
            {
               param1 = param1.substr(1);
            }
            _path = "/" + param1;
         }
         if(!_path)
         {
            _path = param1;
         }
      }
      
      private function _parseWindowsAbsoluteFilePath(param1:String) : void
      {
         if(param1.length > 2 && param1.charAt(2) != "\\" && param1.charAt(2) != "/")
         {
            return;
         }
         this.scheme = "file";
         _port = -1;
         _fragment = "";
         _query = "";
         _host = "";
         _path = "/" + param1.replace(_r,"/");
      }
      
      private function _parseWindowsUNC(param1:String) : void
      {
         this.scheme = "file";
         _port = -1;
         _fragment = "";
         _query = "";
         while(param1.charAt(0) == "\\")
         {
            param1 = param1.substr(1);
         }
         var _loc2_:int = param1.indexOf("\\");
         if(_loc2_ > 0)
         {
            _path = param1.substring(_loc2_);
            _host = param1.substring(0,_loc2_);
         }
         else
         {
            _host = param1;
            _path = "";
         }
         _path = _path.replace(_r,"/");
      }
      
      private function _parse(param1:String) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:Boolean = false;
         var _loc2_:int = param1.indexOf(":");
         if(_loc2_ < 0)
         {
            if(param1.charAt(0) == "/")
            {
               _parseUnixAbsoluteFilePath(param1);
            }
            else if(param1.substr(0,2) == "\\\\")
            {
               _parseWindowsUNC(param1);
            }
            return;
         }
         if(_loc2_ == 1)
         {
            _parseWindowsAbsoluteFilePath(param1);
            return;
         }
         var _loc3_:RegExp = new RegExp("^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)([?]([^#]*))?(#(.*))?",null);
         var _loc4_:Object;
         if(Boolean((_loc4_ = _loc3_.exec(param1))[1]) && Boolean(_loc4_[2]))
         {
            this.scheme = _loc4_[2];
         }
         if(_loc4_[3])
         {
            _loc5_ = String(_loc4_[4]);
            _loc6_ = "";
            if(_loc5_.indexOf("@") > -1)
            {
               _loc7_ = String(_loc5_.split("@")[0]);
               _loc6_ = String(_loc5_.split("@")[1]);
               if(_loc7_.indexOf(":") != -1)
               {
                  _username = _loc7_.split(":")[0];
                  _password = _loc7_.split(":")[1];
               }
               else
               {
                  _username = _loc7_;
               }
            }
            else
            {
               _loc6_ = _loc5_;
            }
            if(_loc6_.indexOf(":") > -1)
            {
               _loc8_ = String(_loc6_.split(":")[1]);
               _loc11_ = true;
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  _loc10_ = _loc8_.charAt(_loc9_);
                  if(!("0" <= _loc10_ && _loc10_ <= "9"))
                  {
                     _loc11_ = false;
                  }
                  _loc9_++;
               }
               if(_loc11_)
               {
                  _loc6_ = String(_loc6_.split(":")[0]);
                  if(Boolean(_loc8_) && _loc8_.length > 0)
                  {
                     this.port = parseInt(_loc8_);
                  }
               }
            }
            this.host = _loc6_;
         }
         if(_loc4_[5])
         {
            this.path = _loc4_[5];
         }
         if(_loc4_[6])
         {
            _query = _loc4_[7];
         }
         if(_loc4_[8])
         {
            _fragment = _loc4_[9];
         }
      }
      
      public function get authority() : String
      {
         var _loc1_:String = "";
         if(userinfo)
         {
            _loc1_ += userinfo + "@";
         }
         _loc1_ += host;
         if(host != "" && port > -1)
         {
            _loc1_ += ":" + port;
         }
         return _loc1_;
      }
      
      public function get fragment() : String
      {
         return _fragment;
      }
      
      public function set fragment(param1:String) : void
      {
         _fragment = param1;
      }
      
      public function get host() : String
      {
         return _host;
      }
      
      public function set host(param1:String) : void
      {
         _host = param1;
      }
      
      public function get path() : String
      {
         return _path;
      }
      
      public function set path(param1:String) : void
      {
         _path = param1;
      }
      
      public function get port() : int
      {
         return _port;
      }
      
      public function set port(param1:int) : void
      {
         _port = param1;
      }
      
      public function get scheme() : String
      {
         return _scheme;
      }
      
      public function set scheme(param1:String) : void
      {
         _scheme = param1;
      }
      
      public function get source() : String
      {
         return _source;
      }
      
      public function get userinfo() : String
      {
         if(!_username)
         {
            return "";
         }
         var _loc1_:String = "";
         _loc1_ += _username;
         return _loc1_ + (":" + _password);
      }
      
      public function get query() : String
      {
         return _query;
      }
      
      public function set query(param1:String) : void
      {
         _query = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:* = "";
         if(scheme)
         {
            _loc1_ += scheme + ":";
         }
         if(authority)
         {
            _loc1_ += "//" + authority;
         }
         if(authority == "" && scheme == "file")
         {
            _loc1_ += "//";
         }
         _loc1_ += path;
         if(query)
         {
            _loc1_ += "?" + query;
         }
         if(fragment)
         {
            _loc1_ += "#" + fragment;
         }
         return _loc1_;
      }
      
      public function valueOf() : String
      {
         return toString();
      }
   }
}
