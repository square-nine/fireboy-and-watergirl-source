package com.miniclip.gamemanager
{
   import com.miniclip.blackbox.BlackBox;
   import com.miniclip.events.BlackBoxEvent;
   import com.miniclip.hack;
   import core.uri;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   
   use namespace hack;
   
   public class GameInfo extends EventDispatcher
   {
       
      
      private var _blackbox:BlackBox;
      
      private var _complete:Boolean;
      
      private var _preload:*;
      
      private var _name:String;
      
      private var _id:uint;
      
      private var _SWFversion:uint;
      
      private var _ASversion:uint;
      
      private var _raw:uri;
      
      private var _iconfilename:uri;
      
      private var _bigiconfilename:uri;
      
      public var filename:String;
      
      public var iconfilename:String;
      
      public var bigiconfilename:String;
      
      public var quality:String;
      
      public function GameInfo(param1:BlackBox, param2:String = "", param3:uint = 0, param4:String = "", param5:String = "", param6:String = "", param7:String = "")
      {
         super();
         _blackbox = param1;
         _complete = false;
         this.name = param2;
         this.id = param3;
         this.filename = param4;
         this.iconfilename = param5;
         this.bigiconfilename = param6;
         if(param7 == "")
         {
            param7 = StageQuality.HIGH;
         }
         this.quality = param7;
         if(_blackbox.ready)
         {
            onReady();
         }
         else
         {
            _blackbox.addEventListener(BlackBoxEvent.READY,onReady);
         }
      }
      
      private function onReady(param1:BlackBoxEvent = null) : void
      {
         _blackbox.removeEventListener(BlackBoxEvent.READY,onReady);
         _updateInfoFromParameters();
         _updateInfoFromConfig();
         dispatchEvent(new Event(Event.COMPLETE));
         _complete = true;
      }
      
      private function _getIconURL(param1:String) : uri
      {
         var _loc2_:uri = new uri(this.url.toString());
         if(_blackbox.isLocal() || _loc2_.host == BlackBox.developerServer)
         {
            _loc2_.path = _blackbox.modulePath + this[param1];
         }
         else if(_blackbox.isAllowed())
         {
            if(_blackbox.module.path != "")
            {
               _loc2_.path = _blackbox.module.path + this[param1];
            }
            else
            {
               _loc2_.path = "/" + this[param1];
            }
         }
         else
         {
            _loc2_.path = "/" + this[param1];
         }
         return _loc2_;
      }
      
      private function _verifyFilename() : void
      {
         if(filename.substr(0,7) == "http://" || filename.substr(0,8) == "https://" || filename.substr(0,6) == "ftp://")
         {
            filename = "";
         }
      }
      
      private function _verifyPreload() : void
      {
         if(_preload && isNaN(_preload))
         {
            _blackbox.globalconfig.preloadEntireGame = true;
         }
         else
         {
            _blackbox.globalconfig.preloadEntireGame = false;
            _blackbox.globalconfig.howManyBytesToPreload = Number(_preload);
         }
      }
      
      private function _updateFrom(param1:Object, param2:String = "params") : void
      {
         var _loc3_:Object = {
            "params":["fn","mc_gamename","mc_hsname","mc_icon","mc_iconBig"],
            "names":["filename","name","id","iconfilename","bigiconfilename"]
         };
         var _loc4_:Object;
         if((_loc4_ = {
            "filename":param1[_loc3_[param2][0]],
            "name":param1[_loc3_[param2][1]],
            "id":param1[_loc3_[param2][2]],
            "icon":param1[_loc3_[param2][3]],
            "bigicon":param1[_loc3_[param2][4]]
         }).filename)
         {
            filename = _loc4_.filename;
            _verifyFilename();
            if(_loc4_.name)
            {
               name = _loc4_.name;
            }
            if(_loc4_.id)
            {
               id = parseInt(_loc4_.id);
            }
            if(_loc4_.icon)
            {
               iconfilename = _loc4_.icon;
            }
            if(_loc4_.bigicon)
            {
               bigiconfilename = _loc4_.bigicon;
            }
            if(param1.preload)
            {
               _preload = param1.preload;
               _verifyPreload();
            }
         }
      }
      
      private function _updateInfoFromConfig() : void
      {
         if(_blackbox.module.config.blockLocalConfig)
         {
            return;
         }
         var _loc1_:Object = _blackbox.module.localconfig;
         _updateFrom(_loc1_,"params");
         _updateFrom(_loc1_,"names");
      }
      
      private function _updateInfoFromParameters() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         if(variables.cfg)
         {
            _loc1_ = String(variables.cfg);
            if(_loc1_.indexOf(",") > -1)
            {
               _loc2_ = _loc1_.split(",");
            }
            else
            {
               _loc2_ = [_loc1_];
            }
            if(_loc2_.indexOf("menu") > -1)
            {
               _blackbox.globalconfig.showInitialMenu = true;
            }
            if(_loc2_.indexOf("no_hsb") > -1)
            {
               _blackbox.globalconfig.showHighScoresBox = false;
            }
         }
         _updateFrom(variables,"params");
      }
      
      private function _cleanSpaces(param1:String) : String
      {
         param1 = param1.split("%20").join(" ");
         return param1.split("+").join(" ");
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = _cleanSpaces(param1);
      }
      
      public function get id() : uint
      {
         if(_blackbox.isLocal())
         {
            return 1808;
         }
         return _id;
      }
      
      public function set id(param1:uint) : void
      {
         _id = param1;
      }
      
      public function get complete() : Boolean
      {
         return _complete;
      }
      
      public function get url() : uri
      {
         var _loc1_:String = null;
         var _loc2_:uri = null;
         if(!_raw)
         {
            if(_blackbox.isLibrary())
            {
               _loc1_ = BlackBox.current.moduleURL;
            }
            else
            {
               _loc1_ = _blackbox.moduleURL;
            }
            _loc2_ = new uri(_loc1_);
            _loc2_.query = "";
            _loc2_.fragment = "";
            _raw = _loc2_;
         }
         return _raw;
      }
      
      public function get SWFversion() : uint
      {
         return _SWFversion;
      }
      
      hack function set SWFversion(param1:uint) : void
      {
         _SWFversion = param1;
      }
      
      public function get ASversion() : uint
      {
         return _ASversion;
      }
      
      hack function set ASversion(param1:uint) : void
      {
         _ASversion = param1;
      }
      
      public function get iconURL() : uri
      {
         if(!_iconfilename)
         {
            _iconfilename = _getIconURL("iconfilename");
         }
         return _iconfilename;
      }
      
      public function get bigIconURL() : uri
      {
         if(!_bigiconfilename)
         {
            _bigiconfilename = _getIconURL("bigiconfilename");
         }
         return _bigiconfilename;
      }
      
      public function get gameURL() : uri
      {
         var _loc1_:uri = new uri(this.url.toString());
         _loc1_.query = "";
         _loc1_.fragment = "";
         if(_blackbox.isLocal() || _loc1_.host == BlackBox.developerServer)
         {
            _loc1_.path = _blackbox.modulePath + filename;
         }
         else if(_blackbox.isAllowed())
         {
            if(_blackbox.globalconfig.allowContentDeliveryNetwork)
            {
               _loc1_.host = BlackBox.CDNServer;
            }
            _loc1_.path = _blackbox.modulePath + filename;
         }
         else
         {
            _loc1_.path = "/" + filename;
         }
         return _loc1_;
      }
      
      public function get variables() : URLVariables
      {
         return _blackbox.variables;
      }
      
      public function getVariablesStartingWith(param1:String) : URLVariables
      {
         var _loc4_:String = null;
         var _loc2_:URLVariables = new URLVariables();
         var _loc3_:uint = uint(param1.length);
         for(_loc4_ in variables)
         {
            if(_loc4_.substr(0,_loc3_) == param1)
            {
               _loc2_[_loc4_] = variables[_loc4_];
            }
         }
         return _loc2_;
      }
      
      override public function toString() : String
      {
         var _loc1_:* = "";
         _loc1_ += "[GameInfo";
         _loc1_ += " name=" + name;
         _loc1_ += " id=" + id;
         _loc1_ += " filename=" + filename;
         _loc1_ += " iconfilename=" + iconfilename;
         _loc1_ += " bigiconfilename=" + bigiconfilename;
         _loc1_ += " quality=" + quality;
         _loc1_ += "\rurl=" + url;
         _loc1_ += "\riconURL=" + iconURL;
         _loc1_ += "\rbigIconURL=" + bigIconURL;
         _loc1_ += "\rgameURL=" + gameURL;
         return _loc1_ + " ]";
      }
   }
}
