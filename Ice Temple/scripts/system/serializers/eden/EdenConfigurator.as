package system.serializers.eden
{
   import system.Configurator;
   import system.eden;
   
   public class EdenConfigurator extends Configurator
   {
       
      
      public function EdenConfigurator(param1:Object)
      {
         super(param1);
      }
      
      public function get allowFunctionCall() : Boolean
      {
         return _config.allowFunctionCall;
      }
      
      public function set allowFunctionCall(param1:Boolean) : void
      {
         _config.allowFunctionCall = param1;
      }
      
      public function get arrayIndexAsBracket() : Boolean
      {
         return _config.arrayIndexAsBracket;
      }
      
      public function set arrayIndexAsBracket(param1:Boolean) : void
      {
         _config.arrayIndexAsBracket = param1;
      }
      
      public function get authorized() : Array
      {
         return _config.authorized;
      }
      
      public function set authorized(param1:Array) : void
      {
         _config.authorized = param1;
      }
      
      public function get autoAddScopePath() : Boolean
      {
         return _config.autoAddScopePath;
      }
      
      public function set autoAddScopePath(param1:Boolean) : void
      {
         _config.autoAddScopePath = param1;
      }
      
      public function get compress() : Boolean
      {
         return _config.compress;
      }
      
      public function set compress(param1:Boolean) : void
      {
         _config.compress = param1;
         eden.prettyPrinting = param1;
      }
      
      public function get copyObjectByValue() : Boolean
      {
         return _config.copyObjectByValue;
      }
      
      public function set copyObjectByValue(param1:Boolean) : void
      {
         _config.copyObjectByValue = param1;
      }
      
      public function get strictMode() : Boolean
      {
         return _config.strictMode;
      }
      
      public function set strictMode(param1:Boolean) : void
      {
         _config.strictMode = param1;
      }
      
      public function get undefineable() : *
      {
         return _config.undefineable;
      }
      
      public function set undefineable(param1:*) : void
      {
         _config.undefineable = param1;
      }
      
      public function get verbose() : Boolean
      {
         return _config.verbose;
      }
      
      public function set verbose(param1:Boolean) : void
      {
         _config.verbose = param1;
      }
      
      public function get security() : Boolean
      {
         return _config.security;
      }
      
      public function set security(param1:Boolean) : void
      {
         _config.security = param1;
      }
      
      public function addAuthorized(... rest) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = _config.authorized as Array;
         if(_loc2_ != null)
         {
            _loc3_ = int(rest.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(!_loc2_.indexOf(rest[_loc4_]) > -1)
               {
                  _loc2_.push(rest[_loc4_]);
               }
               _loc4_++;
            }
            return;
         }
         throw new Error(this + " addAuthorized failed with a null \'authorized\' Array to configurate the eden parser.");
      }
      
      public function removeAuthorized(... rest) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         _loc2_ = [].concat(rest);
         var _loc5_:int = int(_loc2_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if((_loc4_ = _config.authorized.indexOf(_loc2_[_loc3_])) > -1)
            {
               _config.authorized.splice(_loc4_,1);
            }
            _loc3_++;
         }
      }
   }
}
